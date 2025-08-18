-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\CircleMainDlg.lua

local ResClanLevel = require("ClientData/ResClanLevel")
local ResClanMisc = require("ClientData/ResClanMisc")
local ResRandClient = require("ClientData/ResRandClient")
local FlyIconUtils = require("UI/Common/FlyIconUtils")
local strClassName = "CircleTipsMoneyPanel"
local CircleTipsMoneyPanel = Class(strClassName, UIControls.Panel)

function CircleTipsMoneyPanel:ctor()
	self:initUI()
end

function CircleTipsMoneyPanel:initUI()
	self.txtMoney = UIControls.Label(self, self.mPath .. "/TextContent/TextMoney/TextNum")
	self.txtActivity1 = UIControls.Label(self, self.mPath .. "/TextContent/TextActivity1/TextNum")
	self.txtActivity2 = UIControls.Label(self, self.mPath .. "/TextContent/TextActivity2/TextNum")
end

function CircleTipsMoneyPanel:refreshTipsLvPanel()
	self.circle = self.mWindow.circle
	self.curLvInfo = ResClanLevel[self.circle.level]

	self.txtMoney:setText(self.curLvInfo.fund_limit)

	local member = self.circle:getCircleMember(CurAvatar.uid)

	if member then
		self.txtActivity1:setText(member.dayfeat .. "/" .. ResClanMisc[1].feat_limit)
		self.txtActivity2:setText(member.weekfeat .. "/" .. ResClanMisc[1].feat_limit * 7)
	end
end

local strClassName = "CircleTipsLVPanel"
local CircleTipsLVPanel = Class(strClassName, UIControls.Panel)

function CircleTipsLVPanel:ctor()
	self:initUI()
end

function CircleTipsLVPanel:initUI()
	self.panelTextContent = UIControls.Panel(self, self.mPath .. "/TextContent")
	self.txtMemberPlus = UIControls.Label(self, self.mPath .. "/TextContent/TextMember/TextNum")
	self.txtMoneyPlus = UIControls.Label(self, self.mPath .. "/TextContent/TextMoney/TextNum")
	self.txtAwardPlus = UIControls.Label(self, self.mPath .. "/TextContent/TextAward/TextNum")
	self.txtMaxed = UIControls.Label(self, self.mPath .. "/TextMaxed")
end

function CircleTipsLVPanel:refreshTipsLvPanel()
	self.circle = self.mWindow.circle

	if self.circle.level == #ResClanLevel then
		self.txtMaxed:setVisible(true)
		self.panelTextContent:setVisible(false)
	else
		self.nextLevelInfo = ResClanLevel[self.circle.level + 1]
		self.curLvInfo = ResClanLevel[self.circle.level]

		self.txtMemberPlus:setText("+" .. self.nextLevelInfo.member_num - self.curLvInfo.member_num)
		self.txtMoneyPlus:setText("+" .. self.nextLevelInfo.fund_limit - self.curLvInfo.fund_limit)

		local curAwardId = self.curLvInfo.checkin_award
		local itemId = ResRandClient[curAwardId].show_ids[1]
		local itemNumCur = ResRandClient[curAwardId].show_nums[1]
		local itemNumNext = ResRandClient[self.nextLevelInfo.checkin_award].show_nums[1]

		self.txtAwardPlus:setText("+" .. itemNumNext - itemNumCur)
	end
end

