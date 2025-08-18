-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityFashionLotteryDlg.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local ResOpActivityFLottoryMisc = require("ClientData/ResOpActivityFLottoryMisc")
local ResOpActivityFLottoryTemplate = require("ClientData/ResOpActivityFLottoryTemplate")
local MULTI_DRAW_DEFAULT = 10
local RANDOM_MAX_NUM = 3
local START_DELAY_TIME = 1
local INTERVAL_TIME = 0.6
local SHOW_DELAY_TIME = 1
local IS_SHOW_GOT = false
local LotteryCell = Class("LotteryCell", UIControls.Child)

function LotteryCell:ctor()
	self.btnChange = UIControls.Button(self, "BtnChange")

	self.btnChange:addEventClick(self.onChangeClick)

	self.btnAdd = UIControls.Button(self, "BtnAdd")

	self.btnAdd:addEventClick(self.onAddClick)

	self.imgCell = UIControls.Image(self, "Bg")
	self.imgGet = UIControls.Image(self, "ImgGot")
	self.gridBonus = {}
	self.panelItem = UIControls.Panel(self, "GridItem")
end

function LotteryCell:setData(cellData, cellGot, editEnable)
	self.editEnable = editEnable
	self.cellData = cellData
	self.cellGot = cellGot

	if self.cellData then
		ClientUtils.CreateBonusGrid(self, self.gridBonus, "GridItem", self.cellData.award, true, nil, true)
	else
		for _, grid in ipairs(self.gridBonus) do
			grid:setVisible(false)
		end
	end

	for index, grid in ipairs(self.gridBonus) do
		if self.cellGot then
			grid:setGet(true)
		else
			grid:setGet(false)
		end

		if self.mParent.gridId then
			grid:setContainerConfig(self.mParent.gridId)
		end
	end

	if self.cellGot then
		self.imgGet:setVisible(true)
		self.btnChange:setVisible(false)
		self.btnAdd:setVisible(false)
	else
		self.imgGet:setVisible(false)
	end

	local bgAtlasPath = self.mParent.lotteryCellBgAtlasPath

	if self.editEnable then
		if self.cellData then
			self.imgCell:setImage(bgAtlasPath, "BgBubbleDNml")
		else
			self.imgCell:setImage(bgAtlasPath, "BgBubbleDSel")
		end

		self.imgGet:setImage(bgAtlasPath, "BgBubbleDLight")
	else
		self.imgCell:setImage(bgAtlasPath, "BgBubbleXNml")
		self.imgGet:setImage(bgAtlasPath, "BgBubbleXLight")
	end

	if self.lookAwardMode ~= nil then
		self:refreshMode(self.lookAwardMode)
	end
end

function LotteryCell:setCellShowState(isShow)
	return
end

function LotteryCell:refreshMode(lookAwardMode)
	self.lookAwardMode = lookAwardMode

	if self.lookAwardMode then
		if self.cellGot then
			self:trySetVisible(true)
		end

		self.panelItem:setVisible(true)

		if self.editEnable and self.cellData then
			self.btnChange:setVisible(true)
		else
			self.btnChange:setVisible(false)
		end

		if self.editEnable and not self.cellData then
			self.btnAdd:setVisible(true)
		else
			self.btnAdd:setVisible(false)
		end

		if self.cellGot then
			self.imgCell:setVisible(false)
		else
			self.imgCell:setVisible(true)
		end
	else
		self.btnChange:setVisible(false)
		self.btnAdd:setVisible(false)

		if self.cellGot then
			self:trySetVisible(false)
		else
			self.panelItem:setVisible(false)
			self.imgCell:setVisible(true)
		end
	end
end

function LotteryCell:onChangeClick()
	self.mParent:onModifyChoosen(self)
end

function LotteryCell:onAddClick()
	self.mParent:onModifyChoosen()
end

function LotteryCell:playOpenAnim()
	self:playAni("GetGridLottery", Slot(self.onCellOpened, self), true)
end

function LotteryCell:onCellOpened()
	self.mParent:onCellOpened()
	self:trySetVisible(false, true)
end

