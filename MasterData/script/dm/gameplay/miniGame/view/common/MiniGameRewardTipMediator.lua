-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/miniGame/view/common/MiniGameRewardTipMediator.lua

MiniGameRewardTipMediator = class("MiniGameRewardTipMediator", DmPopupViewMediator, _M)

MiniGameRewardTipMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
MiniGameRewardTipMediator:has("_gameServer", {
	is = "r"
}):injectWith("GameServerAgent")
MiniGameRewardTipMediator:has("_miniGameSystem", {
	is = "r"
}):injectWith("MiniGameSystem")

local kBtnHandlers = {}

function MiniGameRewardTipMediator:initialize()
	super.initialize(self)
end

function MiniGameRewardTipMediator:dispose()
	super.dispose(self)
end

function MiniGameRewardTipMediator:userInject()
	return
end

function MiniGameRewardTipMediator:onRegister()
	super.onRegister(self)
end

function MiniGameRewardTipMediator:bindWidgets()
	return
end

function MiniGameRewardTipMediator:adjustLayout(targetFrame)
	super.adjustLayout(self, targetFrame)
end

function MiniGameRewardTipMediator:enterWithData(data)
	self._data = data

	self:mapButtonHandlers(kBtnHandlers)
	self:initData()
	self:initNodes()
	self:refreshView(data)
end

function MiniGameRewardTipMediator:initData()
	return
end

function MiniGameRewardTipMediator:initNodes()
	self._mainPanel = self:getView():getChildByFullName("main")

	local bgNode = self:getView():getChildByFullName("main.bgNode")

	self:bindWidget(bgNode, PopupNormalWidget, {
		btnHandler = bind1(self.onCloseClicked, self),
		title = Strings:get("BattleValue_UI08")
	})
	self._mainPanel:getChildByName("desclabel"):setVisible(false)
end

function MiniGameRewardTipMediator:refreshView(data)
	local dailyRewards = self._data.reward
	local node = self:createRewardPanel(dailyRewards)

	node:addTo(self._mainPanel):posite(400, 354)

	local itemLimit = self._data.rewardLimit
	local node = self:createRewardPanel(itemLimit)

	node:addTo(self._mainPanel):posite(400, 270)
end

function MiniGameRewardTipMediator:createRewardPanel(rewards)
	local node = cc.Node:create()
	local posX = 0

	for k, v in pairs(rewards) do
		local icon = IconFactory:createSimplePic({
			id = v.id
		}, {
			autoScaleWidth = 40
		})

		icon:setAnchorPoint(0, 0)
		icon:addTo(node):posite(posX, -40)

		posX = posX + 90

		local label = cc.Label:createWithTTF(v.num, DEFAULT_TTF_FONT, 20)

		label:setAnchorPoint(0, 0)
		label:enableOutline(cc.c4b(0, 0, 0, 255), 2)
		label:setColor(cc.c3b(255, 171, 55))
		label:addTo(node):posite(posX, 0)

		posX = posX + label:getContentSize().width
	end

	return node
end

function MiniGameRewardTipMediator:onCloseClicked(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self:close()
	end
end
