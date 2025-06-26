-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/login/updatejumpstoredialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local UpdateJumpStoreDialog = class("UpdateJumpStoreDialog", Dialog)
UpdateJumpStoreDialog.AssetBundleName = "ui/layouts.secondconfirm"
UpdateJumpStoreDialog.AssetName = "SecondConfirmHighLevel"
UpdateJumpStoreDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : UpdateJumpStoreDialog
  ((UpdateJumpStoreDialog.super).Ctor)(self, ...)
  self._groupName = "ClickEffect"
end

UpdateJumpStoreDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  (self:GetChild("Text")):SetText(((NekoData.BehaviorManager).BM_Message):GetString(1637))
  self._confirmBtn = self:GetChild("ConfirmButton")
  self._cancleBtn = self:GetChild("CancelButton")
  ;
  (self._confirmBtn):Subscribe_PointerClickEvent(self.OnConfirmBtnClicked, self)
  ;
  (self._cancleBtn):Subscribe_PointerClickEvent(self.OnCancleBtnClicked, self)
end

UpdateJumpStoreDialog.OnDestroy = function(self)
  -- function num : 0_2
end

UpdateJumpStoreDialog.OnConfirmBtnClicked = function(self)
  -- function num : 0_3 , upvalues : _ENV
  ((NekoData.BehaviorManager).BM_Game):JumpToTheStore(2)
end

UpdateJumpStoreDialog.OnCancleBtnClicked = function(self)
  -- function num : 0_4
  self:Destroy()
end

return UpdateJumpStoreDialog

