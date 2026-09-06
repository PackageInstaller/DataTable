local LuaManager = CS.PixelNeko.LuaManager
local EventPointManager = CS.PixelNeko.P1.EventPoint.EventPointManager
local PrefabLoader = CS.PixelNeko.Assets.PrefabLoader
local UIBackManager = CS.PixelNeko.P1.UIBackManager
local State = {}

local function versionNum(ver)
  warn("ver: ", ver)
  if not ver then
    return 0
  end
  local v = string.split(ver or "", ".")
  return tonumber(v[1] or 0) * 10000 + tonumber(v[2] or 0) * 100 + tonumber(v[3] or 0)
end

function State.OnEnter(lastState)
  LogInfo("GameFSM", "Init Enter")
  if DataCommon.StartForceUpdate and (not SdkManager.IsOverseas and SdkManager.GetChannel() ~= "none" or SdkManager.IsOverseas and not CS.PixelNeko.P1.PackageTypeManager.IsTestPack()) then
    local localVer = CS.UnityEngine.Application.version
    local remoteVer = DataCommon.version_forceUpdate[SdkManager.GetPlatform()]
    LogInfoFormat("GameFSM.Init", "--- version = %s, updateVersion = %s ---", localVer, remoteVer)
    local localNum = versionNum(localVer)
    local remoteNum = versionNum(remoteVer)
    if localNum < remoteNum then
      DialogManager.CreateSingletonDialog("login.forceupdatedialog")
      return
    end
  end
  if GlobalGameFSM:GetParameter("loadedModalBack") == false then
    GlobalGameFSM:SetBoolean("loadedModalBack", true)
    local modalBackAB, modalBackName = EffectUtil.GetAssetBundleNameAndAssetName(1016)
    local modalBackGO = PrefabLoader.LoadAndInstantiatePrefab(modalBackAB, modalBackName)
    if modalBackGO then
      UIBackManager.Init(modalBackGO, 10, 10, 10)
    end
  end
  EventPointManager.TriggerEvent(EventPointManager.Test_GameFSMInit, CS.PixelNeko.P1.EventPoint.EventPointPlatform.UMeng)
  GameScene.LoadInGame()
  GlobalGameFSM:SetBoolean("toPalyPV", true)
end

function State.Update()
end

function State.OnExit(nextState)
  LogInfo("GameFSM", "Init Exit")
end

return State
