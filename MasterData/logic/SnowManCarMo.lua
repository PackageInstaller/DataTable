-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/snowmancar/model/SnowManCarMo.lua

module("logic.extensions.snowmancar.view.SnowManCarMo", package.seeall)

local SnowManCarMo = class("SnowManCarMo", BaseLuaOnce)
local CarIconPath = "ui/icon/headicon"

function SnowManCarMo:buildUI()
	self._icon = self:getGo("icon")
end

function SnowManCarMo:onExit()
	SnowManCarMo.super.onExit(self)
	self:clear()
end

function SnowManCarMo:onEnter(view)
	self._view = view
	self._orgAnchorPos = GameUtil.getAnchoredPos(self.mainGO)
end

function SnowManCarMo:move(duration)
	local fromPos = self._orgAnchorPos
	local toPos = Vector3.New(0, -250, 0)
	local tween = UnityTweens.TweenPosition.StartTween(self.mainGO, fromPos, toPos, duration, UnityTweens.EaseType.linear, 0, UnityTweens.CoordSpace.Anchor)

	tween:AddListener(self._afterMove, self)
end

function SnowManCarMo:_afterMove(tween)
	tween:RemoveListener()

	local fromPos = self._orgAnchorPos

	GameUtil.setAnchoredPos(self.mainGO.transform, fromPos.x, fromPos.y)
	self._view:notify(SnowManCarController.AfterCarMoveFinish, self, self.mainGO)
end

function SnowManCarMo:initUI(imgName)
	SnowManCarController.instance:setSpriteToImage(self._icon, CarIconPath, imgName)
end

function SnowManCarMo:clear()
	self:setActive(true)
	MaterialMgr.resetAll(self._icon)
	UnityTweens.TweenPosition.StopTween(self.mainGO)
end

function SnowManCarMo:setActive(active)
	goutil.setActive(self.mainGO, active)
end

return SnowManCarMo