local CircleApplyListPanel = require("UI/Circle/CircleApplyListPanel")
local CircleActivityPanel = require("UI/Circle/CircleActivityPanel")
local CircleHomePagePanel = require("UI/Circle/CircleHomePagePanel")
local CircleMemberListPanel = require("UI/Circle/CircleMemberListPanel")
local CONTENTP_PANEL_DIC = {
	[Const.CIRCLE_ACTIVITY_PANEL] = {
		panelPath = "ActivityPanel",
		btnName = "Btn1",
		luaTable = CircleActivityPanel
	},
	[Const.CIRCLE_HOMEPAGE_PANEL] = {
		panelPath = "HomePageListPanel",
		btnName = "Btn2",
		luaTable = CircleHomePagePanel
	},
	[Const.CIRCLE_MEMBER_LIST_PANEL] = {
		panelPath = "MemberListPanel",
		btnName = "Btn3",
		luaTable = CircleMemberListPanel
	},
	[Const.CIRCLE_APPLY_LIST_PANEL] = {
		panelPath = "ApplyListPanel",
		btnName = "Btn4",
		luaTable = CircleApplyListPanel
	}
}
local strClassName = "CircleMainDlg"
local CircleMainDlg = Class(strClassName, UIControls.Window)

function CircleMainDlg:ctor()
	self:initUI()
end

