-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nailonghotsearch/config/NaiLongHotSearchConfig.lua

module("logic.extensions.nailonghotsearch.config.NaiLongHotSearchConfig", package.seeall)

local NaiLongHotSearchConfig = class("NaiLongHotSearchConfig", BaseConfig)

function NaiLongHotSearchConfig:onInit()
	NaiLongHotSearchConfig.super.onInit(self)
end

function NaiLongHotSearchConfig:getNames()
	return {
		"hot_search_activity",
		"hot_search_information",
		"hot_search_reply_plan",
		"hot_search_reply_npc",
		"hot_search_process_prize",
		"hot_search_note"
	}
end

function NaiLongHotSearchConfig:handleConfig(name, content)
	if name == "hot_search_activity" then
		self._hot_search_activity = content
	elseif name == "hot_search_information" then
		self._hot_search_information = content
	elseif name == "hot_search_reply_plan" then
		self._hot_search_reply_plan = content
	elseif name == "hot_search_reply_npc" then
		self._hot_search_reply_npc = content
	elseif name == "hot_search_process_prize" then
		self._hot_search_process_prize = content
	elseif name == "hot_search_note" then
		self._hot_search_note = content
	end
end

function NaiLongHotSearchConfig:getActData(activityId)
	return self._hot_search_activity[activityId]
end

function NaiLongHotSearchConfig:getInformationCfg(activityId)
	return self._hot_search_information[activityId]
end

function NaiLongHotSearchConfig:getInformationData(activityId, informationId)
	if self._hot_search_information[activityId] then
		return self._hot_search_information[activityId][informationId]
	end
end

function NaiLongHotSearchConfig:getReplyPlanCfg(activityId, informationId)
	local data = self:getInformationData(activityId, informationId)
	local replyPlanId = data and data.replyPlanId

	if replyPlanId then
		return self._hot_search_reply_plan[replyPlanId]
	end
end

function NaiLongHotSearchConfig:getReplyPlanData(activityId, informationId, replyId)
	local cfg = self:getReplyPlanCfg(activityId, informationId)

	if cfg then
		return cfg[replyId]
	end
end

function NaiLongHotSearchConfig:getReplyNpcCfg(replyId)
	return self._hot_search_reply_npc[replyId]
end

function NaiLongHotSearchConfig:getReplyNpcData(replyId, npcId)
	if self._hot_search_reply_npc[replyId] then
		return self._hot_search_reply_npc[replyId][npcId]
	end
end

function NaiLongHotSearchConfig:getMaxNpcId(replyId)
	local cfg = self._hot_search_reply_npc[replyId]

	return (cfg or nil) and (#cfg or 0)
end

function NaiLongHotSearchConfig:getProPrizeCfg(activityId)
	return self._hot_search_process_prize[activityId]
end

function NaiLongHotSearchConfig:getProPrizeData(activityId, prizeId)
	if self._hot_search_process_prize[activityId] then
		return self._hot_search_process_prize[activityId][prizeId]
	end
end

function NaiLongHotSearchConfig:getNoteCfg(activityId)
	return self._hot_search_note[activityId]
end

function NaiLongHotSearchConfig:getNoteData(activityId, noteId)
	if self._hot_search_note[activityId] then
		return self._hot_search_note[activityId][noteId]
	end
end

NaiLongHotSearchConfig.instance = NaiLongHotSearchConfig.New()

return NaiLongHotSearchConfig
