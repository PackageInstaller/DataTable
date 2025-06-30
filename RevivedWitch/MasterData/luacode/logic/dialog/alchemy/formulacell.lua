-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/alchemy/formulacell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CAlchemyPicRes = (BeanManager.GetTableByName)("courtyard.calchemypicres")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local Item = require("logic.manager.experimental.types.item")
local MaterialMaxNum = 3
local FormulaCell = class("FormulaCell", Dialog)
FormulaCell.AssetBundleName = "ui/layouts.yard"
FormulaCell.AssetName = "AlchemyChooseCell"
FormulaCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : FormulaCell
  ((FormulaCell.super).Ctor)(self, ...)
  self._mainProductItem = nil
  self._materialItems = {}
  self._formulaId = nil
end

FormulaCell.OnCreate = function(self)
  -- function num : 0_1 , upvalues : MaterialMaxNum
  self._mainProductPanel = {}
  -- DECOMPILER ERROR at PC6: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._mainProductPanel).frame = self:GetChild("ResultItemBack")
  -- DECOMPILER ERROR at PC11: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._mainProductPanel).icon = self:GetChild("ResultItem")
  -- DECOMPILER ERROR at PC16: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._mainProductPanel).num = self:GetChild("Num")
  -- DECOMPILER ERROR at PC21: Confused about usage of register: R1 in 'UnsetPending'

  ;
  (self._mainProductPanel).name = self:GetChild("ItemName")
  self._materialPanels = {}
  for i = 1, MaterialMaxNum do
    do
      -- DECOMPILER ERROR at PC30: Confused about usage of register: R5 in 'UnsetPending'

      (self._materialPanels)[i] = {}
      local map = (self._materialPanels)[i]
      map.material = self:GetChild("MaterialArea/Material" .. i)
      map.frame = self:GetChild("MaterialArea/Material" .. i .. "/MaterialBack")
      map.icon = self:GetChild("MaterialArea/Material" .. i .. "/Item")
      map.name = self:GetChild("MaterialArea/Material" .. i .. "/Name")
      map.haveNum = self:GetChild("MaterialArea/Material" .. i .. "/Num")
      map.haveNumRed = self:GetChild("MaterialArea/Material" .. i .. "/NumRed")
      map.costNum = self:GetChild("MaterialArea/Material" .. i .. "/NumMax")
      ;
      (map.icon):Subscribe_PointerClickEvent(function()
    -- function num : 0_1_0 , upvalues : self, i
    self:OnMaterialClicked(i)
  end
)
    end
  end
  self._addPanels = {}
  for i = 1, MaterialMaxNum - 1 do
    -- DECOMPILER ERROR at PC100: Confused about usage of register: R5 in 'UnsetPending'

    (self._addPanels)[i] = self:GetChild("MaterialArea/Add" .. i)
  end
  self._select = self:GetChild("Select")
  ;
  ((self._mainProductPanel).icon):Subscribe_LongPressEvent(self.OnMainProductClicked, self)
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

FormulaCell.OnDestroy = function(self)
  -- function num : 0_2
end

FormulaCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, Item, CAlchemyPicRes, CImagePathTable, MaterialMaxNum
  while (self._materialItems)[#self._materialItems] do
    (table.remove)(self._materialItems, #self._materialItems)
  end
  self._mainProductItem = (Item.Create)(data.outcome)
  local alchemyPicResRecord = CAlchemyPicRes:GetRecorder((self._mainProductItem):GetPinJiID())
  local imageRecord = (self._mainProductItem):GetIcon()
  ;
  ((self._mainProductPanel).icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  if not CImagePathTable:GetRecorder(alchemyPicResRecord.materialpageframe) then
    imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  ((self._mainProductPanel).frame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  ((self._mainProductPanel).num):SetText(data.outcomeNum)
  ;
  ((self._mainProductPanel).name):SetText((self._mainProductItem):GetName())
  self._canSelect = true
  local materialNum = #data.items
  for i = 1, materialNum do
    local panel = (self._materialPanels)[i]
    ;
    (panel.material):SetActive(true)
    local tmp = i - 1
    if tmp <= 0 then
      ((self._addPanels)[tmp]):SetActive(not (self._addPanels)[tmp])
      local itemId = (data.items)[i]
      local item = (Item.Create)(itemId)
      ;
      (table.insert)(self._materialItems, item)
      local stock = 0
      if (string.sub)(itemId, 1, 2) == "35" then
        stock = ((NekoData.BehaviorManager).BM_Currency):GetCurrencyNum(itemId)
      else
        stock = ((NekoData.BehaviorManager).BM_BagInfo):GetItemCountById(itemId)
      end
      do
        local cost = (data.num)[i]
        if cost <= stock then
          (panel.haveNum):SetActive(true)
          ;
          (panel.haveNumRed):SetActive(false)
          ;
          (panel.haveNum):SetText(stock)
        else
          self._canSelect = false
          ;
          (panel.haveNum):SetActive(false)
          ;
          (panel.haveNumRed):SetActive(true)
          ;
          (panel.haveNumRed):SetText(stock)
        end
        ;
        (panel.costNum):SetText(cost)
        alchemyPicResRecord = CAlchemyPicRes:GetRecorder(item:GetPinJiID())
        if not CImagePathTable:GetRecorder(alchemyPicResRecord.materialpageframe) then
          imageRecord = DataCommon.DefaultImageAsset
        end
        ;
        (panel.frame):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
        imageRecord = item:GetIcon()
        ;
        (panel.icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
        ;
        (panel.name):SetText(item:GetName())
        -- DECOMPILER ERROR at PC184: LeaveBlock: unexpected jumping out IF_THEN_STMT

        -- DECOMPILER ERROR at PC184: LeaveBlock: unexpected jumping out IF_STMT

      end
    end
  end
  for i = materialNum + 1, MaterialMaxNum do
    (((self._materialPanels)[i]).material):SetActive(false)
    local tmp = i - 1
    if (self._addPanels)[tmp] then
      ((self._addPanels)[tmp]):SetActive(false)
    end
  end
  local selectFormulaId = ((self._delegate)._delegate)._selectFormulaId
  ;
  (self._select):SetActive(not selectFormulaId or selectFormulaId == data.id)
  self._formulaId = data.id
  -- DECOMPILER ERROR: 10 unprocessed JMP targets
end

FormulaCell.OnMainProductClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if not ((self._delegate)._delegate)._willDestroy then
    local width, height = ((self._mainProductPanel).icon):GetRectSize()
    local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
    if tipsDialog then
      tipsDialog:Init({item = self._mainProductItem})
      tipsDialog:SetTipsPosition(width, height, ((self._mainProductPanel).icon):GetLocalPointInUiRootPanel())
    end
  end
end

FormulaCell.OnMaterialClicked = function(self, index)
  -- function num : 0_5 , upvalues : _ENV
  if not ((self._delegate)._delegate)._willDestroy then
    local width, height = (((self._materialPanels)[index]).material):GetRectSize()
    local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
    if tipsDialog then
      tipsDialog:Init({item = (self._materialItems)[index]})
      tipsDialog:SetTipsPosition(width, height, (((self._materialPanels)[index]).material):GetLocalPointInUiRootPanel())
    end
  end
end

FormulaCell.OnCellClicked = function(self)
  -- function num : 0_6 , upvalues : _ENV
  if not ((self._delegate)._delegate)._willDestroy then
    if self._canSelect then
      local dialog = (DialogManager.GetDialog)("alchemy.alchemydialog")
      if dialog then
        dialog:ChooseFormula(self._formulaId)
      end
      ;
      (DialogManager.DestroySingletonDialog)("alchemy.chooseformuladialog")
    else
      do
        ;
        ((NekoData.BehaviorManager).BM_Message):SendMessageById(100168)
      end
    end
  end
end

return FormulaCell

