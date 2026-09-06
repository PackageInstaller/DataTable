local UIManager = CS.PixelNeko.UI.UIManager
local CImagePathTable = BeanManager.GetTableByName("ui.cimagepath")
local CInterEntry = BeanManager.GetTableByName("dungeonselect.cinterentry")
local CInterfaceFunction = BeanManager.GetTableByName("dungeonselect.cinterfacefunction")
local TableFrame = require("framework.ui.frame.table.tableframe")
local ChristmasFoodStallsShowDialog = class("ChristmasFoodStallsShowDialog", Dialog)
ChristmasFoodStallsShowDialog.AssetBundleName = "ui/layouts.activitychristmas"
ChristmasFoodStallsShowDialog.AssetName = "ActivityChristmasStallsShow"

function ChristmasFoodStallsShowDialog:Ctor(...)
  ChristmasFoodStallsShowDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
end

function ChristmasFoodStallsShowDialog:OnCreate()
  self._item = self:GetChild("BuyBtn")
  self._off = self:GetChild("Item/Off")
  self._on = self:GetChild("Item/On")
  self._detail = self:GetChild("Detail")
  self._title = self:GetChild("Title")
  self._off:SetActive(true)
  self._on:SetActive(false)
  self._item:Subscribe_PointerClickEvent(self.OnCheckbtnClicked, self)
  LuaNotificationCenter.AddObserver(self, self.RefreshStatus, Common.n_OnRefreshChristmasFoodStallsStatus, nil)
  LuaNotificationCenter.AddObserver(self, self.OnEveryWhereClick, Common.n_GlobalPointerWillDown, nil)
end

function ChristmasFoodStallsShowDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
end

function ChristmasFoodStallsShowDialog:SetData(data)
  self._functionID = data.functionID
  self._constructionID = data.constructionID
  local block = CInterEntry:GetRecorder(data.constructionID)
  self._title:SetText(TextManager.GetText(block.name))
  self._detail:SetText(TextManager.GetText(block.destribe))
  local protocol = LuaNetManager.CreateProtocol("protocol.activity.copenchristmasdinner")
  if protocol then
    protocol:Send()
    return
  end
end

function ChristmasFoodStallsShowDialog:RefreshStatus()
  local data = NekoData.BehaviorManager.BM_Activity:GetManager(DataCommon.ChristmasActivityManagerID):GetSnackData()
  if next(data) ~= nil then
    self._on:SetActive(data.isOpen == 1)
    self._off:SetActive(data.isOpen == 0)
  else
    self._on:SetActive(false)
    self._off:SetActive(true)
  end
end

function ChristmasFoodStallsShowDialog:OnCheckbtnClicked()
  local dialog = DialogManager.CreateSingletonDialog("activity.christmas.christmasfoodstallsdialog")
  if dialog then
    dialog:Init()
  end
  self:OnBackBtnClicked()
end

function ChristmasFoodStallsShowDialog:OnEveryWhereClick(args)
  if not UIManager.RectangleContainsScreenPoint(self:GetRootWindow()._uiObject, args.userInfo.eventData.position.x, args.userInfo.eventData.position.y) then
    self:OnBackBtnClicked()
  end
end

function ChristmasFoodStallsShowDialog:OnBackBtnClicked()
  self:Destroy()
end

return ChristmasFoodStallsShowDialog
