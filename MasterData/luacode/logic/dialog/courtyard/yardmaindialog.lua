local UIManager = CS.PixelNeko.UI.UIManager
local TransformStaticFunctions = CS.PixelNeko.Lua.TransformStaticFunctions
local TableFrame = require("framework.ui.frame.table.tableframe")
local ImageTable = BeanManager.GetTableByName("ui.cimagepath")
local Item = require("logic.manager.experimental.types.item")
local CEffectWordChangeConfig = BeanManager.GetTableByName("overseas.ceffectwordchangeconfig")
local YardMainDialog = class("YardMainDialog", Dialog)
YardMainDialog.AssetBundleName = "ui/layouts.yard"
YardMainDialog.AssetName = "YardMain"

function YardMainDialog:Ctor(...)
  YardMainDialog.super.Ctor(self, ...)
  self._groupName = "Default"
  self._courtyardSceneController = nil
  self._currencies = {}
  self._bmBuildings = {}
  self._bmBuildings[DataCommon.MagicTree] = NekoData.BehaviorManager.BM_MagicTree
  self._bmBuildings[DataCommon.Explore] = NekoData.BehaviorManager.BM_Explore
  self._bmBuildings[DataCommon.Firefly] = NekoData.BehaviorManager.BM_Firefly
  self._bmBuildings[DataCommon.Alchemy] = NekoData.BehaviorManager.BM_Alchemy
  self._bmBuildings[DataCommon.Cabin] = NekoData.BehaviorManager.BM_Cabin
  self._bmBuildings[DataCommon.TrainCamp] = NekoData.BehaviorManager.BM_TrainCamp
  self._bmBuildings[DataCommon.YardMusic] = NekoData.BehaviorManager.BM_YardMusic
end

function YardMainDialog:OnCreate()
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._panel = self:GetChild("TopGroup")
  self._width, self._height = self._panel:GetRectSize()
  self._anchoredx, self._anchoredy = self._panel:GetAnchoredPosition()
  self._currencyFrame = TableFrame.Create(self._panel, self, false, false)
  self._titles = {}
  for k, v in pairs(self._bmBuildings) do
    self._titles[k] = {}
    local titleStr
    if k == DataCommon.MagicTree then
      titleStr = "Tree"
    elseif k == DataCommon.Explore then
      titleStr = "Explore"
    elseif k == DataCommon.Firefly then
      titleStr = "Glow"
    elseif k == DataCommon.Alchemy then
      titleStr = "Alchemy"
    elseif k == DataCommon.Cabin then
      titleStr = "House"
    elseif k == DataCommon.TrainCamp then
      titleStr = "Train"
    elseif k == DataCommon.YardMusic then
      titleStr = "Music"
    end
    local map = self._titles[k]
    map.title = self:GetChild(titleStr .. "Title")
    map.textEffect = self:GetChild(titleStr .. "Title/Effect")
    map.redDot = {}
    map.redDot.dot = self:GetChild(titleStr .. "Title/RedDot")
    map.redDot.num = self:GetChild(titleStr .. "Title/RedDot/Num")
  end
  self._backBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._menuBtn:Subscribe_PointerClickEvent(self.OnMenuBtnClick, self)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshCurrency, Common.n_RefreshCurrency, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshCurrency, Common.n_RefreshFirefly, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshCurrency, Common.n_CollectorCapacityLvUp, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshTitles, Common.n_RefreshCourtYard, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshTitles, Common.n_RefreshAllExploreSlots, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshTitles, Common.n_RefreshFirefly, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshTitles, Common.n_RefreshAlchemy, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshTitles, Common.n_RefreshCabin, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshTitles, Common.n_RefreshTrainCamp, nil)
  LuaNotificationCenter.AddObserver(self, self.OnRefreshTitles, Common.n_RefreshYardMusic, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshYardRedDot, Common.n_BuildingGetNumChanged, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshYardRedDot, Common.n_BuildingPauseTaskNumChanged, nil)
  LuaNotificationCenter.AddObserver(self, self.OnCameraTransformChanged, Common.n_CameraTransformChanged, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshYardRedDot, Common.n_BuildingLevelUp, nil)
  LuaNotificationCenter.AddObserver(self, self.RefreshYardRedDot, Common.n_GuideStatusChanged, nil)
  self:RefreshYardRedDot()
end

function YardMainDialog:OnDestroy()
  LuaNotificationCenter.RemoveObserver(self)
  self._currencyFrame:Destroy()
  DialogManager.DestroySingletonDialog("courtyard.interactdialog")
  DialogManager.DestroySingletonDialog("bag.itemtipsdialog")
  DialogManager.DestroySingletonDialog("fastmenu.fastmenudialog")
end

function YardMainDialog:RefreshCurrency()
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
  self._panel:SetSize(0, cellPanelWidth, 0, self._height)
  self._panel:SetAnchoredPosition(self._anchoredx, self._anchoredy)
  self._currencyFrame:ReloadAllCell()
end

