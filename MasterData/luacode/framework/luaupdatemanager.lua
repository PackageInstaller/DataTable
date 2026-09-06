local UpdateManagerGame = CS.PixelNeko.FileSystem.Update.UpdateManagerGame
local CheckLocalResStatus = CS.PixelNeko.FileSystem.Update.CheckLocalResStatus
local UpdateManager = CS.PixelNeko.FileSystem.Update.UpdateManager
local ResName_Main = CS.PixelNeko.FileSystem.ConstValue.ResName_Main
local LuaUpdateManager = {}

function LuaUpdateManager.Init()
  if UpdateManagerGame.SetCheckLocalResPeriod then
    UpdateManagerGame.SetCheckLocalResPeriod(300)
  end
end

function LuaUpdateManager.GetUpdateStateChecks()
  local retValue = {}
  local usChecks = UpdateManager.UpdateStateChecks
  for k, v in pairs(usChecks) do
    retValue[k] = v
  end
  return retValue
end

function LuaUpdateManager.GetResValidState()
  local retValue = {}
  if UpdateManager.GetMainUpdateStateCheck() then
    retValue[ResName_Main] = true
  else
    retValue[ResName_Main] = false
  end
  local usChecks = UpdateManager.UpdateStateChecks
  local mountList = CS.PixelNeko.FileSystem.NekoFS.GetValidResNames()
  for k, v in pairs(usChecks) do
    retValue[k] = false
  end
  for k, v in pairs(mountList) do
    if retValue[v] ~= nil then
      retValue[v] = true
    end
  end
  return retValue
end

function LuaUpdateManager.HasInGameUpdateFSM(resName)
  local ingame = UpdateManagerGame.UpdateFSMsGame
  for k, v in pairs(ingame) do
    if k == resName then
      return true
    end
  end
  return false
end

function LuaUpdateManager.UseEditorRes()
  return not UpdateManager.GetMainUpdateStateCheck()
end

function LuaUpdateManager:OnEventUpdateManagerGameTerminated(resName)
  LuaNotificationCenter.PostNotification(Common.n_NewOverlayFSMounted, nil, resName)
end

function LuaUpdateManager.CheckLocalResNewVersion()
  if UpdateManagerGame.LocalResHasNewVersion then
    local toGame = GlobalGameFSM:GetParameter("toGame")
    if toGame then
      if UpdateManagerGame.LocalResHasNewVersion() then
        NekoData.BehaviorManager.BM_Login:ClientLogout()
        DialogManager.CreateSingletonDialog("login.restartdialog")
      end
    elseif UpdateManagerGame.GetCheckLocalResStatus() == CheckLocalResStatus.Success and UpdateManagerGame.LocalResHasNewVersion() then
      DialogManager.CreateSingletonDialog("login.restartdialog")
    end
  end
end

local function versionNum(ver)
  warn("ver: ", ver)
  if not ver then
    return 0
  end
  local v = string.split(ver or "", ".")
  return tonumber(v[1] or 0) * 10000 + tonumber(v[2] or 0) * 100 + tonumber(v[3] or 0)
end

function LuaUpdateManager.HasLatestAppVersion()
  if DataCommon.StartForceUpdateGuide then
    local localVer = CS.UnityEngine.Application.version
    local latestVer = DataCommon.version_forceUpdateGuide[SdkManager.GetPlatform()]
    LogInfoFormat("LuaUpdateManager.HasLatestAppVersion", "--- localVer = %s, latestVer = %s ---", localVer, latestVer)
    local localNum = versionNum(localVer)
    local latestNum = versionNum(latestVer)
    return localNum < latestNum
  end
end

UpdateManagerGame.EventUpdateManagerGameTerminated:Subscribe(LuaUpdateManager, LuaUpdateManager.OnEventUpdateManagerGameTerminated)
return LuaUpdateManager
