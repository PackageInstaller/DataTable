-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roseclg/model/RoseClgFmtMo.lua

module("logic.extensions.roseclg.model.RoseClgFmtMo", package.seeall)

local RoseClgFmtMo = class("RoseClgFmtMo", BaseCustomFmtMo)

function RoseClgFmtMo:initParams(activityId, teamIndex, creepsMasterId)
	self._activityId = activityId
	self._teamIndex = teamIndex
	self._creepsMasterId = creepsMasterId
	self._masterData = RoseclgConfig.instance:getCreepsMasterCfg(self._creepsMasterId)
	self._creepsCfg = RoseclgConfig.instance:getCreepsCfgs(self._creepsMasterId)

	local info = RoseclgModel.instance:getInfo(self._activityId)

	self._petIdHPMap = {}

	for i, v in ipairs(info.petHpInfo or {}) do
		self._petIdHPMap[v.left] = v.right
	end
end

function RoseClgFmtMo:updateData()
	self.topTitleStr = self._masterData.name
	self.validatorDescStr = self._masterData.missionDesc
	self.ruleDescStr = self._masterData.ruleDesc

	self:setFormCondition(self._masterData.formCondition)
end

function RoseClgFmtMo:initFightHandler()
	local function handler()
		local simpleForm = self:getCurSimpleForm()

		RoseClgAgent.instance:sendPM_RoseClgChallengeReq(self._activityId, self._teamIndex, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function RoseClgFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function RoseClgFmtMo:getFmtInfoConfig()
	return self._masterData
end

function RoseClgFmtMo:checkPetIsForbit(petMo, baseCheck)
	if petMo and self._petIdHPMap[petMo.petId] and self._petIdHPMap[petMo.petId] <= 0 then
		return true
	end

	return false
end

function RoseClgFmtMo:showForbitPetAlert(petMo)
	return
end

function RoseClgFmtMo:updateCellTop(cell, petMo)
	local luaCls = PetHpSlider
	local url = PetHpSlider.prefabUrl
	local proxy = MaterialMgr.getProxyWithOutPool(url, luaCls, cell)

	if proxy then
		local percent = RoseclgModel.instance:getPetHpPercent(self._activityId, petMo.petId)

		proxy.binder:onUpdateHp(percent)
	end
end

return RoseClgFmtMo
