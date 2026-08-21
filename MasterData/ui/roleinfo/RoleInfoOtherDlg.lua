-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\RoleInfo\\RoleInfoOtherDlg.lua

local RoleInfoPanelMixin = require("UI/RoleInfo/RoleInfoPanelMixin")
local RoleInfoTab = require("UI/RoleInfo/RoleInfoTab")
local ResMasterMisc = require("ClientData/ResMasterMisc")
local strClassName = "RoleInfoOtherDlg"
local OPERA = {}

OPERA.ADD_BLACK = 1
OPERA.DEL_BLACK = 2
OPERA.ADD_SHIELD = 3
OPERA.DEL_SHIELD = 4

local RoleInfoOtherDlg = Class(strClassName, UIControls.Window)

MixinClass(RoleInfoOtherDlg, RoleInfoPanelMixin, true)

function RoleInfoOtherDlg:ctor(...)
	self:ctorMixin()
	self:initUI()
	self:initData()
end

function RoleInfoOtherDlg:initUI(...)
	self.inforPanel = UIControls.Panel(self, "InforPanel")
	self.btnChat = UIControls.Button(self, "InforPanel/BtnFuncPanel/BtnChat")

	self.btnChat:addEventClick(self.onBtnChatClick)

	self.btnRequest = UIControls.Button(self, "InforPanel/BtnFuncPanel/BtnRequest", "Text")

	self.btnRequest:addEventClick(self.onBtnRequestClick)

	self.btnBlackList = UIControls.Button(self, "InforPanel/BtnFuncPanel/BtnBlacklist", "Text")

	self.btnBlackList:setVisible(false)

	self.btnDel = UIControls.Button(self, "InforPanel/BtnFuncPanel/BtnDel")

	self.btnDel:addEventClick(self.onBtnDelClick)

	self.panelFunc = UIControls.Panel(self, "InforPanel/BtnFuncPanel")
	self.btnShield = UIControls.Button(self, "InforPanel/BtnFuncPanel/BtnShield", "Text")

	self.btnShield:addEventClick(self.onBtnShieldClick)

	self.txtProgress = UIControls.Label(self, "InforPanel/DetailPanel/TextProgress/Text")
	self.btnGmBanChat1 = UIControls.Button(self, "InforPanel/BtnFuncPanel/BtnGM1h")

	self.btnGmBanChat1:addEventClick(self.onBtnGmBanChat1Click)

	self.btnGmBanChat2 = UIControls.Button(self, "InforPanel/BtnFuncPanel/BtnGM24h")

	self.btnGmBanChat2:addEventClick(self.onBtnGmBanChat2Click)

	self.btnGmBanChat3 = UIControls.Button(self, "InforPanel/BtnFuncPanel/BtnGM72h")

	self.btnGmBanChat3:addEventClick(self.onBtnGmBanChat3Click)

	self.btnGmBanChat4 = UIControls.Button(self, "InforPanel/BtnFuncPanel/BtnGMBan")

	self.btnGmBanChat4:addEventClick(self.onBtnGmBanChat4Click)

	self.btnGmBanChat5 = UIControls.Button(self, "InforPanel/BtnFuncPanel/BtnGMUnBan")

	self.btnGmBanChat5:addEventClick(self.onBtnGmBanChat5Click)

	self.imgBgEnUp = UIControls.Image(self, "BgText/TextEngUp")
	self.imgBgEnDown = UIControls.Image(self, "BgText/TextEngDown")
	self.imgBg = UIControls.Image(self, "InforPanel/Bg/BgImg")
	self.btnCircleInvite = UIControls.Button(self, "InforPanel/BtnFuncPanel/BtnCircleInvite", "Text")

	self.btnCircleInvite:addEventClick(self.onBtnCircleInviteClick)

	self.btnAddMaster = UIControls.Button(self, "InforPanel/BtnFuncPanel/BtnStudentFind")

	self.btnAddMaster:addEventClick(self.onClickBtnAddMaster)

	self.btnAddApprentice = UIControls.Button(self, "InforPanel/BtnFuncPanel/BtnTeacherFind")

	self.btnAddApprentice:addEventClick(self.onClickBtnAddApprentice)

	self.btnDeleteMasterApprentice = UIControls.Button(self, "InforPanel/BtnFuncPanel/BtnBreakup")

	self.btnDeleteMasterApprentice:addEventClick(self.onClickBtnDeleteMasterApprentice)
end

function RoleInfoOtherDlg:initData(...)
	self:setHeroCellClickCallBack(Slot(self.onHeroCellClick, self))
end

function RoleInfoOtherDlg:setRoleInfo(roleInfo, orderCell)
	self:_setRoleInfo(roleInfo, orderCell)

	if self.roleInfo.uid == CurAvatar.uid then
		local path = "Atlas/PlayerInforAtlas/PlayerInforAtlas"

		self.imgBg:setImage(path, "BgMyMessage")
		self.imgBgEnDown:setColorByRGBA(157, 126, 224, 90)
		self.imgBgEnUp:setColorByRGBA(157, 126, 224, 90)
	end
