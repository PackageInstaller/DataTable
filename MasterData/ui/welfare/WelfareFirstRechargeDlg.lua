-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Welfare\\WelfareFirstRechargeDlg.lua

local ResMallFirstRecharge = require("ClientData/ResMallFirstRecharge")
local UIMiscConfig = require("DesignerScript/UIMiscConfig")
local FirstRechargeCell = Class("WelfareFirstRechargeDlg_FirstRechargeCell", UIControls.Panel)

function FirstRechargeCell:ctor()
	self.textTime = UIControls.Label(self, self.mPath .. "/TextTime")
	self.btnGet = UIControls.Button(self, self.mPath .. "/BtnGet", "Text")

	self.btnGet:addEventClick(self.onBtnGetClick)

	self.imgGet = UIControls.Panel(self, self.mPath .. "/ImgGet")
	self.getPanel = UIControls.Panel(self, self.mPath .. "/ImgHave")
	self.panelState = UIControls.Label(self, self.mPath .. "/TextState")
	self.grids = {}
end

function FirstRechargeCell:setData(firstRechargeConfig, index, checkOpen, checkGet)
	self.firstRechargeConfig = firstRechargeConfig
	self.level = self.firstRechargeConfig.level
	self.index = index
	self.detailConfig = self.firstRechargeConfig.first_recharge_detail[index]

	ClientTimerManager.RemoveSecondTickUI(self.textTime)
	ClientUtils.CreateBonusGrid(self, self.grids, self.mPath .. "/GridPanel", self.detailConfig.reward, true, nil, true, {
		isShowPreviewTips = true
	})
	self.getPanel:setVisible(checkOpen and checkGet)
	self.textTime:setText(checkOpen and checkGet and "" or string.format(self.detailConfig.des, self.firstRechargeConfig.first_recharge_money_limit / 100))

	for _, grid in ipairs(self.grids) do
		grid:setGet(checkOpen and checkGet)
	end

	self.btnGet:setVisible(false)
	self.imgGet:setVisible(false)
	self.panelState:setVisible(false)

	if checkOpen and not checkGet then
		if CurAvatar:firstRechargeEnable(self.detailConfig.target_type, self.detailConfig.target_args) then
			self.btnGet:setText(Lang.get(38))
			self.btnGet:setVisible(true)
			self.imgGet:setVisible(true)
		else
			self.panelState:setVisible(true)

			if self.index == 3 then
				local targetTick = ClientUtils.getServerTimeTodayStart(CurAvatar.firstRechargeTriggerTick) + (self.detailConfig.target_args - 1) * Const.TIME_ONE_DAY
				local serverTime = ClientUtils.getServerTime()
				local second = targetTick - serverTime

				ClientTimerManager.AddSecondTickUI(self.panelState, second, false, "", "")
			end
		end
	end
end

function FirstRechargeCell:onBtnGetClick()
	if not self.clickDisable then
		RPC.rechargeGetFirstAward(self.level, self.index - 1)

		if self.index == 2 then
			CurAvatar:tryOpenGameEvaluateDlg("FirstRechargeCell_666")
		elseif self.index == 3 then
			CurAvatar:tryOpenGameEvaluateDlg("FirstRechargeCell_888")
		end
	else
		MsgManager.notice(Lang.get(30782))
	end
end

local WelfareFirstRechargePanel = Class("WelfareFirstRechargeDlg_WelfareFirstRechargePanel", UIControls.Child)
local MAX_CELL_NUM = 3

function WelfareFirstRechargePanel:ctor()
	self.btnFunc = UIControls.Button(self, "Bg/BtnFunc", "Text")

	self.btnFunc:addEventClick(self.onBtnClick)

	self.panelTitle = UIControls.Panel(self, "Bg/ImgTitle")
	self.cells = {}

	for index = 1, MAX_CELL_NUM do
		local newCell = FirstRechargeCell(self, "Bg/AwardPanel/Day" .. index)

		table.insert(self.cells, newCell)
	end

	self.textExtraNum = UIControls.Label(self, "Bg/BgDec/TextNum")

	if UIControls.checkControlFunc(self, "Bg/BgDec/TextTitle1") then
		self.txtTitle1 = UIControls.Label(self, "Bg/BgDec/TextTitle1")
	end
end

function WelfareFirstRechargePanel:setData(_firstRechargeConfig, _firstRechargeData)
	self.firstRechargeConfig = _firstRechargeConfig
	self.firstRechargeData = _firstRechargeData

	self.textExtraNum:setText(self.firstRechargeConfig.first_recharge_extra_money)

	if self.txtTitle1 and self.firstRechargeConfig.des then
		self.txtTitle1:setText(string.format(self.firstRechargeConfig.des, self.firstRechargeConfig.first_recharge_money_limit / 100))
	end

	local checkTrigger = self.firstRechargeData ~= nil

	self.btnFunc:setVisible(not checkTrigger)
	self.panelTitle:setVisible(not checkTrigger)

	for index, cell in ipairs(self.cells) do
		cell:setData(self.firstRechargeConfig, index, checkTrigger, self.firstRechargeData and self.firstRechargeData.getStateDic[index])
	end
end

function WelfareFirstRechargePanel:onBtnClick()
	CurAvatar:sendRechargeAnalyticsData(Const.OSS_TYPE_CLICK_JUMP)

	if ClientUtils.JumpToFirstRecharge() then
		self.mWindow:setVisible(false)
	end
end

local WelfareFirstRechargeDlg = Class("WelfareFirstRechargeDlg", UIControls.Window)

