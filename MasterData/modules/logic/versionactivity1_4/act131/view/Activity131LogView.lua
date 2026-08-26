-- chunkname: @modules/logic/versionactivity1_4/act131/view/Activity131LogView.lua

module("modules.logic.versionactivity1_4.act131.view.Activity131LogView", package.seeall)

local Activity131LogView = class("Activity131LogView", BaseView)

function Activity131LogView:onInitView()
	self._gobg = gohelper.findChild(self.viewGO, "#go_bg")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#go_btns/#btn_close")
	self._scrolllog = gohelper.findChildScrollRect(self.viewGO, "#scroll_log")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity131LogView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function Activity131LogView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function Activity131LogView:_btncloseOnClick()
	self:closeThis()
end

function Activity131LogView:_editableInitView()
	self.goEmpty = gohelper.findChild(self.viewGO, "Empty")
	self.goChapterRoot = gohelper.findChild(self.viewGO, "Left/scroll_chapterlist/viewport/content")

	local logCategortList = Activity131Model.instance:getLogCategortList()

	if #logCategortList > 0 then
		Activity131Model.instance:setSelectLogType(logCategortList[1].logType)
	end

	local resPtah = self.viewContainer:getSetting().otherRes[2]

	for _, v in ipairs(logCategortList) do
		local go = self:getResInst(resPtah, self.goChapterRoot)
		local item = MonoHelper.addNoUpdateLuaComOnceToGo(go, Activity131LogCategoryItem)

		item:setInfo(v.logType)
	end
end

function Activity131LogView:onOpen()
	Activity131Controller.instance:registerCallback(Activity131Event.SelectCategory, self._onSelectCategoryChange, self)
	self:_refreshView()
end

function Activity131LogView:onClose()
	Activity131Controller.instance:unregisterCallback(Activity131Event.SelectCategory, self._onSelectCategoryChange, self)
end

function Activity131LogView:onDestroyView()
	return
end

function Activity131LogView:_refreshView()
	local logList = Activity131Model.instance:getLog()

	Activity131LogListModel.instance:setLogList(logList)

	self._scrolllog.verticalNormalizedPosition = 0

	gohelper.setActive(self.goEmpty, not next(logList))
end

function Activity131LogView:_onSelectCategoryChange()
	self:_refreshView()
end

return Activity131LogView