end

function RoleInfoOtherDlg:_setRoleInfo(roleInfo, orderCell)
	self:setRoleInfoMixin(roleInfo, orderCell)

	self.uid = roleInfo.commInfo.uid

	self:setBtnState()
	self:setCommInfo()
end

function RoleInfoOtherDlg:refreshUI(...)
	if self._shouldHide == true then
		return
	end

	self:_setRoleInfo(self.roleInfo, self.orderCell)
end

function RoleInfoOtherDlg:setCommInfo(...)
	self.txtProgress:setText(self.roleInfo.stage)
end

function RoleInfoOtherDlg:setBtnState(...)
	local uid = self.uid

	if uid == CurAvatar.uid then
		self.panelFunc:setVisible(false)
	elseif CurAvatar:isMyFriend(uid) then
		self.btnChat:setVisible(true)

		if ChannelUtil.isDMMGame() then
			self.btnChat:setVisible(false)
		end

		self.btnRequest:setVisible(false)
		self.btnDel:setVisible(true)
	else
		self.btnChat:setVisible(true)

		if ChannelUtil.isDMMGame() then
			self.btnChat:setVisible(false)
		end

		self.btnRequest:setVisible(true)
		self.btnDel:setVisible(false)
	end

	self:_checkShield(uid)

	if CurAvatar.isGs then
		self.btnGmBanChat1:setVisible(true)
		self.btnGmBanChat2:setVisible(true)
		self.btnGmBanChat3:setVisible(true)
		self.btnGmBanChat4:setVisible(true)
		self.btnGmBanChat5:setVisible(true)
	end

	self:refreshCircleInvite()

	local isSelf = self.uid == CurAvatar.uid
	local checkShowTab = self.roleInfo.vow and next(self.roleInfo.vow) or self.roleInfo.signet and next(self.roleInfo.signet)

	if checkShowTab then
		if not self.tabPanel then
			self.tabPanel = RoleInfoTab(self, "TabPanel")

			self.tabPanel:setTabData(false, self.roleInfo.vow, self.uid, self.roleInfo.signet)
		end

		self.tabPanel:setVisible(true)
	end

	self:refreshMasterApprentice()
end

function RoleInfoOtherDlg:refreshCircleInvite(isOut)
	if RegionUtils.isJP() then
		self.btnCircleInvite:setVisible(false)

		return
	end

	if CurAvatar:isInCircle() and CurAvatar:getMyDutyPermission().invite ~= nil and not CurAvatar.myCircle:isMemberMax() then
		if not self.roleInfo:isPassStage(Const.CONDITION_LIMIT_CIRCLE) or self:isInCircle() then
			self.btnCircleInvite:setVisible(false)
		else
			self.btnCircleInvite:setVisible(true)

			if isOut and CurAvatar.myCircle:playerIsIvited(self.uid) then
				self.btnCircleInvite:setEnable(false)
				self.btnCircleInvite:setText(Lang.get(45338))
			end
		end
	else
		self.btnCircleInvite:setVisible(false)
	end
end

function RoleInfoOtherDlg:_checkShield(uid)
	self.btnShield:setVisible(true)

	if MsgManager.isInShield(uid) then
		self.btnShield:setText(Lang.get(30750))

		self.btnShield.opera = OPERA.DEL_SHIELD
	else
		self.btnShield:setText(Lang.get(30751))

		self.btnShield.opera = OPERA.ADD_SHIELD
	end
end

function RoleInfoOtherDlg:onBtnCircleInviteClick(...)
	if not CurAvatar.myCircle then
		return
	end

	if (CurAvatar.nextCircleInviteTick or 0) > ClientUtils.getServerTime() then
		MsgManager.notice(Lang.get(45339))

		return
	end

	if CurAvatar.myCircle:playerIsIvited(self.uid) then
		MsgManager.clientNotice(608)

		return
	end

	if CurAvatar.myCircle:isInviteListMax() then
		MsgManager.clientNotice(609)

		return
	end

	RPC.clanFuncInvite(self.uid)
end

function RoleInfoOtherDlg:onHeroCellClick(sender)
	local ui = UIManager.getUI("roleInfoHeroDlg")

	ui:setData(self.roleInfo.heros, sender.mIndex, self)
	ui:setPlayerInfo(self.roleInfo)
end

function RoleInfoOtherDlg:onBtnChatClick(...)
	if CurAvatar:inMyBlackList(self.uid) then
		MsgManager.notice(Lang.get(30491))
	else
		UIManager.getUI("chatDlg", true):addFriendTalk(self.roleInfo.commInfo)
		self:setVisible(false)
	end
end

function RoleInfoOtherDlg:onBtnDelClick(...)
	UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "", Lang.get(30492), Functor(self._delBuddy, self))
end

