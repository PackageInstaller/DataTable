-- chunkname: @modules/logic/summonsimulationpick/model/SummonSimulationInfoMo.lua

module("modules.logic.summonsimulationpick.model.SummonSimulationInfoMo", package.seeall)

local SummonSimulationInfoMo = pureTable("SummonSimulationInfoMo")

function SummonSimulationInfoMo:ctor()
	self.activityId = 0
	self.leftTimes = 0
	self.saveHeroIds = {}
	self.isSelect = false
	self.selectIndex = nil
end

function SummonSimulationInfoMo:update(info, saveCurrent)
	self.activityId = info.activityId
	self.leftTimes = info.leftTimes

	tabletool.clear(self.saveHeroIds)

	if info.savedHeroIds and #info.savedHeroIds > 0 then
		for _, heroInfo in ipairs(info.savedHeroIds) do
			local result = tabletool.copy(heroInfo.heroId)

			SummonModel.sortResultByHeroIds(result)
			table.insert(self.saveHeroIds, result)
		end
	end

	self.maxCount = SummonSimulationPickModel.instance:getActivityMaxSummonCount(self.activityId)
	self.isSelect = info.selectIndex ~= nil and info.selectIndex ~= 0
	self.selectIndex = info.selectIndex
end

return SummonSimulationInfoMo
