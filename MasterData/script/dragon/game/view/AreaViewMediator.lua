-- chunkname: @/tmp/or_script/lua_compile/dragon/game/view/AreaViewMediator.lua

AreaViewMediator = class("AreaViewMediator", BaseViewMediator)

function AreaViewMediator:initialize()
	super.initialize(self)
end

function AreaViewMediator:dispose()
	super.dispose(self)
end

function AreaViewMediator:enterWithData(data)
	return
end

function AreaViewMediator:leaveWithData(data)
	self:dismiss(data)
end

function AreaViewMediator:willStartEnterTransition(transition)
	return
end

function AreaViewMediator:didFinishEnterTransition(transition)
	return
end

function AreaViewMediator:willStartExitTransition(transition)
	return
end

function AreaViewMediator:didFinishExitTransition(transition)
	return
end

function AreaViewMediator:willBeCovered()
	return
end

function AreaViewMediator:willStartCoverTransition(transition)
	return
end

function AreaViewMediator:didFinishCoverTransition(transition)
	return
end

function AreaViewMediator:resumeWithData(data)
	return
end

function AreaViewMediator:willStartResumeTransition(transition)
	return
end

function AreaViewMediator:didFinishResumeTransition(transition)
	return
end

function AreaViewMediator:dismiss(data)
	return self:dismissWithOptions(nil, data)
end

function AreaViewMediator:dismissWithOptions(options, data)
	local view = self:getView()

	view:dispatchEvent(ViewEvent:new(EVT_DISMISS_VIEW, view, options, data))
end
