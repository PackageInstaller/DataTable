-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/messagetip/functionunlockdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local CImagePath = (BeanManager.GetTableByName)("ui.cimagepath")
local CStringRes = (BeanManager.GetTableByName)("message.cstringres")
local FunctionUnlockDialog = class("FunctionUnlockDialog", Dialog)
FunctionUnlockDialog.AssetBundleName = "ui/layouts.basemainhud"
FunctionUnlockDialog.AssetName = "FunctionUnlock"
FunctionUnlockDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : FunctionUnlockDialog
  ((FunctionUnlockDialog.super).Ctor)(self, ...)
  self._groupName = "Loading"
end

FunctionUnlockDialog.OnCreate = function(self)
  -- function num : 0_1
  self._title = self:GetChild("Title")
  self._image = self:GetChild("Image")
  ;
  (self:GetRootWindow()):Subscribe_PointerClickEvent(self.OnRootWindowClicked, self)
end

FunctionUnlockDialog.OnDestroy = function(self)
  -- function num : 0_2
end

FunctionUnlockDialog.SetData = function(self, data)
  -- function num : 0_3 , upvalues : _ENV, CStringRes, CImagePath
  local str = (TextManager.GetText)((CStringRes:GetRecorder(data.textID)).msgTextID)
  ;
  (self._title):SetText(str)
  if data.tips ~= 0 then
    local imageRecord = CImagePath:GetRecorder(data.tips)
    ;
    (self._image):SetSprite(imageRecord.assetBundle, imageRecord.assetName)
  end
end

FunctionUnlockDialog.OnRootWindowClicked = function(self)
  -- function num : 0_4
  self:Destroy()
end

return FunctionUnlockDialog

