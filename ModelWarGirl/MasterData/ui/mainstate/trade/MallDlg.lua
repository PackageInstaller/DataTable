-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\Trade\\MallDlg.lua

local UIControls = UIControls
local MallDlgBase = require("UI/MainState/Trade/MallDlgBase")
local VersionUtils = require("System/VersionUtils")
local ResClientHardCode = require("ClientData/ResClientHardCode")
local strClassName = "MallDlg"
local MallDlg = Class(strClassName, MallDlgBase)

function MallDlg:ctor()
	return
end

function MallDlg:initConfig()
	self.startTabId = 1
	self.tabTypeConfig = {
		[1] = true,
		[2] = true
	}
end

function MallDlg:onOpen()
	CurAvatar:initMallClientData()
	self:checkRDhint()
	MallDlg.super.onOpen(self)
end

function MallDlg:initUI()
	MallDlg.super.initUI(self)

	self.btnStore = UIControls.Button(self, "MainInfoPanel/BtnStore")

	self.btnStore:addEventClick(self.onStoreClick)

	if ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_ACTIVITY_STORE) then
		self.btnStore:setVisible(false)
	else
		self.btnStore:setVisible(true)
	end

	self.panelQQVip = UIControls.Panel(self, "QQVipPanel")
	self.btnJoinQQVip = UIControls.Button(self, "QQVipPanel/BtnJoin")

	self.btnJoinQQVip:addEventClick(self.onJoinQQVipClicked)
	self.panelQQVip:setVisible(ChannelUtil.isQQGame())

	self.jpPanel = UIControls.Panel(self, "MainInfoPanel/JPFuncPanel")
	self.btnLaw = UIControls.Button(self, "MainInfoPanel/JPFuncPanel/BtnLaw", "Text")

	self.btnLaw:addEventClick(self.jpLaw)
end

function MallDlg:onJoinQQVipClicked()
	local QQGameHelper = require("Helper/QQGameHelper")

	QQGameHelper.joinVip()
end

function MallDlg:onStoreClick()
	UIManager.getUI("activityMallDlg", true):onShow(50, 200)
end

function MallDlg:checkRDhint()
	return
end

function MallDlg:refreshBtnLaw(sender)
	if VersionUtils.IsReviewVersion() then
		self.jpPanel:setVisible(false)

		return
	end

	local storeIdx = sender and sender.tabData and sender.tabData.id or -1

	if storeIdx == 2 or storeIdx == 3 or storeIdx == 4 then
		if not RegionUtils.isCN() then
			self.jpPanel:setVisible(true)
		end
	else
		self.jpPanel:setVisible(false)
	end

	if RegionUtils.isTW() then
		self.btnLaw:setText(Lang.get(42785))
		self.jpPanel:setVisible(false)
	elseif RegionUtils.isSEA() then
		self.btnLaw:setText("Recharge")
		self.jpPanel:setVisible(false)
	elseif RegionUtils.isJP() then
		-- block empty
	end
end

function MallDlg:jpLaw()
	if RegionUtils.isJP() then
		UIManager.getUI("storeLawJP", true, true)
	elseif RegionUtils.isTW() then
		local clientHardCode = ResClientHardCode[12] and ResClientHardCode[12].desc[1] or nil

		CurAvatar:jumpToOpenWebUrl(clientHardCode)
	elseif RegionUtils.isKR() then
		UIManager.getUI("infoNotice", true):showSystemInfo(206)
	elseif RegionUtils.isSEA() then
		local clientHardCode = ResClientHardCode[14] and ResClientHardCode[14].desc[1] or nil

		CurAvatar:jumpToOpenWebUrl(clientHardCode)
	end
end

function MallDlg:onClose()
	CueManager.stopVocal()
	MallDlg.super.onClose(self)
end

return MallDlg
