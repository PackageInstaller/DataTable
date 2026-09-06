local Live2DManager = {}
local _canUse = false
local _LocalStateName = "USE_LIVE2D"

local function InitLive2DData()
  if Live2DManager.IsLive2DSelected() == false then
    _canUse = false
    return
  end
  _canUse = true
end

function Live2DManager.IsDownloaded()
  if LuaUpdateManager.UseEditorRes() then
    return true
  end
  local resState = LuaUpdateManager.GetResValidState()
  if resState.live2d ~= nil and resState.live2d == true then
    return true
  else
    return false
  end
end

function Live2DManager.IsLive2DSelected()
  local state = CS.UnityEngine.PlayerPrefs.GetInt(_LocalStateName)
  if state == nil or state == "" then
    return false
  end
  if state == 1 then
    if Live2DManager.IsDownloaded() then
      return true
    else
      CS.UnityEngine.PlayerPrefs.SetInt(_LocalStateName, 2)
      return false
    end
  end
  return false
end

function Live2DManager.GetLive2dState()
  local state = CS.UnityEngine.PlayerPrefs.GetInt(_LocalStateName)
  if state == nil or state == "" then
    return false
  end
  return state == 1
end

function Live2DManager.SaveLocalSelected(state)
  CS.UnityEngine.PlayerPrefs.SetInt(_LocalStateName, state)
  InitLive2DData()
end

function Live2DManager.Init()
  InitLive2DData()
end

function Live2DManager.CanUse()
  return _canUse
end

function Live2DManager.GetResName()
  return "live2d"
end

return Live2DManager
