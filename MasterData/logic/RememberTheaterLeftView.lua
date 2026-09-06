-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/remembertheater/view/RememberTheaterLeftView.lua

module("logic.extensions.remembertheater.view.RememberTheaterLeftView", package.seeall)

local RememberTheaterLeftView = class("RememberTheaterLeftView", TableViewComponent)

function RememberTheaterLeftView:ctor()
	RememberTheaterLeftView.super.ctor(self)
end

function RememberTheaterLeftView:buildUI()
	RememberTheaterLeftView.super.buildUI(self)
end

function RememberTheaterLeftView:destroyUI()
	RememberTheaterLeftView.super.destroyUI(self)
end

function RememberTheaterLeftView:bindEvents()
	RememberTheaterLeftView.super.bindEvents(self)
end

function RememberTheaterLeftView:unbindEvents()
	RememberTheaterLeftView.super.unbindEvents(self)
end

function RememberTheaterLeftView:onEnter()
	RememberTheaterLeftView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.PM_ActivitySummaryGetTaskInfo, self._PM_ActivitySummaryGetTaskInfo, self)

	local summaryId = 17042

	self._curData = nil

	OpSummaryModel.instance:sendGetAllTask(summaryId)

	self._curSelectCellId = 0
	self._curViewDatas = RememberTheaterConfig.instance:getTabCfgs()
	self._isEnterFrist = true
end

function RememberTheaterLeftView:onEnterFinished()
	RememberTheaterLeftView.super.onEnterFinished(self)
end

function RememberTheaterLeftView:onExit()
	RememberTheaterLeftView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_ActivitySummaryGetTaskInfo, self._PM_ActivitySummaryGetTaskInfo, self)
end

function RememberTheaterLeftView:_getPath()
	return {
		cellPath = "btnCell",
		viewPath = "chapterView"
	}
end

function RememberTheaterLeftView:_updateCell(view, cell, data)
	local chapterNameText = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local chapterLock = goutil.findChild(cell.gameObject, "lock")
	local chapterSelect = goutil.findChild(cell.gameObject, "select")
	local redPoint = goutil.findChild(cell.gameObject, "redPoint")
	local btn = Framework.ButtonAdapter.Get(cell.gameObject)
	local isLockChapter = RememberTheaterModel.instance:isLockChapter(data.tabId)
	local haveRedPoint = RememberTheaterModel.instance:haveRedPoint(data.tabId)

	goutil.setActive(redPoint, haveRedPoint)
	goutil.setActive(chapterLock, isLockChapter)

	chapterNameText.text = string.format("章节%d", data.tabId)

	goutil.setActive(chapterSelect, self._curSelectCellId == data.tabId)
	btn:RemoveClickListener()
	btn:AddClickListener(function()
		if isLockChapter then
			FloatWordMgr.instance:show(data.desc)

			return
		end

		self:_onBtnClick(data)
	end)
end

function RememberTheaterLeftView:_clearTableview(cell)
	local btn = Framework.ButtonAdapter.Get(cell.gameObject)

	btn:RemoveClickListener()
end

function RememberTheaterLeftView:_onBtnClick(data)
	if data.tabId == self._curSelectCellId then
		return
	end

	self._curData = data

	if RememberTheaterModel.instance:isLockChapter(data.tabId) then
		FloatWordMgr.instance:show(data.desc)
	else
		self._curSelectCellId = data.tabId

		self:reloadData()
		GlobalDispatcher:dispatch(GlobalNotify.RememberTheaterChangePage, self._curSelectCellId)
	end
end

function RememberTheaterLeftView:_PM_ActivitySummaryGetTaskInfo()
	self:reloadData()

	if self._isEnterFrist and not RememberTheaterModel.instance:isLockChapter(1) then
		self:_onBtnClick(self._curViewDatas[1])

		self._isEnterFrist = false
	end
end

return RememberTheaterLeftView