function LotteryCell:trySetVisible(isShow, isDraw)
	if isShow then
		self:setVisible(true)
	elseif not IS_SHOW_GOT then
		self:setVisible(false)
	elseif self.cellGot or isDraw then
		self.imgGet:setVisible(true)
		self.panelItem:setVisible(false)
		self.imgCell:setVisible(false)
	end
end

local LotteryAwardCell = Class("LotteryAwardCell", UIControls.Child)

function LotteryAwardCell:ctor()
	self.btnSensor = UIControls.Button(self, "BtnFunc")

	self.btnSensor:addEventClick(self.onSensorClick)
	self.btnSensor:addEventHoldClick(self.onSensorHoldClick)

	self.panelGet = UIControls.Panel(self, "ImgGot")
	self.panelSelect = UIControls.Panel(self, "ImgCheck")
	self.gridBonus = {}
end

function LotteryAwardCell:setData(choosenData)
	self.choosenData = choosenData
	self.choosenIndex = choosenData.index

	ClientUtils.CreateBonusGrid(self, self.gridBonus, "GridPanel", choosenData.award, true, nil, true)
end

function LotteryAwardCell:setState(choosen, got)
	self.hasSel = nil

	for pos, index in pairs(choosen) do
		if index == self.choosenIndex then
			self.hasSel = pos

			break
		end
	end

	self.hasGot = got[self.choosenIndex]

	if self.hasGot then
		self.panelSelect:setVisible(true)
		self.panelGet:setVisible(true)
	else
		self.panelGet:setVisible(false)

		if self.hasSel then
			self.panelSelect:setVisible(true)
		else
			self.panelSelect:setVisible(false)
		end
	end
end

function LotteryAwardCell:onSensorClick()
	if self.mEventClick then
		self:mEventClick()
	end
end

function LotteryAwardCell:onSensorHoldClick()
	if self.gridBonus[1] and self.gridBonus[1].grid and self.gridBonus[1].grid.onGridClick then
		self.gridBonus[1].grid:onGridClick()
	end
end

local MAX_CELL_NUM = 24
local strClassName = "ActivityFashionLotteryDlg"
local ActivityFashionLotteryDlg = Class(strClassName, UIControls.Window)

MixinClass(ActivityFashionLotteryDlg, ActivityPanelMixin)

function ActivityFashionLotteryDlg:ctor()
	return
end