function RoleInfoOtherDlg:_delBuddy(...)
	self._shouldHide = true

	RPC.buddyDel(self.uid)
end

function RoleInfoOtherDlg:onBtnRequestClick(...)
	if utils.isRobot(self.uid) then
		MsgManager.notice(Lang.get(1850))
	else
		CurAvatar:addFriend(self.uid)
	end

	self.btnRequest:setText(Lang.get(30174))
end

function RoleInfoOtherDlg:onBtnShieldClick(...)
	if self.btnShield.opera == OPERA.ADD_SHIELD then
		MsgManager.addShield(self.uid)
		MsgManager.notice(Lang.get(30752))
	else
		MsgManager.removeShield(self.uid)
		MsgManager.notice(Lang.get(30753))
	end

	self:_checkShield(self.uid)
end

function RoleInfoOtherDlg:onBtnGmBanChat1Click()
	CHATRPC.gSBlock(self.uid, self.openId, 1)
end

function RoleInfoOtherDlg:onBtnGmBanChat2Click()
	CHATRPC.gSBlock(self.uid, self.openId, 24)
end

function RoleInfoOtherDlg:onBtnGmBanChat3Click()
	CHATRPC.gSBlock(self.uid, self.openId, 72)
end

function RoleInfoOtherDlg:onBtnGmBanChat4Click()
	CHATRPC.gSBlock(self.uid, self.openId, 87600)
end

function RoleInfoOtherDlg:onBtnGmBanChat5Click()
	CHATRPC.gSBlock(self.uid, self.openId, 0)
end

function RoleInfoOtherDlg:refreshMasterApprentice()
	if not Const.Master_Apprentice_OPEN then
		return
	end

	self.isMyMaster = CurAvatar:isMyMaster(self.uid)
	self.isMyApprentice = CurAvatar:isMyApprentice(self.uid)

	self.btnDeleteMasterApprentice:setVisible(self.isMyMaster or self.isMyApprentice)
	self.btnAddMaster:setVisible(false)
	self.btnAddApprentice:setVisible(false)

	local checkRecordAddMasterApprentice = CurAvatar:checkRecordAddMasterApprentice(self.uid)

	if not self.isMyMaster and not self.isMyApprentice then
		if CurAvatar:checkCanAddMaster() and self.roleInfo:checkCanAddApprentice() then
			self.btnAddMaster:setVisible(true)
			self.btnAddMaster:setEnable(not checkRecordAddMasterApprentice)
		elseif CurAvatar:checkCanAddApprentice() and self.roleInfo:checkCanAddMaster() then
			self.btnAddApprentice:setVisible(true)
			self.btnAddApprentice:setEnable(not checkRecordAddMasterApprentice)
		end
	end
end

function RoleInfoOtherDlg:onClickBtnAddMaster()
	if not CurAvatar:checkCanAddMasterApprentice(Const.MASTER_APPRENTICE_TYPE.Master, true) then
		return
	end

	CurAvatar:rpcAddMasterApprentice(Const.MASTER_APPRENTICE_TYPE.Master, self.uid)
	self.btnAddMaster:setEnable(false)
end

function RoleInfoOtherDlg:onClickBtnAddApprentice()
	if not CurAvatar:checkCanAddMasterApprentice(Const.MASTER_APPRENTICE_TYPE.Apprentice, true) then
		return
	end

	CurAvatar:rpcAddMasterApprentice(Const.MASTER_APPRENTICE_TYPE.Apprentice, self.uid)
	self.btnAddApprentice:setEnable(false)
end

function RoleInfoOtherDlg:onClickBtnDeleteMasterApprentice()
	self.slotDelMasterApprentice = self.slotDelMasterApprentice or Slot(self.delMasterApprentice, self)

	if CurAvatar:checkCanApprenticeGraduate() then
		UIManager.showConfirmWithId(1149, self.slotDelMasterApprentice)

		return
	end

	local checkCd = true

	if not self.commInfo.online then
		local noCdTime = ResMasterMisc[1].no_cd_time * 24 * 3600
		local logout_tick = self.commInfo.logout_tick or 0

		checkCd = noCdTime > ClientUtils.getServerTime() - logout_tick
	end

	if checkCd then
		if self.isMyMaster then
			UIManager.showConfirmWithId(1140, self.slotDelMasterApprentice)
		elseif self.isMyApprentice then
			UIManager.showConfirmWithId(1142, self.slotDelMasterApprentice)
		end
	else
		UIManager.showConfirmWithId(1141, self.slotDelMasterApprentice)
	end
end

function RoleInfoOtherDlg:delMasterApprentice()
	if self.isMyMaster then
		RPC.masterApprenticeDel(Const.MASTER_APPRENTICE_TYPE.Master, self.uid)
	elseif self.isMyApprentice then
		RPC.masterApprenticeDel(Const.MASTER_APPRENTICE_TYPE.Apprentice, self.uid)
	end
end

return RoleInfoOtherDlg
