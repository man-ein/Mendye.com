<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Percentage Calculator • mendye.com</title>
  <style>
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body {
      font-family: 'Segoe UI', Arial, sans-serif;
      background: linear-gradient(135deg, #77a7dd, #284beb, #2b7be4);
      color: white;
      min-height: 100vh;
      display: flex;
      flex-direction: column;
    }

    header {
      background: rgba(0, 0, 0, 0.4);
      padding: 20px 40px;
      backdrop-filter: blur(10px);
      position: sticky;
      top: 0;
      z-index: 100;
    }
    .header-content {
      max-width: 1200px;
      margin: 0 auto;
      display: flex;
      justify-content: space-between;
      align-items: center;
    }
    .logo {
      font-size: 28px;
      font-weight: bold;
      text-decoration: none;
      color: #ffeb3b;
      text-shadow: 0 0 10px rgba(255,235,59,0.5);
    }
    nav a {
      color: white;
      text-decoration: none;
      margin-left: 30px;
      font-weight: 500;
      transition: color 0.3s;
    }
    nav a:hover { color: #ffeb3b; }

    main {
      flex: 1;
      padding: 40px 20px;
      max-width: 900px;
      margin: 0 auto;
      width: 100%;
    }

    h1 {
      text-align: center;
      font-size: 52px;
      margin-bottom: 40px;
      text-shadow: 0 0 20px rgba(0,0,0,0.4);
    }

    .calc-grid {
      display: grid;
      gap: 30px;
      grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
    }

    .calc-card {
      background: rgba(255,255,255,0.12);
      backdrop-filter: blur(12px);
      border-radius: 20px;
      padding: 30px;
      border: 1px solid rgba(255,255,255,0.1);
      box-shadow: 0 15px 40px rgba(0,0,0,0.3);
    }

    .calc-card h3 {
      font-size: 22px;
      margin-bottom: 20px;
      color: #ffeb3b;
      text-align: center;
    }

    input {
      width: 100%;
      padding: 14px;
      margin: 10px 0;
      background: rgba(255,255,255,0.2);
      border: none;
      border-radius: 10px;
      color: white;
      font-size: 18px;
      text-align: center;
    }
    input::placeholder { color: rgba(255,255,255,0.7); }

    .result {
      text-align: center;
      font-size: 32px;
      font-weight: bold;
      margin: 20px 0;
      padding: 15px;
      background: rgba(255,235,59,0.2);
      border-radius: 12px;
      min-height: 70px;
      display: flex;
      align-items: center;
      justify-content: center;
      color: #ffeb3b;
    }

    button {
      width: 100%;
      padding: 14px;
      background: #ffeb3b;
      color: #0f5132;
      font-weight: bold;
      border: none;
      border-radius: 50px;
      font-size: 18px;
      cursor: pointer;
      transition: 0.4s;
    }
    button:hover {
      background: white;
      transform: translateY(-4px);
    }

    footer {
      background: rgba(0, 0, 0, 0.6);
      padding: 40px 20px;
      backdrop-filter: blur(10px);
    }
    .footer-content {
      max-width: 1200px;
      margin: 0 auto;
      text-align: center;
    }
    .footer-links a { color: #ffeb3b; text-decoration: none; margin: 0 15px; }
    .footer-links a:hover { text-decoration: underline; }

    @media (max-width: 768px) {
      h1 { font-size: 42px; }
      .calc-grid { grid-template-columns: 1fr; }
    }
  </style>
</head>
<body>

  <header>
    <div class="header-content">
      <a href="/" class="logo">mendye.com</a>
      <nav>
        <a href="/">Home</a>
        <a href="/about-us">About Us</a>
        <a href="/contact-us">Contact Us</a>
        <a href="/tools">Tools</a>
      </nav>
    </div>
  </header>

  <main>
    <h1>Percentage Calculator</h1>

    <div class="calc-grid">

      <!-- 1. What is X% of Y? -->
      <div class="calc-card">
        <h3>What is <input type="number" id="p1" placeholder="%" style="width:60px;display:inline-block;">% of <input type="number" id="n1" placeholder="number">?</h3>
        <div class="result" id="r1">0</div>
        <button onclick="calc1()">Calculate</button>
      </div>

      <!-- 2. X is what % of Y? -->
      <div class="calc-card">
        <h3><input type="number" id="n2" placeholder="part"> is what % of <input type="number" id="t2" placeholder="total">?</h3>
        <div class="result" id="r2">0%</div>
        <button onclick="calc2()">Calculate</button>
      </div>

      <!-- 3. X is Y% of what? -->
      <div class="calc-card">
        <h3><input type="number" id="n3" placeholder="part"> is <input type="number" id="p3" placeholder="%" style="width:60px;display:inline-block;">% of what?</h3>
        <div class="result" id="r3">0</div>
        <button onclick="calc3()">Calculate</button>
      </div>

      <!-- 4. Percentage Change -->
      <div class="calc-card">
        <h3>From <input type="number" id="old" placeholder="old value"> to <input type="number" id="new" placeholder="new value"></h3>
        <div class="result" id="change">0%</div>
        <button onclick="calcChange()">Calculate Change</button>
      </div>

      <!-- 5. Add/Subtract % -->
      <div class="calc-card">
        <h3><input type="number" id="base" placeholder="number"> ± <input type="number" id="perc" placeholder="%" style="width:70px;display:inline-block;">%</h3>
        <div class="result" id="plusminus">0</div>
        <button onclick="calcPlusMinus()">Calculate</button>
      </div>

    </div>
  </main>

  <footer>
    <div class="footer-content">
      <div class="footer-links">
        <a href="/contact-us">Contact Us</a>
        <a href="/terms-and-conditions">Terms & Conditions</a>
        <a href="/privacy-policy">Privacy Policy</a>
      </div>
      <div style="margin-top:10px; opacity:0.8;">© 2025 mendye.com • All rights reserved.</div>
    </div>
  </footer>

  <script>
    function calc1() {
      let p = parseFloat(document.getElementById('p1').value) || 0;
      let n = parseFloat(document.getElementById('n1').value) || 0;
      document.getElementById('r1').textContent = (n * p / 100).toFixed(2);
    }
    function calc2() {
      let part = parseFloat(document.getElementById('n2').value) || 0;
      let total = parseFloat(document.getElementById('t2').value) || 0;
      document.getElementById('r2').textContent = total ? (part / total * 100).toFixed(2) + '%' : '0%';
    }
    function calc3() {
      let part = parseFloat(document.getElementById('n3').value) || 0;
      let p = parseFloat(document.getElementById('p3').value) || 0;
      document.getElementById('r3').textContent = p ? (part * 100 / p).toFixed(2) : '0';
    }
    function calcChange() {
      let old = parseFloat(document.getElementById('old').value) || 0;
      let newv = parseFloat(document.getElementById('new').value) || 0;
      let change = old ? ((newv - old) / old * 100).toFixed(2) : 0;
      document.getElementById('change').textContent = change + '%';
      document.getElementById('change').style.color = change >= 0 ? '#90ee90' : '#ff6b6b';
    }
    function calcPlusMinus() {
      let base = parseFloat(document.getElementById('base').value) || 0;
      let perc = parseFloat(document.getElementById('perc').value) || 0;
      let plus = base + (base * perc / 100);
      let minus = base - (base * perc / 100);
      document.getElementById('plusminus').innerHTML = 
        `<strong>+${perc}% →</strong> ${plus.toFixed(2)}<br><strong>-${perc}% →</strong> ${minus.toFixed(2)}`;
    }

    // Auto-calculate on input
    document.querySelectorAll('input').forEach(inp => inp.addEventListener('input', function() {
      const card = this.closest('.calc-card');
      const btn = card.querySelector('button');
      if (btn.onclick) btn.onclick();
    }));
  </script>

</body>
</html>