function ActivityFashionLotteryDlg:initUI()
	self.textTime = UIControls.Label(self, "MainInfoPanel/BasicInfoPanel/BgTime/TextTime")
	self.textRule = UIControls.Label(self, "MainInfoPanel/BasicInfoPanel/BgRule/TextRule")
	self.panelRoundBonus = UIControls.Panel(self, "MainInfoPanel/BasicInfoPanel/RoundAwardPanel")
	self.gridsRoundBonus = {}
	self.btnClose = UIControls.Button(self, "BtnClose", "Text")

	self.btnClose:addEventClick(self.onCloseClick)

	self.panelFirst = UIControls.Panel(self, "BeforePanel")
	self.btnFirst = UIControls.Button(self, "BeforePanel/BtnNext")

	self.btnFirst:addEventClick(self.onFirstClick)

	self.btnAchieve = UIControls.Button(self, "MainInfoPanel/BtnAchi")

	self.btnAchieve:addEventClick(self.onAchieveClick)

	self.btnStore = UIControls.Button(self, "MainInfoPanel/BtnSpeStore")

	self.btnStore:addEventClick(self.onStoreClick)

	self.panelFly = UIControls.Panel(self, "MainInfoPanel/FlyTarget")
	self.imgStoreNew = UIControls.Panel(self, "MainInfoPanel/BtnSpeStore/IconNew")
	self.imgStoreItem = UIControls.Image(self, "MainInfoPanel/BtnSpeStore/Bg/NumPanel/Icon")
	self.miscData = self.actObj.actData.miscData or {}
	self.storeItemId = self.miscData.ext_item_id

	local iconPath = BaseObject.getItemIconPath(self.storeItemId)

	if iconPath then
		self.imgStoreItem:setImage(iconPath[1], iconPath[2])
	end

	self.numStoreItem = UIControls.Label(self, "MainInfoPanel/BtnSpeStore/Bg/NumPanel/TextNum")
	self.btnGift = UIControls.Button(self, "MainInfoPanel/BtnGiftStore")

	self.btnGift:addEventClick(self.onGiftClick)

	self.panelList = UIControls.Panel(self, "MainInfoPanel/LotteryList")
	self.textRound = UIControls.Label(self, "MainInfoPanel/LotteryList/Content/RoundInfo/TextRound")
	self.textProgress = UIControls.Label(self, "MainInfoPanel/LotteryList/Content/RoundInfo/TextProgress")
	self.cells = {}

	local cellPrefabPath = "System/Activity/ActivitySkinLottery/GridLottery"

	self.lotteryCellBgAtlasPath = "Atlas/ActivityAtlas/ActivitySkinLotteryAtlas/ActivitySkinPartyAtlas1"

	if self.replaceableCellPath then
		if self.replaceableCellPath[1] then
			cellPrefabPath = "System/Activity/" .. self.replaceableCellPath[1] .. "/GridLottery"
		end

		if self.replaceableCellPath[2] then
			self.lotteryCellBgAtlasPath = "Atlas/ActivityAtlas/" .. self.replaceableCellPath[2]
		end

		self.lotteryBonusGridPath = self.replaceableCellPath[3]
	end

	for index = 1, MAX_CELL_NUM do
		local newCell = LotteryCell(self, "MainInfoPanel/LotteryList/Content/Lottery" .. index, cellPrefabPath)

		table.insert(self.cells, newCell)
	end

	self.btnLookAward = UIControls.Button(self, "MainInfoPanel/LotteryList/Content/BtnCheck")

	self.btnLookAward:addEventClick(self.onLookAwardModeClick)

	self.panelNone = UIControls.Panel(self, "MainInfoPanel/NoLottery")
	self.btnNoneChoose = UIControls.Button(self, "MainInfoPanel/NoLottery/BtnAdd")

	self.btnNoneChoose:addEventClick(self.onNoneChooseClick)

	self.labelNoneRound = UIControls.Label(self, "MainInfoPanel/NoLottery/RoundInfo/TextRound")
	self.panelDraw = UIControls.Panel(self, "MainInfoPanel/FuncPanel")
	self.btnDrawOne = UIControls.Button(self, "MainInfoPanel/FuncPanel/BtnDraw", "Text")

	self.btnDrawOne:addEventClick(self.onDrawOneClick)

	self.imgDrawOneNew = UIControls.Panel(self, "MainInfoPanel/FuncPanel/BtnDraw/IconNew")
	self.btnDrawMulti = UIControls.Button(self, "MainInfoPanel/FuncPanel/BtnDrawMulti", "Text")

	self.btnDrawMulti:addEventClick(self.onDrawMultiClick)

	self.imgDrawMultiNew = UIControls.Panel(self, "MainInfoPanel/FuncPanel/BtnDrawMulti/IconNew")
	self.imgDrawOne = UIControls.Image(self, "MainInfoPanel/FuncPanel/BtnDraw/Icon")
	self.imgDrawMulti = UIControls.Image(self, "MainInfoPanel/FuncPanel/BtnDrawMulti/Icon")
	self.drawCostItem = self.miscData.cost_item_id
	iconPath = BaseObject.getItemIconPath(self.drawCostItem)

	if iconPath then
		self.imgDrawOne:setImage(iconPath[1], iconPath[2])
		self.imgDrawMulti:setImage(iconPath[1], iconPath[2])
	end

	self.numDrawOne = UIControls.Label(self, "MainInfoPanel/FuncPanel/BtnDraw/TextNum")
	self.numDrawMulti = UIControls.Label(self, "MainInfoPanel/FuncPanel/BtnDrawMulti/TextNum")
	self.panelModify = UIControls.Panel(self, "ChooseAwardPanel")
	self.btnConfirm = UIControls.Button(self, "ChooseAwardPanel/BtnConfirm")

	self.btnConfirm:addEventClick(self.onConfirmClick)

	self.btnCancel = UIControls.Button(self, "ChooseAwardPanel/BtnCancel")

	self.btnCancel:addEventClick(self.onCancelClick)

	self.textChooseNum = UIControls.Label(self, "ChooseAwardPanel/TextTips")
	self.gridsChooseBonus = {}
	self.slot4ModifyBonus = Slot(self.onModifyBonus, self)
	self.gridId = self.clientTemplateData.grid_id
	self.slotForRefreshDrawItem = Slot(self.onDrawItemRefresh, self)

	CurAvatar:registerItemChangedCallBack(self.drawCostItem, self.slotForRefreshDrawItem)

	self.slotForRefreshStoreItem = Slot(self.onStoreItemRefresh, self)

	CurAvatar:registerItemChangedCallBack(self.storeItemId, self.slotForRefreshStoreItem)

	local showPanel = UIControls.Panel(self, "ShowPanel")

	if showPanel:getVisible() then
		self.multiCircles = {}

		for index = 1, MULTI_DRAW_DEFAULT do
			self.multiCircles[index] = UIControls.Panel(self, "ShowPanel/CircleMulti/Circle" .. index)
		end
	end

	self.hasDelyAnim = false
	self.panelScrollList = UIControls.ScrollView(self, "MainInfoPanel/LotteryList")

	self:setModifyMode(false)

	local actId = self.actObj.actId
	local miscMap = ResOpActivityFLottoryMisc[actId]
	local showTemolateId = miscMap and miscMap.show_template_id

	if showTemolateId then
		self.hasDelyAnim = true

		local templeteData = ResOpActivityFLottoryTemplate[showTemolateId]

		RANDOM_MAX_NUM = templeteData.random_max_count
		START_DELAY_TIME = templeteData.start_delay_time
		INTERVAL_TIME = templeteData.interval_time
		SHOW_DELAY_TIME = templeteData.show_delay_time
		IS_SHOW_GOT = templeteData.is_show_got == 1
	end
