/**
 * RXR (jp.co.happyelements.rxr) in-process network capture + cert pinning bypass.
 *
 * Capture strategy: we DO NOT MITM (the game's bootstrap cert download cannot be
 * intercepted without a trusted CA and app pinning gets in the way). Instead we hook
 * the managed UnityWebRequest layer and dump every request URL + request body +
 * response body (byte[] / string) directly from the decrypted native buffers.
 *
 * Hooks:
 *   UnityWebRequest.set_url                    -> URL, map reqPtr -> url
 *   UnityWebRequest.set_uploadHandler         -> map reqPtr -> uploadHandlerPtr
 *   UploadHandlerRaw.GetData (byte[])         -> request body (map via uploadHandler)
 *   UnityWebRequest.get_downloadHandler       -> map downloadHandlerPtr -> reqPtr
 *   DownloadHandler.get_data (byte[])         -> response body (binary send)
 *   DownloadHandler.get_text (string)         -> response body (utf-16 -> text)
 *   DownloadHandler.get_error                 -> error string
 *   UnityWebRequest.get_error                 -> error string
 * plus pinning bypass hooks (kept for optional MITM experiments):
 *   ApiCertificateHandler.ValidateCertificate -> true
 *   Cysharp NativeHttpHandlerCore.OnServerCertificateVerification -> true
 *   ServerCertificateVerificationHandler.Invoke -> true
 *   SignedTrustPublicKeysVerifier.Verify -> true
 *   NativeClientSettings.get_SkipCertificateVerification -> true
 *
 * Build: node_modules/.bin/frida-compile agent.ts -o _agent.js
 */
import "frida-il2cpp-bridge";

const CFG = {
    BYPASS_PINNING: true,
    DUMP_BODIES: true,
    MAX_BODY: 400 * 1024 * 1024,   // hard cap per body
    MIN_BODY: 0,                    // dump all sizes
    LOG: true,
};

let binSeq = 0;
const reqUrl: { [k: string]: string } = {};
const reqUpload: { [k: string]: string } = {};
const uploadReq: { [k: string]: string } = {};
const handlerReq: { [k: string]: string } = {};

function log(kind: string, data: any) { try { send({ kind: kind, data: data }); } catch (e) { } }
function logBody(dir: "req" | "resp", bytes: ArrayBuffer, url: string, note: string) {
    try {
        binSeq++;
        // 大响应（masterdata 约 80MB）只回传头部，避免跨 frida 通道搬 80MB；分类只需要长度+前 4KB。
        if (bytes.byteLength > 1024 * 1024) {
            send({ kind: "body-meta", dir: dir, id: binSeq, len: bytes.byteLength, url: url, note: note, head: bytes.slice(0, 4096) });
            return;
        }
        send({ kind: "body", dir: dir, id: binSeq, len: bytes.byteLength, url: url, note: note }, bytes);
    } catch (e) { log("body-send-err", { err: String(e) }); }
}

function findClass(fullName: string): Il2Cpp.Class | null {
    const parts = fullName.split("/");
    try {
        for (const asm of Il2Cpp.domain.assemblies) {
            try {
                const image = asm.image;
                let klass: Il2Cpp.Class | null = image.tryClass(parts[0]);
                if (!klass) { for (const c of image.classes) if (c.fullName === parts[0]) { klass = c; break; } }
                if (!klass) continue;
                let ok = true;
                for (let i = 1; i < parts.length; i++) {
                    let next: Il2Cpp.Class | null = null;
                    for (const n of klass.nestedClasses) if (n.name === parts[i]) { next = n; break; }
                    if (!next) { ok = false; break; }
                    klass = next;
                }
                if (ok && klass) return klass;
            } catch (e) { }
        }
    } catch (e) { log("find-class-err", { name: fullName, err: String(e) }); }
    return null;
}

function hookMethod(klass: Il2Cpp.Class | null, methodName: string, tag: string, handlers: { onEnter?: (args: NativePointer[]) => void; onLeave?: (retval: NativePointer) => void }) {
    if (!klass) { log("hook-miss-class", { tag: tag }); return; }
    let ms: Il2Cpp.Method[] = [];
    try { ms = klass.methods.filter(m => m.name === methodName); } catch (e) { }
    if (!ms.length) { log("hook-miss-method", { tag: tag, avail: (() => { try { return klass.methods.map(m => m.name); } catch (e) { return []; } })() }); return; }
    for (const m of ms) {
        try {
            let ret = "?";
            try { ret = m.returnType.name; } catch (e) { }
            log("hook", { tag: tag, ret: ret, params: (() => { try { return m.parameters.map(p => p.type.name); } catch (e) { return []; } })(), va: m.virtualAddress.toString() });
            Interceptor.attach(m.virtualAddress, {
                onEnter: function (args) { try { if (handlers.onEnter) handlers.onEnter(args); } catch (e) { log("onenter-err", { tag: tag, err: String(e) }); } },
                onLeave: function (retval) { try { if (handlers.onLeave) handlers.onLeave(retval as NativePointer); } catch (e) { log("onleave-err", { tag: tag, err: String(e) }); } }
            });
            log("hook-ok", { tag: tag });
        } catch (e) { log("hook-err", { tag: tag, err: String(e) }); }
    }
}

