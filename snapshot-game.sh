#!/usr/bin/env bash
# 把某个游戏文件夹做成 DataTable 的独立快照并推送。
# 大文件（默认 >= 50MB）自动走 Git LFS。
#
# 用法:
#   ./snapshot-game.sh Echocalypse
#   ./snapshot-game.sh /path/to/SomeGame --name SomeGame
#
# 已有 game/<名> 分支时默认更新该分支（保留历史），不会重建孤儿快照。
# 游戏自己的更新脚本只负责刷新本地数据，跑完再执行本脚本上传。
#
# 常用选项:
#   --name NAME        分支名，默认用文件夹名
#   --threshold 90M    走 LFS 的大小阈值
#   --new              仅当分支不存在时新建孤儿快照
#   --no-lfs           不启用 LFS；单个文件超过 100MB 会失败
#   --no-push          只提交不推送
#   --no-index         不改 master README
#   --dry-run          只打印将要做的事
#   --message MSG      提交说明

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BRANCH_PREFIX="game/"
DEFAULT_THRESHOLD="50M"
GITHUB_HARD="100M"

GAME_NAME=""
SRC_DIR=""
THRESHOLD="$DEFAULT_THRESHOLD"
FORCE_NEW=0
NO_LFS=0
NO_PUSH=0
NO_INDEX=0
DRY_RUN=0
COMMIT_MSG=""

usage() {
    sed -n '2,20p' "$0" | sed 's/^# \?//'
    exit "${1:-0}"
}

log() { printf '[snapshot] %s\n' "$*"; }
die() { printf '[snapshot] 错误: %s\n' "$*" >&2; exit 1; }

parse_size() {
    local raw="${1^^}"
    if [[ "$raw" =~ ^([0-9]+)([KMG]?)$ ]]; then
        local n="${BASH_REMATCH[1]}"
        local u="${BASH_REMATCH[2]}"
        case "$u" in
            K) echo $((n * 1024)) ;;
            M) echo $((n * 1024 * 1024)) ;;
            G) echo $((n * 1024 * 1024 * 1024)) ;;
            *) echo "$n" ;;
        esac
        return
    fi
    die "无法解析大小: $1"
}

human_size() {
    local n="$1"
    if ((n >= 1073741824)); then
        awk -v n="$n" 'BEGIN { printf "%.1fGB", n/1073741824 }'
    elif ((n >= 1048576)); then
        awk -v n="$n" 'BEGIN { printf "%.1fMB", n/1048576 }'
    elif ((n >= 1024)); then
        awk -v n="$n" 'BEGIN { printf "%.1fKB", n/1024 }'
    else
        echo "${n}B"
    fi
}

while [[ $# -gt 0 ]]; do
    case "$1" in
        -h | --help) usage 0 ;;
        --name)
            GAME_NAME="${2:-}"
            shift 2
            ;;
        --threshold)
            THRESHOLD="${2:-}"
            shift 2
            ;;
        --new)
            FORCE_NEW=1
            shift
            ;;
        --no-lfs)
            NO_LFS=1
            shift
            ;;
        --no-push)
            NO_PUSH=1
            shift
            ;;
        --no-index)
            NO_INDEX=1
            shift
            ;;
        --dry-run)
            DRY_RUN=1
            shift
            ;;
        --message)
            COMMIT_MSG="${2:-}"
            shift 2
            ;;
        --)
            shift
            break
            ;;
        -*)
            die "未知选项: $1"
            ;;
        *)
            if [[ -n "$SRC_DIR" ]]; then
                die "只能传入一个文件夹"
            fi
            SRC_DIR="$1"
            shift
            ;;
    esac
done

[[ -n "$SRC_DIR" ]] || usage 1

cd "$REPO_ROOT"
git rev-parse --is-inside-work-tree >/dev/null 2>&1 || die "请在 DataTable 仓库里运行"
[[ "$(git rev-parse --show-toplevel)" == "$REPO_ROOT" ]] || die "脚本必须放在仓库根目录"

SRC_DIR="$(cd "$SRC_DIR" && pwd)"
[[ -d "$SRC_DIR" ]] || die "不是文件夹: $SRC_DIR"
GAME_NAME="${GAME_NAME:-$(basename "$SRC_DIR")}"
[[ "$GAME_NAME" =~ ^[A-Za-z0-9._⁄/-]+$ ]] || die "游戏名不合法: $GAME_NAME"
BRANCH="${BRANCH_PREFIX}${GAME_NAME}"
THRESHOLD_BYTES="$(parse_size "$THRESHOLD")"
HARD_BYTES="$(parse_size "$GITHUB_HARD")"

