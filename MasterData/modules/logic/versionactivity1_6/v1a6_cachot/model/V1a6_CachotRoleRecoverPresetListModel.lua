-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/model/V1a6_CachotRoleRecoverPresetListModel.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.model.V1a6_CachotRoleRecoverPresetListModel", package.seeall)

local V1a6_CachotRoleRecoverPresetListModel = class("V1a6_CachotRoleRecoverPresetListModel", ListScrollModel)

function V1a6_CachotRoleRecoverPresetListModel:onInit()
	return
end

function V1a6_CachotRoleRecoverPresetListModel:reInit()
	self:onInit()
end

function V1a6_CachotRoleRecoverPresetListModel:getEquip(mo)
	return self._equipMap[mo]
end

function V1a6_CachotRoleRecoverPresetListModel:initList()
	V1a6_CachotTeamModel.instance:clearSeatInfos()

	local rogueInfo = V1a6_CachotModel.instance:getRogueInfo()
	local teamInfo = rogueInfo.teamInfo
	local heroList = teamInfo:getGroupLiveHeros()
	local equipList = teamInfo:getGroupEquips()

	self._equipMap = {}

	local list = {}

	for i = 1, V1a6_CachotEnum.HeroCountInGroup do
		local mo = heroList[i]

		table.insert(list, mo)

		self._equipMap[mo] = equipList[i]

		V1a6_CachotTeamModel.instance:setSeatInfo(i, V1a6_CachotTeamModel.instance:getSeatLevel(i), mo)
	end

	self:setList(list)
end

V1a6_CachotRoleRecoverPresetListModel.instance = V1a6_CachotRoleRecoverPresetListModel.New()

return V1a6_CachotRoleRecoverPresetListModel
