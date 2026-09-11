#!/usr/bin/env bash
#
# snapshot-game.sh —— 把一个游戏数据文件夹发布成独立的孤儿快照分支
#
# 流程：
#   1. 在 $TMPDIR 的临时目录里组装快照（只读文件夹，不动主工作区、不切分支）
#   2. 用文件夹的内容建立 / 更新孤儿分支 game/<文件夹名>（内容放在分支根目录）并推送
#   3. 回到 master，在 README.md 索引表里按字典序插入一行（英文名，中文名留空）并推送
#   4. 删除本地文件夹
#
set -euo pipefail

if [ -t 1 ]; then
  BOLD=$'\033[1m'; CYAN=$'\033[36m'; YELLOW=$'\033[33m'; RED=$'\033[31m'; RESET=$'\033[0m'
else
  BOLD=; CYAN=; YELLOW=; RED=; RESET=
fi

info() { printf '%s==>%s %s\n' "$CYAN$BOLD" "$RESET" "$*"; }
warn() { printf '%s警告:%s %s\n' "$YELLOW$BOLD" "$RESET" "$*" >&2; }
die()  { printf '%s错误:%s %s\n' "$RED$BOLD" "$RESET" "$*" >&2; exit 1; }

usage() {
  cat <<'EOF'
把游戏数据文件夹发布成独立的孤儿快照分支。

用法:
  snapshot-game.sh [选项] <文件夹> [英文名] [中文名]

流程:
  1. 用文件夹内容建立/更新孤儿分支 game/<文件夹名>（内容放在分支根目录）
  2. 推送该分支到 origin
  3. 在 master 的 README.md 索引表里按字典序插入一行，中文名留空
  4. 推送 master
  5. 删除本地文件夹

选项:
  -k, --keep   保留本地文件夹（默认会删掉）
  -y, --yes    兼容旧用法，默认就是删，不需要这个参数
  -h, --help   显示本帮助

说明:
  - <文件夹> 相对仓库根目录解析，文件夹里被 .gitignore 排除的内容
    （例如 Assets/*、Painting/、__pycache__/）不会进快照。
  - 快照在 $TMPDIR 的临时目录里组装，README.md、.github 之类不会被带进分支。
  - 已经在 README.md 里的分支不会被重复插入索引，直接原地更新快照。
  - 推送成功之后默认删除本地文件夹，想留着就加 -k。

示例:
  snapshot-game.sh AzurLane                  # 分支 game/AzurLane，英文名 AzurLane，中文名留空
  snapshot-game.sh AzurLane AzurLane 碧蓝航线  # 顺便填上中文名
EOF
}

# ---------------------------------------------------------------- 参数解析
keep_folder=0
params=()

while [ $# -gt 0 ]; do
  case $1 in
    -y | --yes) shift ;; # 默认就会删，保留这个参数只是兼容旧用法
    -k | --keep) keep_folder=1; shift ;;
    -h | --help) usage; exit 0 ;;
    --) shift; while [ $# -gt 0 ]; do params+=("$1"); shift; done ;;
    -?*) usage >&2; die "未知选项: $1" ;;
    *) params+=("$1"); shift ;;
  esac
done

if [ "${#params[@]}" -lt 1 ] || [ "${#params[@]}" -gt 3 ]; then
  usage >&2
  exit 2
fi

folder_arg=${params[0]}
english_name=${params[1]:-}
chinese_name=${params[2]:-}

# ---------------------------------------------------------------- 环境检查
repo_root=$(git rev-parse --show-toplevel 2>/dev/null) || die "当前目录不在 git 仓库里"
repo_root=$(cd "$repo_root" && pwd -P)
cd "$repo_root"

[ -d "$folder_arg" ] || die "找不到文件夹: $folder_arg（相对仓库根目录）"
folder_abs=$(cd "$folder_arg" && pwd -P)

[ "$folder_abs" != "$repo_root" ] || die "不能把仓库根目录当成游戏文件夹"
case $folder_abs in
  "$repo_root"/*) ;;
  *) die "文件夹必须在仓库 $repo_root 里面: $folder_abs" ;;
esac

folder_rel=${folder_abs#"$repo_root"/}
folder_name=${folder_rel##*/}
branch="game/$folder_name"
[ -n "$english_name" ] || english_name=$folder_name

