"""
https://otogi-rest.otogi-frontier.com/api/UGachas
卡池视频需要带上token get获取,这里就不放了
"""

import json, os, re, gzip, shutil, time
from concurrent.futures import ThreadPoolExecutor, as_completed
from pathlib import Path

import requests, pandas as pd, UnityPy
from Crypto.Cipher import AES
from Crypto.Util.Padding import unpad
from rich.progress import (Progress, SpinnerColumn, BarColumn, TextColumn,
                            TimeElapsedColumn, TimeRemainingColumn)


ENV_URL = ("https://osapi.dmm.com/gadgets/makeRequest?"
            "url=http://otogi-sp.trafficmanager.net/api/Configuration/Environment&httpMethod=POST")
WEBGL_MANIFEST_URL = "https://web-assets.otogi-frontier.com/prodassets/GeneralWebGL/Assets/WebGL"
ASSET_BASE_URL = "https://web-assets.otogi-frontier.com/prodassets/GeneralWebGL/Assets/"
MASTERDATA_URL = "https://web-assets.otogi-frontier.com/prodassets/MasterData/"
PATCH_URL_TEMPLATE = ("https://web-assets.otogi-frontier.com/prodassets/GeneralWebGL/AssetBundlePatch/"
                        "{version}/0_{version}{suffix}.csv")

MASTERDATA_FILES = [
    "MAccessory.gz", "MFoods.gz", "MItems.gz", "MMaterials.gz", "MMonsters.gz",
    "MRecipes.gz", "MSkills.gz", "MSpirits.gz", "MTrophies.gz", "MWeapons.gz", "SkillFilters.gz"
]

KEY, IV = b'kms1kms2kms3kms4', b'nekonekonyannyan'
UNITYFS_MAGIC, HEAD_LEN = b'UnityFS', 7


def decrypt_blob(enc: bytes):
    try:
        text = unpad(AES.new(KEY, AES.MODE_CBC, IV).decrypt(enc), AES.block_size)
        return text if text[:HEAD_LEN] == UNITYFS_MAGIC else None
    except Exception:
        return None

def need_decrypt(data: bytes):
    return data[:HEAD_LEN] != UNITYFS_MAGIC


def get_environment_ver():
    j = re.sub(r"^throw 1;.*?\{", "{", requests.get(ENV_URL, timeout=15).text,
                count=1, flags=re.DOTALL)
    headers = json.loads(j)["http://otogi-sp.trafficmanager.net/api/Configuration/Environment"]["headers"]
    ver = headers["X-OtogiSp-AssetsVersion"]
    print(f"[+] AssetVersion = {ver}")
    return ver


def load_manifest_tree(path: Path):
    env = UnityPy.load(str(path))
    for obj in env.objects:
        if obj.type.name == "AssetBundleManifest":
            return obj.read_typetree()


def download_webgl_manifest():
    Path("WebGL").write_bytes(requests.get(WEBGL_MANIFEST_URL, timeout=15).content)
    tree = load_manifest_tree(Path("WebGL"))
    idx2name = {int(i): n for i, n in tree["AssetBundleNames"]}
    names = [idx2name[int(e[0])] for e in tree["AssetBundleInfos"]]
    pd.DataFrame({"AssetBundleName": names}).to_csv("WebGL.csv", index=False)
    print(f"[+] WebGL.csv 解析完成 ({len(names)})")
    return names


def download_masterdata():
    os.makedirs("MasterData", exist_ok=True)
    with Progress(SpinnerColumn(), TextColumn("{task.description}"),
                    BarColumn(), TimeRemainingColumn(), transient=True) as p:
        t = p.add_task("[cyan]MasterData", total=len(MASTERDATA_FILES))
        for f in MASTERDATA_FILES:
            gz = Path("MasterData") / f
            gz.write_bytes(requests.get(MASTERDATA_URL + f, timeout=30).content)
            with gzip.open(gz, "rb") as i, open(gz.with_suffix(".json"), "wb") as o:
                shutil.copyfileobj(i, o)
            data = json.load(open(gz.with_suffix(".json"), encoding="utf-8"))
            json.dump(data, open(gz.with_suffix(".json"), "w", encoding="utf-8"),
                        ensure_ascii=False, indent=4)
            gz.unlink(); p.advance(t)
    print("[+] MasterData 解析完成")


