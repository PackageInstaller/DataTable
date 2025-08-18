-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Chat\\ClaimRedPacketDlg.lua

local ResRedPacketThankContent = require("ClientData/ResRedPacketThankContent")
local ResItemClientConfig = require("ClientData/ResItemClientConfig")
local ResUpperLimit = require("ClientData/ResUpperLimit")
local ResClientHardCode = require("ClientData/ResClientHardCode")
local ResRedPacketShow = require("ClientData/ResRedPacketShow")
local ClaimRedPacketCell = Class("ClaimRedPacketCell", UIControls.ScrollViewLoopCell)
local ICON_PATH = "Atlas/FriendAtlas/FriendAtlas"

function ClaimRedPacketCell:ctor(...)
	self:initUI()
end

function ClaimRedPacketCell:initUI(...)
	self.btnHead = UIControls.PlayerHeadGridChild(self, "GridPlayer", "System/Common/Grid/GridPlayerCommon")
	self.txtName = UIControls.Label(self, "TextPlayerName")
	self.imgSex = UIControls.Image(self, "TextPlayerName/IconSex")
	self.imgServer = UIControls.Image(self, "IconServer")
end

function ClaimRedPacketCell:setData(data)
	local comm = data.sattr

	self.btnHead:setCommInfo(comm, true, self)
	self.txtName:setText(comm.name)

	if comm.gender == Const.GENDER_MAN then
		self.imgSex:setImage(ICON_PATH, "IconMale")
	elseif comm.gender == Const.GENDER_WOMAN then
		self.imgSex:setImage(ICON_PATH, "IconFemale")
	end

	if comm.serverId == SvrListManager.getSelectedSvrID() then
		self.imgServer:setImage(ICON_PATH, "IconServerSame")
	else
		self.imgServer:setImage(ICON_PATH, "IconServerElse")
	end
end

local strClassName = "ClaimRedPacketDlg"
local ClaimRedPacketDlg = Class(strClassName, UIControls.Window)

function ClaimRedPacketDlg:ctor(...)
	self:initUI()
end

