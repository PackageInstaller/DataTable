-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/gacha/dotcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local DotCell = class("DotCell", Dialog)
DotCell.AssetBundleName = "ui/layouts.gacha"
DotCell.AssetName = "GachaMainPageDotsCell"
DotCell.OnCreate = function(self)
  -- function num : 0_0
  self._dotGrey = self:GetChild("Dot0")
  self._dotLight = self:GetChild("Dot1")
end

DotCell.OnDestroy = function(self)
  -- function num : 0_1
end

DotCell.RefreshCell = function(self, data)
  -- function num : 0_2
  if data == (self._delegate)._selectedPoolIndex then
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

DotCell.OnEvent = function(self, eventName, arg)
  -- function num : 0_3
  if eventName == "SetPageDot" then
    if self._cellData == (self._delegate)._selectedPoolIndex then
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
end

return DotCell

