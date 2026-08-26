-- chunkname: @modules/logic/versionactivity1_4/puzzle/view/Role37PuzzleRecordView.lua

module("modules.logic.versionactivity1_4.puzzle.view.Role37PuzzleRecordView", package.seeall)

local Role37PuzzleRecordView = class("Role37PuzzleRecordView", BaseView)

function Role37PuzzleRecordView:onInitView()
	self._btnCloseMask = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_CloseMask")
	self._txtTitle = gohelper.findChildText(self.viewGO, "Title/#txt_Title")
	self._scrollList = gohelper.findChildScrollRect(self.viewGO, "#scroll_List")
	self._goEmpty = gohelper.findChild(self.viewGO, "#go_Empty")
	self._txtEmpty = gohelper.findChildText(self.viewGO, "#go_Empty/#txt_Empty")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Role37PuzzleRecordView:addEvents()
	self._btnCloseMask:AddClickListener(self._btnCloseMaskOnClick, self)
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
end

function Role37PuzzleRecordView:removeEvents()
	self._btnCloseMask:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function Role37PuzzleRecordView:_btnCloseMaskOnClick()
	self:closeThis()
end

function Role37PuzzleRecordView:_btnCloseOnClick()
	self:closeThis()
end

function Role37PuzzleRecordView:_editableInitView()
	Role37PuzzleController.instance:registerCallback(Role37PuzzleEvent.RecordCntChange, self.onRecordChange, self)

	local cnt = PuzzleRecordListModel.instance:getCount()

	self:onRecordChange(cnt)
end

function Role37PuzzleRecordView:onDestroyView()
	Role37PuzzleController.instance:unregisterCallback(Role37PuzzleEvent.RecordCntChange, self.onRecordChange, self)
end

function Role37PuzzleRecordView:onRecordChange(cnt)
	gohelper.setActive(self._goEmpty, cnt <= 0)
end

return Role37PuzzleRecordView
