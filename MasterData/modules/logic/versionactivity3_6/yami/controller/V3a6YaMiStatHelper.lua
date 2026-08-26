-- chunkname: @modules/logic/versionactivity3_6/yami/controller/V3a6YaMiStatHelper.lua

module("modules.logic.versionactivity3_6.yami.controller.V3a6YaMiStatHelper", package.seeall)

local V3a6YaMiStatHelper = class("V3a6YaMiStatHelper")

function V3a6YaMiStatHelper:ctor()
	self.enterViewTime = nil
end

function V3a6YaMiStatHelper:InitEnterYaMiMainViewTime()
	self.enterViewTime = UnityEngine.Time.realtimeSinceStartup
end

function V3a6YaMiStatHelper:StartResearch()
	local materialIds = V3a6YaMiStatHelper:getMaterialIds()
	local researcherIds = V3a6YaMiModel.instance:getSelectHeros()
	local currency = V3a6YaMiModel.instance:getCurrencyNum()
	local _, level, _ = V3a6YaMiModel.instance:getLevelExp()

	StatController.instance:track(StatEnum.EventName.YaMiGame, {
		[StatEnum.EventProperties.OperationType] = "开始研究",
		[StatEnum.EventProperties.MaterialCost] = materialIds,
		[StatEnum.EventProperties.HeroList] = researcherIds,
		[StatEnum.EventProperties.Bakaluoer_activity_points] = currency,
		[StatEnum.EventProperties.FieldLevel] = level
	})
end

function V3a6YaMiStatHelper:FinishResearch()
	local productionId, rating = V3a6YaMiStatHelper:getProductIdAndRating()
	local materialIds = V3a6YaMiStatHelper:getMaterialIds()
	local researcherIds = V3a6YaMiModel.instance:getSelectHeros()
	local currency = V3a6YaMiModel.instance:getCurrencyNum()
	local _, level, _ = V3a6YaMiModel.instance:getLevelExp()

	StatController.instance:track(StatEnum.EventName.YaMiGame, {
		[StatEnum.EventProperties.OperationType] = "完成研究",
		[StatEnum.EventProperties.MaterialCost] = materialIds,
		[StatEnum.EventProperties.HeroList] = researcherIds,
		[StatEnum.EventProperties.Bakaluoer_activity_points] = currency,
		[StatEnum.EventProperties.FieldLevel] = level,
		[StatEnum.EventProperties.CollectionId] = productionId,
		[StatEnum.EventProperties.Score] = rating
	})
end

function V3a6YaMiStatHelper:ExitYaMiMainView()
	local currency = V3a6YaMiModel.instance:getCurrencyNum()
	local _, level, _ = V3a6YaMiModel.instance:getLevelExp()

	StatController.instance:track(StatEnum.EventName.YaMiGame, {
		[StatEnum.EventProperties.OperationType] = "离开场景",
		[StatEnum.EventProperties.Bakaluoer_activity_points] = currency,
		[StatEnum.EventProperties.FieldLevel] = level,
		[StatEnum.EventProperties.UseTime] = (self.enterViewTime or nil) and UnityEngine.Time.realtimeSinceStartup - self.enterViewTime
	})
end

function V3a6YaMiStatHelper:getMaterialIds()
	local materialIds = {}
	local subType, materials = V3a6YaMiModel.instance:getSelectMaterials()

	if materials then
		for _, id in pairs(materials) do
			table.insert(materialIds, id)
		end
	end

	if subType then
		table.insert(materialIds, subType)
	end

	return materialIds
end

function V3a6YaMiStatHelper:getProductIdAndRating()
	local productId = 0
	local rating = 0
	local productMo = V3a6YaMiModel.instance:getSelfProductMo()

	if productMo then
		productId = productMo.id
		rating = productMo.rating
	end

	return productId, rating
end

V3a6YaMiStatHelper.instance = V3a6YaMiStatHelper.New()

return V3a6YaMiStatHelper
