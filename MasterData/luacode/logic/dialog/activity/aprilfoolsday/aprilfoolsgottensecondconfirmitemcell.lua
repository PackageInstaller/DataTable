-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/aprilfoolsday/aprilfoolsgottensecondconfirmitemcell.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local AprilFoolsGottenSecondConfirmItemCell = class("AprilFoolsGottenSecondConfirmItemCell", Dialog)
AprilFoolsGottenSecondConfirmItemCell.AssetBundleName = "ui/layouts.activityaprilfools"
AprilFoolsGottenSecondConfirmItemCell.AssetName = "ActivityAprilFoolsCellItem"
AprilFoolsGottenSecondConfirmItemCell.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : AprilFoolsGottenSecondConfirmItemCell
  ((AprilFoolsGottenSecondConfirmItemCell.super).Ctor)(self, ...)
end

AprilFoolsGottenSecondConfirmItemCell.OnCreate = function(self)
  -- function num : 0_1
  self._frameBackImg = self:GetChild("Panel/ItemCell/_BackGround/Frame")
  self._iconImg = self:GetChild("Panel/ItemCell/_BackGround/Icon")
  self._num = self:GetChild("Panel/ItemCell/_Count")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnCellClick, self)
end

AprilFoolsGottenSecondConfirmItemCell.OnDestroy = function(self)
  -- function num : 0_2
end

AprilFoolsGottenSecondConfirmItemCell.RefreshCell = function(self, data)
  -- function num : 0_3
  local imageRecord = (data.item):GetIcon()
  ;
  (self._iconImg):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  imageRecord = (data.item):GetPinJiImage()
  ;
  (self._frameBackImg):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  ;
  (self._num):SetNumber(data.num)
end

AprilFoolsGottenSecondConfirmItemCell.OnCellClick = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local width, height = (self:GetRootWindow()):GetRectSize()
  local tipsDialog = (DialogManager.CreateSingletonDialog)("bag.itemtipsdialog")
  if tipsDialog then
    tipsDialog:Init(self._cellData)
    tipsDialog:SetTipsPosition(width, height, (self:GetRootWindow()):GetLocalPointInUiRootPanel())
  end
end

return AprilFoolsGottenSecondConfirmItemCell

