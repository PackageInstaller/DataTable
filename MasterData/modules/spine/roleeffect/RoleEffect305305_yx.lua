-- chunkname: @modules/spine/roleeffect/RoleEffect305305_yx.lua

module("modules.spine.roleeffect.RoleEffect305305_yx", package.seeall)

local RoleEffect305305_yx = class("RoleEffect305305_yx", CommonRoleEffectContinue)

function RoleEffect305305_yx:showBodyEffect(bodyName, callback, callbackTarget)
	RoleEffect305305_yx.super.showBodyEffect(self, bodyName, callback, callbackTarget)

	if bodyName == "b_jiaohu_02" then
		self:_effectPlayAnim("idle")
	elseif bodyName == "b_jiaohu_03" then
		self:_effectPlayAnim("start")
	end

	if self._prevBodyName == "b_jiaohu_03" then
		self:_effectPlayAnim("end")
		TaskDispatcher.cancelTask(self._hideEffect, self)
		TaskDispatcher.runDelay(self._hideEffect, self, 1.5)
	end

	self._prevBodyName = bodyName
end

function RoleEffect305305_yx:_hideEffect()
	local go = gohelper.findChild(self._spineGo, "roleeffect_skinchange")

	gohelper.setActive(go, false)
end

function RoleEffect305305_yx:_effectPlayAnim(name)
	local go = gohelper.findChild(self._spineGo, "roleeffect_skinchange")

	gohelper.setActive(go, true)

	if not go then
		return
	end

	local animator = go:GetComponent("Animator")

	if not animator then
		return
	end

	animator:Play(name, 0, 0)
end

function RoleEffect305305_yx:onDestroy()
	RoleEffect305305_yx.super.onDestroy(self)
	TaskDispatcher.cancelTask(self._hideEffect, self)
end

return RoleEffect305305_yx
