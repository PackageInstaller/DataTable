-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/holydragontemple/config/HolyDragonTempleConfig.lua

module("logic.extensions.holydragontemple.config.HolyDragonTempleConfig", package.seeall)

local HolyDragonTempleConfig = class("HolyDragonTempleConfig", BaseConfig)

function HolyDragonTempleConfig:getNames()
	return {
		"holy_dragon_temple_activity",
		"holy_dragon_temple_creeps",
		"holy_dragon_temple_support_pet",
		"holy_dragon_temple_sign_in_buff",
		"holy_dragon_temple_master",
		"holy_dragon_temple_end_circle_buff",
		"holy_dragon_temple_stage",
		"holy_dragon_temple_floor"
	}
end

function HolyDragonTempleConfig:handleConfig(name, content)
	if name == "holy_dragon_temple_activity" then
		self._holy_dragon_temple_activity = content
	elseif name == "holy_dragon_temple_creeps" then
		self._holy_dragon_temple_creeps = content
	elseif name == "holy_dragon_temple_support_pet" then
		self._holy_dragon_temple_support_pet = content
	elseif name == "holy_dragon_temple_sign_in_buff" then
		self._holy_dragon_temple_sign_in_buff = content
	elseif name == "holy_dragon_temple_master" then
		self._holy_dragon_temple_master = content
	elseif name == "holy_dragon_temple_end_circle_buff" then
		self._holy_dragon_temple_end_circle_buff = content
	elseif name == "holy_dragon_temple_stage" then
		self._holy_dragon_temple_stage = content
	elseif name == "holy_dragon_temple_floor" then
		self._holy_dragon_temple_floor = content
	end
end

function HolyDragonTempleConfig:_safeGet(data, ...)
	local keys = {
		...
	}
	local current = data

	for i = 1, #keys do
		if current and type(current) == "table" then
			current = current[keys[i]]
		else
			current = nil

			break
		end
	end

	return current
end

function HolyDragonTempleConfig:getActivityData(activityId)
	return self:_safeGet(self._holy_dragon_temple_activity, activityId)
end

function HolyDragonTempleConfig:getCreepsDatas(creepsMasterId)
	return self:_safeGet(self._holy_dragon_temple_creeps, creepsMasterId)
end

function HolyDragonTempleConfig:getCreepsData(creepsMasterId, creepsId)
	return self:_safeGet(self._holy_dragon_temple_creeps, creepsMasterId, creepsId)
end

function HolyDragonTempleConfig:getSupportPetDatas(supportPetPlan)
	return self:_safeGet(self._holy_dragon_temple_support_pet, supportPetPlan)
end

function HolyDragonTempleConfig:getSupportPetData(supportPetPlan, creepsId)
	return self:_safeGet(self._holy_dragon_temple_support_pet, supportPetPlan, creepsId)
end

function HolyDragonTempleConfig:getSignInBuffDatass(activityId)
	return self:_safeGet(self._holy_dragon_temple_sign_in_buff, activityId)
end

function HolyDragonTempleConfig:getSignInBuffDatas(activityId, floorId)
	return self:_safeGet(self._holy_dragon_temple_sign_in_buff, activityId, floorId)
end

function HolyDragonTempleConfig:getSignInBuffData(activityId, floorId, buffId)
	return self:_safeGet(self._holy_dragon_temple_sign_in_buff, activityId, floorId, buffId)
end

function HolyDragonTempleConfig:getSignInBuffDataBySignInDays(activityId, floorId, signInDays)
	signInDays = checknumber(signInDays)

	if signInDays <= 0 then
		return nil
	end

	local buffDatas = self:getSignInBuffDatas(activityId, floorId)

	for _, buffData in pairs(buffDatas or {}) do
		if checknumber(buffData.signInDays) == signInDays then
			return buffData
		end
	end

	return nil
end

function HolyDragonTempleConfig:getMasterData(creepsMasterId)
	return self:_safeGet(self._holy_dragon_temple_master, creepsMasterId)
end

function HolyDragonTempleConfig:getEndCircleBuffDatas(activityId)
	return self:_safeGet(self._holy_dragon_temple_end_circle_buff, activityId)
end

function HolyDragonTempleConfig:getEndCircleBuffData(activityId, circleNum)
	return self:_safeGet(self._holy_dragon_temple_end_circle_buff, activityId, circleNum)
end

function HolyDragonTempleConfig:getStageDatass(activityId)
	return self:_safeGet(self._holy_dragon_temple_stage, activityId)
end

function HolyDragonTempleConfig:getStageDatas(activityId, floorId)
	return self:_safeGet(self._holy_dragon_temple_stage, activityId, floorId)
end

function HolyDragonTempleConfig:getStageData(activityId, floorId, stageId)
	return self:_safeGet(self._holy_dragon_temple_stage, activityId, floorId, stageId)
end

function HolyDragonTempleConfig:getFloorDatas(activityId)
	return self:_safeGet(self._holy_dragon_temple_floor, activityId)
end

function HolyDragonTempleConfig:getFloorData(activityId, floorId)
	return self:_safeGet(self._holy_dragon_temple_floor, activityId, floorId)
end

HolyDragonTempleConfig.instance = HolyDragonTempleConfig.New()

return HolyDragonTempleConfig
