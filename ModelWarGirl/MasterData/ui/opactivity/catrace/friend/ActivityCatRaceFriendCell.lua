-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\CatRace\\Friend\\ActivityCatRaceFriendCell.lua

local HeadHelper = require("UI/RoleInfo/HeadHelper")
local ResClientNotice = require("ClientData/ResClientNotice")
local strClassName = "ActivityCatRaceFriendCell"
local ActivityCatRaceFriendCell = Class(strClassName, UIControls.ScrollViewLoopCell)

function ActivityCatRaceFriendCell:ctor()
	self:initUI()
end

function ActivityCatRaceFriendCell:initUI()
	self.playerNameTxt = UIControls.Label(self, "TextPlayerName")
	self.playerGridPanel = UIControls.Panel(self, "GridPlayer")
	self.btnHead = UIControls.PlayerHeadGridChild(self, "GridPlayer", "System/Common/Grid/GridPlayerCommon")
	self.serverTxt = UIControls.Label(self, "TextServer")
	self.crossServerImg = UIControls.Image(self, "TextServer/IconServer")
	self.giftNumTxt = UIControls.Label(self, "TextGiftPanel/TextNum")
	self.giftSendBtn = UIControls.Button(self, "FuncPanel/BtnGiftSend")

	self.giftSendBtn:addEventClick(self._onBtnGiftSend)

	self.giftSendHighLightImg = UIControls.Image(self, "FuncPanel/BtnGiftSend/BgHighlight")
	self.giftReceiveBtn = UIControls.Button(self, "FuncPanel/BtnGiftReceive")

	self.giftReceiveBtn:addEventClick(self._onBtnGiftReceive)

	self.giftReceiveHighlightImg = UIControls.Image(self, "FuncPanel/BtnGiftReceive/BgHighlight")
	self.giftReceiveBgImg = UIControls.Image(self, "FuncPanel/BtnGiftReceive/Bg")
	self.giftReceiveHighLightImg = UIControls.Image(self, "FuncPanel/BtnGiftReceive/BgHightLight")
	self.compSetBtn = UIControls.Button(self, "FuncPanel/BtnComp")

	self.compSetBtn:addEventClick(self._onBtnCompSet)

	self.compHighLightImg = UIControls.Image(self, "FuncPanel/BtnComp/BgHighlight")
	self.chatBtn = UIControls.Button(self, "FuncPanel/BtnChat")

	self.chatBtn:addEventClick(self._onBtnChat)

	self.giftPanel = UIControls.Panel(self, "TextGiftPanel")
end

function ActivityCatRaceFriendCell:setData(data, mainActID)
	self.friendInfo = data
	self.mainActID = mainActID
	self.mainActObj = CurAvatar:getActivityObj(self.mainActID)
	self.mainActData = self.mainActObj.actData
	self.mainOpID = self.mainActObj.opId
	self.maxCount = self.mainActData.miscData.recive_max_count

	self:setVisible(true)
	self:refreshData()
end

function ActivityCatRaceFriendCell:refreshData()
	self.playerNameTxt:setText(self.friendInfo.name)
	self.serverTxt:setText(self.friendInfo.serverName)
	self.crossServerImg:setVisible(not self.friendInfo.sameServer)
	self.btnHead:hideLevel()
	self.btnHead:setEnable(false)
	self.btnHead:setCommInfo(self.friendInfo, false, self)

	self.isSent = self.mainActData:checkFriendIsSent(self.friendInfo.uid)

	self.giftSendHighLightImg:setVisible(not self.isSent)

	self.isReceived = self.mainActData:checkFriendIsReceived(self.friendInfo.uid)
	self.canRecevied = self.mainActData:checkFriendCanReceived(self.friendInfo.uid)

	self.giftReceiveHighlightImg:setVisible(self.canRecevied)

	self.isComp = self.mainActData:checkFriendIsComp(self.friendInfo.uid)

	self.compHighLightImg:setVisible(self.isComp)

	self.receiveNum = self.mainActData:getFriendReceiveNum(self.friendInfo.uid)
	self.totalGiftNum = self.mainActData:getTotalGiftNum(self.friendInfo.uid)

	if self.totalGiftNum > 0 then
		self.giftPanel:setVisible(true)
		self.giftNumTxt:setText(self.totalGiftNum)
	else
		self.giftPanel:setVisible(false)
	end
end

function ActivityCatRaceFriendCell:_onBtnCompSet()
	if not self.isComp then
		CurAvatar:activityRPC(Functor(RPC.opActCatRaceSetFriend, self.mainOpID, self.friendInfo.uid), self.mainOpID)
		MsgManager.notice(ResClientNotice[453].notice)
	else
		MsgManager.notice(ResClientNotice[454].notice)
		CurAvatar:activityRPC(Functor(RPC.opActCatRaceSetFriend, self.mainOpID, "0"), self.mainOpID)
	end
end

function ActivityCatRaceFriendCell:_onBtnGiftSend()
	if not self.isSent then
		local uidList = {
			self.friendInfo.uid
		}

		CurAvatar:activityRPC(Functor(RPC.opActCatRaceSendFriend, self.mainOpID, uidList), self.mainOpID)
		MsgManager.notice(ResClientNotice[450].notice)
	else
		MsgManager.notice(ResClientNotice[455].notice)
	end
end

function ActivityCatRaceFriendCell:_onBtnGiftReceive()
	if self.canRecevied then
		local curCount = self.mainActData:getReceivedGiftNum()

		if curCount < self.maxCount then
			local uidList = {
				self.friendInfo.uid
			}

			CurAvatar:activityRPC(Functor(RPC.opActCatRaceGetFriendGift, self.mainOpID, uidList), self.mainOpID)
		else
			MsgManager.notice(ResClientNotice[457].notice)
		end
	end
end

function ActivityCatRaceFriendCell:_onBtnChat()
	UIManager.getUI("chatDlg", true):addFriendTalk(self.friendInfo)
end

return ActivityCatRaceFriendCell
