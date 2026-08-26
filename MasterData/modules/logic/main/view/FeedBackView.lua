-- chunkname: @modules/logic/main/view/FeedBackView.lua

module("modules.logic.main.view.FeedBackView", package.seeall)

local FeedBackView = class("FeedBackView", BaseView)

function FeedBackView:onInitView()
	self._browserGo = gohelper.findChild(self.viewGO, "browser")
	self._rootGo = gohelper.findChild(self.viewGO, "root")
	self._gosuretip = gohelper.findChild(self.viewGO, "root/bottom/#go_suretip")
	self._txtsuretip = gohelper.findChildText(self.viewGO, "root/bottom/#go_suretip")
	self._btnsure = gohelper.findChildButtonWithAudio(self.viewGO, "root/bottom/#btn_sure")
	self._inputfeedback = gohelper.findChildTextMeshInputField(self.viewGO, "root/message/#input_feedback")
	self._inputtitle = gohelper.findChildTextMeshInputField(self.viewGO, "root/#input_title")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FeedBackView:addEvents()
	self._btnsure:AddClickListener(self._btnsureOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._inputfeedback:AddOnValueChanged(self._onContentValueChanged, self)
	self._inputtitle:AddOnValueChanged(self._onTitleValueChanged, self)
end

function FeedBackView:removeEvents()
	self._btnsure:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self._inputfeedback:RemoveOnValueChanged()
	self._inputtitle:RemoveOnValueChanged()
end

FeedBackView.commitInterval = 30
FeedBackView.maxTitleLength = 20
FeedBackView.maxContentLength = 300
FeedBackView.nilTitleToastId = 124
FeedBackView.nilContentToastId = 125
FeedBackView.maxTitleToastId = 126
FeedBackView.maxContentToastId = 127

function FeedBackView:_btnsureOnClick()
	local titleText = self._inputtitle:GetText()
	local contentText = self._inputfeedback:GetText()

	if string.nilorempty(titleText) and string.nilorempty(contentText) then
		return
	end

	if string.nilorempty(titleText) then
		GameFacade.showToast(FeedBackView.nilTitleToastId)

		return
	end

	if string.nilorempty(contentText) then
		GameFacade.showToast(FeedBackView.nilContentToastId)

		return
	end

	TaskDispatcher.cancelTask(self.hideSureTip, self)

	local preCommitTime = PlayerModel.instance:getPreFeedBackTime()

	if preCommitTime == -1 or Time.time - preCommitTime > FeedBackView.commitInterval then
		self:sendRequest(titleText, contentText)
		PlayerModel.instance:setPreFeedBackTime()
	else
		self._txtsuretip.text = luaLang("frequently_commit")

		gohelper.setActive(self._gosuretip, true)
		TaskDispatcher.runDelay(self.hideSureTip, self, 3)
	end
end

function FeedBackView:_btncloseOnClick()
	self:closeThis()
end

function FeedBackView:sendRequest(title, content)
	local feedbackUrl = GameUrlConfig.getCurConfig().feedBack
	local data = {}

	table.insert(data, string.format("userId=%s", PlayerModel.instance:getMyUserId()))
	table.insert(data, string.format("title=%s", title))
	table.insert(data, string.format("content=%s", content))

	feedbackUrl = feedbackUrl .. "?" .. table.concat(data, "&")

	logWarn(feedbackUrl)
	SLFramework.SLWebRequest.Instance:Get(feedbackUrl, self.receiveResponse, self)
end

function FeedBackView:receiveResponse(isSuccess, msg)
	if msg == "fail" then
		self._txtsuretip.text = luaLang("frequently_commit")
	else
		self._txtsuretip.text = luaLang("thanks_feedback")

		self._inputfeedback:SetText("")
		self._inputtitle:SetText("")
	end

	gohelper.setActive(self._gosuretip, true)
	TaskDispatcher.runDelay(self.hideSureTip, self, 3)
end

function FeedBackView:_onContentValueChanged()
	local contentText = self._inputfeedback:GetText()

	if string.utf8len(contentText) > FeedBackView.maxContentLength then
		contentText = GameUtil.utf8sub(contentText, 1, FeedBackView.maxContentLength)

		self._inputfeedback:SetText(contentText)
		GameFacade.showToast(FeedBackView.maxContentToastId, FeedBackView.maxContentLength)
	end
end

function FeedBackView:_onTitleValueChanged()
	local titleText = self._inputtitle:GetText()

	if string.utf8len(titleText) > FeedBackView.maxTitleLength then
		titleText = GameUtil.utf8sub(titleText, 1, FeedBackView.maxTitleLength)

		self._inputtitle:SetText(titleText)
		GameFacade.showToast(FeedBackView.maxTitleToastId, FeedBackView.maxTitleLength)
	end
end

function FeedBackView:hideSureTip()
	gohelper.setActive(self._gosuretip, false)
end

function FeedBackView:_editableInitView()
	gohelper.addUIClickAudio(self._btnclose.gameObject, AudioEnum.UI.play_ui_feedback_close)
end

function FeedBackView:onUpdateParam()
	return
end

function FeedBackView:onOpen()
	if GameChannelConfig.isSlsdk() then
		self:hideSureTip()
		gohelper.setActive(self._browserGo, false)
		gohelper.setActive(self._rootGo, true)
	else
		gohelper.setActive(self._browserGo, true)
		gohelper.setActive(self._rootGo, false)
	end

	NavigateMgr.instance:addEscape(ViewName.FeedBackView, self._btncloseOnClick, self)
end

function FeedBackView:onClose()
	return
end

function FeedBackView:onDestroyView()
	return
end

return FeedBackView
