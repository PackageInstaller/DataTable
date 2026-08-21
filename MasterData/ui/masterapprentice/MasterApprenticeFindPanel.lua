-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MasterApprentice\\MasterApprenticeFindPanel.lua

local ResMasterMisc = require("ClientData.ResMasterMisc")
local ResMasterLevel = require("ClientData.ResMasterLevel")
local ResClientNotice = require("ClientData.ResClientNotice")
local ConditionCell = Class("MasterApprenticeFindPanel_ConditionCell", UIControls.Panel)

function ConditionCell:ctor()
	self.txtTitle = UIControls.Label(self, self.mPath .. "/TextTitle")
	self.anim = UIControls.UIAni(self, self.mPath)
end

function ConditionCell:setData(conditionId, reverse)
	self.checkOk = not ConditionLimitManager.inLimitState(conditionId)

	if reverse then
		self.checkOk = not self.checkOk
	end

	self.txtTitle:setText(ConditionLimitManager.getLimitUnlockDesc(conditionId))
	self.anim:startAni(self.checkOk and "TargetReach" or "TargetFail")
end

local PlayerCell = Class("MasterApprenticeFindPanel_PlayerCell", UIControls.Child)

function PlayerCell:ctor()
	self.headCell = UIControls.PlayerHeadGridChild(self, "BgPanel/GridPlayer", "System/Common/Grid/GridPlayerCommon")
	self.txtName = UIControls.Label(self, "BgPanel/TextPlayerName")
	self.iconSex = UIControls.Image(self, "BgPanel/TextPlayerName/IconSex")
	self.txtServer = UIControls.Label(self, "BgPanel/TextServer")
	self.imgServer = UIControls.Image(self, "BgPanel/TextServer/IconServer")
	self.btnChat = UIControls.Button(self, "BgPanel/FunPanel/BtnChat")

	self.btnChat:addEventClick(self.onClickBtnChat)

	self.btnAdd = UIControls.Button(self, "BgPanel/FunPanel/BtnFind")

	self.btnAdd:addEventClick(self.onClickBtnAdd)

	self.btnBg = UIControls.Button(self, "")

	self.btnBg:addEventClick(self.onClickBtnBg)

	if UIControls.checkControlFunc(self, "BgPanel/IconTeacherLv") then
		self.imgMasterLv = UIControls.Image(self, "BgPanel/IconTeacherLv")
		self.txtMasterLv = UIControls.Label(self, "BgPanel/IconTeacherLv/TextNum")
	end
end

function PlayerCell:setData(target_type, other_player)
	self.targetType = target_type
	self.otherPlayer = other_player
	self.uid = self.otherPlayer.uid

	self.txtName:setText(self.otherPlayer.name)

	if self.otherPlayer.gender == Const.GENDER_MAN then
		self.iconSex:setImage("Atlas/FriendAtlas/FriendAtlas", "IconMale")
	else
		self.iconSex:setImage("Atlas/FriendAtlas/FriendAtlas", "IconFemale")
	end

	self.txtServer:setText(self.otherPlayer.serverName or "")

	if self.otherPlayer.sameServer then
		self.imgServer:setVisible(false)
	else
		self.imgServer:setVisible(true)
	end

	self.headCell:setPlayer(self.otherPlayer, true, self)

	local checkRecordAddMasterApprentice = CurAvatar:checkRecordAddMasterApprentice(self.uid)

	self.btnAdd:setEnable(not checkRecordAddMasterApprentice)

	if self.targetType == Const.MASTER_APPRENTICE_TYPE.Master then
		local lv = self.otherPlayer.masterLv
		local config = ResMasterLevel[math.max(lv, 1)]

		self.imgMasterLv:setImage(config.icon_path, config.icon)
		self.txtMasterLv:setText(string.format(Lang.get(80803), lv))
	end
end

function PlayerCell:onClickBtnAdd()
	if not CurAvatar:checkCanAddMasterApprentice(self.targetType, true) then
		return
	end

	self.btnAdd:setEnable(false)
	CurAvatar:rpcAddMasterApprentice(self.targetType, self.uid)