function CircleMainDlg:initUI()
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.txtName = UIControls.Label(self, "MainInfoPanel/CircleInfoPanel/CircleNamePanel/TextName")
	self.btnCircleHead = UIControls.Button(self, "MainInfoPanel/CircleInfoPanel/CircleNamePanel/BtnEditHead")

	self.btnCircleHead:addEventClick(self.onBtnCircleHeadClick)

	self.redCircleHead = UIControls.RedDot(self, "MainInfoPanel/CircleInfoPanel/CircleNamePanel/BtnEditHead/IconNew")

	self.redCircleHead:addHint({
		UIConst.RD_HINT_CIRCLE_EDIT_HEAD
	})

	self.imgIconHead = UIControls.Image(self, "MainInfoPanel/CircleInfoPanel/CircleNamePanel/IconCircleHead")
	self.txtId = UIControls.Label(self, "MainInfoPanel/CircleInfoPanel/CircleNamePanel/IDPanel/TextNum")
	self.txtLeaderName = UIControls.Label(self, "MainInfoPanel/CircleInfoPanel/BtnLeader/TextName")
	self.imgLeaderSex = UIControls.Image(self, "MainInfoPanel/CircleInfoPanel/BtnLeader/IconSex")
	self.panelLeaderVip = UIControls.PanelPlayerVip(self, "MainInfoPanel/CircleInfoPanel/BtnLeader/TextName/VIPPanel")
	self.txtLv = UIControls.Label(self, "MainInfoPanel/CircleInfoPanel/InfoPanel/BtnLV/TextLV")
	self.txtExp = UIControls.Label(self, "MainInfoPanel/CircleInfoPanel/InfoPanel/BtnLV/SliderExp/TextNum")
	self.sliderExp = UIControls.Slider(self, "MainInfoPanel/CircleInfoPanel/InfoPanel/BtnLV/SliderExp")
	self.txtFund = UIControls.Label(self, "MainInfoPanel/CircleInfoPanel/InfoPanel/BtnMoney/TextNum")
	self.txtSignNum = UIControls.Label(self, "MainInfoPanel/CircleInfoPanel/InfoPanel/SignPanel/TextNum")
	self.txtCirlceTitle = UIControls.Label(self, "MainInfoPanel/ContentPanel/NoticePanel/TextPanel/TextTitle")
	self.txtCirlceContent = UIControls.Label(self, "MainInfoPanel/ContentPanel/NoticePanel/TextPanel/TextContent")
	self.btnSign = UIControls.Button(self, "MainInfoPanel/CircleInfoPanel/BtnSign", "Text")

	self.btnSign:addEventClick(self.onBtnSignClick)

	self.signRD = UIControls.RedDot(self, "MainInfoPanel/CircleInfoPanel/BtnSign/IconNew")

	self.signRD:addHint({
		UIConst.RD_HINT_CIRCLE_SIGN
	})

	self.panelHead = UIControls.Panel(self, "CircleHeadPanel")
	self.btnSearch = UIControls.Button(self, "BtnSearch")

	self.btnSearch:addEventClick(self.onBtnSearchClick)

	self.rawImgBanner = UIControls.RawImage(self, "MainInfoPanel/BannerCircle")
	self.panelNotice = UIControls.Panel(self, "MainInfoPanel/ContentPanel/NoticePanel")
	self.btnName = UIControls.Button(self, "MainInfoPanel/CircleInfoPanel/CircleNamePanel/BtnEditName")

	self.btnName:addEventClick(self.onBtnNameClick)

	self.btnEditNotice = UIControls.Button(self, "MainInfoPanel/ContentPanel/NoticePanel/BtnEdit")

	self.btnEditNotice:addEventClick(self.onBtnEditNoticeClick)

	self.btnMail = UIControls.Button(self, "BtnMail")

	self.btnMail:addEventClick(self.onBtnMailClick)

	self.btnManagerClose = UIControls.Button(self, "MainInfoPanel/ContentPanel/UIClickThrough")

	self.btnManagerClose:addEventClick(self.onBtnManagerCloseClick)

	self.btnAppoint = UIControls.Button(self, "MainInfoPanel/ContentPanel/ListTypePanel/BtnType3")

	self.btnAppoint:addEventClick(self.onBtnAppointClick)

	self.btnKick = UIControls.Button(self, "MainInfoPanel/ContentPanel/ListTypePanel/BtnType1")

	self.btnKick:addEventClick(self.onBtnKickClick)

	self.btnFire = UIControls.Button(self, "MainInfoPanel/ContentPanel/ListTypePanel/BtnType2")

	self.btnFire:addEventClick(self.onBtnFireClick)

	self.btnLv = UIControls.Button(self, "MainInfoPanel/CircleInfoPanel/InfoPanel/BtnLV")

	self.btnLv:addEventClick(self.onBtnLvClick)

	self.btnMoney = UIControls.Button(self, "MainInfoPanel/CircleInfoPanel/InfoPanel/BtnMoney")

	self.btnMoney:addEventClick(self.onBtnMoneyClick)

	self.panelManager = UIControls.Panel(self, "MainInfoPanel/ContentPanel/ListTypePanel")
	self.panelTipsLv = CircleTipsLVPanel(self, "MainInfoPanel/TipsLVPanel")
	self.panelTipsMoney = CircleTipsMoneyPanel(self, "MainInfoPanel/TipsMoneyPanel")
	self.panelTipsActive = UIControls.Panel(self, "MainInfoPanel/ContentPanel/TipsActivePanel")
	self.panelTipsJob = UIControls.Panel(self, "MainInfoPanel/ContentPanel/TipsJobPanel")
	self.txtTipsJobTitle = UIControls.Label(self, "MainInfoPanel/ContentPanel/TipsJobPanel/TextTitle")
	self.txtTipsJobContent = UIControls.Label(self, "MainInfoPanel/ContentPanel/TipsJobPanel/TextContent")
	self.btnClosePanelTips = UIControls.Button(self, "MainInfoPanel/UIClickThrough")

	self.btnClosePanelTips:addEventClick(self.onBtnClosePanelTipsClick)

	self.btnAche = UIControls.Button(self, "BtnAche")

	self.btnAche:addEventClick(self.onBtnAcheClick)
	self.btnAche:setVisible(Const.FORCE_OPEN_CIRCLE_BATTLE)

	self.btnAdvertise = UIControls.Button(self, "MainInfoPanel/CircleInfoPanel/BtnAdvertise")

	self.btnAdvertise:addEventClick(self.onBtnAdvertiseClick)

	self.btnTabList = {}
	self.contentPanelList = {}
	self.imgIconNewApply = UIControls.Panel(self, "MainInfoPanel/ContentPanel/TabPanel/Btn4/IconNew")

	for idx, panelInfo in ipairs(CONTENTP_PANEL_DIC) do
		local btnContentTab = UIControls.Button(self, "MainInfoPanel/ContentPanel/TabPanel/" .. panelInfo.btnName)

		btnContentTab:addEventClick(self.onBtnContentTabClick)

		self.btnTabList[idx] = btnContentTab

		local contentPanel = panelInfo.luaTable(self, "MainInfoPanel/ContentPanel/" .. panelInfo.panelPath)

		self.contentPanelList[idx] = contentPanel
	end

	self:onBtnContentTabClick(self.btnTabList[1])
