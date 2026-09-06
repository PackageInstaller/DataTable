local CSRLand = BeanManager.GetTableByName("activity.csrland")
local CSRFunction = BeanManager.GetTableByName("activity.csrfunction")
local CSRChallengeBattle = BeanManager.GetTableByName("activity.csrchallengebattle")
local CSummerEchoEventDef = require("protocols.def.protocol.activity.csummerechoevent")
local BM_SummerEchoesActivity = class("BM_SummerEchoesActivity")

function BM_SummerEchoesActivity:Ctor()
  self._data = NekoData.Data.activities.summerechoesActivity
end

function BM_SummerEchoesActivity:OnBlockClick(id)
  if id == 0 or DialogManager.GetDialog("dungeon.battlecrossdialog") then
    return
  end
  local recorder = CSRLand:GetRecorder(id)
  if not recorder then
    LogErrorFormat("BM_SummerEchoesActivity", "CSRLand Can`t Find ID %s", id)
  end
  local eventIds, locked, autoExplore
  for _, v in ipairs(self._data.constructions) do
    if v.ID == id then
      eventIds = v.event
      locked = v.locked
      autoExplore = v.autoExplore
      break
    end
  end
  LogErrorFormat("BM_SummerEchoesActivity", "Block EventID = %s", table.concat(eventIds, ", "))
  if #eventIds < 1 then
    return
  end
  local type = CSRFunction:GetRecorder(eventIds[1]).type
  if type == CSummerEchoEventDef.MAINLINE_DRAMA then
    local dialog = DialogManager.CreateSingletonDialog("activity.swimsuitechoes.swimsuitstorymiandialog")
    dialog:SetData({
      functionID = eventIds[1],
      constructionID = id
    })
  elseif type == CSummerEchoEventDef.MAINLINE_BATTLE then
    local dialog = DialogManager.CreateSingletonDialog("activity.swimsuitechoes.swimsuitstorybattledialog")
    dialog:SetData({
      functionID = eventIds[1],
      constructionID = id
    })
  elseif type == CSummerEchoEventDef.FREEDOM_BATTLE then
    local dialog = DialogManager.CreateSingletonDialog("activity.swimsuitechoes.swimsuitbattledialog")
    dialog:SetData({
      functionIDs = eventIds,
      constructionID = id,
      locked = locked,
      autoExplore = autoExplore
    })
  elseif type == CSummerEchoEventDef.SHOP then
    self._data.shopAdditionData = {functionIDs = eventIds, constructionID = id}
    local csend = LuaNetManager.CreateProtocol("protocol.activity.csummerechoevent")
    if csend then
      csend.constructionID = id
      csend.eventID = eventIds[1]
      csend:Send()
    end
  elseif type == 5 then
    self:SendCOpenEchoSnack()
    local dialog = DialogManager.CreateSingletonDialog("activity.swimsuitechoes.swimsuitfoodstallsdialog")
    if dialog then
      dialog:Init()
    end
  elseif type == 6 then
    if NekoData.BehaviorManager.BM_Game:GetLocalTipsState(DataCommon.LocalTips.SummerEchoesChallengeFirstOpen) == DataCommon.LocalTips.SummerEchoesChallengeFirstOpen.Default then
      local dialog = DialogManager.CreateSingletonDialog("npcchat.newnpcchatdialog")
      if dialog then
        dialog:SetDialogLibraryId(CSRFunction:GetRecorder(eventIds[1]).sectionID, false, dialog.DialogType.SummerEchoes)
      end
    elseif self._data.eventList then
      self:OpenEventListDialog()
    else
      local dialog = DialogManager.CreateSingletonDialog("activity.swimsuitechoes.challenge.maindialog")
      if dialog then
        dialog:Init()
      end
    end
  end
end

function BM_SummerEchoesActivity:OpenEventListDialog()
  DialogManager.CreateSingletonDialog("activity.swimsuitechoes.challenge.eventlistdialog")
end

function BM_SummerEchoesActivity:GetConstructions()
  return self._data.constructions
end

function BM_SummerEchoesActivity:GetShopAdditionData()
  return self._data.shopAdditionData
end

function BM_SummerEchoesActivity:HasFinishBlockBattle(id, eventID)
  for _, v in ipairs(self._data.constructions) do
    if id == v.ID then
      return table.contain(v.autoExplore, eventID)
    end
  end
end

function BM_SummerEchoesActivity:GetIsOpen()
  return NekoData.BehaviorManager.BM_Activity:IsActivityOpenById(161)
end

function BM_SummerEchoesActivity:GetFreeRedDot()
  return self._data.freeReddot
end

function BM_SummerEchoesActivity:KillFreeRedDot()
  self._data.freeReddot = false
end

function BM_SummerEchoesActivity:HaveRedDot()
  return self._data.freeReddot and self:GetSnacRedpoint()
end

