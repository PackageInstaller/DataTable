-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/traincampqiecuo/config/TraincampqiecuoConfig.lua

module("logic.extensions.traincampqiecuo.config.TraincampqiecuoConfig", package.seeall)

local TraincampqiecuoConfig = class("TraincampqiecuoConfig", BaseConfig)

function TraincampqiecuoConfig:onInit()
	return
end

function TraincampqiecuoConfig:getNames()
	return {
		"tc_qie_cuo_common",
		"tc_qie_cuo_creeps",
		"tc_qie_cuo_chat",
		"tc_qie_cuo_room_name"
	}
end

function TraincampqiecuoConfig:handleConfig(name, content)
	if name == "tc_qie_cuo_common" then
		self._tc_qie_cuo_common = content
	elseif name == "tc_qie_cuo_creeps" then
		self._tc_qie_cuo_creeps = content
	elseif name == "tc_qie_cuo_chat" then
		self._tc_qie_cuo_chat = content
	elseif name == "tc_qie_cuo_room_name" then
		self._tc_qie_cuo_room_name = content
	end
end

function TraincampqiecuoConfig:getRandomNameId()
	local cfgs = self:getRoomNameCfgs()
	local index = math.random(1, #cfgs)

	return cfgs[index].id
end

function TraincampqiecuoConfig:getRandomName()
	local cfgs = self:getRoomNameCfgs()
	local index = math.random(1, #cfgs)

	return cfgs[index].name
end

function TraincampqiecuoConfig:getRoomNameCfgs()
	return self._tc_qie_cuo_room_name.dataList
end

function TraincampqiecuoConfig:getRoomNameCfg(id)
	return self._tc_qie_cuo_room_name[id]
end

function TraincampqiecuoConfig:getRoomName(id)
	return self._tc_qie_cuo_room_name[id].name
end

function TraincampqiecuoConfig:getChatCfg(id)
	return self._tc_qie_cuo_chat[id]
end

function TraincampqiecuoConfig:getChatCfgs()
	return self._tc_qie_cuo_chat.dataList
end

function TraincampqiecuoConfig:getCommonValue(key, need2number)
	local value = self._tc_qie_cuo_common[key].value

	if need2number then
		return checknumber(value)
	end

	return value
end

function TraincampqiecuoConfig:getCreepsCfg(creepsId)
	return self._tc_qie_cuo_creeps[creepsId]
end

function TraincampqiecuoConfig:getCreepsCfgs()
	return self._tc_qie_cuo_creeps.dataList
end

function TraincampqiecuoConfig:getPVEFormationMinPower()
	return self:getCommonValue("PVE_PER_PET_MIN_POWER", true)
end

function TraincampqiecuoConfig:getPVEFormationMaxPower()
	return self:getCommonValue("PVE_PER_PET_MAX_POWER", true)
end

function TraincampqiecuoConfig:getPVEFormationStepPower()
	return self:getCommonValue("PVE_PER_STEP_POWER", true)
end

function TraincampqiecuoConfig:getBreakRecommendZdlRange()
	return self:getCommonValue("Break_recommend_zdl_range", true)
end

TraincampqiecuoConfig.instance = TraincampqiecuoConfig.New()

return TraincampqiecuoConfig
