-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/activitylistcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local ActivityListCell = class("ActivityListCell", Dialog)
ActivityListCell.AssetBundleName = "ui/layouts.activityhud"
ActivityListCell.AssetName = "ActivityListCell"
ActivityListCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : ActivityListCell
  ((ActivityListCell.super).Ctor)(self, ...)
end

ActivityListCell.OnCreate = function(self)
  -- function num : 0_1
  self._image = self:GetChild("Activity")
  self._reddot = self:GetChild("Activity/RedDot")
  ;
  (self._reddot):SetActive(false)
  self._time = self:GetChild("Activity/Time")
  ;
  (self._time):SetActive(false)
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClick, self)
end

ActivityListCell.OnDestroy = function(self)
  -- function num : 0_2
end

ActivityListCell.RefreshCell = function(self, data)
  -- function num : 0_3 , upvalues : CImagePathTable, _ENV
  if not CImagePathTable:GetRecorder((data.record).bannerpicid) then
    local imageRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._image):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._reddot):SetActive(data.showRedDot)
  ;
  (self._time):SetActive(true)
  ;
  (self._time):SetText((data.record).bannerTimeText)
end

ActivityListCell.OnCellClick = function(self)
  -- function num : 0_4 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Activity):EnterActivityById((self._cellData).id)
end

return ActivityListCell

