-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/courtyard/yardmaindialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UIManager = ((CS.PixelNeko).UI).UIManager
local TransformStaticFunctions = ((CS.PixelNeko).Lua).TransformStaticFunctions
local TableFrame = require("framework.ui.frame.table.tableframe")
local ImageTable = (BeanManager.GetTableByName)("ui.cimagepath")
local Item = require("logic.manager.experimental.types.item")
local CEffectWordChangeConfig = (BeanManager.GetTableByName)("overseas.ceffectwordchangeconfig")
local YardMainDialog = class("YardMainDialog", Dialog)
YardMainDialog.AssetBundleName = "ui/layouts.yard"
YardMainDialog.AssetName = "YardMain"
YardMainDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : YardMainDialog, _ENV
  ((YardMainDialog.super).Ctor)(self, ...)
  self._groupName = "Default"
  self._courtyardSceneController = nil
  self._currencies = {}
  self._bmBuildings = {}
  -- DECOMPILER ERROR at PC17: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._bmBuildings)[DataCommon.MagicTree] = (NekoData.BehaviorManager).BM_MagicTree
  -- DECOMPILER ERROR at PC24: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._bmBuildings)[DataCommon.Explore] = (NekoData.BehaviorManager).BM_Explore
  -- DECOMPILER ERROR at PC31: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._bmBuildings)[DataCommon.Firefly] = (NekoData.BehaviorManager).BM_Firefly
  -- DECOMPILER ERROR at PC38: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._bmBuildings)[DataCommon.Alchemy] = (NekoData.BehaviorManager).BM_Alchemy
  -- DECOMPILER ERROR at PC45: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._bmBuildings)[DataCommon.Cabin] = (NekoData.BehaviorManager).BM_Cabin
  -- DECOMPILER ERROR at PC52: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._bmBuildings)[DataCommon.TrainCamp] = (NekoData.BehaviorManager).BM_TrainCamp
  -- DECOMPILER ERROR at PC59: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._bmBuildings)[DataCommon.YardMusic] = (NekoData.BehaviorManager).BM_YardMusic
end

YardMainDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : TableFrame, _ENV
  self._backBtn = self:GetChild("BackBtn")
  self._menuBtn = self:GetChild("MenuBtn")
  self._panel = self:GetChild("TopGroup")
  self._width = (self._panel):GetRectSize()
  self._anchoredx = (self._panel):GetAnchoredPosition()
  self._currencyFrame = (TableFrame.Create)(self._panel, self, false, false)
  self._titles = {}
  for k,v in pairs(self._bmBuildings) do
    -- DECOMPILER ERROR at PC37: Confused about usage of register: R6 in 'UnsetPending'

    (self._titles)[k] = {}
    local titleStr = nil
    if k == DataCommon.MagicTree then
      titleStr = "Tree"
    else
      if k == DataCommon.Explore then
        titleStr = "Explore"
      else
        if k == DataCommon.Firefly then
          titleStr = "Glow"
        else
          if k == DataCommon.Alchemy then
            titleStr = "Alchemy"
          else
            if k == DataCommon.Cabin then
              titleStr = "House"
            else
              if k == DataCommon.TrainCamp then
                titleStr = "Train"
              else
                if k == DataCommon.YardMusic then
                  titleStr = "Music"
                end
              end
            end
          end
        end
      end
    end
    local map = (self._titles)[k]
    map.title = self:GetChild(titleStr .. "Title")
    map.textEffect = self:GetChild(titleStr .. "Title/Effect")
    map.redDot = {}
    -- DECOMPILER ERROR at PC102: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (map.redDot).dot = self:GetChild(titleStr .. "Title/RedDot")
    -- DECOMPILER ERROR at PC109: Confused about usage of register: R8 in 'UnsetPending'

    ;
    (map.redDot).num = self:GetChild(titleStr .. "Title/RedDot/Num")
  end
  ;
  (self._backBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._menuBtn):Subscribe_PointerClickEvent(self.OnMenuBtnClick, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshCurrency, Common.n_RefreshCurrency, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshCurrency, Common.n_RefreshFirefly, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshCurrency, Common.n_CollectorCapacityLvUp, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshTitles, Common.n_RefreshCourtYard, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshTitles, Common.n_RefreshAllExploreSlots, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshTitles, Common.n_RefreshFirefly, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshTitles, Common.n_RefreshAlchemy, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshTitles, Common.n_RefreshCabin, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshTitles, Common.n_RefreshTrainCamp, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRefreshTitles, Common.n_RefreshYardMusic, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshYardRedDot, Common.n_BuildingGetNumChanged, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshYardRedDot, Common.n_BuildingPauseTaskNumChanged, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnCameraTransformChanged, Common.n_CameraTransformChanged, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshYardRedDot, Common.n_BuildingLevelUp, nil)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.RefreshYardRedDot, Common.n_GuideStatusChanged, nil)
  self:RefreshYardRedDot()
