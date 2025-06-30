-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/dialog/character/newcharbreaksecondconfirmdialog.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local NewCharBreakBreakSecondConfirmDialog = class("NewCharBreakBreakSecondConfirmDialog", Dialog)
NewCharBreakBreakSecondConfirmDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
NewCharBreakBreakSecondConfirmDialog.AssetName = "CharBreakSecondConfirm"
NewCharBreakBreakSecondConfirmDialog.Ctor = function(self, ...)
  -- function num : 0_0 , upvalues : NewCharBreakBreakSecondConfirmDialog
  ((NewCharBreakBreakSecondConfirmDialog.super).Ctor)(self, ...)
  self._groupName = "SecondConfirm"
end

NewCharBreakBreakSecondConfirmDialog.OnCreate = function(self)
  -- function num : 0_1 , upvalues : _ENV
  self._preCurLv = self:GetChild("Left/LevelNum")
  self._preMaxLv = self:GetChild("Left/LevelMax")
  self._nextCurLv = self:GetChild("Right/LevelNum")
  self._nextMaxLv = self:GetChild("Right/LevelMax")
  self._cancelBtn = self:GetChild("CancelButton")
  self._confirmBtn = self:GetChild("ConfirmButton")
  ;
  (self._cancelBtn):Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  ;
  (self._confirmBtn):Subscribe_PointerClickEvent(self.OnConfirmClick, self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnRoleInfoChange, Common.n_RoleInfoChange, nil)
end

NewCharBreakBreakSecondConfirmDialog.OnDestroy = function(self)
  -- function num : 0_2
end

NewCharBreakBreakSecondConfirmDialog.SetData = function(self, roleKey, data)
  -- function num : 0_3
  self._roleKey = roleKey
  ;
  (self._preCurLv):SetText(data.curLv)
  ;
  (self._preMaxLv):SetText(data.curMaxLv)
  ;
  (self._nextCurLv):SetText(data.curLv)
  ;
  (self._nextMaxLv):SetText(data.nextMaxLv)
end

NewCharBreakBreakSecondConfirmDialog.OnBackBtnClicked = function(self)
  -- function num : 0_4
  if not self._sendProtocol then
    self:Destroy()
  end
end

NewCharBreakBreakSecondConfirmDialog.OnConfirmClick = function(self)
  -- function num : 0_5 , upvalues : _ENV
  if not self._sendProtocol then
    local CRoleBreak = (LuaNetManager.CreateProtocol)("protocol.login.crolebreak")
    if CRoleBreak then
      self._sendProtocol = true
      CRoleBreak.roleId = self._roleKey
      CRoleBreak:Send()
    end
  end
end

NewCharBreakBreakSecondConfirmDialog.OnRoleInfoChange = function(self, notification)
  -- function num : 0_6
  if (notification.userInfo).name == "sroleupdatebreaklv" then
    self._sendProtocol = false
    self:Destroy()
  end
end

return NewCharBreakBreakSecondConfirmDialog

