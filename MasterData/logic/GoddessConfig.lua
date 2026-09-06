-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddess/config/GoddessConfig.lua

module("logic.extensions.goddess.config.GoddessConfig", package.seeall)

local GoddessConfig = class("GoddessConfig", BaseConfig)

function GoddessConfig:onInit()
	GoddessConfig.super.onInit(self)

	self._actCfgs = nil
	self._goddessCfgs = nil
	self._commonCfgs = nil
	self._flowerCfgs = nil
	self._goodFeelingLvCfgs = nil
	self._goodFeelingPrizeCfgs = nil
	self._touchCfgs = nil
	self._rankPrizeCfgs = nil
end

function GoddessConfig:getNames()
	return {
		"goddess_activity",
		"goddess_pet",
		"goddess_common",
		"goddess_flower",
		"goddess_feeling_lv",
		"goddess_feeling_prize",
		"goddess_touch",
		"goddess_rank_prize",
		"goddess_game",
		"goddess_pet_chat",
		"goddess_chat_text",
		"goddess_text"
	}
end

function GoddessConfig:handleConfig(name, content)
	if name == "goddess_activity" then
		self._actCfgs = content
	elseif name == "goddess_pet" then
		self._goddessCfgs = content
	elseif name == "goddess_common" then
		self._commonCfgs = content
	elseif name == "goddess_flower" then
		self._flowerCfgs = content
	elseif name == "goddess_feeling_lv" then
		self._goodFeelingLvCfgs = content
	elseif name == "goddess_feeling_prize" then
		self._goodFeelingPrizeCfgs = content
	elseif name == "goddess_touch" then
		self._touchCfgs = content
	elseif name == "goddess_rank_prize" then
		self._rankPrizeCfgs = content
	elseif name == "goddess_game" then
		self._goddess_game = content
	elseif name == "goddess_pet_chat" then
		self._goddess_pet_chat = content
	elseif name == "goddess_chat_text" then
		self._goddess_chat_text = content
	elseif name == "goddess_text" then
		self._goddess_text = content
	end
end

function GoddessConfig:getActCfgByActId(actId)
	return self._actCfgs[actId]
end

function GoddessConfig:getGoddessCfgsByActId(actId)
	return self._goddessCfgs[actId]
end

function GoddessConfig:getGoddessCfg(actId, raceId)
	return self._goddessCfgs[actId][raceId]
end

function GoddessConfig:getFlowerCfgsByActId(actId)
	local actCfg = self:getActCfgByActId(actId)

	if actCfg then
		return self._flowerCfgs[actCfg.flowerPlanId]
	end
end

function GoddessConfig:getGoodFeelingLvCfgs(actId, raceId)
	local gooddessCfg = self:getGoddessCfg(actId, raceId)

	if gooddessCfg then
		return self._goodFeelingLvCfgs[gooddessCfg.feelingPlanId]
	end
end

function GoddessConfig:getGoodFeelingLvCfgsByIds(actId, raceId, id)
	local lvCfgs = self:getGoodFeelingLvCfgsByIds(actId, raceId)

	if lvCfgs then
		return lvCfgs[id]
	end
end

function GoddessConfig:getGoodFeelingPrizeCfgsByIds(actId, raceId)
	local gooddessCfg = self:getGoddessCfg(actId, raceId)

	if gooddessCfg then
		return self._goodFeelingPrizeCfgs[gooddessCfg.feelingPrizePlanId]
	end
end

function GoddessConfig:getTouchCfgByActId(actId)
	local actCfg = self:getActCfgByActId(actId)

	if actCfg then
		return self._touchCfgs[actCfg.touchPlanId]
	end
end

function GoddessConfig:getRankCfgsByActId(actId)
	if not self._rankPrizeCfgs[actId] then
		local list = {}

		if #list > 0 then
			local list1 = table.values(list)

			table.sort(list1, function(a, b)
				return a.rank < b.rank
			end)

			local startNum = 0
			local list2 = {}

			for _, v in ipairs(list1) do
				for i = startNum + 1, v.rank do
					list2[i] = v
				end

				startNum = v.rank
			end

			return list2
		end
	end
end

function GoddessConfig:getTouchLimit()
	return checkint(self._commonCfgs.TOUCH_TIMES.value)
end

function GoddessConfig:getDailyAddGoodFeelingLimit()
	return checkint(self._commonCfgs.FLOWER_FEELING_LIMIT.value)
end

function GoddessConfig:getCommonValue(key, need2number)
	local value = ""

	if self._commonCfgs[key] then
		value = not string.nilorempty(self._commonCfgs[key].value2) and self._commonCfgs[key].value2 or self._commonCfgs[key].value
	end

	if need2number then
		return checkint(value)
	else
		return value
	end
end

function GoddessConfig:getGameTotalTime()
	return self:getCommonValue("BALLOON_TIMES", true)
end

function GoddessConfig:getGameReliveTotalTime()
	return self:getCommonValue("BALL_RESURRECTION_TIMES", true)
end

function GoddessConfig:getScalePrizeCfgs(planId)
	local cfgs = self._goddess_game[planId]
	local newCfgs = {}

	for k, v in pairs(cfgs) do
		table.insert(newCfgs, v)
	end

	table.sort(newCfgs, function(a, b)
		return a.scale < b.scale
	end)

	return newCfgs
end

function GoddessConfig:getTotalChatTime()
	return self:getCommonValue("CHAT_TIMES", true)
end

function GoddessConfig:getPetChatCfgs(raceId, goodfeelLv)
	local cfgs = self._goddess_pet_chat[raceId]
	local lvLimit = 0

	for i, v in ipairs(cfgs) do
		if goodfeelLv > v.lvLimit then
			lvLimit = v.lvLimit
		end
	end

	local cfgs1 = self._goddess_pet_chat[raceId][lvLimit]

	if cfgs1 then
		for k, v in pairs(cfgs1) do
			-- block empty
		end
	end
end

function GoddessConfig:getChatTextCfgByChatId(chatId)
	return self._goddess_chat_text[chatId]
end

function GoddessConfig:getChatTextCfgsByChatOrder(planId, order)
	local list = {}

	for i, v in ipairs(self._goddess_chat_text.dataList) do
		if v.planId == planId and order == v.num then
			table.insert(list, v)
		end
	end

	return list
end

function GoddessConfig:getGoddessTexts(raceId, lv)
	local texts = {}
	local cfgs = self._goddess_text[raceId]

	if cfgs then
		for k, v in pairs(cfgs) do
			local lvDown, lvUp = checkint(v.interval[1]), checkint(v.interval[2])

			if lvDown <= lv and lv <= lvUp then
				table.insert(texts, v.text)
			end
		end
	end

	return texts
end

GoddessConfig.instance = GoddessConfig.New()

return GoddessConfig
