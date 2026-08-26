-- chunkname: @modules/logic/bossrush/model/V1a4_BossRush_ScheduleViewListModel.lua

module("modules.logic.bossrush.model.V1a4_BossRush_ScheduleViewListModel", package.seeall)

local V1a4_BossRush_ScheduleViewListModel = class("V1a4_BossRush_ScheduleViewListModel", ListScrollModel)

function V1a4_BossRush_ScheduleViewListModel:setStaticData(staticData)
	self._staticData = staticData
end

function V1a4_BossRush_ScheduleViewListModel:getStaticData()
	return self._staticData
end

function V1a4_BossRush_ScheduleViewListModel:getFinishCount(moList, stage)
	local count = 0

	for _, mo in pairs(moList) do
		if not mo.isGot and mo.isAlready then
			count = count + 1
		end
	end

	return count
end

function V1a4_BossRush_ScheduleViewListModel:setScheduleMoList(stage, actId)
	local stageMo = V3a9_BossRushModel.instance:getStageMo(actId, stage)
	local moList = stageMo and stageMo:getScheduleViewRewardList(stage) or {}
	local finishTaskCount = stageMo and stageMo:getFinishScheduleRewardCount() or 0

	if finishTaskCount > 1 then
		table.insert(moList, 1, {
			getAll = true,
			stage = stage
		})
	end

	table.sort(moList, self._sort)
	self:setList(moList)
end

function V1a4_BossRush_ScheduleViewListModel._sort(a, b)
	if a.getAll then
		return true
	end

	if b.getAll then
		return false
	end

	local a_config = a.stageRewardCO
	local b_config = b.stageRewardCO
	local a_id = a_config.id
	local b_id = a_config.id
	local a_isGot = a.isGot and 1 or 0
	local b_isGot = b.isGot and 1 or 0
	local a_isAvaliable = a.isAlready and 1 or 0
	local b_isAvaliable = b.isAlready and 1 or 0
	local a_maxProgress = a_config.rewardPointNum
	local b_maxProgress = b_config.rewardPointNum

	if a_isGot ~= b_isGot then
		return a_isGot < b_isGot
	end

	if a_isAvaliable ~= b_isAvaliable then
		return b_isAvaliable < a_isAvaliable
	end

	if a_maxProgress ~= b_maxProgress then
		return a_maxProgress < b_maxProgress
	end

	return a_id < b_id
end

function V1a4_BossRush_ScheduleViewListModel:isReddot(stage)
	local moList = BossRushModel.instance:getScheduleViewRewardList(stage)
	local info = BossRushModel.instance:getLastPointInfo(stage)

	if info then
		if not info.cur then
			local cur = 0

			for _, mo in pairs(moList) do
				local isAlready = cur >= mo.stageRewardCO.rewardPointNum
				local isGot = BossRushModel.instance:hasGetBonusIds(stage, mo.id)

				if not mo.isGot and isAlready then
					return true
				end
			end
		end
	end
end

V1a4_BossRush_ScheduleViewListModel.instance = V1a4_BossRush_ScheduleViewListModel.New()

return V1a4_BossRush_ScheduleViewListModel
