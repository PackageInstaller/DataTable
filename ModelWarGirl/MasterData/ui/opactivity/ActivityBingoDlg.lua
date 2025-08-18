-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityBingoDlg.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local ResRandClient = require("ClientData/ResRandClient")
local ResTigerBandit = require("ClientData/ResTigerBandit")
local ResOpActivityBingoMisc = require("ClientData/ResOpActivityBingoMisc")
local ResBingoRandomRule = require("ClientData/ResBingoRandomRule")
local ResBingoWeight = require("ClientData/ResBingoWeight")
local ResOpActivityBingoBigReward = require("ClientData/ResOpActivityBingoBigReward")
local CommonFuncEntryPanel = require("UI/MainMenu/CommonFuncEntryPanel")
local FlyIconUtils = require("UI/Common/FlyIconUtils")
local ResColor = require("ClientData/ResColor")
local UserData = require("Helper/UserData")
local ResItem = require("ClientData/ResItem")
local BingoCell = Class("BingoCell", UIControls.Child)
local RES_PATH = "Atlas/ActivityAtlas/"

function BingoCell:ctor()
	self.btn = UIControls.Button(self, "BeforePanel")

	if self.btn then
		self.btn:setEnable(false)
		self.btn:addEventClick(self.onClick)
	end

	self.panelbefore = UIControls.Panel(self, "BeforePanel")
	self.panelAfter = UIControls.Panel(self, "AfterPanel")
	self.imgReal = UIControls.Image(self, "AfterPanel/Bg")
	self.efxTurn = UIControls.LazyEffectPlayer(self, "EfxTurn")
	self.EfxRandom = UIControls.LazyEffectPlayer(self, "EfxRandom")
	self.EfxChoose = UIControls.LazyEffectPlayer(self, "EfxChoose")
	self.isGet = false
end

function BingoCell:setData(data, iconPath, round, num)
	self.round = round
	self.data = data

	local idx = self.data.index
	local strNum = idx < 10 and "0" .. idx or idx
	local resTexture = "/ActivityBingoAtlas" .. (self.round - 1) % num + 1
	local resPath = RES_PATH .. iconPath .. resTexture
	local resName = (self.round - 1) % num + 1 .. strNum

	self.imgReal:setImage(resPath, resName)
	self:setState(self.data.state)
end

function BingoCell:setState(state)
	if not self.panelbefore then
		return
	end

	if state ~= 0 then
		self.isGet = true

		self.panelbefore:setVisible(false)
		self.panelAfter:setVisible(true)
	else
		self.panelbefore:setVisible(true)
		self.panelAfter:setVisible(false)
	end
end

function BingoCell:setTurn(isTurn)
	if not self.panelAfter then
		return
	end

	if isTurn then
		self:playAni("GridBingoEfxTurn", nil, true)
	end
end

function BingoCell:setTurnOpen(isOpen)
	if not self.panelAfter then
		return
	end

	if isOpen then
		self:playAni("GridBingoEfxRandom", nil, true)
	end

	self.panelbefore:setVisible(not isOpen)
	self.panelAfter:setVisible(isOpen)

	local awardStr = ""

	if self.isGet == false and self.data.rand_id then
		local awardInfo = ResRandClient[self.data.rand_id]
		local name = ResItem[awardInfo.show_ids[1]].name

		FlyIconUtils.sendFlyEvent(self.imgReal, awardInfo.show_ids[1], awardInfo.show_nums[1])

		awardStr = name .. "*" .. awardInfo.show_nums[1]
	end

	if self.mParent.msicData.roll_award then
		local awardInfo = ResRandClient[self.mParent.msicData.roll_award]
		local name = ResItem[awardInfo.show_ids[1]].name

		FlyIconUtils.sendFlyEvent(self.imgReal, awardInfo.show_ids[1], awardInfo.show_nums[1])

		awardStr = awardStr .. "  " .. name .. "*" .. awardInfo.show_nums[1]
	end

	MsgManager.notice(string.format(Lang.get(30604), awardStr))
	self:setState(1)
end

function BingoCell:setToChoose(isChoose)
	self.btn:setEnable(isChoose)
	self.EfxChoose:setVisible(isChoose)

	if isChoose then
		self.EfxChoose:playEffect()
	end
