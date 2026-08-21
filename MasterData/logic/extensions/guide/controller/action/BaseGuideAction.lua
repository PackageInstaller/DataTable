-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/controller/action/BaseGuideAction.lua

module("logic.extensions.guide.controller.action.BaseGuideAction", package.seeall)

local BaseGuideAction = class("BaseGuideAction", WorkBase)

function BaseGuideAction:ctor(guideId, stepId, guideStepCO)
	self.guideId = guideId
	self.stepId = stepId
	self.guideStepCO = guideStepCO

	BaseGuideAction.super.ctor(self)
end

function BaseGuideAction:onEnter(context)
	printInfo(string.format("<color=#EA00B3>start guide_%d_%d %s</color>", self.guideId, self.stepId, self.__cname))
end

function BaseGuideAction:onExit()
	printInfo(string.format("<color=#EA00B3>destroy guide_%d_%d %s</color>", self.guideId, self.stepId, self.__cname))

	if self.guideStepCO.isGotoMainUI == 1 then
		local curSceneType = SceneMgr.instance:getCurSceneType()

		if curSceneType == SceneType.Dungeon then
			SceneMgr.instance:exitCurScene()
			VirtualCameraMgr.instance:clearFollowConfiner()
			SceneFace.instance:enterRoomScene()
		elseif curSceneType == SceneType.Retrieve then
			SceneFace.instance:exitScene()
			SceneFace.instance:clearEnterSceneInfo()
			SceneMgr.instance:exitCurScene()
			SceneFace.instance:enterRoomScene()
		else
			ViewMgr.instance:jumpToMainView(ViewName.MainUIView)
		end
	end
end

return BaseGuideAction
