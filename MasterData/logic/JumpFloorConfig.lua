-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jumpfloor/config/JumpFloorConfig.lua

module("logic.extensions.jumpfloor.config.JumpFloorConfig", package.seeall)

local JumpFloorConfig = class("JumpFloorConfig", BaseConfig)

function JumpFloorConfig:onInit()
	JumpFloorConfig.super.onInit(self)

	self.dancing_lion_jump = nil
	self.dancing_lion_jump_stage = nil
	self.dancing_lion_jump_endless = nil
end

function JumpFloorConfig:getNames()
	return {
		"dancing_lion_jump",
		"dancing_lion_jump_stage",
		"dancing_lion_jump_endless"
	}
end

function JumpFloorConfig:handleConfig(name, content)
	if name == "dancing_lion_jump" then
		self.dancing_lion_jump = content
	elseif name == "dancing_lion_jump_stage" then
		self.dancing_lion_jump_stage = content
	elseif name == "dancing_lion_jump_endless" then
		self.dancing_lion_jump_endless = content
	end
end

function JumpFloorConfig:getActivityCfg(id)
	return self.dancing_lion_jump[id]
end

function JumpFloorConfig:getStageListById(stagePlanId)
	return self.dancing_lion_jump_stage[stagePlanId]
end

function JumpFloorConfig:getStageById(stagePlanId, stageId)
	if self.dancing_lion_jump_stage[stagePlanId] then
		return self.dancing_lion_jump_stage[stagePlanId][stageId]
	end
end

function JumpFloorConfig:getEndlessList()
	return self.dancing_lion_jump_endless.dataList
end

JumpFloorConfig.instance = JumpFloorConfig.New()

return JumpFloorConfig
