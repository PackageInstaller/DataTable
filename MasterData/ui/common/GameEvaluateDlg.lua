-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\GameEvaluateDlg.lua

local Analytics = require("SDK/Analytics")
local UserData = require("Helper/UserData")
local GameEvaluateDlg = Class("GameEvaluateDlg", UIControls.Window)
local MAX_STAR = 5

function GameEvaluateDlg:ctor()
	self.starGroup = {}

	for i = 1, MAX_STAR do
		self.starGroup[i] = UIControls.Toggle(self, "BgPanel/ScorePanel/StartGroup/TogglePraise0" .. i)

		self.starGroup[i]:addEventValueChanged(self.valueChanged)

		self.starGroup[i].index = i
	end

	self.btnClose = UIControls.Button(self, "BgPanel/BtnCancel")

	self.btnClose:setText("後で")
	self.btnClose:addEventClick(self.onCloseClick)

	self.btnConfirm = UIControls.Button(self, "BgPanel/BtnConfirm", "Text")

	self.btnConfirm:setText("応援する")
	self.btnConfirm:addEventClick(self.onConfirmClick)
	self.btnConfirm:setEnable(false)

	self.txtTitle = UIControls.Label(self, "BgPanel/TextTitle")

	self.txtTitle:setText("大好きなご主人様に一生のお願い！")

	self.txtDescription = UIControls.Label(self, "BgPanel/ScorePanel/Text")

	self.txtDescription:setText("ちょっとでも面白いと思っていれば星を付けて、応援レビュー書いていただけませんか？(｡>人<｡)")
	self.txtDescription:setAlign(UIConst.TXTALIGN_UL)
end

function GameEvaluateDlg:popupPos(pos)
	self.popPos = pos

	self:setPopUpTimes(self:getPopUpTimes())
end

function GameEvaluateDlg:valueChanged(sender)
	local ind = sender.index

	if self.curClickIndex ~= nil and ind ~= self.curClickIndex then
		return
	end

	self.curClickIndex = ind

	for i = 1, MAX_STAR do
		if not self.starGroup[i]:isOn() and i <= ind then
			self.starGroup[i]:setOn(true)
		elseif ind < i then
			self.starGroup[i]:setOn(false)
		end
	end

	self.star = ind
	self.curClickIndex = nil

	self.btnConfirm:setEnable(true)
end

function GameEvaluateDlg:onConfirmClick()
	local function yesFunc()
		SDKAgent.customerService()
		self:reportBuriedPoint("comment_popup", 1)
		self:setVisible(false)
	end

	local function noFunc()
		self:reportBuriedPoint("comment_popup", 2)
		self:setVisible(false)
	end

	if self.star <= 4 then
		UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "", "ご主人様にもっともーっと！楽しく遊んでいただけたいので、ご意見を聞いちゃダメでしょうか？\nб(//ｘ//）", yesFunc, noFunc, nil, "意見を書く", "特になし", nil, UIConst.TXTALIGN_UL)
	else
		ChannelUtil.doAnyFunction("evaluate", {
			evaluateShowType = "1"
		})
		self:setPopUpTimes(-1)
		self:setVisible(false)
	end

	self:reportBuriedPoint("rating_popup", 1)
end

function GameEvaluateDlg:onCloseClick()
	self:setVisible(false)
	self:reportBuriedPoint("rating_popup", 2)
end

function GameEvaluateDlg:reportBuriedPoint(logType, action)
	local strData = Analytics.getByteSendLogPubParameter()

	strData.action = action
	strData.rate = self.star
	strData.times = self:getPopUpTimes()
	strData.popup_pos = self.popPos

	Analytics.sendLogByted(logType, ClientUtils.table2String(strData))
end

function GameEvaluateDlg:getPopUpTimes()
	if not self.popupTimes then
		self.popupTimes = tonumber(UserData.loadCommonData("GameEvaluateNum_Total")) or 0
	end

	return self.popupTimes + 1
end

function GameEvaluateDlg:setPopUpTimes(time)
	UserData.saveCommonData("GameEvaluateNum_Total", tostring(time))
	UserData.saveCommonData("GameEvaluateNum_Last_" .. self.popPos, tostring(os.time()))
end

return GameEvaluateDlg
