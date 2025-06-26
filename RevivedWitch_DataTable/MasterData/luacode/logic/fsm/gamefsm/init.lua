-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/fsm/gamefsm/init.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local LuaManager = (CS.PixelNeko).LuaManager
local EventPointManager = (((CS.PixelNeko).P1).EventPoint).EventPointManager
local PrefabLoader = ((CS.PixelNeko).Assets).PrefabLoader
local UIBackManager = ((CS.PixelNeko).P1).UIBackManager
local State = {}
local versionNum = function(ver)
  -- function num : 0_0 , upvalues : _ENV
  warn("ver: ", ver)
  if not ver then
    return 0
  end
  local v = (string.split)(ver or "", ".")
  return tonumber(v[1] or 0) * 10000 + tonumber(v[2] or 0) * 100 + tonumber(v[3] or 0)
end

State.OnEnter = function(lastState)
  -- function num : 0_1 , upvalues : _ENV, versionNum, PrefabLoader, UIBackManager, EventPointManager
  LogInfo("GameFSM", "Init Enter")
  if (not SdkManager.IsOverseas and (SdkManager.GetChannel)() ~= "none") or SdkManager.IsOverseas and not ((((CS.PixelNeko).P1).PackageTypeManager).IsTestPack)() then
    local localVer = ((CS.UnityEngine).Application).version
    local remoteVer = (DataCommon.version_forceUpdate)[(SdkManager.GetPlatform)()]
    LogInfoFormat("GameFSM.Init", "--- version = %s, updateVersion = %s ---", localVer, remoteVer)
    local localNum = versionNum(localVer)
    local remoteNum = versionNum(remoteVer)
    if localNum < remoteNum then
      (DialogManager.CreateSingletonDialog)("login.forceupdatedialog")
      return 
    end
  end
  do
    if GlobalGameFSM:GetParameter("loadedModalBack") == false then
      GlobalGameFSM:SetBoolean("loadedModalBack", true)
      local modalBackAB, modalBackName = (EffectUtil.GetAssetBundleNameAndAssetName)(1016)
      local modalBackGO = (PrefabLoader.LoadAndInstantiatePrefab)(modalBackAB, modalBackName)
      if modalBackGO then
        (UIBackManager.Init)(modalBackGO, 10, 10, 10)
      end
    end
    do
      ;
      (EventPointManager.TriggerEvent)(EventPointManager.Test_GameFSMInit, ((((CS.PixelNeko).P1).EventPoint).EventPointPlatform).UMeng)
      ;
      (GameScene.LoadInGame)()
      GlobalGameFSM:SetBoolean("toPalyPV", true)
    end
  end
end

State.Update = function()
  -- function num : 0_2
end

State.OnExit = function(nextState)
  -- function num : 0_3 , upvalues : _ENV
  LogInfo("GameFSM", "Init Exit")
end

return State

