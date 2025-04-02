# Equipo Tr3s decodificador asm a txt
import tkinter as tk
from tkinter import filedialog, messagebox

# Configuración de opcodes y formato
OPCODES = {
    "ADD": "000",
    "SUB": "001",
    "SLT": "010",
    "SW": "011",
    "LW": "100"
}

def register_to_bin(reg_str):
    """Convierte $n a binario de 5 bits (ej: $3 → '00011')."""
    reg_num = int(reg_str.strip('$').strip(','))
    return f"{reg_num:05b}"

def parse_instruction(line):
    """Convierte una línea ASM a binario de 18 bits (sin guiones)."""
    parts = line.split()
    opcode = OPCODES.get(parts[0])
    
    if not opcode:
        raise ValueError(f"Opcode no válido: {parts[0]}")
    
    if opcode in ["000", "001", "010"]:
        if len(parts) != 4:
            raise ValueError(f"Formato incorrecto: {line}")
        rd = register_to_bin(parts[1])
        rs1 = register_to_bin(parts[2])
        rs2 = register_to_bin(parts[3])
        return f"{opcode}{rd}{rs1}{rs2}"
    
    elif opcode in ["011", "100"]:
        if len(parts) != 3 or not parts[1].startswith('$') or not parts[2].startswith('$'):
            raise ValueError(f"Formato incorrecto: {line}. Debe ser: OP $direccion, $dato")
        
        direccion = register_to_bin(parts[1].strip(','))  # $dato → 5 bits
        dato_reg = parts[2].strip(',')
        dato_num = int(dato_reg.strip('$'))
        
        dato_bin = f"{dato_num:05b}" 
        return f"{opcode}00000{direccion}{dato_bin}" 

class ASMConverterApp:
    def __init__(self, root):
        self.root = root
        self.root.title("Ensamblador a Binario")
        self.root.geometry("800x600")
        self.root.configure(bg="#333333")
        
        # Frame principal
        self.main_frame = tk.Frame(root, bg="#333333")
        self.main_frame.pack(pady=20, padx=20, fill=tk.BOTH, expand=True)
        
        # Sección de carga de archivo
        self.file_frame = tk.LabelFrame(
            self.main_frame, 
            text="Cargar Archivo.asm", 
            padx=10, 
            pady=10,
            bg="#444444",
            fg="white",
            font=("Arial", 10, "bold")
        )
        self.file_frame.pack(fill=tk.X, pady=10)
        
        self.file_path = tk.StringVar()
        tk.Entry(
            self.file_frame, 
            textvariable=self.file_path, 
            width=50,
            bg="#555555",
            fg="white",
            insertbackground="white"
        ).pack(side=tk.LEFT, padx=5)
        
        tk.Button(
            self.file_frame, 
            text="Buscar", 
            command=self.browse_file,
            bg="#555555",
            fg="white",
            activebackground="#666666",
            activeforeground="white"
        ).pack(side=tk.LEFT, padx=5)
        
        tk.Button(
            self.file_frame, 
            text="Abrir", 
            command=self.load_file,
            bg="#555555",
            fg="white",
            activebackground="#666666",
            activeforeground="white"
        ).pack(side=tk.LEFT, padx=5)
        
        # Vista previa del archivo ASM
        self.preview_frame = tk.LabelFrame(
            self.main_frame, 
            text="Vista Previa", 
            padx=10, 
            pady=10,
            bg="#444444",
            fg="white",
            font=("Arial", 10, "bold")
        )
        self.preview_frame.pack(fill=tk.BOTH, expand=True, pady=10)
        
        self.preview_text = tk.Text(
            self.preview_frame, 
            height=15,
            bg="#555555",
            fg="white",
            insertbackground="white"
        )
        self.preview_text.pack(fill=tk.BOTH, expand=True)
        
        # Botón de decodificación
        tk.Button(
            self.main_frame, 
            text="Decodificar a Binario", 
            command=self.decode_file,
            bg="#555555",
            fg="white",
            activebackground="#666666",
            activeforeground="white",
            pady=5
        ).pack(pady=10)
    
    def browse_file(self):
        """Abre el explorador de archivos para seleccionar .asm."""
        file = filedialog.askopenfilename(filetypes=[("ASM Files", "*.asm")])
        if file:
            self.file_path.set(file)
    
    def load_file(self):
        """Carga el contenido del archivo .asm en la vista previa."""
        file = self.file_path.get()
        if not file.endswith('.asm'):
            messagebox.showerror("Error", "¡El archivo debe ser .asm!")
            return
        
        try:
            with open(file, 'r') as f:
                content = f.read()
                self.preview_text.delete(1.0, tk.END)
                self.preview_text.insert(tk.END, content)
        except Exception as e:
            messagebox.showerror("Error", f"No se pudo abrir el archivo:\n{e}")
    
    def decode_file(self):
        """Convierte el ASM a binario y guarda en dato.txt."""
        asm_content = self.preview_text.get(1.0, tk.END).splitlines()
        output_lines = []
        
        try:
            for line in asm_content:
                line = line.strip()
                if line and not line.startswith(';'):  # Ignora comentarios
                    bin_line = parse_instruction(line)
                    output_lines.append(bin_line)
            
            with open("Instrucciones.txt", 'w') as f:
                f.write("\n".join(output_lines))
            messagebox.showinfo("Éxito", "Archivo 'Instrucciones.txt' generado correctamente.")
        except Exception as e:
            messagebox.showerror("Error", f"Error al decodificar:\n{e}")

if __name__ == "__main__":
    root = tk.Tk()
    app = ASMConverterApp(root)
    root.mainloop()