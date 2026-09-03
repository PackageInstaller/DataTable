-- chunkname: @/tmp/or_script/lua_compile/cocos/ui/GuiConstants.lua

if ccui == nil then
	return
end

ccui.BrightStyle = {
	normal = 0,
	highlight = 1,
	none = -1
}
ccui.TextureResType = {
	userDataType = 128,
	plistType = 1,
	localType = 0
}
ccui.TouchEventType = {
	moved = 1,
	began = 0,
	canceled = 3,
	ended = 2
}
ccui.SizeType = {
	absolute = 0,
	percent = 1
}
ccui.PositionType = {
	absolute = 0,
	percent = 1
}
ccui.CheckBoxEventType = {
	selected = 0,
	unselected = 1
}
ccui.RadioButtonEventType = {
	selected = 0,
	unselected = 1
}
ccui.RadioButtonGroupEventType = {
	select_changed = 0
}
ccui.TextFiledEventType = {
	insert_text = 2,
	detach_with_ime = 1,
	attach_with_ime = 0,
	delete_backward = 3
}
ccui.LayoutBackGroundColorType = {
	solid = 1,
	gradient = 2,
	none = 0
}
ccui.LayoutType = {
	ABSOLUTE = 0,
	RELATIVE = 3,
	VERTICAL = 1,
	HORIZONTAL = 2
}
ccui.LayoutParameterType = {
	linear = 1,
	relative = 2,
	none = 0
}
ccui.LinearGravity = {
	right = 3,
	bottom = 4,
	centerVertical = 5,
	centerHorizontal = 6,
	top = 2,
	left = 1,
	none = 0
}
ccui.RelativeAlign = {
	locationAboveCenter = 11,
	alignParentBottomCenterHorizontal = 8,
	locationLeftOfCenter = 14,
	alignParentTopCenterHorizontal = 2,
	locationRightOfTopAlign = 16,
	locationRightOfCenter = 17,
	centerInParent = 5,
	alignParentRightBottom = 9,
	locationBelowRightAlign = 21,
	alignParentRightCenterVertical = 6,
	locationBelowLeftAlign = 19,
	locationLeftOfTopAlign = 13,
	locationBelowCenter = 20,
	alignNone = 0,
	alignParentLeftCenterVertical = 4,
	locationAboveLeftAlign = 10,
	alignParentLeftBottom = 7,
	locationLeftOfBottomAlign = 15,
	locationRightOfBottomAlign = 18,
	locationAboveRightAlign = 12,
	alignParentTopLeft = 1,
	alignParentTopRight = 3
}
ccui.SliderEventType = {
	slideBallDown = 1,
	slideBallCancel = 3,
	percentChanged = 0,
	slideBallUp = 2
}
ccui.LoadingBarDirection = {
	LEFT = 0,
	RIGHT = 1
}
ccui.ScrollViewDir = {
	both = 3,
	vertical = 1,
	horizontal = 2,
	none = 0
}
ccui.ScrollViewMoveDir = {
	down = 2,
	up = 1,
	right = 4,
	left = 3,
	none = 0
}
ccui.ScrollviewEventType = {
	scrollToTop = 0,
	bounceBottom = 6,
	bounceLeft = 7,
	bounceTop = 5,
	autoscrollEnded = 10,
	scrollToBottom = 1,
	scrolling = 4,
	containerMoved = 9,
	bounceRight = 8,
	scrollToRight = 3,
	scrollToLeft = 2
}
ccui.ScrollInertiaType = {
	SCROLLVIEW_INERTIA_SINE_EASEOUT = 1,
	SCROLLVIEW_INERTIA_LINEAR = 0,
	SCROLLVIEW_INERTIA_QUAD_EASEOUT = 2,
	SCROLLVIEW_INERTIA_QUART_EASEOUT = 4,
	SCROLLVIEW_INERTIA_CUBIC_EASEOUT = 3,
	SCROLLVIEW_INERTIA_QUINT_EASEOUT = 5,
	SCROLLVIEW_INERTIA_EXPO_EASEOUT = 6
}
ccui.ListViewDirection = {
	vertical = 1,
	horizontal = 2,
	none = 0
}
ccui.ListViewMoveDirection = {
	down = 2,
	up = 1,
	right = 4,
	left = 3,
	none = 0
}
ccui.ListViewEventType = {
	ONSELECTEDITEM_END = 1,
	ONSELECTEDITEM_START = 0
}
ccui.PageViewEventType = {
	turning = 0
}
ccui.PageViewDirection = {
	HORIZONTAL = 0,
	VERTICAL = 1
}
ccui.PVTouchDir = {
	touchUp = 2,
	touchDown = 3,
	touchRight = 1,
	touchLeft = 0
}
ccui.ListViewGravity = {
	bottom = 4,
	centerVertical = 5,
	centerHorizontal = 2,
	top = 3,
	left = 0,
	right = 1
}
ccui.TextType = {
	TTF = 1,
	SYSTEM = 0
}
ccui.LayoutComponent.HorizontalEdge = {
	Right = 2,
	Center = 3,
	Left = 1,
	None = 0
}
ccui.LayoutComponent.VerticalEdge = {
	Top = 2,
	Center = 3,
	Bottom = 1,
	None = 0
}
