-- chunkname: @modules/spine/roleeffect/RoleEffect307904_6.lua

module("modules.spine.roleeffect.RoleEffect307904_6", package.seeall)

local RoleEffect307904_6 = class("RoleEffect307904_6", CommonRoleEffect)

function RoleEffect307904_6:init(roleEffectConfig)
	RoleEffect307904_6.super.init(self, roleEffectConfig)

	self._idleIndex = tabletool.indexOf(self._motionList, "b_idle")
	self._lightBodyList = {
		"b_idle",
		"b_diantou",
		"b_yaotou",
		"b_taishou"
	}
end

function RoleEffect307904_6:showBodyEffect(bodyName, callback, callbackTarget)
	self._effectVisible = false

	if self._index == self._idleIndex then
		if not tabletool.indexOf(self._lightBodyList, bodyName) then
			self:_setNodeVisible(self._index, false)
		end
	else
		self:_setNodeVisible(self._index, false)
	end

	self._index = tabletool.indexOf(self._motionList, bodyName)

	self:_setNodeVisible(self._index, true)

	if tabletool.indexOf(self._lightBodyList, bodyName) then
		self:_setNodeVisible(self._idleIndex, true)
	end

	if not self._firstShow then
		self._firstShow = true

		self:showEverNodes(false)
		TaskDispatcher.cancelTask(self._delayShowEverNodes, self)
		TaskDispatcher.runDelay(self._delayShowEverNodes, self, 0.3)
	end

	if callback and callbackTarget then
		callback(callbackTarget, self._effectVisible or self._showEverEffect)
	end
end

return RoleEffect307904_6
