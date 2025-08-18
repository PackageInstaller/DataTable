-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\RearHouse\\RearHouseVisitMainDlg.lua

local RearHouseDragCenter = require("Logic/RearHouse/RearHouseDragCenter")
local RearHouseCommon = require("Logic/RearHouse/RearHouseCommon")
local RearHouseMoreRoomPanel = require("UI/RearHouse/RearHouseMoreRoomPanel")
local strClassName = "RearHouseVisitMainDlg"
local RearHouseVisitMainDlg = Class(strClassName, UIControls.Window)

function RearHouseVisitMainDlg:ctor(...)
	self:initUI()
end

function RearHouseVisitMainDlg:initUI(...)
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)

	self.btnHide = UIControls.Button(self, "Bg/BtnHide")

	self.btnHide:addEventClick(self.onBtnHideClick)

	self.btnVisit = UIControls.Button(self, "Bg/BtnVisit")

	self.btnVisit:addEventClick(self.onBtnVisitClick)

	self.btnLike = UIControls.Button(self, "Bg/BtnPopularity/BtnLike")

	self.btnLike:addEventClick(self.onBtnLikeClick)

	self.btnAttr = UIControls.Button(self, "Bg/BtnAttr")

	self.btnAttr:addEventClick(self.onBtnAttrClick)

	self.btnChangeRoom = UIControls.Button(self, "Bg/BtnChangeRoom", "TextNum")

	self.btnChangeRoom:addEventClick(self.onBtnChangeRoomClick)

	self.btnComment = UIControls.Button(self, "Bg/BtnPopularity/BtnComment")

	self.btnComment:addEventClick(self.onBtnCommentClick)
	self.btnComment:setVisible(true)

	self.txtPopularity = UIControls.Label(self, "Bg/BtnPopularity/TextNum")
	self.txtTitle = UIControls.Label(self, "Bg/BtnPopularity/TextTitle")
	self.panelBg = UIControls.DragClickPanel(self, "DragBg")
	self.panelFuncBg = UIControls.Panel(self, "Bg")
	self.btnHead = UIControls.PlayerHeadGridChild(self, "Bg/BtnPopularity/GridPlayer", "System/Common/Grid/GridPlayerCommon")
	self.panelRoom = RearHouseMoreRoomPanel(self, "Bg/ChangeRoomPanel")
	self.hideFlag = false
end

function RearHouseVisitMainDlg:onOpen(...)
	RearHouseVisitMainDlg.super.onOpen(self)

	self.mainState = GameFsm.getState(Const.STATE_MAIN_REAR_HOUSE)

	RearHouseDragCenter.setMode(self)
end

function RearHouseVisitMainDlg:setData(data)
	self.uid = data.uid
	CurAvatar.curRearHouseVisitUid = self.uid
	self.favorNum = data.favorNum

	CurAvatar:getRoleCommInfosNoTip({
		self.uid
	}, Slot(self.getInfoCB, self))
	CurAvatar:getMyRHCommentInfo(Slot(self.getMyRHCommentInfoCB, self))
end

function RearHouseVisitMainDlg:getInfoCB(info)
	local ui = UIManager.tryGetUI("rearHouseVisitMainDlg")

	if ui then
		ui:onInfoBack(info)
	end
end

function RearHouseVisitMainDlg:getMyRHCommentInfoCB()
	local ui = UIManager.tryGetUI("rearHouseVisitMainDlg")

	if ui then
		ui:refreshUI()
	end
end

function RearHouseVisitMainDlg:onInfoBack(info)
	info = info[1]
	self.comm = info.commInfo

	self:refreshUI()
end

function RearHouseVisitMainDlg:onFavorSuccess(...)
	self.favorNum = self.favorNum or 0
	self.favorNum = self.favorNum + 1

	self:refreshUI()
end

function RearHouseVisitMainDlg:refreshUI(...)
	self.btnLike:setEnable(not CurAvatar:isFavoredToday(self.uid))
	self.btnComment:setEnable(not CurAvatar:isRHTodayCommentedByUid(self.uid))

	if self.favorNum then
		self.txtPopularity:setText(ClientUtils.getNumShortStr2(self.favorNum))
	end

	if self.comm then
		self.btnHead:setCommInfo(self.comm, false, self)
		self.txtTitle:setText(self.comm.name)
	end

	local houseData = RearHouseDragCenter.getCurShowData()

	if houseData then
		local num = RearHouseCommon.getUnlockRoomNum(houseData.level)

		if num > 1 then
			self.btnChangeRoom:setVisible(true)
			self.btnChangeRoom:setText(RearHouseDragCenter.getCurZoneId())
		else
			self.btnChangeRoom:setVisible(false)
		end

		self.commentSwitch = houseData.comment_switch
	end
