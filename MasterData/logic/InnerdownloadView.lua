-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/innerdownload/view/InnerdownloadView.lua

module("logic.extensions.innerdownload.view.InnerdownloadView", package.seeall)

local InnerdownloadView = class("InnerdownloadView", ViewComponent)

function InnerdownloadView:ctor()
	InnerdownloadView.super.ctor(self)
end

function InnerdownloadView:unbindEvents()
	InnerdownloadView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function InnerdownloadView:bindEvents()
	InnerdownloadView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnStart, self._onClickStart, self)
	GameUtil.addClickHandler(self._btnPause, self._onClickPause, self)
end

function InnerdownloadView:buildUI()
	InnerdownloadView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnStart = self:getGo("btnStart")
	self._btnPause = self:getGo("btnPause")
	self._tableview = self:getGo("tableview")
	self._tablecell = self:getGo("tableview/tablecell")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function InnerdownloadView:onExit()
	InnerdownloadView.super.onExit(self)
	self._scrollList:dispose()
end

function InnerdownloadView:onEnter()
	InnerdownloadView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.INNER_DOWNLOAD_UPDATE, self._updateCellByIdx, self)

	local data = InnerDownloadController.instance:getDataList() or {}
	local arr = {}

	for i, v in ipairs(data) do
		table.insert(arr, v)
	end

	ArraySort.sortOn(arr, {
		function(a)
			local idx = a.id
			local info = InnerDownloadController.instance:getLoadInfoIdx(idx)

			if info and info.isDone == true then
				return 1
			else
				return 0
			end
		end,
		"id"
	}, {
		ArraySort.NUMERIC,
		ArraySort.NUMERIC
	})
	self._scrollList:reloadData(arr)
end

function InnerdownloadView:_updateCellByIdx(idx)
	self._scrollList:refresh()
end

function InnerdownloadView:_onClickStart()
	InnerDownloadController.instance:resumeAllDownload()
	self._scrollList:refresh()
end

function InnerdownloadView:_onClickPause()
	InnerDownloadController.instance:pauseAllDownload()
	self._scrollList:refresh()
end

function InnerdownloadView:_updateCell(view, cell, data, tag)
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtProgress = goutil.findChildTextComponent(cell, "slider/txtProgress")
	local sliderGo = goutil.findChild(cell, "slider")
	local slider = Framework.SliderAdapter.Get(sliderGo)
	local btnPause = goutil.findChild(cell, "btnPause")
	local pauseGo = goutil.findChild(cell, "btnPause/img_1")
	local resumeGo = goutil.findChild(cell, "btnPause/img_2")

	txtName.text = data.name
	txtProgress.text = ""

	GameUtil.SetActive(btnPause, false)
	GameUtil.rmClickHandler(btnPause)
	slider:SetValue(0)

	local idx = data.id
	local info = InnerDownloadController.instance:getLoadInfoIdx(idx)

	if info then
		if info.loader then
			local progress = info.loader.curCount / info.loader.totalCount

			txtProgress.text = string.format("%.2f%%", progress * 100)

			slider:SetValue(progress)
			GameUtil.SetActive(btnPause, info.isDone == false)
		end

		GameUtil.SetActive(pauseGo, info.isPause)
		GameUtil.SetActive(resumeGo, not info.isPause)
		GameUtil.addClickHandler(btnPause, function()
			if info.isPause then
				InnerDownloadController.instance:resumeDownloadIndex(idx)
			else
				InnerDownloadController.instance:pauseDownloadIndex(idx)
			end

			self._scrollList:refresh()
		end)
	end
end

function InnerdownloadView:_clearCell(cell)
	return
end

return InnerdownloadView
