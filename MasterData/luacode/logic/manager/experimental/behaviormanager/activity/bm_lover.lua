local BM_Lover = class("BM_Lover")
local CInterfaceFunction = BeanManager.GetTableByName("dungeonselect.cvalentineinterfacefunction")
local CInterEntry = BeanManager.GetTableByName("dungeonselect.cvalentineinterentry")
local CLoverLines = BeanManager.GetTableByName("activity.cvalentinelines")
local CLoverActivityEvent = require("protocols.def.protocol.activity.cloveractivityevent")
local CStringRes = BeanManager.GetTableByName("message.cstringres")
local Item = require("logic.manager.experimental.types.item")
BM_Lover.LineFuncitionType = {
  Store = 1,
  FlowerLeft = 2,
  FlowerRight = 3
}
local PlayerPrefs = CS.UnityEngine.PlayerPrefs
local RedPointPrefix = "LoverRedPoint"
local RedPointStatus = {UNREAD = 0, READ = 1}
BM_Lover.RedPointKey = {
  Banner = "Banner",
  Shop = "Shop",
  ShopChocolateTab = "ShopChocolateTab",
  Store = "Store",
  Flower = "Flower",
  Chocolate = "Chocolate"
}

function BM_Lover:Ctor()
  self._data = NekoData.Data.activities.lover
  self._lineList = {}
end

function BM_Lover:OnDoorClick(Id)
  local eventIds, locked
  for i, v in ipairs(self._data.constructions) do
    if v.ID == Id then
      eventIds = v.event
      locked = v.locked
      break
    end
  end
  if #eventIds < 1 then
    LogErrorFormat("BM_Lover", "Click Null Door :%s", Id)
    return
  end
  local type = CInterfaceFunction:GetRecorder(eventIds[1]).type
  if type == CLoverActivityEvent.MAINLINE_BATTLE then
    local dialog = DialogManager.CreateSingletonDialog("activity.lover.loverstorybattledialog")
    dialog:SetData({
      functionID = eventIds[1],
      constructionID = Id
    })
  elseif type == CLoverActivityEvent.COMMON_BATTLE then
    local dialog = DialogManager.CreateSingletonDialog("activity.lover.loverbattledialog")
    dialog:SetData({
      functionIDs = eventIds,
      constructionID = Id,
      locked = locked
    })
  elseif type == CLoverActivityEvent.MAINLINE_PLOT then
    local dialog = DialogManager.CreateSingletonDialog("activity.lover.loverstorymaindialog")
    dialog:SetData({
      functionID = eventIds[1],
      constructionID = Id
    })
  end
end

function BM_Lover:GetConstructions()
  return self._data.constructions
end

function BM_Lover:HasFinishBlockBattle(Id, EventID)
  for i, v in ipairs(self._data.constructions) do
    if Id == v.ID then
      return table.contain(v.autoExplore, EventID)
    end
  end
end

function BM_Lover:ShowRedDot()
  return self:GetRedPointWithLocalKey(self.RedPointKey.Banner)
end

function BM_Lover:CheckFunctionUnLock(type)
  return type == CLoverActivityEvent.ITEM_SHOP and self._data.Function.ItemShop == 1 or type == CLoverActivityEvent.CHOCOLATE and self._data.Function.Chocolate == 1 or type == CLoverActivityEvent.FLOWER_LIST and self._data.Function.Flowers == 1 or type == CLoverActivityEvent.DIALOGUE_STORE and self._data.Function.DialogueStore == 1
end

function BM_Lover:GetChocolateEntry()
  return self._data.ChocolateEntry
end

function BM_Lover:GetRandomLine(functionType, condition)
  local lineList = self._lineList
  if #lineList == 0 then
    for _, v in ipairs(CLoverLines:GetAllIds()) do
      local recorder = CLoverLines:GetRecorder(v)
      if not lineList[recorder.type] then
        lineList[recorder.type] = {}
      end
      if not lineList[recorder.type][recorder.condition] then
        lineList[recorder.type][recorder.condition] = {}
      end
      table.insert(lineList[recorder.type][recorder.condition], recorder.textId)
    end
    self._lineList = lineList
  end
  if lineList[functionType] and lineList[functionType][condition] then
    local length = #lineList[functionType][condition]
    local id = math.random(1, length)
    return lineList[functionType][condition][id]
  else
    return 0
  end
end

function BM_Lover:GetFlowerEntry()
  return self._data.FlowerEntry
end

function BM_Lover:GetRedPointWithState(state)
  return self._data.redPoint[state]
end

function BM_Lover:SetRedPointWithState(state, flag)
  LogInfoFormat("BM_Lover", "set redPoint[%s] = %s", state, flag)
  self._data.redPoint[state] = flag
end

function BM_Lover:GetRedPointWithLocalKey(key)
  local userid = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().userid
  local result = PlayerPrefs.GetInt(table.concat({
    userid,
    RedPointPrefix,
    key
  }, "."), RedPointStatus.UNREAD) == RedPointStatus.UNREAD
  LogInfoFormat("BM_Lover", "get redPoint local key %s state %s", key, result)
  return result
end

function BM_Lover:SetRedPointWithLocalKey(key)
  LogInfoFormat("BM_Lover", "set redPoint local key %s", key)
  local userid = NekoData.BehaviorManager.BM_Game:GetMyRoleInfo().userid
  PlayerPrefs.SetInt(table.concat({
    userid,
    RedPointPrefix,
    key
  }, "."), RedPointStatus.READ)
end

return BM_Lover
