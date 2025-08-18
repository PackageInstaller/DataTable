-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\Trade\\MallDlgBase.lua

local UIControls = UIControls
local ChannelUtil = ChannelUtil
local ResMall = require("ClientData/ResMall")
local ResMallSubPanelConfig = require("ClientData/ResMallSubPanelConfig")
local ShopDlg = require("UI/MainState/Trade/ShopDlg")
local StoreRelicPanel = require("UI/MainState/Trade/StoreRelicPanel")
local CommonFuncEntryPanel = require("UI/MainMenu/CommonFuncEntryPanel")
local ShopUtils = require("UI/MainState/Trade/ShopUtils")
local RechargeManager = require("System/Recharge/RechargeManager")
local EventConst = require("EventConst")
local VersionUtils = require("System/VersionUtils")
local MallSimplePanel = require("UI/MainState/Trade/MallSimplePanel")
local MallMultiPanel = require("UI/MainState/Trade/MallMultiPanel")
local ResShop = require("ClientData/ResShop")
local ResRearHousePreview = require("ClientData/ResRearHousePreview")
local WelfareFundPanel = require("UI/Welfare/WelfareFundPanel")
local WelfareGiftPanel = require("UI/Welfare/WelfareGiftPanel")
local WelfareMonthCardPanel = require("UI/Welfare/WelfareMonthCardPanel")
local WelfareBattlePassPanel = require("UI/Welfare/WelfareBattlePassPanel")
local WelfareBPTaskPanel = require("UI/Welfare/WelfareBPTaskPanel")
local WelfareVIPPanel = require("UI/Welfare/WelfareVIPPanel")
local WelfareRicGiftPanel = require("UI/Welfare/WelfareRicGiftPanel")
local ActivityGiftPanel = require("UI/Welfare/ActivityGiftPanel")
local ActivityShopPanel = require("UI/Welfare/ActivityShopPanel")
local TurnTablePanel = require("UI/Welfare/TurnTablePanel")
local CommonAndActShopPanel = require("UI/Welfare/CommonAndActShopPanel")
local GiftRecommendPanel = require("UI/Welfare/GiftRecommendPanel")
local WelfarePrivilegeMonthCardPanel = require("UI/Welfare/WelfarePrivilegeMonthCardPanel")

local function ContentHasFund(contents)
	for _, subId in ipairs(contents or {}) do
		local subData = ResMallSubPanelConfig[subId]

		if subData and subData.pageType == Const.WELFARETYPE_FUND then
			return true
		end
	end

	return false
end

local MallTabButton = Class("MallTabButton", UIControls.Child)
local ICON_PATH = "Atlas/StoreAtlas/StoreAtlas"

function MallTabButton:ctor(...)
	self.tabBtn = UIControls.Button(self, "TabStore", "Text")

	self.tabBtn:addEventClick(self.onClickBtn)

	self.tabBtnDis = UIControls.Button(self, "TabStoreDis", "Text")

	self.tabBtnDis:addEventClick(self.onClickDisBtn)

	self.floreNum = UIControls.Label(self, "TabStore/TextFloreNum")
	self.disFloreNum = UIControls.Label(self, "TabStoreDis/TextFloreNum")
	self.iconNew = UIControls.RedDot(self, "TabStore/IconNew")
	self.imgIcon = UIControls.Image(self, "TabStore/Icon")
	self.imgIconDis = UIControls.Image(self, "TabStoreDis/Icon")
	self.isShow = false
	self.panelTimeLimit = UIControls.Panel(self, "ClockImg")
end

function MallTabButton:setData(tabData, count, index, redHint, timeLimit)
	self.isShow = true
	self.tabData = tabData

	self.tabBtn:setText(tabData.name)
	self.floreNum:setText(index - count + 1)
	self.disFloreNum:setText(index - count + 1)
	self.imgIcon:setImage(ICON_PATH, tabData.pageIcon)
	self.imgIconDis:setImage(ICON_PATH, tabData.pageIcon)
	self.iconNew:clearHint()

	if redHint then
		if ContentHasFund(tabData.contents) then
			self.iconNew:addHint({
				redHint,
				UIConst.RD_HINT_FUND_NO_BUY
			})
		else
			self.iconNew:addHint({
				redHint
			})
		end
	end

	self.panelTimeLimit:setVisible(timeLimit)