RSYNC_EXCLUDES=(
    --exclude ".git"
    --exclude ".git/"
    --exclude "__pycache__/"
    --exclude "*.py[cod]"
    --exclude "snapshot-game.sh"
    --exclude "Assets/"
    --exclude "Painting/"
    --exclude "Paintings/"
    --exclude "Zips/"
    --exclude "ZipsSilent/"
    --exclude "ZipsLang/"
    --exclude "Usms/"
    --exclude "Bytecode/"
)

require_cmd() {
    command -v "$1" >/dev/null 2>&1 || die "缺少命令: $1"
}

fetch_branch() {
    if git show-ref --verify --quiet "refs/heads/$BRANCH"; then
        return
    fi
    if git ls-remote --exit-code origin "refs/heads/$BRANCH" >/dev/null 2>&1; then
        git fetch origin "$BRANCH:$BRANCH"
    fi
}

list_large_files() {
    local root="$1"
    find "$root" -type f -print0 | while IFS= read -r -d '' f; do
        local rel="${f#"$root"/}"
        case "$rel" in
            .git/* | __pycache__/* | Assets/* | Painting/* | Paintings/* | Zips/* | ZipsSilent/* | ZipsLang/* | Usms/* | Bytecode/*)
                continue
                ;;
        esac
        [[ "$(basename "$f")" == "snapshot-game.sh" ]] && continue
        local sz
        sz="$(stat -c '%s' "$f")"
        if ((sz >= THRESHOLD_BYTES)); then
            printf '%s\t%s\n' "$sz" "$rel"
        fi
    done
}

track_large_files() {
    local dest="$1"
    local list="$2"

    if [[ ! -s "$list" ]]; then
        log "没有超过 ${THRESHOLD} 的文件，跳过 LFS"
        return
    fi

    if [[ "$NO_LFS" -eq 1 ]]; then
        while IFS=$'\t' read -r sz rel; do
            [[ -n "$rel" ]] || continue
            if ((sz >= HARD_BYTES)); then
                die "$rel 有 $(human_size "$sz")，超过 GitHub 100MB 限制，不能加 --no-lfs"
            fi
        done <"$list"
        log "已指定 --no-lfs，大文件将按普通 blob 提交"
        return
    fi

    require_cmd git-lfs
    if [[ "$DRY_RUN" -eq 1 ]]; then
        log "dry-run: git lfs track 下列文件"
        return
    fi

    git -C "$dest" lfs install --local >/dev/null
    while IFS=$'\t' read -r sz rel; do
        [[ -n "$rel" ]] || continue
        log "  LFS  $(human_size "$sz")  $rel"
        git -C "$dest" lfs track --filename -- "$rel" >/dev/null
    done <"$list"
}

insert_readme_row() {
    local name="$1"
    python3 - "$REPO_ROOT/README.md" "$name" <<'PY'
import pathlib
import sys

readme = pathlib.Path(sys.argv[1])
name = sys.argv[2]
row = f"| `game/{name}` | {name} |\n"
text = readme.read_text(encoding="utf-8")
if row in text:
    raise SystemExit(0)
lines = text.splitlines(True)
out = []
inserted = False
for line in lines:
    if (
        not inserted
        and line.startswith("| `game/")
        and line[len("| `game/") :].split("`", 1)[0] > name
    ):
        out.append(row)
        inserted = True
    out.append(line)
if not inserted:
    for i in range(len(out) - 1, -1, -1):
        if out[i].startswith("| `game/"):
            out.insert(i + 1, row)
            inserted = True
            break
if not inserted:
    raise SystemExit("README 里找不到分支表格")
readme.write_text("".join(out), encoding="utf-8")
raise SystemExit(2)
PY
}

sync_tree() {
    local src="$1"
    local dest="$2"
    local saved_attr=""
    require_cmd rsync
    if [[ -f "$dest/.gitattributes" ]]; then
        saved_attr="$(mktemp)"
        cp -a "$dest/.gitattributes" "$saved_attr"
    fi
    rsync -a --delete "${RSYNC_EXCLUDES[@]}" "$src/" "$dest/"
    cp -a "$REPO_ROOT/.gitignore" "$dest/.gitignore"
    if [[ -n "$saved_attr" ]]; then
        cp -a "$saved_attr" "$dest/.gitattributes"
        rm -f "$saved_attr"
    elif [[ ! -f "$dest/.gitattributes" ]]; then
        : >"$dest/.gitattributes"
    fi
    rm -f "$dest/README.md"
}

commit_tree() {
    local dest="$1"
    local msg="$2"
    git -C "$dest" add -A
    if git -C "$dest" diff --cached --quiet; then
        log "分支 ${BRANCH} 没有变更"
        return 1
    fi
    if [[ "$DRY_RUN" -eq 1 ]]; then
        log "dry-run: 提交 ${msg}"
        git -C "$dest" reset -q
        return 0
    fi
    git -C "$dest" commit -m "$msg"
}

push_branch() {
    local dest="$1"
    local ref="$2"
    [[ "$NO_PUSH" -eq 1 ]] && return
    if [[ "$DRY_RUN" -eq 1 ]]; then
        log "dry-run: 推送 ${ref}"
        return
    fi
    git -C "$dest" push -u origin "$ref"
}

update_index() {
    [[ "$NO_INDEX" -eq 1 ]] && return
    local code=0
    insert_readme_row "$GAME_NAME" || code=$?
    if [[ "$code" -eq 0 ]]; then
        log "README 已有 ${GAME_NAME}"
        return
    fi
    [[ "$code" -eq 2 ]] || die "更新 README 失败"
    if [[ "$DRY_RUN" -eq 1 ]]; then
        git -C "$REPO_ROOT" checkout -- README.md
        log "dry-run: 写入 README 索引 ${GAME_NAME}"
        return
    fi
    git -C "$REPO_ROOT" add README.md
    if git -C "$REPO_ROOT" diff --cached --quiet; then
        return
    fi
    git -C "$REPO_ROOT" commit -m "在索引里加上 ${GAME_NAME} 的独立快照分支。"
    [[ "$NO_PUSH" -eq 1 ]] || git -C "$REPO_ROOT" push origin HEAD
}

current="$(git -C "$REPO_ROOT" branch --show-current)"
[[ "$current" == "master" || "$current" == "main" ]] || die "请先切到 master 再发布（当前: ${current}）"

require_cmd git
require_cmd python3
require_cmd find
[[ "$NO_LFS" -eq 1 ]] || require_cmd git-lfs

EXISTS=0
git show-ref --verify --quiet "refs/heads/$BRANCH" && EXISTS=1
git show-ref --verify --quiet "refs/remotes/origin/$BRANCH" && EXISTS=1
if [[ "$EXISTS" -eq 0 ]]; then
    git ls-remote --exit-code origin "refs/heads/$BRANCH" >/dev/null 2>&1 && EXISTS=1 || true
fi

if [[ "$EXISTS" -eq 1 && "$FORCE_NEW" -eq 1 ]]; then
    die "分支 ${BRANCH} 已存在。已有分支请直接更新；重建孤儿快照需要先手动删掉该分支。"
fi

MODE="create"
[[ "$EXISTS" -eq 1 ]] && MODE="update"
if [[ "$FORCE_NEW" -eq 1 ]]; then
    MODE="create"
fi

if [[ -z "$COMMIT_MSG" ]]; then
    if [[ "$MODE" == "create" ]]; then
        COMMIT_MSG="Snapshot of ${GAME_NAME}"
    else
        COMMIT_MSG="Update ${GAME_NAME} snapshot"
    fi
fi

log "游戏 ${GAME_NAME}"
log "来源 ${SRC_DIR}"
log "模式 ${MODE} -> ${BRANCH}"
log "LFS 阈值 ${THRESHOLD} ($(human_size "$THRESHOLD_BYTES"))"

LARGE_LIST="$(mktemp)"
list_large_files "$SRC_DIR" | sort -t $'\t' -k2 >"$LARGE_LIST"
if [[ -s "$LARGE_LIST" ]]; then
    log "将走 Git LFS 的文件:"
    while IFS=$'\t' read -r sz rel; do
        log "  $(human_size "$sz")  $rel"
    done <"$LARGE_LIST"
fi

WT="$(mktemp -d "${TMPDIR:-/tmp}/datatable-${GAME_NAME}.XXXXXX")"
cleanup() {
    if git -C "$REPO_ROOT" worktree list --porcelain 2>/dev/null | grep -Fq "worktree $WT"; then
        git -C "$REPO_ROOT" worktree remove --force "$WT" >/dev/null 2>&1 || true
    fi
    rm -rf "$WT"
    rm -f "$LARGE_LIST"
}
trap cleanup EXIT

if [[ "$MODE" == "create" ]]; then
    git -C "$REPO_ROOT" worktree add --orphan -b "$BRANCH" "$WT"
else
    fetch_branch
    git -C "$REPO_ROOT" worktree add "$WT" "$BRANCH"
fi

if [[ "$DRY_RUN" -eq 1 ]]; then
    log "dry-run: 同步 ${SRC_DIR} -> ${WT}"
    track_large_files "$WT" "$LARGE_LIST"
else
    sync_tree "$SRC_DIR" "$WT"
    track_large_files "$WT" "$LARGE_LIST"
fi

commit_tree "$WT" "$COMMIT_MSG" || true
push_branch "$WT" "$BRANCH"
update_index

log "完成。克隆:"
log "  git clone -b ${BRANCH} --single-branch --depth 1 https://github.com/PackageInstaller/DataTable.git"
if [[ -s "$LARGE_LIST" && "$NO_LFS" -eq 0 ]]; then
    log "大文件由 Git LFS 拉取，请先安装 git-lfs。"
fi
