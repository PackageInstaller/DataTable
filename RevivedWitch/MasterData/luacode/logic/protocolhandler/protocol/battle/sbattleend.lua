-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/protocolhandler/protocol/battle/sbattleend.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CBattleInfoTable = (BeanManager.GetTableByName)("battle.cbattleinfo")
local CSceneinfoStatic = (BeanManager.GetTableByName)("scene.csceneinfostatic")
local BattleEndType = (BattleClientProtocolManager.GetBeanDef)("data.battleendtype")
local CBattleStartProtocol = require("protocols.def.protocol.battle.cbattlestart")
local p1 = function(protocol)
  -- function num : 0_0 , upvalues : CBattleStartProtocol, _ENV, CBattleInfoTable, CSceneinfoStatic
  do
    -- DECOMPILER ERROR at PC12: Unhandled construct in 'MakeBoolean' P1

    if protocol.battleType ~= CBattleStartProtocol.TOWER or protocol.playerExp > 0 then
      local level = ((NekoData.BehaviorManager).BM_Game):GetUserLevel()
      ;
      ((NekoData.DataManager).DM_Game):AddPlayerExp(protocol.playerExp)
      ;
      (LuaNotificationCenter.PostNotification)(Common.n_PlayerExpChanged, nil, nil)
      if level ~= ((NekoData.BehaviorManager).BM_Game):GetUserLevel() then
        (SdkManager.Report)("LevelUp")
      end
    end
    local info = {}
    for k,v in pairs(protocol) do
      info[k] = v
    end
    ;
    ((NekoData.DataManager).DM_SBattleEnd):OnSBattleEnd(info)
    ;
    ((NekoData.DataManager).DM_AllRoles):OnSBattleEnd(protocol)
    local record = CBattleInfoTable:GetRecorder((info.battleResult).battleId)
    LogInfoFormat("sbattleend", "--------- battleType = %s, battleid = %s, result = %s, failTimes = %s --------", info.battleType, (info.battleResult).battleId, (info.battleResult).result, (info.battleResult).failTime)
    if record then
      local controller = nil
      if (info.battleResult).battleId == 1122 or protocol.battleType == CBattleStartProtocol.RESOURCE or protocol.battleType == CBattleStartProtocol.STARRY or protocol.battleType == CBattleStartProtocol.UNDECIDEDROAD or protocol.battleType == CBattleStartProtocol.CHRISTMAS or protocol.battleType == CBattleStartProtocol.SPRING_FESTIVAL or protocol.battleType == CBattleStartProtocol.LOVER or protocol.battleType == CBattleStartProtocol.PARTY_BOSS then
        controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).BossBattle)
      else
        if protocol.battleType == CBattleStartProtocol.SUMMER or protocol.battleType == CBattleStartProtocol.SUMMER_ECHO or protocol.battleType == CBattleStartProtocol.ANNIVERSARY or protocol.battleType == CBattleStartProtocol.STARRY_MIRROR then
          local battleSceneID = (((NekoData.BehaviorManager).BM_SBattleStart):GetProtocol()).battleSceneId
          local loadType = (CSceneinfoStatic:GetRecorder(battleSceneID)).loadType
          if loadType == 2 then
            controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeonBattle)
          else
            if loadType == 3 then
              controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).BossBattle)
            end
          end
        else
          do
            controller = (SceneManager.GetSceneControllerByLoadType)((SceneManager.LoadType).CommonDungeonBattle)
            if controller then
              do
                do
                  if controller.OnSBattleEndProtocol then
                    local reconnectTag = false
                    if ((NekoData.BehaviorManager).BM_Login):IfCanUseLocalCBattleEnd(((NekoData.BehaviorManager).BM_SBattleStart):GetProtocol()) then
                      (controller._bsc_battleFSM):SetBoolean("battleLogicEnd", true)
                      ;
                      (controller._bsc_battleFSM):SetNumber("battleResult", ((NekoData.BehaviorManager).BM_Login):GetCBattleEndType())
                      ;
                      ((NekoData.DataManager).DM_Login):SetCBattleEndInfo(nil)
                      reconnectTag = true
                    end
                    controller:OnSBattleEndProtocol(info, reconnectTag)
                  end
                  ;
                  (controller._bsc_battleFSM):SetNumber("battleType", protocol.battleType)
                  LogError("SBattleEnd", "战斗场景已经不存在")
                  LogError("SBattleEnd", "战斗id不存在")
                end
              end
            end
          end
        end
      end
    end
  end
end

local p2 = function(protocol, client)
  -- function num : 0_1
end

return {p1, p2}

