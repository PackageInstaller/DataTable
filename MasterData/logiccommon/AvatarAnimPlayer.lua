-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logiccommon/common/avatar/animator/AvatarAnimPlayer.lua

module("logiccommon.common.avatar.animator.AvatarAnimPlayer", package.seeall)

local AvatarAnimPlayer = class("AvatarAnimPlayer")

function AvatarAnimPlayer:ctor()
	self._animator = nil
	self._moedelName = nil
	self._animClips = {}
	self._lastAnimClips = {}
	self._currAnimName = nil
	self._layerIndex = 0
end

function AvatarAnimPlayer:setModelName(moedelName)
	self._moedelName = moedelName
end

function AvatarAnimPlayer:clearAnim()
	self:_clearLastAnimClip()
	self:_clearAnimClips()
end

function AvatarAnimPlayer:playAnim(animName, layerIndex)
	if not self._moedelName or not self:isStateExist(animName, layerIndex) then
		return
	end

	local configs = MainPlayerAnimState.Configs[animName]

	if not configs then
		return
	end

	if animName == self._currAnimName and self:isAllClipsLoaded() then
		self:_startPlayAnim()

		return
	end

	self._currAnimName = animName
	self._layerIndex = layerIndex or 0

	self:_clearLastAnimClip()
	table.merge(self._lastAnimClips, self._animClips)
	table.clear(self._animClips)

	for i = 1, #configs.clips do
		local clipPath = GameUrl.getAnimClipPath(self._moedelName, configs.clips[i])

		self._animClips[clipPath] = AvatarsMgr.instance:newObject(clipPath, self._onAnimClipLoaded, self)
	end
end

function AvatarAnimPlayer:isStateExist(stateName, layerIndex)
	if not self._animator then
		return
	end

	if MainPlayerAnimState.isChildStateMachine(stateName) then
		return self:getAnimStateMachine(stateName, layerIndex)
	end

	return self:getAnimState(stateName, layerIndex)
end

function AvatarAnimPlayer:getAnimState(stateName, layerIndex)
	if not self._animator then
		return
	end

	layerIndex = layerIndex or 0

	local controller = self._animator.runtimeAnimatorController

	if not controller then
		return
	end

	local layers = controller.layers

	if not layers or layerIndex < 0 or layerIndex >= layers.Length then
		return
	end

	local layer = layers[layerIndex]
	local stateMachine = layer.stateMachine

	if not stateMachine then
		return
	end

	local states = stateMachine.states

	if states then
		for i = 0, states.Length - 1 do
			if states[i].state.name == stateName then
				return states[i].state
			end
		end
	end
end

function AvatarAnimPlayer:getAnimStateMachine(stateName, layerIndex)
	if not self._animator then
		return
	end

	layerIndex = layerIndex or 0

	local controller = self._animator.runtimeAnimatorController

	if not controller then
		return
	end

	local layers = controller.layers

	if not layers or layerIndex < 0 or layerIndex >= layers.Length then
		return
	end

	local layer = layers[layerIndex]
	local stateMachine = layer.stateMachine

	if not stateMachine then
		return
	end

	local stateMachines = stateMachine.stateMachines

	if stateMachines then
		for i = 0, stateMachines.Length - 1 do
			if stateMachines[i].stateMachine.name == stateName then
				return stateMachines[i].stateMachine
			end
		end
	end
end

function AvatarAnimPlayer:isAllClipsLoaded()
	if not self._animClips then
		return true
	end

	for k, v in pairs(self._animClips) do
		if not v.res or not v.isEnabled then
			return
		end
	end

	return true
end

function AvatarAnimPlayer:_clearAnimClips()
	for k, v in pairs(self._animClips) do
		AvatarsMgr.instance:returnObject(v)
	end

	table.clear(self._animClips)

	self._currAnims = nil
	self._layerIndex = 0
end

function AvatarAnimPlayer:_clearLastAnimClip()
	for k, v in pairs(self._lastAnimClips) do
		AvatarsMgr.instance:returnObject(v)
	end

	table.clear(self._lastAnimClips)
end

function AvatarAnimPlayer:_onAnimClipLoaded(resObject)
	local clipPath = resObject.resPath

	if self._animClips and self._animClips[clipPath] == resObject then
		if self:isAllClipsLoaded() then
			self:_clearLastAnimClip()
			self:_startPlayAnim()
		end
	else
		AvatarsMgr.instance:recycleObject(resObject)
	end
end

function AvatarAnimPlayer:_startPlayAnim()
	if MainPlayerAnimState.isChildStateMachine(self._currAnimName) then
		self:_overrideAnimStateMachine()
	else
		self:_overrideAnimState()
	end
end

function AvatarAnimPlayer:_overrideAnimStateMachine()
	local stateMachine = self:getAnimStateMachine(self._currAnimName, self._layerIndex)
	local states = stateMachine.states
	local configs = MainPlayerAnimState.Configs[self._currAnimName]

	for i = 1, #configs.clips do
		local clipName = GameUrl.getAnimClipPath(self._moedelName, configs.clips[i])
		local animRes = self._animClips[clipName].res

		states[i - 1].state.motion = animRes:GetMainAsset()
	end

	self._animator:Rebind()
end

function AvatarAnimPlayer:_overrideAnimState()
	local state = self:getAnimState(self._currAnimName, self._layerIndex)
	local configs = MainPlayerAnimState.Configs[self._currAnimName]
	local clipName = GameUrl.getAnimClipPath(self._moedelName, configs.clips[1])
	local animRes = self._animClips[clipName].res

	state.motion = animRes:GetMainAsset()

	self._animator:Rebind()
end

return AvatarAnimPlayer