end

function BingoCell:playTurnOnOpen()
	if not self.panelAfter then
		return
	end

	self:playAni("GridBingoSpin", nil, true)
end

function BingoCell:onClick()
	if self.mEvevtClick then
		self.mEvevtClick(self.data.index)
	end
end

local FinalAward = Class("FinalAward", UIControls.Panel)

function FinalAward:ctor()
	self.btn = UIControls.Button(self, self.mPath)

	self.btn:addEventClick(Slot(self.onClick, self))

	self.imgAdd = UIControls.Panel(self, self.mPath .. "/IconAdd")
	self.imgNew = UIControls.Panel(self, self.mPath .. "/IconNew")
	self.imgSwitch = UIControls.Panel(self, self.mPath .. "/ImgSwitch")
	self.panelAward = UIControls.Panel(self, self.mPath .. "/AwardPanel")
	self.imgNewOpen = UIControls.Panel(self, self.mPath .. "/IconNewOpen")
end

function FinalAward:setData(hasNew, gridId, state, finaleAwardData)
	self.state = state
	self.gridId = gridId

	self.imgAdd:setVisible(false)
	self.imgNew:setVisible(false)
	self.imgNewOpen:setVisible(hasNew)
	self.imgSwitch:setVisible(false)

	if state == 0 then
		self.imgAdd:setVisible(true)
		self.panelAward:setVisible(false)
	elseif state == 1 then
		if not hasNew then
			self.imgNew:setVisible(true)
		end

		self.imgAdd:setVisible(true)
		self.panelAward:setVisible(false)
	elseif state == 2 then
		self.imgSwitch:setVisible(not hasNew)
		self.panelAward:setVisible(true)
		self:setAward(finaleAwardData)
	end
end

function FinalAward:setAward(finaleAwardData)
	if self.awardItem then
		self.awardItem:destroy()

		self.awardItem = nil
	end

	local awardData = finaleAwardData
	local item = BaseObject.GetObject(awardData.item_id, awardData.item_num)

	self.awardItem = UIControls.getGridAwardContainer(self.mParent, self.mPath .. "/AwardPanel")

	self.awardItem:setVisible(true)
	self.awardItem:setContainerConfig(self.gridId)
	self.awardItem:setObj(item)
	self.awardItem:setNumColor(1)

	self.awardItem.grid.mEnableTips = false
	self.awardItem.grid.mDisableWays = true
	self.awardItem.grid.isShowPreviewTips = true
	self.awardItem.grid.mEventClick = Slot(self.onClick, self)
end

function FinalAward:onClick()
	if self.mEventClick then
		self:mEventClick()
	end
end

local CellAward = Class("CellAward", UIControls.Panel)

function CellAward:ctor()
	self.hasGet = false
	self.toGet = false
	self.state = 0
	self.includeChildsId = {}
	self.imgGet = UIControls.Image(self, self.mPath .. "/ImgDis")
	self.efxGetAward = UIControls.LazyEffectPlayer(self, self.mPath)
end

function CellAward:setData(data, includeChilds, gridId)
	self.data = data
	self.id = data.index
	self.includeChildsId = includeChilds

	local awardData = ResRandClient[data.rand_id]
	local item = BaseObject.GetObject(awardData.show_ids[1], awardData.show_nums[1])

	self.awardItem = UIControls.getGridAwardContainer(self.mParent, self.mPath .. "/GridAwardPanel")

	self.awardItem:setVisible(true)
	self.awardItem:setContainerConfig(gridId)
	self.awardItem:setObj(item)

	self.awardItem.grid.mDisableWays = true
	self.awardItem.grid.isShowPreviewTips = true
	self.awardItem.grid.mEventClick = Slot(self.onClick, self)

	self:refreshState(data.state)
end

function CellAward:refreshState(state)
	local isCHange = false

	if self.state then
		if self.state == state then
			return
		else
			isCHange = true
		end
	end

	self.state = state

	if state == 0 then
		self.awardItem:setNumColor(1)
	elseif state == 1 then
		if isCHange == true then
			self:playGetAnim()
		end

		self.hasGet = true

		self.awardItem:setNumColor(3)
		self.awardItem:setIconGray(true)
	else
		self.hasGet = true

		self.awardItem:setNumColor(3)
		self.awardItem:setIconGray(true)
		self.imgGet:setVisible(true)
	end