end

function RearHouseVisitMainDlg:showUI(v)
	self.hideFlag = not v

	self.panelFuncBg:setVisible(v)
	self.btnClose:setVisible(v)
	self.btnTips:setVisible(v)

	if self.panelFund then
		self.panelFund:setVisible(v)
	end
end

function RearHouseVisitMainDlg:destroy(...)
	RearHouseVisitMainDlg.super.destroy(self)

	CurAvatar.curRearHouseVisitUid = nil
end

function RearHouseVisitMainDlg:onBtnChangeRoomClick(...)
	local houseData = RearHouseDragCenter.getCurShowData()
	local num = RearHouseCommon.getUnlockRoomNum(houseData.level)

	if num == 2 then
		local houseIndex = RearHouseDragCenter.getCurZoneId()
		local state = GameFsm.getState(Const.STATE_MAIN_REAR_HOUSE)
		local nextId = RearHouseCommon.getNextRoomId(houseIndex, houseData.level)

		if state then
			state:changeWall(nextId, true)
		end
	elseif not self.panelRoom:getVisible() then
		self.panelRoom:setVisible(true)
		self.panelRoom:setData(true)
	end
end

function RearHouseVisitMainDlg:onBtnAttrClick(...)
	if not RearHouseCommon.isAttrFurniturePuted() then
		MsgManager.notice(Lang.get(30718))
	else
		UIManager.getUI("rearHouseAttrDlg", true)
	end
end

function RearHouseVisitMainDlg:onBtnLikeClick(...)
	if self.uid == nil or CurAvatar.rearHouseFavorInfo == nil then
		return
	end

	if CurAvatar.rearHouseFavorInfo.favorToday and utils.getTableElemCount(CurAvatar.rearHouseFavorInfo.favorToday) >= Const.REARHOUSE_FAVOR_LIMIT then
		MsgManager.notice(Lang.get(30719))

		return
	end

	CurAvatar.cachedRearHouseFavorUid = self.uid

	RPC.houseFavor(self.uid)
end

function RearHouseVisitMainDlg:onBtnCommentClick()
	if self.uid == nil then
		return
	end

	if CurAvatar.rearHouseFavorInfo.favorToday and utils.getTableElemCount(CurAvatar.rearHouseFavorInfo.favorToday) >= Const.REARHOUSE_FAVOR_LIMIT then
		MsgManager.notice(Lang.get(30719))

		return
	end

	if CurAvatar:getRearHouseCommentNum() >= Const.REARHOUSE_COMMENT_LIMIT then
		MsgManager.notice(Lang.get(96440))

		return
	end

	if self.commentSwitch and self.commentSwitch == 1 then
		if CurAvatar:isMyFriend(self.uid) or CurAvatar:playerInMyCircle(self.uid) then
			UIManager.getUI("rearHouseCommentDlg", true):setData(self.uid)
		else
			MsgManager.notice(Lang.get(96441))
		end
	else
		UIManager.getUI("rearHouseCommentDlg", true):setData(self.uid)
	end
end

function RearHouseVisitMainDlg:onBtnVisitClick(...)
	UIManager.getUI("rearHouseVisitChooseDlg", true)
end

function RearHouseVisitMainDlg:onBtnHideClick(...)
	self:showUI(false)
end

function RearHouseVisitMainDlg:onBtnTipsClick(...)
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_HOUSE_VISIT)
end

function RearHouseVisitMainDlg:onBtnCloseClick(...)
	local isHouseShareEnter = RearHouseCommon.getIsHouseShareEnter()

	if isHouseShareEnter then
		GameFsm.getState(Const.STATE_MAIN):enterDefaultMainState()
	else
		RearHouseDragCenter.visit(nil, Const.REARHOUSE_CREATE_MODE.MINE)
		self:setVisible(false)
	end
end

return RearHouseVisitMainDlg
