-- chunkname: @modules/logic/sp01/odyssey/controller/OdysseyStatHelper.lua

module("modules.logic.sp01.odyssey.controller.OdysseyStatHelper", package.seeall)

local OdysseyStatHelper = class("OdysseyStatHelper")

function OdysseyStatHelper:ctor()
	self.sceneStartTime = 0
	self.dungeonStartTime = 0
	self.viewStartTime = 0
end

function OdysseyStatHelper:initSceneStartTime()
	self.sceneStartTime = UnityEngine.Time.realtimeSinceStartup
end

function OdysseyStatHelper:initViewStartTime()
	self.viewStartTime = UnityEngine.Time.realtimeSinceStartup
end

function OdysseyStatHelper:initDungeonStartTime()
	self.dungeonStartTime = UnityEngine.Time.realtimeSinceStartup
end

function OdysseyStatHelper:sendOdysseyDungeonViewClickBtn(btnInfo)
	StatController.instance:track(StatEnum.EventName.S01OdysseyDungeonBtnClick, {
		[StatEnum.EventProperties.Odyssey_MapId] = tostring(OdysseyDungeonModel.instance:getCurMapId()),
		[StatEnum.EventProperties.Odyssey_ButtonName] = btnInfo,
		[StatEnum.EventProperties.Odyssey_InterfaceName] = "OdysseyDungeonView"
	})
end

function OdysseyStatHelper:sendOdysseyDungeonViewClose(closeMapId, operationType)
	StatController.instance:track(StatEnum.EventName.S01OdysseyDungeonViewClose, {
		[StatEnum.EventProperties.Odyssey_InterfaceName] = "OdysseyDungeonSceneView",
		[StatEnum.EventProperties.Odyssey_MapId] = tostring(closeMapId),
		[StatEnum.EventProperties.Odyssey_OperationType] = operationType,
		[StatEnum.EventProperties.Odyssey_Usetime] = UnityEngine.Time.realtimeSinceStartup - self.sceneStartTime
	})
end

function OdysseyStatHelper:sendOdysseyViewStayTime(viewName, libraryId)
	local isDungeonRootView = viewName == "OdysseyDungeonView"
	local var_7_0 = {
		[StatEnum.EventProperties.Odyssey_InterfaceName] = viewName,
		[StatEnum.EventProperties.Odyssey_ActAssassinLibraryId] = libraryId and libraryId or 0
	}

	var_7_0[StatEnum.EventProperties.Odyssey_Usetime] = UnityEngine.Time.realtimeSinceStartup - ((isDungeonRootView or nil) and (self.dungeonStartTime or self.viewStartTime))

	StatController.instance:track(StatEnum.EventName.S01OdysseyViewStayTime, var_7_0)
end

function OdysseyStatHelper:sendLibraryDialogueClick(btnInfo)
	StatController.instance:track(StatEnum.EventName.S01LibraryDetailViewClick, {
		[StatEnum.EventProperties.Odyssey_InterfaceName] = "AssassinLibraryDetailView",
		[StatEnum.EventProperties.Odyssey_ButtonName] = btnInfo
	})
end

OdysseyStatHelper.instance = OdysseyStatHelper.New()

return OdysseyStatHelper
