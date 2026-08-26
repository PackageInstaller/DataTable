-- chunkname: @modules/logic/fight/mgr/FightBloomMgr.lua

module("modules.logic.fight.mgr.FightBloomMgr", package.seeall)

local FightBloomMgr = class("FightBloomMgr", FightBaseClass)

FightBloomMgr.Bloom_invisible = "invisible"
FightBloomMgr.Bloom_mirror = "mirror"
FightBloomMgr.Bloom_useShadow = "useShadow"
FightBloomMgr.Bloom_mirrorNoise = "mirrorNoise"

local PPEffectMaskDict = {
	[FightBloomMgr.Bloom_invisible] = "useInvisible",
	[FightBloomMgr.Bloom_mirror] = "useMirror",
	[FightBloomMgr.Bloom_useShadow] = "useShadow"
}
local PPVolumeDict = {
	[FightBloomMgr.Bloom_invisible] = "characterInvisibleActive"
}

function FightBloomMgr:onConstructor()
	self._entityDict = {}
	self._scenePassDict = {}
	self._entityPassDict = {}

	local curScene = GameSceneMgr.instance:getCurScene()

	self:com_registFightEvent(FightEvent.OnSceneLevelLoaded, self.onLevelLoaded)
	self:com_registFightEvent(FightEvent.OnSkillPlayStart, self.onSkillPlayStart)
	self:com_registFightEvent(FightEvent.OnSkillPlayFinish, self.onSkillPlayFinish)
end

function FightBloomMgr:onLevelLoaded(levelId)
	local levelCO = lua_scene_level.configDict[levelId]

	if levelCO and levelCO.useBloom == 1 then
		if self._localBloomColor == nil then
			self._localBloomColor = PostProcessingMgr.instance:getLocalBloomColor()
		end

		PostProcessingMgr.instance:setLocalBloomColor(Color.New(levelCO.bloomR, levelCO.bloomG, levelCO.bloomB, levelCO.bloomA))
		PostProcessingMgr.instance:setFlickerSceneFactor(levelCO.flickerSceneFactor)
		PostProcessingMgr.instance:setLocalBloomActive(true)

		self._scenePassDict = {}

		if not string.nilorempty(levelCO.bloomEffect) then
			local passNames = string.split(levelCO.bloomEffect, "#")

			for _, name in ipairs(passNames) do
				self._scenePassDict[name] = true
			end
		end
	end

	for entity, _ in pairs(self._entityDict) do
		self:_checkEntityPPEffectMask(entity)
	end

	self:_checkCameraPPVolume()
end

function FightBloomMgr:addEntity(entity)
	self._delayAddEntitys = self._delayAddEntitys or {}

	table.insert(self._delayAddEntitys, entity)
	TaskDispatcher.cancelTask(self._delayAddEntityBloom, self)
	TaskDispatcher.runDelay(self._delayAddEntityBloom, self, 2)
end

function FightBloomMgr:_delayAddEntityBloom()
	for _, entity in ipairs(self._delayAddEntitys) do
		self._entityDict[entity] = true

		self:_checkEntityPPEffectMask(entity)
		self:_checkCameraPPVolume()
	end

	self._delayAddEntitys = nil
end

function FightBloomMgr:removeEntity(entity)
	self._entityDict[entity] = nil

	self:_checkEntityPPEffectMask(entity)
	self:_checkCameraPPVolume()
end

function FightBloomMgr:setSingleEntityPass(passName, enable, entity, sourceKey)
	local entitys = self._entityPassDict[passName]

	if not entitys then
		entitys = {}
		self._entityPassDict[passName] = entitys
	end

	local sourceKeyDict = entitys[entity]

	if not sourceKeyDict then
		sourceKeyDict = {}
		entitys[entity] = sourceKeyDict
	end

	sourceKeyDict[sourceKey] = enable and true or nil

	self:_checkEntityPPEffectMask(entity)
	self:_checkCameraPPVolume(passName)
end

function FightBloomMgr:_checkEntityPPEffectMask(entity)
	if entity.spine then
		local ppEffectMask = entity.spine:getPPEffectMask()

		if not entity.spine then
			return
		end

		if not entity.spineRenderer then
			return
		end

		local replaceMat = entity.spineRenderer:getReplaceMat()

		if gohelper.isNil(replaceMat) then
			return
		end

		for passName, passName4PPEffectMask in pairs(PPEffectMaskDict) do
			if self._entityDict[entity] then
				if not self._scenePassDict[passName] then
					local enable = false

					if not enable then
						local entitys = self._entityPassDict[passName]

						if entitys then
							local sourceKeyDict = entitys[entity]

							if sourceKeyDict then
								for _, _ in pairs(sourceKeyDict) do
									enable = true

									break
								end
							end
						end
					end

					entity.spine:SetPassEnable(replaceMat, passName4PPEffectMask, enable)
				end
			end
		end
	end
end

function FightBloomMgr:_checkCameraPPVolume(passName)
	if passName then
		if PPVolumeDict[passName] then
			self:_checkOneCameraPPVolume(passName)
		end
	else
		for passName, _ in pairs(PPVolumeDict) do
			self:_checkOneCameraPPVolume(passName)
		end
	end
end

function FightBloomMgr:_checkOneCameraPPVolume(passName)
	local isEnable = self._scenePassDict[passName]

	if not isEnable then
		local entitys = self._entityPassDict[passName]

		if entitys then
			for _, sourceKeyDict in pairs(entitys) do
				for _, _ in pairs(sourceKeyDict) do
					isEnable = true

					break
				end

				if isEnable then
					break
				end
			end
		end
	end

	local ppVolumeName = PPVolumeDict[passName]

	PostProcessingMgr.instance:setUnitPPValue(ppVolumeName, isEnable)
end

function FightBloomMgr:onSkillPlayStart(entity, skillId)
	local entityMO = entity:getMO()

	if entityMO and FightCardDataHelper.isBigSkill(skillId) then
		local entityList = FightHelper.getSideEntitys(entityMO.side)

		for i, v in ipairs(entityList) do
			self:setSingleEntityPass(FightBloomMgr.Bloom_invisible, false, v, "buff_bloom")
		end
	end
end

function FightBloomMgr:onSkillPlayFinish(entity, skillId)
	local entityMO = entity:getMO()

	if entityMO and FightCardDataHelper.isBigSkill(skillId) then
		local entityList = FightHelper.getSideEntitys(entityMO.side)

		for i, v in ipairs(entityList) do
			if v.buff then
				v.buff:_udpateBuffVariant()
			end
		end
	end
end

function FightBloomMgr:onDestructor()
	if self._localBloomColor then
		PostProcessingMgr.instance:setLocalBloomColor(self._localBloomColor)

		self._localBloomColor = nil
	end

	self:_checkCameraPPVolume()
end

return FightBloomMgr