end

function MallTabButton:setLockState(isLock)
	self.tabBtn:setVisible(not isLock)
	self.tabBtnDis:setVisible(isLock)
end

function MallTabButton:setSelect(isSelected)
	self.tabBtn:setEnable(not isSelected)
end

function MallTabButton:onClickBtn(sender)
	self.mParent:onTabButtonClick(self)
end

function MallTabButton:onClickDisBtn(sender)
	return
end

function MallTabButton:onHide()
	self.isShow = false
end

local MallSubTabButton = Class("MallSubTabButton", UIControls.Child)

function MallSubTabButton:ctor(...)
	self.secTabBtn = UIControls.Button(self, "BtnNml", "Text")

	self.secTabBtn:addEventClick(self.onClickBtn)

	self.btnDis = UIControls.Button(self, "BtnDis", "Text")

	self.btnDis:addEventClick(self.onClickBtn)

	self.iconNml = UIControls.Image(self, "BtnNml/IconNml")
	self.iconSel = UIControls.Image(self, "BtnNml/IconSel")
	self.iconNew = UIControls.RedDot(self, "BtnNml/IconNew")
	self.isShow = false
	self.panelSpec = UIControls.Panel(self, "BtnNml/Text/LimitPanel")
	self.panelClock = UIControls.Panel(self, "BtnNml/Text/ClockImg")
	self.panelTimeLimit = UIControls.Panel(self, "TimeUpPanel")
	self.textTimeLimit = UIControls.Label(self, "TimeUpPanel/TiemText")
end

function MallSubTabButton:setData(configData, nextUnlockSubTabId)
	self.isLock = false

	if nextUnlockSubTabId and nextUnlockSubTabId == configData.id then
		self.isLock = true
	end

	self.isShow = true
	self.configData = configData

	self.secTabBtn:setText(configData.pageName)
	self.secTabBtn:setVisible(not self.isLock)
	self.btnDis:setVisible(self.isLock)
	self.btnDis:setText(configData.pageName)

	local strPath = "StoreTabIconAtlas"
	local strName = "BgDefault"

	if configData.iconName then
		local path = utils.splitString(configData.iconName, "/")

		if path then
			strPath = path[1]
			strName = path[2]
		end
	end

	self.iconNml:setImage("Atlas/StoreAtlas/" .. strPath, strName .. "Nml")
	self.iconSel:setImage("Atlas/StoreAtlas/" .. strPath, strName .. "Dis")
	self.iconNew:clearHint()

	if configData.redHint then
		if configData.pageType == Const.WELFARETYPE_FUND then
			self.iconNew:addHint({
				configData.redHint,
				UIConst.RD_HINT_FUND_NO_BUY
			})
		else
			self.iconNew:addHint({
				configData.redHint
			})
		end
	elseif configData.limitTypeExtra == 1 then
		local actId = configData.limitConditionExtra
		local hintId = UIConst.RD_HINT_ACTIVITY_CONFIG[actId]

		if hintId then
			self.iconNew:addHint({
				hintId
			})
		end
	end

	self:_checkActivityFlag()
	self:clearTickTimer()

	local timeLimit, timeTick = CurAvatar:checkMallSubTabTimeLimit(configData.id)

	if self.isLock == false and timeLimit then
		self.panelClock:setVisible(true)
		self.panelTimeLimit:setVisible(true)
		ClientTimerManager.AddSecondTickUI(self.textTimeLimit, timeTick, nil, "", "")
		self.iconNml:setVisible(false)
		self.iconSel:setVisible(false)
	else
		self.panelClock:setVisible(false)
		self.panelTimeLimit:setVisible(false)
		self.iconNml:setVisible(true)
		self.iconSel:setVisible(true)
	end