function BM_SummerEchoesActivity:EntranceRedDot()
  if not self:GetIsOpen() then
    return false
  end
  if self:HasAwardRedDot() then
    return true
  end
  return self:GetSnacRedpoint()
end

function BM_SummerEchoesActivity:ShowRedDot()
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

function BM_SummerEchoesActivity:BlockHasEvent(id)
  for _, v in ipairs(self._data.constructions) do
    if v.ID == id then
      return v.event and #v.event > 0
    end
  end
end

function BM_SummerEchoesActivity:GetSnackData()
  return self._data.foodStallsData
end

function BM_SummerEchoesActivity:GetSnacRedpoint()
  if next(self._data.foodStallsData) == nil then
    return self._data.snackRedpoint == 1
  else
    return self._data.foodStallsData.isOpen == 1 and self._data.foodStallsData.used == 0
  end
end

function BM_SummerEchoesActivity:SendCGetSummerEchoInfo()
  local protocol = LuaNetManager.CreateProtocol("protocol.activity.cgetsummerechoinfo")
  if protocol then
    protocol:Send()
  end
end

function BM_SummerEchoesActivity:SendCGetShopInfo(shopId)
  local protocol = LuaNetManager.CreateProtocol("protocol.shop.cgetshopinfo")
  if protocol then
    protocol.shopId = shopId
    protocol:Send()
  end
end

function BM_SummerEchoesActivity:GetCSummerEchoEventDef()
  return CSummerEchoEventDef
end

function BM_SummerEchoesActivity:SendCOpenEchoSnack()
  local protocol = LuaNetManager.CreateProtocol("protocol.activity.copenechosnack")
  if protocol then
    protocol:Send()
  end
end

function BM_SummerEchoesActivity:SendCHavingEchoSnack()
  local protocol = LuaNetManager.CreateProtocol("protocol.activity.chavingechosnack")
  if protocol then
    protocol:Send()
  end
end

function BM_SummerEchoesActivity:SendCUpdateEchoEvent()
  local protocol = LuaNetManager.CreateProtocol("protocol.activity.cupdateechoevent")
  if protocol then
    protocol:Send()
  end
end

function BM_SummerEchoesActivity:GetChallengeModeData()
  return self._data.challengeModeData
end

function BM_SummerEchoesActivity:GetEventListData()
  return self._data.eventList
end

function BM_SummerEchoesActivity:GetAwardList()
  local CSrchallengeReward = BeanManager.GetTableByName("activity.csrchallengereward")
  local allIds = CSrchallengeReward:GetAllIds()
  local dataList = {}
  local curNum = self._data.challengeModeData.totalScore or 0
  for i, j in pairs(allIds) do
    local status = 0
    local record = CSrchallengeReward:GetRecorder(j)
    if curNum >= record.neededPoint then
      status = 1
    end
    if table.indexof(self._data.receiveAward, j) then
      status = 2
    end
    local temp = {
      id = j,
      status = status,
      num = math.min(curNum, record.neededPoint)
    }
    table.insert(dataList, temp)
  end
  return dataList
end

function BM_SummerEchoesActivity:IsChallengeBattle(battleId)
  return CSRChallengeBattle:GetRecorder(battleId)
end

function BM_SummerEchoesActivity:GetStageStr(battleId)
  local allIds = CSRChallengeBattle:GetAllIds()
  return NekoData.BehaviorManager.BM_Message:GetString(2172, {
    table.indexof(allIds, battleId),
    tostring(#allIds)
  })
end

function BM_SummerEchoesActivity:GetBattleResult()
  return self._data.battleresult
end

function BM_SummerEchoesActivity:GetAfterBattleStory(functionId)
  local recorder = CSRFunction:GetRecorder(functionId)
  if recorder and recorder.sectionID ~= 0 then
    if recorder.type == 2 then
      return recorder.sectionID
    elseif recorder.type == 6 and functionId == 46001605 and NekoData.BehaviorManager.BM_Game:GetLocalTipsState(DataCommon.LocalTips.SummerEchoesChallengeFirstVictory) == DataCommon.LocalTips.SummerEchoesChallengeFirstVictory.Default then
      NekoData.BehaviorManager.BM_Game:SetLocalTipsChecked(DataCommon.LocalTips.SummerEchoesChallengeFirstVictory)
      return recorder.sectionID
    end
  end
end

function BM_SummerEchoesActivity:HasAwardRedDot()
  local CSrchallengeReward = BeanManager.GetTableByName("activity.csrchallengereward")
  local allIds = CSrchallengeReward:GetAllIds()
  local dataList = {}
  local curNum = self._data.challengeModeData.totalScore or 0
  for i, j in pairs(allIds) do
    local record = CSrchallengeReward:GetRecorder(j)
    if curNum >= record.neededPoint and not table.indexof(self._data.receiveAward, j) then
      return true
    end
  end
end

return BM_SummerEchoesActivity
