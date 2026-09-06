-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/pathfinder/ScenePathFinderEx.lua

module("logicscene.scene.component.pathfinder.ScenePathFinderEx", package.seeall)

local ScenePathFinderEx = class("ScenePathFinderEx", SceneComponentBase)

function ScenePathFinderEx:ctor()
	ScenePathFinderEx.super.ctor(self)
end

function ScenePathFinderEx:getPath(unit, startX, startY, endX, endY, state)
	if not self._wholeScene then
		return {}
	end

	local paths = self._wholeScene:GetPath(unit, startX, startY, endX, endY, state or -1)
	local len = 0

	if paths then
		len = paths.Length
	end

	if len == 0 then
		return
	end

	local fullPaths = {}

	len = len - 1

	for i = 0, len do
		local x, y = paths:GetPathPoint(i, nil, nil)
		local startIdx = i * 2 + 1

		fullPaths[startIdx] = x
		fullPaths[startIdx + 1] = y
	end

	paths:Clear()

	return fullPaths
end

function ScenePathFinderEx:calculatePathLen(sx, sy, path)
	if not path then
		return 0
	end

	local dist = 0
	local preX = sx
	local preY = sy

	for i = 1, #path, 2 do
		local x = path[i]
		local y = path[i + 1]

		dist = dist + GameUtil.distance(preX, preY, 0, x, y, 0)
		preX = x
		preY = y
	end

	return dist
end

function ScenePathFinderEx:onEnterSceneFinished(sceneId, bornX, bornZ)
	self._wholeScene = SceneMgr.instance:getCurScene().stage.wholeScene
end

return ScenePathFinderEx
