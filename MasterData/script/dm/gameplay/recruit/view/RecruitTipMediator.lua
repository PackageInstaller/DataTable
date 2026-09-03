-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/recruit/view/RecruitTipMediator.lua

RecruitTipMediator = class("RecruitTipMediator", DmPopupViewMediator, _M)

RecruitTipMediator:has("_recruitSystem", {
	is = "r"
}):injectWith("RecruitSystem")

local kBtnHandlers = {}

function RecruitTipMediator:initialize()
	super.initialize(self)
end

function RecruitTipMediator:dispose()
	super.dispose(self)
end

function RecruitTipMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._main = self:getView():getChildByName("main")
	self._bg = self._main:getChildByName("bg")
	self._titleNode = self._main:getChildByName("titleNode")
	self._panel = self._main:getChildByName("panel")
end

function RecruitTipMediator:enterWithData(data)
	self._panel:removeAllChildren()

	local infos = data.info
	local posY = 0
	local length = 0

	for i = 1, #infos do
		local info = infos[#infos + 1 - i]
		local title = Strings:get(info[1])
		local desc = Strings:get(info[2], {
			fontName = TTF_FONT_FZYH_M
		})
		local label = ccui.RichText:createWithXML(desc, {})

		label:addTo(self._panel)
		label:renderContent(482, 0)
		label:setAnchorPoint(cc.p(0, 0))
		label:setPosition(cc.p(0, posY))

		length = label:getContentSize().height
		posY = posY + length + 4

		local titleLabel = cc.Label:createWithTTF(title, TTF_FONT_FZYH_M, 20)

		titleLabel:setAnchorPoint(cc.p(0, 0))
		titleLabel:setPosition(cc.p(0, posY))
		titleLabel:addTo(self._panel)

		length = titleLabel:getContentSize().height + 15
		posY = posY + length
	end

	local height = posY - 15

	self._panel:setContentSize(cc.size(474, height))
	self._bg:setContentSize(cc.size(534, height + 82))
	self._titleNode:setPositionY(self._panel:getPositionY() + height / 2)
end
