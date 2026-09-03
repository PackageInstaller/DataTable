-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/RechargeTipMediator.lua

RechargeTipMediator = class("RechargeTipMediator", DmPopupViewMediator, _M)

local kBtnHandlers = {}

function RechargeTipMediator:initialize()
	super.initialize(self)
end

function RechargeTipMediator:dispose()
	super.dispose(self)
end

function RechargeTipMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._main = self:getView():getChildByName("main")
	self._bg = self._main:getChildByName("bg")
	self._titleNode = self._main:getChildByName("titleNode")
	self._panel = self._main:getChildByName("panel")
end

function RechargeTipMediator:enterWithData(data)
	self._panel:removeAllChildren()

	local infos = data.info
	local posY = 0

	for i = 1, #infos do
		local info = infos[#infos + 1 - i]
		local desc = Strings:get(info, {
			fontName = TTF_FONT_FZYH_M,
			time = TimeUtil:getSystemResetDate()
		})
		local label = ccui.RichText:createWithXML(desc, {})

		label:addTo(self._panel)
		label:renderContent(482, 0)
		label:setAnchorPoint(cc.p(0, 0))
		label:setPosition(cc.p(0, posY))

		posY = posY + label:getContentSize().height + 4
	end

	local height = posY - 15

	self._panel:setContentSize(cc.size(474, height))
	self._bg:setContentSize(cc.size(534, height + 82))
	self._titleNode:setPositionY(self._panel:getPositionY() + height / 2)
end
