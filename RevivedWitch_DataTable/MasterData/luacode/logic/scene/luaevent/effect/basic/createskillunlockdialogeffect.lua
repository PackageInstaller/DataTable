-- Decompiled using luadec 2.2 rev: 895d923 for Lua 5.3 from https://github.com/viruscamp/luadec
-- Command line: -se UTF8 luacode/logic/scene/luaevent/effect/basic/createskillunlockdialogeffect.lua 

-- params : ...
-- function num : 0 , upvalues : _ENV
local EffectBase = require("logic.scene.luaevent.effect.effectbase")
local CreateSkillUnlockDialog = class("CreateSkillUnlockDialog", EffectBase)
CreateSkillUnlockDialog.Ctor = function(self, skillId, skillItemId, roleId)
  -- function num : 0_0
  self._skillId = skillId
  self._skillItemId = skillItemId
  self._roleId = roleId
  self._dialogName = "skill.skillunlocksuccessdialog"
end

CreateSkillUnlockDialog.Run = function(self, args)
  -- function num : 0_1 , upvalues : _ENV
  if global_var_debug and self:GetParam("pause") then
    (((CS.PixelNeko).LuaManager).Pause)()
  end
  self._dialog = (DialogManager.CreateSingletonDialog)(self._dialogName)
  ;
  (self._dialog):SetData(self._skillId, self._skillItemId, self._roleId)
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
  ;
  (LuaNotificationCenter.AddObserver)(self, self.OnDialogDestroy, Common.n_DialogWillDestroy, nil)
end

CreateSkillUnlockDialog.OnDialogDestroy = function(self, notification)
  -- function num : 0_2 , upvalues : _ENV
  if (notification.userInfo)._dialogKey ~= (self._dialog)._dialogKey then
    return 
  end
  ;
  (LuaNotificationCenter.RemoveObserver)(self)
  if self._callback then
    (self._callback)()
    self._callback = nil
  else
    self._finished = true
  end
end

CreateSkillUnlockDialog.Then = function(self, callback)
  -- function num : 0_3
  if not self._finished then
    self._callback = callback
  else
    callback()
    self._finished = false
  end
end

return CreateSkillUnlockDialog

