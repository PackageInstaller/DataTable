-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/orimatgame/model/buff/OriMatGameDotBuff.lua

module("logic.extensions.orimatgame.model.buff.OriMatGameDotBuff", package.seeall)

local OriMatGameDotBuff = class("OriMatGameDotBuff", OriMatGameBuffBase)

function OriMatGameDotBuff:initComplete()
	OriMatGameDotBuff.super.initComplete(self)

	self._totalLifeTime = checknumber(self._tiggerParam[self:gPId()])
	self._curTimeInterval = checknumber(self._tiggerParam[self:gPId()])
	self._isExistInterval = self._curTimeInterval > 0
	self._lifeTimer = 0
	self._elapsedTime = 0
end

function OriMatGameDotBuff:onUpdate(dt)
	if self._lifeTimer < self:getMaxLifeTime() then
		self._lifeTimer = self._lifeTimer + dt

		if self._isExistInterval then
			self._elapsedTime = self._elapsedTime + dt

			if self._elapsedTime >= self._curTimeInterval then
				self._elapsedTime = self._elapsedTime - self._curTimeInterval

				self:onBuffTrigger()
			end
		end
	else
		self._unit:removeBuff(self)
	end
end

function OriMatGameDotBuff:onBuffTrigger()
	return
end

function OriMatGameDotBuff:getMaxLifeTime()
	return checknumber(self._totalLifeTime)
end

return OriMatGameDotBuff
