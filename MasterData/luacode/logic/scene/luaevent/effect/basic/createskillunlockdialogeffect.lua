local EffectBase = require("logic.scene.luaevent.effect.effectbase")
local CreateSkillUnlockDialog = class("CreateSkillUnlockDialog", EffectBase)

function CreateSkillUnlockDialog:Ctor(skillId, skillItemId, roleId)
  self._skillId = skillId
  self._skillItemId = skillItemId
  self._roleId = roleId
  self._dialogName = "skill.skillunlocksuccessdialog"
end

function CreateSkillUnlockDialog:Run(args)
  if global_var_debug and self:GetParam("pause") then
    CS.PixelNeko.LuaManager.Pause()
  end
  self._dialog = DialogManager.CreateSingletonDialog(self._dialogName)
  self._dialog:SetData(self._skillId, self._skillItemId, self._roleId)
  LuaNotificationCenter.RemoveObserver(self)
  LuaNotificationCenter.AddObserver(self, self.OnDialogDestroy, Common.n_DialogWillDestroy, nil)
end

function CreateSkillUnlockDialog:OnDialogDestroy(notification)
  if notification.userInfo._dialogKey ~= self._dialog._dialogKey then
    return
  end
  LuaNotificationCenter.RemoveObserver(self)
  if self._callback then
    self._callback()
    self._callback = nil
  else
    self._finished = true
  end
end

function CreateSkillUnlockDialog:Then(callback)
  if not self._finished then
    self._callback = callback
  else
    callback()
    self._finished = false
  end
end

return CreateSkillUnlockDialog
