-- chunkname: @modules/logic/guide/controller/action/impl/WaitGuideActionSurvivalBuildingLv.lua

module("modules.logic.guide.controller.action.impl.WaitGuideActionSurvivalBuildingLv", package.seeall)

local WaitGuideActionSurvivalBuildingLv = class("WaitGuideActionSurvivalBuildingLv", BaseGuideAction)

function WaitGuideActionSurvivalBuildingLv:onStart(context)
	local param = string.splitToNumber(self.actionParam, "#")

	self.buildingType = param[1]
	self.buildingLv = param[2] or 0

	if self:checkDone() then
		return
	end

	SurvivalController.instance:registerCallback(SurvivalEvent.OnBuildingInfoUpdate, self.onBuildingInfoUpdate, self)
end

function WaitGuideActionSurvivalBuildingLv:checkDone()
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

	if not weekInfo then
		return
	end

	local isDone = weekInfo:checkBuildingTypeLev(self.buildingType, self.buildingLv)

	if isDone then
		self:onDone(true)

		return true
	end

	return false
end

function WaitGuideActionSurvivalBuildingLv:onBuildingInfoUpdate()
	self:checkDone()
end

function WaitGuideActionSurvivalBuildingLv:clearWork()
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnBuildingInfoUpdate, self.onBuildingInfoUpdate, self)
end

return WaitGuideActionSurvivalBuildingLv