end

YardMainDialog.OnDestroy = function(self)
  -- function num : 0_2 , upvalues : _ENV
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (self._currencyFrame):Destroy()
  ;
  (DialogManager.DestroySingletonDialog)("courtyard.interactdialog")
  ;
  (DialogManager.DestroySingletonDialog)("bag.itemtipsdialog")
  ;
  (DialogManager.DestroySingletonDialog)("fastmenu.fastmenudialog")
end

YardMainDialog.RefreshCurrency = function(self)
  -- function num : 0_3 , upvalues : _ENV
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
  (self._panel):SetSize(0, cellPanelWidth, 0, self._height)
  ;
  (self._panel):SetAnchoredPosition(self._anchoredx, self._anchoredy)
  ;
  (self._currencyFrame):ReloadAllCell()
end

YardMainDialog.OnRefreshCurrency = function(self, notification)
  -- function num : 0_4 , upvalues : _ENV
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
        (self._panel):SetSize(0, cellPanelWidth, 0, self._height)
        ;
        (self._panel):SetAnchoredPosition(self._anchoredx, self._anchoredy)
      end
      for i,v in ipairs(insertList) do
        (self._currencyFrame):InsertCellsAtIndex({v})
      end
    end
  end
end

YardMainDialog.GetCurrencyIndexById = function(self, id)
  -- function num : 0_5 , upvalues : _ENV
  for i,v in ipairs(self._currencies) do
    if v.currecyId == id then
      return i
    end
  end
end

YardMainDialog.OnRefreshTitles = function(self)
  -- function num : 0_6 , upvalues : _ENV
  for k,v in pairs(self._titles) do
    local bm_building = (self._bmBuildings)[k]
    ;
    (v.title):SetActive(not bm_building or bm_building:GetLevel() > 0)
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

YardMainDialog.OnCameraTransformChanged = function(self)
  -- function num : 0_7 , upvalues : _ENV, TransformStaticFunctions, UIManager
  for k,v in pairs(self._uiPoints) do
    local actorX, actorY, actorZ = (TransformStaticFunctions.GetPosition)(v)
    local pos2 = (self._mainCamera):WorldToViewportPoint({x = actorX, y = actorY, z = actorZ})
    local screenPos = (self._mainCamera):ViewportToScreenPoint(pos2)
    local x, y = (UIManager.ScreenPointToLocalPointInRectangle)((self:GetRootWindow())._uiObject, screenPos.x, screenPos.y)
    ;
    (((self._titles)[k]).title):SetAnchoredPosition(x, y)
  end
end