function WelfareFirstRechargeDlg:ctor()
	self.btnClose = UIControls.Button(self, "Bg/EmptyRaycast")

	self.btnClose:addEventClick(self.onClickBtnClose)

	self.btnPre = UIControls.Button(self, "Bg/BtnPre")

	self.btnPre:addEventClick(self.onClickBtnPre)

	self.preRed = UIControls.Panel(self, "Bg/BtnPre/IconNew")
	self.btnNext = UIControls.Button(self, "Bg/BtnNext")

	self.btnNext:addEventClick(self.onClickBtnNext)

	self.nextRed = UIControls.Panel(self, "Bg/BtnNext/IconNew")
	self.pagePointPanel = UIControls.Panel(self, "PagePanel")
	self.btnPagePointList = {}

	for i = 1, Const.WELFARE_FIRST_RECHAREGE_GEAR do
		if UIControls.checkControlFunc(self, "Bg/PagePanel/Page" .. i) then
			local btn = UIControls.Button(self, "Bg/PagePanel/Page" .. i)

			local function func()
				self:onClickBtnPagePoint(i)
			end

			btn:addEventClick(func)
			table.insert(self.btnPagePointList, btn)
		end
	end

	self.pageDic = {}
end

function WelfareFirstRechargeDlg:onOpen()
	WelfareFirstRechargeDlg.super.onOpen(self)
	CurAvatar:sendRechargeAnalyticsData(Const.OSS_TYPE_SHOW_UI, Const.OSS_OPEN_UI_TYPE_FIRST_REC, UIMiscConfig.FIRST_RECHARGE_UI_ID)

	local voiceId = UIMiscConfig.VOCAL_ID_FIRST_RECHARGE

	CueManager.playGroupVocal(voiceId)
	self:refreshShow()
end

function WelfareFirstRechargeDlg:refreshShow()
	self.showLevelList = {}

	for level = 1, CurAvatar.firstRechargeMaxTriggerLevel + 1 do
		local config = CurAvatar:getFirstRechargeConfig(level)

		if config then
			local data = CurAvatar.firstRechargeDataDic[level]

			if not data or not data.hasGet then
				table.insert(self.showLevelList, level)
			end
		end
	end

	table.sort(self.showLevelList)

	self.showLevelNum = #self.showLevelList

	local checkShowPagePoint = self.showLevelNum > 1

	self.pagePointPanel:setVisible(checkShowPagePoint)

	if checkShowPagePoint then
		for index, btnPagePoint in ipairs(self.btnPagePointList) do
			local check = index <= self.showLevelNum

			btnPagePoint:setVisible(check)
			btnPagePoint:setEnable(true)
		end
	end

	for _, page in pairs(self.pageDic) do
		page:setVisible(false)
	end

	self.selectIndex = 0

	local newIndex = 0

	if CurAvatar.newUnlockFirstRechargeLevel and CurAvatar.newUnlockFirstRechargeLevel > 0 then
		newIndex = utils.getIndexByValue(self.showLevelList, CurAvatar.newUnlockFirstRechargeLevel)
	end

	if newIndex <= 0 then
		local canGetLevel = CurAvatar:getFirstRechargeCanGetMaxLevel()

		if canGetLevel > 0 then
			newIndex = utils.getIndexByValue(self.showLevelList, canGetLevel)
		end
	end

	if newIndex <= 0 then
		newIndex = self.showLevelNum
	end

	self:selectPage(newIndex)
end

function WelfareFirstRechargeDlg:selectPage(index)
	if index == self.selectIndex or index < 1 or index > self.showLevelNum then
		return
	end

	if self.selectIndex > 0 then
		self.pageDic[self.showLevelList[self.selectIndex]]:setVisible(false)
		self.btnPagePointList[self.selectIndex]:setEnable(true)
	end

	self.selectIndex = index

	self.btnPagePointList[index]:setEnable(false)
	self:refreshSelectRes()
end

function WelfareFirstRechargeDlg:refreshSelectRes()
	local level = self.showLevelList[self.selectIndex]
	local data = CurAvatar.firstRechargeDataDic[level]
	local firstRechargeConfig = CurAvatar:getFirstRechargeConfig(level)
	local page = self.pageDic[level]

	if not page then
		page = WelfareFirstRechargePanel(self, "Bg/GiftPanel", "System/Store/" .. firstRechargeConfig.prefab_path)
		self.pageDic[level] = page
	end

	page:setData(firstRechargeConfig, data)
	page:setVisible(true)

	local checkShowPre = self.selectIndex > 1

	self.btnPre:setVisible(checkShowPre)

	if checkShowPre then
		local preLevel = self.showLevelList[self.selectIndex - 1]

		self.preRed:setVisible(CurAvatar:checkFirstRechargeCanGet(preLevel))
	end

	local checkShowNext = self.selectIndex < self.showLevelNum

	self.btnNext:setVisible(checkShowNext)

	if checkShowNext then
		local nextLevel = self.showLevelList[self.selectIndex + 1]

		self.nextRed:setVisible(CurAvatar:checkFirstRechargeCanGet(nextLevel))
	end

	CurAvatar:onFirstRechargeDlgOpen()
end

function WelfareFirstRechargeDlg:onClickBtnClose()
	self:setVisible(false)
end

function WelfareFirstRechargeDlg:onClickBtnPre()
	local index = self.selectIndex - 1

	self:selectPage(index)
end

function WelfareFirstRechargeDlg:onClickBtnNext()
	local index = self.selectIndex + 1

	self:selectPage(index)
end

function WelfareFirstRechargeDlg:onClickBtnPagePoint(index)
	self:selectPage(index)
end

function WelfareFirstRechargeDlg:onDataChange()
	local level = self.showLevelList[self.selectIndex]
	local data = CurAvatar.firstRechargeDataDic[level]

	if data and not data.hasGet then
		self:refreshSelectRes()
	else
		self:refreshShow()
	end
end

return WelfareFirstRechargeDlg