[ -n "$(ls -A "$folder_abs")" ] || die "$folder_rel 是空文件夹"

current_branch=$(git symbolic-ref -q --short HEAD || true)
[ "$current_branch" = master ] || die "请先切回 master 再执行（当前分支: ${current_branch:-detached HEAD}）"

if ! git diff --quiet -- README.md || ! git diff --cached --quiet -- README.md; then
  die "README.md 有未提交的改动，请先处理"
fi
if ! git diff --quiet; then
  warn "工作区还有其他未提交的改动，本脚本只提交 README.md，不管其他文件"
fi

if [ -e "$folder_abs/.git" ]; then
  die "$folder_rel 里有嵌套的 .git，git 会把它记成 gitlink，请先处理"
fi

if [ -n "$(git ls-files -- "$folder_rel")" ]; then
  die "$folder_rel 已被 master 跟踪，请先把这些文件从 master 移除"
fi

# ------------------------------------------------------------ 与远端同步
info "更新 origin/master ..."
git fetch --quiet origin master
if git rev-parse -q --verify refs/remotes/origin/master >/dev/null; then
  git merge-base --is-ancestor refs/remotes/origin/master master ||
    die "本地 master 落后于 origin/master，请先 git pull --ff-only"
fi

remote_has_branch=0
if git ls-remote --exit-code --heads origin "refs/heads/$branch" >/dev/null 2>&1; then
  remote_has_branch=1
  info "分支 $branch 已存在，这次是更新快照"
  git fetch --quiet origin "refs/heads/$branch:refs/remotes/origin/$branch"
fi

parent=
if [ "$remote_has_branch" = 1 ]; then
  parent=$(git rev-parse "refs/remotes/origin/$branch")
fi

if git show-ref --verify --quiet "refs/heads/$branch"; then
  local_tip=$(git rev-parse "refs/heads/$branch")
  if [ -n "$parent" ] && [ "$local_tip" != "$parent" ] &&
     ! git merge-base --is-ancestor "$local_tip" "$parent"; then
    die "本地分支 $branch 有未推送的提交，先确认一下（要丢弃就 git branch -D $branch）"
  fi
  [ -n "$parent" ] || parent=$local_tip
fi

readme_has_row=0
if grep -qF "| \`$branch\` |" README.md; then
  readme_has_row=1
  info "README.md 里已经有 $branch 的索引，稍后跳过索引更新"
fi

# ---------------------------------------------------------------- 生成快照
work=$(mktemp -d "${TMPDIR:-/tmp}/snapshot-game.XXXXXX")
trap 'rm -rf "$work"' EXIT

# .gitattributes：把仓库根目录里 "<文件夹>/xxx" 的规则去掉前缀后带进分支，
# 这样原来的 LFS 文件在新分支上依然是 LFS 指针；再补上文件夹自带的规则。
attrs="$work/gitattributes"
repo_attrs="$work/repo.gitattributes"
if [ -f .gitattributes ]; then
  cp .gitattributes "$repo_attrs"
else
  git show master:.gitattributes >"$repo_attrs" 2>/dev/null || : >"$repo_attrs"
fi
{
  awk -v prefix="$folder_name/" 'index($0, prefix) == 1 { print substr($0, length(prefix) + 1) }' "$repo_attrs"
  if [ -f "$folder_abs/.gitattributes" ]; then cat "$folder_abs/.gitattributes"; fi
} | awk '!seen[$0]++' >"$attrs"

# .gitignore：沿用仓库的规则（仓库里没有就退回 master 的版本），
# 这些规则同时用于挑文件，所以 Assets/*、Painting/ 之类不会进快照。
ignore="$work/gitignore"
if [ -f .gitignore ]; then
  cp .gitignore "$ignore"
else
  git show master:.gitignore >"$ignore" 2>/dev/null || : >"$ignore"
fi

idx="$work/index"
info "在临时目录里组装快照（只读 $folder_rel）"
(
  cd "$folder_abs"
  GIT_INDEX_FILE="$idx" git \
    -c core.attributesFile="$attrs" \
    -c core.excludesFile="$ignore" \
    --work-tree="$folder_abs" \
    add -A -- .
)

