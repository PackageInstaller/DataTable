-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\RearHouse\\RearHouseVisitChooseDlg.lua

local RearHouseCommon = require("Logic/RearHouse/RearHouseCommon")
local RearHouseVisitCell = Class("RearHouseVisitCell", UIControls.ScrollViewLoopCell)

function RearHouseVisitCell:ctor(...)
	self:initUI()
end

function RearHouseVisitCell:initUI(...)
	self.btnHead = UIControls.PlayerHeadGridChild(self, "BgPanel/GridPlayer", "System/Common/Grid/GridPlayerCommon")
	self.txtPlayerName = UIControls.Label(self, "BgPanel/TextPlayerName")
	self.txtPop = UIControls.Label(self, "BgPanel/InfoPanel/TextPop")
	self.txtLock = UIControls.Label(self, "BgPanel/InfoPanel/TextUnopen")
	self.txtVisiting = UIControls.Label(self, "BgPanel/InfoPanel/TextLocal")
	self.btnVisit = UIControls.Button(self, "BgPanel/BtnVisit")

	self.btnVisit:addEventClick(self.onBtnvisitClick)

	self.commentPanel = UIControls.Panel(self, "BgPanel/CommentPanel")
	self.commentText = UIControls.Label(self, "BgPanel/CommentPanel/Text")
	self.btnMore = UIControls.Button(self, "BgPanel/BtnMore")

	self.btnMore:addEventClick(self.onBtnMoreClick)

	self.btnLike = UIControls.Button(self, "BgPanel/BtnLike")

	self.btnLike:addEventClick(self.onBtnLikeClick)
end

function RearHouseVisitCell:setData(data)
	if data == nil then
		return
	end

	self.uid = data.comm.uid

	local name = utils.GetPlayerName(data.comm.name)

	self.txtPlayerName:setText(name)
	self.btnHead:setCommInfo(data.comm, true, self)
	self.commentPanel:setVisible(false)
	self.btnLike:setVisible(false)
	self.btnMore:setVisible(false)

	if CurAvatar.curRearHouseVisitUid and self.uid == CurAvatar.curRearHouseVisitUid then
		self.txtVisiting:setVisible(true)
		self.btnVisit:setVisible(false)
	else
		self.txtVisiting:setVisible(false)
		self.btnVisit:setVisible(true)
	end

	if self.mParent.choosingButton == self.mParent.btnLiked and (not CurAvatar.curRearHouseVisitUid or self.uid ~= CurAvatar.curRearHouseVisitUid) then
		self.btnLike:setVisible(true)
		self.btnLike:setEnable(not CurAvatar:isFavoredToday(self.uid))

		if data.commentContent then
			self.commentPanel:setVisible(true)
			self.btnMore:setVisible(true)
			self.commentText:setText(data.commentContent)

			self.commentId = data.commentId
		else
			self.commentPanel:setVisible(false)
			self.btnMore:setVisible(false)
		end
	end
end

function RearHouseVisitCell:refreshBtnLikeEnable()
	self.btnLike:setEnable(not CurAvatar:isFavoredToday(self.uid))
end

function RearHouseVisitCell:onBtnMoreClick()
	self.mWindow:openMorePanel(self)
end

function RearHouseVisitCell:onBtnLikeClick()
	if self.uid == nil or CurAvatar.rearHouseFavorInfo == nil then
		return
	end

	if CurAvatar.rearHouseFavorInfo.favorToday and utils.getTableElemCount(CurAvatar.rearHouseFavorInfo.favorToday) >= Const.REARHOUSE_FAVOR_LIMIT then
		MsgManager.notice(Lang.get(30719))

		return
	end

	CurAvatar.cachedRearHouseFavorUid = self.uid
	self.mParent.curLikeCell = self

	RPC.houseFavor(self.uid)
end

function RearHouseVisitCell:onBtnvisitClick(...)
	CurAvatar:checkHouseVisitReq(self.uid)
end

local strClassName = "RearHouseVisitChooseDlg"
local RearHouseVisitChooseDlg = Class(strClassName, UIControls.Window)

function RearHouseVisitChooseDlg:ctor(...)
	self:initUI()
end