def download_patch_list(ver: str):
    size_map, names = {}, []
    for suf in ["", "_ad"]:
        url = PATCH_URL_TEMPLATE.format(version=ver, suffix=suf)
        df = pd.read_csv(url)
        names += df["AssetBundleName"].dropna().tolist()
        if "Size" in df.columns:
            for n, s in zip(df["AssetBundleName"], df["Size"]):
                if pd.notna(n) and pd.notna(s):
                    size_map[n] = int(s)
    print(f"[+] Patch CSV 解析完成 ({len(names)})")
    return names, size_map


def _process_asset(asset: str, size_map: dict[str, int], retries=5):
    expected = size_map.get(asset)
    path_old = Path("Assets") / asset
    need_new, is_update = False, False

    if path_old.exists() and expected:
        local = path_old.stat().st_size
        if abs(local - expected) <= 16: # 16B误差
            data = path_old.read_bytes()
            if need_decrypt(data):
                dec = decrypt_blob(data)
                if dec:
                    path_old.write_bytes(dec)
                    return "ok_dec", asset
                return "decrypt_failed", str(path_old)
            return "ok", asset
        else:
            need_new, is_update = True, True
    elif not path_old.exists():
        need_new = True

    if need_new:
        url = ASSET_BASE_URL + asset
        for attempt in range(retries):
            try:
                remote = requests.get(url, timeout=30).content
                break
            except Exception as e:
                if attempt == retries - 1:
                    return "download_failed", url
                time.sleep(1.5 ** attempt)

        save_path = (Path("Assets_Update") if is_update else Path("Assets")) / asset
        save_path.parent.mkdir(parents=True, exist_ok=True)
        save_path.write_bytes(remote)

        if need_decrypt(remote):
            dec = decrypt_blob(remote)
            if dec:
                save_path.write_bytes(dec)
                return ("updated_dec" if is_update else "ok_dec"), asset
            return "decrypt_failed", str(save_path)
        return ("updated" if is_update else "ok"), asset


def download_assets(assets: list[str], size_map: dict[str, int]):
    os.makedirs("Assets", exist_ok=True)
    os.makedirs("Assets_Update", exist_ok=True)

    stats = {k: 0 for k in
            ["ok", "ok_dec", "updated", "updated_dec",
            "download_failed", "decrypt_failed"]}
    dl_failed, dec_failed = [], []

    workers = max(4, (os.cpu_count() or 4) * 2)
    print(f"[*] 检查/下载 {len(assets)} 个资源 ({workers} 线程)")
    prog = Progress(SpinnerColumn(), TextColumn("{task.description}"),
                    BarColumn(), "[progress.percentage]{task.percentage:>3.1f}%",
                    TimeElapsedColumn(), TimeRemainingColumn(), transient=True)

    with prog:
        task = prog.add_task("[cyan]Assets", total=len(assets))
        with ThreadPoolExecutor(max_workers=workers) as pool:
            futs = {pool.submit(_process_asset, a, size_map): a for a in assets}
            for fut in as_completed(futs):
                state, info = fut.result()
                stats[state] += 1
                if state == "download_failed":
                    dl_failed.append(info)
                elif state == "decrypt_failed":
                    dec_failed.append(info)
                prog.advance(task)

    if dl_failed:
        Path("download_failed.txt").write_text("\n".join(dl_failed), encoding="utf-8")
    if dec_failed:
        Path("decrypt_failed.txt").write_text("\n".join(dec_failed), encoding="utf-8")

    line = ", ".join(f"{k}={v}" for k, v in stats.items())
    print("[+] 总结 →", line)
    if dl_failed:
        print(f"[!] download_failed.txt 写入 ({len(dl_failed)})")
    if dec_failed:
        print(f"[!] decrypt_failed.txt 写入 ({len(dec_failed)})")


def main():
    ver = get_environment_ver()
    webgl_names = download_webgl_manifest()
    download_masterdata()
    patch_names, size_map = download_patch_list(ver)

    all_assets = sorted(set(webgl_names + patch_names))
    download_assets(all_assets, size_map)

if __name__ == "__main__":
    main()
