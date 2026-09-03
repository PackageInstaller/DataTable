-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/mail/view/MailTipsMediator.lua

MailTipsMediator = class("MailTipsMediator", DmPopupViewMediator, _M)

MailTipsMediator:has("_mailSystem", {
	is = "r"
}):injectWith("MailSystem")

local kBtnHandlers = {
	["bg.button_mail"] = "onClickMail",
	["bg.backpanel.mainpanel.backbtn"] = "onClickBack"
}

function MailTipsMediator:initialize()
	super.initialize(self)
end

function MailTipsMediator:dispose()
	super.dispose(self)
end

function MailTipsMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function MailTipsMediator:enterWithData(data)
	self:setupView(data)
end

function MailTipsMediator:setupView(data)
	local mailNum = data.unReadMails
	local content = self:getView():getChildByFullName("bg.content")

	content:setString(Strings:get("MAIL_NOTICE_TIPS", {
		num = mailNum
	}))
end

function MailTipsMediator:onClickMail(sender, eventType)
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
	self:close()

	local function getDataSucc()
		local view = self:getInjector():getInstance("MailView")
		local event = ViewEvent:new(EVT_SHOW_POPUP, view, {}, {}, nil)

		self:dispatch(event)
	end

	self._mailSystem:requestGetMailList(true, getDataSucc)
end

function MailTipsMediator:onClickBack(sender, eventType)
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
	self:close()
end
