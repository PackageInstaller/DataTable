-- chunkname: @modules/logic/bossrush/model/v1a6/V1a6_BossRush_BonusModel.lua

module("modules.logic.bossrush.model.v1a6.V1a6_BossRush_BonusModel", package.seeall)

local V1a6_BossRush_BonusModel = class("V1a6_BossRush_BonusModel", BaseModel)

function V1a6_BossRush_BonusModel:selecAchievementTab(stage, actId)
	V1a4_BossRush_ScoreTaskAchievementListModel.instance:setAchievementMoList(stage, actId)
end

function V1a6_BossRush_BonusModel:selectScheduleTab(stage, actId)
	V1a4_BossRush_ScheduleViewListModel.instance:setScheduleMoList(stage, actId)
end

function V1a6_BossRush_BonusModel:selectSpecialScheduleTab(stage, actId)
	V2a1_BossRush_SpecialScheduleViewListModel.instance:setMoList(stage, actId)
end

function V1a6_BossRush_BonusModel:getScheduleRewardData(actId, stage)
	local dataList = BossRushModel.instance:getScheduleViewRewardList(stage)

	if dataList then
		local stageMo = V3a9_BossRushModel.instance:getStageMo(actId, stage)
		local dataCount = #dataList
		local cur = stageMo and stageMo:getTotalPoint() or 0
		local max = stageMo and stageMo:getRewardMaxTotalScore() or 0
		local data = {
			dataCount = dataCount,
			curNum = cur
		}

		if cur == 0 then
			data.lastIndex = 0
			data.nextIndex = 1
		elseif max <= cur then
			data.lastIndex = dataCount
			data.nextIndex = dataCount
		else
			for i, v in pairs(dataList) do
				local num = v.stageRewardCO.rewardPointNum

				if cur <= num then
					data.lastIndex = cur == num and i or i - 1
					data.nextIndex = i

					break
				end
			end
		end

		data.lastIndex = data.lastIndex or 0
		data.nextIndex = data.nextIndex or 1

		if dataList[data.lastIndex] then
			data.lastNum = dataList[data.lastIndex].stageRewardCO.rewardPointNum or 0
		end

		if dataList[data.nextIndex] then
			data.nextNum = dataList[data.nextIndex].stageRewardCO.rewardPointNum or 0
		end

		return data
	end
end

function V1a6_BossRush_BonusModel:getScheduleProgressWidth(actId, stage, spacing, offset)
	local data = self:getScheduleRewardData(actId, stage)
	local grayWidth, gotWidth

	if data then
		local dataCount = data.dataCount

		grayWidth = (dataCount - 1) * spacing + offset

		if data.lastIndex and data.nextIndex then
			if data.lastIndex == data.nextIndex then
				gotWidth = data.lastIndex > 1 and (data.lastIndex - 1) * spacing + offset or offset
			else
				local extra = (data.curNum - data.lastNum) / (data.nextNum - data.lastNum)

				gotWidth = data.lastIndex > 0 and (data.lastIndex - 1 + extra) * spacing + offset or extra * offset
			end
		end
	end

	return grayWidth, gotWidth
end

function V1a6_BossRush_BonusModel:getLayer4RewardData(stage)
	local dataList = BossRushModel.instance:getSpecialScheduleViewRewardList(stage)

	if dataList then
		local dataCount = #dataList
		local cur = BossRushModel.instance:getLayer4CurScore(stage)
		local max = BossRushModel.instance:getLayer4MaxRewardScore(stage)
		local data = {
			dataCount = dataCount,
			curNum = cur
		}

		if cur == 0 then
			data.lastIndex = 0
			data.nextIndex = 1
		elseif max <= cur then
			data.lastIndex = dataCount
			data.nextIndex = dataCount
		else
			for i, v in pairs(dataList) do
				local num = v.config.maxProgress

				if cur <= num then
					data.lastIndex = cur == num and i or i - 1
					data.nextIndex = i

					break
				end
			end
		end

		data.lastIndex = data.lastIndex or 0
		data.nextIndex = data.nextIndex or 1

		if dataList[data.lastIndex] then
			data.lastNum = dataList[data.lastIndex].config.maxProgress or 0
		end

		if dataList[data.nextIndex] then
			data.nextNum = dataList[data.nextIndex].config.maxProgress or 0
		end

		return data
	end
end

function V1a6_BossRush_BonusModel:getLayer4ProgressWidth(stage, spacing, offset)
	local data = self:getLayer4RewardData(stage)
	local grayWidth, gotWidth

	if data then
		local dataCount = data.dataCount

		grayWidth = (dataCount - 1) * spacing + offset

		if data.lastIndex and data.nextIndex then
			if data.lastIndex == data.nextIndex then
				gotWidth = data.lastIndex > 1 and (data.lastIndex - 1) * spacing + offset or offset
			else
				local extra = (data.curNum - data.lastNum) / (data.nextNum - data.lastNum)

				gotWidth = data.lastIndex > 0 and (data.lastIndex - 1 + extra) * spacing + offset or extra * offset
			end
		end
	end

	return grayWidth, gotWidth
end

function V1a6_BossRush_BonusModel:getTab()
	return self._selectTab or BossRushEnum.BonusViewTab.AchievementTab
end

function V1a6_BossRush_BonusModel:setTab(tab)
	self._selectTab = tab
end

V1a6_BossRush_BonusModel.instance = V1a6_BossRush_BonusModel.New()

return V1a6_BossRush_BonusModel
