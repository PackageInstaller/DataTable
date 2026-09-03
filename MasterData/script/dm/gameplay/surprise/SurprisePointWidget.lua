-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/surprise/SurprisePointWidget.lua

SurpriseTimesPointWidget = class("SurpriseTimesPointWidget", BaseWidget, _M)

SurpriseTimesPointWidget:has("_eventDispatcher", {
	is = "r"
}):injectWith("legs_sharedEventDispatcher")

function SurpriseTimesPointWidget:initialize(view)
	super.initialize(self, view)
end

function SurpriseTimesPointWidget:dispose()
	super.dispose(self)
end

function SurpriseTimesPointWidget:setupView(id)
	self._id = id
	self._surprisePointSystem = self:getInjector():getInstance(SurprisePointSystem)
	self._surprise = self._surprisePointSystem:getSurpriseById(id)

	if self._surprise then
		local curTimes = self._surprise:getCurTimes()
		local maxTimes = self._surprise:getMaxTimes()

		if curTimes < maxTimes then
			local view = self:getView()

			self._giftPanel = ccui.Layout:create()

			self._giftPanel:setContentSize(cc.size(50, 50))
			self._giftPanel:setCascadeOpacityEnabled(true)
			self._giftPanel:setTouchEnabled(true)
			self._giftPanel:addTouchEventListener(function(sender, eventType)
				self:onClickGift(sender, eventType)
			end)
			self._giftPanel:addTo(view):center(view:getContentSize())

			local icon = IconFactory:createPic({
				id = CurrencyIdKind.kDiamond
			}, {
				isWidget = true
			})

			icon:addTo(self._giftPanel):center(self._giftPanel:getContentSize())
			icon:setName("diamondIcon")
		end
	end
end

function SurpriseTimesPointWidget:updateView()
	local curTimes = self._surprise:getCurTimes()
	local maxTimes = self._surprise:getMaxTimes()

	if curTimes < maxTimes then
		self._giftPanel:setVisible(true)
	else
		self._giftPanel:setVisible(false)
	end
end

function SurpriseTimesPointWidget:onClickGift(sender, eventType)
	if eventType == ccui.TouchEventType.ended and self._surprise then
		local rewardAmount = self._surprise:getSurpriseGift().amount
		local icon = self._giftPanel:getChildByFullName("diamondIcon")

		if icon then
			self._surprisePointSystem:requestContinueReward(self._id, function()
				local label = icon:getChildByFullName("diamondCount")

				if not label then
					label = ccui.Text:create("+" .. rewardAmount, TTF_FONT_FZYH_M, 30)

					label:addTo(icon):posite(50, 50)
					label:setName("diamondCount")
					label:setColor(cc.c3b(255, 174, 18))
					label:enableOutline(cc.c4b(0, 0, 0, 127.5), 2)
					label:setCascadeOpacityEnabled(true)
				else
					label:setOpacity(255)
					label:setString("+" .. rewardAmount)
				end

				icon:runAction(cc.Sequence:create(cc.MoveBy:create(0.3, cc.p(0, 50)), cc.FadeOut:create(0.3), cc.MoveBy:create(0.1, cc.p(0, -50)), cc.CallFunc:create(function()
					icon:setOpacity(255)
					self:updateView()
				end)))
				label:runAction(cc.Sequence:create(cc.FadeOut:create(0.3)))
			end)
		end
	end
end
