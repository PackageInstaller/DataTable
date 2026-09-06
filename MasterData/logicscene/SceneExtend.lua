-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/SceneExtend.lua

module("logicscene.scene.SceneExtend", package.seeall)

local SceneExtend = {}

function SceneExtend.extend()
	return
end

function SceneBase:onExit()
	self._isExiting = true

	local len = #self._compList
	local tempComp

	for i = 1, len do
		if self._compList[i].onExitScene then
			self._compList[i]:onExitScene()
		end
	end
end

function SceneBase:onExitFinished()
	local len = #self._compList
	local tempComp

	for i = 1, len do
		if self._compList[i].onExitSceneFinished then
			self._compList[i]:onExitSceneFinished()
		end
	end

	self._isExiting = false
end

function SceneBase:lateEnterFinished()
	local len = #self._compList
	local tempComp

	for i = 1, len do
		if self._compList[i].lateEnterFinished then
			self._compList[i]:lateEnterFinished()
		end
	end
end

return SceneExtend
