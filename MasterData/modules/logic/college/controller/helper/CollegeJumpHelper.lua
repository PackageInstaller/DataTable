-- chunkname: @modules/logic/college/controller/helper/CollegeJumpHelper.lua

module("modules.logic.college.controller.helper.CollegeJumpHelper", package.seeall)

local CollegeJumpHelper = class("CollegeJumpHelper")

function CollegeJumpHelper:jumpTo(str)
	if string.nilorempty(str) then
		return
	end

	local arr = string.split(str, "#")
	local func = self["jump_" .. arr[1]]

	if func then
		local param = {}

		for i = 2, #arr do
			param[i - 1] = tonumber(arr[i]) or arr[i]
		end

		return func(self, unpack(param))
	end
end

function CollegeJumpHelper:jump_Building(buildingId, toastId)
	local sceneMo = CollegeModel.instance:getSceneMo()
	local buildingMO = sceneMo.buildingBox:getBuildingMo(buildingId) or sceneMo.worldMap:getAreaMo(buildingId)

	if not buildingMO or not buildingMO.unlock then
		if toastId and toastId > 0 then
			GameFacade.showToast(toastId)
		else
			logError("无法跳转且未配置飘字ID")
		end

		return true
	end

	self._toBuildingMo = buildingMO

	CollegeController.instance:dispatchEvent(CollegeEvent.ChangeSceneType, buildingMO.type, self._onSwitchScene, self)
end

function CollegeJumpHelper:_onSwitchScene()
	if not self._toBuildingMo then
		return
	end

	CollegeHelper.instance:focusTo(self._toBuildingMo, self.finishCallback, self)
end

function CollegeJumpHelper:finishCallback()
	if self._toBuildingMo.type == CollegeEnum.SceneType.Map then
		ViewMgr.instance:openView(ViewName.CollegeAreaView, {
			data = self._toBuildingMo
		})
	else
		ViewMgr.instance:openView(ViewName.CollegeBuildingView, {
			data = self._toBuildingMo
		})
	end

	self._toBuildingMo = nil
end

function CollegeJumpHelper:jump_Scene(sceneType, toastId)
	if sceneType == CollegeEnum.SceneType.Map then
		local sceneMo = CollegeModel.instance:getSceneMo()

		if not sceneMo.worldMap.isUnlock then
			if toastId and toastId > 0 then
				GameFacade.showToast(toastId)
			else
				logError("无法跳转且未配置飘字ID")
			end

			return true
		end
	end

	CollegeController.instance:dispatchEvent(CollegeEvent.ChangeSceneType, sceneType)
end

function CollegeJumpHelper:jump_OpenView(viewName)
	ViewMgr.instance:openView(viewName)
end

CollegeJumpHelper.instance = CollegeJumpHelper.New()

return CollegeJumpHelper
