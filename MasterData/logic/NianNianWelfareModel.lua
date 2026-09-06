-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/niannianwelfare/model/NianNianWelfareModel.lua

module("logic.extensions.niannianwelfare.model.NianNianWelfareModel", package.seeall)

local NianNianWelfareModel = class("NianNianWelfareModel", BaseModel)

function NianNianWelfareModel:onReset()
	NianNianWelfareModel.super.onReset(self)
end

function NianNianWelfareModel:setDailyItemNum(dailyItemNum)
	self._dailyItemNum = dailyItemNum
end

function NianNianWelfareModel:getDailyItemNum()
	return self._dailyItemNum
end

function NianNianWelfareModel:setIsGainDailyPrize(isGainDailyPrize)
	self._isGainDailyPrize = isGainDailyPrize
end

function NianNianWelfareModel:isGainDailyPrize()
	return self._isGainDailyPrize
end

function NianNianWelfareModel:setIsRefine(isRefine)
	self._isRefine = isRefine
end

function NianNianWelfareModel:isRefine()
	return self._isRefine
end

function NianNianWelfareModel:setGainAchievementPrizeIds(gainAchievementPrizeIds)
	self._gainAchievementPrizeIds = {}

	for i, id in ipairs(gainAchievementPrizeIds) do
		self._gainAchievementPrizeIds[id] = true
	end
end

function NianNianWelfareModel:gainAchievementPrize(id)
	self._gainAchievementPrizeIds[id] = true
end

function NianNianWelfareModel:isGainAchievementPrizeById(id)
	return self._gainAchievementPrizeIds[id]
end

function NianNianWelfareModel:setPartinfos(infos, planId)
	self._partInfos = {
		lv = 0,
		maxLevel = 0
	}

	local partCfg = NianNianWelfareConfig.instance:getPartByPlanId(planId)

	for i, v in ipairs(infos) do
		self._partInfos[v.id] = clone(partCfg[v.id])
		self._partInfos[v.id].level = v.level
		self._partInfos.lv = self._partInfos.lv + v.level
		self._partInfos.maxLevel = self._partInfos.maxLevel + partCfg[v.id].maxLevel
	end
end

function NianNianWelfareModel:upPart(partId)
	self._partInfos[partId].level = self._partInfos[partId].level + 1
	self._partInfos.lv = self._partInfos.lv + 1
end

function NianNianWelfareModel:getPartInfo()
	return self._partInfos
end

function NianNianWelfareModel:getPartInfoById(partId)
	return self._partInfos[partId]
end

NianNianWelfareModel.instance = NianNianWelfareModel.New()

return NianNianWelfareModel
