import subprocess
import os
import html
from selenium import webdriver
from selenium.webdriver.chrome.options import Options

def run_cmd(cmd):
    result = subprocess.run(cmd, shell=True, capture_output=True, text=True, cwd=r"c:\SEMESTER 5\MOBILE PROGRAMMING\tugas 2")
    return result.stdout.strip() if result.stdout else result.stderr.strip()

def create_terminal_html(title, command, output_text, width=820):
    escaped_output = html.escape(output_text)
    # Highlight specific parts if needed or clean text
    html_content = f"""<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<style>
  * {{ box-sizing: border-box; margin: 0; padding: 0; }}
  body {{
    background: transparent;
    padding: 20px;
    font-family: 'Consolas', 'Cascadia Mono', 'Courier New', monospace;
    display: inline-block;
  }}
  .window {{
    width: {width}px;
    background: #0c0c0c;
    border-radius: 8px;
    box-shadow: 0 10px 30px rgba(0,0,0,0.5);
    overflow: hidden;
    border: 1px solid #2d2d2d;
  }}
  .titlebar {{
    background: #1f1f1f;
    padding: 10px 14px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    border-bottom: 1px solid #2a2a2a;
  }}
  .title {{
    color: #cccccc;
    font-size: 13px;
    font-weight: 500;
    font-family: 'Segoe UI', sans-serif;
  }}
  .buttons {{
    display: flex;
    gap: 8px;
  }}
  .btn {{
    width: 12px;
    height: 12px;
    border-radius: 50%;
    display: inline-block;
  }}
  .btn-close {{ background: #ff5f56; }}
  .btn-min {{ background: #ffbd2e; }}
  .btn-max {{ background: #27c93f; }}
  .content {{
    padding: 18px 20px;
    color: #cccccc;
    font-size: 13.5px;
    line-height: 1.5;
    white-space: pre-wrap;
    word-break: break-all;
  }}
  .prompt {{
    color: #4ec9b0;
    font-weight: bold;
  }}
  .cmd {{
    color: #ffffff;
    font-weight: bold;
  }}
  .output {{
    color: #d4d4d4;
    margin-top: 8px;
  }}
  .success {{
    color: #4ec9b0;
  }}
  .highlight {{
    color: #ce9178;
  }}
</style>
</head>
<body>
<div class="window">
  <div class="titlebar">
    <div class="buttons">
      <span class="btn btn-close"></span>
      <span class="btn btn-min"></span>
      <span class="btn btn-max"></span>
    </div>
    <div class="title">{title}</div>
    <div style="width: 48px;"></div>
  </div>
  <div class="content">
    <span class="prompt">PS C:\SEMESTER 5\MOBILE PROGRAMMING\tugas 2&gt;</span> <span class="cmd">{command}</span>
    <div class="output">{escaped_output}</div>
  </div>
</div>
</body>
</html>
"""
    return html_content

def take_terminal_screenshot(driver, html_content, output_file):
    driver.get("about:blank")
    # Write to temp html
    temp_path = os.path.abspath("bukti_screenshot/temp_term.html")
    with open(temp_path, "w", encoding="utf-8") as f:
        f.write(html_content)

    driver.get(f"file:///{temp_path.replace(os.sep, '/')}")
    # Find window element to get precise bounding box
    elem = driver.find_element("class name", "window")
    elem.screenshot(output_file)
    print(f"Captured: {output_file}")

def main():
    os.makedirs("bukti_screenshot", exist_ok=True)

    options = Options()
    options.add_argument('--headless=new')
    options.add_argument('--window-size=1200,1600')
    driver = webdriver.Chrome(options=options)

    # 1. Praktikum Dasar 1-9
    print("Running dart run bin/praktikum_dasar.dart...")
    full_p_out = run_cmd("dart run bin/praktikum_dasar.dart")

    # Split output into P1-4, P5-6, P7-9
    lines = full_p_out.splitlines()

    # Find markers
    idx_p1 = 0
    idx_p5 = next(i for i, l in enumerate(lines) if "PRAKTIKUM 5" in l)
    idx_p7 = next(i for i, l in enumerate(lines) if "PRAKTIKUM 7" in l)

    p1_4 = "\n".join(lines[idx_p1:idx_p5]).strip()
    p5_6 = "\n".join(lines[idx_p5:idx_p7]).strip()
    p7_9 = "\n".join(lines[idx_p7:]).strip()

    # Capture P1-4
    h_p1_4 = create_terminal_html("PowerShell - Praktikum 1 s.d. 4", "dart run bin/praktikum_dasar.dart", p1_4)
    take_terminal_screenshot(driver, h_p1_4, "bukti_screenshot/terminal_praktikum_1_4.png")

    # Capture P5-6
    h_p5_6 = create_terminal_html("PowerShell - Praktikum 5 s.d. 6", "dart run bin/praktikum_dasar.dart", p5_6)
    take_terminal_screenshot(driver, h_p5_6, "bukti_screenshot/terminal_praktikum_5_6.png")

    # Capture P7-9
    h_p7_9 = create_terminal_html("PowerShell - Praktikum 7 s.d. 9", "dart run bin/praktikum_dasar.dart", p7_9)
    take_terminal_screenshot(driver, h_p7_9, "bukti_screenshot/terminal_praktikum_7_9.png")

    # 2. Eksplorasi Collection Bagian I & N
    print("Running dart run bin/eksplorasi_collection.dart...")
    out_eksplorasi = run_cmd("dart run bin/eksplorasi_collection.dart")
    h_eksplorasi = create_terminal_html("PowerShell - Eksplorasi Collection Bagian I & N", "dart run bin/eksplorasi_collection.dart", out_eksplorasi)
    take_terminal_screenshot(driver, h_eksplorasi, "bukti_screenshot/terminal_eksplorasi_bagian_i_n.png")

    # 3. Flutter analyze
    print("Running flutter analyze...")
    out_analyze = run_cmd("flutter analyze")
    h_analyze = create_terminal_html("PowerShell - Flutter Static Analysis", "flutter analyze", out_analyze)
    take_terminal_screenshot(driver, h_analyze, "bukti_screenshot/terminal_flutter_analyze.png")

    # 4. Flutter test
    print("Running flutter test...")
    out_test = run_cmd("flutter test")
    h_test = create_terminal_html("PowerShell - Automated Test Suite (28 Tests)", "flutter test", out_test, width=900)
    take_terminal_screenshot(driver, h_test, "bukti_screenshot/terminal_flutter_test.png")

    driver.quit()
    print("ALL TERMINAL SCREENSHOTS COMPLETED!")

if __name__ == '__main__':
    main()