end

function MallSubTabButton:_checkActivityFlag()
	local actFlag = false

	if self.configData.includeGiftId then
		for _, rechargeId in ipairs(self.configData.includeGiftId) do
			if CurAvatar and CurAvatar.rechargeReplaced[rechargeId] then
				local newRechargeInfo = CurAvatar.rechargeReplaced[rechargeId]
				local actObj = newRechargeInfo[2]

				if actObj:isValid() then
					actFlag = true

					break
				end
			end
		end
	end

	self.panelSpec:setVisible(actFlag)
end

function MallSubTabButton:clearTickTimer()
	ClientTimerManager.RemoveSecondTickUI(self.textTimeLimit)
end

function MallSubTabButton:setSelect(isSelected)
	self.secTabBtn:setEnable(not isSelected)
end

function MallSubTabButton:onClickBtn()
	self.mParent:onSubTabButtonClick(self)
	CurAvatar:setUserDataMallNew(self.configData.id)
end

function MallSubTabButton:onHide()
	self.isShow = false
end

local strClassName = "MallDlgBase"
local MallDlgBase = Class(strClassName, UIControls.Window)

MallDlgBase.SubPanelTypeConfig = {
	[Const.WELFARETYPE_SHOP] = {
		PanelClass = ShopDlg
	},
	[Const.WELFARETYPE_SKINSHOP] = {
		PanelClass = ShopDlg
	},
	[Const.WELFARETYPE_RELICSHOP] = {
		PanelClass = StoreRelicPanel
	},
	[Const.WELFARETYPE_FUND] = {
		PanelClass = WelfareFundPanel
	},
	[Const.WELFARETYPE_NEWBEE] = {
		PanelClass = WelfareGiftPanel
	},
	[Const.WELFARETYPE_NEWBEE2] = {
		PanelClass = WelfareGiftPanel
	},
	[Const.WELFARETYPE_DAYBEE] = {
		PanelClass = WelfareGiftPanel
	},
	[Const.WELFARETYPE_WEEKBEE] = {
		PanelClass = WelfareGiftPanel
	},
	[Const.WELFARETYPE_MONTHBEE] = {
		PanelClass = WelfareGiftPanel
	},
	[Const.WELFARETYPE_MONTHCARD] = {
		PanelClass = WelfareMonthCardPanel
	},
	[Const.WELFARETYPE_BPAWARD] = {
		PanelClass = WelfareBattlePassPanel
	},
	[Const.WELFARETYPE_BPTASK] = {
		PanelClass = WelfareBPTaskPanel
	},
	[Const.WELFARETYPE_VIPBENEFIT] = {
		PanelClass = WelfareVIPPanel
	},
	[Const.WELFARETYPE_RECHARGEGIFT] = {
		PanelClass = WelfareRicGiftPanel
	},
	[Const.WELFARETYPE_ACTGIFT] = {
		PanelClass = ActivityGiftPanel
	},
	[Const.MALL_TYPE_JUMP_TMALL] = {
		PanelClass = MallSimplePanel
	},
	[Const.WELFARETYPE_ACTSHOP] = {
		PanelClass = ActivityShopPanel
	},
	[Const.MALL_TYPE_MULTI_TMALL] = {
		PanelClass = MallMultiPanel
	},
	[Const.WELFARETYPE_TURNTABLE] = {
		PanelClass = TurnTablePanel
	},
	[Const.WELFARETYPE_ACTTURNTABLE] = {
		PanelClass = TurnTablePanel
	},
	[Const.WELFARETYPE_MIXSHOP] = {
		PanelClass = CommonAndActShopPanel
	},
	[Const.MALL_TYPE_GIFT_RECOMMEND] = {
		PanelClass = GiftRecommendPanel
	},
	[Const.WELFARETYPE_PRIVILEGEMONTHCARD] = {
		PanelClass = WelfarePrivilegeMonthCardPanel
	}
}

