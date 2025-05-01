import tkinter as tk
from tkinter import filedialog, messagebox, ttk

# ==================== CONFIGURACIÓN DE INSTRUCCIONES ====================
R_TYPE = {
    "ADD": {"opcode": "000000", "funct": "100000", "format": "RD, RS, RT"},
    "SUB": {"opcode": "000000", "funct": "100010", "format": "RD, RS, RT"},
    "SLT": {"opcode": "000000", "funct": "101010", "format": "RD, RS, RT"},
    "AND": {"opcode": "000000", "funct": "100100", "format": "RD, RS, RT"},
    "OR": {"opcode": "000000", "funct": "100101", "format": "RD, RS, RT"},
    "NOP": {"opcode": "000000", "funct": "000000", "format": ""}
}

I_TYPE = {
    "ADDI": {"opcode": "001000", "format": "RT, RS, #inmediato"},
    "SW": {"opcode": "101011", "format": "RT, RS, #inmediato"},  
    "LW": {"opcode": "100011", "format": "RT, RS, #inmediato"} 
}

def register_to_bin(reg_str, bits=5):
    """Convierte $n a binario."""
    reg_num = int(reg_str.strip('$').replace(',', ''))
    return f"{reg_num:0{bits}b}"

def parse_instruction(line):
    """Convierte una línea ASM a 4 líneas de 8 bits."""
    parts = [p.strip() for p in line.split() if p.strip()]
    if not parts:
        return None

    mnemonic = parts[0].upper()
    
    # NOP
    if mnemonic == "NOP":
        return ["00000000"] * 4

    # Tipo-R (Ej: AND $1, $2, $3)
    if mnemonic in R_TYPE:
        if len(parts) != 4:
            raise ValueError(f"Formato incorrecto. Uso: {mnemonic} {R_TYPE[mnemonic]['format']}")
        opcode = R_TYPE[mnemonic]["opcode"]
        rd = register_to_bin(parts[1])
        rs = register_to_bin(parts[2])
        rt = register_to_bin(parts[3])
        shamt = "00000"
        funct = R_TYPE[mnemonic]["funct"]
        full_binary = f"{opcode}{rs}{rt}{rd}{shamt}{funct}"

    elif mnemonic in I_TYPE:
        if len(parts) != 4:
            raise ValueError(f"Formato incorrecto. Uso: {mnemonic} $rt, $rs, #inmediato")
        
        # Extraer partes
        rt = parts[1].replace(',', '')
        rs = parts[2].replace(',', '')
        inmediato = parts[3].replace('#', '')
        
        # Validar
        if not rt.startswith('$') or not rs.startswith('$'):
            raise ValueError("Los operandos deben ser registros (ej: $1)")
        
        # Convertir a binario
        opcode = I_TYPE[mnemonic]["opcode"]
        rt_bin = register_to_bin(rt)
        rs_bin = register_to_bin(rs)
        inmediato_bin = f"{int(inmediato):016b}"  # 16 bits
        full_binary = f"{opcode}{rs_bin}{rt_bin}{inmediato_bin}"

    else:
        raise ValueError(f"Instrucción no soportada: {mnemonic}")

    return [full_binary[i*8:(i+1)*8] for i in range(4)]

# ==================== GUI OSCURA ====================
class ASMConverterApp:
    def __init__(self, root):
        self.root = root
        self.root.title("Decodificador MIPS - Equipo Tr3s")
        self.root.geometry("800x600")
        self.root.configure(bg="#121212")  # Fondo más oscuro
        
        # Configurar estilo
        self.style = ttk.Style()
        self.style.theme_use('clam')
        self.style.configure('.', background="#121212", foreground="white")
        self.style.configure('TFrame', background="#121212")
        self.style.configure('TLabelFrame', background="#1E1E1E", foreground="white")
        self.style.configure('TButton', background="#333333", foreground="white", bordercolor="#444444")
        self.style.map('TButton', background=[('active', '#444444')])
        
        # Frame principal
        self.main_frame = ttk.Frame(root)
        self.main_frame.pack(pady=20, padx=20, fill=tk.BOTH, expand=True)
        
        # Sección de carga de archivo
        self.file_frame = ttk.LabelFrame(self.main_frame, text=" Cargar Archivo.asm ", padding=10)
        self.file_frame.pack(fill=tk.X, pady=10)
        
        self.file_path = tk.StringVar()
        self.entry_file = tk.Entry(self.file_frame, textvariable=self.file_path, width=60,
                           bg="#252525", fg="white", insertbackground="white", relief=tk.FLAT)
        self.entry_file.pack(side=tk.LEFT, padx=5)
        
        ttk.Button(self.file_frame, text="Buscar", command=self.browse_file).pack(side=tk.LEFT, padx=5)
        ttk.Button(self.file_frame, text="Abrir", command=self.load_file).pack(side=tk.LEFT, padx=5)
        
        # Vista previa
        self.preview_frame = ttk.LabelFrame(self.main_frame, text=" Vista Previa ", padding=10)
        self.preview_frame.pack(fill=tk.BOTH, expand=True, pady=10)
        
        self.preview_text = tk.Text(
            self.preview_frame,
            height=15,
            bg="#252525",
            fg="white",
            insertbackground="white",
            font=("Consolas", 10)
        )
        self.preview_text.pack(fill=tk.BOTH, expand=True, padx=5, pady=5)
        
        # Botón de decodificación
        ttk.Button(
            self.main_frame,
            text="Decodificar",
            command=self.decode_file,
            style="TButton"
        ).pack(pady=10)

    def browse_file(self):
        file = filedialog.askopenfilename(filetypes=[("ASM Files", "*.asm")])
        if file:
            self.file_path.set(file)

    def load_file(self):
        file = self.file_path.get()
        if not file.endswith('.asm'):
            messagebox.showerror("Error", "¡El archivo debe ser .asm!")
            return
        try:
            with open(file, 'r') as f:
                self.preview_text.delete(1.0, tk.END)
                self.preview_text.insert(tk.END, f.read())
        except Exception as e:
            messagebox.showerror("Error", f"No se pudo abrir el archivo:\n{e}")

    def decode_file(self):
        asm_content = self.preview_text.get(1.0, tk.END).splitlines()
        output_lines = []
        try:
            for line in asm_content:
                line = line.strip()
                if line and not line.startswith(';'):
                    bin_lines = parse_instruction(line)
                    if bin_lines:
                        output_lines.extend(bin_lines)
            
            # Cambia esta línea para guardar en el escritorio
            import os
            desktop = os.path.join(os.path.expanduser("~"), "Desktop")
            output_path = os.path.join(desktop, "Instrucciones.txt")
            
            with open(output_path, 'w') as f:
                f.write("\n".join(output_lines))
            messagebox.showinfo("Éxito", f"Archivo guardado en:\n{output_path}")
        except Exception as e:
            messagebox.showerror("Error", f"Error al decodificar:\n{e}")

if __name__ == "__main__":
    root = tk.Tk()
    app = ASMConverterApp(root)
    root.mainloop()