function YardMainDialog:OnRefreshCurrency(notification)
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
    self._panel:SetSize(0, cellPanelWidth, 0, self._height)
    self._panel:SetAnchoredPosition(self._anchoredx, self._anchoredy)
  end
  for i, v in ipairs(insertList) do
    self._currencyFrame:InsertCellsAtIndex({v})
  end
end

function YardMainDialog:GetCurrencyIndexById(id)
  for i, v in ipairs(self._currencies) do
    if v.currecyId == id then
      return i
    end
  end
end

function YardMainDialog:OnRefreshTitles()
  for k, v in pairs(self._titles) do
    local bm_building = self._bmBuildings[k]
    v.title:SetActive(bm_building and bm_building:GetLevel() > 0)
  end
end

function YardMainDialog:OnCameraTransformChanged()
  for k, v in pairs(self._uiPoints) do
    local actorX, actorY, actorZ = TransformStaticFunctions.GetPosition(v)
    local pos2 = self._mainCamera:WorldToViewportPoint({
      x = actorX,
      y = actorY,
      z = actorZ
    })
    local screenPos = self._mainCamera:ViewportToScreenPoint(pos2)
    local x, y = UIManager.ScreenPointToLocalPointInRectangle(self:GetRootWindow()._uiObject, screenPos.x, screenPos.y)
    self._titles[k].title:SetAnchoredPosition(x, y)
  end
end

function YardMainDialog:Init(sceneController)
  self._courtyardSceneController = sceneController
  self._mainCamera = self._courtyardSceneController:GetMainCamera()
  self._uiPoints = self._courtyardSceneController._sceneRef:GetUIPoints()
  for k, v in pairs(self._uiPoints) do
    local actorX, actorY, actorZ = TransformStaticFunctions.GetPosition(v)
    local pos2 = self._mainCamera:WorldToViewportPoint({
      x = actorX,
      y = actorY,
      z = actorZ
    })
    local screenPos = self._mainCamera:ViewportToScreenPoint(pos2)
    local x, y = UIManager.ScreenPointToLocalPointInRectangle(self:GetRootWindow()._uiObject, screenPos.x, screenPos.y)
    self._titles[k].title:SetAnchoredPosition(x, y)
  end
  local languageId = tonumber(BeanManager.GetTableByName("var.cvarconfig"):GetRecorder(101).Value)
  for k, value in pairs(self._titles) do
    local configId
    if k == DataCommon.MagicTree then
      configId = 7
    elseif k == DataCommon.Explore then
      configId = 9
    elseif k == DataCommon.Firefly then
      configId = 11
    elseif k == DataCommon.Alchemy then
      configId = 6
    elseif k == DataCommon.Cabin then
      configId = 8
    elseif k == DataCommon.TrainCamp then
      configId = 10
    elseif k == DataCommon.YardMusic then
      configId = 12
    end
    local recorder = CEffectWordChangeConfig:GetRecorder(configId)
    local assetBundleName = recorder.assetBundle
    local assetName
    if languageId == 1 then
      assetName = recorder.cn
    elseif languageId == 2 then
      assetName = recorder.en
    elseif languageId == 3 then
      assetName = recorder.kr
    elseif languageId == 4 then
      assetName = recorder.jp
    end
    value.textEffect:AddEffectSync(assetBundleName, assetName)
  end
  self:RefreshCurrency()
  self:OnRefreshTitles()
end

function YardMainDialog:RefreshYardRedDot()
  for k, v in pairs(self._titles) do
    if k == DataCommon.Alchemy then
      v.redDot.dot:SetActive(false)
    else
      local bm_building = self._bmBuildings[k]
      if bm_building then
        if bm_building:GetPauseTaskNum() + bm_building:GetGetNum() > 0 then
          v.redDot.dot:SetActive(true)
          v.redDot.num:SetText(bm_building:GetPauseTaskNum() + bm_building:GetGetNum())
        else
          v.redDot.dot:SetActive(false)
        end
      end
    end
  end
end

function YardMainDialog:OnMenuBtnClick()
  local dialog = DialogManager.GetDialog("fastmenu.fastmenudialog")
  if dialog then
    DialogManager.DestroySingletonDialog("fastmenu.fastmenudialog")
  else
    DialogManager.CreateSingletonDialog("fastmenu.fastmenudialog")
  end
end

function YardMainDialog:OnAddBtnClick(index)
  self._courtyardSceneController:SetCameraAnimatorState(5)
  if NekoData.BehaviorManager.BM_Firefly:GetLevel() > 0 then
    DialogManager.CreateSingletonDialog("firefly.fireflydialog"):Init(self._courtyardSceneController)
  end
end

function YardMainDialog:NumberOfCell(frame)
  return #self._currencies
end

function YardMainDialog:CellAtIndex(frame, index)
  return "courtyard.currencycell"
end

function YardMainDialog:DataAtIndex(frame, index)
  return self._currencies[index]
end

function YardMainDialog:OnBackBtnClicked()
  local csend = LuaNetManager.CreateProtocol("protocol.battle.centermaincity")
  csend:Send()
  self:Destroy()
end

return YardMainDialog
