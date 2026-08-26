-- chunkname: @modules/logic/autochess/main/view/AutoChessFriendBattleRecordView.lua

module("modules.logic.autochess.main.view.AutoChessFriendBattleRecordView", package.seeall)

local AutoChessFriendBattleRecordView = class("AutoChessFriendBattleRecordView", BaseView)

function AutoChessFriendBattleRecordView:onInitView()
	self._recordItemRoot = gohelper.findChild(self.viewGO, "#scroll_record/viewport/content")
	self._goRecordItem = gohelper.findChild(self.viewGO, "#scroll_record/viewport/content/#go_recorditem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AutoChessFriendBattleRecordView:addEvents()
	return
end

function AutoChessFriendBattleRecordView:removeEvents()
	return
end

function AutoChessFriendBattleRecordView:onClickBattleRecord()
	return
end

function AutoChessFriendBattleRecordView:onClickFriendList()
	return
end

function AutoChessFriendBattleRecordView:onClickModalMask()
	self:closeThis()
end

function AutoChessFriendBattleRecordView:_editableInitView()
	return
end

function AutoChessFriendBattleRecordView:onUpdateParam()
	return
end

function AutoChessFriendBattleRecordView:onOpen()
	self._actId = Activity182Model.instance:getCurActId()

	local actInfo = Activity182Model.instance:getActMo(self._actId)
	local friendFightRecords = actInfo:getFriendFightRecords()

	self._recordDataList = {}

	for idx, fightRecord in ipairs(friendFightRecords) do
		self._recordDataList[#friendFightRecords - idx + 1] = fightRecord
	end

	self:_createRecordItems()
end

function AutoChessFriendBattleRecordView:_createRecordItems()
	self._recordItemDict = {}

	gohelper.CreateObjList(self, self._createRecordItem, self._recordDataList, self._recordItemRoot, self._goRecordItem, AutoChessBattleRecordItem)
end

function AutoChessFriendBattleRecordView:_createRecordItem(recordItemComp, recordData, index)
	recordItemComp:onUpdateData(recordData)
end

function AutoChessFriendBattleRecordView:onClose()
	return
end

function AutoChessFriendBattleRecordView:onDestroyView()
	return
end

return AutoChessFriendBattleRecordView
