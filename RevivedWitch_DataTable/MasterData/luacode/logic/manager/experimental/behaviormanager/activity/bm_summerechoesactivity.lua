-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/manager/experimental/behaviormanager/activity/bm_summerechoesactivity.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CSRLand = (BeanManager.GetTableByName)("activity.csrland")
local CSRFunction = (BeanManager.GetTableByName)("activity.csrfunction")
local CSRChallengeBattle = (BeanManager.GetTableByName)("activity.csrchallengebattle")
local CSummerEchoEventDef = require("protocols.def.protocol.activity.csummerechoevent")
local BM_SummerEchoesActivity = class("BM_SummerEchoesActivity")
BM_SummerEchoesActivity.Ctor = function(self)
  -- function num : 0_0 , upvalues : _ENV
  self._data = ((NekoData.Data).activities).summerechoesActivity
end

BM_SummerEchoesActivity.OnBlockClick = function(self, id)
  -- function num : 0_1 , upvalues : _ENV, CSRLand, CSRFunction, CSummerEchoEventDef
  if id == 0 or (DialogManager.GetDialog)("dungeon.battlecrossdialog") then
    return 
  end
  local recorder = CSRLand:GetRecorder(id)
  if not recorder then
    LogErrorFormat("BM_SummerEchoesActivity", "CSRLand Can`t Find ID %s", id)
  end
  local eventIds, locked, autoExplore = nil, nil, nil
  for _,v in ipairs((self._data).constructions) do
    if v.ID == id then
      eventIds = v.event
      locked = v.locked
      autoExplore = v.autoExplore
      break
    end
  end
  do
    LogErrorFormat("BM_SummerEchoesActivity", "Block EventID = %s", (table.concat)(eventIds, ", "))
    if #eventIds < 1 then
      return 
    end
    local type = (CSRFunction:GetRecorder(eventIds[1])).type
    if type == CSummerEchoEventDef.MAINLINE_DRAMA then
      local dialog = (DialogManager.CreateSingletonDialog)("activity.swimsuitechoes.swimsuitstorymiandialog")
      dialog:SetData({functionID = eventIds[1], constructionID = id})
    else
      do
        if type == CSummerEchoEventDef.MAINLINE_BATTLE then
          local dialog = (DialogManager.CreateSingletonDialog)("activity.swimsuitechoes.swimsuitstorybattledialog")
          dialog:SetData({functionID = eventIds[1], constructionID = id})
        else
          do
            if type == CSummerEchoEventDef.FREEDOM_BATTLE then
              local dialog = (DialogManager.CreateSingletonDialog)("activity.swimsuitechoes.swimsuitbattledialog")
              dialog:SetData({functionIDs = eventIds, constructionID = id, locked = locked, autoExplore = autoExplore})
            else
              do
                -- DECOMPILER ERROR at PC103: Confused about usage of register: R7 in 'UnsetPending'

                if type == CSummerEchoEventDef.SHOP then
                  (self._data).shopAdditionData = {functionIDs = eventIds, constructionID = id}
                  local csend = (LuaNetManager.CreateProtocol)("protocol.activity.csummerechoevent")
                  if csend then
                    csend.constructionID = id
                    csend.eventID = eventIds[1]
                    csend:Send()
                  end
                else
                  do
                    if type == 5 then
                      self:SendCOpenEchoSnack()
                      local dialog = (DialogManager.CreateSingletonDialog)("activity.swimsuitechoes.swimsuitfoodstallsdialog")
                      if dialog then
                        dialog:Init()
                      end
                    else
                      do
                        if type == 6 then
                          if ((NekoData.BehaviorManager).BM_Game):GetLocalTipsState((DataCommon.LocalTips).SummerEchoesChallengeFirstOpen) == ((DataCommon.LocalTips).SummerEchoesChallengeFirstOpen).Default then
                            local dialog = (DialogManager.CreateSingletonDialog)("npcchat.newnpcchatdialog")
                            if dialog then
                              dialog:SetDialogLibraryId((CSRFunction:GetRecorder(eventIds[1])).sectionID, false, (dialog.DialogType).SummerEchoes)
                            end
                          else
                            do
                              if (self._data).eventList then
                                self:OpenEventListDialog()
                              else
                                local dialog = (DialogManager.CreateSingletonDialog)("activity.swimsuitechoes.challenge.maindialog")
                                if dialog then
                                  dialog:Init()
                                end
                              end
                            end
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end

