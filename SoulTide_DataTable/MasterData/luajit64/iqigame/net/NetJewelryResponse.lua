-- chunkname: @IQIGame\\Net\\NetJewelryResponse.lua

function net_jewelry.wearResult(code, soulCid, cid, speed)
	JewelryModule.WearResult(soulCid, cid, speed)
end

function net_jewelry.unwearResult(code, soulCid)
	JewelryModule.UnWearResult(soulCid)
end

function net_jewelry.upStarResult(code, soulCid, newId)
	JewelryModule.UpStarResult(soulCid, newId)
end

function net_jewelry.upStarInBagResult(code, cid)
	JewelryModule.UpStarInBagResult(cid)
end

function net_jewelry.setSpeedResult(code, soulCid, speed)
	JewelryModule.SetSpeedResult(soulCid, speed)
end

function net_jewelry.recycleResult(code, cid, getItems)
	JewelryModule.RecycleResult(cid, getItems)
end

function net_jewelry.newWearResult(code)
	JewelryModule.NewWearResult()
end

function net_jewelry.newUnWearResult(code)
	JewelryModule.NewUnWearResult()
end

function net_jewelry.setJewelrySpeedResult(code)
	JewelryModule.SetJewelrySpeedResult()
end

function net_jewelry.newUpStarResult(code)
	JewelryModule.NewUpStarResult()
end

function net_jewelry.newRecycleResult(code, getItems)
	JewelryModule.NewRecycleResult(getItems)
end
