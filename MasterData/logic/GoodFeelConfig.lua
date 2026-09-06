-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goodfeel/config/GoodFeelConfig.lua

module("logic.extensions.goodfeel.config.GoodFeelConfig", package.seeall)

local GoodFeelConfig = class("GoodFeelConfig", BaseConfig)

function GoodFeelConfig:onInit()
	return
end

function GoodFeelConfig:getNames()
	return {
		"good_feeling_common",
		"good_feeling_lv",
		"good_feeling_prize_plan",
		"good_feeling_prop",
		"good_feeling_self_chat",
		"good_feeling_schedule_chat_plan",
		"good_feeling_chat_reply_plan",
		"good_feeling_event",
		"good_feeling_answer",
		"good_feeling_lv_prop"
	}
end

function GoodFeelConfig:handleConfig(name, content)
	if name == "good_feeling_common" then
		self._good_feeling_commonCfg = content
	elseif name == "good_feeling_lv" then
		self._good_feeling_lvCfg = content
	elseif name == "good_feeling_prize_plan" then
		self._good_feeling_prize_planCfg = content
	elseif name == "good_feeling_prop" then
		self._good_feeling_propCfg = content
		self._good_feeling_propPlanIdKeyCfg = {}

		for i, v in pairs(content) do
			if v.planId then
				self._good_feeling_propPlanIdKeyCfg[v.planId] = self._good_feeling_propPlanIdKeyCfg[v.planId] or {}

				table.insert(self._good_feeling_propPlanIdKeyCfg[v.planId], v)
			end
		end

		for k, v in pairs(self._good_feeling_propPlanIdKeyCfg) do
			table.sort(v, function(a, b)
				return a.unlockLv < b.unlockLv
			end)
		end
	elseif name == "good_feeling_self_chat" then
		self._good_feeling_self_chatCfg = content
	elseif name == "good_feeling_schedule_chat_plan" then
		self._good_feeling_schedule_chat_planCfg = content
	elseif name == "good_feeling_chat_reply_plan" then
		self._good_feeling_chat_reply_planCfg = content
	elseif name == "good_feeling_event" then
		self._good_feeling_eventCfg = content
	elseif name == "good_feeling_answer" then
		self._good_feeling_answerCfg = content
	elseif name == "good_feeling_lv_prop" then
		self._good_feeling_lv_prop = content

		self:_onCalLvPropMinAndMaxLv()
	end
end

function GoodFeelConfig:getTodayInteractCount()
	return checknumber(self._good_feeling_commonCfg.DAILY_INTERACT_COUNT.value)
end

function GoodFeelConfig:getCommonAnswerEventDesc()
	return lang("我觉得这一题你不一定会哦！说好了不许偷看！上网查的都是小傻瓜！")
end

function GoodFeelConfig:getDaylySelfChatCount()
	return checknumber(self._good_feeling_commonCfg.DAILY_SELF_CHAT_COUNT.value)
end

function GoodFeelConfig:getLvByGoodFeelExp(goodFeelExp)
	local lv = 1

	goodFeelExp = checknumber(goodFeelExp)

	for i, cfg in ipairs(self._good_feeling_lvCfg) do
		if goodFeelExp < cfg.exp then
			break
		else
			lv = i
		end
	end

	return lv
end

function GoodFeelConfig:getGoodFeelExpCfgs()
	return self._good_feeling_lvCfg
end

function GoodFeelConfig:getGoodFeelExpCfg(lv)
	return self._good_feeling_lvCfg[lv]
end

function GoodFeelConfig:getPrizePlan(planId)
	self._good_feeling_prize_planCfgCache = self._good_feeling_prize_planCfgCache or {}

	if not self._good_feeling_prize_planCfgCache[planId] then
		local list = {}
		local cfg = self._good_feeling_prize_planCfg[planId]

		for k, v in pairs(cfg) do
			table.insert(list, v)
		end

		table.sort(list, function(a, b)
			return a.lv < b.lv
		end)

		self._good_feeling_prize_planCfgCache[planId] = list
	end

	return self._good_feeling_prize_planCfgCache[planId]
end

function GoodFeelConfig:getSelfChatCfg(id)
	return self._good_feeling_self_chatCfg[id]
end

function GoodFeelConfig:getSelfChatCfgs()
	return self._good_feeling_self_chatCfg
end

function GoodFeelConfig:getReplyPlanCfg(planId)
	return self._good_feeling_chat_reply_planCfg[planId]
end

function GoodFeelConfig:getReplyPlanCfgById(planId, id)
	return self._good_feeling_chat_reply_planCfg[planId][id]
end

function GoodFeelConfig:getUnlockVoiceCfgs(raceId)
	return CharacterConfig.instance:getPetCvCfg(raceId) or {}
end

function GoodFeelConfig:getStroyCfgsByPlantId(planId)
	return self._good_feeling_propPlanIdKeyCfg[planId]
end

function GoodFeelConfig:getHudongEvent(id)
	return self._good_feeling_eventCfg[id]
end

function GoodFeelConfig:getAnsertEvent(id)
	return self._good_feeling_answerCfg[id]
end

function GoodFeelConfig:getGoodFeelingPorp(id)
	return self._good_feeling_propCfg[id]
end

function GoodFeelConfig:getSheduleChatCfgs(planId)
	return self._good_feeling_schedule_chat_planCfg[planId]
end

function GoodFeelConfig:getLvPropCfgs(planId)
	return self._good_feeling_lv_prop[planId]
end

function GoodFeelConfig:getLvPropCfg(planId, unlockLv)
	if self._good_feeling_lv_prop[planId] then
		return self._good_feeling_lv_prop[planId][unlockLv]
	end
end

function GoodFeelConfig:_onCalLvPropMinAndMaxLv()
	self._propLvMinMaxLv = {}

	for i, v in ipairs(self._good_feeling_lv_prop.dataList) do
		self._propLvMinMaxLv[v.planId] = self._propLvMinMaxLv[v.planId] or {
			minLv = -1,
			maxLv = 0
		}

		if self._propLvMinMaxLv[v.planId].minLv < 0 then
			self._propLvMinMaxLv[v.planId].minLv = v.unlockLv
			self._propLvMinMaxLv[v.planId].maxLv = v.unlockLv
		else
			self._propLvMinMaxLv[v.planId].minLv = math.min(self._propLvMinMaxLv[v.planId].minLv, v.unlockLv)
			self._propLvMinMaxLv[v.planId].maxLv = math.max(self._propLvMinMaxLv[v.planId].maxLv, v.unlockLv)
		end
	end
end

function GoodFeelConfig:getMinAndMaxPropLvByRaceId(raceId)
	local detailCfg = HandbookConfig.instance:getPetDetailsCfgById(raceId)
	local data = self._propLvMinMaxLv[detailCfg.propertyPlan]

	if data then
		return data.minLv, data.maxLv
	else
		return 0, 0
	end
end

GoodFeelConfig.instance = GoodFeelConfig.New()

return GoodFeelConfig