end

function CellAward:playGetAnim()
	self.efxGetAward:playEffect()
	self.imgGet:setVisible(true)
end

function CellAward:flyAward()
	self.awardItem.grid:flyToCommonFuncEntryPanel()

	local awardData = ResRandClient[self.data.rand_id]
	local name = ResItem[awardData.show_ids[1]].name
	local awardStr = name .. "*" .. awardData.show_nums[1]

	MsgManager.notice(string.format(Lang.get(30605), awardStr))
end

function CellAward:clearPanel()
	self.imgGet:setVisible(false)

	if self.awardItem then
		self.awardItem:destroy()

		self.awardItem = nil
	end
end

function CellAward:onClick()
	self.mParent:stopTargetRoll()
end

local strClassName = "ActivityBingoDlg"
local ActivityBingoDlg = Class(strClassName, UIControls.Window)

MixinClass(ActivityBingoDlg, ActivityPanelMixin)

local CellType = {
	Final = 5,
	Cell = 1,
	AwardCol = 3,
	AwardLine = 4,
	AwardRow = 2
}
local FinalAwardStateType = {
	toChoose = 0,
	hasChoose = 2,
	enoughChoose = 1
}
local DEAW_TYPW = {
	rand = "kBingoDrawTypeRand",
	target = "kBingoDrawTypePoint"
}
local CELL_LINE_TYPE_EQUAL = 1
local CELL_LINE_TYPE_SUB = 2

function ActivityBingoDlg:ctor()
	self.cells = {}
	self.cellsR = {}
	self.cellsC = {}
	self.cellsL = {}
	self.cellsAwardR = {}
	self.cellsAwardC = {}
	self.cellFinalAward = {}
	self.lotteryGotList = {}
	self.toShowFinalAward = false
	self.cellObjs = {}
	self.cellAwardObjs = {}
	self.finalAward = {}
	self.maxNum = 4
	self.maxCount = self.maxNum * self.maxNum
	self.slotOfRoll = Slot(self.rollFunc, self)
	self.finalAwardState = FinalAwardStateType.toChoose
	self.rollCDTimer = Timer.New(Slot(self.onRollCDTimerEnd, self), 0.5)
	self.resultList = {}
	self.coOnGetAwards = {}
end

function ActivityBingoDlg:onOpen()
	ActivityBingoDlg.super.onOpen(self)

	if self.msicData then
		self:checkMoneyEnough()
		self:refreshPanel()
	end
end

function ActivityBingoDlg:initUI()
	self.panelFund = CommonFuncEntryPanel(self, "CommonFuncEntryPanel", "System/MainMenu/CommonFuncEntryPanel", 0, 0, true)
	self.textTime = UIControls.Label(self, "MainInfoPanel/BgTime/TextTime")
	self.txtRounds = UIControls.Label(self, "MainInfoPanel/TextRounds")
	self.btnConfirm = UIControls.Button(self, "MainInfoPanel/BtnRandom")
	self.imgBtncfmIcon = UIControls.Image(self, "MainInfoPanel/BtnRandom/Icon")
	self.imgBtncfmNew = UIControls.Image(self, "MainInfoPanel/BtnRandom/IconNew")
	self.txtBtn = UIControls.Label(self, "MainInfoPanel/BtnRandom/TextNum")
	self.txtBtnRed = UIControls.Label(self, "MainInfoPanel/BtnRandom/TextNumRed")

	self.btnConfirm:addEventClick(self.onClickRoll)

	self.btnSpeConfirm = UIControls.Button(self, "MainInfoPanel/BtnSpecific", "TextNum")

	self.btnSpeConfirm:setVisible(false)

	self.imgBtnSpeIcon = UIControls.Image(self, "MainInfoPanel/BtnSpecific/Icon")
	self.imgBtnSpeNew = UIControls.Image(self, "MainInfoPanel/BtnSpecific/IconNew")

	self.btnSpeConfirm:addEventClick(self.onClickTargetRoll)

	self.btnBlock = UIControls.Button(self, "MainInfoPanel/Block")

	self.btnBlock:addEventClick(self.onBlockClick)

	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnClose)

	self.finalAward = FinalAward(self, "MainInfoPanel/BtnFinalAward")
	self.finalAward.mEventClick = Slot(self.onClickFinal, self)
	self.audioPanel = UIControls.LazyAudioPlayer(self, "MainInfoPanel/AudioLine")
	self.txtCrit = UIControls.Label(self, "MainInfoPanel/CritPanel/ImgLucky/TextNum")
