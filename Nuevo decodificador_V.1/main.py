import tkinter as tk
from tkinter import filedialog, messagebox
import ttkbootstrap as ttk
from ttkbootstrap.constants import *

# Configuración de funct (6 bits) - Ahora define la operación
FUNCT_CODES = {
    "ADD": "100000",  # 0x20
    "SUB": "100010",  # 0x22
    "SLT": "101010",  # 0x2A
    "AND": "100100",
    "NOT": "000000"
}

def register_to_bin(reg_str, bits=5):
    """Convierte $n a binario de 'bits' longitud."""
    reg_num = int(reg_str.strip('$'))
    if reg_num < 0:
        raise ValueError("¡Registro no puede ser negativo!")
    return f"{reg_num:0{bits}b}"

def parse_instruction(line):
    """Convierte una línea ASM a 4 líneas de 8 bits para tipo-R."""
    parts = line.split()
    if len(parts) != 4:
        raise ValueError(f"Formato incorrecto: {line}. Ejemplo: ADD $4 $0 $1")
    
    mnemonic = parts[0]
    funct = FUNCT_CODES.get(mnemonic)
    if not funct:
        raise ValueError(f"Mnemónico no válido: {mnemonic}")

    # Campos para tipo-R (opcode siempre 000000)
    opcode = "000000"
    rs = register_to_bin(parts[2])   # Fuente 1
    rt = register_to_bin(parts[3])   # Fuente 2
    rd = register_to_bin(parts[1])   # Destino
    shut = "00000"                   # No usado
    full_binary = f"{opcode}{rs}{rt}{rd}{shut}{funct}"
    
    # Divide en 4 líneas de 8 bits
    return [
        full_binary[0:8],    # Bits 0-7
        full_binary[8:16],    # Bits 8-15
        full_binary[16:24],   # Bits 16-23
        full_binary[24:32]    # Bits 24-31
    ]

class ASMConverterApp:
    def __init__(self, root):
        self.root = root
        self.root.title("Decodificador MIPS Tipo-R - Equipo Tr3s")
        self.root.geometry("800x600")
        
        # Tema oscuro
        self.style = ttk.Style(theme="darkly")
        
        # Frame principal
        self.main_frame = ttk.Frame(root)
        self.main_frame.pack(pady=20, padx=20, fill=tk.BOTH, expand=True)
        
        # Sección de carga
        self.file_frame = ttk.LabelFrame(
            self.main_frame, 
            text=" Cargar Archivo .asm ",
            bootstyle="info"
        )
        self.file_frame.pack(fill=tk.X, pady=10)
        
        self.file_path = tk.StringVar()
        self.entry_file = ttk.Entry(
            self.file_frame, 
            textvariable=self.file_path, 
            width=60,
            bootstyle="dark"
        )
        self.entry_file.pack(side=tk.LEFT, padx=5, pady=5)
        
        ttk.Button(
            self.file_frame, 
            text="Buscar", 
            command=self.browse_file,
            bootstyle="info-outline"
        ).pack(side=tk.LEFT, padx=5)
        
        ttk.Button(
            self.file_frame, 
            text="Abrir", 
            command=self.load_file,
            bootstyle="info"
        ).pack(side=tk.LEFT, padx=5)
        
        # Vista previa
        self.preview_frame = ttk.LabelFrame(
            self.main_frame, 
            text=" Vista Previa ",
            bootstyle="info"
        )
        self.preview_frame.pack(fill=tk.BOTH, expand=True, pady=10)
        
        self.preview_text = tk.Text(
            self.preview_frame, 
            height=15,
            bg="#2E2E2E",
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
            bootstyle="success",
            width=20
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
                    output_lines.extend(parse_instruction(line))
            
            with open("Instrucciones.txt", 'w') as f:
                f.write("\n".join(output_lines))
            messagebox.showinfo("Éxito", "Archivo 'Instrucciones.txt' generado correctamente.")
        except Exception as e:
            messagebox.showerror("Error", f"Error al decodificar:\n{e}")

if __name__ == "__main__":
    root = ttk.Window(themename="darkly")
    app = ASMConverterApp(root)
    root.mainloop()
