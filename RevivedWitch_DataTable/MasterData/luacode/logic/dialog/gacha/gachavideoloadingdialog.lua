-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/gacha/gachavideoloadingdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GachaVideoLoadingDialog = class("GachaVideoLoadingDialog", Dialog)
GachaVideoLoadingDialog.AssetBundleName = "ui/layouts.loading"
GachaVideoLoadingDialog.AssetName = "gacharesultskip"
GachaVideoLoadingDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GachaVideoLoadingDialog
  ((GachaVideoLoadingDialog.super).Ctor)(self, ...)
  self._groupName = "Loading"
end

GachaVideoLoadingDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._skipBtn = self:GetChild("SkipBtn")
  ;
  (self._skipBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  local dialog = (DialogManager.GetDialog)("gacha.gachamoviedialog")
  if not dialog then
    (self._skipBtn):SetActive(false)
  end
end

GachaVideoLoadingDialog.OnDestroy = function(self)
  -- function num : 0_2
end

GachaVideoLoadingDialog.OnBackBtnClicked = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local dialog = (DialogManager.GetDialog)("gacha.gachamoviedialog")
  if dialog then
    dialog:OnSkipButtonClick()
  end
  self:Destroy()
end

return GachaVideoLoadingDialog