end

function ActivityFashionLotteryDlg:onFirstClick()
	self:playAni("HideSkinLotteryMainBefore", Slot(self.onFirstAnimOver, self), true)

	if self.actObj:isNewOpened() then
		RPC.opActSetFocus(self.actObj.opId, 1)
	end
end

function ActivityFashionLotteryDlg:onFirstAnimOver()
	if self.miscData.prepare_bgm then
		self:stopLogicBGM()
	end
end

function ActivityFashionLotteryDlg:onLookAwardModeClick()
	self.lookAwardMode = true

	self:playAni("ChangeModeToCheck")
	self:refreshLookAwardMode()
end

function ActivityFashionLotteryDlg:onNoneChooseClick()
	self:onLookAwardModeClick()
end

function ActivityFashionLotteryDlg:onModifyChoosen(cell)
	if not self.lookAwardMode then
		return
	end

	if self.inModify then
		if cell and cell.cellData and not cell.cellGot then
			self:_onModifyBonus(cell.cellData)
		end

		return
	end

	self:setModifyMode(true)
	self:playAni("ChangeModeToEdit")
	self.btnClose:setText(Lang.get(48068))
	self.panelModify:setVisible(true)

	local choosenAward = self.roundData.chooseAward

	for index = #self.gridsChooseBonus, #choosenAward - 1 do
		local newCell = LotteryAwardCell(self, "ChooseAwardPanel/AwardChooseList/Content", "System/Activity/ActivitySkinLottery/GridLotteryAward")

		newCell.mEventClick = self.slot4ModifyBonus

		table.insert(self.gridsChooseBonus, newCell)
	end

	for index, cell in ipairs(self.gridsChooseBonus) do
		if choosenAward[index] then
			cell:setVisible(true)
			cell:setData(choosenAward[index])
			cell:setState(self.choosen, self.choosenState)
		else
			cell:setVisible(false)
		end
	end
end

function ActivityFashionLotteryDlg:onModifyBonus(cell)
	if cell.hasGot then
		MsgManager.clientNotice(425)

		return
	end

	self:_onModifyBonus(cell.choosenData)
end

function ActivityFashionLotteryDlg:_onModifyBonus(choosenData)
	local choosenIndex = choosenData.index
	local hasSel

	for pos, index in pairs(self.choosen) do
		if index == choosenIndex then
			hasSel = pos

			break
		end
	end

	if hasSel then
		self.choosen[hasSel] = nil

		self:_refreshChoosen()
	else
		local empty

		for pos = 1, self.choosenNeedNum do
			if not self.choosen[pos] then
				empty = pos

				break
			end
		end

		if empty then
			self.choosen[empty] = choosenIndex

			self:_refreshChoosen()
		else
			MsgManager.clientNotice(426)
		end
	end
