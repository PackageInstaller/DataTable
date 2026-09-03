-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/club/view/ClubMemberInfoTipMediator.lua

ClubMemberInfoTipMediator = class("ClubMemberInfoTipMediator", DmPopupViewMediator, _M)

ClubMemberInfoTipMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ClubMemberInfoTipMediator:has("_clubSystem", {
	is = "r"
}):injectWith("ClubSystem")

local kBtnHandlers = {}

function ClubMemberInfoTipMediator:initialize()
	super.initialize(self)
end

function ClubMemberInfoTipMediator:dispose()
	super.dispose(self)
end

function ClubMemberInfoTipMediator:userInject()
	return
end

function ClubMemberInfoTipMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	local bgNode = self:getView():getChildByFullName("main.bg")
	local widget = self:bindWidget(bgNode, PopupNormalWidget, {
		bg = "bg_popup_dark.png",
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onCloseClicked, self)
		},
		title = Strings:get("Club_Text142"),
		bgSize = {
			width = 726,
			height = 497
		}
	})
end

function ClubMemberInfoTipMediator:enterWithData(data)
	self._data = data
	self._mainPanel = self:getView():getChildByFullName("main")

	local iconPanel = self._mainPanel:getChildByFullName("iconpanel")

	iconPanel:removeAllChildren()

	local icon = IconFactory:createPlayerIcon({
		clipType = 4,
		frameStyle = 1,
		id = data:getHeadId(),
		headFrameId = data:getHeadFrame()
	})

	icon:addTo(iconPanel):center(iconPanel:getContentSize())
	icon:setScale(0.9)

	local titleLabel = self._mainPanel:getChildByFullName("Text_3")

	titleLabel:enableOutline(cc.c4b(77, 45, 21, 255), 2)
	titleLabel:setLineSpacing(-8)

	local nameLabel = self._mainPanel:getChildByFullName("namelabel")

	nameLabel:setString(data:getName())

	local vipNode = self._mainPanel:getChildByFullName("vipnode")

	self._playerVipWidget = self:getInjector():injectInto(PlayerVipWidgetExtend:new(vipNode))

	self._playerVipWidget:updateView(data:getVip())

	local levelText = self._mainPanel:getChildByName("Text_level")

	levelText:setString(self._data:getLevel())

	local combat = data:getCombat()
	local combatLabel = self._mainPanel:getChildByFullName("combatimg.numlabel")

	combatLabel:setString(combat)

	local heroParent = self._mainPanel:getChildByFullName("onbattlenode")
	local heros = data:getHeroes()

	for i, hero in pairs(heros) do
		local heroPro = PrototypeFactory:getInstance():getHeroPrototype(hero[1])
		local icon = IconFactory:createHeroIcon({
			id = hero[1],
			modelId = heroPro:getModelId(),
			level = tonumber(hero[2]),
			star = tonumber(hero[3]),
			quality = tonumber(hero[4])
		})

		icon:setScale(0.7)
		heroParent:addChild(icon, 5)
		icon:setPosition(cc.p(40 + (i - 1) * 78, 35))
	end

	local manifestoLabel = self._mainPanel:getChildByFullName("desclabel")

	manifestoLabel:setString(data:getSlogan())
end

function ClubMemberInfoTipMediator:onCloseClicked(sender, eventType)
	self:close()
end
