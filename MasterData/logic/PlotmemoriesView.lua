-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/plotmemories/view/PlotmemoriesView.lua

module("logic.extensions.plotmemories.view.PlotmemoriesView", package.seeall)

local PlotmemoriesView = class("PlotmemoriesView", ViewComponent)

function PlotmemoriesView:buildUI()
	PlotmemoriesView.super.buildUI(self)

	self._closeBtn = self:getBtn("btnClose")
	self._mainBtn = self:getBtn("mainBtn")
	self._mainRed = self:getGo("mainBtn/redPoint")
	self._activityBtn = self:getBtn("activityBtn")
	self._activityRed = self:getGo("activityBtn/redPoint")
	self._cgBtn = self:getBtn("cgBtn")
	self._cartoonBtn = self:getBtn("cartoonBtn")
end

function PlotmemoriesView:bindEvents()
	PlotmemoriesView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._mainBtn:AddClickListener(self._onClickMain, self)
	self._activityBtn:AddClickListener(self._onClickActivity, self)
	self._cgBtn:AddClickListener(self._onClickCg, self)
	self._cartoonBtn:AddClickListener(self._onClickCartoon, self)
end

function PlotmemoriesView:unbindEvents()
	PlotmemoriesView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._mainBtn:RemoveClickListener()
	self._activityBtn:RemoveClickListener()
	self._cgBtn:RemoveClickListener()
	self._cartoonBtn:RemoveClickListener()
end

function PlotmemoriesView:onEnter()
	PlotmemoriesView.super.onEnter(self)
	GlobalDispatcher:addListener(PlotmamoriesController.PM_PlotReviewGetInfoRes, self._PlotReviewGetInfoRes, self)
	PlotReviewAgent.instance:sendPM_PlotReviewGetInfoReq()
end

function PlotmemoriesView:onExit()
	PlotmemoriesView.super.onExit(self)
	GlobalDispatcher:removeListener(PlotmamoriesController.PM_PlotReviewGetInfoRes, self._PlotReviewGetInfoRes, self)
end

function PlotmemoriesView:_PlotReviewGetInfoRes()
	local chapters = PlotmamoriesController.instance:getMainPlot()
	local prizeIds = PlotmamoriesController.instance:getGainedPrizeIds()
	local redFlag = false

	for i, chapter in ipairs(chapters) do
		for i, v in ipairs(chapter.ids) do
			local son = PlotmemoriesConfig.instance:getChapterSonById(v)

			if son then
				local sp = string.split(son.condition, "-")

				if not prizeIds[son.prizeId] and not (son.condition ~= "" and not TaskFacade.instance:isTaskStepFinished(checknumber(sp[1]), checknumber(sp[2]))) then
					redFlag = true

					break
				end
			else
				printError(string.format("没有小章节id:%d的配置信息"), v)
			end
		end
	end

	goutil.setActive(self._mainRed, redFlag)

	chapters = PlotmamoriesController.instance:getActivityPlot()
	redFlag = false

	for i, chapter in ipairs(chapters) do
		local lock = false
		local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(chapter.activityType, chapter.activityId)

		lock = endTime > ServerTime.now()

		for i, v in ipairs(chapter.ids) do
			local son = PlotmemoriesConfig.instance:getChapterSonById(v)

			if son then
				if not prizeIds[son.prizeId] and not lock then
					redFlag = true

					break
				end
			else
				printError(string.format("没有小章节id:%d的配置信息"), v)
			end
		end
	end

	goutil.setActive(self._activityRed, redFlag)
end

function PlotmemoriesView:_onClickMain()
	if PlotmamoriesController.instance:getGainedPrizeIds() then
		UIStateManager.instance:push(ViewName.PlotmainView, 0)
	end
end

function PlotmemoriesView:_onClickActivity()
	if PlotmamoriesController.instance:getGainedPrizeIds() then
		UIStateManager.instance:push(ViewName.PlotmainView, 1)
	end
end

function PlotmemoriesView:_onClickCg()
	UIStateManager.instance:push(ViewName.PlotrecallView)
end

function PlotmemoriesView:_onClickCartoon()
	FloatWordMgr.instance:show(lang("tips_not_release"))
end

return PlotmemoriesView