end

function PlayerCell:onClickBtnChat()
	UIManager.getUI("chatDlg", true):addFriendTalk(self.otherPlayer)
end

function PlayerCell:onClickBtnBg()
	self.headCell:onEventClick()
end

local MasterApprenticeFindPanel = Class("MasterApprenticeFindPanel", UIControls.Child)

function MasterApprenticeFindPanel:ctor()
	self.recommendPanel = UIControls.Panel(self, "FindPlayerPanel")
	self.txtCd = UIControls.Label(self, "FindPlayerPanel/TextCD")
	self.btnRandom = UIControls.Button(self, "BtnRandom")

	self.btnRandom:addEventClick(self.onClickBtnRandom)

	self.btnInvite = UIControls.Button(self, "BtnRequest")

	self.btnInvite:addEventClick(self.onClickBtnInvite)

	self.redDotInvite = UIControls.RedDot(self, "BtnRequest/IconNew")

	self.redDotInvite:addHint({
		UIConst.RD_HINT_MASTER_APPRENTICE_INVITE
	})

	self.noContentPanel = UIControls.Panel(self, "NoContentPanel")
	self.condtionPanel = UIControls.Panel(self, "NoConditionPanel")
	self.conditionCellList = {}

	for i = 1, 5 do
		local cell = ConditionCell(self, "NoConditionPanel/ConditionPanel/Target" .. i)

		table.insert(self.conditionCellList, cell)
	end

	self.btnEnroll = UIControls.Button(self, "NoConditionPanel/ConditionPanel/BtnBegin")

	self.btnEnroll:addEventClick(self.onClickBtnEnroll)

	self.enrollEfx = UIControls.LazyEffectPlayer(self, "Efx")
end

function MasterApprenticeFindPanel:initData(targetType)
	self.targetType = targetType
end

function MasterApprenticeFindPanel:onDestroy()
	self:clearCdTimer()

	if self.corDelayRefreshShow then
		coroutine.stop(self.corDelayRefreshShow)
	end
end

function MasterApprenticeFindPanel:onShow()
	self:refreshShow(true)
end

function MasterApprenticeFindPanel:refreshShow(isShow)
	self.recommendPanel:setVisible(false)
	self.noContentPanel:setVisible(false)

	local checkEnroll = false

	if self.targetType == Const.MASTER_APPRENTICE_TYPE.Master then
		checkEnroll = CurAvatar.checkEnrollApprentice
	else
		checkEnroll = CurAvatar.checkEnrollMaster
	end

	self.condtionPanel:setVisible(not checkEnroll)
	self.btnRandom:setVisible(checkEnroll)
	self.btnInvite:setVisible(checkEnroll)

	if not checkEnroll then
		self:refreshConditionPanel()
	else
		self:clearCdTimer()

		local cd = CurAvatar:getMasterApprenticeCd()

		self:refreshTxtCd(cd)

		if cd > 0 then
			self.slotUpdateCdTimer = self.slotUpdateCdTimer or Slot(self.updateCdTimer, self)
			self.timerCd = Timer(self.slotUpdateCdTimer, 1, -1)

			self.timerCd:Start()
		end

		self.dataList = CurAvatar.recommendMasterApprenticeList or {}

		local checkData = #self.dataList > 0

		if checkData then
			self.recommendPanel:setVisible(true)
			self:refreshRecommendPanel()
		else
			self.noContentPanel:setVisible(true)
		end

		if isShow then
			self:rpcRandom()
		end
	end
end

function MasterApprenticeFindPanel:updateCdTimer()
	local cd = CurAvatar:getMasterApprenticeCd()

	self:refreshTxtCd(cd)

	if cd <= 0 then
		self:clearCdTimer()
	end
end

function MasterApprenticeFindPanel:refreshTxtCd(cd)
	self.txtCd:setVisible(cd > 0)

	if cd > 0 then
		local strTime = ClientUtils.getTimeStrBySecond(cd)

		if self.targetType == Const.MASTER_APPRENTICE_TYPE.Master then
			self.txtCd:setText(string.format(ResClientNotice[780].notice, strTime))
		else
			self.txtCd:setText(string.format(ResClientNotice[781].notice, strTime))
		end
	end
