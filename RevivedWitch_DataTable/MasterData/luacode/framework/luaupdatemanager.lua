-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/framework/luaupdatemanager.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UpdateManagerGame = (((CS.PixelNeko).FileSystem).Update).UpdateManagerGame
local CheckLocalResStatus = (((CS.PixelNeko).FileSystem).Update).CheckLocalResStatus
local UpdateManager = (((CS.PixelNeko).FileSystem).Update).UpdateManager
local ResName_Main = (((CS.PixelNeko).FileSystem).ConstValue).ResName_Main
local LuaUpdateManager = {}
LuaUpdateManager.Init = function()
  -- function num : 0_0 , upvalues : UpdateManagerGame
  if UpdateManagerGame.SetCheckLocalResPeriod then
    (UpdateManagerGame.SetCheckLocalResPeriod)(300)
  end
end

LuaUpdateManager.GetUpdateStateChecks = function()
  -- function num : 0_1 , upvalues : UpdateManager, _ENV
  local retValue = {}
  local usChecks = UpdateManager.UpdateStateChecks
  for k,v in pairs(usChecks) do
    retValue[k] = v
  end
  return retValue
end

LuaUpdateManager.GetResValidState = function()
  -- function num : 0_2 , upvalues : UpdateManager, ResName_Main, _ENV
  local retValue = {}
  if (UpdateManager.GetMainUpdateStateCheck)() then
    retValue[ResName_Main] = true
  else
    retValue[ResName_Main] = false
  end
  local usChecks = UpdateManager.UpdateStateChecks
  local mountList = ((((CS.PixelNeko).FileSystem).NekoFS).GetValidResNames)()
  for k,v in pairs(usChecks) do
    retValue[k] = false
  end
  for k,v in pairs(mountList) do
    if retValue[v] ~= nil then
      retValue[v] = true
    end
  end
  return retValue
end

LuaUpdateManager.HasInGameUpdateFSM = function(resName)
  -- function num : 0_3 , upvalues : UpdateManagerGame, _ENV
  local ingame = UpdateManagerGame.UpdateFSMsGame
  for k,v in pairs(ingame) do
    if k == resName then
      return true
    end
  end
  return false
end

LuaUpdateManager.UseEditorRes = function()
  -- function num : 0_4 , upvalues : UpdateManager
  return not (UpdateManager.GetMainUpdateStateCheck)()
end

LuaUpdateManager.OnEventUpdateManagerGameTerminated = function(self, resName)
  -- function num : 0_5 , upvalues : _ENV
  (LuaNotificationCenter.PostNotification)(Common.n_NewOverlayFSMounted, nil, resName)
end

LuaUpdateManager.CheckLocalResNewVersion = function()
  -- function num : 0_6 , upvalues : UpdateManagerGame, _ENV, CheckLocalResStatus
  if UpdateManagerGame.LocalResHasNewVersion then
    local toGame = GlobalGameFSM:GetParameter("toGame")
    if toGame and (UpdateManagerGame.LocalResHasNewVersion)() then
      ((NekoData.BehaviorManager).BM_Login):ClientLogout()
      ;
      (DialogManager.CreateSingletonDialog)("login.restartdialog")
    end
  end
  if (UpdateManagerGame.GetCheckLocalResStatus)() == CheckLocalResStatus.Success and (UpdateManagerGame.LocalResHasNewVersion)() then
    (DialogManager.CreateSingletonDialog)("login.restartdialog")
  end
end

local versionNum = function(ver)
  -- function num : 0_7 , upvalues : _ENV
  warn("ver: ", ver)
  if not ver then
    return 0
  end
  local v = (string.split)(ver or "", ".")
  return tonumber(v[1] or 0) * 10000 + tonumber(v[2] or 0) * 100 + tonumber(v[3] or 0)
end

LuaUpdateManager.HasLatestAppVersion = function()
  -- function num : 0_8 , upvalues : _ENV, versionNum
  if DataCommon.StartForceUpdateGuide then
    local localVer = ((CS.UnityEngine).Application).version
    local latestVer = (DataCommon.version_forceUpdateGuide)[(SdkManager.GetPlatform)()]
    LogInfoFormat("LuaUpdateManager.HasLatestAppVersion", "--- localVer = %s, latestVer = %s ---", localVer, latestVer)
    local localNum = versionNum(localVer)
    local latestNum = versionNum(latestVer)
    return localNum < latestNum
  end
  -- DECOMPILER ERROR: 2 unprocessed JMP targets
end

;
(UpdateManagerGame.EventUpdateManagerGameTerminated):Subscribe(LuaUpdateManager, LuaUpdateManager.OnEventUpdateManagerGameTerminated)
return LuaUpdateManager

