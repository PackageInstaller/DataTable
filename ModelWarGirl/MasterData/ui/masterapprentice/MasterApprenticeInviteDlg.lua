-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MasterApprentice\\MasterApprenticeInviteDlg.lua

local InviteCell = Class("MasterApprenticeInviteDlg_InviteCell", UIControls.ScrollViewLoopCell)

function InviteCell:ctor()
	self.headCell = UIControls.PlayerHeadGridChild(self, "BgPanel/GridPlayer", "System/Common/Grid/GridPlayerCommon")
	self.txtName = UIControls.Label(self, "BgPanel/TextPlayerName")
	self.iconSex = UIControls.Image(self, "BgPanel/TextPlayerName/IconSex")
	self.panelVip = UIControls.PanelPlayerVip(self, "BgPanel/TextPlayerName/VIPPanel")
	self.txtServer = UIControls.Label(self, "BgPanel/TextServer")
	self.imgServer = UIControls.Image(self, "BgPanel/TextServer/IconServer")
	self.bgPlayer = UIControls.Image(self, "BgPanel/BgPlayer")
	self.btnAccept = UIControls.Button(self, "BgPanel/BtnAgree")

	self.btnAccept:addEventClick(self.onClickBtnAccept)

	self.btnRefuse = UIControls.Button(self, "BgPanel/BtnRefuse")

	self.btnRefuse:addEventClick(self.onClickBtnRefuse)
end

function InviteCell:setData(targetType, otherPlayer)
	self.targetType = targetType
	self.otherPlayer = otherPlayer

	self.txtName:setText(self.otherPlayer.name)
	self.panelVip:setData(self.otherPlayer.vip, self.otherPlayer.vip_hide)

	if self.otherPlayer.gender == Const.GENDER_MAN then
		self.bgPlayer:setImage("Atlas/FriendAtlas/FriendAtlas", "BgPlayerMale")
		self.iconSex:setImage("Atlas/FriendAtlas/FriendAtlas", "IconMale")
	else
		self.bgPlayer:setImage("Atlas/FriendAtlas/FriendAtlas", "BgPlayerFemale")
		self.iconSex:setImage("Atlas/FriendAtlas/FriendAtlas", "IconFemale")
	end

	self.txtServer:setText(self.otherPlayer.serverName or "")

	if self.otherPlayer.sameServer then
		self.imgServer:setVisible(false)
	else
		self.imgServer:setVisible(true)
	end

	self.headCell:setPlayer(self.otherPlayer, true, self)
end

function InviteCell:onClickBtnAccept()
	if not CurAvatar:checkCanAddMasterApprentice(self.targetType, true) then
		return
	end

	RPC.masterApprenticeInviteOp(self.targetType, Const.MASTER_APPRENTICE_OP_TYPE.Accept, self.otherPlayer.uid)
end

function InviteCell:onClickBtnRefuse()
	RPC.masterApprenticeInviteOp(self.targetType, Const.MASTER_APPRENTICE_OP_TYPE.Refuse, self.otherPlayer.uid)
end

local MasterApprenticeInviteDlg = Class("MasterApprenticeInviteDlg", UIControls.Window)

function MasterApprenticeInviteDlg:ctor()
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onClickBtnClose)

	self.titleApprentice = UIControls.Label(self, "BgPanel/TextStudent")
	self.titleMaster = UIControls.Label(self, "BgPanel/TextTeacher")
	self.scrollList = UIControls.ScrollViewLoopV(self, "BgPanel/PlayerList")

	self.scrollList:addEventCellChanged(self.onScrollListChanged)

	self.empty = UIControls.Panel(self, "TextEmpty")
	self.apprenticePanel = UIControls.Panel(self, "BgPanel/TeacherPanel")
	self.txtApprenticeNum = UIControls.Label(self, "BgPanel/TeacherPanel/TextNum1/Num1")
	self.txtInviteNum = UIControls.Label(self, "BgPanel/TeacherPanel/TextNum2/Num2")
	self.btnAllRefuse = UIControls.Button(self, "BgPanel/TeacherPanel/BtnAllRefuse")

	self.btnAllRefuse:addEventClick(self.onClickBtnAllRefuse)
end

function MasterApprenticeInviteDlg:setData(targetType)
	self.targetType = targetType

	self:refreshShow()
end

function MasterApprenticeInviteDlg:refreshShow()
	self.uidList = {}
	self.dataDic = {}

	local checkMaster = self.targetType == Const.MASTER_APPRENTICE_TYPE.Master

	self.titleMaster:setVisible(checkMaster)
	self.titleApprentice:setVisible(not checkMaster)

	if checkMaster then
		self.uidList = CurAvatar.masterInviteUidList or {}
		self.dataDic = CurAvatar.masterInviteDic or {}
	else
		self.uidList = CurAvatar.apprenticeInviteUidList or {}
		self.dataDic = CurAvatar.apprenticeInviteDic or {}

		local curApprenticeNum = #self.uidList

		self.txtApprenticeNum:setText(curApprenticeNum .. "/" .. CurAvatar:getCurMaxApprenticeNum())
		self.txtInviteNum:setText(#self.uidList .. "/30")
	end

	local checkData = #self.uidList > 0

	self.apprenticePanel:setVisible(checkData and not checkMaster)
	self.btnAllRefuse:setVisible(#self.uidList > 1)
	self.empty:setVisible(not checkData)
	self.scrollList:setVisible(checkData)

	if checkData then
		coroutine.start(self.setScrollCount, self)
	end
end

function MasterApprenticeInviteDlg:setScrollCount()
	coroutine.step()
	self.scrollList:setTotalCount(#self.uidList)
end

function MasterApprenticeInviteDlg:onScrollListChanged(sender, targetCell, newIdx)
	if not targetCell then
		targetCell = InviteCell(sender, "System/HandBook/RankSelectRequestCell", newIdx)
	else
		targetCell.mIndex = newIdx
	end

	local uid = self.uidList[newIdx]

	targetCell:setData(self.targetType, self.dataDic[uid])
end

function MasterApprenticeInviteDlg:onClickBtnAllRefuse()
	RPC.masterApprenticeInviteOp(self.targetType, Const.MASTER_APPRENTICE_OP_TYPE.Refuse, 0)
end

function MasterApprenticeInviteDlg:onClickBtnClose()
	self:setVisible(false)
end

function MasterApprenticeInviteDlg:onMasterApprenticeInviteOpResp()
	self:refreshShow()
end

return MasterApprenticeInviteDlg
