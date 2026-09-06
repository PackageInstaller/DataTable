-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/tiling/SceneStatus.lua

module("logicscene.scene.tiling.SceneStatus", package.seeall)

local SceneStatus = class("SceneStatus")

function SceneStatus:ctor()
	return
end

function SceneStatus:saveStatus(curScene)
	if curScene then
		self.originSceneType = curScene:getSceneType()
		self.originSceneId = curScene:getSceneId()

		if curScene.bgm then
			self.originSceneBgm = curScene.bgm:getBgmId()
		end
	end

	if SceneMainPlayer.instance then
		local mainPlayer = SceneMainPlayer.instance:getMainPlayer()

		if mainPlayer then
			self.playerBirdgeState = mainPlayer:isUnderBridge()

			local x, y = mainPlayer.transform:getPos()

			self.posX = x
			self.posY = y
		end
	end
end

return SceneStatus