end

function ActivityBingoDlg:_setData()
	self.actId = self.actObj.actId
	self.detailData = self.actObj.actData.clientData
	self.serverData = self.actObj.actData.serverData
	self.round = self.serverData.round
	self.gridId = self.actObj.clientTemplateData.grid_id or nil
	self.msicData = ResOpActivityBingoMisc[self.actObj.actId]

	if self.msicData.target_item_id then
		self.hasTargetItem = true
	else
		self.hasTargetItem = false
	end

	local itemPath = BaseObject.getItemIconPath(self.msicData.rand_item_id)

	self.imgBtncfmIcon:setImage(itemPath[1], itemPath[2])
	self.txtBtn:setText(self.msicData.rand_item_cost)
	self.txtBtnRed:setText(self.msicData.rand_item_cost)

	if self.hasTargetItem then
		local speMoneyInfo = BaseObject.getItemIconPath(self.msicData.target_item_id)

		self.imgBtnSpeIcon:setImage(speMoneyInfo[1], speMoneyInfo[2])
		self.btnSpeConfirm:setText(self.msicData.target_item_cost)
	end

	self:clearGrids()
	self:checkMoneyEnough()
	self:refreshPanel()
	self:_refreshCells()
	self:_refreshCellsUI()
end

function ActivityBingoDlg:onUpdateItemChanged()
	self:checkMoneyEnough()
	self:refreshPanel()
end

function ActivityBingoDlg:clearGrids()
	if #self.cellObjs > 0 then
		for _, cell in ipairs(self.cellObjs) do
			cell:destroy()
		end

		self.cells = {}
		self.cellObjs = {}
	end
end

function ActivityBingoDlg:checkItemEnough()
	local randItemId = self.msicData.rand_item_id
	local randItemNeed = self.msicData.rand_item_cost
	local itemNum = CurAvatar:getItemNumById(randItemId)

	if itemNum and randItemNeed <= itemNum then
		self.randItemEnough = true
	else
		self.randItemEnough = false
	end

	local targetItemId = self.msicData.target_item_id
	local targetItemNeed = self.msicData.target_item_cost

	if targetItemId then
		local tgtItemNum = CurAvatar:getItemNumById(targetItemId)

		if targetItemNeed <= tgtItemNum then
			self.targetItemEnough = true
		else
			self.targetItemEnough = false
		end
	end
end

function ActivityBingoDlg:checkMoneyEnough()
	self:checkItemEnough()

	if self.randItemEnough then
		self.imgBtncfmNew:setVisible(true)
		self.txtBtnRed:setVisible(false)
		self.txtBtn:setVisible(true)
	else
		self.imgBtncfmNew:setVisible(false)
		self.txtBtnRed:setVisible(true)
		self.txtBtn:setVisible(false)
	end

	if self.targetItemEnough then
		self.imgBtnSpeNew:setVisible(true)
		self.btnSpeConfirm:setFontColor(ResColor.WHITE)
	else
		self.imgBtnSpeNew:setVisible(false)
		self.btnSpeConfirm:setFontColor(ResColor.RED)
	end
end

function ActivityBingoDlg:toNextRound()
	self.serverData = self.actObj.actData.serverData
	self.round = self.serverData.round

	for _, cell in ipairs(self.cellObjs) do
		cell:destroy()
	end

	self.cellObjs = {}

	for k, awardCell in pairs(self.cellAwardObjs) do
		awardCell:clearPanel()
	end

	self.cellAwardObjs = {}

	for i, data in ipairs(self.cells) do
		data.state = 0
	end

	self.lotteryGotList = {}

	self:refreshPanel()
	self:_refreshCellsUI()

	self.isOnRandLock = false
end

