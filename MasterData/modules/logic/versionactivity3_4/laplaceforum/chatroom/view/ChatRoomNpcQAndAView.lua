-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/chatroom/view/ChatRoomNpcQAndAView.lua

module("modules.logic.versionactivity3_4.laplaceforum.chatroom.view.ChatRoomNpcQAndAView", package.seeall)

local ChatRoomNpcQAndAView = class("ChatRoomNpcQAndAView", BaseView)

function ChatRoomNpcQAndAView:onInitView()
	self._goroot = gohelper.findChild(self.viewGO, "root")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_close")
	self._txttitle = gohelper.findChildText(self.viewGO, "root/Title/txt_Title")
	self._imagehead = gohelper.findChildImage(self.viewGO, "root/head/#image_head")
	self._txtquestion = gohelper.findChildText(self.viewGO, "root/questionbox/#txt_question")
	self._gobtns = gohelper.findChild(self.viewGO, "root/layout_btn")
	self._btna1 = gohelper.findChildButtonWithAudio(self.viewGO, "root/layout_btn/#btn_a1")
	self._txta1 = gohelper.findChildText(self.viewGO, "root/layout_btn/#btn_a1/#txt_a1")
	self._btna2 = gohelper.findChildButtonWithAudio(self.viewGO, "root/layout_btn/#btn_a2")
	self._txta2 = gohelper.findChildText(self.viewGO, "root/layout_btn/#btn_a2/#txt_a2")
	self._btna3 = gohelper.findChildButtonWithAudio(self.viewGO, "root/layout_btn/#btn_a3")
	self._txta3 = gohelper.findChildText(self.viewGO, "root/layout_btn/#btn_a3/#txt_a3")
	self._txtcomment = gohelper.findChildText(self.viewGO, "root/#txt_comment")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ChatRoomNpcQAndAView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btna1:AddClickListener(self._btna1OnClick, self)
	self._btna2:AddClickListener(self._btna2OnClick, self)
	self._btna3:AddClickListener(self._btna3OnClick, self)
end

function ChatRoomNpcQAndAView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btna1:RemoveClickListener()
	self._btna2:RemoveClickListener()
	self._btna3:RemoveClickListener()
end

function ChatRoomNpcQAndAView:_btncloseOnClick()
	UIBlockMgr.instance:startBlock("npccQAndAShow")
	self._viewAnim:Play("out", 0, 0)
	TaskDispatcher.runDelay(self.closeThis, self, 0.33)
end

function ChatRoomNpcQAndAView:_btna1OnClick()
	self:_selectAnswer(1)
end

function ChatRoomNpcQAndAView:_btna2OnClick()
	self:_selectAnswer(2)
end

function ChatRoomNpcQAndAView:_btna3OnClick()
	self:_selectAnswer(3)
end

function ChatRoomNpcQAndAView:_selectAnswer(option)
	if self._answered then
		return
	end

	local qCo = Activity225Config.instance:getQuestionCo(self.viewParam)
	local aIds = string.splitToNumber(qCo.answerIds, "|")
	local id = aIds[option]

	Activity225Rpc.instance:sendAct225QAndARequest(self._actId, id)
end

function ChatRoomNpcQAndAView:_editableInitView()
	self._actId = VersionActivity3_4Enum.ActivityId.LaplaceChatRoom

	self:_addSelfEvents()

	self._viewAnim = self._goroot:GetComponent(typeof(UnityEngine.Animator))
end

function ChatRoomNpcQAndAView:_addSelfEvents()
	self.addEventCb(self, ChatRoomController.instance, ChatRoomEvent.OnQAndABack, self._onAnswerFinished, self)
end

function ChatRoomNpcQAndAView:_removeSelfEvents()
	self.removeEventCb(self, ChatRoomController.instance, ChatRoomEvent.OnQAndABack, self._onAnswerFinished, self)
end

function ChatRoomNpcQAndAView:_onAnswerFinished(id)
	gohelper.setActive(self._txtcomment.gameObject, true)

	local qCo = Activity225Config.instance:getQuestionCo(self.viewParam)
	local aIds = string.splitToNumber(qCo.answerIds, "|")

	gohelper.setActive(self._btna1.gameObject, aIds[1] == id)
	gohelper.setActive(self._btna2.gameObject, aIds[2] == id)
	gohelper.setActive(self._btna3.gameObject, aIds[3] == id)

	local aCo = Activity225Config.instance:getAnswerCo(id)

	self._txtcomment.text = aCo.answerComment
	self._answered = true
end

function ChatRoomNpcQAndAView:onOpen()
	self._answered = false

	self:_refreshUI()
end

function ChatRoomNpcQAndAView:_refreshUI()
	if self._answered then
		return
	end

	local qCos = Activity225Config.instance:getQuestionCos()
	local qCo = qCos[self.viewParam]

	self._txttitle.text = GameUtil.getSubPlaceholderLuaLang(luaLang("v3a4_chatroomnpcqandaview_txt_title"), {
		self.viewParam,
		#qCos
	})
	self._txtquestion.text = qCo.question

	gohelper.setActive(self._txtcomment.gameObject, false)
	gohelper.setActive(self._gobtns, true)

	local aIds = string.splitToNumber(qCo.answerIds, "|")

	for i = 1, #aIds do
		local aCo = Activity225Config.instance:getAnswerCo(aIds[i])

		self["_txta" .. i].text = aCo.answerTxt
	end
end

function ChatRoomNpcQAndAView:onClose()
	UIBlockMgr.instance:endBlock("npccQAndAShow")
end

function ChatRoomNpcQAndAView:onDestroyView()
	self:_removeSelfEvents()
end

return ChatRoomNpcQAndAView