function ClaimRedPacketDlg:initUI(...)
	self.btnTips = UIControls.Button(self, "Bg/BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)

	self.btnClose = UIControls.Button(self, "Bg/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnHead = UIControls.PlayerHeadGridChild(self, "Bg/InfoPanel/GridPlayer", "System/Common/Grid/GridPlayerCommon")
	self.btnRandom = UIControls.Button(self, "Bg/InfoPanel/BgText/BtnRandom")

	self.btnRandom:addEventClick(self.onBtnRandomClick)

	self.btnSend = UIControls.Button(self, "Bg/InfoPanel/BtnSend")

	self.btnSend:addEventClick(self.onBtnSendClick)

	self.scrollView = UIControls.ScrollViewLoopV(self, "Bg/ReceiveList", 0, self.onCellChanged)
	self.txtName = UIControls.Label(self, "Bg/InfoPanel/TextNamePanel/Text")
	self.txtBlessing = UIControls.Label(self, "Bg/InfoPanel/TextBlessing")
	self.txtClaimedNum = UIControls.Label(self, "Bg/InfoPanel/TextNumPanel/TextNum")
	self.txtThanks = UIControls.Label(self, "Bg/InfoPanel/BgText/TextBlessing")
end

function ClaimRedPacketDlg:show(data)
	self.data = data

	if self.data.item.resData.extend_args2 == 2 then
		self:playAni("ShowRedMoneyReceiveCanvas2")
	else
		self:playAni("ShowRedMoneyReceiveCanvas")
	end

	local redPacketInfo = CurAvatar:getRedPacketClaimInfo(data.seq)

	if redPacketInfo and redPacketInfo.msg then
		local comm = redPacketInfo.msg.sattr

		self.isMyRedPacket = comm.uid == CurAvatar.uid

		self.btnHead:setCommInfo(comm, false, self)

		local name = utils.GetPlayerName(comm.name)

		self.givePlayerName = name

		local blessingContent = CurAvatar:getMsgBlessingContent(redPacketInfo.msg)

		self.txtBlessing:setText(blessingContent)
	end

	local content = utils.format(Lang.get(51015), self.givePlayerName or "", data.item.name)

	self.txtName:setText(content)
	self.txtThanks:setText(self:getRandThxContent())
	self.txtClaimedNum:setText(CurAvatar.redPacketData.day_get .. "/" .. ResUpperLimit[1].red_package_diamond)

	local item = BaseObject.GetObject(Const.MONEY_ID_DIAMOND, data.num or 1)
	local awardGrid = UIControls.getGridAwardContainer(self, "Bg/InfoPanel/GridPanel")

	awardGrid.mDisableWays = true

	awardGrid:setObj(item)
	awardGrid:setVisible(true)

	local isClaimed = CurAvatar:isRedPacketClaimed(data.seq)

	self.isClaimed = isClaimed

	awardGrid:setGet(isClaimed)

	self.grid = awardGrid
	self.datas = {}

	local infos = CurAvatar:getRedPacketThxInfo(self.data.seq)

	if infos then
		for i, msg in ipairs(infos) do
			table.insert(self.datas, msg)
		end
	end

	self.scrollView:setTotalCount(#self.datas)
end

function ClaimRedPacketDlg:getRandThxContent(default)
	local itConfig = ResItemClientConfig[self.data.item.id]
	local id = itConfig.red_pack_tks
	local data = ResRedPacketThankContent[id] or {}

	if #data > 0 then
		if default then
			return data[1].content or ""
		end

		local index = math.random(#data)
		local content = data[index].content

		return content or ""
	end

	return ""
end

function ClaimRedPacketDlg:onBtnSendClick(...)
	local content = self.txtThanks:getText()
	local other = CurAvatar:getFormatOtherData(Const.CUSTOM_MSG_DATA_TYPE.RED_THX, self.data.seq)

	MsgManager.sendBySystem(content, Const.CHANNEL_WORLD, other)
	self:sendClaimedMsg()
	self:setVisible(false)
end

function ClaimRedPacketDlg:onBtnRandomClick(...)
	local content = self:getRandThxContent()

	self.txtThanks:setText(content)
end

function ClaimRedPacketDlg:onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = ClaimRedPacketCell(sender, "System/Chat/RedMoneyReceiveCell", newIdx, 0, 0, true)
	end

	targetCell.index = newIdx

	targetCell:setData(self.datas[newIdx])
end

function ClaimRedPacketDlg:onBtnCloseClick(...)
	self:setVisible(false)
	self:sendClaimedMsg()
end

function ClaimRedPacketDlg:getOtherInfo(type)
	if self.isMyRedPacket then
		return
	end

	local info = CurAvatar:getRedPacketThxInfo(self.data.seq)

	if info and #info >= Const.MAX_THX_MSG_NUM then
		return nil
	end

	return CurAvatar:getFormatOtherData(type, self.data.seq)
end

function ClaimRedPacketDlg:sendClaimedMsg()
	if self.isClaimed then
		return
	end

	local other = self:getOtherInfo(Const.CUSTOM_MSG_DATA_TYPE.RED_CLAIM)
	local name = self.givePlayerName or ""
	local content = name .. "|" .. self.data.item.id .. "|" .. self.data.num

	CurAvatar:receiveFakeWordMsg(content, CurAvatar:getFormatOtherData(Const.CUSTOM_MSG_DATA_TYPE.RED_CLAIM, self.data.seq))

	if other then
		MsgManager.sendBySystem(content, Const.CHANNEL_WORLD, other)
	end
end

function ClaimRedPacketDlg:destroy(...)
	ClaimRedPacketDlg.super.destroy(self)

	if self.grid then
		self.grid:flyToCommonFuncEntryPanel()
	end

	local ui = UIManager.getUI("chatDlg", nil, false)

	if ui then
		ui:checkJumpRedPacketShow(true)
	end

	if CurAvatar.redPacketData and CurAvatar.redPacketData.day_get >= ResUpperLimit[1].red_package_diamond then
		local type = ResClientHardCode[13].value[1]
		local content = ResRedPacketShow[type] and ResRedPacketShow[type].confirm_str or Lang.get(31296)

		local function yesFunc(...)
			MsgManager.setHideRedMsg(true)
		end

		UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "", content, yesFunc, nil, nil)
	end
end

function ClaimRedPacketDlg:onBtnTipsClick(...)
	local type = ResClientHardCode[13].value[1]
	local noticeId = ResRedPacketShow[type] and ResRedPacketShow[type].notice_id or Const.INFO_NOTICE_RED_PACKET

	UIManager.getUI("infoNotice", true):showSystemInfo(noticeId)
end

return ClaimRedPacketDlg