function MallDlgBase:ctor(...)
	self.tabPrefabName = "System/Store/TabStore"

	self:initConfig()
	self:initUI()

	self.hasEnter = false
	self.isTabSwitch = false
end

function MallDlgBase:initConfig()
	self.startTabId = nil
	self.tabTypeConfig = {}
end

function MallDlgBase:initUI()
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self._onClickClose)

	self.panelFund = CommonFuncEntryPanel(self, "CommonFuncEntryPanel", "System/MainMenu/CommonFuncEntryPanel", 0, 0, true)

	self.panelFund:settingFunc()

	self.btnTip = UIControls.Button(self, "BtnTips")

	self.btnTip:addEventClick(self._onClickTip)

	self.panelWithChilds = UIControls.Panel(self, "MainInfoPanel/SubTabContent")
	self.panelWithChild = UIControls.Panel(self, "MainInfoPanel/TabContent")
	self.switchAnim = UIControls.UIAni(self, "MainInfoPanel/SubTabContent/Content")

	self.switchAnim:addEventFinish(Slot(self.animCreateSubPanel, self))

	if UIControls.checkControlFunc(self, "MainInfoPanel/BtnLook") then
		self.btnLook = UIControls.Button(self, "MainInfoPanel/BtnLook")

		self.btnLook:addEventClick(self.onBtnLookClick)
	end

	if UIControls.checkControlFunc(self, "MainInfoPanel/LookPanel") then
		self.panelLook = UIControls.Panel(self, "MainInfoPanel/LookPanel")
		self.btnClosePreview = UIControls.Button(self, "MainInfoPanel/LookPanel/BtnClose")

		self.btnClosePreview:addEventClick(self.onBtnClosePreviewClick)

		self.txtTitlePreview = UIControls.Label(self, "MainInfoPanel/LookPanel/TextTitle")
		self.rimgPreview = UIControls.RawImage(self, "MainInfoPanel/LookPanel/ImgBackyardLook")
	end

	self.tabBtns = {}
	self.subTabBtns = {}
	self.subPanels = {}
	self.tabData = nil
	self.panelConfigData = nil
end

function MallDlgBase:onOpen()
	MallDlgBase.super.onOpen(self)
	self:onSetTabs()
	self:openMall()
end

function MallDlgBase:openMall()
	local nowTabId = self.nowTabId

	if nowTabId then
		local curTabShow = false

		for idx, tab in ipairs(self.tabBtns) do
			if tab.tabData.id == nowTabId and tab.isShow == true then
				curTabShow = true

				break
			end
		end

		if not curTabShow then
			self.nowTabId = self.startTabId
		end
	else
		self.nowTabId = self.startTabId
	end

	self:onShow(self.nowTabId, self.nowSubTabId)
end

function MallDlgBase:onClose()
	if self.curSubPanel then
		self.curSubPanel:onClosePanel()
		self.curSubPanel:setVisible(false)
	end

	MallDlgBase.super.onClose(self)
end