BM_SummerEchoesActivity.OpenEventListDialog = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("activity.swimsuitechoes.challenge.eventlistdialog")
end

BM_SummerEchoesActivity.GetConstructions = function(self)
  -- function num : 0_3
  return (self._data).constructions
end

BM_SummerEchoesActivity.GetShopAdditionData = function(self)
  -- function num : 0_4
  return (self._data).shopAdditionData
end

BM_SummerEchoesActivity.HasFinishBlockBattle = function(self, id, eventID)
  -- function num : 0_5 , upvalues : _ENV
  for _,v in ipairs((self._data).constructions) do
    if id == v.ID then
      return (table.contain)(v.autoExplore, eventID)
    end
  end
end

BM_SummerEchoesActivity.GetIsOpen = function(self)
  -- function num : 0_6 , upvalues : _ENV
  return ((NekoData.BehaviorManager).BM_Activity):IsActivityOpenById(161)
end

BM_SummerEchoesActivity.GetFreeRedDot = function(self)
  -- function num : 0_7
  return (self._data).freeReddot
end

BM_SummerEchoesActivity.KillFreeRedDot = function(self)
  -- function num : 0_8
  -- DECOMPILER ERROR at PC1: Confused about usage of register: R1 in 'UnsetPending'

  (self._data).freeReddot = false
end

BM_SummerEchoesActivity.HaveRedDot = function(self)
  -- function num : 0_9
  if (self._data).freeReddot then
    return self:GetSnacRedpoint()
  end
end

BM_SummerEchoesActivity.EntranceRedDot = function(self)
  -- function num : 0_10
  if not self:GetIsOpen() then
    return false
  end
  if self:HasAwardRedDot() then
    return true
  end
  return self:GetSnacRedpoint()
end

BM_SummerEchoesActivity.ShowRedDot = function(self)
  -- function num : 0_11
  if not self:GetIsOpen() then
    return false
  end
  if self:HasAwardRedDot() then
    return true
  end
  if self:GetFreeRedDot() then
    return true
  end
  return self:GetSnacRedpoint()
end

BM_SummerEchoesActivity.BlockHasEvent = function(self, id)
  -- function num : 0_12 , upvalues : _ENV
  for _,v in ipairs((self._data).constructions) do
    -- DECOMPILER ERROR at PC17: Unhandled construct in 'MakeBoolean' P1

    if v.event and #v.event <= 0 then
      do
        do return v.ID ~= id end
        -- DECOMPILER ERROR at PC18: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC18: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

BM_SummerEchoesActivity.GetSnackData = function(self)
  -- function num : 0_13
  return (self._data).foodStallsData
end

BM_SummerEchoesActivity.GetSnacRedpoint = function(self)
  -- function num : 0_14 , upvalues : _ENV
  if (self._data).snackRedpoint ~= 1 then
    do return next((self._data).foodStallsData) ~= nil end
    do return ((self._data).foodStallsData).isOpen == 1 and ((self._data).foodStallsData).used == 0 end
    -- DECOMPILER ERROR: 5 unprocessed JMP targets
  end
end

BM_SummerEchoesActivity.SendCGetSummerEchoInfo = function(self)
  -- function num : 0_15 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.cgetsummerechoinfo")
  if protocol then
    protocol:Send()
  end
end

BM_SummerEchoesActivity.SendCGetShopInfo = function(self, shopId)
  -- function num : 0_16 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.shop.cgetshopinfo")
  if protocol then
    protocol.shopId = shopId
    protocol:Send()
  end
end

