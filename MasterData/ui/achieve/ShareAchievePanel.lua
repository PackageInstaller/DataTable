-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Achieve\\ShareAchievePanel.lua

local ResAchieve = require("ClientData/ResAchieve")
local ShareUIConfig = require("DesignerScript/ShareUIConfig")
local PluginManager = require("SDK/Plugin/PluginManager")
local ResOpActivityShopDetail = require("ClientData/ResOpActivityShopDetail")
local strClassName = "ShareAchievePanel"
local ShareAchievePanel = Class(strClassName, UIControls.Panel)

ShareAchievePanel.AWARD_TYPE = {
	Achieve = "achieve",
	Activity = "activity",
	Shop = "shop",
	NoAward = "noAward"
}

function ShareAchievePanel:ctor(...)
	self:initUI()

	self.awardType = nil
end

function ShareAchievePanel:initUI(...)
	self.rootPanel = UIControls.Panel(self, self.mPath)
	self.shareBtn = UIControls.Button(self, self.mPath .. "/BtnShare", "Text")

	self.shareBtn:addEventClick(self._onClickShare)

	if UIControls.checkControlFunc(self, self.mPath .. "/BtnShare/IconNew") then
		self.shareBtnIconNew = UIControls.Panel(self, self.mPath .. "/BtnShare/IconNew")
	end

	if UIControls.checkControlFunc(self, self.mPath .. "/AwardPanel") then
		self.achieveAwardPanel = UIControls.Panel(self, self.mPath .. "/AwardPanel")
		self.achieveAwardTxt = UIControls.Label(self, self.mPath .. "/AwardPanel/EmojiText")
	end
end

function ShareAchievePanel:setBeforeAction(action, ...)
	self.beforeAction = action
	self.beforeActionParams = {
		...
	}
end

function ShareAchievePanel:setFinishAction(action, ...)
	self.finishAction = action
	self.finishActionParams = {
		...
	}
end

function ShareAchievePanel:setAchieveInfo(achieveType, uiName)
	self.awardType = self.AWARD_TYPE.Achieve
	self.achieveType = achieveType
	self.uiName = uiName

	local achieveInfo = self:_getAchieveInfoByType(achieveType)

	if not achieveInfo then
		return
	end

	self.achieveId = achieveInfo.id

	if self.achieveAwardTxt then
		self.achieveAwardTxt:setText(achieveInfo.action_desc or "")
	end
end

function ShareAchievePanel:setActivityInfo(opActId, uiName)
	self.awardType = self.AWARD_TYPE.Activity
	self.opActId = opActId
	self.uiName = uiName

	if self.achieveAwardTxt then
		self.achieveAwardTxt:setText(Const.DEFAULT_SHARE_AWARD)
	end
end

function ShareAchievePanel:setNoAwardInfo(uiName)
	self.awardType = self.AWARD_TYPE.NoAward
	self.uiName = uiName
end

function ShareAchievePanel:setShopInfo(actId, uiName)
	self.awardType = self.AWARD_TYPE.Shop
	self.actId = actId
	self.uiName = uiName
end

function ShareAchievePanel:setShareVisible(isVisible)
	self.rootPanel:setVisible(isVisible)

	if isVisible then
		self:refreshShareAchieve()
	end
end

function ShareAchievePanel:refreshShareAchieve(reward)
	local achievePanelVisible = false

	if self.achieveType and CurAvatar and CurAvatar:getAchieveProcessByType(self.achieveType) == 0 then
		achievePanelVisible = true
	elseif self.opActId and CurAvatar then
		local actObj = CurAvatar:getActivityObj(self.opActId)

		achievePanelVisible = not actObj.actData:hasShared()
		self.actType = actObj.actType
		self.opId = actObj.opId
	elseif self.actId and CurAvatar then
		local actObj = CurAvatar:getActivityObj(self.actId)

		self.opId = actObj.opId
		achievePanelVisible = reward
	end

	if self.achieveAwardPanel then
		self.achieveAwardPanel:setVisible(achievePanelVisible)
	end

	if self.shareBtnIconNew then
		self.shareBtnIconNew:setVisible(achievePanelVisible)
	end
end

function ShareAchievePanel:hideAwardPanel(isHide)
	self.achieveAwardPanel:setVisible(not isHide)
end

