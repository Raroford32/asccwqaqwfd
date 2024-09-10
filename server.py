import subprocess

def run_webui():
    try:
        # Run the oobabooga web UI
        subprocess.run([
            "python3", "server.py", 
            "--listen", "--listen-port", "7860"
        ], check=True)
    except subprocess.CalledProcessError as e:
        print(f"Error running server: {e}")

if __name__ == "__main__":
    print("Starting the oobabooga Text Generation Web UI...")
    run_webui()
