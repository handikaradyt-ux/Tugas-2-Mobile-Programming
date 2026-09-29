import os
import time
import html
import subprocess
import urllib.parse
from selenium import webdriver
from selenium.webdriver.chrome.options import Options

def run_cmd(cmd):
    result = subprocess.run(cmd, shell=True, capture_output=True, text=True, cwd=r"c:\SEMESTER 5\MOBILE PROGRAMMING\tugas 2")
    return result.stdout.strip() if result.stdout else result.stderr.strip()

def create_terminal_html(title, command, output_text, width=860):
    escaped_output = html.escape(output_text)
    html_content = f"""<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<style>
  * {{ box-sizing: border-box; margin: 0; padding: 0; }}
  body {{
    background: transparent;
    padding: 16px;
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
    <span class="prompt">PS C:\\SEMESTER 5\\MOBILE PROGRAMMING\\tugas 2&gt;</span> <span class="cmd">{command}</span>
    <div class="output">{escaped_output}</div>
  </div>
</div>
</body>
</html>
"""
    return html_content

def take_terminal_screenshot(driver, html_content, output_file):
    temp_path = os.path.abspath("bukti_screenshot/temp_term.html")
    with open(temp_path, "w", encoding="utf-8") as f:
        f.write(html_content)

    driver.get(f"file:///{temp_path.replace(os.sep, '/')}")
    elem = driver.find_element("class name", "window")
    elem.screenshot(output_file)
    print(f"Captured: {output_file}")

