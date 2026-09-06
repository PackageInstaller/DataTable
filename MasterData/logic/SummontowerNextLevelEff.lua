-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summontower/view/SummontowerNextLevelEff.lua

module("logic.extensions.summontower.view.SummontowerNextLevelEff", package.seeall)

local SummontowerNextLevelEff = class("SummontowerNextLevelEff")

function SummontowerNextLevelEff:ctor(view, playerNode, gridGo)
	self._playerNode = playerNode
	self._gridGo = gridGo
	self._view = view
end

function SummontowerNextLevelEff:startTween(finishCallback, finishCallbackObj)
	self._finishCallback = finishCallback
	self._finishCallbackObj = finishCallbackObj
	self._startPos = self._playerNode.transform.position
	self._destPos = self._gridGo.transform.position
	self._effDoor = UIEffectManager.instance:playEffectBrief(self._view, "20211028/zhaohuanmiyu/fx_ui_zhaohuanmiyu_chuansongfankui.prefab", self._view.mainGO, false, self._onEffectLoaded, self)

	self._effDoor:setParent(self._view.mainGO.transform)
	printInfo(self._gridGo.name, self._destPos.x, self._destPos.y, self._destPos.z)
	self._effDoor:setPos(self._destPos.x, self._destPos.y, self._destPos.z)
	self._effDoor:setScale(1)
	self._effDoor:setSortingOrder(201)
	self._effDoor:setEffTime(2)

	self._effDoor.finishHandler = self._onTweenPositionFinished
	self._effDoor.finishHandlerTarget = self
end

function SummontowerNextLevelEff:clear()
	if self._effDoor then
		UIEffectManager.instance:stopEffect(self._effDoor)

		self._effDoor = nil
	end

	if self._playerNode then
		UnityTweens.TweenPosition.StopTween(self._playerNode)
		UnityTweens.TweenScale.StopTween(self._playerNode)
	end

	self._playerNode = nil
	self._gridGo = nil
	self._view = nil
	self._finishCallback = nil
	self._finishCallbackObj = nil
	self._startPos = nil
	self._destPos = nil
end

function SummontowerNextLevelEff:_onEffectLoaded(eff)
	self._effDoor:setPos(self._destPos.x, self._destPos.y, self._destPos.z)

	local tween = UnityTweens.TweenPosition.StartTween(self._playerNode, self._startPos, self._destPos, 0.4, UnityTweens.EaseType.linear, 0, UnityTweens.CoordSpace.World)

	tween:RemoveListener()

	local sx, sy, sz = Framework.TransformUtil.GetLocalScale(self._playerNode.transform, nil, nil, nil)
	local tweenScale = UnityTweens.TweenScale.StartTween(self._playerNode, Vector3.New(sx, sy, sz), Vector3.New(0, 0, 0), 0.4)

	tweenScale.autoDestroy = true
end

function SummontowerNextLevelEff:_onTweenPositionFinished()
	local finishCallback = self._finishCallback
	local finishCallbackObj = self._finishCallbackObj

	self:clear()

	if finishCallback then
		self._finishCallback(finishCallbackObj, self)
	end
end

return SummontowerNextLevelEff
