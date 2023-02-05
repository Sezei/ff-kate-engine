# Note that this might take a while since I'm a bit rusty with Python


# All of our cool imports
import tkinter
import customtkinter as converter

class App(converter.CTk):
    def __init__(self):
        # Our constructor
        super().__init__()

        
        converter.set_appearance_mode('Dark')
        converter.set_default_color_theme('dark-blue')

        self.geometry("1000x750")
        self.title("Convert FNF Charts to FF!")

        def button_function():
            print("Test!")

        # Use CTkButton instead of tkinter Button
        button = converter.CTkButton(master=self, text="Silly little thing", command=button_function)
        button.place(relx=0.5, rely=0.5, anchor=tkinter.CENTER)



if __name__ == "__main__":
    app = App()
    app.mainloop()