end

function ActivityFashionLotteryDlg:_refreshChoosen(refreshData)
	if refreshData then
		self.choosen = {}

		for pos, sIndex in ipairs(self.roundData.choosen or {}) do
			self.choosen[pos] = sIndex
		end
	end

	for index = 1, self.choosenNeedNum do
		local cell = self.cells[index]

		if self.choosen[index] then
			cell:setData(self.chooseData[self.choosen[index]], self.choosenState[self.choosen[index]], true)
		else
			cell:setData(nil, false, true)
		end
	end

	for index, cell in ipairs(self.gridsChooseBonus) do
		cell:setState(self.choosen, self.choosenState)
	end
end

function ActivityFashionLotteryDlg:onConfirmClick()
	local poses = {}

	for pos = 1, self.choosenNeedNum do
		if not self.choosen[pos] then
			MsgManager.clientNotice(427)

			return
		else
			table.insert(poses, self.choosen[pos])
		end
	end

	CurAvatar:activityRPC(RPC.opActFlottorySetSelIndex, self.actObj.opId, self.actObj.opId, poses)
end

function ActivityFashionLotteryDlg:onCancelClick()
	self:_refreshChoosen(true)
	self:setModifyMode(false)
	self.panelModify:setVisible(false)
	self:playAni("ChangeModeBackToNml2")

	self.lookAwardMode = false

	self:refreshLookAwardMode()
end

function ActivityFashionLotteryDlg:setModifyMode(inModify)
	self.inModify = inModify

	self.panelScrollList:setScrollEnable(self.inModify)

	if not self.inModify then
		self.panelScrollList:gotoTop()
	end
end

function ActivityFashionLotteryDlg:onOpen()
	ActivityFashionLotteryDlg.super.onOpen(self)

	if self.inModify or self.lookAwardMode then
		self.inModify = nil
		self.lookAwardMode = nil

		self:_setData()
	end
end

function ActivityFashionLotteryDlg:_setData()
	if self.actObj:isNewOpened() then
		if self.miscData.enter_avg then
			UIManager.playAVG(self.miscData.enter_avg)
		end

		self.panelFirst:setVisible(true)

		if self.miscData.prepare_bgm then
			self:playLogicBGM(self.miscData.prepare_bgm)
		end
	end

	self.actId = self.actObj.actId
	self.curRound = self.actObj.actData.curRound
	self.roundData = self.actObj.actData:getCurRoundData()
	self.allRoundData = self.actObj.actData.roundData
	self.choosen = {}

	for pos, sIndex in ipairs(self.roundData.choosen or {}) do
		self.choosen[pos] = sIndex
	end

	self.choosenState = self.roundData.choosenState
	self.fixedState = self.roundData.fixedState
	self.choosenNeedNum = self.roundData.chooseNum

	self.textChooseNum:setText(string.format(Lang.get(48582), self.choosenNeedNum))

	self.chooseData = self.roundData.chooseAward
	self.fixedData = self.roundData.fixedAward
	self.maxNumber = self.choosenNeedNum + #self.fixedData

	local numberInfo = self.roundData.gotInfo
	local maxNumber = numberInfo[1]
	local nowNumber = numberInfo[2]

	self.lastNumber = maxNumber - nowNumber

	self.textRound:setText(self.curRound)
	self.textProgress:setText(nowNumber .. "/" .. maxNumber)
	ClientUtils.CreateBonusGrid(self, self.gridsRoundBonus, "MainInfoPanel/BasicInfoPanel/RoundAwardPanel/AwardPanel", self.roundData.roundAward, true, nil, true)

	if self.roundData.choosen and next(self.roundData.choosen) then
		self:onDrawItemRefresh()
	end

	self.labelNoneRound:setText(string.format(Lang.get(48583), self.curRound))

	for index, cell in ipairs(self.cells) do
		local isShow = true

		if index <= self.choosenNeedNum then
			if self.choosen[index] then
				cell:setData(self.chooseData[self.choosen[index]], self.choosenState[self.choosen[index]], true)
			else
				cell:setData(nil, false, true)
			end
		elseif index <= self.maxNumber then
			cell:setData(self.fixedData[index - self.choosenNeedNum], self.fixedState[index - self.choosenNeedNum], false)
		else
			isShow = false
		end

		cell:trySetVisible(isShow)
	end

	self:refreshLookAwardMode()
	self:onStoreItemRefresh()

	if self.curRound == #self.allRoundData and self.lastNumber <= 0 then
		self.textRound:setText("MAX")
		self.btnDrawOne:setVisible(false)
		self.btnDrawMulti:setVisible(false)
	else
		self.textRound:setText(self.curRound)
		self.btnDrawOne:setVisible(true)
	end
