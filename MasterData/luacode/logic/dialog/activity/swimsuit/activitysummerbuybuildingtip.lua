local CHexagonLand = BeanManager.GetTableByName("activity.chexagonland")
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local ActivitySummerBuyBuildingTip = class("ActivitySummerBuyBuildingTip", Dialog)
local TableFrame = require("framework.ui.frame.table.tableframe")
local CMessageTip = BeanManager.GetTableByName("message.cmessagetip")
ActivitySummerBuyBuildingTip.AssetBundleName = "ui/layouts.activitysummer"
ActivitySummerBuyBuildingTip.AssetName = "ActivitySummerBuy"
local UIManager = CS.PixelNeko.UI.UIManager

function ActivitySummerBuyBuildingTip:Ctor(...)
  ActivitySummerBuyBuildingTip.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._canClick = false
end

function ActivitySummerBuyBuildingTip:OnCreate()
  self._back = self:GetChild("Back")
  self._buyBtn = self:GetChild("BuyBtn")
  self._name = self:GetChild("Name")
  self._detail = self:GetChild("Detail")
  self._item = self:GetChild("Item")
  self._materialPanel = self:GetChild("MaterialFrame")
  self._buyBtn:Subscribe_PointerClickEvent(self.OnBuyBtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.OnGlobalPointerDown, Common.n_GlobalPointerWillDown, nil)
end

function ActivitySummerBuyBuildingTip:OnGlobalPointerDown(args)
  if not UIManager.RectangleContainsScreenPoint(self._back._uiObject, args.userInfo.eventData.position.x, args.userInfo.eventData.position.y) then
    local dialog = DialogManager.GetDialog("activity.swimsuit.swimsuitmaindialog")
    if dialog and not dialog:IsRectangleContainsScreenPoint(args) then
      self:OnBackBtnClicked()
      LuaNotificationCenter.PostNotification(Common.n_SHideDownPanel, nil, nil)
    end
  end
end

function ActivitySummerBuyBuildingTip:IsRectangleContainsScreenPoint(args)
  return UIManager.RectangleContainsScreenPoint(self._back._uiObject, args.userInfo.eventData.position.x, args.userInfo.eventData.position.y)
end

function ActivitySummerBuyBuildingTip:OnBackBtnClicked()
  self:Destroy()
end

function ActivitySummerBuyBuildingTip:OnDestroy()
  self._materialFrame:Destroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function ActivitySummerBuyBuildingTip:SetData(ID)
  self._ID = ID
  local recorder = CHexagonLand:GetRecorder(ID)
  local image = CImagePathTable:GetRecorder(recorder.image) or DataCommon.DefaultImageAsset
  self._item:SetSprite(image.assetBundle, image.assetName)
  self._name:SetText(TextManager.GetText(recorder.name))
  self._detail:SetText(TextManager.GetText(recorder.destribe))
  if self._materialFrame then
    self._materialFrame:Destroy()
  end
  self._materialFrame = TableFrame.Create(self._materialPanel, self, true, false)
  self._materialsData = {}
  for i, v in ipairs(recorder.itemID) do
    table.insert(self._materialsData, {
      id = v,
      count = recorder.itemAmount[i]
    })
  end
  self._materialFrame:ReloadAllCell()
end

function ActivitySummerBuyBuildingTip:OnBuyBtnClicked()
  for i, v in ipairs(self._materialsData) do
    local count = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(v.id)
    if count < v.count then
      NekoData.BehaviorManager.BM_Message:AddMessageTip(TextManager.GetText(CMessageTip:GetRecorder(100392).msgTextID))
      return
    end
  end
  local csend = LuaNetManager.CreateProtocol("protocol.activity.cupdatesummerconstruction")
  csend.ID = self._ID
  csend.vertical = 0
  csend.abscissa = 0
  csend:Send()
  self:Destroy()
end

function ActivitySummerBuyBuildingTip:NumberOfCell(frame)
  return #self._materialsData
end

function ActivitySummerBuyBuildingTip:CellAtIndex(frame, index)
  return "activity.swimsuit.swimsuitmaterialcell"
end

function ActivitySummerBuyBuildingTip:DataAtIndex(frame, index)
  return self._materialsData[index]
end

return ActivitySummerBuyBuildingTip
