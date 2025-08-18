-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\CatRace\\Friend\\ActivityCatRaceFriendDlg.lua

local ResOpActivityCatRaceMisc = require("ClientData/ResOpActivityCatRaceMisc")
local ResClientNotice = require("ClientData/ResClientNotice")
local ActivityCatRaceFriendCell = require("UI/OpActivity/CatRace/Friend/ActivityCatRaceFriendCell")
local strClassName = "ActivityCatRaceFriendDlg"
local ActivityCatRaceFriendDlg = Class(strClassName, UIControls.Window)

function ActivityCatRaceFriendDlg:ctor()
	self.cellPrefabPath = "System/Activity/ActivityCatRace/BtnCatRaceFriendCell"
	self.cellMountPath = "BgPanel/FriendList/Content"

	self:initUI()
end

function ActivityCatRaceFriendDlg:initUI()
	self.cells = {}
	self.scroll = UIControls.ScrollViewLoopV(self, "BgPanel/FriendList")

	self.scroll:addEventCellChanged(self.onCellChanged)

	self.closeBtn = UIControls.Button(self, "BgPanel/BgFrame/DecPanel/Dec03")

	self.closeBtn:addEventClick(self._onBtnClose)

	self.quickGiftBtn = UIControls.Button(self, "BgPanel/BtnQuickGift")

	self.quickGiftBtn:addEventClick(self._onBtnQuickGift)

	self.labelQuickGiftBtnEng = UIControls.Label(self, "BgPanel/BtnQuickGift/TextEng")
	self.quickGiftTipTxt = UIControls.Label(self, "BgPanel/TextNumGift")
	self.noFriendPanel = UIControls.Panel(self, "BgPanel/ImgNothing")
	self.tipsBtn = UIControls.Button(self, "BgPanel/BgTitle/TextTitle/BtnTips")

	self.tipsBtn:addEventClick(self._onBtnTips)
end

function ActivityCatRaceFriendDlg:_onBtnClose()
	self:setVisible(false)
end

function ActivityCatRaceFriendDlg:_onBtnTips()
	UIManager.getUI("infoNotice", true):showSystemInfo(self.mainActData.miscData.gift_tip_id)
end

function ActivityCatRaceFriendDlg:setData(data)
	self.mainActID = data.mainActID
	self.resData = ResOpActivityCatRaceMisc[self.mainActID]
	self.mainActObj = CurAvatar:getActivityObj(self.mainActID)

	if self.mainActObj then
		self.mainActData = self.mainActObj.actData
		self.mainOpID = self.mainActObj.opId
		self.comPlayer = self.mainActData:getComPlayer()
		self.friendDataList = CurAvatar:getSortedFriends()

		if self.friendDataList and #self.friendDataList > 0 then
			for i = #self.friendDataList, 1, -1 do
				if self.mainActData:checkFriendIsComp(self.friendDataList[i].uid) then
					self.friendDataList[i], self.friendDataList[1] = self.friendDataList[1], self.friendDataList[i]

					break
				end
			end

			table.sort(self.friendDataList, Slot(self._friendSortFunc, self))
			self.scroll:setTotalCount(#self.friendDataList)
		end

		self.maxCount = self.mainActData.miscData.recive_max_count

		self:refreshData()
	end
end

function ActivityCatRaceFriendDlg:_friendSortFunc(friendA, friendB)
	local AIsComp = self.mainActData:checkFriendIsComp(friendA.uid)
	local AHasSent = self.mainActData:checkFriendIsSent(friendA.uid)
	local AHasReceive = self.mainActData:checkFriendCanReceived(friendA.uid)
	local BIsComp = self.mainActData:checkFriendIsComp(friendB.uid)
	local BHasSent = self.mainActData:checkFriendIsSent(friendB.uid)
	local BHasReceive = self.mainActData:checkFriendCanReceived(friendB.uid)

	if AIsComp then
		return true
	end

	if BIsComp then
		return false
	end

	if AHasReceive and not BHasReceive then
		return true
	end

	if BHasReceive and not AHasReceive then
		return false
	end

	if not AHasSent and BHasSent then
		return true
	end

	if not BHasSent and AHasSent then
		return false
	end

	if friendA.online and friendB.online then
		return friendA.level > friendB.level
	elseif friendA.online then
		return true
	elseif friendB.online then
		return false
	else
		return friendA.logout_tick > friendB.logout_tick
	end
end

function ActivityCatRaceFriendDlg:refreshData()
	if self.cells then
		for _, cell in pairs(self.cells) do
			cell:refreshData()
		end
	end

	self.curCount = self.mainActData:getReceivedGiftNum()

	self.quickGiftTipTxt:setText(utils.format(Lang.get(53352), self.curCount, self.maxCount))

	self.remainGiftNum = self.maxCount - self.curCount

	self.noFriendPanel:setVisible(#self.friendDataList <= 0)

	if self.mainActData:hasGiftToSend() or self.mainActData:hasGiftToReceive() then
		self.quickGiftBtn:setObjGray(false)
		self.labelQuickGiftBtnEng:setFontColor(ResColor.BLUE)
	else
		self.quickGiftBtn:setObjGray(true)
		self.labelQuickGiftBtnEng:setFontColor(ResColor.GREYMIDDLE)
	end
end

function ActivityCatRaceFriendDlg:onCellChanged(sender, targetCell, newIdx)
	if not self.friendDataList then
		return
	end

	local cellData = self.friendDataList[newIdx]

	if not cellData then
		return
	end

	if targetCell == nil then
		targetCell = ActivityCatRaceFriendCell(sender, self.cellPrefabPath, newIdx, 0, 0)
	else
		self.cells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	targetCell:setData(cellData, self.mainActID)

	self.cells[newIdx] = targetCell
end

function ActivityCatRaceFriendDlg:_onBtnQuickGift()
	if self.mainActData:hasGiftToSend() or self.mainActData:hasGiftToReceive() then
		self:quickGiftAll()
		self:quickReceiveAll()
	elseif self.mainActData:hasTodayMaxGift() then
		MsgManager.notice(ResClientNotice[457].notice)
	else
		MsgManager.notice(ResClientNotice[452].notice)
	end
end

function ActivityCatRaceFriendDlg:quickGiftAll()
	local uidList = {}

	for _, friend in ipairs(self.friendDataList) do
		if not self.mainActData:checkFriendIsSent(friend.uid) then
			table.insert(uidList, friend.uid)
		end
	end

	if #uidList > 0 then
		CurAvatar:activityRPC(Functor(RPC.opActCatRaceSendFriend, self.mainOpID, uidList), self.mainOpID)
		MsgManager.notice(ResClientNotice[450].notice)
	end
end

function ActivityCatRaceFriendDlg:quickReceiveAll()
	local uidList = {}

	for _, friend in ipairs(self.friendDataList) do
		if self.mainActData:checkFriendCanReceived(friend.uid) then
			table.insert(uidList, friend.uid)
		end
	end

	local curCount = self.mainActData:getReceivedGiftNum()
	local remainGiftNum = self.maxCount - curCount

	if remainGiftNum < #uidList then
		for i = #uidList, self.remainGiftNum + 1, -1 do
			table.remove(uidList, i)
		end
	end

	if #uidList > 0 and self.mainActData:getReceivedGiftNum() < self.maxCount then
		CurAvatar:activityRPC(Functor(RPC.opActCatRaceGetFriendGift, self.mainOpID, uidList), self.mainOpID)
	end
end

return ActivityCatRaceFriendDlg
