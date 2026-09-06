-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summontower/view/SummontowerGetDragonBall.lua

module("logic.extensions.summontower.view.SummontowerGetDragonBall", package.seeall)

local SummontowerGetDragonBall = class("SummontowerGetDragonBall")

function SummontowerGetDragonBall:ctor(view, ballGo, gridGo)
	self._ballGo = ballGo
	self._gridGo = gridGo
	self._view = view
end

function SummontowerGetDragonBall:startTween(finishCallback, finishCallbackObj)
	self._finishCallback = finishCallback
	self._finishCallbackObj = finishCallbackObj
	self._startPos = self._gridGo.transform.position
	self._destPos = self._ballGo.transform.position
	self._effFly = UIEffectManager.instance:playEffectBrief(self._view, "20211028/zhaohuanmiyu/fx_ui_zhaohuanmiyu_longzhu.prefab", self._view.mainGO, true, self._onEffectLoaded, self)

	self._effFly:setParent(self._view.mainGO.transform)
	self._effFly:setPos(self._startPos.x, self._startPos.y, self._startPos.z)
	self._effFly:setScale(1)
end

function SummontowerGetDragonBall:clear()
	if self._effFly then
		if not goutil.isNil(self._effFly.effGo) then
			UnityTweens.TweenPosition.StopTween(self._effFly.effGo)
		end

		UIEffectManager.instance:stopEffect(self._effFly)

		self._effFly = nil
	end

	if self._effBall then
		UIEffectManager.instance:stopEffect(self._effBall)

		self._effBall = nil
	end

	self._ballGo = nil
	self._gridGo = nil
	self._view = nil
	self._finishCallback = nil
	self._finishCallbackObj = nil
	self._startPos = nil
	self._destPos = nil
end

function SummontowerGetDragonBall:_onEffectLoaded(eff)
	local tween = UnityTweens.TweenPosition.StartTween(self._effFly.effGo, self._startPos, self._destPos, 0.5, UnityTweens.EaseType.easeInSine, 0, UnityTweens.CoordSpace.World)

	tween.autoDestroy = true

	tween:AddListener(self._onTweenPositionFinished, self)
end

function SummontowerGetDragonBall:_onTweenPositionFinished()
	self._ballGo:SetActive(false)

	self._effBall = UIEffectManager.instance:playEffectBrief(self._view, "20211028/zhaohuanmiyu/fx_ui_zhaohuanmiyu_feirufankui.prefab", self._view.mainGO, false, function()
		self._effBall:setPos(self._destPos.x, self._destPos.y, self._destPos.z)
	end)

	self._effBall:setParent(self._view.mainGO.transform)
	self._effBall:setPos(self._destPos.x, self._destPos.y, self._destPos.z)
	self._effBall:setScale(1)
	self._effBall:setEffTime(1.5)

	self._effBall.finishHandler = self._onBallEffectFinished
	self._effBall.finishHandlerTarget = self
end

function SummontowerGetDragonBall:_onBallEffectFinished()
	local finishCallback = self._finishCallback
	local finishCallbackObj = self._finishCallbackObj

	self:clear()

	if finishCallback then
		self._finishCallback(finishCallbackObj, self)
	end
end

return SummontowerGetDragonBall
