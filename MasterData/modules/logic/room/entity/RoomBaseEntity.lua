-- chunkname: @modules/logic/room/entity/RoomBaseEntity.lua

module("modules.logic.room.entity.RoomBaseEntity", package.seeall)

local RoomBaseEntity = class("RoomBaseEntity", BaseUnitSpawn)

function RoomBaseEntity:ctor()
	RoomBaseEntity.super.ctor(self)
	LuaEventSystem.addEventMechanism(self)
end

function RoomBaseEntity:init(go)
	RoomBaseEntity.super.init(self, go)

	self.luaMono = go:GetComponent(RoomEnum.ComponentType.LuaMonobehavier)
	self.__hasTaskOnEnabled = true

	TaskDispatcher.runDelay(self._onEnabledLuaMono, self, 0.01)
end

function RoomBaseEntity:_onEnabledLuaMono()
	self.__hasTaskOnEnabled = false
	self.luaMono.enabled = false
end

function RoomBaseEntity:getCharacterMeshRendererList()
	return
end

function RoomBaseEntity:getGameObjectListByName(goName)
	return
end

function RoomBaseEntity:playAudio(audioId)
	logNormal("当前接口未实现,需子类实现")
end

function RoomBaseEntity:getMainEffectKey()
	return RoomEnum.EffectKey.BuildingGOKey
end

function RoomBaseEntity:addComp(compName, compClass)
	local compInst = MonoHelper.addNoUpdateLuaComOnceToGo(self.go, compClass, self)

	self[compName] = compInst

	table.insert(self._compList, compInst)
end

function RoomBaseEntity:beforeDestroy()
	if self.__hasTaskOnEnabled then
		self.__hasTaskOnEnabled = false

		TaskDispatcher.cancelTask(self._onEnabledLuaMono, self)
	end

	local compList = self:getCompList()

	if compList then
		for _, comp in ipairs(compList) do
			if comp.beforeDestroy then
				comp:beforeDestroy()
			end
		end
	end
end

return RoomBaseEntity
