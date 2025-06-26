-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/traincamp/traincampmaindialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local TableFrame = require("framework.ui.frame.table.tableframe")
local TrainCampMainDialog = class("TrainCampMainDialog", Dialog)
TrainCampMainDialog.AssetBundleName = "ui/layouts.yard"
TrainCampMainDialog.AssetName = "TrainMain"
TrainCampMainDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : TrainCampMainDialog
  ((TrainCampMainDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
  self._currencies = {}
  self._show = true
end

TrainCampMainDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._iBtn = self:GetChild("Ibtn")
  self._backBtn = self:GetChild("Panel/BackBtn")
  self._menuBtn = self:GetChild("Panel/MenuBtn")
  self._lvTxt = self:GetChild("Panel/LVNum")
  self._currencyPanel = self:GetChild("Panel/TopGroup")
  self._dispatchBtn = self:GetChild("Panel/Down/Btn")
  self._dispatchBtn_redDot = self:GetChild("Panel/Down/Btn/RedDot")
  self._panel = self:GetChild("Panel")
  self._viewBtn = self:GetChild("HideBtn")
  ;
  (self._viewBtn):SetSelected(false)
  self._currencyFrame = (TableFrame.Create)(self._currencyPanel, self, false, false)
  ;
  (self._viewBtn):Subscribe_PointerClickEvent(self.OnViewBtnClick, self)
  ;
  (self._dispatchBtn):Subscribe_PointerClickEvent(self.OnDispatchBtnClick, self)
  ;
  (self._iBtn):Subscribe_PointerClickEvent(self.OnIBtnClicked, self)
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClick, self)
  self._width = (self._currencyPanel):GetRectSize()
  self:RefreshCurrency()
  self:RefreshRedDot()
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshCurrency, Common.n_RefreshCurrency, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshRedDot, Common.n_BuildingGetNumChanged, nil)
  ;
  (self._lvTxt):SetText(((NekoData.BehaviorManager).BM_TrainCamp):GetLevel())
end

TrainCampMainDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (self._currencyFrame):Destroy()
  ;
  (DialogManager.DestroySingletonDialog)("traincamp.trainlistdialog")
  ;
  (DialogManager.DestroySingletonDialog)("fastmenu.fastmenudialog")
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
end

TrainCampMainDialog.OnDispatchBtnClick = function(self)
  -- function num : 0_3 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("traincamp.trainlistdialog")
end

TrainCampMainDialog.GetCurrencyIndexById = function(self, id)
  -- function num : 0_4 , upvalues : _ENV
  for i,v in ipairs(self._currencies) do
    if v.currecyId == id then
      return i
    end
  end
end

TrainCampMainDialog.OnRefreshCurrency = function(self, notification)
  -- function num : 0_5 , upvalues : _ENV
  local fireMap = {}
  local insertList = {}
  for i = DataCommon.WhiteLight, DataCommon.ColorLight do
    local index = self:GetCurrencyIndexById(i)
    if index then
      fireMap[i] = true
    else
      if ((NekoData.BehaviorManager).BM_Firefly):GetLightMaxCapacity(i) > 0 then
        (table.insert)(insertList, i - DataCommon.WhiteLight + 1)
      end
    end
  end
  do
    while (self._currencies)[#self._currencies] do
      (table.remove)(self._currencies, #self._currencies)
    end
    for i = DataCommon.WhiteLight, DataCommon.ColorLight do
      local maxCapacity = ((NekoData.BehaviorManager).BM_Firefly):GetLightMaxCapacity(i)
      if maxCapacity > 0 then
        (table.insert)(self._currencies, {currecyId = i, num = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(i), maxCapacity = maxCapacity, canJump = true})
      end
    end
    ;
    (self._currencyFrame):FireEvent("PlayUpEffect", fireMap)
    do
      if #insertList > 0 then
        local cellPanelWidth = self._width / 3 * #self._currencies
        ;
        (self._currencyPanel):SetDeltaSize(cellPanelWidth, self._height)
      end
      for i,v in ipairs(insertList) do
        (self._currencyFrame):InsertCellsAtIndex({v})
      end
    end
  end
end

TrainCampMainDialog.RefreshCurrency = function(self)
  -- function num : 0_6 , upvalues : _ENV
  while (self._currencies)[#self._currencies] do
    (table.remove)(self._currencies, #self._currencies)
  end
  for i = DataCommon.WhiteLight, DataCommon.ColorLight do
    local maxCapacity = ((NekoData.BehaviorManager).BM_Firefly):GetLightMaxCapacity(i)
    if maxCapacity > 0 then
      (table.insert)(self._currencies, {currecyId = i, num = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(i), maxCapacity = maxCapacity, canJump = true})
    end
  end
  local cellPanelWidth = self._width / 3 * #self._currencies
  ;
  (self._currencyPanel):SetDeltaSize(cellPanelWidth, self._height)
  ;
  (self._currencyFrame):ReloadAllCell()
end

TrainCampMainDialog.RefreshRedDot = function(self)
  -- function num : 0_7 , upvalues : _ENV
  (self._dispatchBtn_redDot):SetActive(((NekoData.BehaviorManager).BM_TrainCamp):GetGetNum() > 0)
  -- DECOMPILER ERROR: 1 unprocessed JMP targets
end

TrainCampMainDialog.NumberOfCell = function(self, frame)
  -- function num : 0_8
  if frame == self._currencyFrame then
    return #self._currencies
  end
end

TrainCampMainDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_9
  if frame == self._currencyFrame then
    return "courtyard.currencycell"
  end
end

TrainCampMainDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_10
  if frame == self._currencyFrame then
    return (self._currencies)[index]
  end
end

TrainCampMainDialog.OnViewBtnClick = function(self)
  -- function num : 0_11
  self._show = not self._show
  ;
  (self._panel):SetActive(self._show)
  ;
  (self._viewBtn):SetSelected(not self._show)
end

TrainCampMainDialog.OnIBtnClicked = function(self)
  -- function num : 0_12 , upvalues : _ENV
  ((DialogManager.CreateSingletonDialog)("newbattle.battleteachguidedialog")):Init(((DataCommon.LocalTips).GuideOpenInstructionDialog_TrainCamp).guideId)
end

TrainCampMainDialog.OnBackBtnClicked = function(self)
  -- function num : 0_13 , upvalues : _ENV
  local yardController = (SceneManager.GetSceneControllerByID)(30004)
  ;
  (yardController._yardFSM):SetNumber("sceneId", 0)
end

TrainCampMainDialog.OnMenuBtnClick = function(self)
  -- function num : 0_14 , upvalues : _ENV
  (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
end

TrainCampMainDialog.AddNewModal = function(self)
  -- function num : 0_15
end

return TrainCampMainDialog

