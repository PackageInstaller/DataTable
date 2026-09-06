-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divineskliexinclg/model/DivineSKLieXinClgFmtMo.lua

module("logic.extensions.divineskliexinclg.model.DivineSKLieXinClgFmtMo", package.seeall)

local DivineSKLieXinClgFmtMo = class("DivineSKLieXinClgFmtMo", BaseCustomFmtMo)

function DivineSKLieXinClgFmtMo:initParams(activityId, stageId)
	self.activityId = activityId
	self.stageId = stageId

	local activityCfg = DivineSKLieXinClgConfig.instance:getActivityCfg(activityId)
	local stageCfg = DivineSKLieXinClgConfig.instance:getStageCfg(activityCfg.stagePlanId, stageId)

	self._cfgEnemy = DivineSKLieXinClgConfig.instance:getTeamCfg(stageCfg.creepsMasterId)
	self._masterList = DivineSKLieXinClgConfig.instance:getCreepsCfg(stageCfg.creepsMasterId)
	self.topTitleStr = self._cfgEnemy.name
	self.ruleDescStr = self._cfgEnemy.WinDesc

	self:setFormCondition(self._cfgEnemy.formCondition)

	self._tagPosIdMap = DivineSKLieXinClgModel.instance:getTempTagPos(stageId) or {}
end

function DivineSKLieXinClgFmtMo:initFightHandler()
	local function handler()
		UIJumper.instance:saveCurStack(ViewName.CustomMissionView, ViewName.CustomFormationView)

		local simpleForm = self:getCurSimpleForm()
		local tagPosIds = {}

		for i, v in pairs(self._tagPosIdMap) do
			table.insert(tagPosIds, i)
		end

		DivineSKLieXinClgModel.instance:saveTempTagPos(self.stageId, self._tagPosIdMap)
		DivineSKLieXinClgAgent.instance:sendPM_DivineSKLieXinClgChallengeReq(self.activityId, self.stageId, simpleForm, tagPosIds)
	end

	self:setFightHandler(handler, nil)
end

function DivineSKLieXinClgFmtMo:onClickCloseBtn(handler)
	DivineSKLieXinClgModel.instance:saveTempTagPos(self.stageId, self._tagPosIdMap)
	GameUtil.callBack(handler)
end

function DivineSKLieXinClgFmtMo:getMonsterConfigList()
	return self._masterList
end

function DivineSKLieXinClgFmtMo:getFmtInfoConfig()
	return self._cfgEnemy
end

function DivineSKLieXinClgFmtMo:setTagPos(pos, isSet)
	self._tagPosIdMap[pos] = isSet == true and true or nil
end

function DivineSKLieXinClgFmtMo:resetAllTagPos()
	table.clear(self._tagPosIdMap)
end

function DivineSKLieXinClgFmtMo:getTagPos(pos)
	return self._tagPosIdMap[pos]
end

function DivineSKLieXinClgFmtMo:getExtendViewName()
	return ViewName.DivineSKLieXinClgFmtView
end

function DivineSKLieXinClgFmtMo:checkFormationEmptyAndPosNumLimit(posLimitCallback, hasOneKey, onekeyCallBack)
	if FormationFacade.instance:checkFormationEmptyByFmo(self:getCurFormation()) then
		if hasOneKey then
			TipsFacade.instance:openPopupWindowWithX(lang("tip"), lang("fight_unformation"), function()
				return
			end, onekeyCallBack, lang("fight_goto_fmt"), lang("一键布阵"))
		else
			TipsFacade.instance:openTipWindow(lang("tip"), lang("fight_unformation"), nil, lang("fight_goto_fmt"))
		end

		return true
	end

	local tagCount = 0
	local activityCfg = DivineSKLieXinClgConfig.instance:getActivityCfg(self.activityId)
	local stageCfg = DivineSKLieXinClgConfig.instance:getStageCfg(activityCfg.stagePlanId, self.stageId)

	if stageCfg.tagCount == 0 then
		return (FormationFacade.instance:checkFormationPosNumber(posLimitCallback, hasOneKey, onekeyCallBack, self:getCurFormation()))
	else
		for k, v in pairs(self._tagPosIdMap) do
			if v == true then
				tagCount = tagCount + 1
			end
		end

		if tagCount == 0 then
			TipsFacade.instance:openPopupWindowWithX(lang("tip"), lang("未使用红莲道具，是否继续"), function()
				local isLimit = FormationFacade.instance:checkFormationPosNumber(posLimitCallback, hasOneKey, onekeyCallBack, self:getCurFormation())

				if not isLimit then
					posLimitCallback()
				end
			end, function()
				return
			end, lang("继续挑战"), lang("取消"))

			return true
		else
			return (FormationFacade.instance:checkFormationPosNumber(posLimitCallback, hasOneKey, onekeyCallBack, self:getCurFormation()))
		end
	end
end

return DivineSKLieXinClgFmtMo