function ActivityBingoDlg:refreshPanel()
	self.serverData = self.actObj.actData.serverData

	self.txtRounds:setText(string.format(Lang.get(30606), self.round))

	local finaleAwardId = self.serverData.big_reward_id

	if self.serverData.big_reward_id ~= 0 then
		local finalAwardGetTime = self.serverData.rewarded[finaleAwardId] and self.serverData.rewarded[finaleAwardId].times or 0
		local cangetTime = ResOpActivityBingoBigReward[self.msicData.final_award_id][finaleAwardId].max_get_times - finalAwardGetTime

		if cangetTime <= 0 then
			self:showHideBtn(false)

			self.finalAwardState = FinalAwardStateType.toChoose

			if self.randItemEnough == true or self.targetItemEnough == true then
				self.finalAwardState = FinalAwardStateType.enoughChoose
			end
		else
			self:showHideBtn(true)

			self.finalAwardState = FinalAwardStateType.hasChoose
		end
	else
		self:showHideBtn(false)

		self.finalAwardState = FinalAwardStateType.toChoose

		if self.randItemEnough == true or self.targetItemEnough == true then
			self.finalAwardState = FinalAwardStateType.enoughChoose
		end
	end

	if finaleAwardId ~= 0 then
		local awardData = ResOpActivityBingoBigReward[self.msicData.final_award_id][finaleAwardId]

		self.finalAward:setData(self.actObj.actData:hasBingoAwardNew(), self.gridId, self.finalAwardState, awardData)
	else
		self.finalAward:setData(self.actObj.actData:hasBingoAwardNew(), self.gridId, self.finalAwardState)
	end

	self.curFinalAwardId = finaleAwardId
end

function ActivityBingoDlg:_refreshCells()
	for idx, data in ipairs(self.detailData) do
		local rowNum = math.floor((data.index - 1) / self.maxNum) + 1
		local colNum = (data.index - 1) % self.maxNum + 1
		local state = 0

		if self.serverData.cube[data.index] then
			state = 2
			self.lotteryGotList[data.index] = true
		end

		data.state = state
		self.cells[data.index] = data

		if data.cell_type == CellType.Cell then
			if not self.cellsR[rowNum] then
				self.cellsR[rowNum] = {}
			end

			table.insert(self.cellsR[rowNum], data.index)

			if not self.cellsC[colNum] then
				self.cellsC[colNum] = {}
			end

			table.insert(self.cellsC[colNum], data.index)

			if rowNum == colNum then
				self.cellsL[CELL_LINE_TYPE_EQUAL] = self.cellsL[CELL_LINE_TYPE_EQUAL] or {}

				table.insert(self.cellsL[CELL_LINE_TYPE_EQUAL], data.index)
			end

			if rowNum + colNum == self.maxNum + 1 then
				self.cellsL[CELL_LINE_TYPE_SUB] = self.cellsL[CELL_LINE_TYPE_SUB] or {}

				table.insert(self.cellsL[CELL_LINE_TYPE_SUB], data.index)
			end
		elseif data.cell_type == CellType.AwardLine then
			if data.param == 1 then
				self.cellsAwardR[self.maxNum + 1] = data.index
			elseif data.param == 2 then
				self.cellsAwardC[self.maxNum + 1] = data.index
			end
		elseif data.cell_type == CellType.AwardRow then
			self.cellsAwardR[data.param] = data.index
		elseif data.cell_type == CellType.AwardCol then
			self.cellsAwardC[data.param] = data.index
		elseif data.cell_type == CellType.Final then
			self.cellFinalAward = data.index
		end
	end
end

