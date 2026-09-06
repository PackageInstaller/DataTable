local BM_Christmas = class("BM_Christmas")
local CInterfaceFunction = BeanManager.GetTableByName("dungeonselect.cinterfacefunction")
local CInterEntry = BeanManager.GetTableByName("dungeonselect.cinterentry")
local CChristmasActivityEvent = require("protocols.def.protocol.activity.cchristmasactivityevent")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local Item = require("logic.manager.experimental.types.item")
local CChriscorresponding = BeanManager.GetTableByName("dungeonselect.cchriscorresponding")

function BM_Christmas:Ctor()
  self._data = NekoData.Data.activities.christmas
end

local function DoorScoreLimit(Id)
  local recorder = CInterEntry:GetRecorder(Id)
  if not recorder then
    LogErrorFormat("BM_Christmas", "CInterEntry Cannt Find ID %s", Id)
  end
  local curNum = 0
  local locklist = {}
  local limit = 0
  local islock = false
  local outStr = ""
  for i, v in ipairs(recorder.itemID) do
    local params = {}
    local currencyItem
    if v == DataCommon.ChristmasSing then
      curNum = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.ChristmasActivityManagerID):GetScoreByType(DataCommon.ChristmasSing)
      currencyItem = Item.Create(DataCommon.ChristmasSing)
    elseif v == DataCommon.ChristmasJump then
      curNum = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.ChristmasActivityManagerID):GetScoreByType(DataCommon.ChristmasJump)
      currencyItem = Item.Create(DataCommon.ChristmasJump)
    elseif v == DataCommon.ChristmasExpressiveForce then
      curNum = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.ChristmasActivityManagerID):GetScoreByType(DataCommon.ChristmasExpressiveForce)
      currencyItem = Item.Create(DataCommon.ChristmasExpressiveForce)
    else
      LogErrorFormat("BM_Christmas", "CInterEntry itemID Exist Error ItemId:%s", v)
      return false
    end
    if curNum < recorder.itemAmount[i] then
      islock = true
      table.insert(params, currencyItem:GetName())
      table.insert(params, recorder.itemAmount[i])
      local msgRecord = BeanManager.GetTableByName("message.cmessagetip"):GetRecorder(100435)
      local str = TextManager.GetText(msgRecord.msgTextID)
      if params then
        local num = 1
        for _, i in pairs(params) do
          str = string.gsub(str, "%$parameter1%$", params[num], 1)
          num = num + 1
        end
      end
      if outStr == "" then
        outStr = str
      else
        outStr = outStr .. [[


]] .. str
      end
    end
  end
  if islock then
    NekoData.BehaviorManager.BM_Message:AddConfirmTip(outStr)
  end
  return islock
end

function BM_Christmas:OnDoorClick(Id)
  local lock = DoorScoreLimit(Id)
  if lock then
    return
  end
  local eventIds, locked
  for i, v in ipairs(self._data.constructions) do
    if v.ID == Id then
      eventIds = v.event
      locked = v.locked
      break
    end
  end
  if #eventIds < 1 then
    LogErrorFormat("BM_Christmas", "Click Null Door :%s", Id)
    return
  end
  local type = CInterfaceFunction:GetRecorder(eventIds[1]).type
  if type == CChristmasActivityEvent.MAINLINE_BATTLE then
    local dialog = DialogManager.CreateSingletonDialog("activity.christmas.christmasstorybattledialog")
    dialog:SetData({
      functionID = eventIds[1],
      constructionID = Id
    })
  elseif type == CChristmasActivityEvent.COMMON_BATTLE then
    local dialog = DialogManager.CreateSingletonDialog("activity.christmas.christmasbattledialog")
    dialog:SetData({
      functionIDs = eventIds,
      constructionID = Id,
      locked = locked
    })
  elseif type == CChristmasActivityEvent.MAINLINE_PLOT then
    local dialog = DialogManager.CreateSingletonDialog("activity.christmas.christmasstorymaindialog")
    dialog:SetData({
      functionID = eventIds[1],
      constructionID = Id
    })
  elseif type == CChristmasActivityEvent.BRANCH_PLOT then
    if #eventIds == 3 then
      local dialog = DialogManager.CreateSingletonDialog("activity.christmas.christmasstorybranchdialog")
      dialog:SetData({functionID = eventIds, constructionID = Id})
    else
      NekoData.BehaviorManager.BM_Message:SendMessageById(100442)
    end
  elseif type == CChristmasActivityEvent.CHRISTMAS_DINNER then
    local dialog = DialogManager.CreateSingletonDialog("activity.christmas.christmasfoodstallsshowdialog")
    dialog:SetData({
      functionID = eventIds[1],
      constructionID = Id
    })
  elseif type == CChristmasActivityEvent.TOP_LEVEL then
    local csend = LuaNetManager.CreateProtocol("protocol.activity.cchristmasactivityevent")
    csend.constructionID = Id
    csend.eventID = eventIds[1]
    csend:Send()
  elseif type == CChristmasActivityEvent.END_PLOT then
    local rec = CChriscorresponding:GetRecorder(Id)
    if rec and self:GetScoreByType(rec.itemId) >= rec.itemNum then
      local dialog = DialogManager.CreateSingletonDialog("activity.christmas.christmasstoryendscoredialog")
      dialog:SetData({
        functionID = eventIds[1],
        constructionID = Id
      })
    else
      local currencyItem = Item.Create(rec.itemId)
      local name = currencyItem:GetName()
      NekoData.BehaviorManager.BM_Message:SendMessageById(100437, {
        name,
        rec.itemNum
      })
    end
  elseif type == CChristmasActivityEvent.COMMON_TOWER then
    local dialog = DialogManager.CreateSingletonDialog("activity.christmas.christmasstorybattledialog")
    dialog:SetData({
      functionID = eventIds[1],
      constructionID = Id
    })
  elseif type == CChristmasActivityEvent.COMMON_BOSS then
    local csend = LuaNetManager.CreateProtocol("protocol.activity.copenhardboss")
    csend:Send()
    local dialog = DialogManager.CreateSingletonDialog("activity.christmas.christmasbossdialog")
    dialog:SetData({
      functionIDs = eventIds,
      constructionID = Id,
      locked = locked
    })
  elseif type == CChristmasActivityEvent.RANKING_BOSS then
    local dialog = DialogManager.CreateSingletonDialog("activity.christmas.christmasbossdialog")
    dialog:SetData({
      functionIDs = eventIds,
      constructionID = Id,
      locked = locked
    })
  end
