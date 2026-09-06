local CHexagonland = BeanManager.GetTableByName("activity.chexagonland")
local CSwimSuitTimeCfg = BeanManager.GetTableByName("activity.cswimsuittimecfg")
local CHexagonFunction = BeanManager.GetTableByName("activity.chexagonfunction")
local CSummerActivityEvent = require("protocols.def.protocol.activity.csummeractivityevent")
local BM_SummerActivity = class("BM_SummerActivity")

function BM_SummerActivity:Ctor()
  self._data = NekoData.Data.activities.summerActivity
end

function BM_SummerActivity:OnBlockClick(Id)
  if Id == 0 or DialogManager.GetDialog("dungeon.battlecrossdialog") then
    return
  end
  local recorder = CHexagonland:GetRecorder(Id)
  if not recorder then
    LogErrorFormat("BM_SummerActivity", "CHexagonland Cannt Find ID %s", Id)
  end
  local eventIds, constructionLevel, canlvup, event2lock, locked
  for i, v in ipairs(self._data.constructions) do
    if v.ID == Id then
      eventIds = v.event
      constructionLevel = v.level
      canlvup = v.canlvup == 1
      event2lock = v.event2lock
      locked = v.locked
      break
    end
  end
  if #eventIds < 1 then
    return
  end
  local type = CHexagonFunction:GetRecorder(eventIds[1]).type
  if type == CSummerActivityEvent.MAINLINE_DRAMA then
    local dialog = DialogManager.CreateSingletonDialog("activity.swimsuit.swimsuitstorymiandialog")
    dialog:SetData({
      functionID = eventIds[1],
      constructionID = Id
    })
  elseif type == CSummerActivityEvent.MAINLINE_BATTLE then
    local dialog = DialogManager.CreateSingletonDialog("activity.swimsuit.swimsuitstorybattledialog")
    dialog:SetData({
      functionID = eventIds[1],
      constructionID = Id
    })
  elseif type == CSummerActivityEvent.SIDE_DRAMA then
    local dialog = DialogManager.CreateSingletonDialog("activity.swimsuit.swimsuitstorybranchdialog")
    dialog:SetData({
      functionID = eventIds[1],
      constructionID = Id
    })
  elseif type == CSummerActivityEvent.FREEDOM_BATTLE then
    local dialog = DialogManager.CreateSingletonDialog("activity.swimsuit.swimsuitbattledialog")
    dialog:SetData({
      functionIDs = eventIds,
      constructionID = Id,
      event2lock = event2lock,
      locked = locked,
      constructionLevel = constructionLevel
    })
  elseif type == CSummerActivityEvent.SUMMER_SHOP then
    local dialogName = "activity.swimsuit.buydialog"
    local dialog = DialogManager.GetDialog(dialogName)
    dialog = dialog or DialogManager.CreateSingletonDialog(dialogName)
    dialog:SetData({
      functionID = eventIds[1],
      constructionID = Id,
      constructionLevel = constructionLevel,
      canLevelUp = canlvup
    })
  elseif type == CSummerActivityEvent.SUMMER_SNACK then
    local dialog = DialogManager.CreateSingletonDialog("activity.swimsuit.swimsuitfoodstallsshowdialog")
    dialog:SetData({
      functionID = eventIds[1],
      constructionID = Id
    })
  elseif type == CSummerActivityEvent.WATERMELON then
    local dialogName = "activity.swimsuit.xiguadialog"
    local dialog = DialogManager.GetDialog(dialogName)
    dialog = dialog or DialogManager.CreateSingletonDialog(dialogName)
    dialog:SetData({
      functionIDs = eventIds,
      constructionID = Id,
      constructionLevel = constructionLevel,
      canLevelUp = canlvup
    })
  elseif type == CSummerActivityEvent.DISPLAY_ROOM then
    local dialogName = "activity.swimsuit.showdialog"
    local dialog = DialogManager.GetDialog(dialogName)
    dialog = dialog or DialogManager.CreateSingletonDialog(dialogName)
    dialog:SetData({
      functionID = eventIds[1],
      constructionID = Id,
      constructionLevel = constructionLevel
    })
  end
  LuaNotificationCenter.PostNotification(Common.n_COnBlockClick, nil, Id)
end

function BM_SummerActivity:GetTimeProgress()
  return self._data.timeProgress
end

function BM_SummerActivity:GetTimeProgressMax()
  return self._data.timeRecorder.timePointMax
end

function BM_SummerActivity:GetState()
  return self._data.state
end

function BM_SummerActivity:GetPreState()
  return self._data.state_Old
end

function BM_SummerActivity:GetMissions()
  table.sort(self._data.missions, function(a, b)
    return a.ID > b.ID
  end)
  return self._data.missions
end

function BM_SummerActivity:GetConstructions()
  return self._data.constructions
end

function BM_SummerActivity:HasFinishBlockBattle(Id, EventID)
  for i, v in ipairs(self._data.constructions) do
    if Id == v.ID then
      return table.contain(v.autoExplore, EventID)
    end
  end
end

function BM_SummerActivity:GetShopConstructionList()
  return self._data.shopConstructionList
end

function BM_SummerActivity:GetStorageConstructionList()
  return self._data.storageConstructionList
end

function BM_SummerActivity:IsDayTime()
  return self._data.timeRecorder.dayOrNight == 1
end

function BM_SummerActivity:BlockHasEvent(ID)
  for i, v in ipairs(self._data.constructions) do
    if v.ID == ID then
      return v.event and #v.event > 0
    end
  end
end

function BM_SummerActivity:CanBuyBuildings()
  return self._data.constructionRedpoint == 1
end

function BM_SummerActivity:GetSnackData()
  return self._data.foodStallsData
end

function BM_SummerActivity:GetSnacRedpoint()
  if next(self._data.foodStallsData) == nil then
    return self._data.snackRedpoint == 1
  else
    return self._data.foodStallsData.isOpen == 1 and self._data.foodStallsData.used == 0
  end
end

function BM_SummerActivity:GetIsOpen()
  return NekoData.BehaviorManager.BM_Activity:IsActivityOpenById(21)
end

function BM_SummerActivity:GetFreeRedDot()
  return self._data.freeReddot
end

function BM_SummerActivity:KillFreeRedDot()
  self._data.freeReddot = false
end

function BM_SummerActivity:HaveRedDot()
  return self._data.freeReddot
end

function BM_SummerActivity:ShowRedDot()
  if not self:GetIsOpen() then
    return false
  end
  return self:HaveRedDot()
end

return BM_SummerActivity
