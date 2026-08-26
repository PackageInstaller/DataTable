-- chunkname: @modules/logic/versionactivity3_8/echosong/view/V3a8EchoSongGameHitBallItem.lua

module("modules.logic.versionactivity3_8.echosong.view.V3a8EchoSongGameHitBallItem", package.seeall)

local V3a8EchoSongGameHitBallItem = class("V3a8EchoSongGameHitBallItem")

function V3a8EchoSongGameHitBallItem:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a8EchoSongGameHitBallItem:addEvents()
	return
end

function V3a8EchoSongGameHitBallItem:removeEvents()
	return
end

function V3a8EchoSongGameHitBallItem:_init(go)
	self.viewGO = go

	self:onInitView()
end

function V3a8EchoSongGameHitBallItem:_editableInitView()
	self._meshRenderer = self.viewGO:GetComponent(typeof(UnityEngine.MeshRenderer))
	self._mat = self._meshRenderer.material
	self._matColor = MaterialUtil.GetMainColor(self._mat)
end

function V3a8EchoSongGameHitBallItem:_resetState()
	self._startTime = Time.time
	self._matColor.a = 1
end

function V3a8EchoSongGameHitBallItem:update(deltaTime, needMatUpdate)
	if self._mat and needMatUpdate then
		local time = Time.time - self._startTime

		if time > self._lifeTime then
			self._matColor.a = 0

			MaterialUtil.setMainColor(self._mat, self._matColor)

			return
		end

		self._matColor.a = 1 - time / self._lifeTime

		MaterialUtil.setMainColor(self._mat, self._matColor)
	end
end

function V3a8EchoSongGameHitBallItem:onUpdateMO(lifeTime)
	self:_resetState()

	self._lifeTime = lifeTime
end

function V3a8EchoSongGameHitBallItem:isDead()
	return self._startTime and self._startTime + self._lifeTime < Time.time
end

function V3a8EchoSongGameHitBallItem:offsetStartTime(delta)
	if self._startTime then
		self._startTime = self._startTime + delta
	end
end

function V3a8EchoSongGameHitBallItem:reset()
	transformhelper.setPosXY(self.viewGO.transform, 10000, 10000)
end

return V3a8EchoSongGameHitBallItem
