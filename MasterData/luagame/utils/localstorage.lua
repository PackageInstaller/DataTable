local _sf = string.format
local _concat = table.concat
local UGetString = UnityEngine.PlayerPrefs.GetString
local USetString = UnityEngine.PlayerPrefs.SetString
local UGetInt = UnityEngine.PlayerPrefs.GetInt
local USetInt = UnityEngine.PlayerPrefs.SetInt
local USave = UnityEngine.PlayerPrefs.Save
local UDeleteKey = UnityEngine.PlayerPrefs.DeleteKey
local M = {}

function M:save_table(k, v, is_user)
  if is_user then
    k = k .. Global.player_uuid
  end
  local s = self:_serialize(v)
  USetString(k, s)
  USave()
end

function M:load_table(k, is_user)
  if is_user then
    k = k .. Global.player_uuid
  end
  local s = UGetString(k)
  if s then
    local c, e = load("return " .. s)
    if c then
      return c()
    end
  end
end

function M:save_string(k, v, is_user)
  if is_user then
    k = k .. Global.player_uuid
  end
  USetString(k, tostring(v))
  USave()
end

function M:load_string(k, default, is_user)
  if is_user then
    k = k .. Global.player_uuid
  end
  return UGetString(k, default)
end

function M:save_int(k, v, is_user)
  if is_user then
    k = k .. Global.player_uuid
  end
  USetInt(k, v)
  USave()
end

function M:load_int(k, default, is_user)
  if is_user then
    k = k .. Global.player_uuid
  end
  return UGetInt(k, default)
end

function M:delete_key(k, is_user)
  if is_user then
    k = k .. Global.player_uuid
  end
  UDeleteKey(k)
end

function M:_serialize(t)
  local pair = {}
  for k, v in pairs(t) do
    local tk = type(k)
    local sk = false
    if "number" == tk then
      sk = _sf("[%d]", k)
    elseif "string" == tk then
      sk = _sf("['%s']", k)
    end
    local tv = type(v)
    local sv = false
    if "number" == tv then
      sv = tostring(v)
    elseif "string" == tv then
      sv = _sf("[[%s]]", v)
    elseif "table" == tv then
      sv = self:_serialize(v)
    elseif UNITY_EDITOR then
      Log.Error("不支持的类型：", tv, "key:", k, "value:", v, debug.traceback())
    end
    if sk and sv then
      pair[#pair + 1] = _sf("%s=%s", sk, sv)
    end
  end
  return _sf("{%s}", _concat(pair, ","))
end

function M:is_use_sdk_login()
  if UNITY_EDITOR then
    return false
  end
  if GAME_RELEASE and not PUBLISH_GM then
    return true
  end
  if GAME_DEBUG then
    local v = self:load_int("_MINGZHOU_IS_USE_SDK_", 0)
    return Util.is_true(v)
  else
    local v = self:load_int("_MINGZHOU_IS_USE_SDK_", 1)
    return Util.is_true(v)
  end
end

return M
