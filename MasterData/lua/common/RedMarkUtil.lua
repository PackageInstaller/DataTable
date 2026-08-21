local RU = {}
local m_wrapperCache = setmetatable({}, {__mode = "v"})

function RU.BindRedMark(db, path, callback, ignores)
  local splitPath = string.split(NormalizedPath(path), "/")
  local dbPath = "RedMark/" .. splitPath[1]
  ignores = NormalizedPath(ignores)
  local wrapper
  if m_wrapperCache[db] and m_wrapperCache[db][path] then
    wrapper = m_wrapperCache[db][path]
  else
    function wrapper(mark)
      callback(GetRedMark(mark, path, ignores))
    end
  end
  m_wrapperCache[db] = m_wrapperCache[db] or {}
  m_wrapperCache[db][path] = wrapper
  db:Bind(dbPath, wrapper)
end

function RU.UnbindRedMark(db, path)
  local splitPath = string.split(NormalizedPath(path), "/")
  local dbPath = "RedMark/" .. splitPath[1]
  if m_wrapperCache[db] and m_wrapperCache[db][path] then
    db:Unbind(dbPath, m_wrapperCache[db][path])
  end
end

function RU.SetRedMark(path, value)
  local DB = CS.DataBindingManager.Instance
  local splitPath = string.split(NormalizedPath(path), "/")
  local dbPath = "RedMark/" .. splitPath[1]
  local mark = DB:GetData(dbPath) or {}
  DB:SetData(dbPath, SetRedMark(mark, splitPath, 1, value))
end

function RU.GetRedMark(path, ignores)
  local DB = CS.DataBindingManager.Instance
  ignores = NormalizedPath(ignores)
  local splitPath = string.split(NormalizedPath(path), "/")
  local dbPath = "RedMark/" .. splitPath[1]
  local mark = DB:GetData(dbPath) or {}
  return GetRedMark(mark, path, ignores)
end

function GetRedMark(mark, path, ignores)
  local splitPath = string.split(NormalizedPath(path), "/")
  table.remove(splitPath, 1)
  while 0 < #splitPath and mark and mark._children do
    mark = mark._children[table.remove(splitPath, 1)]
  end
  return UpdateRedMark(mark, ignores)
end

function SetRedMark(mark, splitPath, level, value)
  mark._path = NormalizedPath(table.concat(splitPath, "/", 1, level))
  if #splitPath == level then
    if mark._children ~= nil then
      warning("RedMark", "Can't set a non-leaf node")
      return
    end
    mark._root = value
  else
    if mark._root == nil then
      mark._root = false
    end
    if mark._children == nil then
      mark._children = {}
    end
    local name = splitPath[level + 1]
    mark._children[name] = mark._children[name] or {}
    SetRedMark(mark._children[name], splitPath, level + 1, value)
  end
  return mark
end

function UpdateRedMark(mark, ignores)
  if mark == nil then
    return false
  end
  if mark._children then
    for k, v in pairs(mark._children) do
      if not table.find(ignores, function(k2, v2)
        return MatchPath(v._path, v2)
      end) then
        local r = UpdateRedMark(v, ignores)
        if r then
          mark._root = true
          return mark._root
        end
      end
    end
    mark._root = false
    return mark._root
  elseif mark._root then
    return mark._root
  else
    return false
  end
end

function NormalizedPath(path)
  if type(path) == "string" then
    if string.sub(path, 1, 1) == "/" then
      path = string.sub(path, 2, #path)
    end
    if string.sub(path, -1) ~= "/" then
      path = path .. "/"
    end
  elseif type(path) == "table" then
    for i = 1, #path do
      path[i] = NormalizedPath(path[i])
    end
  end
  return path
end

function MatchPath(source, target)
  source = NormalizedPath(source)
  target = NormalizedPath(target)
  local splitSource = string.split(source, "/")
  local splitTarget = string.split(target, "/")
  if #splitSource ~= #splitTarget then
    return false
  end
  for i = 1, #splitSource do
    if splitTarget[i] ~= "?" and splitSource[i] ~= splitTarget[i] then
      return false
    end
  end
  return true
end

return RU
