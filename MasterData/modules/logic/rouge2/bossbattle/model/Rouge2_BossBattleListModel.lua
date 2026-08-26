-- chunkname: @modules/logic/rouge2/bossbattle/model/Rouge2_BossBattleListModel.lua

module("modules.logic.rouge2.bossbattle.model.Rouge2_BossBattleListModel", package.seeall)

local Rouge2_BossBattleListModel = class("Rouge2_BossBattleListModel", MixScrollModel)

function Rouge2_BossBattleListModel:initList()
	local bossMoList = self:_buildList()

	self:setList(bossMoList)
end

function Rouge2_BossBattleListModel:_buildList()
	local bossList = {}
	local bossConfigList = Rouge2_BossBattleConfig.instance:getAllBossConfigList() or {}
	local bossBattleInfo = Rouge2_OutsideModel.instance:getBossBattleInfo()

	for _, bossCo in ipairs(bossConfigList) do
		table.insert(bossList, bossCo)
	end

	table.sort(bossList, self._bossSortFunc)

	return bossList
end

function Rouge2_BossBattleListModel._bossSortFunc(aBossCo, bBossCo)
	return aBossCo.id < bBossCo.id
end

function Rouge2_BossBattleListModel:getInfoList(scrollGO)
	local mixCellInfos = {}
	local list = self:getList()

	for i, mo in ipairs(list) do
		local mixCellInfo = SLFramework.UGUI.MixCellInfo.New(i, 600, i)

		table.insert(mixCellInfos, mixCellInfo)
	end

	return mixCellInfos
end

Rouge2_BossBattleListModel.instance = Rouge2_BossBattleListModel.New()

return Rouge2_BossBattleListModel
