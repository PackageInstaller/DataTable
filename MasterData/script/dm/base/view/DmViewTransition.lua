-- chunkname: @/tmp/or_script/lua_compile/dm/base/view/DmViewTransition.lua

PopupEnterTransition = class("PopupEnterTransition", ActionPopupViewTransition)

function PopupEnterTransition:resetViewForTransition(view)
	view:setAnchorPoint(cc.p(0.5, 0.5))
	view:setIgnoreAnchorPointForPosition(true)
	view:setOpacity(0)
	view:setScale(0.9)
end

function PopupEnterTransition:createTransitionAction()
	local duration = 0.15
	local fadeIn = cc.FadeIn:create(duration)
	local scaleTo1 = cc.ScaleTo:create(duration, 1.17)
	local spawn = cc.Spawn:create(fadeIn, scaleTo1)
	local easeInOut = cc.EaseInOut:create(spawn, 1)
	local scaleTo2 = cc.ScaleTo:create(duration, 1)
	local easeInOut1 = cc.EaseInOut:create(scaleTo2, 1)

	return (cc.Sequence:create(easeInOut, easeInOut1))
end

PopupExitTransition = class("PopupExitTransition", ActionPopupViewTransition)

function PopupExitTransition:resetViewForTransition(view)
	view:setAnchorPoint(cc.p(0.5, 0.5))
	view:setIgnoreAnchorPointForPosition(true)
	view:setScale(1)
end

function PopupExitTransition:createTransitionAction()
	local duration = 0.2

	return (cc.FadeOut:create(duration))
end

DmAreaViewTransition = class("DmAreaViewTransition")

DmAreaViewTransition:implements(IAreaViewTransition)

function DmAreaViewTransition:runTransitionAnimation(mainView, otherView, finishCallback)
	local winSize = cc.Director:getInstance():getWinSize()
	local transitionView = cc.LayerColor:create(cc.c4b(0, 0, 0, 255), winSize.width, winSize.height)

	transitionView:setOpacity(0)
	transitionView:addTo(mainView)
	transitionView:runAction(cc.Sequence:create(cc.FadeIn:create(0.2), cc.CallFunc:create(function()
		if finishCallback then
			return finishCallback(mainView, otherView, self)
		end
	end)))
end
