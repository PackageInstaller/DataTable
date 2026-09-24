-- chunkname: @modules/logic/autochess/main/model/rpcmo/AutoChessMallMo.lua

module("modules.logic.autochess.main.model.rpcmo.AutoChessMallMo", package.seeall)

local AutoChessMallMo = pureTable("AutoChessMallMo")

function AutoChessMallMo:init(data)
	self.coin = tonumber(data.coin)
	self.regions = GameUtil.rpcInfosToList(data.regions, AutoChessMallRegionMo)
	self.rewardProgress = data.rewardProgress
	self.freeRefreshCount = data.freeRefreshCount
	self.refreshCost = data.refreshCost
end

function AutoChessMallMo:getNormalRegion()
	for _, region in ipairs(self.regions) do
		if region.config.type == AutoChessEnum.MallType.Normal then
			return region
		end
	end

	logError("找不到普通商店数据")
end

function AutoChessMallMo:getFreeRegion()
	for _, region in ipairs(self.regions) do
		if region.config.type == AutoChessEnum.MallType.Free then
			return region
		end
	end
end

function AutoChessMallMo:updateCoin(value)
	self.coin = tonumber(value)

	AutoChessController.instance:dispatchEvent(AutoChessEvent.MallCoinChange)
end

function AutoChessMallMo:updateSvrMallRegion(data, event)
	local index

	for k, v in ipairs(self.regions) do
		if v.mallId == data.mallId then
			index = k

			break
		end
	end

	if index then
		self.regions[index] = GameUtil.rpcInfoToMo(data, AutoChessMallRegionMo)
	else
		logError("未找到可替换商店数据 ID:" .. data.mallId)
	end

	if event then
		AutoChessController.instance:dispatchEvent(AutoChessEvent.UpdateMallRegion)
	end
end

function AutoChessMallMo:fixLockStatus(mallId, type)
	local isLock = type == AutoChessEnum.FreeZeType.Freeze

	for _, region in ipairs(self.regions) do
		if region.mallId == mallId then
			for _, chessItem in ipairs(region.items) do
				chessItem.freeze = isLock
			end

			break
		end
	end
end

return AutoChessMallMo
