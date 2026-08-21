-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Welfare\\WelfareBattlePassPanel.lua

local welfareBase = require("UI/Welfare/WelfarePanelBase")
local ResBattlePassLevel = require("ClientData/ResBattlePassLevel")
local RechargeManager = require("System/Recharge/RechargeManager")
local ResMallSubPanelConfig = require("ClientData/ResMallSubPanelConfig")
local ResRandClient = require("ClientData/ResRandClient")
local EventConst = require("EventConst")
local RPC = require("Framework/RPC")
local ResColor = require("ClientData/ResColor")
local ResBattlePassMisc = require("ClientData/ResBattlePassMisc")
local ResClientNotice = require("ClientData/ResClientNotice")
local ResClientConfirm = require("ClientData/ResClientConfirm")
local BpCell = Class("BpCell", UIControls.ScrollViewLoopCell)
local SOURCR_INFO = {
	{
		"BgLongBottom3",
		"BgLongBottom3R",
		"BgLevel3",
		ResColor.GREYMIDDLE,
		ResColor.GREYMIDDLE
	},
	{
		"BgLongBottom2",
		"BgLongBottom2R",
		"BgLevel2",
		ResColor.BLACK,
		ResColor.ORANGE
	},
	{
		"BgLongBottom1",
		"BgLongBottom1R",
		"BgLevel1",
		ResColor.WHITE,
		ResColor.ORANGE
	},
	{
		"BgLongBottom1",
		"BgLongBottom1R",
		"BgLevel1",
		ResColor.WHITE,
		ResColor.ORANGE
	}
}

