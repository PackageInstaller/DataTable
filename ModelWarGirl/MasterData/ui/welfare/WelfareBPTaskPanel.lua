-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Welfare\\WelfareBPTaskPanel.lua

local welfareBase = require("UI/Welfare/WelfarePanelBase")
local ResBattlePassTask = require("ClientData/ResBattlePassTask")
local RPC = require("Framework/RPC")
local ResRandClient = require("ClientData/ResRandClient")
local ResBattlePassMisc = require("ClientData/ResBattlePassMisc")
local ResColor = require("ClientData/ResColor")
local ResClientNotice = require("ClientData/ResClientNotice")
local ResBattlePassLevel = require("ClientData/ResBattlePassLevel")
local BPTaskCell = Class("BPTaskCell", UIControls.ScrollViewLoopCell)
local SOURCR_INFO = {
	{
		"BgLongBottom3",
		"BgLongBottom3R"
	},
	{
		"BgLongBottom2",
		"BgLongBottom2R"
	},
	{
		"BgLongBottom1",
		"BgLongBottom1R"
	}
}

function BPTaskCell:ctor()
	self.imgBg = UIControls.Image(self, "Bg")
	self.imgBgRight = UIControls.Image(self, "Bg/BgRight")
	self.slider = UIControls.Slider(self, "Bg/Slider", "TextProgress")

	self.slider:setEnable(false)

	self.txtRule = UIControls.Label(self, "Bg/TextRule", true)
	self.singlePanel = UIControls.Panel(self, "Bg/SinglePanel")
	self.btnGoS = UIControls.Button(self, "Bg/SinglePanel/BtnGo")
	self.btnConfirmS = UIControls.Button(self, "Bg/SinglePanel/BtnConfirm")
	self.txtStateS = UIControls.Label(self, "Bg/SinglePanel/TextState")
	self.iconNewS = UIControls.Panel(self, "Bg/SinglePanel/BtnConfirm/IconNew")
	self.multiPanel = UIControls.Panel(self, "Bg/MultiPanel")
	self.btnGoM = UIControls.Button(self, "Bg/MultiPanel/BtnGo")
	self.btnConfirmM = UIControls.Button(self, "Bg/MultiPanel/BtnConfirm")
	self.iconNewM = UIControls.Panel(self, "Bg/MultiPanel/BtnConfirm/IconNew")
	self.txtStateM = UIControls.Label(self, "Bg/MultiPanel/TextState")
	self.txtLimit = UIControls.Label(self, "Bg/MultiPanel/TextLimit")
	self.outAnim = UIControls.UIAni(self, "")

	self.btnGoS:addEventClick(self.onBtnGo)
	self.btnGoM:addEventClick(self.onBtnGo)
	self.btnConfirmS:addEventClick(self.onBtnConfirm)
	self.btnConfirmM:addEventClick(self.onBtnConfirm)

	self.items = {}
	self.onlyAttrs = true
	self.isLastGet = false
end

function BPTaskCell:setData(data, srvData, isMaxProgress)
	self.outAnim:startAni("FadeResetStoreBPGetCell")

	self.data = data

	self.btnGoS:setVisible(false)
	self.btnConfirmS:setVisible(false)
	self.txtStateS:setVisible(false)
	self.btnGoM:setVisible(false)
	self.btnConfirmM:setVisible(false)
	self.txtStateM:setVisible(false)

	for _, item in ipairs(self.items) do
		item:destroy()
	end

	self.items = {}

	local taskAward = srvData.taskData[data.task_id] and srvData.taskData[data.task_id].award_time or 0
	local actionType = data.task_type
	local taskCurValue = srvData.progress[actionType] and srvData.progress[actionType].value or 0

	self.txtRule:setText(data.task_desc)
	self.slider:setText(string.format("%s/%s", taskCurValue, data.task_param))

	local value = taskCurValue / data.task_param >= 1 and 1 or taskCurValue / data.task_param

	self.slider:setValue(value, nil, true)

	if taskAward == data.can_get_count - 1 then
		self.isLastGet = true
	else
		self.isLastGet = false
	end

	local isMuti = data.can_get_count > 1

	if isMuti then
		self.multiPanel:setVisible(true)
		self.singlePanel:setVisible(false)
		self.txtLimit:setText(utils.format(Lang.get(30598), taskAward, data.can_get_count))

		if data.task_param == 1 then
			self.slider:setText(string.format("%s/%s", 0, data.task_param))
			self.slider:setValue(0, nil, true)
		end
	else
		self.multiPanel:setVisible(false)
		self.singlePanel:setVisible(true)
	end

	local state = 1

	self.slider:setVisible(true)

	if srvData.taskHasGet[data.task_id] then
		self.txtStateS:setVisible(true)
		self.txtStateM:setVisible(true)
		self.slider:setVisible(false)

		state = 3
	elseif srvData.taskCanGet[data.task_id] then
		self.btnConfirmS:setVisible(true)
		self.btnConfirmM:setVisible(true)
		self.slider:setText(string.format("%s/%s", data.task_param, data.task_param))
		self.slider:setValue(1, nil, true)

		state = 2
	elseif data.jump_id then
		self.btnGoS:setVisible(true)
		self.btnGoM:setVisible(true)
	end

	self:changeSource(state)

	if data.award then
		local awardData = ResRandClient[data.award]
		local items = awardData.show_ids

		for idx, id in ipairs(items) do
			if not (id >= 100000) or not (id < 200000) then
				self.onlyAttrs = false
			end

			local item = BaseObject.GetObject(id, awardData.show_nums[idx])

			self.items[idx] = UIControls.getGridChild(item, self, "Bg/GridAward")

			self.items[idx]:setVisible(true)

			self.items[idx].mDisableWays = true
			self.items[idx].isShowPreviewTips = true

			self.items[idx]:setObj(item)
			self.items[idx]:setIconGray(state == 3)
		end

		if not isMaxProgress then
			self:setRedIconState(isMuti, true)
		elseif #items == 1 and items[1] == Const.MONEY_ID_BP then
			self:setRedIconState(isMuti, false)
		else
			self:setRedIconState(isMuti, true)
		end
	end
