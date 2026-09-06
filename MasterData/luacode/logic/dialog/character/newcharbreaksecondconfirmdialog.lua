local NewCharBreakBreakSecondConfirmDialog = class("NewCharBreakBreakSecondConfirmDialog", Dialog)
NewCharBreakBreakSecondConfirmDialog.AssetBundleName = "ui/layouts.basecharacterinfo"
NewCharBreakBreakSecondConfirmDialog.AssetName = "CharBreakSecondConfirm"

function NewCharBreakBreakSecondConfirmDialog:Ctor(...)
  NewCharBreakBreakSecondConfirmDialog.super.Ctor(self, ...)
  self._groupName = "SecondConfirm"
end

function NewCharBreakBreakSecondConfirmDialog:OnCreate()
  self._preCurLv = self:GetChild("Left/LevelNum")
  self._preMaxLv = self:GetChild("Left/LevelMax")
  self._nextCurLv = self:GetChild("Right/LevelNum")
  self._nextMaxLv = self:GetChild("Right/LevelMax")
  self._cancelBtn = self:GetChild("CancelButton")
  self._confirmBtn = self:GetChild("ConfirmButton")
  self._cancelBtn:Subscribe_PointerClickEvent(self.OnBackBtnClicked, self)
  self._confirmBtn:Subscribe_PointerClickEvent(self.OnConfirmClick, self)
  LuaNotificationCenter.AddObserver(self, self.OnRoleInfoChange, Common.n_RoleInfoChange, nil)
end

function NewCharBreakBreakSecondConfirmDialog:OnDestroy()
end

function NewCharBreakBreakSecondConfirmDialog:SetData(roleKey, data)
  self._roleKey = roleKey
  self._preCurLv:SetText(data.curLv)
  self._preMaxLv:SetText(data.curMaxLv)
  self._nextCurLv:SetText(data.curLv)
  self._nextMaxLv:SetText(data.nextMaxLv)
end

function NewCharBreakBreakSecondConfirmDialog:OnBackBtnClicked()
  if not self._sendProtocol then
    self:Destroy()
  end
end

function NewCharBreakBreakSecondConfirmDialog:OnConfirmClick()
  if not self._sendProtocol then
    local CRoleBreak = LuaNetManager.CreateProtocol("protocol.login.crolebreak")
    if CRoleBreak then
      self._sendProtocol = true
      CRoleBreak.roleId = self._roleKey
      CRoleBreak:Send()
    end
  end
end

function NewCharBreakBreakSecondConfirmDialog:OnRoleInfoChange(notification)
  if notification.userInfo.name == "sroleupdatebreaklv" then
    self._sendProtocol = false
    self:Destroy()
  end
end

return NewCharBreakBreakSecondConfirmDialog