function MallDlgBase:onSetTabs()
	self.mallData = {}

	local showTableData = {}

	for tabId, data in pairs(ResMall) do
		if self.tabTypeConfig[data.type] and not CurAvatar:checkMallTabLocked(data) then
			if self.startTabId == nil then
				self.startTabId = tabId
			end

			self.mallData[tabId] = data

			table.insert(showTableData, data)
		end
	end

	table.sort(showTableData, function(a, b)
		return (a.sort_id or 0) < (b.sort_id or 0)
	end)

	for index = #self.tabBtns, #showTableData - 1 do
		local newBtn = MallTabButton(self, "MainInfoPanel/TabPanel/Content", self.tabPrefabName, 0, 0, nil, nil, nil, index)

		table.insert(self.tabBtns, newBtn)
	end

	for index = 1, #self.tabBtns do
		local tabData = showTableData[index]
		local btn = self.tabBtns[index]

		if tabData then
			btn:setVisible(true)
			btn:setData(tabData, index, #showTableData, UIConst.RD_HINT_MALL_TAB[tabData.id], CurAvatar:checkMallTabTimeLimit(tabData))
		else
			btn:onHide()
			btn:setVisible(false)
		end
	end
end

function MallDlgBase:onTabButtonClick(sender)
	self.tabData = sender.tabData

	self:_setTabButton()
	self:onSubTabButtonClick(self.subTabBtns[1])

	if self.refreshBtnLaw then
		self:refreshBtnLaw(sender)
	end
end

function MallDlgBase:_setTabButton()
	for _, btn in ipairs(self.tabBtns) do
		btn:setSelect(btn.tabData.id == self.tabData.id)
	end

	self:onSetSubTabs()
end

function MallDlgBase:onSetSubTabs()
	local subConfigData = {}
	local nextUnlockSubTabId, needPreNotice

	if self.tabData.needPreNotice == 1 and #self.tabData.contents > 1 then
		needPreNotice = true
	end

	for _, subTabId in ipairs(self.tabData.contents) do
		local configData = ResMallSubPanelConfig[subTabId] or {}

		if ResMallSubPanelConfig[subTabId] then
			if CurAvatar:_checkMallLocked(subTabId, true) then
				if needPreNotice and not nextUnlockSubTabId then
					nextUnlockSubTabId = subTabId

					table.insert(subConfigData, configData)
				end
			else
				table.insert(subConfigData, configData)
			end
		else
			table.insert(subConfigData, configData)
		end
	end

	for index = #self.subTabBtns, #subConfigData - 1 do
		local newBtn = MallSubTabButton(self, "MainInfoPanel/SubTabContent/BgTab", "System/Store/SubTabStore", 0, 0, false, nil, -1, index + 1)

		table.insert(self.subTabBtns, newBtn)
	end

	for index = 1, #self.subTabBtns do
		local configData = subConfigData[index]
		local btn = self.subTabBtns[index]

		if configData then
			btn:setVisible(true)
			btn:setData(configData, nextUnlockSubTabId)
		else
			btn:onHide()
			btn:setVisible(false)
		end
	end

	self.panelWithChilds:setVisible(self.tabData.childs == 1)
	self.panelWithChild:setVisible(self.tabData.childs ~= 1)
end

function MallDlgBase:onSubTabButtonClick(sender)
	if sender.isLock then
		local limitId = sender.configData.unlockCondition

		if limitId then
			local strDesc = ConditionLimitManager.getLimitUnlockDesc(limitId)

			MsgManager.notice(strDesc)
		end

		return
	end

	if self.panelConfigData and self.panelConfigData.id then
		CurAvatar:setUserDataMallNew(self.panelConfigData.id)
	end

	self.panelConfigData = sender.configData

	self:_setSubTabButton()
	self:_refreshPreviewState()
end

function MallDlgBase:_setSubTabButton()
	for _, btn in ipairs(self.subTabBtns) do
		btn:setSelect(self.panelConfigData.id == btn.configData.id)
	end

	local actAnim = false

	if self.nowTabId == self.tabData.id then
		if self.nowSubTabId and self.nowSubTabId ~= self.panelConfigData.id and self.curSubPanel then
			actAnim = true
		else
			actAnim = false
		end
	else
		actAnim = false
	end

	self.nowTabId = self.tabData.id
	self.nowSubTabId = self.panelConfigData.id

	if actAnim then
		self.animName = "HideSubContent"

		self.switchAnim:startAni("HideSubContent", true)
	else
		if self.curSubPanel then
			self.curSubPanel:onClosePanel()
			self.curSubPanel:setVisible(false)
		end

		self:_realCreateSubPanel()
	end
end

function MallDlgBase:animCreateSubPanel()
	if self.animName == "HideSubContent" then
		if self.curSubPanel then
			self.curSubPanel:onClosePanel()
			self.curSubPanel:setVisible(false)
		end

		self:_realCreateSubPanel(Slot(self.animShowSubPanel, self))
	end
end

function MallDlgBase:animShowSubPanel()
	self.animName = "ShowSubContent"

	self.switchAnim:startAni("ShowSubContent", false)
end

function MallDlgBase:_realCreateSubPanel(funcCB)
	local subPanelType = self.panelConfigData.pageType

	if subPanelType == Const.WELFARETYPE_ACTGIFT and self.subPanels[subPanelType] then
		self.subPanels[subPanelType]:destroy()

		self.subPanels[subPanelType] = nil
	end

	if not self.subPanels[subPanelType] then
		local parentPath = "MainInfoPanel/SubTabContent/Content"

		if self.tabData.childs ~= 1 then
			parentPath = "MainInfoPanel/TabContent"
		end

		local panelClass = MallDlgBase.SubPanelTypeConfig[subPanelType].PanelClass
		local subPanel = panelClass(self, parentPath, self.panelConfigData.prePath .. self.panelConfigData.preName, 0, 0, true)

		subPanel:initPanelData(self.tabData, self.panelConfigData)

		self.subPanels[subPanelType] = subPanel
	end

	self.curSubPanel = self.subPanels[subPanelType]

	self.curSubPanel:openPanelData(self.tabData, self.panelConfigData)
	self.curSubPanel:setVisible(true)

	if funcCB then
		funcCB()
	end
end

function MallDlgBase:showShop(shopID)
	for tabId, tabInfo in pairs(ResMall) do
		for _, panelId in ipairs(tabInfo.contents or {}) do
			local panelDta = ResMallSubPanelConfig[panelId]

			if panelDta and panelDta.pageType == Const.WELFARETYPE_SHOP and shopID == panelDta.arg1 then
				self:onShow(tabId, panelId)

				return
			end
		end
	end
end

function MallDlgBase:onShow(tabId, subTabId)
	if self:isInShow() then
		if self.mallData[tabId] then
			self.tabData = ResMall[tabId]

			self:_setTabButton()

			for _, btn in ipairs(self.subTabBtns) do
				if btn.isShow and btn.configData and (subTabId == nil or btn.configData.id == subTabId) then
					self:onSubTabButtonClick(btn)

					return
				end
			end

			self:onSubTabButtonClick(self.subTabBtns[1])
		elseif self.startTabId ~= tabId then
			self:onShow(self.startTabId)
		end
	else
		self.nowTabId = tabId
		self.nowSubTabId = subTabId
	end
end

function MallDlgBase:onShowByJump(jumpStr, extraSrcFunc, extraSrcArgs)
	local strID = utils.splitString(jumpStr, ",")
	local tabId = tonumber(strID[1])
	local subTabId = tonumber(strID[2])

	if ResMall[tabId] then
		self:onShow(tabId, subTabId)

		if extraSrcFunc and self.curSubPanel[extraSrcFunc] then
			self.curSubPanel[extraSrcFunc](self.curSubPanel, extraSrcArgs)
		end
	end
end

function MallDlgBase:activityStateShow(actObj, extraStateArgs)
	if extraStateArgs then
		local extraSrcFunc = extraStateArgs[1]
		local extraSrcArgs = extraStateArgs[2]

		if extraSrcFunc and self.curSubPanel[extraSrcFunc] then
			self.curSubPanel[extraSrcFunc](self.curSubPanel, extraSrcArgs)
		end
	end
end

function MallDlgBase:onShowActivity(pageData)
	local clientTemplateData = pageData[1]
	local jumpStr = clientTemplateData.template_args

	if jumpStr then
		self:onShow(tonumber(jumpStr[1]), tonumber(jumpStr[2]))
	end
end

function MallDlgBase:updateActivityData(actObj)
	CurAvatar:refreshActGiftData(actObj)

	local State = actObj:getState()

	if State ~= Const.OPACT_STATE_OPEN then
		self:onSetTabs()
		self:openMall()
		MsgManager.notice(Lang.get(1870))
	end
end

function MallDlgBase:updateRelatedActivityData(actObj)
	CurAvatar:refreshActGiftData(actObj)

	local State = actObj:getState()

	if State ~= Const.OPACT_STATE_OPEN then
		self:onSetTabs()
		self:openMall()
		MsgManager.notice(Lang.get(1870))
	end
end

function MallDlgBase:onShopEnterResp(shopID, shopItems)
	local shopType = Const.WELFARETYPE_SHOP

	if ResShop[shopID] and ResShop[shopID].type == Const.SHOP_ENTER_TYPE_SKIN then
		shopType = Const.WELFARETYPE_SKINSHOP
	end

	if ResShop[shopID] and ResShop[shopID].type == Const.SHOP_ENTER_TYPE_RELIC then
		shopType = Const.WELFARETYPE_RELICSHOP
	end

	if ResShop[shopID] and ResShop[shopID].type == Const.SHOP_ENTER_TYPE_MIXED then
		shopType = Const.WELFARETYPE_MIXSHOP
	end

	if self.subPanels[shopType] then
		self.subPanels[shopType]:onShopEnterResp(shopID, shopItems)
	end
end

function MallDlgBase:onTurnTableDrawResp(items)
	local shopType = Const.WELFARETYPE_TURNTABLE

	if self.curSubPanel and self.curSubPanel.onTurnTableDrawResp then
		self.curSubPanel:onTurnTableDrawResp(items)
	end
end

function MallDlgBase:updateItem(serverItemInfo)
	for shopType, _ in pairs(Const.SHOP_ENTER_WELFARETYPE_DIC) do
		if self.subPanels[shopType] then
			self.subPanels[shopType]:updateItem(serverItemInfo)
		end
	end
end

function MallDlgBase:_onClickClose(sender)
	self:setVisible(false)
	self:recoverManualReject()
end

function MallDlgBase:_onClickTip(sender)
	local id = self.panelConfigData.tipId or 10

	UIManager.getUI("infoNotice", true):showSystemInfo(id)
end

function MallDlgBase:destroy()
	for _, sBtn in pairs(self.subTabBtns) do
		sBtn:clearTickTimer()
	end

	for _, panel in pairs(self.subPanels) do
		panel:onDestroy()
	end

	MallDlgBase.super.destroy(self)
end

function MallDlgBase:refreshWelData(type, doCB)
	if self.subPanels[type] then
		self.subPanels[type]:refreshData(doCB)
	end
end

function MallDlgBase:onNewDay()
	for _, welPanel in pairs(self.subPanels) do
		welPanel:onNewDay()
	end
end

function MallDlgBase:_refreshPreviewState(...)
	local id

	self.preViewData = nil

	if self.panelConfigData then
		id = self.panelConfigData.id

		for i, info in ipairs(ResRearHousePreview) do
			if info.sub_id == id then
				self.preViewData = info

				break
			end
		end
	end

	if not self.preViewData and self.tabData then
		id = self.tabData.id

		for i, info in ipairs(ResRearHousePreview) do
			if info.main_id == id then
				self.preViewData = info

				break
			end
		end
	end

	if self.preViewData then
		local showPreview = self.preViewData ~= nil and self.preViewData.preview == 1

		if self.btnLook then
			self.btnLook:setVisible(showPreview)
		end
	elseif self.btnLook then
		self.btnLook:setVisible(false)
	end
end

function MallDlgBase:onBtnLookClick(...)
	if self.preViewData then
		self.rimgPreview:setImage(self.preViewData.icon_path)

		if self.tabData then
			self.txtTitlePreview:setText(self.tabData.name)
		end

		self.panelLook:setVisible(true)
	end
end

function MallDlgBase:onBtnClosePreviewClick(...)
	self.panelLook:setVisible(false)
end

return MallDlgBase