function ActivityBingoDlg:_refreshCellsUI()
	local iconPath = self.msicData.picture_path

	for j = 1, self.maxNum * self.maxNum do
		local id = self.cells[j].index
		local cellPath = "ActivityBingo/GridBingo"

		if self.replaceableCellPath and self.replaceableCellPath[1] then
			cellPath = self.replaceableCellPath[1]
		end

		local cell = BingoCell(self, "MainInfoPanel/BingoPanel", "System/Activity/" .. cellPath)

		cell:setData(self.cells[j], iconPath, self.round, self.msicData.picture_num)
		cell:setVisible(true)

		cell.mEvevtClick = Slot(self.onCellClick, self)
		self.cellObjs[id] = cell
	end

	for i = 1, self.maxNum + 1 do
		local idR = self.cellsAwardR[i]
		local idC = self.cellsAwardC[i]
		local cellAwardR = CellAward(self, "MainInfoPanel/AwardPanelL/Panel" .. i)
		local cellAwardC = CellAward(self, "MainInfoPanel/AwardPanelB/Panel" .. i)

		if i ~= self.maxNum + 1 then
			cellAwardR:setData(self.cells[idR], self.cellsR[i], self.gridId)
			cellAwardC:setData(self.cells[idC], self.cellsC[i], self.gridId)
		else
			cellAwardR:setData(self.cells[idR], self.cellsL[CELL_LINE_TYPE_EQUAL], self.gridId)
			cellAwardC:setData(self.cells[idC], self.cellsL[CELL_LINE_TYPE_SUB], self.gridId)
		end

		self.cellAwardObjs[idR] = cellAwardR
		self.cellAwardObjs[idC] = cellAwardC
	end

	self:refreshAllAwards()
	self:playAnimOnOpen()
end

function ActivityBingoDlg:playAnimOnOpen()
	local aniList = {}

	for i = 1, self.maxCount do
		local rowNum = math.floor((i - 1) / self.maxNum) + 1
		local colNum = (i - 1) % self.maxNum + 1
		local subNum = rowNum + colNum

		if not aniList[subNum - 1] then
			aniList[subNum - 1] = {}
		end

		table.insert(aniList[subNum - 1], self.cellObjs[i])
	end

	for index, list in ipairs(aniList) do
		coroutine.start(self.coPlayInAnim, self, index, list)
	end
end

function ActivityBingoDlg:coPlayInAnim(cd, list)
	coroutine.wait(cd * 0.1)

	for _, item in ipairs(list) do
		item:playTurnOnOpen()
	end
end

function ActivityBingoDlg:refreshAllAwards()
	for i = 1, self.maxNum + 1 do
		self:refreshAward(self.cellsAwardR[i])
		self:refreshAward(self.cellsAwardC[i])
	end
end

function ActivityBingoDlg:checkAwardCanGet(id)
	local awardCell = self.cellAwardObjs[id]

	if awardCell and awardCell.hasGet ~= true then
		local canGet = true

		for i, childId in ipairs(awardCell.includeChildsId) do
			if not self.cellObjs[childId] or self.cellObjs[childId].isGet ~= true then
				canGet = false

				break
			end
		end

		return canGet
	end

	return false
end

function ActivityBingoDlg:refreshAward(id)
	local awardCell = self.cellAwardObjs[id]

	if awardCell == nil then
		return
	end

	local state = awardCell.state
	local isCanGet = self:checkAwardCanGet(awardCell.id)

	if isCanGet == true then
		state = 2
	end

	awardCell:refreshState(state)
end

function ActivityBingoDlg:setCellGot(idTab)
	self.awardToGetList = {}

	for _, id in ipairs(idTab) do
		self.lotteryGotList[id] = true

		self:getAwardListByCellId(id)
	end

	local toGetList = {}

	for i, award in ipairs(self.awardToGetList) do
		table.insert(toGetList, award)
	end

	local coOnGetAward = coroutine.start(self.coGetAward, self, toGetList)

	table.insert(self.coOnGetAwards, coOnGetAward)
end