end

function ActivityFashionLotteryDlg:refreshLookAwardMode()
	for index, cell in ipairs(self.cells) do
		cell:refreshMode(self.lookAwardMode)
	end

	if self.lookAwardMode then
		self.btnClose:setText(Lang.get(48069))
		self.panelDraw:setVisible(false)
		self.panelNone:setVisible(false)
		self.panelList:setVisible(true)
	else
		self.btnClose:setText(self.clientTemplateData.template_name or Lang.get(48111))

		if self.roundData.choosen and next(self.roundData.choosen) then
			self.panelNone:setVisible(false)
			self.panelList:setVisible(true)
			self.panelDraw:setVisible(true)
		else
			self.panelNone:setVisible(true)
			self.panelList:setVisible(false)
			self.panelDraw:setVisible(false)
		end
	end
end

function ActivityFashionLotteryDlg:onCloseClick()
	if self.inModify then
		self:onCancelClick()
	elseif self.lookAwardMode then
		self.lookAwardMode = false

		self:playAni("ChangeModeBackToNml")
		self:refreshLookAwardMode()
	else
		self:setVisible(false)
	end
end

function ActivityFashionLotteryDlg:onAchieveClick()
	local actObj = CurAvatar:getActivityObj(self.miscData.achieve_id)

	if actObj and actObj:isValid() then
		CurAvatar:jumpToShowActivity(actObj.actId)
	else
		MsgManager.notice(Lang.get(1870))
	end
end

function ActivityFashionLotteryDlg:onDrawItemRefresh()
	if self.actObj.actData.hasFree then
		self.btnDrawOne:setText(Lang.get(48584))
		self.numDrawOne:setText("0")
		self.imgDrawOneNew:setVisible(true)
		self.btnDrawMulti:setVisible(false)
	else
		self.btnDrawOne:setText(Lang.get(46185))

		local hasItemNumber = ClientUtils.getMoney(self.drawCostItem)

		self.numDrawOne:setText(1)
		self.numDrawOne:setFontColor(hasItemNumber < 1 and ResColor.RED or ResColor.WHITE)
		self.imgDrawOneNew:setVisible(hasItemNumber >= 1)

		if self.lastNumber <= 1 then
			self.btnDrawMulti:setVisible(false)
		else
			self.btnDrawMulti:setVisible(true)

			if self.lastNumber >= MULTI_DRAW_DEFAULT then
				self.multiDrawNumber = MULTI_DRAW_DEFAULT
			else
				self.multiDrawNumber = self.lastNumber
			end

			self.btnDrawMulti:setText(string.format(Lang.get(48112), self.multiDrawNumber))
			self.numDrawMulti:setText(self.multiDrawNumber)
			self.numDrawMulti:setFontColor(hasItemNumber < self.multiDrawNumber and ResColor.RED or ResColor.WHITE)
			self.imgDrawMultiNew:setVisible(hasItemNumber >= self.multiDrawNumber)
		end

		self.actObj:checkNew()
	end
end

function ActivityFashionLotteryDlg:onStoreItemRefresh()
	self.numStoreItem:setText(ClientUtils.getMoney(self.storeItemId))

	local actObj = CurAvatar:getActivityObj(self.miscData.store_id)
	local isAllSoldOut = true

	if actObj and actObj:isValid() then
		isAllSoldOut = actObj.actData:isOver()
	end

	self.imgStoreNew:setVisible(ClientUtils.getMoney(self.storeItemId) >= (self.miscData.achieve_new_num or 0) and not isAllSoldOut)
	self.actObj:checkNew()
end

