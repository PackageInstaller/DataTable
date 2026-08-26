-- chunkname: @modules/logic/versionactivity3_7/travelgo/model/TravelGoLuckEventMO.lua

module("modules.logic.versionactivity3_7.travelgo.model.TravelGoLuckEventMO", package.seeall)

local TravelGoLuckEventMO = pureTable("TravelGoLuckEventMO", TravelGoEventMO)

function TravelGoLuckEventMO:onSetData()
	if not string.nilorempty(self.cfg.typeParam) then
		local luckInfoList = GameUtil.splitString2(self.cfg.typeParam, false, "|", ":")
		local weights = {}

		for i, info in ipairs(luckInfoList) do
			local weight = tonumber(info[1])

			table.insert(weights, weight)
		end

		local index = TravelGoController.instance:randomByWeight(weights)

		self.luckEventType = index
		self.luckEventDesc = luckInfoList[index][2]
	end
end

function TravelGoLuckEventMO:getLuckDescList()
	return string.split(self.luckEventDesc, "#")
end

function TravelGoLuckEventMO:getResultRewardStr()
	if self.luckEventType == TravelGoEnum.LuckEventType.UnLuck then
		return self.cfg.result1reward
	elseif self.luckEventType == TravelGoEnum.LuckEventType.LittleLuck then
		return self.cfg.result2reward
	elseif self.luckEventType == TravelGoEnum.LuckEventType.VeryLuck then
		return self.cfg.result3reward
	end
end

return TravelGoLuckEventMO