end

function BPTaskCell:setRedIconState(isMult, isShow)
	if isMult then
		self.iconNewM:setVisible(isShow)
	else
		self.iconNewS:setVisible(isShow)
	end
end

function BPTaskCell:onBtnGo()
	if self.mGoEventClick then
		self.mGoEventClick(self.data.jump_id)
	end
end

function BPTaskCell:onBtnConfirm()
	self:getAwardCB()

	if self.mConfirEventClick then
		self.mConfirEventClick(self.data.task_id)
	end
end

function BPTaskCell:changeSource(state)
	self.imgBg:setImage("Atlas/StoreAtlas/StoreBPAtlas", SOURCR_INFO[state][1])
	self.imgBgRight:setImage("Atlas/StoreAtlas/StoreBPAtlas", SOURCR_INFO[state][2])
end

function BPTaskCell:getAwardCB()
	self.btnConfirmS:setVisible(false)
	self.btnConfirmM:setVisible(false)

	local aniName = self.isLastGet == true and "FadeStoreBPGetCell" or "ChangeStoreBPGetCell"

	self.outAnim:startAni(aniName)

	if self.onlyAttrs == true then
		for idx, item in pairs(self.items) do
			if BaseObject.isAttrs(item.object.id) then
				item:flyToCommonFuncEntryPanel()
			end
		end
	end
end

local strClassName = "WelfareBPTaskPanel"
local WelfareBPTaskPanel = Class(strClassName, welfareBase)

function WelfareBPTaskPanel:ctor()
	self.cells = {}
	self.curGroup = {}
	self._slot4CellGo = Slot(self.onCellGo, self)
	self._slot4CellConfirm = Slot(self.onCellConfirm, self)

	self:initUI()
end

function WelfareBPTaskPanel:initUI()
	self.scrollItems = UIControls.ScrollViewLoopV(self, "BPGetList", 0, self._onCellChanged)
	self.txtTime = UIControls.Label(self, "TipsPanel/TextTime")
	self.txtTip = UIControls.Label(self, "TipsPanel/TextDes")

	self.txtTip:setText(ResClientNotice[250].notice)
end

function WelfareBPTaskPanel:onOpenPanel()
	self.showGroupList = {}
	self.srvData = CurAvatar:getBpServerData()
	self.step = self.srvData.step
	self.isMaxProgress = self.srvData.curValue >= ResBattlePassLevel[#ResBattlePassLevel][1].bp_need

	for idx, info in ipairs(ResBattlePassTask) do
		local data = info[self.step]

		if not data then
			return
		end

		if not self.showGroupList[data.group_id] then
			self.showGroupList[data.group_id] = {}
		end

		local mData = {}

		mData.id = data.task_id
		mData.state = 0

		table.insert(self.showGroupList[data.group_id], mData)
	end

	self:refreshData()
end

function WelfareBPTaskPanel:refreshData()
	if not self.srvData.systemData then
		return
	end

	local groupId = self.panelConfigData.arg1

	self.curGroup = self.showGroupList[groupId]
	self.lastTime = self.srvData.systemData.end_time - ClientUtils.getServerTime()

	ClientTimerManager.RemoveSecondTickUI(self.txtTime)
	ClientTimerManager.AddSecondFormatTickUI(self.txtTime, self.lastTime, nil, Lang.get(48695), Slot(self.timeDownCB, self))

	local speedUpLimit = ResBattlePassMisc[1].bp_buy_day

	if speedUpLimit >= self.lastTime / 86400 then
		self.txtTime:setFontColor(ResColor.RED)
	else
		self.txtTime:setFontColor(ResColor.WHITE)
	end

	for k, data in ipairs(self.curGroup) do
		local awardState = 2

		if self.srvData.taskCanGet[data.id] == true then
			awardState = 1
		end

		if self.srvData.taskHasGet[data.id] == true then
			awardState = 3
		end

		self.curGroup[k].state = awardState
	end

	table.sort(self.curGroup, function(a, b)
		if a.state == b.state then
			return a.id < b.id
		else
			return a.state < b.state
		end
	end)
	self.scrollItems:setTotalCount(#self.curGroup, nil, false)
end

function WelfareBPTaskPanel:_onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = BPTaskCell(sender, "System/Store/StoreBPGetCell", newIdx, 0, 0)
	else
		self.cells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	self.cells[newIdx] = targetCell

	local data = ResBattlePassTask[self.curGroup[newIdx].id][self.step]

	self.cells[newIdx]:setData(data, self.srvData, self.isMaxProgress)

	self.cells[newIdx].mGoEventClick = self._slot4CellGo
	self.cells[newIdx].mConfirEventClick = self._slot4CellConfirm
end

function WelfareBPTaskPanel:timeDownCB()
	ClientTimerManager.RemoveSecondTickUI(self.txtTime)
end

function WelfareBPTaskPanel:onCellGo(jumpId)
	JumpGuideManager.jump(jumpId)
end

function WelfareBPTaskPanel:onCellConfirm(taskId)
	RPC.battlePassGetTaskAward(taskId)
end

function WelfareBPTaskPanel:onClosePanel()
	WelfareBPTaskPanel.super.onClosePanel(self)
end

function WelfareBPTaskPanel:onDestroy()
	ClientTimerManager.RemoveSecondTickUI(self.txtTime)
end

return WelfareBPTaskPanel
