-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/magictree/magictreelvupsuccessdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CTreeLvUp = (BeanManager.GetTableByName)("courtyard.ctreelvup")
local CImagePathTable = (BeanManager.GetTableByName)("ui.cimagepath")
local MagicTreeLvUpSuccessDialog = class("MagicTreeLvUpSuccessDialog", Dialog)
MagicTreeLvUpSuccessDialog.AssetBundleName = "ui/layouts.yard"
MagicTreeLvUpSuccessDialog.AssetName = "MagicTreeNewAni"
MagicTreeLvUpSuccessDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : MagicTreeLvUpSuccessDialog
  ((MagicTreeLvUpSuccessDialog.super).Ctor)(self, ...)
  self._groupName = "Tip"
end

MagicTreeLvUpSuccessDialog.OnCreate = function(self)
  -- function num : 0_1
  self._image = self:GetChild("Tree")
  self._lastLv = self:GetChild("Lv/Txt2")
  self._curLv = self:GetChild("Lv/Txt3")
  ;
  (self._rootWindow):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
end

MagicTreeLvUpSuccessDialog.OnDestroy = function(self)
  -- function num : 0_2
end

MagicTreeLvUpSuccessDialog.Init = function(self, lastLv, curLv)
  -- function num : 0_3 , upvalues : CTreeLvUp, CImagePathTable, _ENV
  local record = CTreeLvUp:GetRecorder(curLv)
  if not CImagePathTable:GetRecorder(record.image) then
    local imgRecord = DataCommon.DefaultImageAsset
  end
  ;
  (self._image):SetSprite(imgRecord.assetBundle, imgRecord.assetName)
  ;
  (self._lastLv):SetText(lastLv)
  ;
  (self._curLv):SetText(curLv)
end

MagicTreeLvUpSuccessDialog.OnBackBtnClicked = function(self)
  -- function num : 0_4
  self:Destroy()
end

return MagicTreeLvUpSuccessDialog

