-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/bannerdotcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BannerDotCell = class("BannerDotCell", Dialog)
BannerDotCell.AssetBundleName = "ui/layouts.basemainhud"
BannerDotCell.AssetName = "BaseMainHUDActivityDot"
BannerDotCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BannerDotCell
  ((BannerDotCell.super).Ctor)(self, ...)
end

BannerDotCell.OnCreate = function(self)
  -- function num : 0_1
  self._dotGrey = self:GetChild("Dot0")
  self._dotLight = self:GetChild("Dot1")
end

BannerDotCell.OnDestroy = function(self)
  -- function num : 0_2
end

local Refresh = function(self)
  -- function num : 0_3
  if (self._delegate)._curActivityIndex and (self._cellData).id == (((self._delegate)._bannerList)[(self._delegate)._curActivityIndex]).id then
    (self._dotGrey):SetActive(false)
    ;
    (self._dotLight):SetActive(true)
  else
    ;
    (self._dotGrey):SetActive(true)
    ;
    (self._dotLight):SetActive(false)
  end
end

BannerDotCell.RefreshCell = function(self, data)
  -- function num : 0_4 , upvalues : Refresh
  Refresh(self)
end

BannerDotCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_5 , upvalues : Refresh
  if eventName == "SetPageDot" then
    Refresh(self)
  end
end

return BannerDotCell

