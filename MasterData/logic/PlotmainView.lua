-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/plotmemories/view/PlotmainView.lua

module("logic.extensions.plotmemories.view.PlotmainView", package.seeall)

local PlotmainView = class("PlotmainView", ViewComponent)

function PlotmainView:buildUI()
	PlotmainView.super.buildUI(self)

	self._title = self:getTxt("closebg/title")
	self._closeBtn = self:getBtn("closebg/btnClose")
	self._chapterCell = self:getGo("chapterCell")
	self._chapterView = ScrollerList.create(self:getGo("chapterView"), self._chapterCell, GameUtil.handler(self._updateChapterCell, self))
	self._nodeCell = self:getGo("nodeCell")
	self._nodeView = ScrollerList.create(self:getGo("nodeView"), self._nodeCell, GameUtil.handler(self._updateNodeCell, self), GameUtil.handler(self._clearNodeCell, self))
end

function PlotmainView:bindEvents()
	PlotmainView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
end

function PlotmainView:unbindEvents()
	PlotmainView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function PlotmainView:onEnter()
	PlotmainView.super.onEnter(self)

	self._storyType = self:getFirstParam() or 0
	self._title.text = self._storyType == 0 and lang("主线回顾") or lang("活动回顾")
	self._firstOpen = true
	self._gainedPrizeIds = PlotmamoriesController.instance:getGainedPrizeIds()
	self._cellId = {}

	if self._storyType == 0 then
		self._chapterView:reloadData(PlotmamoriesController.instance:getMainPlot())
	else
		self._chapterView:reloadData(PlotmamoriesController.instance:getActivityPlot())
	end

	GlobalDispatcher:addListener(PlotmamoriesController.PM_PlotReviewGainPrizeRes, self._PlotReviewGainPrizeRes, self)
end

function PlotmainView:onExit()
	PlotmainView.super.onExit(self)
	GlobalDispatcher:removeListener(PlotmamoriesController.PM_PlotReviewGainPrizeRes, self._PlotReviewGainPrizeRes, self)
	self._chapterView:dispose()
	self._nodeView:dispose()
end

function PlotmainView:_PlotReviewGainPrizeRes()
	goutil.setActive(goutil.findChild(self._gainCell, "red"), false)
	goutil.setActive(goutil.findChild(self._gainCell, "new"), false)
	self._chapterView:refresh()
end

function PlotmainView:_updateChapterCell(view, cell, data)
	local lock = true

	if self._storyType == 0 then
		local sp = string.split(data.condition, "-")

		lock = not TaskFacade.instance:isTaskStepFinished(checknumber(sp[1]), checknumber(sp[2]))
	else
		local startTime, endTime = ActivityDefineController.instance:getStartTimeAndEndTime(data.activityType, data.activityId)

		lock = endTime > ServerTime.now()
	end

	uGuiUtil.setGoGrayState(cell.gameObject, lock)

	local selectIcon = goutil.findChild(cell.gameObject, "select/icon")
	local unSelectIcon = goutil.findChild(cell.gameObject, "icon")

	uGuiUtil.setSpriteToImage(selectIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getPlotSonIcon(data.icon))
	uGuiUtil.setSpriteToImage(unSelectIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getPlotSonIcon(data.icon))

	local function clickBtnHandler()
		if lock then
			FloatWordMgr.instance:show(lang("tip_lock_txt"))

			return
		end

		self._curSelect = data.chapterId

		for k, id in pairs(self._cellId) do
			if id ~= self._curSelect then
				goutil.setActive(goutil.findChild(k, "select"), false)
				goutil.setActive(goutil.findChild(k, "icon"), true)
			else
				goutil.setActive(goutil.findChild(k, "select"), true)
				goutil.setActive(goutil.findChild(k, "icon"), false)
			end
		end

		local nodeList = {}

		for i, v in ipairs(data.ids) do
			local obj = PlotmemoriesConfig.instance:getChapterSonById(v)

			if self._storyType == 0 then
				local sp = string.split(obj.condition, "-")
				local temp = obj.condition ~= "" and not TaskFacade.instance:isTaskStepFinished(checknumber(sp[1]), checknumber(sp[2]))

				if not temp then
					table.insert(nodeList, obj)
				end
			else
				table.insert(nodeList, obj)
			end
		end

		self._nodeView:reloadData(nodeList)
	end

	Framework.ButtonAdapter.Get(cell.gameObject):AddClickListener(clickBtnHandler)

	self._cellId[cell.gameObject] = data.chapterId

	goutil.setActive(goutil.findChild(cell.gameObject, "select"), self._curSelect == data.chapterId)
	goutil.setActive(unSelectIcon, self._curSelect ~= data.chapterId)

	if self._firstOpen and not lock then
		clickBtnHandler()

		self._firstOpen = false
	end

	goutil.setActive(goutil.findChild(cell.gameObject, "red"), false)

	for i, v in ipairs(data.ids) do
		local son = PlotmemoriesConfig.instance:getChapterSonById(v)
		local sp = string.split(son.condition, "-")

		if not self._gainedPrizeIds[son.prizeId] and not (son.condition ~= "" and not TaskFacade.instance:isTaskStepFinished(checknumber(sp[1]), checknumber(sp[2]))) then
			goutil.setActive(goutil.findChild(cell.gameObject, "red"), not lock)

			break
		end
	end