function RearHouseVisitChooseDlg:initUI(...)
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnVisitRand = UIControls.Button(self, "BgPanel/BtnVisit")

	self.btnVisitRand:addEventClick(self.onBtnVisitRandClick)

	self.btnVisitRandDis = UIControls.Button(self, "BgPanel/BtnVisitDis")

	self.btnVisitRandDis:addEventClick(self.onBtnVisitRandClick)

	self.btnFriend = UIControls.Button(self, "BgPanel/FuncPanel/BtnFriend")

	self.btnFriend:addEventClick(self.onBtnFriendClick)

	self.btnCircle = UIControls.Button(self, "BgPanel/FuncPanel/BtnCircle")

	self.btnCircle:addEventClick(self.onBtnCircleClick)

	self.btnCircleDis = UIControls.Button(self, "BgPanel/FuncPanel/BtnCircleDis")

	self.btnCircleDis:addEventClick(self.onBtnCircleDisClick)

	self.btnVisitor = UIControls.Button(self, "BgPanel/FuncPanel/BtnVisitor")

	self.btnVisitor:addEventClick(self.onBtnVisitorClick)

	self.btnLike = UIControls.Button(self, "BgPanel/FuncPanel/BtnLike")

	self.btnLike:addEventClick(self.onBtnLikeClick)

	self.btnLiked = UIControls.Button(self, "BgPanel/FuncPanel/BtnLiked")

	self.btnLiked:addEventClick(self.onBtnLikedClick)

	self.scrollView = UIControls.ScrollViewLoopV(self, "BgPanel/PlayerRankList", 0, self.onCellChanged)
	self.panelEmpty = UIControls.Panel(self, "BgPanel/PlayerRankList/NonePanel")
	self.txtTime = UIControls.Label(self, "BgPanel/BtnVisit/TextTime")
	self.uIClickThrough = UIControls.Button(self, "BgPanel/MorePanel/UIClickThrough")

	self.uIClickThrough:addEventClick(self.onUIClickThroughClick)

	self.morePanel = UIControls.Panel(self, "BgPanel/MorePanel")
	self.btnDelete = UIControls.Button(self, "BgPanel/MorePanel/BtnDelete")

	self.btnDelete:addEventClick(self.onBtnDeleteClick)

	self.bgAccess = UIControls.Panel(self, "BgPanel/BgAccess")
	self.attentionSwitch = UIControls.Toggle(self, "BgPanel/BgAccess/AttentionSwitch", "Label")

	self.attentionSwitch:addEventValueChanged(self.onToggleValueChanged)

	self.datas = {}
	self.choosingButton = nil
	self.cellList = {}
end

function RearHouseVisitChooseDlg:onOpen(...)
	RearHouseVisitChooseDlg.super.onOpen(self)
	self:show()
end

function RearHouseVisitChooseDlg:show(...)
	self.btnCircle:setVisible(CurAvatar:isInCircle())
	self.btnCircleDis:setVisible(not CurAvatar:isInCircle())
	self:onBtnFriendClick(self.btnFriend)
	self:timeDown()

	if self:isLevelLimit() then
		self.btnVisitRand:setVisible(false)
		self.btnVisitRandDis:setVisible(true)
	else
		self.btnVisitRand:setVisible(true)
		self.btnVisitRandDis:setVisible(false)
	end
end

function RearHouseVisitChooseDlg:onChooseButton(sender)
	if self.choosingButton then
		self.choosingButton:setEnable(true)
	end

	self.choosingButton = sender

	self.choosingButton:setEnable(false)
	self:refreshList(true)
end

function RearHouseVisitChooseDlg:refreshList(isTop)
	self.bgAccess:setVisible(self.choosingButton == self.btnLiked)

	if self.choosingButton == self.btnLiked then
		self.attentionSwitch:setOn(CurAvatar:isLimitFriendComment())
	end

	self.corDelaySetTotalCnt = coroutine.start(self.delaySetTotalCnt, self)
	self.isTop = isTop
end

