-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/activity/loverunlockdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local LoverUnlockDialog = class("LoverUnlockDialog", Dialog)
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
LoverUnlockDialog.AssetBundleName = "ui/layouts.activityvalentines"
LoverUnlockDialog.AssetName = "ActivityValentinesStart"
LoverUnlockDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : LoverUnlockDialog
  ((LoverUnlockDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

LoverUnlockDialog.OnCreate = function(self)
  -- function num : 0_1
  self._goBtn = self:GetChild("BackImage/GoBtn")
  self._closeBtn = self:GetChild("BackImage/CloseBtn")
  self._backImage = self:GetChild("BackImage")
  ;
  (self._goBtn):Subscribe_PointerClickEvent(self.OnGoBtnClicked, self)
  ;
  (self._closeBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

LoverUnlockDialog.Init = function(self)
  -- function num : 0_2 , upvalues : CImagePathTable, _ENV
  if not CImagePathTable:GetRecorder(13835) then
    local image = DataCommon.DefaultImageAsset
  end
  ;
  (self._backImage):SetSprite(image.assetBundle, image.assetName)
end

LoverUnlockDialog.OnDestroy = function(self)
  -- function num : 0_3
end

LoverUnlockDialog.OnGoBtnClicked = function(self)
  -- function num : 0_4 , upvalues : _ENV
  local protocol = (LuaNetManager.CreateProtocol)("protocol.activity.cgetloveractivityinfo")
  if protocol then
    protocol:Send()
  end
end

LoverUnlockDialog.OnBackBtnClicked = function(self)
  -- function num : 0_5
  self:Destroy()
end

return LoverUnlockDialog

