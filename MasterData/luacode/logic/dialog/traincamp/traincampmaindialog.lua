local TableFrame = require("framework.ui.frame.table.tableframe")
local TrainCampMainDialog = class("TrainCampMainDialog", Dialog)
TrainCampMainDialog.AssetBundleName = "ui/layouts.yard"
TrainCampMainDialog.AssetName = "TrainMain"

function TrainCampMainDialog:Ctor(...)
  TrainCampMainDialog.super.Ctor(self, ...)
  self._groupName = "Modal"
  self._currencies = {}
  self._show = true
end

function TrainCampMainDialog:OnCreate()
  self._iBtn = self:GetChild("Ibtn")
  self._backBtn = self:GetChild("Panel/BackBtn")
  self._menuBtn = self:GetChild("Panel/MenuBtn")
  self._lvTxt = self:GetChild("Panel/LVNum")
  self._currencyPanel = self:GetChild("Panel/TopGroup")
  self._dispatchBtn = self:GetChild("Panel/Down/Btn")
  self._dispatchBtn_redDot = self:GetChild("Panel/Down/Btn/RedDot")
  self._panel = self:GetChild("Panel")
  self._viewBtn = self:GetChild("HideBtn")
  self._viewBtn:SetSelected(false)
  self._currencyFrame = TableFrame.Create(self._currencyPanel, self, false, false)
  self._viewBtn:Subscribe_PointerClickEvent(self.OnViewBtnClick, self)
  self._dispatchBtn:Subscribe_PointerClickEvent(self.OnDispatchBtnClick, self)
  self._iBtn:Subscribe_PointerClickEvent(self.OnIBtnClicked, self)
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClick, self)
  self._width, self._height = self._currencyPanel:GetRectSize()
  self:RefreshCurrency()
  self:RefreshRedDot()
  LuaNotificationCenter.AddObserver(self, self.OnRefreshCurrency, Common.n_RefreshCurrency, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshRedDot, Common.n_BuildingGetNumChanged, nil)
  self._lvTxt:SetText(NekoData.BehaviorManager.BM_TrainCamp:GetLevel())
end

function TrainCampMainDialog:OnDestroy()
  self._currencyFrame:Destroy()
  DialogManager.DestroySingletonDialog("traincamp.trainlistdialog")
  DialogManager.DestroySingletonDialog("fastmenu.fastmenudialog")
  LuaNotificationCenter.RemoveObserver(self)
end

function TrainCampMainDialog:OnDispatchBtnClick()
  DialogManager.CreateSingletonDialog("traincamp.trainlistdialog")
end

function TrainCampMainDialog:GetCurrencyIndexById(id)
  for i, v in ipairs(self._currencies) do
    if v.currecyId == id then
      return i
    end
  end
end

function TrainCampMainDialog:OnRefreshCurrency(notification)
  local fireMap = {}
  local insertList = {}
  for i = DataCommon.WhiteLight, DataCommon.ColorLight do
    local index = self:GetCurrencyIndexById(i)
    if index then
      fireMap[i] = true
    elseif NekoData.BehaviorManager.BM_Firefly:GetLightMaxCapacity(i) > 0 then
      table.insert(insertList, i - DataCommon.WhiteLight + 1)
    end
  end
  while self._currencies[#self._currencies] do
    table.remove(self._currencies, #self._currencies)
  end
  for i = DataCommon.WhiteLight, DataCommon.ColorLight do
    local maxCapacity = NekoData.BehaviorManager.BM_Firefly:GetLightMaxCapacity(i)
    if 0 < maxCapacity then
      table.insert(self._currencies, {
        currecyId = i,
        num = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(i),
        maxCapacity = maxCapacity,
        canJump = true
      })
    end
  end
  self._currencyFrame:FireEvent("PlayUpEffect", fireMap)
  if 0 < #insertList then
    local cellPanelWidth = self._width / 3 * #self._currencies
    self._currencyPanel:SetDeltaSize(cellPanelWidth, self._height)
  end
  for i, v in ipairs(insertList) do
    self._currencyFrame:InsertCellsAtIndex({v})
  end
end

function TrainCampMainDialog:RefreshCurrency()
  while self._currencies[#self._currencies] do
    table.remove(self._currencies, #self._currencies)
  end
  for i = DataCommon.WhiteLight, DataCommon.ColorLight do
    local maxCapacity = NekoData.BehaviorManager.BM_Firefly:GetLightMaxCapacity(i)
    if 0 < maxCapacity then
      table.insert(self._currencies, {
        currecyId = i,
        num = NekoData.BehaviorManager.BM_Currency:GetCurrencyNum(i),
        maxCapacity = maxCapacity,
        canJump = true
      })
    end
  end
  local cellPanelWidth = self._width / 3 * #self._currencies
  self._currencyPanel:SetDeltaSize(cellPanelWidth, self._height)
  self._currencyFrame:ReloadAllCell()
end

function TrainCampMainDialog:RefreshRedDot()
  self._dispatchBtn_redDot:SetActive(NekoData.BehaviorManager.BM_TrainCamp:GetGetNum() > 0)
end

function TrainCampMainDialog:NumberOfCell(frame)
  if frame == self._currencyFrame then
    return #self._currencies
  end
end

function TrainCampMainDialog:CellAtIndex(frame, index)
  if frame == self._currencyFrame then
    return "courtyard.currencycell"
  end
end

function TrainCampMainDialog:DataAtIndex(frame, index)
  if frame == self._currencyFrame then
    return self._currencies[index]
  end
end

function TrainCampMainDialog:OnViewBtnClick()
  self._show = not self._show
  self._panel:SetActive(self._show)
  self._viewBtn:SetSelected(not self._show)
end

function TrainCampMainDialog:OnIBtnClicked()
  DialogManager.CreateSingletonDialog("newbattle.battleteachguidedialog"):Init(DataCommon.LocalTips.GuideOpenInstructionDialog_TrainCamp.guideId)
end

function TrainCampMainDialog:OnBackBtnClicked()
  local yardController = SceneManager.GetSceneControllerByID(30004)
  yardController._yardFSM:SetNumber("sceneId", 0)
end

function TrainCampMainDialog:OnMenuBtnClick()
  DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
end

function TrainCampMainDialog:AddNewModal()
end

return TrainCampMainDialog
