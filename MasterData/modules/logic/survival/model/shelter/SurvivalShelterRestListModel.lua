-- chunkname: @modules/logic/survival/model/shelter/SurvivalShelterRestListModel.lua

module("modules.logic.survival.model.shelter.SurvivalShelterRestListModel", package.seeall)

local SurvivalShelterRestListModel = class("SurvivalShelterRestListModel", ListScrollModel)

function SurvivalShelterRestListModel:refreshList(buildingInfo)
	local list = {}

	if buildingInfo then
		local heroCount = buildingInfo:getAttr(SurvivalEnum.AttrType.LoungeRoleNum)
		local dict = {}

		for heroId, pos in pairs(buildingInfo.heros) do
			dict[pos] = heroId
		end

		for i = 1, heroCount do
			local data = {}

			data.pos = i - 1
			data.heroId = dict[data.pos] or 0
			data.buildingId = buildingInfo.id

			table.insert(list, data)
		end

		local nextConfig = SurvivalConfig.instance:getBuildingConfig(buildingInfo.buildingId, buildingInfo.level + 1, true)

		if nextConfig then
			local effect = GameUtil.splitString2(nextConfig.effect)

			for i, v in ipairs(effect) do
				if v[1] == "buildPermAttrAdd" and tonumber(v[2]) == SurvivalEnum.AttrType.LoungeRoleNum then
					for j = 1, tonumber(v[3]) do
						local data = {}

						table.insert(list, data)
					end
				end
			end
		end
	end

	self:setList(list)
end

function SurvivalShelterRestListModel:dropHealthHero(buildingInfo)
	if not buildingInfo then
		return
	end

	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local heroCount = buildingInfo:getAttr(SurvivalEnum.AttrType.LoungeRoleNum)
	local healthMax = weekInfo:getAttr(SurvivalEnum.AttrType.HeroHealthMax)
	local hasMaxHero = false
	local heroIds = {}

	for i = 1, heroCount do
		table.insert(heroIds, 0)
	end

	for heroId, pos in pairs(buildingInfo.heros) do
		local heroMo = weekInfo:getHeroMo(heroId)
		local health = heroMo.health

		if healthMax == health then
			hasMaxHero = true
		else
			heroIds[pos + 1] = heroId
		end
	end

	if not hasMaxHero then
		return
	end

	SurvivalWeekRpc.instance:sendSurvivalBatchHeroChangePositionRequest(heroIds, buildingInfo.id)
end

SurvivalShelterRestListModel.instance = SurvivalShelterRestListModel.New()

return SurvivalShelterRestListModel
