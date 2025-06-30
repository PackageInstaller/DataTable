-- chunkname: @IQIGame\\Module\\FurnitureLottery\\FurnitureLotteryModule.lua

FurnitureLotteryModule = {}

local FurnitureLotteryData = require("IQIGame.Module.FurnitureLottery.FurnitureLotteryData")
local DecorateIllustrationsData = require("IQIGame.Module.FurnitureLottery.DecorateIllustrationsData")

function FurnitureLotteryModule.Reload(activationDecorates)
	FurnitureLotteryModule.decorateIllustrationDic = {}

	for i, v in pairsCfg(CfgHomeLandDecorateTable) do
		local activation = table.indexOf(activationDecorates, v.Item) ~= -1
		local IllustrationsData = DecorateIllustrationsData.New(v.Id, activation)

		FurnitureLotteryModule.decorateIllustrationDic[IllustrationsData.cfgItemID] = IllustrationsData
	end
end

function FurnitureLotteryModule.ReloadLottery(decorateLottery)
	FurnitureLotteryModule.decorateLotteryDic = {}

	for i, v in pairsCfg(CfgLotteryShowTable) do
		if v.LotteryType == Constant.LotteryType.Lottery_furniture then
			local lotteryPod = FurnitureLotteryModule.GetLotteryPoD(v.Id, decorateLottery)

			if lotteryPod ~= nil and lotteryPod.open == true then
				local lotteryData = FurnitureLotteryData.New(lotteryPod.showCid, lotteryPod.open, lotteryPod.endDateTime)

				table.insert(FurnitureLotteryModule.decorateLotteryDic, lotteryData)
			end
		end
	end
end

function FurnitureLotteryModule.GetLotteryPoD(showCid, decorateLottery)
	for i, v in pairs(decorateLottery) do
		if v.showCid == showCid then
			return v
		end
	end

	return nil
end

function FurnitureLotteryModule.GetDecorateIllustrationByTheme(themeID)
	local tab = {}

	for i, v in pairs(FurnitureLotteryModule.decorateIllustrationDic) do
		if v.cfgInfo.ThemeID == themeID then
			table.insert(tab, v)
		end
	end

	return tab
end

function FurnitureLotteryModule.LotteryDecorates(showId, lotteryCid)
	net_lottery.lottery(showId, lotteryCid, {})
end

function FurnitureLotteryModule.NotifyActivationDecorates(activationDecorates)
	if FurnitureLotteryModule.decorateIllustrationDic then
		for i, v in pairs(activationDecorates) do
			FurnitureLotteryModule.decorateIllustrationDic[v].activation = true
		end

		EventDispatcher.Dispatch(EventID.UpdateActivationDecorates)
	end
end

function FurnitureLotteryModule.NotifyLottetys(decorateLottery)
	FurnitureLotteryModule.ReloadLottery(decorateLottery)
	EventDispatcher.Dispatch(EventID.UpdateDecorateLottery)
end