def main():
    os.makedirs("bukti_screenshot", exist_ok=True)

    # Setup Chrome
    options = Options()
    options.add_argument('--headless=new')
    options.add_argument('--no-sandbox')
    options.add_argument('--disable-dev-shm-usage')

    # 1. Capture Terminal Screenshots with Desktop Window Size
    options.add_argument('--window-size=1200,1600')
    driver = webdriver.Chrome(options=options)

    print("--- 1. Terminal Screenshots ---")
    full_p_out = run_cmd("dart run bin/praktikum_dasar.dart")
    lines = full_p_out.splitlines()
    idx_p1 = 0
    idx_p5 = next(i for i, l in enumerate(lines) if "PRAKTIKUM 5" in l)
    idx_p7 = next(i for i, l in enumerate(lines) if "PRAKTIKUM 7" in l)

    p1_4 = "\n".join(lines[idx_p1:idx_p5]).strip()
    p5_6 = "\n".join(lines[idx_p5:idx_p7]).strip()
    p7_9 = "\n".join(lines[idx_p7:]).strip()

    take_terminal_screenshot(driver, create_terminal_html("PowerShell - Praktikum 1 s.d. 4", "dart run bin/praktikum_dasar.dart", p1_4), "bukti_screenshot/terminal_praktikum_1_4.png")
    take_terminal_screenshot(driver, create_terminal_html("PowerShell - Praktikum 5 s.d. 6", "dart run bin/praktikum_dasar.dart", p5_6), "bukti_screenshot/terminal_praktikum_5_6.png")
    take_terminal_screenshot(driver, create_terminal_html("PowerShell - Praktikum 7 s.d. 9", "dart run bin/praktikum_dasar.dart", p7_9), "bukti_screenshot/terminal_praktikum_7_9.png")

    out_eksplorasi = run_cmd("dart run bin/eksplorasi_collection.dart")
    take_terminal_screenshot(driver, create_terminal_html("PowerShell - Eksplorasi Collection Bagian I & N", "dart run bin/eksplorasi_collection.dart", out_eksplorasi), "bukti_screenshot/terminal_eksplorasi_bagian_i_n.png")

    out_analyze = run_cmd("flutter analyze")
    take_terminal_screenshot(driver, create_terminal_html("PowerShell - Flutter Static Analysis", "flutter analyze", out_analyze), "bukti_screenshot/terminal_flutter_analyze.png")

    out_test = run_cmd("flutter test")
    take_terminal_screenshot(driver, create_terminal_html("PowerShell - Automated Test Suite (28 Tests)", "flutter test", out_test, width=920), "bukti_screenshot/terminal_flutter_test.png")
    driver.quit()

    # 2. Capture Flutter App Screenshots on Mobile Viewport (390 x 844)
    print("\n--- 2. Flutter Mobile Screenshots (390 x 844) ---")
    m_options = Options()
    m_options.add_argument('--headless=new')
    m_options.add_argument('--no-sandbox')
    m_options.add_argument('--disable-dev-shm-usage')
    m_options.add_argument('--window-size=390,844')
    m_driver = webdriver.Chrome(options=m_options)

    app_targets = [
        # A. Mahasiswa Page
        ("app_mahasiswa_dashboard_daftar.png", "http://localhost:8088/?tab=0"),
        ("app_mahasiswa_tambah_dialog.png", "http://localhost:8088/?tab=0&m_action=tambah"),
        ("app_mahasiswa_tambah_hasil.png", "http://localhost:8088/?tab=0&m_action=added_sample"),
        ("app_mahasiswa_edit_dialog.png", "http://localhost:8088/?tab=0&m_action=edit"),
        ("app_mahasiswa_edit_hasil.png", "http://localhost:8088/?tab=0&m_action=edited_sample"),
        ("app_mahasiswa_delete_dialog.png", "http://localhost:8088/?tab=0&m_action=delete"),
        ("app_mahasiswa_delete_hasil.png", "http://localhost:8088/?tab=0&m_action=deleted_sample"),
        ("app_mahasiswa_search.png", "http://localhost:8088/?tab=0&m_search=fauzi"),
        ("app_mahasiswa_filter_cumlaude.png", f"http://localhost:8088/?tab=0&m_filter={urllib.parse.quote('IPK ≥ 3.50')}"),
        ("app_mahasiswa_filter_non_cumlaude.png", f"http://localhost:8088/?tab=0&m_filter={urllib.parse.quote('IPK < 3.50')}"),
        ("app_mahasiswa_sort_nama_za.png", f"http://localhost:8088/?tab=0&m_sort={urllib.parse.quote('Nama Z-A')}"),
        ("app_mahasiswa_sort_ipk_tertinggi.png", f"http://localhost:8088/?tab=0&m_sort={urllib.parse.quote('IPK Tertinggi')}"),
        ("app_mahasiswa_sort_ipk_terendah.png", f"http://localhost:8088/?tab=0&m_sort={urllib.parse.quote('IPK Terendah')}"),
        ("app_mahasiswa_sort_semester.png", f"http://localhost:8088/?tab=0&m_sort={urllib.parse.quote('Semester')}"),

        # B. Mata Kuliah Page
        ("app_matakuliah_daftar_ringkasan.png", "http://localhost:8088/?tab=1"),
        ("app_matakuliah_tambah_dialog.png", "http://localhost:8088/?tab=1&mk_action=tambah"),
        ("app_matakuliah_edit_dialog.png", "http://localhost:8088/?tab=1&mk_action=edit"),
        ("app_matakuliah_delete_dialog.png", "http://localhost:8088/?tab=1&mk_action=delete"),
        ("app_matakuliah_search.png", "http://localhost:8088/?tab=1&mk_search=mobile"),
        ("app_matakuliah_sort_sks.png", f"http://localhost:8088/?tab=1&mk_sort={urllib.parse.quote('SKS (Urutan Naik)')}"),
        ("app_matakuliah_filter_2sks.png", f"http://localhost:8088/?tab=1&mk_filter={urllib.parse.quote('2 SKS')}"),
        ("app_matakuliah_filter_3sks.png", f"http://localhost:8088/?tab=1&mk_filter={urllib.parse.quote('3 SKS')}"),
        ("app_matakuliah_filter_4sks.png", f"http://localhost:8088/?tab=1&mk_filter={urllib.parse.quote('4 SKS')}"),

        # C. Inventory Page
        ("app_inventory_daftar_total.png", "http://localhost:8088/?tab=2"),
        ("app_inventory_tambah_dialog.png", "http://localhost:8088/?tab=2&inv_action=tambah"),
        ("app_inventory_edit_dialog.png", "http://localhost:8088/?tab=2&inv_action=edit"),
        ("app_inventory_delete_dialog.png", "http://localhost:8088/?tab=2&inv_action=delete"),
        ("app_inventory_search.png", "http://localhost:8088/?tab=2&inv_search=asus"),

        # D. Eksplorasi Page
        ("app_eksplorasi_collection.png", "http://localhost:8088/?tab=3"),
    ]

    for filename, url in app_targets:
        out_path = os.path.join("bukti_screenshot", filename)
        m_driver.get(url)
        time.sleep(2.5)  # Wait for Flutter rendering
        m_driver.save_screenshot(out_path)
        print(f"Captured: {out_path}")

    m_driver.quit()
    print("\nALL SCREENSHOTS CAPTURED SUCCESSFULLY!")

if __name__ == '__main__':
    main()
