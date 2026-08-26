-- chunkname: @modules/logic/room/entity/comp/RoomAnimEventAudioComp.lua

module("modules.logic.room.entity.comp.RoomAnimEventAudioComp", package.seeall)

local RoomAnimEventAudioComp = class("RoomAnimEventAudioComp", LuaCompBase)

RoomAnimEventAudioComp.AUDIO_MAX = 4

function RoomAnimEventAudioComp:ctor(entity)
	self.entity = entity
	self.__willDestroy = false
end

function RoomAnimEventAudioComp:init(go)
	self.go = go
	self._effectKey = RoomEnum.EffectKey.BuildingGOKey
	self._eventPrefix = "audio_"
	self._configName = "room_building"

	local mo = self:getMO()

	if mo and mo.config and not string.nilorempty(mo.config.audioExtendIds) then
		self._audioExtendIds = string.splitToNumber(mo.config.audioExtendIds, "#")
	end
end

function RoomAnimEventAudioComp:addEventListeners()
	return
end

function RoomAnimEventAudioComp:removeEventListeners()
	return
end

function RoomAnimEventAudioComp:getMO()
	return self.entity:getMO()
end

function RoomAnimEventAudioComp:setConfigName(configName)
	self._configName = configName
end

function RoomAnimEventAudioComp:setEffectKey(key)
	if self._effectKey ~= key then
		self._effectKey = key

		self:_removeAnimEvent()
	end
end

function RoomAnimEventAudioComp:beforeDestroy()
	self.__willDestroy = true

	self:removeEventListeners()
	self:_removeAnimEvent()
end

function RoomAnimEventAudioComp:_onAnimEvent_1()
	self:_playAudio(1)
end

function RoomAnimEventAudioComp:_onAnimEvent_2()
	self:_playAudio(2)
end

function RoomAnimEventAudioComp:_onAnimEvent_3()
	self:_playAudio(3)
end

function RoomAnimEventAudioComp:_onAnimEvent_4()
	self:_playAudio(4)
end

function RoomAnimEventAudioComp:_playAudio(index)
	if self.__willDestroy or self._audioExtendIds == nil then
		return
	end

	local audioId = self._audioExtendIds[index]

	if audioId == nil then
		logNormal(string.format("RoomAnimEventAudioComp 请检\"%s\"表中\"audioExtendIds\"配置的音效数量不足。当前第%s个", self._configName, index))
	elseif audioId ~= 0 then
		RoomHelper.audioExtendTrigger(audioId, self.go)
	end
end

function RoomAnimEventAudioComp:_addAnimEvent()
	if self.__willDestroy then
		return
	end

	if self._animEventMonoList or not self.effect:isHasEffectGOByKey(self._effectKey) then
		return
	end

	local monoList = self.effect:getComponentsByKey(self._effectKey, RoomEnum.ComponentName.AnimationEventWrap)

	if not monoList then
		return
	end

	self._animEventMonoList = {}

	tabletool.addValues(self._animEventMonoList, monoList)

	for _, animEventMono in ipairs(self._animEventMonoList) do
		for i = 1, RoomAnimEventAudioComp.AUDIO_MAX do
			local funcName = "_onAnimEvent_" .. i
			local func = self[funcName]

			if func then
				animEventMono:AddEventListener(self._eventPrefix .. i, func, self)
			else
				logError("RoomAnimEventAudioComp can not find function name is:" .. funcName)

				break
			end
		end
	end
end

function RoomAnimEventAudioComp:_removeAnimEvent()
	if self._animEventMonoList then
		local monoList = self._animEventMonoList

		self._animEventMonoList = nil

		for _, animEventMono in ipairs(monoList) do
			animEventMono:RemoveAllEventListener()
		end

		for datakey in pairs(monoList) do
			rawset(monoList, datakey, nil)
		end
	end
end

function RoomAnimEventAudioComp:onEffectRebuild()
	local effect = self.entity.effect

	if effect:isHasEffectGOByKey(self._effectKey) and not effect:isSameResByKey(self._effectKey, self._effectRes) then
		self._effectRes = effect:getEffectRes(self._effectKey)

		self:_removeAnimEvent()
		self:_addAnimEvent()
	end
end

function RoomAnimEventAudioComp:onEffectReturn(key, res)
	if self._effectKey == key then
		self:_removeAnimEvent()
	end
end

return RoomAnimEventAudioComp
