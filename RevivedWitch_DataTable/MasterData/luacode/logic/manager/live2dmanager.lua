-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/live2dmanager.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local Live2DManager = {}
local _canUse = false
local _LocalStateName = "USE_LIVE2D"
local InitLive2DData = function()
  -- function num : 0_0 , upvalues : Live2DManager, _canUse
  if (Live2DManager.IsLive2DSelected)() == false then
    _canUse = false
    return 
  end
  _canUse = true
end

Live2DManager.IsDownloaded = function()
  -- function num : 0_1 , upvalues : _ENV
  if (LuaUpdateManager.UseEditorRes)() then
    return true
  end
  local resState = (LuaUpdateManager.GetResValidState)()
  if resState.live2d ~= nil and resState.live2d == true then
    return true
  else
    return false
  end
end

Live2DManager.IsLive2DSelected = function()
  -- function num : 0_2 , upvalues : _ENV, _LocalStateName, Live2DManager
  local state = (((CS.UnityEngine).PlayerPrefs).GetInt)(_LocalStateName)
  if state == nil or state == "" then
    return false
  end
  if state == 1 then
    if (Live2DManager.IsDownloaded)() then
      return true
    else
      ;
      (((CS.UnityEngine).PlayerPrefs).SetInt)(_LocalStateName, 2)
      return false
    end
  end
  return false
end

Live2DManager.GetLive2dState = function()
  -- function num : 0_3 , upvalues : _ENV, _LocalStateName
  local state = (((CS.UnityEngine).PlayerPrefs).GetInt)(_LocalStateName)
  if state == nil or state == "" then
    return false
  end
  do return state == 1 end
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

Live2DManager.SaveLocalSelected = function(state)
  -- function num : 0_4 , upvalues : _ENV, _LocalStateName, InitLive2DData
  (((CS.UnityEngine).PlayerPrefs).SetInt)(_LocalStateName, state)
  InitLive2DData()
end

Live2DManager.Init = function()
  -- function num : 0_5 , upvalues : InitLive2DData
  InitLive2DData()
end

Live2DManager.CanUse = function()
  -- function num : 0_6 , upvalues : _canUse
  return _canUse
end

Live2DManager.GetResName = function()
  -- function num : 0_7
  return "live2d"
end

return Live2DManager