function BpCell:ctor()
	self.imgBg = UIControls.Image(self, "Bg")
	self.imgBgRight = UIControls.Image(self, "Bg/BgRight")
	self.Bg = UIControls.Image(self, "Bg")
	self.slider = UIControls.Slider(self, "Bg/Slider")
	self.imgBgLv = UIControls.Image(self, "Bg/BgLv")
	self.txtBPLv = UIControls.Label(self, "Bg/TextBPLv")
	self.txtBPPoint = UIControls.Label(self, "Bg/TextBPPoint")
	self.btnConfirm = UIControls.Button(self, "Bg/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnClick)

	self.iconNew = UIControls.Image(self, "Bg/BtnConfirm/IconNew")

	self.iconNew:setVisible(false)

	self.txtState = UIControls.Label(self, "Bg/TextState")

	self.txtState:setVisible(false)

	self.aniName = ""
	self.itemGridPathN = "GridNormalAward"
	self.itemGridPathS = "GridVIPAward"
	self.onlyAttrs = true
	self.normalItem = {}
	self.superItem = {}
end

function BpCell:setData(data, srvData, lastData)
	self.data = data
	self.srvData = srvData

	self.txtBPLv:setText(string.format(Lang.get(30171), data.level))
	self.txtBPPoint:setText(data.bp_need)

	self.state = self:_setState(lastData)

	self:_setItems(data)
	self:_changeSource(self.state)
end

function BpCell:_setState(lastData)
	local data = self.data
	local srvData = self.srvData

	if not lastData then
		self.slider:setVisible(false)
	else
		self.slider:setVisible(true)
	end

	self.iconNew:setVisible(false)
	self.btnConfirm:setVisible(false)
	self.txtState:setVisible(false)

	local state = 1

	if data.normalToGet or data.superToGet then
		state = 2

		self.btnConfirm:setVisible(true)
		self.iconNew:setVisible(true)

		if lastData then
			local value = (srvData.curValue - lastData.bp_need) / (data.bp_need - lastData.bp_need)

			self.slider:setValue(value)
		end
	elseif data.normalHasGet or data.superHasGet then
		state = 3

		self.slider:setValue(1)
		self.txtState:setVisible(true)
	elseif srvData.curValue >= lastData.bp_need and srvData.curValue < data.bp_need then
		local value = (srvData.curValue - lastData.bp_need) / (data.bp_need - lastData.bp_need)

		self.slider:setValue(value)
	elseif data.bp_need <= srvData.curValue then
		state = 4

		self.slider:setValue(1)
	else
		self.slider:setValue(0)
	end

	return state
end

function BpCell:_setItems(data)
	if data.normal_award then
		local awardData = ResRandClient[data.normal_award]
		local isLock = not data.normalToGet and not data.normalHasGet

		for i = #self.normalItem + 1, #awardData.show_ids do
			if not self.normalItem[i] then
				self.normalItem[i] = UIControls.getGridAwardContainer(self, self.itemGridPathN)
			end
		end

		for idx, item in ipairs(self.normalItem) do
			local id = awardData.show_ids[idx]

			if id then
				if not (id >= 100000) or not (id < 200000) then
					self.onlyAttrs = false
				end

				local fakeItem = BaseObject.GetObject(id, awardData.show_nums[idx])

				self.normalItem[idx]:setObj(fakeItem)

				self.normalItem[idx].grid.mDisableWays = true

				self.normalItem[idx]:setVisible(true)
				self.normalItem[idx]:setState(isLock, data.normalHasGet, true)
			else
				self.normalItem[idx]:setVisible(false)
			end
		end
	end

	if data.super_award then
		local supAwardData = ResRandClient[data.super_award]
		local isSLock = not data.superToGet and not data.superHasGet

		for i = #self.superItem + 1, #supAwardData.show_ids do
			if not self.superItem[i] then
				self.superItem[i] = UIControls.getGridAwardContainer(self, self.itemGridPathS)
			end
		end

		for idx, item in ipairs(self.superItem) do
			local id = supAwardData.show_ids[idx]

			if id then
				if not (id >= 100000) or not (id < 200000) then
					self.onlyAttrs = false
				end

				local sfakeItem = BaseObject.GetObject(id, supAwardData.show_nums[idx])
				local hideLock = self.srvData.hasBuy ~= 0

				self.superItem[idx]:setObj(sfakeItem)

				self.superItem[idx].grid.mDisableWays = true

				self.superItem[idx]:setVisible(true)
				self.superItem[idx]:setState(isSLock, data.superHasGet, hideLock)
			else
				self.superItem[idx]:setVisible(false)
			end
		end
	end
end

function BpCell:_changeSource(state)
	self.imgBg:setImage("Atlas/StoreAtlas/StoreBPAtlas", SOURCR_INFO[state][1])
	self.imgBgRight:setImage("Atlas/StoreAtlas/StoreBPAtlas", SOURCR_INFO[state][2])
	self.imgBgLv:setImage("Atlas/StoreAtlas/StoreBPAtlas", SOURCR_INFO[state][3])
	self.txtBPLv:setFontColor(SOURCR_INFO[state][4])
	self.txtBPPoint:setFontColor(SOURCR_INFO[state][5])
end

function BpCell:onBtnClick()
	if self.mEventClick then
		self.mEventClick({
			self.data.level
		})
	end

	self:onClickGetAward()
end

function BpCell:onClickGetAward()
	if not self.onlyAttrs then
		return
	end

	for idx, item in pairs(self.normalItem) do
		if BaseObject.isAttrs(item.object.id) then
			item.grid:flyToCommonFuncEntryPanel()
		end
	end

	for idx, item in pairs(self.superItem) do
		if BaseObject.isAttrs(item.object.id) then
			item.grid:flyToCommonFuncEntryPanel()
		end
	end
end

local strClassName = "WelfareBattlePassPanel"
local WelfareBattlePassPanel = Class(strClassName, welfareBase)

function WelfareBattlePassPanel:ctor()
	self.cells = {}
	self.nextValue = 0
	self.curValue = 0
	self.maxValue = 0
	self.maxLevel = 0
	self.curLevel = 0

	self:initUI()

	self._slot4BPCellClick = Slot(self.onGetAward, self)
	self._slot4BtnBuyClick = Slot(self.onBtnBuyClick, self)
	self._slot4ProductLoaded = Slot(self.refreshData, self)

	EventCenter.addEventListener(EventConst.RECHARGE_PRODUCTS_LOAD_END, self._slot4ProductLoaded)
end

function WelfareBattlePassPanel:initUI()
	self.txtCurBPLevel = UIControls.Label(self, "BgInfo/LvInfo/TextLv")
	self.bpPointPanel = UIControls.Panel(self, "BgInfo/LvInfo/BPPoint")
	self.txtBPPoint = UIControls.Label(self, "BgInfo/LvInfo/BPPoint/TextBPPoint")
	self.imgBPPoint = UIControls.Image(self, "BgInfo/LvInfo/BPPoint/IconBPPoint")
	self.btnSpeedUp = UIControls.Button(self, "BgInfo/BtnSpeedUp")
	self.imgVip = UIControls.Image(self, "BgInfo/ImgVIP")
	self.btnVip = UIControls.Button(self, "BgInfo/BtnVIP")
	self.txtPrice = UIControls.Label(self, "BgInfo/BtnVIP/TextPrice")
	self.txtTalk = UIControls.Label(self, "BgTalk/TextTalk")
	self.scrollItems = UIControls.ScrollViewLoopV(self, "BPList", 0, self._onCellChanged)

	self.btnVip:addEventClick(self.onBtnBuyClick)
	self.btnSpeedUp:addEventClick(self.onSpeedUpClick)

	self.panelAward = UIControls.Panel(self, "BgInfo/GetPanel")
	self.gridsAward = {}

	self.txtTalk:setText(ResClientNotice[182].notice)

	self.txtTimeTip = UIControls.Label(self, "TipsPanel/TextTime")
	self.imgHero = UIControls.Panel(self, "TipsPanel/ImgHero")
	self.textDes = UIControls.Panel(self, "TipsPanel/TextDes")
	self.btnAllAward = UIControls.Button(self, "TipsPanel/BtnAllAward")

	self.btnAllAward:addEventClick(self.oneKeyGetAll)

	self.btnReset = UIControls.Button(self, "BtnReset")

	self.btnReset:addEventClick(self.onResetClick)

	if ChannelUtil.isDMMGame() and UIControls.checkControlFunc(self, "BgInfo/BtnVIP/TextPt") then
		self.priceDmmPanel = UIControls.Panel(self, "BgInfo/BtnVIP/TextPt")

		self.priceDmmPanel:setVisible(true)
	end
end

function WelfareBattlePassPanel:onOpenPanel()
	CurAvatar:sendRechargeAnalyticsData(Const.OSS_TYPE_SHOW_UI, Const.OSS_OPEN_UI_TYPE_MALL, self.panelConfigData.id)

	if not self.rechargeId then
		self.rechargeId = ResMallSubPanelConfig[self.panelConfigData.id].value1

		self:refreshData()
	end

	self:setVisible(true)
end

function WelfareBattlePassPanel:refreshData()
	self.srvData = CurAvatar:getBpServerData()

	if not self.srvData or not self.srvData.systemData then
		return
	end

	self.btnReset:setVisible(self.srvData.canReset == 1)

	self.bpData = CurAvatar:getBPData()

	local speedUpLimit = ResBattlePassMisc[1].bp_buy_day

	self.lastTime = self.srvData.systemData.end_time - 1 - ClientUtils.getServerTime()

	ClientTimerManager.AddSecondFormatTickUI(self.txtTimeTip, self.lastTime, nil, Lang.get(48695), Slot(self.timeDownCB, self))

	local product = RechargeManager.getProductByRechargeId(self.rechargeId)

	if not product then
		-- block empty
	end

	self.txtPrice:setText(product.priceText)

	self.price = product.priceText

	if self.srvData.hasBuy ~= 0 then
		self.btnVip:setVisible(false)
		self.imgVip:setVisible(true)
		self.panelAward:setVisible(false)
	else
		self.panelAward:setVisible(true)
		self.btnVip:setVisible(true)
		self.imgVip:setVisible(false)
	end

	local isToBottom = false
	local curValue = self.srvData.curValue or 0
	local canGetCount = 0

	for idx, data in ipairs(self.bpData) do
		if data.normalToGet == true or data.superToGet == true then
			if not self.targetCellIdx then
				self.targetCellIdx = idx
			end

			canGetCount = canGetCount + 1
		end

		if curValue >= data.bp_need then
			self.curLevel = data.level
		else
			self.nextValue = data.bp_need

			local posIndex = math.max(idx - 2, 1)

			if not self.targetCellIdx then
				if #self.bpData - posIndex <= 5 then
					isToBottom = true
				end

				self.targetCellIdx = posIndex
			end

			break
		end
	end

	if not self.targetCellIdx then
		isToBottom = true
		self.targetCellIdx = #self.bpData - 5
	end

	self.maxLevel = self.bpData[#self.bpData].level
	self.maxValue = self.bpData[#self.bpData].bp_need
	self.curValue = curValue

	self.txtCurBPLevel:setText(self.curLevel)

	if speedUpLimit >= self.lastTime / 86400 then
		self.btnSpeedUp:setVisible(true)
		self.txtTimeTip:setFontColor(ResColor.RED)
	else
		self.btnSpeedUp:setVisible(false)
		self.txtTimeTip:setFontColor(ResColor.WHITE)
	end

	if self.curLevel == self.maxLevel then
		self.btnSpeedUp:setVisible(false)
		self.bpPointPanel:setVisible(false)
	else
		local moneyInfo = UIConst.MONEY_ID2INFO[Const.MONEY_ID_BP]

		self.imgBPPoint:setImage(moneyInfo[1], moneyInfo[2])
		self.txtBPPoint:setText(self.curValue .. "/" .. self.nextValue)
		self.bpPointPanel:setVisible(true)
	end

	self.scrollItems:setTotalCount(#self.bpData, self.targetCellIdx or 1, false)

	if isToBottom == true then
		self.scrollItems:goToBottom()
	end

	self.targetCellIdx = nil

	self:refreshBuyState()
	self:refreshBtnAllAwardState(canGetCount)
end

function WelfareBattlePassPanel:timeDownCB()
	ClientTimerManager.RemoveSecondTickUI(self.txtTimeTip)
end

function WelfareBattlePassPanel:_onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = BpCell(sender, "System/Store/StoreBPCell", newIdx, 0, 0)
	else
		self.cells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	self.cells[newIdx] = targetCell

	local lastData = self.bpData[newIdx - 1] or nil

	self.cells[newIdx]:setData(self.bpData[newIdx], self.srvData, lastData)

	self.cells[newIdx].mEventClick = self._slot4BPCellClick
end

function WelfareBattlePassPanel:refreshBtnAllAwardState(count)
	local needCoutn = self.btnAllAward:getVisible() and 0 or 1
	local isShowBtnAll = needCoutn < count

	self.imgHero:setVisible(not isShowBtnAll)
	self.textDes:setVisible(not isShowBtnAll)
	self.btnAllAward:setVisible(isShowBtnAll)
end

function WelfareBattlePassPanel:oneKeyGetAll()
	local canGotLevelMap = {}

	for index, curData in ipairs(self.bpData) do
		if curData.normalToGet or curData.superToGet then
			table.insert(canGotLevelMap, curData.level)
		end
	end

	if #canGotLevelMap > 0 then
		self:onGetAward(canGotLevelMap)

		for i, cell in pairs(self.cells) do
			if cell and cell.state == 2 then
				cell:onClickGetAward()
			end
		end
	end
end

function WelfareBattlePassPanel:checkToGetSupaerAwa()
	self.toGetSuperAwa = {}

	for idx, data in pairs(self.bpData) do
		if data.level <= self.curLevel and data.super_award then
			self.toGetSuperAwa[idx] = data.super_award
		else
			break
		end
	end
end

function WelfareBattlePassPanel:refreshBuyState()
	local toGetSuperAwards = {}

	for idx, data in pairs(self.bpData) do
		if data.level <= self.curLevel and data.super_award then
			local supAwardData = ResRandClient[data.super_award]

			if supAwardData then
				for k, id in ipairs(supAwardData.show_ids) do
					local has = false

					for _, aInfo in ipairs(toGetSuperAwards) do
						if aInfo[1] == id then
							has = true
							aInfo[2] = aInfo[2] + supAwardData.show_nums[k]

							break
						end
					end

					if not has then
						table.insert(toGetSuperAwards, {
							id,
							supAwardData.show_nums[k]
						})
					end
				end
			end
		end
	end

	for index = #self.gridsAward, #toGetSuperAwards - 1 do
		local newGrid = UIControls.getGridAwardContainer(self, "BgInfo/GetPanel")

		table.insert(self.gridsAward, newGrid)
	end

	for index, grid in ipairs(self.gridsAward) do
		if toGetSuperAwards[index] then
			local clientItem = BaseObject.GetObject(toGetSuperAwards[index][1], toGetSuperAwards[index][2])

			grid.mDisableWays = true

			grid:setObj(clientItem)
			grid:setVisible(true)
		else
			grid:setVisible(false)
		end
	end
end

function WelfareBattlePassPanel:onGetAward(levelMap)
	RPC.battlePassGetAward(levelMap)
end

function WelfareBattlePassPanel:onBtnBuyClick()
	CurAvatar:sendRechargeAnalyticsData(Const.OSS_TYPE_CLICK_RECHARGE, self.rechargeId)
	RechargeManager.startRecharge(self.rechargeId, nil, nil)
end

function WelfareBattlePassPanel:onSpeedUpClick()
	local step = self.srvData.step

	UIManager.getUI("bpSpeedUpBox", true):onShow(self.curLevel, self.maxLevel, self.curValue, step)
end

function WelfareBattlePassPanel:onResetClick()
	local resConfirmData = ResClientConfirm[1071]

	UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, resConfirmData.title, resConfirmData.content, function()
		RPC.battlePassReset()
	end, nil, nil, resConfirmData.confirm_text, resConfirmData.cancel_text)
end

function WelfareBattlePassPanel:onClosePanel()
	CueManager.stopVocal()
	WelfareBattlePassPanel.super.onClosePanel(self)
end

function WelfareBattlePassPanel:onDestroy()
	ClientTimerManager.RemoveSecondTickUI(self.txtTimeTip)
	EventCenter.removeEventListener(EventConst.RECHARGE_PRODUCTS_LOAD_END, self._slot4ProductLoaded)
end

return WelfareBattlePassPanel