attrs_blob=$(git hash-object -w --stdin <"$attrs")
ignore_blob=$(git hash-object -w --stdin <"$ignore")
GIT_INDEX_FILE="$idx" git update-index --add --cacheinfo "100644,$attrs_blob,.gitattributes"
GIT_INDEX_FILE="$idx" git update-index --add --cacheinfo "100644,$ignore_blob,.gitignore"

tree=$(GIT_INDEX_FILE="$idx" git write-tree)

files=$(git ls-tree -r --name-only "$tree" | wc -l)
[ "$files" -gt 0 ] || die "快照里没有任何文件，检查一下 $folder_rel 是不是被 .gitignore 排除了"
gitlinks=$(git ls-tree -r "$tree" | awk '$1 == "160000" { print $4 }')
if [ -n "$gitlinks" ]; then
  die "快照里有嵌套仓库（gitlink），请先处理: $gitlinks"
fi

# 双保险：快照顶层只允许出现文件夹里的东西 + 本脚本生成的两个文件，
# 防止 master 上的 README.md、.github 之类被顺手带进分支。
allowed=$(
  {
    (cd "$folder_abs" && ls -A)
    printf '%s\n' .gitattributes .gitignore
  } | LC_ALL=C sort -u
)
stray=$(comm -23 <(git ls-tree --name-only "$tree" | LC_ALL=C sort) <(printf '%s\n' "$allowed"))
if [ -n "$stray" ]; then
  die "快照里出现了 $folder_rel 之外的条目: $stray"
fi

if [ -n "$parent" ]; then
  message="Update $folder_name snapshot"
  commit=$(git commit-tree "$tree" -p "$parent" -m "$message")
else
  message="Snapshot of $folder_name"
  commit=$(git commit-tree "$tree" -m "$message")
fi

info "推送 $branch（$files 个文件，$message）"
git push origin "$commit:refs/heads/$branch"
git update-ref "refs/heads/$branch" "$commit"
git branch --quiet --set-upstream-to="origin/$branch" "$branch" || true

# ------------------------------------------------------------ README 索引
readme_updated=0
if [ "$readme_has_row" = 0 ]; then
  row="| \`$branch\` | $english_name | $chinese_name |"

  first=$(grep -n '^| `game/' README.md | head -n1 | cut -d: -f1 || true)
  last=$(grep -n '^| `game/' README.md | tail -n1 | cut -d: -f1 || true)
  if [ -z "$first" ]; then
    printf '\n| 分支 | 游戏 | 中文名 |\n|---|---|---|\n%s\n' "$row" >>README.md
  else
    {
      head -n "$((first - 1))" README.md
      { sed -n "${first},${last}p" README.md; printf '%s\n' "$row"; } | LC_ALL=C sort
      tail -n "+$((last + 1))" README.md
    } >"$work/README.md"
    cp "$work/README.md" README.md
  fi

  info "更新索引: $row"
  git commit --quiet -m "在索引里加上 $english_name 的独立快照分支。" -- README.md
  info "推送 master"
  git push --quiet origin master
  readme_updated=1
else
  info "README.md 已包含该分支的索引，跳过"
fi

# ---------------------------------------------------------------- 删除文件夹
if [ "$keep_folder" = 1 ]; then
  info "按 --keep 保留本地文件夹: $folder_rel"
else
  case $folder_abs in
    "" | / | "$repo_root" | "$repo_root"/) die "拒绝删除可疑路径: $folder_abs" ;;
  esac
  case $folder_abs in
    "$repo_root"/*) ;;
    *) die "拒绝删除仓库外的路径: $folder_abs" ;;
  esac
  [ -d "$folder_abs" ] || die "要删除的文件夹不见了: $folder_abs"
  info "删除本地文件夹: $folder_rel"
  rm -rf -- "$folder_abs"
fi

echo
if [ "$readme_updated" = 1 ]; then
  info "完成：分支 $branch 已推送，README.md 索引已更新"
else
  info "完成：分支 $branch 已推送（README.md 索引里本来就有）"
fi
echo "  拉取单个游戏: git clone -b $branch --single-branch --depth 1 https://github.com/PackageInstaller/DataTable.git"
if [ -z "$chinese_name" ]; then
  echo "  提示：索引行 | \`$branch\` | $english_name |  | 的中文名是空的，记得之后补上"
fi
