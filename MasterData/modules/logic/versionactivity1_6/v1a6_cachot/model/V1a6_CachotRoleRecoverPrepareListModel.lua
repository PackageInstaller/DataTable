-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/model/V1a6_CachotRoleRecoverPrepareListModel.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.model.V1a6_CachotRoleRecoverPrepareListModel", package.seeall)

local V1a6_CachotRoleRecoverPrepareListModel = class("V1a6_CachotRoleRecoverPrepareListModel", ListScrollModel)

function V1a6_CachotRoleRecoverPrepareListModel:onInit()
	return
end

function V1a6_CachotRoleRecoverPrepareListModel:reInit()
	self:onInit()
end

function V1a6_CachotRoleRecoverPrepareListModel:initList()
	local rogueInfo = V1a6_CachotModel.instance:getRogueInfo()
	local teamInfo = rogueInfo.teamInfo
	local heroList = teamInfo:getSupportLiveHeros()

	table.sort(heroList, V1a6_CachotRoleRecoverPrepareListModel.sort)

	local pageNum = math.ceil(#heroList / 4)

	pageNum = math.max(pageNum, 1)

	for i = #heroList + 1, pageNum * 4 do
		table.insert(heroList, HeroSingleGroupMO.New())
	end

	self:setList(heroList)
end

function V1a6_CachotRoleRecoverPrepareListModel.sort(a, b)
	if a.hp ~= b.hp then
		return a.hp > b.hp
	end

	a = a._heroMO
	b = b._heroMO

	if a.config.rare ~= b.config.rare then
		return a.config.rare > b.config.rare
	elseif a.level ~= b.level then
		return a.level > b.level
	elseif a.heroId ~= b.heroId then
		return a.heroId > b.heroId
	end
end

V1a6_CachotRoleRecoverPrepareListModel.instance = V1a6_CachotRoleRecoverPrepareListModel.New()

return V1a6_CachotRoleRecoverPrepareListModel