end

function BM_Christmas:GetExistConstructionsByID(doorId)
  for i, v in ipairs(self._data.constructions) do
    if doorId == v.doorID and next(v.event) ~= nil then
      return v
    end
  end
end

function BM_Christmas:GetConstructions()
  return self._data.constructions
end

function BM_Christmas:HasFinishBlockBattle(Id, EventID)
  for i, v in ipairs(self._data.constructions) do
    if Id == v.ID then
      return table.contain(v.autoExplore, EventID)
    end
  end
end

function BM_Christmas:IsUnlockShop()
  return self._data.Function.Shop == 1
end

function BM_Christmas:IsUnlockBag()
  return self._data.Function.Bag == 1
end

function BM_Christmas:IsUnlockMail()
  return self._data.Function.Mail == 1
end

function BM_Christmas:IsUnlockBook()
  return self._data.Function.Book == 1
end

function BM_Christmas:GetSnackData()
  return self._data.foodStallsData
end

function BM_Christmas:GetSnacRedpoint()
  return self._data.snackRedpoint == 1
end

function BM_Christmas:ShowMailRedDot()
  return self._data.showMailRedPoint
end

function BM_Christmas:ShowScoreRedDot()
  return self._data.showScoreRedPoint
end

function BM_Christmas:ShowRedDot()
  return self:ShowMailRedDot() or self:ShowScoreRedDot() or self:GetSnacRedpoint()
end

function BM_Christmas:GetScoreByType(type)
  local data = self._data.scoreData[type]
  if data then
    return data.score
  else
    LogErrorFormat("BM_Christmas", "scoreType: %s is error.", type)
  end
end

function BM_Christmas:GetScoreAwardListByType(type)
  local data = self._data.scoreData[type]
  if data then
    local list = {}
    for k, v in pairs(data.awards) do
      table.insert(list, v)
    end
    table.sort(list, function(a, b)
      return a.record.id < b.record.id
    end)
    return list
  else
    LogErrorFormat("BM_Christmas", "scoreType: %s is error.", type)
  end
end

function BM_Christmas:ShowRedDotByType(type)
  local data = self._data.scoreData[type]
  if data then
    return data.showRedDot
  else
    LogErrorFormat("BM_Christmas", "scoreType: %s is error.", type)
  end
end

function BM_Christmas:GetRolesStatusByRoleID(id)
  return self._data.roleStatus[id]
end

function BM_Christmas:GetBuffInfo(id)
  return self._data.buffInfo
end

function BM_Christmas:GetCanGetBuffNum()
  local ChrisFrameCfg = BeanManager.GetTableByName("dungeonselect.cchrisframeconfig")
  local result = {
    3,
    3,
    3
  }
  for k, v in pairs(self._data.buffInfo) do
    local recorder = ChrisFrameCfg:GetRecorder(k)
    if v == 1 and recorder then
      result[recorder.type] = result[recorder.type] - 1
    end
  end
  return result
end

function BM_Christmas:GetSChristmasBossTimes()
  return self._data.bossTimes
end

function BM_Christmas:GetCanEnterSecond()
  return self._data.canEnterSecond
end

return BM_Christmas
