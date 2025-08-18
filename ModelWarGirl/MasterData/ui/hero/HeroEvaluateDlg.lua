-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Hero\\HeroEvaluateDlg.lua

local strClassName = "heroEvaluateDlg"
local CommentMixin = require("Avatar/AvatarMixins/CommentMixin")
local HeroEvaluateDlg = Class(strClassName, UIControls.Window)
local MAX_STAR = 5
local CONTENT_MIN_CHARACTER = 1
local CONTENT_MAX_CHARACTER = 100
local PANEL_TYPE = {
	score = "score",
	evaluate = "evaluate"
}

function HeroEvaluateDlg:ctor()
	self.onDlgClose = UIControls.Button(self, "BgPanel/BtnCancel")

	self.onDlgClose:addEventClick(self.btnCloseClick)

	self.btnConfirm = UIControls.Button(self, "BgPanel/BtnConfirm", "TimeText")
	self.evaluatePanel = UIControls.Panel(self, "BgPanel/EvaluatePanel")

	self.evaluatePanel:setVisible(false)

	self.scorePanel = UIControls.Panel(self, "BgPanel/ScorePanel")

	self.scorePanel:setVisible(false)

	self.inputComment = UIControls.Input(self, "BgPanel/EvaluatePanel/InputContent")
	self.inputLimit = UIControls.Label(self, "BgPanel/EvaluatePanel/TipsTextNub")
	self.scoreNoticeText = UIControls.Panel(self, "BgPanel/ScorePanel/TipsText")
	self.evaluateNoticeText = UIControls.Panel(self, "BgPanel/EvaluatePanel/TipsText")
	self.starGroup = {}

	for i = 1, MAX_STAR do
		self.starGroup[i] = UIControls.Toggle(self, "BgPanel/ScorePanel/StartGroup/TogglePraise0" .. i)

		self.starGroup[i]:addEventValueChanged(self.valueChanged)

		self.starGroup[i].index = i
	end

	self.scoreText = UIControls.Label(self, "BgPanel/ScorePanel/NubText")

	self.scoreText:setText("")
	self.inputComment:addEventValueChanged(self.onContentChanged)
end

function HeroEvaluateDlg:switchPanel(panelType, heroId, Evaluate)
	self.heroId = heroId
	self.Evaluate = Evaluate

	if panelType == PANEL_TYPE.score then
		self.scorePanel:setVisible(true)
	elseif panelType == PANEL_TYPE.evaluate then
		self.evaluatePanel:setVisible(true)
		ClientTimerManager.AddSecondFormatTickUI(self.btnConfirm, CommentMixin:getRequestCD(), nil, Lang.get(48664), Slot(self.countdownCallback, self), nil, 2)
	end

	self.btnConfirm:addEventClick(Functor(self.btnConfirmClick, self, panelType))
	self.btnConfirm:setEnable(false)
end

function HeroEvaluateDlg:countdownCallback()
	self.btnConfirm:setEnable(true)
	self.btnConfirm:setText("")
end

function HeroEvaluateDlg:onContentChanged(sender)
	local content = self.inputComment:getText()
	local length = content and utils.utf8len(content) or 0

	if length == 0 then
		self.inputLimit:setText(Lang.get(30338), CONTENT_MAX_CHARACTER)
	elseif length > CONTENT_MAX_CHARACTER then
		self.inputLimit:setText(string.format(Lang.get(30339), length - CONTENT_MAX_CHARACTER))
	else
		self.inputLimit:setText(string.format(Lang.get(30340), CONTENT_MAX_CHARACTER - length))
	end

	if CommentMixin:getRequestCD() < 0 then
		self.btnConfirm:setEnable(true)
	end
end

function HeroEvaluateDlg:btnCloseClick(pageType)
	if pageType == PANEL_TYPE.evaluate then
		-- block empty
	elseif pageType == PANEL_TYPE.score then
		self.Evaluate:refreshScoreText(self.heroScore)
	end

	if UIManager.tryGetUI("heroEvaluateDlg") then
		UIManager.tryGetUI("heroEvaluateDlg"):setVisible(false)
	end
end

function HeroEvaluateDlg:hideEvaluateNotice()
	self.evaluateNoticeText:setVisible(false)
end

function HeroEvaluateDlg:hideScoreNotice()
	self.scoreNoticeText:setVisible(false)
end

function HeroEvaluateDlg:btnConfirmClick(panelType)
	if panelType == PANEL_TYPE.score then
		if self.heroScore ~= nil then
			CurAvatar:PostRateHandler(CurAvatar.uid, self.heroId, self.heroScore or 0, Functor(self.btnCloseClick, self, PANEL_TYPE.score))
		end
	elseif panelType == PANEL_TYPE.evaluate then
		local content = self.inputComment:getText()
		local length

		self.content, length = self:handleContent(content)

		if length < CONTENT_MIN_CHARACTER then
			MsgManager.notice(string.format(Lang.get(30335), CONTENT_MIN_CHARACTER))
		elseif length <= CONTENT_MAX_CHARACTER then
			CurAvatar:PostCommentHandler(self.heroId, CurAvatar.uid, self.content, CurAvatar.name, Functor(self.btnCloseClick, self, PANEL_TYPE.evaluate))
			self:setVisible(false)
			CommentMixin:setRequestCD(os.time())
		else
			MsgManager.notice(Lang.get(30341))
		end
	end
end

function HeroEvaluateDlg:handleContent(ctent)
	local str = string.gsub(ctent, " ", "")
	local str1 = string.gsub(str, "\t", "")
	local content = string.gsub(str1, "\n", "")
	local lenFilterSpace = utils.utf8len(content)

	if lenFilterSpace < CONTENT_MIN_CHARACTER then
		return content, lenFilterSpace
	else
		content = string.gsub(ctent, "\n", " ")
		lenFilterSpace = utils.utf8len(content)

		return content, lenFilterSpace
	end
end

function HeroEvaluateDlg:valueChanged(sender, lastScore)
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

	self.heroScore = 2 * ind

	self.scoreText:setText(string.format(Lang.get(30336), self.heroScore))

	self.curClickIndex = nil

	self.btnConfirm:setEnable(true)
end

return HeroEvaluateDlg
