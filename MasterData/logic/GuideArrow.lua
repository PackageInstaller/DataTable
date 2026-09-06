-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guide/model/component/GuideArrow.lua

module("logic.extensions.guide.model.component.GuideArrow", package.seeall)

local GuideArrow = class("GuideArrow")

function GuideArrow:ctor(go, dir, dirGo, offset)
	self._arrow = go
	self._dir = dir
	self._followGo = dirGo
	self._offset = offset
	self._tween = nil

	self:_moveArrow()
end

function GuideArrow:_moveArrow()
	local mbForward = UnityTweens.TweenBase.GetWithTag(self._arrow, UnityTweensType.TweenPositionBy, 10)
	local mbBack = UnityTweens.TweenBase.GetWithTag(self._arrow, UnityTweensType.TweenPositionBy, 10)

	if dir == GuideConst.ArrowDirLeft then
		Framework.TransformUtil.SetLocalRotation(self._arrow.transform, 0, 0, -90)

		mbForward.positionBy = Vector3.New(-20, 0, 0)
		mbBack.positionBy = Vector3.New(20, 0, 0)
	elseif dir == GuideConst.ArrowDirRight then
		Framework.TransformUtil.SetLocalRotation(self._arrow.transform, 0, 0, 90)

		mbForward.positionBy = Vector3.New(20, 0, 0)
		mbBack.positionBy = Vector3.New(-20, 0, 0)
	elseif dir == GuideConst.ArrowDirDown then
		Framework.TransformUtil.SetLocalRotation(self._arrow.transform, 0, 0, 0)

		mbForward.positionBy = Vector3.New(0, -20, 0)
		mbBack.positionBy = Vector3.New(0, 20, 0)
	elseif dir == GuideConst.ArrowDirUp then
		Framework.TransformUtil.SetLocalRotation(self._arrow.transform, 0, 0, 180)

		mbForward.positionBy = Vector3.New(0, 20, 0)
		mbBack.positionBy = Vector3.New(0, -20, 0)
	end

	self._tween = self._arrow:GetComponent(UnityTweensType.TweenSequence)

	self._tween:Stop()
end

function GuideArrow:start()
	self._tween:Stop()
	self._tween:Begin()
end

return GuideArrow
