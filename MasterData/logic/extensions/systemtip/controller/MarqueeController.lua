-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/systemtip/controller/MarqueeController.lua

module("logic.extensions.systemtip.controller.MarqueeController", package.seeall)

local M = class("MarqueeController", BaseController)

function M:ctor()
	return
end

function M:onInit()
	GlobalDispatcher:addEventListener(EventType.SHOW_MARQUEE_EVENT, self._showMarquee, self)
end

function M:onReset()
	ViewMgr.instance:close(ViewName.MarqueeView)
end

function M:_showMarquee()
	local isPlaying = MarqueeFacade.instance:getPlayState()

	if not isPlaying then
		local data = ChatModel.instance:getBroadcastData()

		if data then
			if not ViewMgr.instance:isOpen(ViewName.MarqueeView) then
				ViewMgr.instance:openSpecialView(ViewName.MarqueeView)
			end

			MarqueeFacade.instance:showMarquee(data)
		else
			MarqueeFacade.instance:hideMarquee()
		end
	end
end

M.instance = M.New()

return M
