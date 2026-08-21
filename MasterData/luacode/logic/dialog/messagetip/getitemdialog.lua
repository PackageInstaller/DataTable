-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/messagetip/getitemdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local GetItemDialog = class("GetItemDialog", Dialog)
GetItemDialog.AssetBundleName = "ui/layouts.secondconfirm"
GetItemDialog.AssetName = "GetItemDialog"
GetItemDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : GetItemDialog
  ((GetItemDialog.super).Ctor)(self, ...)
  self._groupName = "Modal"
end

GetItemDialog.OnCreate = function(self)
  -- function num : 0_1
  self._title = self:GetChild("TitleText")
  self._text = self:GetChild("ContentText")
  self._exit = self:GetChild("ConfirmButton")
  self._icon = self:GetChild("IconImage")
  ;
  (self._exit):Subscribe_PointerClickEvent(self.OnCloseClick, self)
end

GetItemDialog.OnDestroy = function(self)
  -- function num : 0_2
end

GetItemDialog.Refresh = function(self)
  -- function num : 0_3 , upvalues : _ENV
  if not ((BeanManager.GetTableByName)("ui.cimagepath")):GetRecorder((self._cfg).img) then
    local recorder = DataCommon.DefaultImageAsset
  end
  ;
  (self._icon):SetSprite(recorder.assetBundle, recorder.assetName)
  ;
  (self._text):SetText((TextManager.GetText)((self._cfg).contentTextID))
  ;
  (self._title):SetText((TextManager.GetText)((self._cfg).titleTextID))
end

GetItemDialog.SetData = function(self, id)
  -- function num : 0_4 , upvalues : _ENV
  self._cfg = ((BeanManager.GetTableByName)("popups.cpopupgetitem")):GetRecorder(tonumber(id))
  if not self._cfg then
    LogError("tip", "invalid cpopupgetitem id " .. id)
  end
  self:Refresh()
end

GetItemDialog.OnCloseClick = function(self)
  -- function num : 0_5
  if not self._closing then
    self._closing = true
    ;
    (self:GetRootWindow()):Subscribe_AnimationEvent((self._cfg).endAni, self.OnAnimatorStateExit, self)
    ;
    (self:GetRootWindow()):PlayAnimation((self._cfg).endAni)
  end
end

GetItemDialog.OnAnimatorStateExit = function(self, handle, stateName, normalizedTime)
  -- function num : 0_6
  self:Destroy()
end

return GetItemDialog

