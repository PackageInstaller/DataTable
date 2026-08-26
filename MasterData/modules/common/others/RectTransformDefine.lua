-- chunkname: @modules/common/others/RectTransformDefine.lua

module("modules.common.others.RectTransformDefine", package.seeall)

local RectTransformDefine = _M

RectTransformDefine.Anchor = {
	LeftUp = Vector2.New(0, 1),
	LeftMiddle = Vector2.New(0, 0.5),
	LeftBottom = Vector2.New(0, 0),
	CenterUp = Vector2.New(0.5, 1),
	CenterMiddle = Vector2.New(0.5, 0.5),
	CenterBottom = Vector2.New(0.5, 0),
	RightUp = Vector2.New(1, 1),
	RightMiddle = Vector2.New(1, 0.5),
	RightBottom = Vector2.New(1, 0)
}

return RectTransformDefine