function ActivityFashionLotteryDlg:onStoreClick()
	local actObj = CurAvatar:getActivityObj(self.miscData.store_id)

	if actObj and actObj:isValid() then
		CurAvatar:addActivityRelated(actObj.actId, "activityCommonStoreDlg")
		UIManager.getUI("activityCommonStoreDlg", true):setData(actObj)
	else
		MsgManager.notice(Lang.get(1870))
	end
end

function ActivityFashionLotteryDlg:onGiftClick()
	local actObj = CurAvatar:getActivityObj(self.miscData.gift_id)

	if actObj and actObj:isValid() then
		CurAvatar:addActivityRelated(actObj.actId, "activitySpeGiftDlg")
		UIManager.getUI("activitySpeGiftDlg", true):setData(actObj, "activitySpeGiftDlg")
	else
		MsgManager.notice(Lang.get(1870))
	end
end

function ActivityFashionLotteryDlg:onDrawOneClick()
	self:drawCheck(1)
end

function ActivityFashionLotteryDlg:onDrawMultiClick()
	if self.multiDrawNumber then
		self:drawCheck(self.multiDrawNumber)
	end
end

function ActivityFashionLotteryDlg:drawCheck(count)
	if self.hasRpcDraw then
		return
	end

	if self.actObj.actData.hasFree then
		self.hasRpcDraw = true

		CurAvatar:activityRPC(RPC.opActFlottoryDraw, self.actObj.opId, self.actObj.opId, 1)
	elseif self.miscData.may_max_round and self.curRound > self.miscData.may_max_round and self.miscData.max_round_notice then
		UIManager.showConfirmWithId(self.miscData.max_round_notice, Functor(self._realDraw, self, count))
	else
		self:_realDraw(count)
	end
end

function ActivityFashionLotteryDlg:_realDraw(count)
	local hasNum = ClientUtils.getMoney(self.drawCostItem)

	if hasNum < count then
		UIManager.showConfirmWithId(1057, Slot(self.onGiftClick, self))
	else
		if self.hasRpcDraw then
			return
		end

		CurAvatar:activityRPC(RPC.opActFlottoryDraw, self.actObj.opId, self.actObj.opId, count)
	end
end

