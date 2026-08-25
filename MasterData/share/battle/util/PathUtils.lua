local StringUtils = require("Battle.Util.StringUtils")
local PathUtils = {}

function PathUtils.GetBaseName(p)
  local name = PathUtils.GetName(p)
  local i = StringUtils.FindLast(name, ".", true)
  if i then
    do return name.sub, name, 1 end
    return name.sub, name, 1, i - 1
  else
    return name
  end
end

function PathUtils.GetDirectory(p)
  local i = StringUtils.FindLast(p, "/", true)
  if i then
    if i > 1 then
      i = i - 1
    end
    do return p.sub, p, 1 end
    return p.sub, p, 1, i
  else
    return "."
  end
end

function PathUtils.GetExtension(p)
  local i = StringUtils.FindLast(p, ".", true)
  if i then
    do return p.sub, p end
    return p.sub, p, i
  else
    return ""
  end
end

function PathUtils.GetName(p)
  local i = StringUtils.FindLast(p, "[/\\]")
  if i then
    do return p.sub, p end
    return p.sub, p, i + 1
  else
    return p
  end
end

return PathUtils