YardMainDialog.Init = function(self, sceneController)
  -- function num : 0_8 , upvalues : _ENV, TransformStaticFunctions, UIManager, CEffectWordChangeConfig
  self._courtyardSceneController = sceneController
  self._mainCamera = (self._courtyardSceneController):GetMainCamera()
  self._uiPoints = ((self._courtyardSceneController)._sceneRef):GetUIPoints()
  for k,v in pairs(self._uiPoints) do
    local actorX, actorY, actorZ = (TransformStaticFunctions.GetPosition)(v)
    local pos2 = (self._mainCamera):WorldToViewportPoint({x = actorX, y = actorY, z = actorZ})
    local screenPos = (self._mainCamera):ViewportToScreenPoint(pos2)
    local x, y = (UIManager.ScreenPointToLocalPointInRectangle)((self:GetRootWindow())._uiObject, screenPos.x, screenPos.y)
    ;
    (((self._titles)[k]).title):SetAnchoredPosition(x, y)
  end
  local languageId = tonumber((((BeanManager.GetTableByName)("var.cvarconfig")):GetRecorder(101)).Value)
  for k,value in pairs(self._titles) do
    local configId = nil
    if k == DataCommon.MagicTree then
      configId = 7
    else
      if k == DataCommon.Explore then
        configId = 9
      else
        if k == DataCommon.Firefly then
          configId = 11
        else
          if k == DataCommon.Alchemy then
            configId = 6
          else
            if k == DataCommon.Cabin then
              configId = 8
            else
              if k == DataCommon.TrainCamp then
                configId = 10
              else
                if k == DataCommon.YardMusic then
                  configId = 12
                end
              end
            end
          end
        end
      end
    end
    local recorder = CEffectWordChangeConfig:GetRecorder(configId)
    local assetBundleName = recorder.assetBundle
    local assetName = nil
    if languageId == 1 then
      assetName = recorder.cn
    else
      if languageId == 2 then
        assetName = recorder.en
      else
        if languageId == 3 then
          assetName = recorder.kr
        else
          if languageId == 4 then
            assetName = recorder.jp
          end
        end
      end
    end
    ;
    (value.textEffect):AddEffectSync(assetBundleName, assetName)
  end
  self:RefreshCurrency()
  self:OnRefreshTitles()
end

YardMainDialog.RefreshYardRedDot = function(self)
  -- function num : 0_9 , upvalues : _ENV
  for k,v in pairs(self._titles) do
    if k == DataCommon.Alchemy then
      ((v.redDot).dot):SetActive(false)
    else
      local bm_building = (self._bmBuildings)[k]
      if bm_building then
        if bm_building:GetPauseTaskNum() + bm_building:GetGetNum() > 0 then
          ((v.redDot).dot):SetActive(true)
          ;
          ((v.redDot).num):SetText(bm_building:GetPauseTaskNum() + bm_building:GetGetNum())
        else
          ;
          ((v.redDot).dot):SetActive(false)
        end
      end
    end
  end
end

YardMainDialog.OnMenuBtnClick = function(self)
  -- function num : 0_10 , upvalues : _ENV
  local dialog = (DialogManager.GetDialog)("fastmenu.fastmenudialog")
  if dialog then
    (DialogManager.DestroySingletonDialog)("fastmenu.fastmenudialog")
  else
    ;
    (DialogManager.CreateSingletonDialog)("fastmenu.fastmenudialog")
  end
end

YardMainDialog.OnAddBtnClick = function(self, index)
  -- function num : 0_11 , upvalues : _ENV
  (self._courtyardSceneController):SetCameraAnimatorState(5)
  if ((NekoData.BehaviorManager).BM_Firefly):GetLevel() > 0 then
    ((DialogManager.CreateSingletonDialog)("firefly.fireflydialog")):Init(self._courtyardSceneController)
  end
end

YardMainDialog.NumberOfCell = function(self, frame)
  -- function num : 0_12
  return #self._currencies
end

YardMainDialog.CellAtIndex = function(self, frame, index)
  -- function num : 0_13
  return "courtyard.currencycell"
end

YardMainDialog.DataAtIndex = function(self, frame, index)
  -- function num : 0_14
  return (self._currencies)[index]
end

YardMainDialog.OnBackBtnClicked = function(self)
  -- function num : 0_15 , upvalues : _ENV
  local csend = (LuaNetManager.CreateProtocol)("protocol.battle.centermaincity")
  csend:Send()
  self:Destroy()
end

return YardMainDialog

