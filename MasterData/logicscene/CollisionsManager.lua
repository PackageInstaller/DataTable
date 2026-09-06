-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/component/battle/CollisionsManager.lua

module("logicscene.scene.component.battle.CollisionsManager", package.seeall)

local CollisionsManager = class("CollisionsManager", SceneComponentBase)

function CollisionsManager:onEnterSceneFinished(sceneId, bornX, bornZ)
	self._collisions = {}
end

function CollisionsManager:onExitScene()
	if self._collisions then
		local cnt = #self._collisions

		for i = 1, cnt do
			self._collisions[i]:clear()
		end

		self._collisions = nil
	end
end

function CollisionsManager:add(collision)
	table.insert(self._collisions, collision)
end

function CollisionsManager:isEmpty()
	return not self._collisions or #self._collisions == 0
end

function CollisionsManager:clearAll()
	if self._collisions then
		for _, v in ipairs(self._collisions) do
			v:clear()
		end

		self._collisions = {}
	end
end

function CollisionsManager:update(deltaTime)
	if not self._collisions then
		return
	end

	local cnt = #self._collisions
	local i = 1

	while i <= cnt do
		self._collisions[i]:update(deltaTime)

		if self._collisions[i]:isDone() then
			self._collisions[i]:clear()
			table.remove(self._collisions, i)

			cnt = cnt - 1
		else
			i = i + 1
		end
	end
end

return CollisionsManager