function ActivityFashionLotteryDlg:onDrawResp(award)
	self.hasRpcDraw = nil
	self.actSingle = false

	if #award == 1 then
		self.actSingle = true
	end

	self.noOneCell = true

	if self.actSingle or not self.hasDelyAnim then
		self:playAnimShow(award)
	else
		self:delayPlayAnimShow(award)
	end

	if self.actSingle then
		self:playAni("DrawShowSingle")
	else
		if self.multiCircles then
			for index, cell in ipairs(self.multiCircles) do
				cell:setVisible(index <= #award)
			end
		end

		self:playAni("DrawShowMulti")
	end

	if self.noOneCell then
		self:onCellOpened()
	end
end

function ActivityFashionLotteryDlg:playAnimShow(award)
	for index, info in ipairs(award) do
		self.waitingCellOpened = true

		local cell

		if info.is_sel ~= 1 then
			local cellIndex = info.index + self.choosenNeedNum

			cell = self.cells[cellIndex]
		else
			for fIndex = 1, self.choosenNeedNum do
				local fCell = self.cells[fIndex]

				if fCell.cellData and fCell.cellData.index == info.index then
					cell = fCell

					break
				end
			end
		end

		if cell and cell:getVisible() then
			self.noOneCell = false

			cell:playOpenAnim()
		end
	end
end

function ActivityFashionLotteryDlg:delayPlayAnimShow(award)
	local delayShowCellMap = {}
	local curRandom = math.random(RANDOM_MAX_NUM)
	local groupIndex = 1
	local curCount = 1

	for index, info in ipairs(award) do
		local cell, curCellIndex

		if info.is_sel ~= 1 then
			local cellIndex = info.index + self.choosenNeedNum

			curCellIndex = cellIndex
			cell = self.cells[cellIndex]
		else
			for fIndex = 1, self.choosenNeedNum do
				local fCell = self.cells[fIndex]

				if fCell.cellData and fCell.cellData.index == info.index then
					curCellIndex = fIndex
					cell = fCell

					break
				end
			end
		end

		if cell and cell:getVisible() then
			self.noOneCell = false

			if self.hasDelyAnim then
				delayShowCellMap[groupIndex] = delayShowCellMap[groupIndex] or {}
				delayShowCellMap[groupIndex][curCount] = curCellIndex
				curCount = curCount + 1

				if curRandom < curCount then
					curCount = 1
					groupIndex = groupIndex + 1
					curRandom = math.random(RANDOM_MAX_NUM)
				end
			end
		end
	end

	local delayInterval = START_DELAY_TIME
	local cellMapLength = #delayShowCellMap

	self.timerMap = {}

	for i, group in ipairs(delayShowCellMap) do
		local curTimer = Timer.New(function(group)
			if i == cellMapLength then
				self.waitingCellOpened = true
			end

			for _, relIndex in ipairs(delayShowCellMap[i]) do
				self.cells[relIndex]:playOpenAnim()
			end
		end, delayInterval)

		table.insert(self.timerMap, curTimer)

		delayInterval = delayInterval + INTERVAL_TIME

		curTimer:Start()
	end
end

function ActivityFashionLotteryDlg:onCellOpened()
	if self.waitingCellOpened then
		self.waitingCellOpened = false

		local function showBonusDlg()
			local commonBonus = CurAvatar.fLottoryCommonBonus
			local specBonus = CurAvatar.fLottorySpecBonus

			if commonBonus or specBonus then
				local fashionLotteryBonusDlg = UIManager.getUI("fashionLotteryBonusDlg", true)

				fashionLotteryBonusDlg:onShow(commonBonus or {}, specBonus or {}, Slot(self.onShowBonusOver, self), self.lotteryBonusGridPath)
				fashionLotteryBonusDlg:setSpecialCustomizeFlyConfig(self.storeItemId, self.panelFly)
			else
				self:onShowBonusOver()
			end
		end

		if self.actSingle or not self.hasDelyAnim then
			showBonusDlg()
		else
			self:clearTimerMap()

			if self.showDlgTimer then
				self.showDlgTimer:Restart()
			else
				self.showDlgTimer = Timer.New(showBonusDlg, SHOW_DELAY_TIME)

				self.showDlgTimer:Start()
			end
		end
	end
end

function ActivityFashionLotteryDlg:onShowBonusOver()
	if self.id and self:isInShow() then
		if self.curRound ~= self.actObj.actData.curRound then
			if CurAvatar.fLottoryRoundBonus then
				UIManager.getUI("fashionLotteryClearDlg", true):onShow(CurAvatar.fLottoryRoundBonus, Slot(self.onRoundBonusOver, self))
				UIManager.getUI("fashionLotteryClearDlg", true):setSpecialCustomizeFlyConfig(self.storeItemId, self.panelFly)
			else
				self:onRoundBonusOver()
			end
		else
			self:_setData()
			self:playAni("ChangeModeBackToNml")
		end
	end
end

function ActivityFashionLotteryDlg:onRoundBonusOver()
	if self.id and self:isInShow() then
		self:_setData()
		self:playAni("ChangeModeBackToNml")
	end
end

function ActivityFashionLotteryDlg:updateActivityData()
	return
end

function ActivityFashionLotteryDlg:onSelBonusResp()
	if self.inModify then
		self:setModifyMode(false)
		self:playAni("ChangeModeBackToNml2")
		MsgManager.clientNotice(428)

		self.lookAwardMode = false
	end

	self:_setData()
end

function ActivityFashionLotteryDlg:clearTimerMap()
	if self.timerMap and #self.timerMap then
		for i, timer in ipairs(self.timerMap) do
			timer:Stop()
		end

		self.timerMap = {}
	end
end

function ActivityFashionLotteryDlg:destroy()
	if self.drawCostItem then
		CurAvatar:unregisterItemChangedCallBack(self.drawCostItem, self.slotForRefreshDrawItem)
		CurAvatar:unregisterItemChangedCallBack(self.storeItemId, self.slotForRefreshStoreItem)
	end

	if self.showDlgTimer then
		self.showDlgTimer:Stop()

		self.showDlgTimer = nil
	end

	self:clearTimerMap()
	ActivityFashionLotteryDlg.super.destroy(self)
end

return ActivityFashionLotteryDlg
