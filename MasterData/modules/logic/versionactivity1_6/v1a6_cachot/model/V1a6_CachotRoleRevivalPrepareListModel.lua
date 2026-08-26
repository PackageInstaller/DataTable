-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/model/V1a6_CachotRoleRevivalPrepareListModel.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.model.V1a6_CachotRoleRevivalPrepareListModel", package.seeall)

local V1a6_CachotRoleRevivalPrepareListModel = class("V1a6_CachotRoleRevivalPrepareListModel", ListScrollModel)

function V1a6_CachotRoleRevivalPrepareListModel:onInit()
	return
end

function V1a6_CachotRoleRevivalPrepareListModel:reInit()
	self:onInit()
end

function V1a6_CachotRoleRevivalPrepareListModel:initList()
	local list = {}
	local teamInfo = V1a6_CachotModel.instance:getTeamInfo()

	for i, v in ipairs(teamInfo.lifes) do
		if v.life <= 0 then
			local heroMO = HeroModel.instance:getByHeroId(v.heroId)
			local mo = HeroSingleGroupMO.New()

			mo.heroUid = heroMO.uid

			table.insert(list, mo)
		end
	end

	self:setList(list)
end

V1a6_CachotRoleRevivalPrepareListModel.instance = V1a6_CachotRoleRevivalPrepareListModel.New()

return V1a6_CachotRoleRevivalPrepareListModel
