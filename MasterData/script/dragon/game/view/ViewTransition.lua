-- chunkname: @/tmp/or_script/lua_compile/dragon/game/view/ViewTransition.lua

IAreaViewTransition = interface("IAreaViewTransition")

function IAreaViewTransition:runTransitionAnimation(mainView, otherView, finishCallback)
	return
end

IPopupViewTransition = interface("IPopupViewTransition")

function IPopupViewTransition:runTransitionAnimation(view, finishCallback)
	return
end

ActionAreaViewTransition = class("ActionAreaViewTransition")

ActionAreaViewTransition:implements(IAreaViewTransition)

function ActionAreaViewTransition:runTransitionAnimation(mainView, otherView, finishCallback)
	local mainAction = self:createMainAction()

	if mainAction == nil then
		if finishCallback ~= nil then
			finishCallback(mainView, otherView, self)
		end

		return
	end

	local otherAction

	if otherView ~= nil then
		otherAction = self:createOtherAction()
	end

	self:resetViewForTransition(mainView, otherView)

	if finishCallback ~= nil then
		local callback = cc.CallFunc:create(function()
			return finishCallback(mainView, otherView, self)
		end)

		mainAction = cc.Sequence:create(mainAction, callback)
	end

	mainView:runAction(mainAction)

	if otherAction ~= nil then
		otherView:runAction(otherAction)
	end
end

function ActionAreaViewTransition:resetViewForTransition(mainView, otherView)
	return
end

function ActionAreaViewTransition:createMainAction()
	return nil
end

function ActionAreaViewTransition:createOtherAction()
	return nil
end

ActionPopupViewTransition = class("ActionPopupViewTransition")

ActionPopupViewTransition:implements(IPopupViewTransition)

function ActionPopupViewTransition:runTransitionAnimation(view, finishCallback)
	local action = self:createTransitionAction()

	if action == nil then
		if finishCallback ~= nil then
			finishCallback(view, self)
		end

		return
	end

	self:resetViewForTransition(view)

	if finishCallback ~= nil then
		action = cc.Sequence:create(action, cc.CallFunc:create(finishCallback, self))
	end

	view:runAction(action)
end

function ActionPopupViewTransition:resetViewForTransition(view)
	return
end

function ActionPopupViewTransition:createTransitionAction()
	return nil
end