BM_SummerEchoesActivity.GetCSummerEchoEventDef = function(self)
  -- function num : 0_17 , upvalues : CSummerEchoEventDef
  return CSummerEchoEventDef
end

BM_SummerEchoesActivity.SendCOpenEchoSnack = function(self)
  -- function num : 0_18 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.copenechosnack")
  if protocol then
    protocol:Send()
  end
end

BM_SummerEchoesActivity.SendCHavingEchoSnack = function(self)
  -- function num : 0_19 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.chavingechosnack")
  if protocol then
    protocol:Send()
  end
end

BM_SummerEchoesActivity.SendCUpdateEchoEvent = function(self)
  -- function num : 0_20 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.cupdateechoevent")
  if protocol then
    protocol:Send()
  end
end

BM_SummerEchoesActivity.GetChallengeModeData = function(self)
  -- function num : 0_21
  return (self._data).challengeModeData
end

BM_SummerEchoesActivity.GetEventListData = function(self)
  -- function num : 0_22
  return (self._data).eventList
end

BM_SummerEchoesActivity.GetAwardList = function(self)
  -- function num : 0_23 , upvalues : _ENV
  local CSrchallengeReward = (BeanManager.GetTableByName)("activity.csrchallengereward")
  local allIds = CSrchallengeReward:GetAllIds()
  local dataList = {}
  local curNum = ((self._data).challengeModeData).totalScore or 0
  for i,j in pairs(allIds) do
    local status = 0
    local record = CSrchallengeReward:GetRecorder(j)
    if record.neededPoint <= curNum then
      status = 1
    end
    if (table.indexof)((self._data).receiveAward, j) then
      status = 2
    end
    local temp = {id = j, status = status, num = (math.min)(curNum, record.neededPoint)}
    ;
    (table.insert)(dataList, temp)
  end
  return dataList
end

BM_SummerEchoesActivity.IsChallengeBattle = function(self, battleId)
  -- function num : 0_24 , upvalues : CSRChallengeBattle
  return CSRChallengeBattle:GetRecorder(battleId)
end

BM_SummerEchoesActivity.GetStageStr = function(self, battleId)
  -- function num : 0_25 , upvalues : CSRChallengeBattle, _ENV
  local allIds = CSRChallengeBattle:GetAllIds()
  return ((NekoData.BehaviorManager).BM_Message):GetString(2172, {(table.indexof)(allIds, battleId), tostring(#allIds)})
end

BM_SummerEchoesActivity.GetBattleResult = function(self)
  -- function num : 0_26
  return (self._data).battleresult
end

BM_SummerEchoesActivity.GetAfterBattleStory = function(self, functionId)
  -- function num : 0_27 , upvalues : CSRFunction, _ENV
  local recorder = CSRFunction:GetRecorder(functionId)
  if recorder and recorder.sectionID ~= 0 then
    if recorder.type == 2 then
      return recorder.sectionID
    else
      if recorder.type == 6 and functionId == 46001605 and ((NekoData.BehaviorManager).BM_Game):GetLocalTipsState((DataCommon.LocalTips).SummerEchoesChallengeFirstVictory) == ((DataCommon.LocalTips).SummerEchoesChallengeFirstVictory).Default then
        ((NekoData.BehaviorManager).BM_Game):SetLocalTipsChecked((DataCommon.LocalTips).SummerEchoesChallengeFirstVictory)
        return recorder.sectionID
      end
    end
  end
end

BM_SummerEchoesActivity.HasAwardRedDot = function(self)
  -- function num : 0_28 , upvalues : _ENV
  local CSrchallengeReward = (BeanManager.GetTableByName)("activity.csrchallengereward")
  local allIds = CSrchallengeReward:GetAllIds()
  local dataList = {}
  local curNum = ((self._data).challengeModeData).totalScore or 0
  for i,j in pairs(allIds) do
    local record = CSrchallengeReward:GetRecorder(j)
    if record.neededPoint <= curNum and not (table.indexof)((self._data).receiveAward, j) then
      return true
    end
  end
end

return BM_SummerEchoesActivity

