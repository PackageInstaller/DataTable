-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/courtcabin/furniturecomfortcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CFurnitureItem = (BeanManager.GetTableByName)("item.cfurnitureitem")
local FurnitureComfortCell = class("FurnitureComfortCell", Dialog)
FurnitureComfortCell.AssetBundleName = "ui/layouts.yard"
FurnitureComfortCell.AssetName = "HouseComfortableCell"
FurnitureComfortCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : FurnitureComfortCell
  ((FurnitureComfortCell.super).Ctor)(self, ...)
end

FurnitureComfortCell.OnCreate = function(self)
  -- function num : 0_1
  self._name = self:GetChild("Name")
  self._comfortNum = self:GetChild("Num")
  self._comfortIcon = self:GetChild("Image")
end

FurnitureComfortCell.OnDestroy = function(self)
  -- function num : 0_2
end

FurnitureComfortCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : _ENV
  (self._name):SetText(data:GetName())
  ;
  (self._comfortNum):SetText(data:GetComfort())
  local imgRecord = ((NekoData.BehaviorManager).BM_Cabin):GetComfortImageRecord()
  if imgRecord then
    (self._comfortIcon):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
  else
    LogError("comfort imgRecord is nil.")
  end
end

return FurnitureComfortCell