end

function CircleMainDlg:onBtnContentTabClick(sender)
	for idx, btn in ipairs(self.btnTabList) do
		self.contentPanelList[idx]:setVisible(btn == sender)
		btn:setEnable(btn ~= sender)

		if btn == sender then
			self.panelNotice:setVisible(idx == Const.CIRCLE_ACTIVITY_PANEL or idx == Const.CIRCLE_HOMEPAGE_PANEL)

			if self.circle then
				self.contentPanelList[idx]:setCircle(self.circle)
			end
		end
	end
end

function CircleMainDlg:onBtnSignClick()
	if CurAvatar:isSigned() then
		MsgManager.clientNotice(231)

		return
	end

	RPC.clanCheckin()
end

function CircleMainDlg:flyCircleGold(num)
	FlyIconUtils.sendFlyEvent(self.btnSign, Const.MONEY_ID_CIRCLE_COIN, num)
end

function CircleMainDlg:onBtnSearchClick()
	local circleListDlg = UIManager.getUI("circleListDlg", true)

	circleListDlg:setOnlyShowMode()
end

function CircleMainDlg:onOpen()
	CircleMainDlg.super.onOpen(self)

	for _, contentPanel in ipairs(self.contentPanelList) do
		if contentPanel:getVisible() and contentPanel.onRefresh then
			contentPanel:onRefresh()
		end
	end
end

function CircleMainDlg:openManageMember(managedMember, btnManager)
	self.managedMember = managedMember

	local btnPos = btnManager:getAbsPosition()

	self.panelManager:setAbsPosition(btnPos.x, btnPos.y + 0.58)
	self.panelManager:setVisible(true)

	local canKick, canFire, canAppoint = CurAvatar:getManageMemberPermission(self.managedMember.duty)

	self.btnKick:setVisible(canKick)
	self.btnFire:setVisible(canFire)
	self.btnAppoint:setVisible(canAppoint)
	self.btnManagerClose:setVisible(true)
end

function CircleMainDlg:openTipsJobPanel(memberCell, duty)
	local cellPos = memberCell:getAbsPosition()

	self.panelTipsJob:setAbsPosition(cellPos.x, cellPos.y + 0.65)
	self.panelTipsJob:setVisible(true)
	self.btnClosePanelTips:setVisible(true)
	self.txtTipsJobTitle:setText(Const.CIRCLE_DUTY_NAME_DIC[duty])
	self.txtTipsJobContent:setText(Const.CIRCLE_DUTY_DES_DIC[duty])
end

function CircleMainDlg:openTipsActivePanel(memberCell)
	local cellPos = memberCell:getAbsPosition()

	self.panelTipsActive:setAbsPosition(cellPos.x, cellPos.y + 0.25)
	self.panelTipsActive:setVisible(true)
	self.btnClosePanelTips:setVisible(true)
end

function CircleMainDlg:onBtnManagerCloseClick()
	self.panelManager:setVisible(false)
	self.btnManagerClose:setVisible(false)
end

function CircleMainDlg:onBtnClosePanelTipsClick()
	self.btnClosePanelTips:setVisible(false)
	self.panelTipsLv:setVisible(false)
	self.panelTipsMoney:setVisible(false)
	self.panelTipsActive:setVisible(false)
	self.panelTipsJob:setVisible(false)
end

function CircleMainDlg:onBtnAcheClick()
	if CurAvatar.myCircle then
		local circleAchievementDlg = UIManager.getUI("circleAchievementDlg", true)

		circleAchievementDlg:setAchievementData(CurAvatar:getCircleHeadConditionDataList())
	end
end

function CircleMainDlg:onBtnAppointClick()
	local circleAppointDlg = UIManager.getUI("circleAppointDlg", true)

	circleAppointDlg:setManagedMember(self.managedMember)
