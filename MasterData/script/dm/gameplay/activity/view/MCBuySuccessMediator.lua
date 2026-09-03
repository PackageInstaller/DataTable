-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/activity/view/MCBuySuccessMediator.lua

MCBuySuccessMediator = class("MCBuySuccessMediator", DmPopupViewMediator, _M)

local kBtnHandlers = {}

function MCBuySuccessMediator:initialize()
	super.initialize(self)
end

function MCBuySuccessMediator:dispose()
	super.dispose(self)
end

function MCBuySuccessMediator:mapEventListeners()
	return
end

function MCBuySuccessMediator:dispose()
	super.dispose(self)
end

function MCBuySuccessMediator:enterWithData(data)
	self._data = data.reward or {}
	self._diamondNum = 0

	self:initData()
	self:initView()
	self:updateViews()
	self:setupExtraReward()
end

function MCBuySuccessMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:mapEventListeners()

	local touchLayer = self:getView():getChildByName("touch_layer")

	touchLayer:addClickEventListener(function()
		self:onClickOk()
	end)
end

function MCBuySuccessMediator:initData()
	self._extraRewards = {}

	for k, v in pairs(self._data) do
		if v.code == "IR_Diamond" then
			self._diamondNum = self._diamondNum + v.amount
		elseif v.type ~= 21 then
			self._extraRewards[#self._extraRewards + 1] = v
		end
	end
end

function MCBuySuccessMediator:initView()
	local animNode = self:getView():getChildByFullName("main.animNode")

	animNode:setScale(1.2)

	local anim = cc.MovieClip:create("huodetishi_huodetishi")

	anim:addTo(animNode, 1)
	anim:addCallbackAtFrame(39, function()
		anim:stop()
	end)

	local cnText = anim:getChildByFullName("cnText")
	local enText = anim:getChildByFullName("enText")
	local title1 = cc.Label:createWithTTF(Strings:get("RewardTitle_Purchased"), CUSTOM_TTF_FONT_1, 50)

	title1:enableOutline(cc.c4b(0, 0, 0, 255), 1)
	title1:addTo(cnText):offset(0, -3)

	local title2 = cc.Label:createWithTTF(Strings:get("UITitle_EN_Goumaichenggong"), TTF_FONT_FZYH_M, 18)

	title2:setColor(cc.c3b(150, 160, 255))
	title2:addTo(enText)

	self._itemNode = self:getView():getChildByFullName("main.itemNode")

	self._itemNode:setScaleY(0)
	anim:addCallbackAtFrame(9, function()
		self._itemNode:runAction(cc.ScaleTo:create(0.2, 1))
	end)
end

function MCBuySuccessMediator:updateViews()
	local text_num = self._itemNode:getChildByFullName("Text_num")

	text_num:setString("+" .. self._diamondNum)
end

function MCBuySuccessMediator:setupExtraReward()
	if #self._extraRewards > 0 then
		for i, v in pairs(self._extraRewards) do
			local icon = IconFactory:createRewardIcon(v, {
				showAmount = false
			})

			icon:addTo(self._itemNode):posite(150 + (i - 1) * 170, 30)
			icon:setScale(0.75)

			local title1 = cc.Label:createWithTTF(RewardSystem:getName(v), TTF_FONT_FZYH_M, 18)

			title1:enableOutline(cc.c4b(0, 0, 0, 255), 1)
			title1:addTo(icon):center(icon:getContentSize()):offset(0, -85)
			title1:setAlignment(cc.TEXT_ALIGNMENT_CENTER, cc.TEXT_ALIGNMENT_CENTER)
			title1:setOverflow(cc.LabelOverflow.SHRINK)
			title1:setDimensions(140, 50)
			title1:setScale(1.3333333333333333)

			if v.code == "IM_MasterStage_Exp" then
				title1:offset(-20, 0)

				local text_num = self._itemNode:getChildByFullName("Text_num")
				local amountText = text_num:clone()

				amountText:setString("+" .. v.amount)
				amountText:addTo(icon)
				amountText:setPosition(title1:getPosition()):offset(52, 0)
				amountText:setScale(1.3333333333333333)
			end
		end

		self._itemNode:offset(-#self._extraRewards * 170 / 2)
		self._itemNode:getChildByName("Text_des"):offset(#self._extraRewards * 150 / 2)
	end
end

function MCBuySuccessMediator:onClickOk()
	self:close()
end
