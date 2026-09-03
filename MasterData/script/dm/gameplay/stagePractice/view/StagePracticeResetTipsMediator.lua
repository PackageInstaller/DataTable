-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/stagePractice/view/StagePracticeResetTipsMediator.lua

StagePracticeResetTipsMediator = class("StagePracticeResetTipsMediator", DmPopupViewMediator, _M)

local kBtnHandlers = {}

function StagePracticeResetTipsMediator:initialize()
	super.initialize(self)
end

function StagePracticeResetTipsMediator:dispose()
	super.dispose(self)
end

function StagePracticeResetTipsMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._ensureBtnWidget = self:bindWidget("bg.button_ensure", TwoLevelMainButton, {
		handler = bind1(self.onClickEnsure, self)
	})
	self._cancleBtnWidget = self:bindWidget("bg.button_cancle", TwoLevelViceButton, {
		handler = bind1(self.onClickBack, self)
	})
end

function StagePracticeResetTipsMediator:enterWithData(data)
	local bgNode = self:getView():getChildByFullName("bg.bgNode")
	local widget = self:bindWidget(bgNode, PopupNormalWidget, {
		bg = "bg_popup_dark.png",
		btnHandler = bind1(self.onClickBack, self),
		title = Strings:get("Tower_Text48"),
		bgSize = {
			width = 544,
			height = 384
		}
	})
	local tipLabel = self:getView():getChildByFullName("bg.cost_text")
	local amount = data.cost.amount
	local costNode = self:getView():getChildByFullName("bg.costnode")
	local width = costNode:getChildByFullName("content_text"):getContentSize().width
	local icon = costNode:getChildByFullName("icon")
	local costIcon = IconFactory:createPic({
		id = data.cost.id
	})

	costIcon:setScale(0.8)
	costIcon:addTo(icon):center(icon:getContentSize()):offset(-2, -2)

	width = width + costIcon:getContentSize().width

	local cost = costNode:getChildByFullName("cost_text")

	cost:setString(amount)

	width = width + cost:getContentSize().width

	costNode:setPositionX(548 - width / 2)
	costNode:setVisible(amount > 0)
	tipLabel:setVisible(amount == 0)
end

function StagePracticeResetTipsMediator:onClickEnsure(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self:close({
			response = AlertResponse.kOK
		})
	end
end

function StagePracticeResetTipsMediator:onClickBack(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		self:close({
			response = AlertResponse.kCancel
		})
	end
end

function StagePracticeResetTipsMediator:onTouchMaskLayer()
	self:close({
		response = AlertResponse.kCancel
	})
end
