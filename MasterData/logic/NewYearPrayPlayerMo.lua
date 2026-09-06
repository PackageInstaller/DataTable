-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newyearpray/view/NewYearPrayPlayerMo.lua

module("logic.extensions.newyearpray.view.NewYearPrayPlayerMo", package.seeall)

local NewYearPrayPlayerMo = class("NewYearPrayPlayerMo")

function NewYearPrayPlayerMo:ctor(activityId)
	self._activityId = activityId

	self:onReset()
end

function NewYearPrayPlayerMo:onReset()
	self._curStepId = 1
	self._choiceIds = {}
	self._scores = {}
	self._choiceLanternId = 0
end

function NewYearPrayPlayerMo:getActivityId()
	return self._activityId
end

function NewYearPrayPlayerMo:setCurStepId(stepId)
	self._curStepId = stepId
end

function NewYearPrayPlayerMo:getCurStepId()
	return self._curStepId
end

function NewYearPrayPlayerMo:setChoiceId(stepId, choiceId)
	self._choiceIds[stepId] = choiceId
end

function NewYearPrayPlayerMo:getChoiceId(stepId)
	return self._choiceIds[stepId]
end

function NewYearPrayPlayerMo:setScore(stepId, score)
	self._scores[stepId] = score
end

function NewYearPrayPlayerMo:getScore(stepId)
	return self._scores[stepId]
end

function NewYearPrayPlayerMo:setChoiceLanternId(lanternId)
	self._choiceLanternId = lanternId
end

function NewYearPrayPlayerMo:getChoiceLanternId()
	return self._choiceLanternId
end

function NewYearPrayPlayerMo:getTodayWishingTabId()
	local key = "Nyp_Wishing_tab"
	local value = GameUtil.getUserDayData(key)

	if value == nil then
		local cfg = NewYearPrayConfig.instance:getNypWishingTabCfgByAct(self._activityId)

		value = Mathf.Random(1, #cfg)

		GameUtil.saveUserDayData(key, tabId)
	end

	return checknumber(value)
end

return NewYearPrayPlayerMo
