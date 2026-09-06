-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origindarkmoyanclg/model/OrigindarkmoyanclgFmtMo.lua

module("logic.extensions.origindarkmoyanclg.model.OrigindarkmoyanclgFmtMo", package.seeall)

local OrigindarkmoyanclgFmtMo = class("OrigindarkmoyanclgFmtMo", BaseCustomFmtMo)

function OrigindarkmoyanclgFmtMo:initParams(activityId, stageId, x, y)
	self._activityId = activityId
	self._stageId = stageId
	self._x = x
	self._y = y

	local cellCfg = OrigindarkmoyanclgConfig.instance:getCellCfg(activityId, stageId, x, y)

	self._creepsMasterId = cellCfg.creepsMasterId
	self._creepsCfg = OrigindarkmoyanclgConfig.instance:getCreepsCfg(self._creepsMasterId)
	self._masterData = OrigindarkmoyanclgConfig.instance:getCreepsMasterCfg(self._creepsMasterId)

	local cellDatas = OrigindarkmoyanclgModel.instance:getCellDatas(self._activityId, self._stageId)

	self._lockRaceMap = {}

	for i, v in pairs(cellDatas) do
		local lockRaceId = checknumber(v.lockRaceId)

		if lockRaceId > 0 then
			self._lockRaceMap[lockRaceId] = true
		end
	end
end

function OrigindarkmoyanclgFmtMo:updateData()
	self.topTitleStr = self._masterData.name
	self.ruleDescStr = self._masterData.ruleDesc

	self:setFormCondition(self._masterData.formCondition)
end

function OrigindarkmoyanclgFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()

		OriginDarkMoYanClgAgent.instance:sendPM_OriginDarkMoYanClgChallengeCellReq(self._activityId, self._stageId, self._x, self._y, simpleForm)
	end

	self:setFightHandler(handler, nil)
end

function OrigindarkmoyanclgFmtMo:getMonsterConfigList()
	return self._creepsCfg
end

function OrigindarkmoyanclgFmtMo:getFmtInfoConfig()
	return self._masterData
end

function OrigindarkmoyanclgFmtMo:checkPetIsForbit(petMo, baseCheck)
	if self._lockRaceMap[petMo.raceId] == true then
		return true
	end

	return false
end

function OrigindarkmoyanclgFmtMo:showForbitPetAlert(petMo)
	FloatWordMgr.instance:show(lang("该精灵已被封印"))
end

return OrigindarkmoyanclgFmtMo
