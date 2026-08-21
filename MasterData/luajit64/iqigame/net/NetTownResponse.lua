-- chunkname: @IQIGame\\Net\\NetTownResponse.lua

function net_town.enterTownResult(code, town)
	TownModule.EnterTownResult(town)
end

function net_town.shoppingResult(code)
	TownModule.ShoppingResult()
end

function net_town.execMainlineResult(code, areaCid, eventCid)
	TownModule.ExecMainlineResult(areaCid, eventCid)
end

function net_town.enterAreaResult(code, areaCid)
	TownModule.EnterAreaResult(areaCid)
end

function net_town.notifyUnlockArea(area)
	TownModule.NotifyUnlockArea(area)
end

function net_town.notifyEvent(ids)
	TownModule.NotifyEvent(ids)
end

function net_town.notifyShoppingFinish(areaCid, itemAwards)
	TownModule.NotifyShoppingFinish(areaCid, itemAwards)
end

function net_town.lookPlateResult(code, type, id)
	TownHandBookModule.LookPlateResult(type, id)
end

function net_town.notifyUnlockPlate(type, id)
	TownHandBookModule.NotifyUnlockPlate(type, id)
end

function net_town.notifyMainlineFinish(itemAwards)
	TownModule.NotifyMainlineFinish(itemAwards)
end

function net_town.selectExchangeTypeResult(code, items, exchange)
	TownModule.ReqSelectExchangeTypeResult(items, exchange)
end

function net_town.selectExchangeEntryResult_delegate(code, getItems, exchange)
	TownModule.ReqSelectExchangeEntryResult(code, getItems, exchange)
end

function net_town.notifyShoppingEventRefresh(ids)
	TownModule.notifyShoppingEventRefresh(ids)
end

function net_town.notifyTownFunctionOpen(townPOD)
	TownModule.NotifyTownFunctionOpen(townPOD)
end