function ActivityBingoDlg:getAwardListByCellId(cellId)
	local rowNum = math.floor((cellId - 1) / self.maxNum) + 1
	local colNum = (cellId - 1) % self.maxNum + 1
	local awardRId = self.cellsAwardR[rowNum]
	local awardCId = self.cellsAwardC[colNum]

	if awardRId and self:checkAwardCanGet(awardRId) then
		self.awardToGetList[#self.awardToGetList + 1] = awardRId
	end

	if awardCId and self:checkAwardCanGet(awardCId) then
		self.awardToGetList[#self.awardToGetList + 1] = awardCId
	end

	local awardLineIdR = self.cellsAwardR[self.maxNum + 1]

	if rowNum == colNum and self:checkAwardCanGet(awardLineIdR) then
		self.awardToGetList[#self.awardToGetList + 1] = awardLineIdR
	end

	local awardLineIdC = self.cellsAwardC[self.maxNum + 1]

	if rowNum + colNum == self.maxNum + 1 and self:checkAwardCanGet(awardLineIdC) then
		self.awardToGetList[#self.awardToGetList + 1] = awardLineIdC
	end

	table.sort(self.awardToGetList, function(a, b)
		return b < a
	end)
end

function ActivityBingoDlg:coGetAward(newAwardList)
	if newAwardList and #newAwardList > 0 then
		local id = newAwardList[#newAwardList]
		local awardCell = self.cellAwardObjs[id]
		local state = 1

		if awardCell ~= nil then
			awardCell:refreshState(state)
			self.audioPanel:playAudio()
		end

		table.remove(newAwardList)
		coroutine.wait(0.5)

		if #self.coOnGetAwards > 0 then
			table.remove(self.coOnGetAwards)
		end

		local coOnGetAward = coroutine.start(self.coGetAward, self, newAwardList)

		table.insert(self.coOnGetAwards, coOnGetAward)
	else
		if self.awardToGetList then
			for i, awardId in pairs(self.awardToGetList) do
				self.cellAwardObjs[awardId]:flyAward()
			end
		end

		self.awardToGetList = nil

		if self.toShowFinalAward == true then
			self:realShowFinlAward()

			self.isOnRandLock = true
		else
			self.isOnRandLock = false
		end

		self.resetRandomParam = true
	end
end

function ActivityBingoDlg:onClickFinal()
	if self.isOnRandLock then
		return
	end

	local finalId = self.msicData.final_award_id
	local finalUI = UIManager.getUI("activityBingoAwardChoosePanel", true)

	finalUI:setData(finalId, self.serverData, self.actObj.opId, self.gridId, self.actObj)
	self:stopTargetRoll()
end

function ActivityBingoDlg:stopTargetRoll()
	if self.isOnTarget then
		self.isOnTarget = false

		for i = 1, self.maxCount do
			self.cellObjs[i]:setToChoose(false)
		end

		self:showHideBtn(true)
	end
end

function ActivityBingoDlg:onClickRoll()
	if self.rollLock == true then
		return
	end

	if self.randItemEnough == false then
		local itemId = self.msicData.rand_item_id
		local fakeItem = BaseObject.GetObject(itemId)

		UIManager.getUI("itemTips"):showObj(self.mWindow, fakeItem)

		return
	end

	local immResult

	if self.rollTimer then
		self.rollTimer:Stop()

		self.rollTimer = nil
		immResult = self.curRollResult

		self:endRoll(immResult)
	end

	self.validIndexList = {}

	for index = 1, self.maxCount do
		if not self.lotteryGotList[index] and immResult ~= index then
			table.insert(self.validIndexList, index)
		end
	end

	if self:_checkRollValid(immResult ~= nil) then
		local drawType = DEAW_TYPW.rand
		local itemid = self.msicData.rand_item_id
		local itemNum = ClientUtils.getMoney(itemid)

		CurAvatar:activityRPC(Functor(RPC.bingoDraw, self.actObj.opId, 0, drawType, itemNum), self.actObj.opId)

		if self.rollCDTimer then
			self.rollLock = true

			self.rollCDTimer:Restart()
		end
	end
end

function ActivityBingoDlg:onRollCDTimerEnd()
	self.rollLock = false
end

function ActivityBingoDlg:onClickTargetRoll()
	if self.rollLock == true then
		return
	end

	if self.targetItemEnough == false then
		MsgManager.notice(Lang.get(200))

		return
	end

	self:showHideBtn(false)
	self.btnBlock:setVisible(true)

	self.isOnTarget = true

	for i = 1, self.maxCount do
		if not self.lotteryGotList[i] then
			self.cellObjs[i]:setToChoose(true)
		end
	end
end

function ActivityBingoDlg:onCellClick(id)
	for i = 1, self.maxCount do
		self.cellObjs[i]:setToChoose(false)
	end

	self:endRoll(id, true)
	self.btnBlock:setVisible(false)

	self.isOnTarget = false
end

function ActivityBingoDlg:onBlockClick()
	self.btnBlock:setVisible(false)

	self.isOnTarget = false

	for i = 1, self.maxCount do
		self.cellObjs[i]:setToChoose(false)
	end

	self:showHideBtn(true)
end

function ActivityBingoDlg:onDrawResp(result)
	local resultTab = {}

	for _, id in ipairs(result) do
		table.insert(resultTab, id + 1)
	end

	self.curRollResult = resultTab
	self.isOnRandLock = true

	self:startRoll()
	self:checkMoneyEnough()
end

function ActivityBingoDlg:showHideBtn(isShow)
	self.btnConfirm:setEnable(true)
	self.btnConfirm:setVisible(isShow)

	if self.hasTargetItem == true then
		self.btnSpeConfirm:setVisible(isShow)
	end
end

function ActivityBingoDlg:showFinalAward()
	self.toShowFinalAward = true

	self.btnConfirm:setEnable(false)
end

function ActivityBingoDlg:realShowFinlAward()
	local finalUI = UIManager.getUI("activityBingoEfxDlg", true)

	finalUI:setData(self.msicData.final_award_id, self.curFinalAwardId, self.gridId)

	self.toShowFinalAward = false
end

function ActivityBingoDlg:_checkRollValid(hasCacheRoll)
	if self.actObj:isValid() == true then
		if not (#self.validIndexList > 0) then
			return false
		end

		return true
	else
		MsgManager.notice(Lang.get(30607))
	end
end

function ActivityBingoDlg:startRoll(...)
	if #self.validIndexList == 0 then
		return
	end

	self:_createCurve()

	self.curveValueIndex = 1
	self.rollTimer = Timer.New(self.slotOfRoll, self.curve[self.curveValueIndex])

	self.rollTimer:Start()
end

function ActivityBingoDlg:rollFunc()
	local rollResult = {
		math.random(self.maxCount)
	}

	if #self.curve == 0 or not self.curve[self.curveValueIndex + 1] then
		rollResult = self.curRollResult
	end

	for _, id in ipairs(rollResult) do
		for i, cell in ipairs(self.cellObjs) do
			cell:setTurn(i == id)
		end
	end

	if #self.curve == 0 or not self.curve[self.curveValueIndex + 1] then
		if self.rollTimer then
			self.rollTimer:Stop()

			self.rollTimer = nil
		end

		local result = self.curRollResult

		self.rollTimer = Timer.New(Functor(self.endRoll, self, result), 0.3)

		self.rollTimer:Start()
	else
		self.curveValueIndex = self.curveValueIndex + 1
		self.rollTimer = Timer.New(self.slotOfRoll, self.curve[self.curveValueIndex])

		self.rollTimer:Start()
	end
end

function ActivityBingoDlg:endRoll(rollResult, isTarget)
	if self.rollTimer then
		self.rollTimer:Stop()

		self.rollTimer = nil
	end

	for i, cell in ipairs(self.cellObjs) do
		cell:setTurn(false)
	end

	if #rollResult > 1 then
		self.txtCrit:setText(#rollResult)

		if #self.resultList > 0 then
			for _, result in ipairs(self.resultList) do
				self:showResult(result)
			end

			self.resultList = {}
		end

		table.insert(self.resultList, rollResult)
		self:playAni("BingoCrit", Functor(self.showResult, self, rollResult), true)
	else
		self:showResult(rollResult)
	end
end

function ActivityBingoDlg:showResult(rollResult)
	for _, id in ipairs(rollResult) do
		self.cellObjs[id]:setTurnOpen(true)
	end

	self.resultList = {}

	self:setCellGot(rollResult)
end

function ActivityBingoDlg:_createCurve()
	self.curve = {}

	local leftLottery = #self.validIndexList

	if ResTigerBandit and ResTigerBandit[leftLottery] and ResTigerBandit[leftLottery].roll_count > 0 then
		for i, delay in ipairs(ResTigerBandit[leftLottery].roll_delay) do
			local delayTime = delay / 10000

			table.insert(self.curve, delayTime)
		end
	end
end

function ActivityBingoDlg:easeOut(t, b, c)
	return c * t * (t - 2) + b
end

function ActivityBingoDlg:onBtnClose()
	if #self.coOnGetAwards > 0 then
		for i, coEvent in ipairs(self.coOnGetAwards) do
			coroutine.stop(coEvent)
		end
	end

	if self.rollTimer then
		self.rollTimer:Stop()

		self.rollTimer = nil
	end

	self:setVisible(false)
	self:recoverManualReject()
end

return ActivityBingoDlg