end

function PlotmainView:_updateNodeCell(view, cell, data)
	local lock = false

	if self._storyType == 0 then
		local sp = string.split(data.condition, "-")

		lock = data.condition ~= "" and not TaskFacade.instance:isTaskStepFinished(checknumber(sp[1]), checknumber(sp[2]))
	end

	uGuiUtil.setGoGrayState(cell.gameObject, lock)

	goutil.findChildTextComponent(cell.gameObject, "title").text = data.title
	goutil.findChildTextComponent(cell.gameObject, "name").text = data.name

	if self._gainedPrizeIds[data.prizeId] then
		goutil.setActive(goutil.findChild(cell.gameObject, "reward"), false)
	else
		local proxy = MaterialMgr.setCellByCfg(PlotmemoriesConfig.instance:getPrizeById(data.prizeId).prize, goutil.findChild(cell.gameObject, "reward/icon"))

		if proxy then
			Framework.TransformUtil.SetLocalScale(proxy.view.transform, 0.5, 0.5, 1)
			proxy.binder:setBgActive(false)
			proxy.binder:setGray(lock)
		end

		goutil.setActive(goutil.findChild(cell.gameObject, "reward"), true)
	end

	Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn"):AddClickListener(function()
		if lock then
			FloatWordMgr.instance:show(lang("tip_lock_txt"))

			return
		end

		if self._gainedPrizeIds[data.prizeId] then
			if PlotmemoriesConfig.instance:getChapterSonById(data.id) then
				UIStateManager.instance:push(ViewName.PlotnodeView, data.id)
			end
		else
			self._gainCell = cell.gameObject

			PlotmamoriesController.instance:sendPM_PlotReviewGainPrizeReq(data.prizeId)
		end
	end)
	goutil.setActive(goutil.findChild(cell.gameObject, "red"), not self._gainedPrizeIds[data.prizeId] and not lock)
	goutil.setActive(goutil.findChild(cell.gameObject, "new"), not self._gainedPrizeIds[data.prizeId] and not lock)
	uGuiUtil.setSpriteToImage(goutil.findChild(cell.gameObject, "cover"), uGuiUtil.SpriteType.BigBg, GameUrl.getPlotSonIcon(data.icon))
end

function PlotmainView:_clearNodeCell(cell)
	MaterialMgr.resetAll(goutil.findChild(cell.gameObject, "reward/icon"))
	uGuiUtil.clearImage(goutil.findChild(cell.gameObject, "cover"))
	Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn"):RemoveClickListener()
end

return PlotmainView
