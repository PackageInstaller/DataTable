-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/courtcabin/themefurniturecell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ThemeFurnitureCell = class("ThemeFurnitureCell", Dialog)
ThemeFurnitureCell.AssetBundleName = "ui/layouts.yard"
ThemeFurnitureCell.AssetName = "HouseThemeCellSmall"
ThemeFurnitureCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ThemeFurnitureCell
  ((ThemeFurnitureCell.super).Ctor)(self, ...)
end

ThemeFurnitureCell.OnCreate = function(self)
  -- function num : 0_1
  self._icon = self:GetChild("Back/Item")
  self._comfortIcon = self:GetChild("Back/ComfortableImg")
  self._comfortNum = self:GetChild("Back/ComfortableNum")
  self._name = self:GetChild("Back/Name")
  self._disable = self:GetChild("Back/Grey")
end

ThemeFurnitureCell.OnDestroy = function(self)
  -- function num : 0_2
end

ThemeFurnitureCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  local imageRecord = (data.item):GetIcon()
  ;
  (self._icon):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._name):SetText((data.item):GetName())
  local comfort = (data.item):GetComfort()
  ;
  (self._comfortNum):SetText(comfort)
  local imgRecord = ((NekoData.BehaviorManager).BM_Cabin):GetComfortImageRecord()
  if imgRecord then
    (self._comfortIcon):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
  else
    LogError("comfort imgRecord is nil.")
  end
  if data.disable then
    (self._disable):SetActive(true)
  else
    ;
    (self._disable):SetActive(false)
  end
end

return ThemeFurnitureCell

