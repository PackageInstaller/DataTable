-- chunkname: @modules/logic/fight/system/work/FightWorkCorrectData.lua

module("modules.logic.fight.system.work.FightWorkCorrectData", package.seeall)

local FightWorkCorrectData = class("FightWorkCorrectData", BaseWork)

function FightWorkCorrectData:onStart(context)
	local curRound = FightDataHelper.roundMgr:getRoundData()
	local dataList = curRound and curRound.exPointInfo

	if dataList then
		for entityId, data in pairs(dataList) do
			local entityMO = FightDataHelper.entityMgr:getById(entityId)

			if entityMO and data.currentHp and data.currentHp ~= entityMO.currentHp then
				entityMO:setHp(data.currentHp)
				FightController.instance:dispatchEvent(FightEvent.OnCurrentHpChange, entityId)
			end
		end
	end

	self:onDone(true)
end

function FightWorkCorrectData:clearWork()
	return
end

return FightWorkCorrectData
