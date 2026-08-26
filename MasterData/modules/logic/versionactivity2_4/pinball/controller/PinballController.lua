-- chunkname: @modules/logic/versionactivity2_4/pinball/controller/PinballController.lua

module("modules.logic.versionactivity2_4.pinball.controller.PinballController", package.seeall)

local PinballController = class("PinballController", BaseController)

function PinballController:addConstEvents()
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, self._getInfo, self)
	self.registerCallback(self, PinballEvent.GuideAddRes, self._guideAddRes, self)
end

function PinballController:_getInfo(activityId)
	if activityId and activityId ~= VersionActivity2_4Enum.ActivityId.Pinball then
		return
	end
end

function PinballController:openMainView()
	ViewMgr.instance:openView(ViewName.PinballCityView)
end

function PinballController:sendGuideMainLv()
	self:dispatchEvent(PinballEvent.GuideMainLv, PinballController._checkMainLv)
end

function PinballController._checkMainLv(param)
	local needLv = tonumber(param)

	if not needLv then
		return
	end

	local lv = PinballModel.instance:getScoreLevel()

	return needLv <= lv
end

function PinballController:_guideAddRes()
	Activity178Rpc.instance:sendAct178GuideAddGrain(VersionActivity2_4Enum.ActivityId.Pinball)
end

function PinballController:removeBuilding(index)
	local buildingInfo = PinballModel.instance:getBuildingInfo(index)

	if not buildingInfo then
		return
	end

	local costDict = {}

	GameUtil.setDefaultValue(costDict, 0)

	for i = 1, buildingInfo.level do
		local buildCo = lua_activity178_building.configDict[VersionActivity2_4Enum.ActivityId.Pinball][buildingInfo.configId][i]

		if buildCo and not string.nilorempty(buildCo.cost) then
			local dict = GameUtil.splitString2(buildCo.cost, true)

			for _, arr in pairs(dict) do
				costDict[arr[1]] = costDict[arr[1]] + arr[2]
			end
		end
	end

	local costArr = {}

	for type, num in pairs(costDict) do
		local resCo = lua_activity178_resource.configDict[VersionActivity2_4Enum.ActivityId.Pinball][type]

		if resCo then
			table.insert(costArr, string.format("%s+%s", resCo.name, num))
		end
	end

	self._tempIndex = index

	GameFacade.showMessageBox(MessageBoxIdDefine.PinballRemoveBuilding, MsgBoxEnum.BoxType.Yes_No, self._realRemoveBuilding, nil, nil, self, nil, nil, table.concat(costArr, " "))
end

function PinballController:_realRemoveBuilding()
	local buildingInfo = PinballModel.instance:getBuildingInfo(self._tempIndex)

	if not buildingInfo then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.Act178.act178_audio5)
	Activity178Rpc.instance:sendAct178Build(VersionActivity2_4Enum.ActivityId.Pinball, buildingInfo.configId, PinballEnum.BuildingOperType.Remove, self._tempIndex)
end

PinballController.instance = PinballController.New()

return PinballController