end

function MasterApprenticeFindPanel:clearCdTimer()
	if self.timerCd then
		self.timerCd:Stop()
	end

	self.timerCd = nil
end

function MasterApprenticeFindPanel:refreshConditionPanel()
	local conditionList = {}

	if self.targetType == Const.MASTER_APPRENTICE_TYPE.Master then
		conditionList = {}
	else
		conditionList = ResMasterMisc[1].add_apprentice_condition
	end

	local conditionNum = #conditionList
	local checkOk = true

	for i = 1, #self.conditionCellList do
		local cell = self.conditionCellList[i]
		local checkShow = i <= conditionNum

		cell:setVisible(checkShow)

		if checkShow then
			cell:setData(conditionList[i], self.targetType == Const.MASTER_APPRENTICE_TYPE.Master)

			if not cell.checkOk then
				checkOk = false
			end
		end
	end

	self.btnEnroll:setEnable(checkOk)
end

function MasterApprenticeFindPanel:refreshRecommendPanel()
	self.playerCellList = self.playerCellList or {}

	local dataNum = #self.dataList
	local cellNum = #self.playerCellList

	for i = 1, dataNum do
		local cell

		if i <= cellNum then
			cell = self.playerCellList[i]
		else
			if self.targetType == Const.MASTER_APPRENTICE_TYPE.Master then
				cell = PlayerCell(self, "FindPlayerPanel/PlayerList/Content", "System/HandBook/RankSelectTeacherFindCell")
			else
				cell = PlayerCell(self, "FindPlayerPanel/PlayerList/Content", "System/HandBook/RankSelectStudentFindCell")
			end

			table.insert(self.playerCellList, cell)
		end

		cell:setVisible(true)
		cell:setData(self.targetType, self.dataList[i])
	end

	if dataNum < cellNum then
		for i = dataNum + 1, cellNum do
			self.playerCellList[i]:setVisible(false)
		end
	end
end

function MasterApprenticeFindPanel:onClickBtnRandom()
	self:rpcRandom(true)
end

function MasterApprenticeFindPanel:rpcRandom(needTip)
	if self.lastRpcTime then
		local now = ClientUtils.getServerTime()

		if now - self.lastRpcTime < 10 then
			if needTip then
				MsgManager.notice(Lang.get(110034))
			end

			return
		end
	end

	self.lastRpcTime = ClientUtils.getServerTime()

	if self.targetType == Const.MASTER_APPRENTICE_TYPE.Master then
		RPC.masterApprenticeRecommend(Const.MASTER_APPRENTICE_TYPE.Master)
	else
		RPC.masterApprenticeRecommend(Const.MASTER_APPRENTICE_TYPE.Apprentice)
	end
end

function MasterApprenticeFindPanel:onClickBtnEnroll()
	if self.targetType == Const.MASTER_APPRENTICE_TYPE.Master then
		RPC.masterApprenticeEnroll(Const.MASTER_APPRENTICE_TYPE.Apprentice)
	else
		RPC.masterApprenticeEnroll(Const.MASTER_APPRENTICE_TYPE.Master)
	end
end

function MasterApprenticeFindPanel:onClickBtnInvite()
	local ui = UIManager.getUI("masterApprenticeInviteDlg", true, true)

	ui:setData(self.targetType)
end

function MasterApprenticeFindPanel:onMasterApprenticeEnrollResp()
	self.enrollEfx:playEffect()

	self.corDelayRefreshShow = coroutine.start(Slot(self.delayRefreshShow, self))
end

function MasterApprenticeFindPanel:delayRefreshShow()
	coroutine.wait(0.8)
	self:refreshShow(true)

	self.corDelayRefreshShow = nil
end

function MasterApprenticeFindPanel:onMasterApprenticeRecommendResp(target_type)
	if target_type == self.targetType then
		self:refreshShow(false)
	end
end

return MasterApprenticeFindPanel
