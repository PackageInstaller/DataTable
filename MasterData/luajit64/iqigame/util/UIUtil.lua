-- chunkname: @IQIGame\\Util\\UIUtil.lua

UIUtil = {}
UGUISide = {
	Bottom = 3,
	BottomLeft = 2,
	Right = 1,
	Top = -3,
	BottomRight = 4,
	TopLeft = -4,
	Left = -1,
	TopRight = -2
}

function UIUtil.ResetTweenIn(gameObject)
	local tweens = gameObject:GetComponentsInChildren(typeof(UITweener))

	for i = 0, tweens.Length - 1 do
		tweens[i]:ResetToBeginning()

		tweens[i].enabled = true
	end
end

function UIUtil.InitSortedComponents(rootUICanvas, gameObject)
	local sortComponents = gameObject:GetComponentsInChildren(typeof(IQIGame.Onigao.Game.SortedComponentOrder), true)

	for i = 0, sortComponents.Length - 1 do
		sortComponents[i].UIRootCanvas = rootUICanvas
	end
end

function UIUtil.CenterPositionOffset(targetObjTransform)
	local p = Vector3.zero

	if targetObjTransform then
		local pivot = targetObjTransform.pivot

		p.x = (pivot.x - 0.5) * targetObjTransform.sizeDelta.x
		p.y = (pivot.y - 0.5) * targetObjTransform.sizeDelta.y
	end

	return p
end

function UIUtil.PlayDefaultAnim(animRoot)
	local animation = animRoot:GetComponent(typeof(UnityEngine.Animation))

	if animation == nil then
		return
	end

	animation:Play()
end

function UIUtil.StopDefaultAnim(animRoot)
	local animation = animRoot:GetComponent(typeof(UnityEngine.Animation))

	if animation == nil then
		return
	end

	animation:Stop()
end

function UIUtil.PlayOrRewindDefaultAnim(animRoot, isReverse)
	local animation = animRoot:GetComponent(typeof(UnityEngine.Animation))

	if animation == nil then
		return
	end

	local enumerator = animation:GetEnumerator()

	while enumerator:MoveNext() do
		local animationState = enumerator.Current

		animationState.time = isReverse and animationState.length or 0
		animationState.speed = isReverse and -1 or 1
	end

	animation:Play()
end

function UIUtil.StopAnimationAt(animRoot, normalizedTime)
	local animation = animRoot:GetComponent(typeof(UnityEngine.Animation))

	if animation == nil then
		return
	end

	animation:Play()

	local enumerator = animation:GetEnumerator()

	while enumerator:MoveNext() do
		local animationState = enumerator.Current

		animationState.normalizedTime = normalizedTime

		break
	end

	animation:Sample()
	animation:Stop()
end

function UIUtil.AdjustUIInScreen(uiCanvas, refTrans, followerTrans, offset, refSide, followerSide)
	if offset == nil then
		offset = Vector2.zero
	end

	if refSide == nil then
		refSide = UGUISide.BottomRight
	end

	if followerSide == nil then
		followerSide = UGUISide.TopLeft
	end

	local screenRect = UGUIUtil.GetUIRect(uiCanvas.transform)

	UIUtil.__AnchorTo(followerTrans, followerSide, refTrans, refSide, offset)

	local offsetIfInScreen = UIUtil.__GetOffsetIfInScreen(followerTrans, screenRect, uiCanvas.transform)

	if offsetIfInScreen.x == 0 and offsetIfInScreen.y == 0 then
		return
	end

	if offsetIfInScreen.x ~= 0 and offsetIfInScreen.y ~= 0 then
		refSide = UIUtil.__ConvertSide(refSide, true, true)
		followerSide = UIUtil.__ConvertSide(followerSide, true, true)
	elseif offsetIfInScreen.x ~= 0 then
		refSide = UIUtil.__ConvertSide(refSide, true, false)
		followerSide = UIUtil.__ConvertSide(followerSide, true, false)
	else
		refSide = UIUtil.__ConvertSide(refSide, false, true)
		followerSide = UIUtil.__ConvertSide(followerSide, false, true)
	end

	UIUtil.__AnchorTo(followerTrans, followerSide, refTrans, refSide, offset)

	offsetIfInScreen = UIUtil.__GetOffsetIfInScreen(followerTrans, screenRect, uiCanvas.transform)

	if offsetIfInScreen.x ~= 0 or offsetIfInScreen.y ~= 0 then
		warning("请找程序确认：在不遮挡参考节点（如道具图标）的情况下，无论怎么对齐都会超框，请检查UI设计和布局是否会出现这种情况，如果Tips过大，建议使用居中弹窗的形式。")
	end
end

function UIUtil.__ConvertSide(side, convertX, convertY)
	if not convertX and not convertY then
		return side
	end

	if convertX and convertY then
		side = side * -1
	elseif convertX then
		if side == UGUISide.Left or side == UGUISide.TopLeft or side == UGUISide.BottomLeft then
			side = side + 2
		else
			side = side - 2
		end
	elseif convertY then
		if side == UGUISide.Top or side == UGUISide.TopLeft or side == UGUISide.TopRight then
			side = side + 6
		else
			side = side - 6
		end
	end

	return side
end

function UIUtil.__AnchorTo(followerTrans, followerSide, refTrans, refSide, offset)
	followerTrans.pivot = Vector2.zero

	local followerRect = UGUIUtil.GetUIRect(followerTrans)
	local refRect = UGUIUtil.GetUIRect(refTrans)
	local refPosition2D = Vector2(refRect.x, refRect.y)
	local followerOffset = UIUtil.__GetRectOffset(followerRect, followerSide)
	local refOffset = UIUtil.__GetRectOffset(refRect, refSide)
	local position = followerTrans.position
	local position2D = refPosition2D + refOffset - followerOffset

	position.x = position2D.x
	position.y = position2D.y
	followerTrans.position = position
	followerTrans.anchoredPosition = followerTrans.anchoredPosition + offset
end

function UIUtil.__GetRectOffset(rect, side)
	local offset = Vector2.zero

	if side == UGUISide.Bottom then
		offset.x = rect.w * 0.5
	elseif side == UGUISide.BottomLeft then
		-- block empty
	elseif side == UGUISide.BottomRight then
		offset.x = rect.w
	elseif side == UGUISide.Left then
		offset.y = rect.h * 0.5
	elseif side == UGUISide.Right then
		offset.x = rect.w
		offset.y = rect.h * 0.5
	elseif side == UGUISide.Top then
		offset.x = rect.w * 0.5
		offset.y = rect.h
	elseif side == UGUISide.TopLeft then
		offset.y = rect.h
	elseif side == UGUISide.TopRight then
		offset.x = rect.w
		offset.y = rect.h
	end

	return offset
end

function UIUtil.__GetOffsetIfInScreen(followerTrans, screenRect, canvasTrans)
	local rect = UGUIUtil.GetUIRect(followerTrans)

	if screenRect == nil then
		return false
	end

	local delta = Vector2.zero

	if rect.x < screenRect.x then
		delta.x = rect.x - screenRect.x
	elseif rect.x + rect.w > screenRect.x + screenRect.w then
		delta.x = rect.x + rect.w - (screenRect.x + screenRect.w)
	end

	if rect.y < screenRect.y then
		delta.y = rect.y - screenRect.y
	elseif rect.y + rect.h > screenRect.y + screenRect.h then
		delta.y = rect.y + rect.h - (screenRect.y + screenRect.h)
	end

	return delta
end
