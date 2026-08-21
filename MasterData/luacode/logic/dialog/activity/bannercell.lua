-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/bannercell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local BannerCell = class("BannerCell", Dialog)
BannerCell.AssetBundleName = "ui/layouts.basemainhud"
BannerCell.AssetName = "BaseMainHUDActivityCell"
BannerCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BannerCell
  ((BannerCell.super).Ctor)(self, ...)
end

BannerCell.OnCreate = function(self)
  -- function num : 0_1
  self._image = self:GetChild("Image")
  self._time = self:GetChild("Time")
  ;
  (self._time):SetActive(false)
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClick, self)
end

BannerCell.OnDestroy = function(self)
  -- function num : 0_2
end

BannerCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CImagePathTable, _ENV
  (self._time):SetActive(true)
  ;
  (self._time):SetText((data.record).bannerTimeText)
  if not CImagePathTable:GetRecorder((data.record).bannerpicid) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._image):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
end

BannerCell.OnCellClick = function(self)
  -- function num : 0_4 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Activity):EnterActivityById((self._cellData).id)
end

return BannerCell

