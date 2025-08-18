-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\RearHouse\\RearHouseCommentDlg.lua

local strClassName = "RearHouseCommentDlg"
local CommentMixin = require("Avatar/AvatarMixins/CommentMixin")
local RearHouseCommentDlg = Class(strClassName, UIControls.Window)
local CONTENT_MIN_CHARACTER = 1
local CONTENT_MAX_CHARACTER = 30

function RearHouseCommentDlg:ctor()
	self.onDlgClose = UIControls.Button(self, "BgPanel/BtnCancel")

	self.onDlgClose:addEventClick(self.btnCloseClick)

	self.btnConfirm = UIControls.Button(self, "BgPanel/BtnConfirm", "TimeText")

	self.btnConfirm:addEventClick(Functor(self.btnConfirmClick, self))

	self.evaluatePanel = UIControls.Panel(self, "BgPanel/EvaluatePanel")
	self.inputComment = UIControls.Input(self, "BgPanel/EvaluatePanel/InputContent")
	self.inputLimit = UIControls.Label(self, "BgPanel/EvaluatePanel/TipsTextNub")

	self.inputComment:addEventValueChanged(self.onContentChanged)
end

function RearHouseCommentDlg:setData(curVisitUid)
	self.curVisitUid = curVisitUid

	local content = self.inputComment:getText()
	local length = content and utils.utf8len(content) or 0

	if length == 0 then
		self.btnConfirm:setEnable(false)
	end

	ClientTimerManager.AddSecondFormatTickUI(self.btnConfirm, CommentMixin:getRHRequestCD(), nil, Lang.get(48664), Slot(self.countdownCallback, self), nil, 2)
	self.inputLimit:setText(string.format(Lang.get(30338), CONTENT_MAX_CHARACTER))
end

function RearHouseCommentDlg:countdownCallback()
	self.btnConfirm:setEnable(true)
	self.btnConfirm:setText("")
end

function RearHouseCommentDlg:onContentChanged(sender)
	local content = self.inputComment:getText()
	local length = content and utils.utf8len(content) or 0

	if length == 0 then
		self.inputLimit:setText(string.format(Lang.get(30338), CONTENT_MAX_CHARACTER))
	elseif length > CONTENT_MAX_CHARACTER then
		self.inputLimit:setText(string.format(Lang.get(30339), length - CONTENT_MAX_CHARACTER))
		self.btnConfirm:setEnable(true)
	else
		self.inputLimit:setText(string.format(Lang.get(30340), CONTENT_MAX_CHARACTER - length))
		self.btnConfirm:setEnable(true)
	end

	if CommentMixin:getRHRequestCD() < 0 then
		self.btnConfirm:setEnable(true)
	end
end

function RearHouseCommentDlg:btnCloseClick()
	self:setVisible(false)
end

function RearHouseCommentDlg:commentSuccessFunc()
	local ui = UIManager.getUI("rearHouseVisitMainDlg", nil, false)

	if ui then
		ui:refreshUI()
	end
end

function RearHouseCommentDlg:btnConfirmClick()
	local content = self.inputComment:getText()
	local length

	self.content, length = self:handleContent(content)

	if length < CONTENT_MIN_CHARACTER then
		MsgManager.notice(string.format(Lang.get(30335), CONTENT_MIN_CHARACTER))
	elseif length <= CONTENT_MAX_CHARACTER then
		CurAvatar.cachedRearHouseCommentUid = self.curVisitUid

		CurAvatar:PostRearHouseCommentHandler(self.curVisitUid, CurAvatar.uid, self.content, CurAvatar.name, Slot(self.commentSuccessFunc, self))
		self:setVisible(false)
		CommentMixin:setRHRequestCD(os.time())
	else
		MsgManager.notice(Lang.get(30341))
	end
end

function RearHouseCommentDlg:handleContent(ctent)
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

return RearHouseCommentDlg