/* ---------- il2cpp array / string readers ---------- */
function readIl2CppString(p: NativePointer): string {
    try {
        if (!p || p.isNull()) return "";
        const len = p.add(0x10).readS32();
        if (len < 0 || len > 1000000) return "";
        const chars = p.add(0x14).readByteArray(len * 2);
        if (!chars) return "";
        // decode utf-16le in frida
        const u16 = new Uint16Array(chars);
        let out = "";
        for (let i = 0; i < u16.length; i++) out += String.fromCharCode(u16[i]);
        return out;
    } catch (e) { return "<str-err:" + String(e) + ">"; }
}
function dumpIl2CppArray(p: NativePointer, dir: "req" | "resp", url: string, note: string) {
    try {
        if (!p || p.isNull()) return;
        const len = p.add(0x18).readS64().toNumber();
        if (len <= CFG.MIN_BODY || len > CFG.MAX_BODY) { log("body-skip", { dir: dir, len: len, url: url }); return; }
        const bytes = p.add(0x20).readByteArray(len);
        if (bytes) logBody(dir, bytes, url, note + ":" + len);
    } catch (e) { log("dump-array-err", { dir: dir, err: String(e) }); }
}

function urlOfReq(reqPtr: NativePointer): string {
    try { const s = reqUrl[reqPtr.toString()]; return s || ""; } catch (e) { return ""; }
}
let lastReqPtrStr = "";
let versionKey = "";
const reqHeaders: { [k: string]: { [k: string]: string } } = {};
let curHandlerPtrStr = "";
const handlerUrl: { [k: string]: string } = {};

/* ---------- pinning bypass (optional, harmless) ---------- */
function bypassPinning() {
    if (!CFG.BYPASS_PINNING) return;
    const handlerCls = findClass("ReverseEngine.Api.Decorators.CertificateDecorator/ApiCertificateHandler");
    if (handlerCls) {
        try {
            const m = handlerCls.methods.find(x => x.name === "ValidateCertificate");
            if (m) { m.implementation = function () { log("cert-validate", { note: "bypass-true" }); return true; }; log("hook-ok", { tag: "ApiCertificateHandler.ValidateCertificate" }); }
        } catch (e) { log("hook-err", { tag: "cert", err: String(e) }); }
    }
    const core = findClass("Cysharp.Net.Http.NativeHttpHandlerCore");
    if (core) {
        try {
            for (const m of core.methods.filter(x => x.name === "OnServerCertificateVerification")) {
                Interceptor.attach(m.virtualAddress, { onEnter() { }, onLeave(retval) { try { retval.replace(ptr(1)); } catch (e) { } } });
                log("hook-ok", { tag: "NativeHttpHandlerCore.OnServerCertificateVerification" });
            }
        } catch (e) { }
    }
    const sch = findClass("Cysharp.Net.Http.ServerCertificateVerificationHandler");
    if (sch) {
        try {
            const m = sch.methods.find(x => x.name === "Invoke");
            if (m) { m.implementation = function () { return true; }; log("hook-ok", { tag: "ServerCertificateVerificationHandler.Invoke" }); }
        } catch (e) { }
    }
    const ver = findClass("Reverse.Runtimes.Api.Model.SignedTrustPublicKeysVerifier");
    if (ver) {
        try {
            for (const m of ver.methods.filter(x => x.name === "Verify")) { m.implementation = function () { return true; }; }
            log("hook-ok", { tag: "SignedTrustPublicKeysVerifier.Verify" });
        } catch (e) { }
    }
}

