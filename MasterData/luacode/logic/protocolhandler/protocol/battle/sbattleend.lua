local CBattleInfoTable = BeanManager.GetTableByName("battle.cbattleinfo")
local CSceneinfoStatic = BeanManager.GetTableByName("scene.csceneinfostatic")
local BattleEndType = BattleClientProtocolManager.GetBeanDef("data.battleendtype")
local CBattleStartProtocol = require("protocols.def.protocol.battle.cbattlestart")

local function p1(protocol)
  if protocol.battleType == CBattleStartProtocol.TOWER then
  end
  if protocol.playerExp > 0 then
    local level = NekoData.BehaviorManager.BM_Game:GetUserLevel()
    NekoData.DataManager.DM_Game:AddPlayerExp(protocol.playerExp)
    LuaNotificationCenter.PostNotification(Common.n_PlayerExpChanged, nil, nil)
    if level ~= NekoData.BehaviorManager.BM_Game:GetUserLevel() then
      SdkManager.Report("LevelUp")
    end
  end
  local info = {}
  for k, v in pairs(protocol) do
    info[k] = v
  end
  NekoData.DataManager.DM_SBattleEnd:OnSBattleEnd(info)
  NekoData.DataManager.DM_AllRoles:OnSBattleEnd(protocol)
  local record = CBattleInfoTable:GetRecorder(info.battleResult.battleId)
  LogInfoFormat("sbattleend", "--------- battleType = %s, battleid = %s, result = %s, failTimes = %s --------", info.battleType, info.battleResult.battleId, info.battleResult.result, info.battleResult.failTime)
  if record then
    local controller
    if info.battleResult.battleId == 1122 or protocol.battleType == CBattleStartProtocol.RESOURCE or protocol.battleType == CBattleStartProtocol.STARRY or protocol.battleType == CBattleStartProtocol.UNDECIDEDROAD or protocol.battleType == CBattleStartProtocol.CHRISTMAS or protocol.battleType == CBattleStartProtocol.SPRING_FESTIVAL or protocol.battleType == CBattleStartProtocol.LOVER or protocol.battleType == CBattleStartProtocol.PARTY_BOSS then
      controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.BossBattle)
    elseif protocol.battleType == CBattleStartProtocol.SUMMER or protocol.battleType == CBattleStartProtocol.SUMMER_ECHO or protocol.battleType == CBattleStartProtocol.ANNIVERSARY or protocol.battleType == CBattleStartProtocol.STARRY_MIRROR then
      local battleSceneID = NekoData.BehaviorManager.BM_SBattleStart:GetProtocol().battleSceneId
      local loadType = CSceneinfoStatic:GetRecorder(battleSceneID).loadType
      if loadType == 2 then
        controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeonBattle)
      elseif loadType == 3 then
        controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.BossBattle)
      end
    else
      controller = SceneManager.GetSceneControllerByLoadType(SceneManager.LoadType.CommonDungeonBattle)
    end
    if controller then
      if controller.OnSBattleEndProtocol then
        local reconnectTag = false
        if NekoData.BehaviorManager.BM_Login:IfCanUseLocalCBattleEnd(NekoData.BehaviorManager.BM_SBattleStart:GetProtocol()) then
          controller._bsc_battleFSM:SetBoolean("battleLogicEnd", true)
          controller._bsc_battleFSM:SetNumber("battleResult", NekoData.BehaviorManager.BM_Login:GetCBattleEndType())
          NekoData.DataManager.DM_Login:SetCBattleEndInfo(nil)
          reconnectTag = true
        end
        controller:OnSBattleEndProtocol(info, reconnectTag)
      end
      controller._bsc_battleFSM:SetNumber("battleType", protocol.battleType)
    else
      LogError("SBattleEnd", "战斗场景已经不存在")
    end
  else
    LogError("SBattleEnd", "战斗id不存在")
  end
end

local function p2(protocol, client)
end

return {p1, p2}
