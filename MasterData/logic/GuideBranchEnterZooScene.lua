-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/model/branch/GuideBranchEnterZooScene.lua

module("logic.extensions.guide.model.branch.GuideBranchEnterZooScene", package.seeall)

local GuideBranchEnterZooScene = class("GuideBranchEnterZooScene")
local GuideBranchEnterZooScene = class("GuideBranchEnterZooScene", GuideBranchFunOpen)

function GuideBranchEnterZooScene:startGuide()
	GuideBranchEnterZooScene.super.startGuide(self)
end

function GuideBranchEnterZooScene:checkFuncOpen(param)
	GuideBranchEnterZooScene.super.checkFuncOpen(self, param)

	if param and param.runPath then
		local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

		if mainPlayer then
			mainPlayer:runPath(param.runPath[1], param.runPath[2], function()
				GuideController.instance:finishGuide()
			end)
		end
	end
end

function GuideBranchEnterZooScene:forceToInScene(sceneId, sceneType)
	if sceneType == SceneType.PetZoo and ZooSceneController.instance:isMyZoo() and self._currGuide then
		local guideId = self._currGuide:getGuideId()

		if guideId ~= 1 then
			return 1
		end
	end
end

return GuideBranchEnterZooScene
