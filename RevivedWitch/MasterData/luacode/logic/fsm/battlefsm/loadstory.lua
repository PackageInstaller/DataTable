-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/fsm/battlefsm/loadstory.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local State = {}
local chatdialogId, battleType, battleController = nil, nil, nil
local CBattleStartProtocol = require("protocols.def.protocol.battle.cbattlestart")
local CategoryMap = {[1252] = 90, [1253] = 91}
local NewNpcChatDialog = require("logic.dialog.npcchat.newnpcchatdialog")
local TypeEnum = {
[CBattleStartProtocol.STARRY] = {bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.StarMirageManagerID), levelTable = (BeanManager.GetTableByName)("dungeonselect.cstarrymirrorlevel"), type = (DataCommon.StarMirage).Type, dialogType = 3}
, 
[CBattleStartProtocol.ANNIVERSARY] = {bm = (NekoData.BehaviorManager).BM_Anniversary, levelTable = (BeanManager.GetTableByName)("dungeonselect.canniversarylevel"), type = (DataCommon.Anniversary).Type, dialogType = 8}
, 
[CBattleStartProtocol.STARRY_MIRROR] = {bm = (NekoData.BehaviorManager).BM_StarMirageCopy, levelTable = (BeanManager.GetTableByName)("dungeonselect.cstarrymirrorlevel"), type = ((DataCommon.StarMirage1)[(DataCommon.Activities).StarMirageCopy]).Type, dialogType = 3}
, 
[CBattleStartProtocol.SUMMER_ECHO] = {bm = ((NekoData.BehaviorManager).BM_Activity):GetManager(DataCommon.SummerActivityEchoesManagerID), levelTable = (BeanManager.GetTableByName)("activity.csrfunction"), dialogType = 9}
}
local ActivityIdType = {[CBattleStartProtocol.STARRY] = (DataCommon.Activities).StarMirage, [CBattleStartProtocol.ANNIVERSARY] = (DataCommon.Activities).Anniversary, [CBattleStartProtocol.STARRY_MIRROR] = (DataCommon.Activities).StarMirageCopy}
State.OnEnter = function(controller, lastState)
  -- function num : 0_0 , upvalues : _ENV, chatdialogId, battleType, battleController, TypeEnum, CBattleStartProtocol, CategoryMap, State
  LogInfo("BattleFSM", "LoadStory Enter")
  chatdialogId = nil
  battleType = 0
  battleController = controller
  battleType = (controller._bsc_battleFSM):GetParameter("battleType")
  local type = TypeEnum[battleType]
  if type then
    local id = ((NekoData.BehaviorManager).BM_SBattleEnd):GetID()
    local result = ((NekoData.BehaviorManager).BM_SBattleEnd):GetBattleResult()
    chatdialogId = (type.bm):GetAfterBattleStory(id)
    if chatdialogId and result == 1 then
      (LuaAudioManager.StopBGM)(((NekoData.BehaviorManager).BM_Game):GetMainCityBgmID())
      ;
      (LuaAudioManager.StopBGM)(4)
      if battleType == CBattleStartProtocol.SUMMER_ECHO then
        (LuaAudioManager.PlayBGM)(DataCommon.SummerEchoesBGM)
      else
        local record = (type.levelTable):GetRecorder(id)
        if record.difficulty == (type.type).Easy then
          (LuaAudioManager.SetCategoryVolume)(CategoryMap[1253], 0)
        else
          if record.difficulty == (type.type).Hard then
            (LuaAudioManager.SetCategoryVolume)(CategoryMap[1252], 0)
          end
        end
        ;
        (LuaAudioManager.PlayBGM)(1252)
        ;
        (LuaAudioManager.PlayBGM)(1253)
      end
      do
        do
          do
            local dialog = (DialogManager.CreateSingletonDialog)("npcchat.newnpcchatdialog")
            if dialog then
              dialog:SetDialogLibraryId(chatdialogId, false, type.dialogType)
              ;
              (LuaNotificationCenter.AddObserver)(State, State.OnNPCChatEnd, Common.n_NPCChatEnd, nil)
            else
              ;
              (controller._bsc_battleFSM):SetNumber("battleType", 0)
            end
            ;
            (controller._bsc_battleFSM):SetNumber("battleType", 0)
            ;
            (controller._bsc_battleFSM):SetNumber("battleType", 0)
          end
        end
      end
    end
  end
end

State.Update = function(controller, deltaTime)
  -- function num : 0_1
end

State.OnExit = function(controller, nextState)
  -- function num : 0_2 , upvalues : _ENV, State
  LogInfo("BattleFSM", "LoadStory Exit")
  ;
  (LuaNotificationCenter.RemoveObserver)(State)
end

State.OnNPCChatEnd = function(observer, notification)
  -- function num : 0_3 , upvalues : _ENV, chatdialogId, battleType, ActivityIdType, TypeEnum, CBattleStartProtocol, battleController
  LogErrorFormat("BattleFSM", "--- chatdialogId = %s, id = %s, battleType = %s ---", chatdialogId, notification.userInfo, battleType)
  if chatdialogId and notification.userInfo == chatdialogId then
    if ActivityIdType[battleType] then
      local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.cactivitydramapassed")
      protocol.dramaType = protocol.AFTER_BATTLE
      protocol.activity = ActivityIdType[battleType]
      protocol.battleID = ((NekoData.BehaviorManager).BM_SBattleEnd):GetID()
      protocol:Send()
      local type = TypeEnum[battleType]
      local id = ((NekoData.BehaviorManager).BM_SBattleEnd):GetID()
      local record = (type.levelTable):GetRecorder(id)
      if battleType ~= CBattleStartProtocol.STARRY and record then
        (type.bm):SetLevelStatus(record.difficulty, id, ((LuaNetManager.GetBeanDef)("protocol.battle.activitybattlenode")).PASSED)
      else
        LogErrorFormat("BattleFSM", "--- id = %s ---", id)
      end
      ;
      (battleController._bsc_battleFSM):SetNumber("battleType", 0)
    else
      do
        if battleType == CBattleStartProtocol.SUMMER_ECHO then
          (battleController._bsc_battleFSM):SetNumber("battleType", 0)
        else
          LogError("data error.")
        end
      end
    end
  end
end

return State

