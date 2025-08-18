-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityBingoAwardChoosePanel.lua

local ResOpActivityBingoBigReward = require("ClientData/ResOpActivityBingoBigReward")
local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local ResColor = require("ClientData/ResColor")
local AwardItem = Class("AwardItem", UIControls.Child)

function AwardItem:ctor()
	self.imgNum = UIControls.Image(self, "BgText")
	self.txtNum = UIControls.Label(self, "BgText/TextNum")
	self.imgSelect = UIControls.Image(self, "ImgCheck")
	self.txtRounds = UIControls.Label(self, "TextRounds")
	self.efxQuality = UIControls.LazyEffectPlayer(self, "EfxQualityPanel")
end

function AwardItem:setData(data, awardStateData, isNew)
	self.data = data

	local hasGetTime = awardStateData[data.index] and awardStateData[data.index].times or 0

	self.txtNum:setText(data.max_get_times - hasGetTime .. "/" .. data.max_get_times)

	local item = BaseObject.GetObject(data.item_id, data.item_num)

	if not self.awardItem then
		self.awardItem = UIControls.getGridAwardContainer(self, "GridPanel")

		self.awardItem:setVisible(true)
	end

	self.awardItem:setObj(item)

	local awardGrid = self.awardItem.grid

	awardGrid.mDisableWays = true
	awardGrid.isShowPreviewTips = true
	awardGrid.mEventClick = nil
	awardGrid.mEnableTips = false

	awardGrid:setVisible(true)

	if awardGrid.imgNew then
		awardGrid.imgNew:setVisible(isNew and not data.isLock and data.validState ~= 0)
	end

	if data.isLock == true then
		awardGrid.mEnableTips = true

		awardGrid:setIconGray(true)

		awardGrid.mEventClick = Slot(self.onClick, self)

		self.imgNum:setVisible(false)
		self.txtRounds:setVisible(true)
		self.txtRounds:setText(string.format(Lang.get(30600), data.unlock_round))
	else
		self.txtRounds:setVisible(false)
		self.imgNum:setVisible(true)

		if data.validState == 0 then
			awardGrid.mEnableTips = true

			self.txtNum:setFontColor(ResColor.RED)
			awardGrid:setIconGray(true)
		else
			self.txtNum:setFontColor(ResColor.WHITE)

			awardGrid.mEnableTips = false

			awardGrid:setIconGray(false)

			awardGrid.mEventClick = Slot(self.onClick, self)
		end
	end

	if data.efx_tag and data.efx_tag == 1 then
		self.efxQuality:setVisible(true)
		self.efxQuality:playEffect()
	else
		self.efxQuality:setVisible(false)
	end
end

function AwardItem:setSelect(isSel)
	self.imgSelect:setVisible(isSel)
end

function AwardItem:onClick()
	if self.data.isLock == true then
		local unlockTime = self.mParent.actData:getDayUnlockTime(self.data)

		if unlockTime > 0 then
			MsgManager.notice(string.format(Lang.get(30599), utils.calcTimeTxt(unlockTime)))
		else
			MsgManager.notice(string.format(Lang.get(30601), self.data.unlock_round))
		end
	else
		self.mParent:chooseFinalAward(self)
		self:setSelect(true)
	end
end

local RoundTabCell = Class("RoundTabCell", UIControls.Button)

function RoundTabCell:ctor()
	self.textTime = UIControls.Label(self, self.mPath .. "/TextTime")
	self.iconNew = UIControls.Panel(self, self.mPath .. "/IconNewOpen")
end

function RoundTabCell:setData(unlockTime, hasNew)
	if unlockTime > 0 then
		self.textTime:setVisible(true)
		ClientTimerManager.AddSecondFormatTickUI(self.textTime, unlockTime, nil, Lang.get(48676))
	else
		self.textTime:setVisible(false)
		ClientTimerManager.RemoveSecondTickUI(self.textTime)
	end

	self.iconNew:setVisible(hasNew)
end

local strClassName = "ActivityBingoAwardChoosePanel"
local ActivityBingoAwardChoosePanel = Class(strClassName, UIControls.Window)

MixinClass(ActivityBingoAwardChoosePanel, ActivityPanelMixin)

function ActivityBingoAwardChoosePanel:initUI()
	self.finalChoose = nil
	self.cells = {}
	self.btnClose = UIControls.Button(self, "BtnClose")
	self.btnCancel = UIControls.Button(self, "MainInfoPanel/BtnClose")
	self.btnConfirm = UIControls.Button(self, "MainInfoPanel/BtnConfirm")

	self.btnClose:addEventClick(self.onClickCancel)
	self.btnCancel:addEventClick(self.onClickCancel)
	self.btnConfirm:addEventClick(self.onClickConfirm)

	if UIControls.checkControlFunc(self, "MainInfoPanel/TabPanel") then
		self.panelTab = UIControls.Panel(self, "MainInfoPanel/TabPanel")
		self.tabCells = {}

		for index = 1, 2 do
			local newCell = RoundTabCell(self, "MainInfoPanel/TabPanel/BtnTab" .. index)

			newCell:addEventClick(self.onClickTab)

			newCell.tabIndex = index

			table.insert(self.tabCells, newCell)
		end
	end
end

function ActivityBingoAwardChoosePanel:onClickTab(sender)
	for index, cell in ipairs(self.tabCells) do
		cell:setEnable(cell ~= sender)
	end

	self.nowTab = sender.tabIndex
	self.data = self.lockDayData[self.nowTab][2]

	self:setItems()
end

function ActivityBingoAwardChoosePanel:setData(finalId, serverData, actId, gridId, actObj)
	self.gridId = gridId

	self:onShowActivity({
		actObj.clientTemplateData,
		actObj
	})
	self:_realSetData(finalId, serverData, actId, gridId, actObj.actData)