function ShareAchievePanel:setShareFrame(frameID, exchgId, reward)
	self.frameID = frameID
	self.exchgId = exchgId

	if self.actId and ResOpActivityShopDetail[self.actId] and self.achieveAwardTxt then
		self.achieveAwardTxt:setText(ResOpActivityShopDetail[self.actId][exchgId].awardText)
	end

	self:refreshShareAchieve(reward)
end

function ShareAchievePanel:_onClickShare()
	if self.beforeAction then
		self.beforeAction(unpack(self.beforeActionParams))
	end

	PluginManager.tryInitShare()

	if self.uiName and ShareUIConfig.ClosePanel[self.uiName] ~= nil then
		self.closePanels = {}

		for _, path in ipairs(ShareUIConfig.ClosePanel[self.uiName]) do
			local panel = UIControls.Panel(self, path)

			if panel and panel:getVisible() then
				table.insert(self.closePanels, panel)
				panel:setVisible(false)
			end
		end
	end

	if MsgManager.getScreenMsgHideflag() then
		self.skipHideMsg = true
	else
		MsgManager.showMsgOnScreen(false)
	end

	self:_hideOtherDlg()
	self:_onOpenCapture()
	UIManager.getUI("noticebox", true)
end

function ShareAchievePanel:_hideOtherDlg()
	local clickDlg = UIManager.getUI("click", nil, false)

	if clickDlg then
		clickDlg:setVisible(false)
	end

	local noticeDlg = UIManager.getUI("noticebox", nil, false)

	if noticeDlg then
		noticeDlg:setVisible(false)
	end

	local flyIconDlg = UIManager.getUI("flyIconDlg", nil, false)

	if flyIconDlg then
		flyIconDlg:setVisible(false)
	end
end

ShareAchievePanel.shareTitle = "1/7のワタシでも、あなたへの想いは1/1です！\nフィギュアがこっそり動きだすRPG『フィギュアストーリー』好評配信中！\n▼DLはコチラ▼\nhttps://giasuto.onelink.me/jFuI/af782d62"

function ShareAchievePanel:_onOpenCapture()
	local frameConfig = {}

	if self.frameID then
		frameConfig.frameType = self.frameID
	elseif self.uiName and ShareUIConfig.UseFrame[self.uiName] ~= nil then
		frameConfig.frameType = ShareUIConfig.UseFrame[self.uiName]
	end

	if self.actId then
		frameConfig.actId = self.actId
	end

	frameConfig.title = self.shareTitle

	local captureDlg = UIManager.getUI("captureDlg", true)

	captureDlg:capture(Slot(self._shareCallback, self), frameConfig)
end

function ShareAchievePanel:_shareCallback(shareId)
	local shareSuccess = shareId ~= 0

	if shareSuccess then
		if CurAvatar and self.achieveType and CurAvatar:getAchieveProcessByType(self.achieveType) == 0 then
			CurAvatar:updateClientAchieveProgress(self.achieveType, 1)
		end

		if self.actType and self.opId and self.achieveAwardPanel and self.achieveAwardPanel:getVisible() then
			if self.actType == Const.ACT_TYPE_REPLACE_POOL then
				RPC.opActDrawReplaceShareAward(self.opId)
			elseif self.actType == Const.ACT_TYPE_UPDRAW then
				RPC.opActDrawGetShareAward(self.opId)
			end
		end

		if CurAvatar and self.opId and self.achieveAwardPanel and self.achieveAwardPanel:getVisible() and self.awardType == self.AWARD_TYPE.Shop then
			CurAvatar:activityRPC(Functor(RPC.opActGetAward, self.opId, self.exchgId, 1), self.opId)
		end

		if self.achieveAwardPanel then
			self.achieveAwardPanel:setVisible(false)
		end

		if self.shareBtnIconNew then
			self.shareBtnIconNew:setVisible(false)
		end
	end

	if self.closePanels then
		for _, panel in ipairs(self.closePanels) do
			panel:setVisible(true)
		end

		self.closePanels = nil
	end

	if not self.skipHideMsg then
		MsgManager.showMsgOnScreen(true)
	else
		self.skipHideMsg = nil
	end

	if self.finishAction then
		self.finishAction(unpack(self.finishActionParams))
	end

	local clickDlg = UIManager.getUI("click", true)
end

function ShareAchievePanel:_getAchieveInfoByType(achieveType)
	for achieveId, achieveInfo in pairs(ResAchieve) do
		if achieveInfo.action_type == achieveType then
			return achieveInfo
		end
	end
end

return ShareAchievePanel
