-- chunkname: @modules/logic/explore/map/unit/comp/ExploreRoleAnimComp.lua

module("modules.logic.explore.map.unit.comp.ExploreRoleAnimComp", package.seeall)

local ExploreRoleAnimComp = class("ExploreRoleAnimComp", LuaCompBase)

function ExploreRoleAnimComp:ctor(unit)
	self.unit = unit
	self._curAnim = nil
	self._checkTime = 0
	self._lastSetIntValue = {}
	self._lastSetBoolValue = {}
	self._lastSetFloatValue = {}
end

function ExploreRoleAnimComp:setup(go)
	self.animator = go:GetComponent(typeof(UnityEngine.Animator))

	if self._curAnim then
		self:playAnim(self._curAnim)
	else
		self:playIdleAnim()
	end
end

function ExploreRoleAnimComp:playIdleAnim()
	self:playAnim(ExploreAnimEnum.RoleAnimName.idle)
end

function ExploreRoleAnimComp:onUpdate()
	if not self.animator then
		return
	end

	if self:isIdleAnim() then
		return
	end

	self._checkTime = self._checkTime + UnityEngine.Time.deltaTime

	if self._checkTime < 0.1 then
		return
	end

	self._checkTime = 0

	local info = self.animator:GetCurrentAnimatorStateInfo(0)

	if not info:IsName(self._curAnim) or info.normalizedTime >= 1 then
		self:onAnimPlayEnd()
	end
end

function ExploreRoleAnimComp:onAnimPlayEnd()
	return
end

function ExploreRoleAnimComp:isIdleAnim()
	return self._curAnim == ExploreAnimEnum.RoleAnimName.idle
end

function ExploreRoleAnimComp:onEnable()
	for key, value in pairs(self._lastSetBoolValue) do
		self:setBool(key, value)
	end

	for key, value in pairs(self._lastSetFloatValue) do
		self:setFloat(key, value)
	end

	for key, value in pairs(self._lastSetIntValue) do
		self:setInteger(key, value)
	end
end

function ExploreRoleAnimComp:setBool(key, value)
	if self.animator then
		self.animator:SetBool(key, value)
	end

	self._lastSetBoolValue[key] = value
end

function ExploreRoleAnimComp:getBool(key)
	return self._lastSetBoolValue[key] or false
end

function ExploreRoleAnimComp:setFloat(key, value)
	if self.animator then
		self.animator:SetFloat(key, value)
	end

	self._lastSetFloatValue[key] = value
end

function ExploreRoleAnimComp:setInteger(key, value)
	if self.animator then
		self.animator:SetInteger(key, value)
	end

	self._lastSetIntValue[key] = value
end

function ExploreRoleAnimComp:playAnim(animName)
	if self._curAnim ~= animName then
		self._curAnim = animName
		self._checkTime = 0

		if not self.animator then
			return
		end

		self.animator:Play(animName, 0, 0)
	end
end

function ExploreRoleAnimComp:clear()
	self._curAnim = nil
	self.animator = nil
end

function ExploreRoleAnimComp:onDestroy()
	self:clear()

	self._lastSetIntValue = {}
	self._lastSetBoolValue = {}
	self._lastSetFloatValue = {}
end

return ExploreRoleAnimComp
