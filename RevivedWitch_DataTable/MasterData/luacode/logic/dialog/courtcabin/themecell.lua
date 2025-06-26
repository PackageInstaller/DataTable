-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/courtcabin/themecell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local FurnitureItem = require("logic.manager.experimental.types.furnitureitem")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local FurnitureCell = class("FurnitureCell", Dialog)
FurnitureCell.AssetBundleName = "ui/layouts.yard"
FurnitureCell.AssetName = "HouseDecorateThemeCell"
FurnitureCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : FurnitureCell
  ((FurnitureCell.super).Ctor)(self, ...)
end

FurnitureCell.OnCreate = function(self)
  -- function num : 0_1
  self._furnitureBack = self:GetChild("Back")
  self._icon = self:GetChild("Back/Item")
  self._comfortIcon = self:GetChild("Back/ComfortableImg")
  self._comfortNum = self:GetChild("Back/ComfortableNum")
  self._name = self:GetChild("Back/Name")
  self._num = self:GetChild("Back/Num")
  self._empty = self:GetChild("Empty")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

FurnitureCell.OnDestroy = function(self)
  -- function num : 0_2
end

FurnitureCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, FurnitureItem, CImagePathTable
  if data.addDiyThemeBtn then
    (self._furnitureBack):SetActive(false)
    ;
    (self._empty):SetActive(true)
  else
    ;
    (self._furnitureBack):SetActive(true)
    ;
    (self._empty):SetActive(false)
    local comfort = 0
    local imgRecord = ((NekoData.BehaviorManager).BM_Cabin):GetComfortImageRecord()
    if imgRecord then
      (self._comfortIcon):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
    else
      LogError("comfort imgRecord is nil.")
    end
    local furnitureNum = 0
    if data.tag == "Recommend" then
      for i,v in ipairs((data.recorder).items) do
        local item = (FurnitureItem.Create)(v)
        comfort = comfort + item:GetComfort()
        furnitureNum = furnitureNum + ((NekoData.BehaviorManager).BM_BagInfo):GetFurnitureCountById(item:GetID())
      end
      ;
      (self._name):SetText((data.recorder).name)
      imgRecord = CImagePathTable:GetRecorder((data.recorder).image)
      ;
      (self._icon):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
    else
      for i,v in ipairs((data.themeInfo).furniturePositions) do
        local item = (FurnitureItem.Create)(v.itemId)
        comfort = comfort + item:GetComfort()
        furnitureNum = furnitureNum + ((NekoData.BehaviorManager).BM_BagInfo):GetFurnitureCountById(item:GetID())
      end
      ;
      (self._name):SetText((data.themeInfo).name)
    end
    ;
    (self._num):SetText(furnitureNum)
    ;
    (self._comfortNum):SetText(comfort)
  end
end

FurnitureCell.OnCellClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if (self._cellData).addDiyThemeBtn then
    (DialogManager.CreateSingletonDialog)("courtcabin.adddiythemedialog")
  else
    if (self._cellData).tag == "Recommend" then
      ((DialogManager.CreateSingletonDialog)("courtcabin.recommendthemedialog")):Init(((self._cellData).recorder).id)
    else
      if (self._cellData).tag == "DIY" then
        ((DialogManager.CreateSingletonDialog)("courtcabin.diythemedialog")):Init((self._cellData).themeInfo)
      end
    end
  end
end

return FurnitureCell

