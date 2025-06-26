-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/courtcabin/recommendthemecell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local FurnitureItem = require("logic.manager.experimental.types.furnitureitem")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local RecommendThemeCell = class("RecommendThemeCell", Dialog)
RecommendThemeCell.AssetBundleName = "ui/layouts.yard"
RecommendThemeCell.AssetName = "HouseThemeCell1"
RecommendThemeCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : RecommendThemeCell
  ((RecommendThemeCell.super).Ctor)(self, ...)
end

RecommendThemeCell.OnCreate = function(self)
  -- function num : 0_1
  self._icon = self:GetChild("Normal/Img")
  self._comfortIcon = self:GetChild("Normal/ComfortableImg")
  self._comfortNum = self:GetChild("Normal/ComfortableNum")
  self._name = self:GetChild("Normal/Name")
  self._select = self:GetChild("Normal/Select")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
end

RecommendThemeCell.OnDestroy = function(self)
  -- function num : 0_2
end

RecommendThemeCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, FurnitureItem, CImagePathTable
  local comfort = 0
  for i,v in ipairs(data.items) do
    local item = (FurnitureItem.Create)(v)
    comfort = comfort + item:GetComfort()
  end
  ;
  (self._comfortNum):SetText(comfort)
  ;
  (self._name):SetText(data.name)
  local imgRecord = CImagePathTable:GetRecorder(data.imageBig)
  ;
  (self._icon):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
  ;
  (self._select):SetActive(data.id == (self._delegate)._themeId)
  imgRecord = ((NekoData.BehaviorManager).BM_Cabin):GetComfortImageRecord()
  if imgRecord then
    (self._comfortIcon):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
  else
    LogError("comfort imgRecord is nil.")
  end
  -- DECOMPILER ERROR: 3 unprocessed JMP targets
end

RecommendThemeCell.OnCellClicked = function(self)
  -- function num : 0_4
  (self._delegate):SelectTheme((self._cellData).id)
end

RecommendThemeCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_5
  if (self._cellData).id ~= arg then
    (self._select):SetActive(eventName ~= "SelectTheme")
    -- DECOMPILER ERROR: 2 unprocessed JMP targets
  end
end

return RecommendThemeCell

