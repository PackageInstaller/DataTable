-- chunkname: @modules/logic/rouge2/bossbattle/model/Rouge2_BossBattleStageRewardListModel.lua

module("modules.logic.rouge2.bossbattle.model.Rouge2_BossBattleStageRewardListModel", package.seeall)

local Rouge2_BossBattleStageRewardListModel = class("Rouge2_BossBattleStageRewardListModel", ListScrollModel)

function Rouge2_BossBattleStageRewardListModel:refreshList(bossId, bossInfo)
	self._bossId = bossId
	self._bossInfo = bossInfo
	self._rewardCoList = Rouge2_BossBattleConfig.instance:getRewardListByBossId(self._bossId)

	local dataList = {}

	for index, rewardCo in ipairs(self._rewardCoList or {}) do
		local status = self._bossInfo and self._bossInfo:getRewardStatus(rewardCo.id) or Rouge2_OutsideEnum.BossRewardStatus.Lock

		table.insert(dataList, {
			index = index,
			config = rewardCo,
			status = status,
			bossInfo = self._bossInfo
		})
	end

	self:setList(dataList)
end

function Rouge2_BossBattleStageRewardListModel:getKeyRewardList()
	return {}
end

Rouge2_BossBattleStageRewardListModel.instance = Rouge2_BossBattleStageRewardListModel.New()

return Rouge2_BossBattleStageRewardListModel
