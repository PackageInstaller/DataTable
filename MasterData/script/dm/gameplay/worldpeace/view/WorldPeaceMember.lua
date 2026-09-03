-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/worldpeace/view/WorldPeaceMember.lua

WorldPeaceMember = class("WorldPeaceMember", objectlua.Object)

WorldPeaceMember:has("_type", {
	is = "rw"
})
WorldPeaceMember:has("_config", {
	is = "rw"
})
WorldPeaceMember:has("_hp", {
	is = "rw"
})
WorldPeaceMember:has("_speed", {
	is = "rw"
})
WorldPeaceMember:has("_state", {
	is = "rw"
})
WorldPeaceMember:has("_displayNode", {
	is = "rw"
})
WorldPeaceMember:has("_id", {
	is = "rw"
})
WorldPeaceMember:has("_assigedNodes", {
	is = "rw"
})
WorldPeaceMember:has("_factory", {
	is = "rw"
})
WorldPeaceMember:has("_radio", {
	is = "rw"
})
WorldPeaceMember:has("_position", {
	is = "rw"
})
WorldPeaceMember:has("_transformDirty", {
	is = "rw"
})
WorldPeaceMember:has("_data", {
	is = "rw"
})
WorldPeaceMember:has("_playMode", {
	is = "rw"
})
WorldPeaceMember:has("_atkEffectProp", {
	is = "rw"
})
WorldPeaceMember:has("_mutilevelNodes", {
	is = "rw"
})
WorldPeaceMember:has("_distance", {
	is = "rw"
})

function WorldPeaceMember:initialize(id, memberType, data, factory)
	super.initialize(self)

	self._id = id
	self._radio = 0
	self._factory = factory
	self._state = K_WORLD_MEMBER_SATGE.Prepare
	self._assigedNodes = {}
	self._mutilevelNodes = {}
	self._transformDirty = false
	self._data = data
	self._atkEffectProp = 1

	if self._factory then
		self._playMode = self._factory:getPaceGame():getDisplayMode()
	end
end

function WorldPeaceMember:assigedNodeToMain(node, layer)
	if not node then
		return
	end

	local nodealf = self._factory:assigedNodeToMain(node, layer)

	self._assigedNodes[node] = {
		node = nodealf,
		pos = cc.p(nodealf:getPosition()),
		scale = nodealf:getScale()
	}

	return nodealf
end

function WorldPeaceMember:isVisible()
	return self._displayNode:isVisible()
end

function WorldPeaceMember:onAttack()
	return
end

function WorldPeaceMember:onIdle()
	return
end

function WorldPeaceMember:Idleing()
	return
end

function WorldPeaceMember:onDie()
	return
end

function WorldPeaceMember:onHit()
	return
end

function WorldPeaceMember:onPrepare()
	return
end

function WorldPeaceMember:update()
	return
end

function WorldPeaceMember:onProtect()
	return
end

function WorldPeaceMember:dispose()
	return
end

function WorldPeaceMember:step(dt)
	if self._state == K_WORLD_MEMBER_SATGE.Prepare then
		self:onPrepare(self.__stateArgs)
	elseif self._state == K_WORLD_MEMBER_SATGE.Idle then
		self:onIdle(self.__stateArgs)
	elseif self._state == K_WORLD_MEMBER_SATGE.Idleing then
		self:Idleing(self.__stateArgs)
	elseif self._state == K_WORLD_MEMBER_SATGE.Attack then
		self:onAttack(self.__stateArgs)
	elseif self._state == K_WORLD_MEMBER_SATGE.Attacking then
		-- block empty
	elseif self._state == K_WORLD_MEMBER_SATGE.Protect then
		self:onProtect(self.__stateArgs)
	elseif self._state == K_WORLD_MEMBER_SATGE.Protecting then
		-- block empty
	elseif self._state == K_WORLD_MEMBER_SATGE.Dieing then
		-- block empty
	elseif self._state == K_WORLD_MEMBER_SATGE.Died then
		self:onDie(self.__stateArgs)
	end

	self:update(dt)
end

function WorldPeaceMember:getEffectLayer()
	local stage = self._factory:getDisplayStage():getChildByFullName("map"):getInnerContainer()

	return (stage:getChildByName("EffectLayer"))
end

function WorldPeaceMember:getUnderLayer()
	local stage = self._factory:getDisplayStage():getChildByFullName("map"):getInnerContainer()

	return (stage:getChildByName("UnderLayer"))
end

function WorldPeaceMember:getBollLayer()
	local stage = self._factory:getDisplayStage():getChildByFullName("map"):getInnerContainer()

	return (stage:getChildByName("BollLayer"))
end

function WorldPeaceMember:setState(state, args)
	self.__stateArgs = args
	self._state = state
end
