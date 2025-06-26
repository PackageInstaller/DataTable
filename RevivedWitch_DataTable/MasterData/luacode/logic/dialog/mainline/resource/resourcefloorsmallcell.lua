-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/mainline/resource/resourcefloorsmallcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local ResourceFloorSmallCell = class("ResourceFloorSmallCell", Dialog)
ResourceFloorSmallCell.AssetBundleName = "ui/layouts.mainline"
ResourceFloorSmallCell.AssetName = "DungeonSelectCellSmall"
ResourceFloorSmallCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ResourceFloorSmallCell
  ((ResourceFloorSmallCell.super).Ctor)(self, ...)
end

ResourceFloorSmallCell.OnCreate = function(self)
  -- function num : 0_1
  self._finishNo = self:GetChild("FinishNo")
  self._finishNoSelect = self:GetChild("FinishNoSelect")
  ;
  (self._finishNoSelect):SetActive(false)
  self._finish = self:GetChild("Finish")
  self._finishSelect = self:GetChild("FinishSelect")
  ;
  (self._finishSelect):SetActive(false)
end

ResourceFloorSmallCell.OnDestroy = function(self)
  -- function num : 0_2
end

local SetStatusActive = function(self, f1, f2, f3, f4)
  -- function num : 0_3
  (self._finish):SetActive(f1)
  ;
  (self._finishNo):SetActive(f2)
  ;
  (self._finishSelect):SetActive(f3)
  ;
  (self._finishNoSelect):SetActive(f4)
end

ResourceFloorSmallCell.RefreshCell = function(self, data)
  -- function num : 0_4 , upvalues : SetStatusActive, _ENV
  self._data = data
  if data.firstGet then
    SetStatusActive(self, true, false, false, false)
    self._assetName = (EffectUtil.GetAssetBundleNameAndAssetName)(1021)
  else
    SetStatusActive(self, false, true, false, false)
    self._assetName = (EffectUtil.GetAssetBundleNameAndAssetName)(1020)
  end
end

ResourceFloorSmallCell.OnEvent = function(self, eventName, args)
  -- function num : 0_5 , upvalues : SetStatusActive
  if eventName == "SetSelected" then
    if args == (self._data).bigParentId then
      local finish = (self._data).firstGet
      if finish then
        SetStatusActive(self, false, false, true, false)
      else
        SetStatusActive(self, false, false, false, true)
      end
    else
      do
        local finish = (self._data).firstGet
        if finish then
          SetStatusActive(self, true, false, false, false)
        else
          SetStatusActive(self, false, true, false, false)
        end
      end
    end
  end
end

ResourceFloorSmallCell.SetPosition = function(self, ax, x, ay, y)
  -- function num : 0_6
  (self:GetRootWindow()):SetPosition(ax, x, ay, y)
end

return ResourceFloorSmallCell

