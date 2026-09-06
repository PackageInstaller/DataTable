-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playmusic/view/symbolcell/CircleSymbolCell.lua

module("logic.extensions.playmusic.view.symbolcell.CircleSymbolCell", package.seeall)

local CircleSymbolCell = class("CircleSymbolCell", MusicSymbolCellBase)

CircleSymbolCell.State = {
	Standing = 1,
	Ending = 5,
	Ended = 6,
	Stoping = 4,
	Hitting = 3,
	Readying = 2
}

function CircleSymbolCell:ctor(entityId)
	CircleSymbolCell.super.ctor(self, entityId)
end

function CircleSymbolCell:init(mainGo, symbolId)
	CircleSymbolCell.super.init(self, mainGo, symbolId)

	self._totalDeltaTime = 5
	self._imgBaseCircle = goutil.findChild(self._mainGo, "imgBaseCircle")
	self._imgDecideCircle = goutil.findChild(self._mainGo, "imgDecideCircle")
	self._btnHit = goutil.findChild(self._mainGo, "btnHit")
	self._btnHitRect = self._btnHit:GetComponent(goutil.Type_RectTransform).rect

	GameUtil.addClickHandler(self._btnHit, self._onHit, self)

	self._deltaTime = 0
	self._isOver = false
	self._isEnable = true
	self._animSpeed = 1
	self._originalScale = GameUtil.getLocalScale(self._imgDecideCircle)
	self._curScaleX = self._originalScale.x

	self:_changeState(self.State.Readying)
end

function CircleSymbolCell:reset()
	self:_changeState(self.State.Standing)
	GameUtil.SetActive(self._mainGo, false)

	if self._originalScale then
		GameUtil.setLocalScale(self._imgDecideCircle, self._originalScale.x, self._originalScale.y, self._originalScale.z)

		self._originalScale = nil
	end

	self._deltaTime = 0
	self._isOver = false
	self._isEnable = true
	self._animSpeed = 1
	self._curHitDeltaTime = 0

	GameUtil.rmClickHandler(self._btnHit)

	self._imgBaseCircle = nil
	self._imgDecideCircle = nil
	self._btnHit = nil
	self._btnHitRect = nil

	CircleSymbolCell.super.reset(self)
end

function CircleSymbolCell:dispose()
	CircleSymbolCell.super.dispose(self)
end

function CircleSymbolCell:onTicking(deltaTime)
	CircleSymbolCell.super.onTicking(self, deltaTime)

	if self._isEnable == false then
		return
	end

	self._deltaTime = deltaTime

	if self._state == self.State.Standing then
		-- block empty
	elseif self._state == self.State.Readying then
		self:_changeState(self.State.Hitting)
	elseif self._state == self.State.Hitting then
		self._curHitDeltaTime = self._curHitDeltaTime + self._deltaTime * self._animSpeed
		self._curHitTimeRatio = Mathf.Floor(self._curHitDeltaTime / self._totalDeltaTime * 100)
		self._curHitTimeRatio = Mathf.Clamp(self._curHitTimeRatio, 0, 100)

		self:_updateShrinkAnim()

		if self._curHitTimeRatio >= 100 then
			self._isOver = true

			self:_changeState(self.State.Ending)
		end
	elseif self._state == self.State.Stoping then
		-- block empty
	elseif self._state == self.State.Ending then
		self:_changeState(self.State.Ended)
	elseif self._state == self.State.Ended then
		-- block empty
	end
end

function CircleSymbolCell:setAnimSpeed(speed)
	self._animSpeed = speed
end

function CircleSymbolCell:getCurState()
	return self._state
end

function CircleSymbolCell:getHitRect()
	return self._btnHitRect
end

function CircleSymbolCell:setEnable(isSetEnable)
	self._isEnable = isSetEnable
end

function CircleSymbolCell:isEnable()
	return self._isEnable
end

function CircleSymbolCell:isOver()
	return self._isOver
end

function CircleSymbolCell:_changeState(state)
	self._state = state
end

function CircleSymbolCell:_onHit()
	if self._state ~= self.State.Hitting or self._isEnable == false then
		return
	end

	self._isHit = true

	self:_changeState(self.State.Ending)
end

function CircleSymbolCell:_updateShrinkAnim()
	self._curScaleX = (self._originalScale.x - 1) * (100 - self:getCurHitTimeRatio()) / 100 + 1

	GameUtil.setLocalScale(self._imgDecideCircle, self._curScaleX)
end

return CircleSymbolCell
