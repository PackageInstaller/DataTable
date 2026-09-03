-- chunkname: @/tmp/or_script/lua_compile/dm/launch/login/view/ServerAnnounceMediator.lua

ServerAnnounceMediator = class("ServerAnnounceMediator", DmPopupViewMediator, _M)

ServerAnnounceMediator:has("_loginSystem", {
	is = "r"
}):injectWith("LoginSystem")

local kBtnHandlers = {}

function ServerAnnounceMediator:initialize()
	super.initialize(self)
end

function ServerAnnounceMediator:dispose()
	super.dispose(self)
end

function ServerAnnounceMediator:onRemove()
	super.onRemove(self)
end

function ServerAnnounceMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._main = self:getView():getChildByName("main")
	self._listView = self._main:getChildByName("ListView")

	self._listView:setScrollBarEnabled(false)

	self._bgWidget = bindWidget(self, "main.bg_node", PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onClickClose, self)
		},
		title = Strings:get("LOGIN_UI1"),
		title1 = Strings:get("Game_Announce"),
		bgSize = {
			width = 963,
			height = 487
		}
	})
end

function ServerAnnounceMediator:enterWithData()
	self:setupView()
end

function ServerAnnounceMediator:setupView()
	local announce = self._loginSystem:getAnnounce()
	local textData = string.split(announce, "<font")
	local kWidth = self._listView:getContentSize().width
	local layout = ccui.Widget:create()

	layout:setAnchorPoint(cc.p(0, 0))

	if (#textData <= 1 or nil) and false then
		local t = TextTemplate:new(announce)
		local params = {
			fontName = TTF_FONT_FZYH_R
		}

		announce = t:stringify(params)

		local contentText = ccui.RichText:createWithXML(announce, {})

		contentText:setAnchorPoint(cc.p(0, 1))
		contentText:renderContent(kWidth, 0)

		local size = contentText:getContentSize()
		local height = size.height

		contentText:addTo(layout):posite(0, height)
		layout:setContentSize(cc.size(kWidth, height))
		self._listView:pushBackCustomItem(layout)
	else
		local contentText = cc.Label:createWithTTF(announce, TTF_FONT_FZYH_M, 16)

		contentText:setColor(cc.c3b(255, 255, 255))
		contentText:enableOutline(cc.c4b(0, 0, 0, 219.29999999999998), 1)
		contentText:setAnchorPoint(cc.p(0, 1))
		contentText:setDimensions(kWidth, 0)

		local size = contentText:getContentSize()

		contentText:addTo(layout):posite(0, size.height)
		layout:setContentSize(cc.size(kWidth, size.height))
		self._listView:pushBackCustomItem(layout)
	end
end

function ServerAnnounceMediator:onClickClose(sender, eventType)
	self:close()
end
