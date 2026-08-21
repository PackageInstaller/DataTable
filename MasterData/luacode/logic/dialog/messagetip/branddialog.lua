-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/messagetip/branddialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local BrandDialog = class("BrandDialog", Dialog)
BrandDialog.AssetBundleName = "ui/layouts.secondconfirm"
BrandDialog.AssetName = "BrandDialog"
BrandDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : BrandDialog
  ((BrandDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

BrandDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._icon = self:GetChild("IconImage")
  self._title = self:GetChild("TitleText")
  self._text = self:GetChild("ContentText")
  ;
  ((((CS.PixelNeko).Animation).EventTriggerHelper).AddStateUpdateListener)((self:GetRootWindow()):GetUIObject(), self.OnStateUpdate, self)
end

BrandDialog.OnDestroy = function(self)
  -- function num : 0_2
end

BrandDialog.Refresh = function(self)
  -- function num : 0_3 , upvalues : _ENV
  local recorder = ((BeanManager.GetTableByName)("ui.cimagepath")):GetRecorder((self._cfg).img)
  ;
  (self._icon):SetSprite(recorder.assetBundle, recorder.assetName)
  ;
  (self._text):SetText((TextManager.GetText)((self._cfg).contentTextID))
  ;
  (self._title):SetText((TextManager.GetText)((self._cfg).titleTextID))
end

BrandDialog.SetData = function(self, id)
  -- function num : 0_4 , upvalues : _ENV
  self._cfg = ((BeanManager.GetTableByName)("popups.cpopupgetitem")):GetRecorder(tonumber(id))
  if not self._cfg then
    LogError("tip", "invalid cpopupgetitem id " .. id)
  end
  self:Refresh()
end

BrandDialog.OnStateUpdate = function(self, handle, stateName, normalizedTime)
  -- function num : 0_5
  self:Destroy()
end

return BrandDialog

