-- chunkname: @modules/logic/summon/controller/SummonLuckyBagController.lua

module("modules.logic.summon.controller.SummonLuckyBagController", package.seeall)

local SummonLuckyBagController = class("SummonLuckyBagController", BaseController)

function SummonLuckyBagController:skipOpenGetChar(heroId, duplicateCount, poolId)
	if not poolId then
		return
	end

	local poolCo = SummonConfig.instance:getSummonPool(poolId)
	local param = {}

	param.heroId = heroId
	param.duplicateCount = duplicateCount
	param.isSummon = true
	param.skipVideo = true

	local mvSkinId = SummonController.instance:getMvSkinIdByHeroId(heroId)

	if mvSkinId then
		param.mvSkinId = mvSkinId
	end

	if poolCo and poolCo.ticketId ~= 0 then
		param.summonTicketId = poolCo.ticketId
	end

	CharacterController.instance:openCharacterGetView(param)
end

function SummonLuckyBagController:skipOpenGetLuckyBag(luckyBagId, poolId)
	if not poolId then
		return
	end

	local luckyBagList = {
		luckyBagId
	}
	local param = {
		luckyBagIdList = luckyBagList,
		poolId = poolId
	}
	local poolCo = SummonConfig.instance:getSummonPool(poolId)

	if poolCo and poolCo.ticketId ~= 0 then
		param.summonTicketId = poolCo.ticketId
	end

	ViewMgr.instance:openView(ViewName.SummonGetLuckyBag, param)
end

SummonLuckyBagController.instance = SummonLuckyBagController.New()

return SummonLuckyBagController
