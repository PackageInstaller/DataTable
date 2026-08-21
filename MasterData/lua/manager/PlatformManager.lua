local WU, DB, REF = require("Common/WindowUtil")(this)
local PB = require("Common/PbHelper")
local S = require("Common/Singleton"):Register(_ENV, "PlatformManager")
local U = require("Common/Util")
local AU = require("Common/ActorUtil")
local HU = require("common/HtmlUtil")
local m_noPopWindow, m_noPopScene, m_bPop
local m_reportData = {}
local m_checkData = {}
local m_zkData = {}
local m_bShow
local forceReset = false

function Start()
  m_bShow = false
  m_noPopWindow = {}
  m_noPopWindow.Gacha = 1
  m_noPopScene = {}
  m_noPopScene.SceneFight = 1
  m_noPopScene.SceneCartoon = 1
  m_noPopScene.ScenePatch = 1
  m_noPopScene.SceneLogin = 1
  m_bPop = true
  this:RegisterGameEvent("OnScMaasRemind", OnScMaasRemind)
  this:RegisterGameEvent("OnScZk", OnScZk)
  this:RegisterGameEvent("UI/WindowInited", OnWindowInited)
  this:RegisterGameEvent("UI/WindowUninited", OnWindowsUninited)
end

function OnWindowInited(window)
  local isZKHandled = OnZkCheckWindow()
  if not isZKHandled then
    OnCheckWindow()
  end
end

function OnWindowsUninited(window)
  if m_noPopWindow[window.name] then
    m_bPop = true
    local isZKHandled = OnZkCheckWindow()
    if not isZKHandled then
      OnCheckWindow()
    end
  end
end

function OnCheckWindow(window)
  local sceneName = WU.CurrentScene()
  if m_noPopScene[sceneName] then
    return
  end
  if window and m_noPopWindow[window.name] then
    m_bPop = false
    return
  end
  if not (#m_checkData ~= 0 and m_bPop) or m_bShow then
    return
  end
  table.sort(m_checkData, function(a, b)
    if a.remindType > b.remindType then
      return true
    else
      return false
    end
  end)
  local res = m_checkData[1]
  table.remove(m_checkData, 1)
  local bResetGame = true
  local tips = ""
  local hour = 0
  local min = 0
  if res.playTime then
    hour = math.floor(res.playTime / 3600)
  end
  if res.restTime then
    min = math.floor(res.restTime / 60)
  end
  if res.remindType == PB.enum.MaasRemindType.OnceGameRemind then
    tips = WU.GetString("Platform_GameTimeTips1", hour)
    bResetGame = false
  elseif res.remindType == PB.enum.MaasRemindType.AccumulateRemind then
    tips = WU.GetString("Platform_GameTimeTips2", hour)
    bResetGame = false
  elseif res.remindType == PB.enum.MaasRemindType.OnceGameForceRest then
    tips = WU.GetString("Platform_GameTimeTips3", hour, min)
  elseif res.remindType == PB.enum.MaasRemindType.AccumulateForceRest then
    tips = WU.GetString("Platform_GameTimeTips4", hour, min)
  elseif res.remindType == PB.enum.MaasRemindType.ForbidGoodNight then
    tips = WU.GetString("Platform_GameTimeTips5")
  elseif res.remindType == PB.enum.MaasRemindType.ForbidEveryday then
    tips = WU.GetString("Platform_GameTimeTips6")
  end
  if tips ~= "" then
    for i, v in ipairs(m_reportData) do
      local data = {}
      data.remindType = v.remindType
      this:WebSocketSendLua(CS.Restifizer.WebSocketTag.PushService, "CsMaasReportRemind", data)
    end
    m_reportData = {}
    m_bShow = true
    WU.ShowMessageOK(tips, function()
      m_bShow = false
      if bResetGame then
        CS.GameGlobal.Instance:ResetGame()
      end
    end)
  end
end

function OnZkCheckWindow(window)
  local sceneName = WU.CurrentScene()
  if m_noPopScene[sceneName] then
    return false
  end
  if window and m_noPopWindow[window.name] then
    m_bPop = false
    return false
  end
  if forceReset then
    forceReset = false
    CS.GameGlobal.Instance:ResetGame()
    return
  end
  if not (#m_zkData ~= 0 and m_bPop) or m_bShow then
    return false
  end
  local res = m_zkData[1]
  table.remove(m_zkData, 1)
  local type = res.zkType
  if type == PB.enum.ZkType.Notice then
    m_bShow = true
    WU.ShowMessageOK(res.zkMsg, function()
      m_bShow = false
      if res.zkTraceId then
        CS.Msdk.WGPlatform.Instance:WGReportPrajna(res.zkTraceId)
      end
    end)
  elseif type == PB.enum.ZkType.Ban then
    m_bShow = true
    WU.ShowMessageOK(res.zkMsg, function()
      m_bShow = false
      DB:DelayInvokeInSeconds(300, function()
        forceReset = true
        OnZkCheckWindow()
      end)
      CS.Msdk.WGPlatform.Instance:WGLogout()
      if res.zkTraceId then
        CS.Msdk.WGPlatform.Instance:WGReportPrajna(res.zkTraceId)
      end
    end)
  elseif type == PB.enum.ZkType.ForceFace then
    m_bShow = false
    CS.Msdk.WGPlatform.Instance:WGOpenFullScreenWebViewWithJson(res.zkJsonStr)
    if res.zkTraceId then
      CS.Msdk.WGPlatform.Instance:WGReportPrajna(res.zkTraceId)
    end
  end
  return true
end

function OnScMaasRemind(res)
  m_reportData[#m_reportData + 1] = res
  m_checkData[#m_checkData + 1] = res
  OnCheckWindow()
end

function OnScZk(msg)
  m_zkData[#m_zkData + 1] = msg
  OnZkCheckWindow()
end
