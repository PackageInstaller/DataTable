-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\CircleBattleActionRecordDlg.lua

local ActionRecordCell = require("UI/Circle/ActionRecordCell")
local strClassName = "CircleBattleActionRecordDlg"
local CircleBattleActionRecordDlg = Class(strClassName, UIControls.Window)

function CircleBattleActionRecordDlg:ctor()
	self:initUI()
end

local OPTION_ALL = 1
local OPTION_SEARCH = 2
local OPTION_BATTLE = 3

function CircleBattleActionRecordDlg:initUI()
	self.filterOptionList = {}

	for i = 1, 3 do
		local option = UIControls.Toggle(self, "Bg/FilterPanel/Option" .. i)

		option:addEventValueChanged(Slot(self.onDataToggleChange, self))
		option:setEnable(false)

		self.filterOptionList[i] = option
	end

	self.txtTips = UIControls.Label(self, "Bg/TextTips")

	self.txtTips:setText(ClientUtils.getClientNotice(550))

	self.scrollActionCells = {}
	self.scrollActionRecord = UIControls.ScrollViewLoopV(self, "Bg/ActionRecordList")

	self.scrollActionRecord:addEventCellChanged(self.onActionRecordChanged)

	if CurAvatar.myCircle then
		self.actionRecordDataList = CurAvatar:tryGetActionRecordDataList()

		if self.actionRecordDataList then
			self.filterOptionList[1]:setOn(true)
		end
	end
end

function CircleBattleActionRecordDlg:onDataToggleChange(table, toggle, isOn)
	local refreshOtherToggle = false

	for option, _toggle in ipairs(self.filterOptionList) do
		if toggle == _toggle and isOn then
			toggle:setEnable(false)
			self:filterActionRecord(option)

			if self.filterRecordDataList then
				self.scrollActionRecord:setTotalCount(#self.filterRecordDataList)
			end

			refreshOtherToggle = true
		end
	end

	if refreshOtherToggle then
		for option, _toggle in ipairs(self.filterOptionList) do
			if _toggle ~= toggle then
				_toggle:setOnVoidUnChange(false)
				_toggle:setEnable(true)
			end
		end
	end
end

function CircleBattleActionRecordDlg:filterActionRecord(option)
	if self.actionRecordDataList then
		self.filterRecordDataList = {}

		if option == OPTION_ALL then
			self.filterRecordDataList = self.actionRecordDataList
		elseif option == OPTION_SEARCH then
			for _, recordData in ipairs(self.actionRecordDataList) do
				if recordData.type == Const.CIRCLE_ACTION_RECORD_TYPE.SEARCH or recordData.type == Const.CIRCLE_ACTION_RECORD_TYPE.SKILL then
					table.insert(self.filterRecordDataList, recordData)
				end
			end
		else
			for _, recordData in ipairs(self.actionRecordDataList) do
				if recordData.type == Const.CIRCLE_ACTION_RECORD_TYPE.BATTLE then
					table.insert(self.filterRecordDataList, recordData)
				end
			end
		end
	end
end

function CircleBattleActionRecordDlg:onActionRecordChanged(sender, targetCell, newIdx)
	targetCell = targetCell or ActionRecordCell(sender, "System/CircleBattle/ActionRecordCell", newIdx)

	if not self.filterRecordDataList or #self.filterRecordDataList == 0 then
		return
	end

	if self.filterRecordDataList[newIdx] ~= nil then
		targetCell:setActionRecordData(self.filterRecordDataList[newIdx], newIdx)
	end

	self.scrollActionCells[newIdx] = targetCell
end

function CircleBattleActionRecordDlg:setActionRecordDataList(actionRecordDataList)
	if CurAvatar.myCircle then
		self.actionRecordDataList = actionRecordDataList

		self.filterOptionList[1]:setOn(true)
		self:onDataToggleChange(nil, self.filterOptionList[1], true)
	end
end

return CircleBattleActionRecordDlg
