local UIManager = CS.PixelNeko.UI.UIManager
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CHexagonFunction = BeanManager.GetTableByName("activity.chexagonfunction")
local CHexagonLand = BeanManager.GetTableByName("activity.chexagonland")
local Chexagonchatconfig = BeanManager.GetTableByName("dialog.chexagonchatconfig")
local TableFrame = require("framework.ui.frame.table.tableframe")
local SwimSuitFoodStallsShowDialog = class("SwimSuitFoodStallsShowDialog", Dialog)
SwimSuitFoodStallsShowDialog.AssetBundleName = "ui/layouts.activitysummer"
SwimSuitFoodStallsShowDialog.AssetName = "ActivitySummerStallsShow"

function SwimSuitFoodStallsShowDialog:Ctor(...)
  SwimSuitFoodStallsShowDialog.super.Ctor(self, ...)
  self._groupName = "Tip"
end

function SwimSuitFoodStallsShowDialog:OnCreate()
  self._item = self:GetChild("BuyBtn")
  self._off = self:GetChild("Item/Off")
  self._on = self:GetChild("Item/On")
  self._detail = self:GetChild("Detail")
  self._title = self:GetChild("Title")
  self._off:SetActive(true)
  self._on:SetActive(false)
  self._item:Subscribe_PointerClickEvent(self.OnCheckbtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.RefreshStatus, Common.n_RefreshFoodStallsStatus, nil)
  LuaNotificationCenter.AddObserver(self, self.OnEveryWhereClick, Common.n_GlobalPointerWillDown, nil)
end

function SwimSuitFoodStallsShowDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function SwimSuitFoodStallsShowDialog:SetData(data)
  self._functionID = data.functionID
  self._constructionID = data.constructionID
  local block = CHexagonLand:GetRecorder(11)
  self._title:SetText(TextManager.GetText(block.name))
  self._detail:SetText(TextManager.GetText(block.destribe))
  local protocol = LuaNetManager.CreateProtocol("protocol.activity.copensnackshop")
  if protocol then
    protocol:Send()
    return
  end
end

function SwimSuitFoodStallsShowDialog:RefreshStatus()
  local data = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.SummerActivityManagerID):GetSnackData()
  if next(data) ~= nil then
    self._on:SetActive(data.isOpen == 1)
    self._off:SetActive(data.isOpen == 0)
  else
    self._on:SetActive(false)
    self._off:SetActive(true)
  end
end

function SwimSuitFoodStallsShowDialog:OnCheckbtnClicked()
  local dialog = DialogManager.CreateSingletonDialog("activity.swimsuit.swimsuitfoodstallsdialog")
  if dialog then
    dialog:Init()
  end
  self:Destroy()
end

function SwimSuitFoodStallsShowDialog:OnEveryWhereClick(args)
  if not UIManager.RectangleContainsScreenPoint(self:GetRootWindow()._uiObject, args.userInfo.eventData.position.x, args.userInfo.eventData.position.y) then
    self:OnBackBtnClicked()
  end
end

function SwimSuitFoodStallsShowDialog:OnBackBtnClicked()
  self:Destroy()
end

return SwimSuitFoodStallsShowDialog