/* ---------- network capture ---------- */
function setupCapture() {
    const UWR = findClass("UnityEngine.Networking.UnityWebRequest");
    if (!UWR) { log("fatal", { err: "UnityWebRequest class not found" }); return; }
    log("class", { name: UWR.fullName });

    hookMethod(UWR, "SetRequestHeader", "UnityWebRequest.SetRequestHeader", {
        onEnter: function (args) {
            try {
                const req = args[0];
                const name = readIl2CppString(args[1]);
                const value = readIl2CppString(args[2]);
                if (name) {
                    const key = req.toString();
                    if (!reqHeaders[key]) reqHeaders[key] = {};
                    reqHeaders[key][name.toLowerCase()] = value;
                    if (name.toLowerCase() === "reverse-version-key") {
                        versionKey = value;
                        log("version-key", { value: value });
                    }
                }
            } catch (e) { log("header-err", { err: String(e) }); }
        }
    });
    hookMethod(UWR, "set_url", "UnityWebRequest.set_url", {
        onEnter: function (args) {
            const req = args[0];
            const url = readIl2CppString(args[1]);
            try { reqUrl[req.toString()] = url; } catch (e) { }
            log("url", { url: url });
        }
    });
    hookMethod(UWR, "set_uploadHandler", "UnityWebRequest.set_uploadHandler", {
        onEnter: function (args) {
            try { reqUpload[args[0].toString()] = args[1].toString(); uploadReq[args[1].toString()] = args[0].toString(); } catch (e) { }
        }
    });
    hookMethod(UWR, "get_downloadHandler", "UnityWebRequest.get_downloadHandler", {
        onEnter: function (args) { try { lastReqPtrStr = args[0].toString(); } catch (e) { } },
        onLeave: function (retval) {
            try {
                const h = retval.toString();
                const u = reqUrl[lastReqPtrStr] || "";
                handlerUrl[h] = u;
                log("dh", { handler: h, url: u });
            } catch (e) { }
            lastReqPtrStr = "";
        }
    });
    hookMethod(UWR, "get_error", "UnityWebRequest.get_error", {
        onLeave: function (retval) {
            const s = readIl2CppString(retval);
            if (s) log("uwerror", { err: s });
        }
    });

    // DownloadHandler: property getters are non-virtual on the base class -> single hook point
    const DH = findClass("UnityEngine.Networking.DownloadHandler");
    if (DH) {
        hookMethod(DH, "get_data", "DownloadHandler.get_data", {
            onEnter: function (args) { try { curHandlerPtrStr = args[0].toString(); } catch (e) { } },
            onLeave: function (retval) {
                const u = handlerUrl[curHandlerPtrStr] || "";
                dumpIl2CppArray(retval, "resp", u, "get_data");
                curHandlerPtrStr = "";
            }
        });
        hookMethod(DH, "get_text", "DownloadHandler.get_text", {
            onLeave: function (retval) {
                try {
                    const s = readIl2CppString(retval);
                    if (s.length > 0 && s.length < 32 * 1024 * 1024) {
                        log("text", { len: s.length, head: s.substring(0, 300) });
                        if (s.length > 200) {
                            binSeq++;
                            const enc = unescape(encodeURIComponent(s));
                            const buf = new ArrayBuffer(enc.length);
                            const view = new Uint8Array(buf);
                            for (let i = 0; i < enc.length; i++) view[i] = enc.charCodeAt(i) & 0xff;
                            send({ kind: "body", dir: "resp", id: binSeq, len: buf.byteLength, url: "", note: "text:" + s.length }, buf);
                        }
                    }
                } catch (e) { log("text-err", { err: String(e) }); }
            }
        });
        hookMethod(DH, "get_error", "DownloadHandler.get_error", {
            onLeave: function (retval) {
                const s = readIl2CppString(retval);
                if (s) log("dherror", { err: s });
            }
        });
    }
    // request bodies: UploadHandlerRaw.GetData (override, Slot 6)
    const UHR = findClass("UnityEngine.Networking.UploadHandlerRaw");
    if (UHR) {
        hookMethod(UHR, "GetData", "UploadHandlerRaw.GetData", {
            onLeave: function (retval) {
                try {
                    const len = retval.isNull() ? 0 : retval.add(0x18).readS64().toNumber();
                    const bytes = retval.isNull() ? null : retval.add(0x20).readByteArray(len);
                    if (bytes && len > 0) logBody("req", bytes, "", "upload:" + len);
                } catch (e) { log("upl-err", { err: String(e) }); }
            }
        });
    }
    log("capture-ready", {});
}

Il2Cpp.perform(() => {
    log("il2cpp-ready", { unity: (() => { try { return Il2Cpp.unityVersion; } catch (e) { return "?"; } })(), version: (() => { try { return Il2Cpp.application.version; } catch (e) { return "?"; } })() });
    bypassPinning();
    setupCapture();
    let appVersion = "?";
    try { appVersion = Il2Cpp.application.version ?? "?"; } catch (e) { }
    log("ready", { appVersion: appVersion, versionKey: versionKey });
});