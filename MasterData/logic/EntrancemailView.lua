-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/entrance/view/EntrancemailView.lua

module("logic.extensions.entrance.view.EntrancemailView", package.seeall)

local EntrancemailView = class("EntrancemailView", ViewComponent)

function EntrancemailView:ctor()
	EntrancemailView.super.ctor(self)
end

function EntrancemailView:buildUI()
	EntrancemailView.super.buildUI(self)

	self._title = goutil.findChildTextComponent(self.mainGO, "bg/title")
	self._subtitle = goutil.findChildTextComponent(self.mainGO, "bg/subtitle")
	self._content = goutil.findChildTextComponent(self.mainGO, "bg/content")
	self._signature = goutil.findChildTextComponent(self.mainGO, "bg/signature")
	self._continueBtn = self:getBtn("mask")
end

function EntrancemailView:bindEvents()
	EntrancemailView.super.bindEvents(self)
	self._continueBtn:AddClickListener(self._onClickContinue, self)
end

function EntrancemailView:unbindEvents()
	EntrancemailView.super.unbindEvents(self)
	self._continueBtn:RemoveClickListener()
end

function EntrancemailView:destroyUI()
	EntrancemailView.super.destroyUI(self)
end

function EntrancemailView:onEnter()
	EntrancemailView.super.onEnter(self)

	local sp = string.split(EntranceConfig.instance:getCommonValue("MAIL_OP"), "#")

	self._mailInfo = EntranceConfig.instance:getTextById(tonumber(sp[RoleModel.instance:getPlayerType()]))

	self:_updateContent(self._mailInfo)
end

function EntrancemailView:onEnterFinished()
	EntrancemailView.super.onEnterFinished(self)
end

function EntrancemailView:onExit()
	EntrancemailView.super.onExit(self)
end

function EntrancemailView:onExitFinished()
	EntrancemailView.super.onExitFinished(self)
end

function EntrancemailView:_onClickContinue()
	if self._mailInfo.next > 0 then
		self._mailInfo = EntranceConfig.instance:getTextById(self._mailInfo.next)

		self:_updateContent(self._mailInfo)
	else
		self:close()
		UIStateManager.instance:push(ViewName.EntranceAdmitCertificateView)
	end
end

function EntrancemailView:_updateContent(mailInfo)
	self._title.text = mailInfo.title
	self._subtitle.text = mailInfo.subtitle
	self._content.text = mailInfo.content
	self._signature.text = mailInfo.signature
end

return EntrancemailView
