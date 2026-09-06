-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragondishitian/controller/DragonDishitianController.lua

module("logic.extensions.dragondishitian.controller.DragonDishitianController", package.seeall)

local DragonDishitianController = class("DragonDishitianController", BaseController)

DragonDishitianController.StarMapPath = "ui/views/dragondishitian/starmap.prefab"
DragonDishitianController.ChildStarMapPath = "ui/views/dragondishitian/childstarmap.prefab"

function DragonDishitianController:ctor()
	return
end

function DragonDishitianController:onInit()
	GlobalDispatcher:addListener(GlobalNotify.Notify_DragonDishitianChallengeRes, self._onNotify_DragonDishitianChallengeRes, self)
end

function DragonDishitianController:onReset()
	return
end

function DragonDishitianController:_onNotify_DragonDishitianChallengeRes(activityId, chapterId, stageId)
	return
end

function DragonDishitianController:openMissionView(activityId, chapterId, stageId)
	local customFmtMo = DragonDishitianModel.instance:getCustomFmtMo(activityId)

	customFmtMo:initParams(activityId, chapterId, stageId)
	CustomFmtController.instance:showMissionView(customFmtMo)
end

function DragonDishitianController:getConditionIdbyStarId(activityId, chapterId, starId)
	local cfgStages = DragonDishitianConfig.instance:getStageCfgList(activityId, chapterId)

	for index1, v1 in ipairs(cfgStages) do
		for index2, v2 in ipairs(v1.starIds) do
			for index3, id in ipairs(v2) do
				if id == starId then
					return v1.stageId, v1.conditionIds[index2]
				end
			end
		end
	end

	return 0, 0
end

DragonDishitianController.instance = DragonDishitianController.New()

return DragonDishitianController
