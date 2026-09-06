-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/action/UnitActionOtherPlayerMove.lua

module("logicscene.scene.unit.action.UnitActionOtherPlayerMove", package.seeall)

local UnitActionOtherPlayerMove = class("UnitActionOtherPlayerMove", UnitActionPathTo)

function UnitActionOtherPlayerMove:reverse()
	return nil
end

function UnitActionOtherPlayerMove:_mergePaths()
	self._paths = self._originsPath
	self._originsPath = nil
end

function UnitActionOtherPlayerMove:_handlePaths()
	if not self._paths then
		self._pathIdx = nil
		self._pathLen = nil
		self._paths = nil
		self._isDone = true
	else
		self._pathLen = #self._paths

		if self._pathLen > 0 then
			if not self._unit:isInFrustum() then
				self._pathIdx = nil

				local cnt = #self._paths

				for i = 1, cnt, 2 do
					if not GameUtil.isInFrustum(self._paths[i], self._paths[i + 1]) then
						self._unit.transform:setPos(self._paths[i], self._paths[i + 1])
					else
						self._pathIdx = i

						break
					end
				end

				if not self._pathIdx then
					self._pathIdx = nil
					self._pathLen = nil
					self._paths = nil
					self._isDone = true
				else
					local dist = self._unit.transform:dist(self._destX, self._destY)

					self._speedMul = dist / 2

					if self._speedMul < 1 then
						self._speedMul = 1
					end
				end
			else
				self._pathIdx = 1
			end
		else
			self._pathIdx = nil
			self._pathLen = nil
			self._paths = nil
			self._isDone = true
		end
	end
end

function UnitActionOtherPlayerMove:_getMoveSpeedRate()
	return 0.8
end

return UnitActionOtherPlayerMove