end

function ActivityBingoAwardChoosePanel:_realSetData(finalId, serverData, actId, gridId, actData)
	self.gridId = gridId
	self.round = serverData.round
	self.rewarded = serverData.rewarded
	self.actId = actId
	self.actData = actData
	self.data = ResOpActivityBingoBigReward[finalId]

	if serverData.big_reward_id ~= 0 then
		self:setCurAward(serverData.big_reward_id, gridId)

		self.finalChoose = serverData.big_reward_id
	end

	self.lockDayData = actData:getUnlockDayBigAwardData()
	self.markNewRound, self.markNewDay = actData:getBingoNewInfo()
	self.nowNewRound = self.markNewRound
	self.nowNewDay = self.markNewDay

	if self.lockDayData and self.panelTab then
		self.panelTab:setVisible(true)

		self.nowTab = 1

		for tabIndex, dData in ipairs(self.lockDayData) do
			for index, awardData in ipairs(dData[2]) do
				if awardData.index == self.finalChoose then
					self.nowTab = tabIndex

					break
				end
			end
		end

		for index, cell in ipairs(self.tabCells) do
			local hasNew = false
			local dayData = self.lockDayData[index]

			if dayData then
				dayData = dayData[2]

				for _, awardData in ipairs(dayData) do
					if self.actData:isAwardValid(awardData) and (awardData.unlock_round > self.markNewRound or awardData.unlock_day and awardData.unlock_day > self.markNewDay) then
						hasNew = true

						break
					end
				end

				cell:setVisible(true)
				cell:setData(self.actData:getDayUnlockTime(dayData[1]), hasNew)
				cell:setEnable(cell.tabIndex ~= self.nowTab)
			else
				cell:setVisible(false)
			end
		end

		self.data = self.lockDayData[self.nowTab][2]
	end

	self:setItems()
end

function ActivityBingoAwardChoosePanel:setItems()
	local maxRound = 1
	local maxDay = 1
	local awardList = {}

	for _, data in ipairs(self.data) do
		if self.actData:isAwardValid(data) then
			data.isLock = false

			if maxRound < data.unlock_round then
				maxRound = data.unlock_round
			end

			if data.unlock_day and maxDay < data.unlock_day then
				maxDay = data.unlock_day
			end
		else
			data.isLock = true
		end

		if not self.rewarded[data.index] or not self.rewarded[data.index].times or not (self.rewarded[data.index].times >= data.max_get_times) then
			data.validState = 1
		else
			data.validState = 0
		end

		table.insert(awardList, data)
	end

	table.sort(awardList, function(a, b)
		if a.validState ~= b.validState then
			return a.validState > b.validState
		elseif a.unlock_round ~= b.unlock_round then
			return a.unlock_round < b.unlock_round
		else
			return a.index < b.index
		end
	end)

	for index = #self.cells + 1, #awardList do
		local newCell = AwardItem(self, "MainInfoPanel/AwardChooseList/Content", "System/Activity/ActivityBingo/GridBingoAward")

		table.insert(self.cells, newCell)
	end

	self.curChoose = nil

	for i, cell in ipairs(self.cells) do
		local awardData = awardList[i]

		if awardData then
			local isNew = awardData.unlock_round > self.markNewRound or awardData.unlock_day and awardData.unlock_day > self.markNewDay

			cell:setData(awardData, self.rewarded, isNew)
			cell:setVisible(true)

			if self.finalChoose and awardData.index == self.finalChoose then
				cell:setSelect(true)

				self.curChoose = cell
			else
				cell:setSelect(false)
			end
		else
			cell:setVisible(false)
		end
	end

	local markNew = maxRound > self.nowNewRound or maxDay > self.nowNewDay

	if markNew then
		self.nowNewRound = math.max(maxRound, self.nowNewRound)
		self.nowNewDay = math.max(maxDay, self.nowNewDay)

		self.actData:setBingoNewInfo(self.nowNewRound, self.nowNewDay)

		local activityBingoDlg = UIManager.tryGetUI("activityBingoDlg")

		if activityBingoDlg then
			activityBingoDlg:refreshPanel()
		end
	end
end

function ActivityBingoAwardChoosePanel:setCurAward(id, gridId)
	local awardInfo

	for _, data in ipairs(self.data) do
		if id == data.index then
			awardInfo = data

			break
		end
	end

	if not awardInfo then
		return
	end

	if self.curAwardItem then
		self.curAwardItem:destroy()

		self.curAwardItem = nil
	end

	local item = BaseObject.GetObject(awardInfo.item_id, awardInfo.item_num)
	local awardItem = UIControls.getGridAwardContainer(self, "MainInfoPanel/FinalAwardPanel")

	awardItem.mDisableWays = true
	awardItem.isShowPreviewTips = true

	if gridId then
		awardItem:setContainerConfig(gridId)
	end

	awardItem:setObj(item)
	awardItem:setVisible(true)
	awardItem:setNumColor(1)

	self.curAwardItem = awardItem
end

function ActivityBingoAwardChoosePanel:chooseFinalAward(award)
	if self.curChoose then
		self.curChoose:setSelect(false)
	end

	self.curChoose = award
	self.finalChoose = award.data.index

	self:setCurAward(award.data.index, self.gridId)
end

function ActivityBingoAwardChoosePanel:onClickConfirm()
	if self.finalChoose == nil then
		MsgManager.notice(Lang.get(30603))
	else
		CurAvatar:activityRPC(Functor(RPC.bingoSetBigReward, self.actId, self.finalChoose), self.actId)
		self:setVisible(false)
	end
end

function ActivityBingoAwardChoosePanel:onClickCancel()
	self:setVisible(false)
end

return ActivityBingoAwardChoosePanel
