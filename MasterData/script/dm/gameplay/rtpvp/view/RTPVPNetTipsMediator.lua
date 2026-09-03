-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/rtpvp/view/RTPVPNetTipsMediator.lua

RTPVPNetTipsMediator = class("RTPVPNetTipsMediator", DmPopupViewMediator, _M)

RTPVPNetTipsMediator:has("_ladderMatchSystem", {
	is = "r"
}):injectWith("LadderMatchSystem")

function RTPVPNetTipsMediator:initialize()
	super.initialize(self)
end

function RTPVPNetTipsMediator:dispose()
	if self._select then
		local gameServerAgent = self:getInjector():getInstance(GameServerAgent)
		local customDataSystem = self:getInjector():getInstance(CustomDataSystem)
		local curTime = gameServerAgent:remoteTimestamp()

		customDataSystem:setValue(PrefixType.kGlobal, "Ladder_ShowNetTips_Time", curTime)
	end

	super.dispose(self)
end

function RTPVPNetTipsMediator:onRegister()
	super.onRegister(self)
	self:bindWidgets()

	self._main = self:getView():getChildByName("main")
end

function RTPVPNetTipsMediator:bindWidgets()
	self._okWidget = self:bindWidget("main.btn_ok", TwoLevelMainButton, {
		handler = bind1(self.onClickClose, self)
	})
end

function RTPVPNetTipsMediator:adjustLayout(targetFrame)
	super.adjustLayout(self, targetFrame)
end

function RTPVPNetTipsMediator:enterWithData(data)
	self._data = data
	self._season = self._ladderMatchSystem:getLadderSeason()

	local bgNode = self._main:getChildByName("bg_node")

	self:bindWidget(bgNode, PopupNormalWidget, {
		btnHandler = bind1(self.onClickClose, self),
		title = Strings:get("SPECIAL_STAGE_TEXT_16")
	})
	self:setupView()

	local netDelayText = ccui.Text:create(Strings:get("RTPvp_Delay_Text", {
		delay = self._data.netDelay
	}), DEFAULT_TTF_FONT, 30)

	netDelayText:setColor(cc.c3b(254, 6, 29))
	netDelayText:addTo(self._main, 10):posite(568, 435)
end

function RTPVPNetTipsMediator:setupView()
	local checkBtn = self._main:getChildByName("CheckBox")

	checkBtn:setSelected(self._ladderMatchSystem:isSelectShowNetTips())
	checkBtn:addEventListener(function(sender, eventType)
		self:onSelectNetTips(sender, eventType)
	end)
end

function RTPVPNetTipsMediator:onClickClose(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self:close()
	end
end

function RTPVPNetTipsMediator:onSelectNetTips(sender, eventType)
	self._select = sender:isSelected()
end

function RTPVPNetTipsMediator:onTouchMaskLayer()
	return
end
