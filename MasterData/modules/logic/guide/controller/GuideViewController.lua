-- chunkname: @modules/logic/guide/controller/GuideViewController.lua

module("modules.logic.guide.controller.GuideViewController", package.seeall)

local GuideViewController = class("GuideViewController", BaseController)

function GuideViewController:onInit()
	return
end

function GuideViewController:reInit()
	return
end

function GuideViewController:addConstEvents()
	GuideController.instance:registerCallback(GuideEvent.FadeView, self._onReceiveFadeView, self)
	GuideController.instance:registerCallback(GuideEvent.FinishGuide, self._onFinishGuide, self)
end

function GuideViewController:_onFinishGuide(guideId)
	if self._isShow == false and guideId == 501 then
		self._isShow = nil

		self:_fadeView(true)
	end
end

function GuideViewController:_onReceiveFadeView(param)
	local show = param == "1"

	self._isShow = show

	self:_fadeView(show)
end

function GuideViewController:_fadeView(show)
	local viewList = {
		ViewName.DungeonMapView,
		ViewName.MainView
	}

	for i, viewName in ipairs(viewList) do
		local viewContainer = ViewMgr.instance:getContainer(viewName)

		if viewContainer and viewContainer:isOpen() and viewContainer.viewGO then
			if show then
				viewContainer:_setVisible(true)
				gohelper.setActive(viewContainer.viewGO, false)
				gohelper.setActive(viewContainer.viewGO, true)

				break
			end

			viewContainer:_setVisible(false)

			break
		end
	end
end

GuideViewController.instance = GuideViewController.New()

return GuideViewController
