// app.js - optional organized helpers (merkle, crypto, notes). This is a placeholder mirroring functions in bitshade-pro.html.
export async function sha256Hex(text){ const enc=new TextEncoder(); const data=enc.encode(text); const h=await crypto.subtle.digest('SHA-256', data); return Array.from(new Uint8Array(h)).map(b=>b.toString(16).padStart(2,'0')).join(''); }
