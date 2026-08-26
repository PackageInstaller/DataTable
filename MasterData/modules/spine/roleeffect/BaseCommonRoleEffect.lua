-- chunkname: @modules/spine/roleeffect/BaseCommonRoleEffect.lua

module("modules.spine.roleeffect.BaseCommonRoleEffect", package.seeall)

local BaseCommonRoleEffect = class("BaseCommonRoleEffect", BaseSpineRoleEffect)

function BaseCommonRoleEffect:init(roleEffectConfig)
	local spineGo = self._spine._spineGo

	if not spineGo then
		logError("BaseCommonRoleEffect spineGo is nil")

		return
	end

	local goDrawables = gohelper.findChild(spineGo, "Drawables")

	if not goDrawables then
		return
	end

	self._animatorInfoList = {}

	for i, v in ipairs(lua_character_motion_effect_animator.configList) do
		if v.heroResName == roleEffectConfig.heroResName then
			local info = self:_initState(spineGo, v)

			if info then
				table.insert(self._animatorInfoList, info)
			end
		end
	end
end

function BaseCommonRoleEffect:_initState(spineGo, config)
	local effectGo = gohelper.findChild(spineGo, config.effectNode)

	if not effectGo then
		logError(config.heroResName, " BaseCommonRoleEffect effectNode is null ", config.effectNode)

		return
	end

	local animator = effectGo:GetComponent("Animator")

	if not animator then
		logError(config.heroResName, " BaseCommonRoleEffect animator is null", config.effectNode)

		return
	end

	local info = {
		config = config,
		animator = animator,
		defaultStateName = config.defaultState,
		curStateName = config.defaultState
	}

	animator:Play(config.defaultState)

	local stateList = GameUtil.splitString2(config.stateList, false, "|", "#")

	for i, t in ipairs(stateList) do
		local stateName

		for k, v in ipairs(t) do
			if k == 1 then
				stateName = v
			else
				local bodyName = v

				if info[bodyName] then
					logError(config.heroResName, " BaseCommonRoleEffect bodyName is repeat ", bodyName)
				else
					info[bodyName] = stateName
				end
			end
		end
	end

	return info
end

function BaseCommonRoleEffect:showBodyEffect(bodyName, callback, callbackTarget)
	if not self._animatorInfoList then
		return
	end

	TaskDispatcher.cancelTask(self._delayChangeState, self)

	self._stateBodyName = bodyName

	for i, v in ipairs(self._animatorInfoList) do
		if not v[bodyName] then
			if v.curStateName ~= v[bodyName] then
				TaskDispatcher.runDelay(self._delayChangeState, self, v.config.delay)

				break
			end
		end
	end
end

function BaseCommonRoleEffect:_delayChangeState()
	for i, v in ipairs(self._animatorInfoList) do
		local animator = v.animator

		if not v[self._stateBodyName] then
			if v.curStateName ~= v[self._stateBodyName] then
				v.curStateName = v[self._stateBodyName]

				animator:Play(v[self._stateBodyName])
			end
		end
	end
end

function BaseCommonRoleEffect:onDestroy()
	TaskDispatcher.cancelTask(self._delayChangeState, self)
end

return BaseCommonRoleEffect