function RearHouseVisitChooseDlg:delaySetTotalCnt()
	coroutine.step()

	local data = self.datas[self.choosingButton]

	if data then
		self.scrollView:setTotalCount(#data, self.isTop)
		self.panelEmpty:setVisible(#data <= 0)
	end
end

function RearHouseVisitChooseDlg:onFavorSuccess()
	for i, cell in pairs(self.cellList) do
		if CurAvatar.cachedRearHouseFavorUid and cell.uid == CurAvatar.cachedRearHouseFavorUid then
			cell:refreshBtnLikeEnable()
		end
	end
end

function RearHouseVisitChooseDlg:refreshFavoredUI(...)
	local favorInfos = CurAvatar:getFavorInfo()

	if favorInfos then
		self.datas[self.btnLiked] = {}

		local data = self.datas[self.btnLiked]

		for i, uid in ipairs(favorInfos.favoredUids) do
			local t = {}

			t.uid = uid
			t.comm = Const.DEFAULT_COMMINFO

			table.insert(data, t)
		end

		self:handleFavorAndCommentData()
		self:refreshList(true)

		local function func(infos)
			for i, _data in ipairs(data or {}) do
				for _, info in ipairs(infos) do
					if _data.uid == info.uid then
						_data.comm = info.commInfo

						break
					end
				end
			end

			local ui = UIManager.tryGetUI("rearHouseVisitChooseDlg")

			if ui then
				ui:refreshList(true)
			end
		end

		CurAvatar:getRoleCommInfosNoTip(favorInfos.favoredUids, func)
	end
end

function RearHouseVisitChooseDlg:handleFavorAndCommentData()
	local function refreshFunc()
		local ui = UIManager.tryGetUI("rearHouseVisitChooseDlg")

		if ui then
			ui:refreshFavoredUI()
		end
	end

	local rearHouseCommentData = CurAvatar:getRHCommentInfo(refreshFunc)

	if rearHouseCommentData then
		local data = self.datas[self.btnLiked]

		for _, v in ipairs(rearHouseCommentData.commentData or {}) do
			local needAddData

			for _, dt in ipairs(data) do
				if dt.uid == v.uid then
					if dt.commentContent == nil then
						dt.commentContent = v.content
						dt.commentId = v.id

						break
					end

					needAddData = utils.deepcopy(dt)
					needAddData.commentContent = v.content
					needAddData.commentId = v.id

					break
				end
			end

			if needAddData then
				table.insert(data, needAddData)
			end
		end
	end
end

function RearHouseVisitChooseDlg:refreshFavorUI(...)
	local favorInfos = CurAvatar:getFavorInfo()

	if favorInfos then
		self.datas[self.btnLike] = {}

		local data = self.datas[self.btnLike]

		for i, uid in ipairs(favorInfos.favorUids) do
			local t = {}

			t.uid = uid
			t.comm = Const.DEFAULT_COMMINFO

			table.insert(data, t)
		end

		self:refreshList(true)

		local function func(infos)
			for i, _data in ipairs(data or {}) do
				for _, info in ipairs(infos) do
					if _data.uid == info.uid then
						_data.comm = info.commInfo

						break
					end
				end
			end

			local ui = UIManager.tryGetUI("rearHouseVisitChooseDlg")

			if ui then
				ui:refreshList(true)
			end
		end

		CurAvatar:getRoleCommInfosNoTip(favorInfos.favorUids, func)
	end
end

function RearHouseVisitChooseDlg:refreshvisitorUI(...)
	local visitorInfos = CurAvatar:getVisitorInfo()

	if visitorInfos then
		self.datas[self.btnVisitor] = {}

		local data = self.datas[self.btnVisitor]

		for i, uid in ipairs(visitorInfos.uids) do
			local t = {}

			t.uid = uid
			t.comm = Const.DEFAULT_COMMINFO

			table.insert(data, t)
		end

		self:refreshList(true)

		local function func(infos)
			for i, _data in ipairs(data or {}) do
				for _, info in ipairs(infos) do
					if _data.uid == info.uid then
						_data.comm = info.commInfo

						break
					end
				end
			end

			local ui = UIManager.tryGetUI("rearHouseVisitChooseDlg")

			if ui then
				ui:refreshList(true)
			end
		end

		CurAvatar:getRoleCommInfosNoTip(visitorInfos.uids, func)
	end
end

function RearHouseVisitChooseDlg:timeDown(...)
	local leftTime = (CurAvatar.nextRearHouseRandVisitTime or 0) - Time.time

	if leftTime > 0 then
		self.txtTime:setVisible(true)
		ClientTimerManager.RemoveSecondTickUI(self.txtTime)
		ClientTimerManager.AddSecondFormatTickUI(self.txtTime, leftTime, nil, Lang.get(48691), Slot(self.timeEndCB, self), nil, 2)
	else
		self:timeEndCB()
	end
end

function RearHouseVisitChooseDlg:timeEndCB(...)
	self.txtTime:setVisible(false)
end

function RearHouseVisitChooseDlg:isLevelLimit(...)
	return CurAvatar.rearHouseData.level < RearHouseCommon.getRandVisitLv()
end

function RearHouseVisitChooseDlg:onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = RearHouseVisitCell(sender, "System/Backyard/BtnBackyardList", newIdx, 0, 0)
	else
		self.cellList[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	targetCell.index = newIdx

	targetCell:setData(self.datas[self.choosingButton][newIdx])

	self.cellList[newIdx] = targetCell
end

function RearHouseVisitChooseDlg:onToggleValueChanged(sender, isOn)
	if CurAvatar:isLimitFriendComment() ~= isOn then
		local isLimit = isOn == true and 1 or 0

		RPC.houseCommentSwitchSet(isLimit)
	end
end

function RearHouseVisitChooseDlg:onBtnLikedClick(sender)
	local info
	local isFirst = false

	if self.datas[sender] == nil then
		isFirst = true
		info = CurAvatar:getFavorInfo()

		local data = {}

		self.datas[sender] = data
	end

	self:onChooseButton(sender)

	if info and isFirst then
		self:refreshFavoredUI()
	end
end

function RearHouseVisitChooseDlg:onBtnLikeClick(sender)
	local info
	local isFirst = false

	if self.datas[sender] == nil then
		isFirst = true
		info = CurAvatar:getFavorInfo()

		local data = {}

		self.datas[sender] = data
	end

	self:onChooseButton(sender)

	if info and isFirst then
		self:refreshFavorUI()
	end
end

function RearHouseVisitChooseDlg:onBtnVisitorClick(sender)
	local info
	local isFirst = false

	if self.datas[sender] == nil then
		isFirst = true
		info = CurAvatar:getVisitorInfo()

		local data = {}

		self.datas[sender] = data
	end

	self:onChooseButton(sender)

	if info and isFirst then
		self:refreshvisitorUI()
	end
end

function RearHouseVisitChooseDlg:onBtnCircleDisClick(sender)
	MsgManager.notice(Lang.get(30050))

	do return end

	if self.datas[sender] == nil then
		self.datas[sender] = {}
	end

	self:onChooseButton(sender)
end

function RearHouseVisitChooseDlg:onBtnCircleClick(sender)
	if CurAvatar:isInCircle() == false then
		return
	end

	if self.datas[sender] == nil then
		local data = {}

		for _, member in ipairs(CurAvatar.myCircle:getCircleMembersList()) do
			if member.base.uid ~= CurAvatar.uid then
				local t = {
					comm = member.base
				}

				table.insert(data, t)
			end
		end

		self.datas[sender] = data
	end

	self:onChooseButton(sender)
end

function RearHouseVisitChooseDlg:onBtnFriendClick(sender)
	if self.datas[sender] == nil then
		local data = {}

		for uid, friend in pairs(CurAvatar.friendList) do
			local t = {
				comm = {}
			}

			t.comm.uid = friend.uid
			t.comm.level = friend.level
			t.comm.head = friend.head
			t.comm.headFrameId = friend.headFrameId
			t.comm.name = friend.name

			table.insert(data, t)
		end

		self.datas[sender] = data
	end

	self:onChooseButton(sender)
end

function RearHouseVisitChooseDlg:onBtnVisitRandClick(...)
	if self:isLevelLimit() then
		local data = CurAvatar:getRearHouseLevelInfo(RearHouseCommon.getRandVisitLv())

		MsgManager.notice(utils.format(Lang.get(30679), data.bigLv, data.smallLv))

		return
	end

	if (CurAvatar.nextRearHouseRandVisitTime or 0) < Time.time then
		RPC.houseVisitRandom()
		self:setVisible(false)
	end
end

function RearHouseVisitChooseDlg:openMorePanel(cell)
	self.curDelCommentData = cell

	local cellAbsPos = cell:getAbsPosition()

	self.morePanel:setAbsPosition(cellAbsPos.x + 3, cellAbsPos.y - 0.2)
	self.morePanel:setVisible(true)
	self.uIClickThrough:setVisible(true)
end

function RearHouseVisitChooseDlg:deleteCB()
	local ui = UIManager.tryGetUI("rearHouseVisitChooseDlg")

	if ui then
		ui:refreshFavoredUI()
	end
end

function RearHouseVisitChooseDlg:onBtnDeleteClick()
	local function yesFunc()
		self.morePanel:setVisible(false)
		self.uIClickThrough:setVisible(false)

		if self.curDelCommentData then
			CurAvatar.curDelCommentDataCache = self.curDelCommentData

			CurAvatar:DeleteRearHouseCommentHandler(self.curDelCommentData.commentId, self.curDelCommentData.uid, CurAvatar.uid, CurAvatar.uid, Functor(self.deleteCB, self))
		end
	end

	local msgContent = Lang.get(96439)

	UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(5), msgContent, yesFunc, nil, -1)
end

function RearHouseVisitChooseDlg:onUIClickThroughClick()
	self.morePanel:setVisible(false)
	self.uIClickThrough:setVisible(false)
end

function RearHouseVisitChooseDlg:onBtnCloseClick(...)
	self:setVisible(false)
end

return RearHouseVisitChooseDlg