end

function CircleMainDlg:onBtnKickClick()
	local function yesFunc()
		RPC.clanKick(self.managedMember.base.uid)
	end

	local name, serverName = utils.GetPlayerName(self.managedMember.base.name)
	local msgContent = string.format(Lang.get(30193), name)

	UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "", msgContent, yesFunc, nil, -1)
end

function CircleMainDlg:onBtnFireClick()
	RPC.clanAppoint(self.managedMember.base.uid, Const.CIRCLE_DUTY_MEMBER)
end

function CircleMainDlg:onBtnLvClick()
	self.panelTipsLv:setVisible(true)
	self.btnClosePanelTips:setVisible(true)
end

function CircleMainDlg:onBtnMoneyClick()
	self.panelTipsMoney:setVisible(true)
	self.btnClosePanelTips:setVisible(true)
end

function CircleMainDlg:setCircle(circle)
	self.circle = circle

	self:refreshCircleBaseInfo()
	self:refreshLeaderInfo()
	self:refreshContentPanel()
end

function CircleMainDlg:simpleRefreshCircle(circle)
	self.circle = circle

	self:refreshCircleBaseInfo()
end

function CircleMainDlg:refreshApplyHint()
	self.imgIconNewApply:setVisible(#self.circle:getApplyRoleList() ~= 0)
end

function CircleMainDlg:refreshContentPanel()
	for _, contentPanel in ipairs(self.contentPanelList) do
		if contentPanel:getVisible() then
			contentPanel:setCircle(self.circle)
		end
	end

	self:refreshApplyHint()
end

function CircleMainDlg:refreshCircleBaseInfo()
	self:onBtnManagerCloseClick()
	self:onBtnClosePanelTipsClick()
	self.btnTabList[Const.CIRCLE_APPLY_LIST_PANEL]:setVisible(CurAvatar:getMyDutyPermission().accept_join ~= nil)
	self.txtName:setText(self.circle.name)

	if Const.FORCE_OPEN_CIRCLE_BATTLE then
		if not self.gridCircle then
			self.gridCircle = UIControls.GridCircleCommonChild(self, "CircleHeadPanel", "System/Common/Grid/GridCircleCommon", 0, 0, true)

			self.gridCircle.btnSelf:setEnable(false)
		end

		self.panelHead:setVisible(true)
		self.gridCircle:setCircle(self.circle)
		self.imgIconHead:setVisible(false)
	else
		local spriteInfo = self.circle:getCircleHeadPath()

		if spriteInfo then
			self.imgIconHead:setImage(spriteInfo[1], spriteInfo[2])
		end
	end

	self.panelTipsLv:refreshTipsLvPanel()
	self.panelTipsMoney:refreshTipsLvPanel()
	self.txtId:setText(self.circle.gid)
	self.txtLv:setText(string.format(Lang.get(30171), self.circle.level))

	if self.circle.level == #ResClanLevel then
		local curMax = ResClanLevel[self.circle.level - 1] and ResClanLevel[self.circle.level - 1].need_xp or 0
		local lastMax = ResClanLevel[self.circle.level - 2] and ResClanLevel[self.circle.level - 2].need_xp or 0
		local curExp = self.circle.exp - lastMax

		self.txtExp:setText(Lang.get(467))
		self.sliderExp:setValue(1)
	else
		local curExp = self.circle.exp - self.circle:getCurLvExp()

		self.txtExp:setText(curExp .. "/" .. self.circle:getNextLvExp() - self.circle:getCurLvExp())
		self.sliderExp:setValue(curExp / (self.circle:getNextLvExp() - self.circle:getCurLvExp()))
	end

	self.txtFund:setText(self.circle.fund .. "/" .. self.circle:getFundUpLimit())
	self.txtSignNum:setText(self.circle.signNum .. "/" .. self.circle.memberCount)
	self.txtCirlceTitle:setText(utils.replaceString(self.circle.title, "\n", ""))
	self.txtCirlceContent:setText(utils.replaceString(self.circle.notice, "\n", ""))
	self:refreshCheckAdvertise()

	if CurAvatar:isSigned() then
		self.btnSign:setText(Lang.get(30194))
		self.btnSign:setEnable(false)
	else
		self.btnSign:setEnable(true)
		self.btnSign:setText(Lang.get(788))
	end

	self.btnName:setVisible(CurAvatar:getMyDutyPermission().rename ~= nil)
	self.btnEditNotice:setVisible(CurAvatar:getMyDutyPermission().renotice ~= nil)
	self.btnMail:setVisible(CurAvatar:getMyDutyPermission().send_mail ~= nil)
	self.btnCircleHead:setVisible(CurAvatar:getMyDutyPermission().rehead ~= nil)

	local rawImgPath = self.circle:getBannerPath()

	if rawImgPath then
		self.rawImgBanner:setImage(rawImgPath)
	end
end

function CircleMainDlg:refreshLeaderInfo()
	local leader = self.circle:getCircleLeader()

	if leader.base.gender == Const.GENDER_MAN then
		self.imgLeaderSex:setImage("Atlas/FriendAtlas/FriendAtlas", "IconMale")
	else
		self.imgLeaderSex:setImage("Atlas/FriendAtlas/FriendAtlas", "IconFemale")
	end

	local name, serverName = utils.GetPlayerName(leader.base.name)

	self.txtLeaderName:setText(name)
	self.panelLeaderVip:setData(leader.base.vip, leader.base.vip_hide)

	self.gridLeader = UIControls.PlayerHeadGridChild(self, "MainInfoPanel/CircleInfoPanel/BtnLeader/GridPlayerCommon", "System/Common/Grid/GridPlayerCommon", 0, 0, true)

	self.gridLeader:hideLevel()
	self.gridLeader:setEnable(false)
	self.gridLeader:setCommInfo(leader.base, false, self)
end

function CircleMainDlg:refreshCheckAdvertise(...)
	if RegionUtils.isJP() then
		self.btnAdvertise:setVisible(false)

		return
	end

	local show = false

	if CurAvatar:getMyDutyPermission().advertise ~= nil then
		show = true
	end

	self.btnAdvertise:setVisible(show)
end

function CircleMainDlg:onBtnAdvertiseClick(...)
	if CurAvatar.myCircle.shareTick + ResClanMisc[1].share_cd > ClientUtils.getServerTime() then
		MsgManager.clientNotice(606)

		return
	end

	UIManager.getUI("editCircleShareDlg", true)
end

function CircleMainDlg:onBtnMailClick()
	if CurAvatar.myCircle then
		local circleEditMailDlg = UIManager.getUI("circleEditMailDlg", true)
	end
end

function CircleMainDlg:onBtnCircleHeadClick()
	if Const.FORCE_OPEN_CIRCLE_BATTLE then
		if CurAvatar.myCircle then
			local editCircleHeadDlg = UIManager.getUI("editCircleHeadDlg", true)
		end
	elseif CurAvatar.myCircle then
		local circleEditHeadDlg = UIManager.getUI("circleEditHeadDlg", true)
	end
end

function CircleMainDlg:onBtnNameClick()
	local result, desc = ClientUtils.isForbideModifyInfo()

	if result then
		MsgManager.notice(desc)

		return
	end

	if CurAvatar.myCircle then
		local circleEditNameDlg = UIManager.getUI("circleEditNameDlg", true)
	end
end

function CircleMainDlg:onBtnEditNoticeClick()
	local result, desc = ClientUtils.isForbideModifyInfo()

	if result then
		MsgManager.notice(desc)

		return
	end

	if CurAvatar.myCircle then
		local circleEditNoticeDlg = UIManager.getUI("circleEditNoticeDlg", true)
	end
end

function CircleMainDlg:onBtnCloseClick()
	self:setVisible(false)
end

return CircleMainDlg
