local M = {}

local function index_func(tbl, key)
  local value = _G[key]
  if not value then
    local file = rawget(tbl, "__file__")
    assert(nil, file .. " 没有找到：" .. key)
  else
    return value
  end
end

local BEHAVIOR_IMPORTED_FILES = {}

local function behavior_importer(file_name)
  local data = BEHAVIOR_IMPORTED_FILES[file_name]
  if data then
    return data
  end
  data = M.load_behavior_file(file_name)
  if data then
    data = data()
    BEHAVIOR_IMPORTED_FILES[file_name] = data
  end
  return data
end

local function get_behavior_env(file)
  return setmetatable({__file__ = file, import = behavior_importer}, {__index = index_func})
end

local CSLuaService = CS.Game.LuaService

function M.load_behavior_file(file)
  local ret, err
  if UNITY_EDITOR and GAME_DEBUG and not Game_AssetBundle then
    local file_path = CSLuaService.GetLuaFilePath(file)
    ret, err = loadfile(file_path, "bt", get_behavior_env(file))
  else
    local data = CSLuaService.loadBehavior(file)
    if not data or "" == data then
      Log.Error("找不到行为文件：", file)
      assert(nil)
    end
    ret, err = load(data, file, "bt", get_behavior_env(file))
  end
  if ret then
    return ret
  else
    Log.Error("加载: " .. file .. " 出错", err, debug.traceback())
  end
end

function M.load_scene_behavior(file)
  local module = M.load_behavior_file(file)()
  if not module then
    Log.Error("行为文件：" .. file .. "创建失败")
  end
  if not module._init then
    Log.Error("行为文件：" .. file .. "缺少_init函数")
  end
  local instance = module:new()
  instance.file_id = file
  return instance
end

function M.clear_all()
  UtilTable.clear_map(BEHAVIOR_IMPORTED_FILES)
end

return M
