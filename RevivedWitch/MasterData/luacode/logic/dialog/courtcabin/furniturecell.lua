-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/courtcabin/furniturecell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local FurnitureCell = class("FurnitureCell", Dialog)
FurnitureCell.AssetBundleName = "ui/layouts.yard"
FurnitureCell.AssetName = "HouseDecorateItemCell"
FurnitureCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : FurnitureCell
  ((FurnitureCell.super).Ctor)(self, ...)
end

FurnitureCell.OnCreate = function(self)
  -- function num : 0_1
  self._icon = self:GetChild("Back/Item")
  self._restNum = self:GetChild("Back/Num")
  self._comfortIcon = self:GetChild("Back/ComfortableImg")
  self._comfortNum = self:GetChild("Back/ComfortableNum")
  self._name = self:GetChild("Back/Name")
  self._disable = self:GetChild("Grey")
  self._usingPanel = self:GetChild("Using")
  self._using = self:GetChild("Using/Using")
  self._reduceBtn = self:GetChild("Using/Using/Reduce")
  self._reachLimit = self:GetChild("Using/Txt")
  self._empty = self:GetChild("Empty")
  ;
  (self._empty):SetActive(false)
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClicked, self)
  ;
  (self._reduceBtn):Subscribe_PointerClickEvent(self.OnReduceClicked, self)
end

FurnitureCell.OnDestroy = function(self)
  -- function num : 0_2
end

FurnitureCell.RefreshCell = function(self, data)
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
  if data.using then
    (self._restNum):SetActive(false)
    ;
    (self._disable):SetActive(false)
    ;
    (self._using):SetActive(true)
    ;
    (self._reachLimit):SetActive(false)
  else
    if data.enable then
      (self._restNum):SetActive(true)
      ;
      (self._disable):SetActive(false)
      ;
      (self._using):SetActive(false)
      ;
      (self._reachLimit):SetActive(false)
      ;
      (self._restNum):SetText(data.num)
    else
      if data.disable then
        (self._restNum):SetActive(true)
        ;
        (self._disable):SetActive(true)
        ;
        (self._using):SetActive(false)
        ;
        (self._reachLimit):SetActive(false)
        ;
        (self._restNum):SetText(data.num)
      else
        if data.reachLimit then
          (self._restNum):SetActive(true)
          ;
          (self._disable):SetActive(false)
          ;
          (self._using):SetActive(false)
          ;
          (self._reachLimit):SetActive(true)
          ;
          (self._restNum):SetText(data.num)
        end
      end
    end
  end
end

FurnitureCell.OnCellClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  if (self._cellData).enable then
    ((self._delegate)._delegate):UseFurniture(self._cellData)
  else
    if (self._cellData).using then
      (LuaNotificationCenter.PostNotification)(Common.n_SelectFurniture, self, {layerId = ((self._cellData).item):GetLayerId(), key = (self._cellData).key})
    end
  end
end

FurnitureCell.OnReduceClicked = function(self)
  -- function num : 0_5
  if (self._cellData).using then
    ((self._delegate)._delegate):UnloadFurniture(self._cellData)
  end
end

return FurnitureCell

