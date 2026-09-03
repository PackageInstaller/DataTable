-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/master/MasterBuyAuraItemMediator.lua

MasterBuyAuraItemMediator = class("MasterBuyAuraItemMediator", DmPopupViewMediator, _M)

MasterBuyAuraItemMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kBtnHandlers = {
	["mainnode.minusbtn"] = {
		ignoreClickAudio = true,
		eventType = 4,
		func = "onChangeClicked"
	},
	["mainnode.addbtn"] = {
		ignoreClickAudio = true,
		eventType = 4,
		func = "onChangeClicked"
	},
	["mainnode.maxbtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onMaxClicked"
	},
	["mainnode.buybtn"] = {
		ignoreClickAudio = true,
		func = "onBuyClicked"
	}
}

function MasterBuyAuraItemMediator:initialize()
	super.initialize(self)
end

function MasterBuyAuraItemMediator:dispose()
	self._viewClose = true

	super.dispose(self)
end

function MasterBuyAuraItemMediator:onRemove()
	super.onRemove(self)
end

function MasterBuyAuraItemMediator:onRegister()
	super.onRegister(self)
end

function MasterBuyAuraItemMediator:enterWithData()
	self:mapButtonHandlersClick(kBtnHandlers)
	self:initData()
	self:initNodes()
	self:initView()
	self:refreshView()
	self:bindBackBtnFlash(self._mainPanel, cc.p(759, 514))
end

function MasterBuyAuraItemMediator:refreshViewByBuyEatItem()
	self:close()
end

function MasterBuyAuraItemMediator:initNodes()
	self._mainPanel = self:getView():getChildByFullName("mainnode")
	self._dimondsIcon = self._mainPanel:getChildByFullName("diamondimg")
	self._goldIcon = self._mainPanel:getChildByFullName("goldimg")

	self._goldIcon:setVisible(not self._dimondsIcon:isVisible())

	local bgNode = self._mainPanel:getChildByFullName("tipnode")

	bindWidget(self, bgNode, PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onBackClicked, self)
		},
		title = Strings:get("SHOP_Text_13"),
		bgSize = {
			width = 700,
			height = 520
		}
	})

	self._slider = self._mainPanel:getChildByFullName("slider")

	self._slider:addEventListener(function(sender, eventType)
		if eventType == ccui.SliderEventType.percentChanged then
			if self._curCount == 0 then
				self._slider:setPercent(0)
			else
				local percent = self._slider:getPercent()

				if percent == 0 then
					self._curCount = 1
				else
					local count = math.ceil(percent / 100 * self._maxNum)

					self._curCount = math.min(count, self._maxNum)
				end

				self:refreshView()
				self:closeChangeScheduler()
			end
		end
	end)
end

function MasterBuyAuraItemMediator:initData()
	self._bagSystem = self._developSystem:getBagSystem()
	self._masterSystem = self._developSystem:getMasterSystem()
	self._isAdd = true
	self._curCount = 1

	local config = ConfigReader:getRecordById("ConfigValue", "MasterAuraItemPrice").content

	self._onceCostNum = config.price
	self._maxNum = config.max
	self._costType = config.expense
	self._itemId = config.iteam
	self._itemConfig = self._bagSystem:getItemConfig(self._itemId)

	local canBuyNum = math.ceil(self._developSystem:getDiamonds() / self._onceCostNum)

	if canBuyNum < self._maxNum then
		self._maxNum = canBuyNum
	end

	if self._maxNum <= 1 then
		self._maxNum = 1
	end

	self._maxNum = math.ceil(self._maxNum)
end

function MasterBuyAuraItemMediator:initView()
	self._minusBtn = self._mainPanel:getChildByFullName("minusbtn")
	self._addBtn = self._mainPanel:getChildByFullName("addbtn")
	self._numLabel = self._mainPanel:getChildByFullName("countlabel")

	local iconPanel = self._mainPanel:getChildByFullName("iconpanel")
	local info = {
		id = self._itemId,
		amount = self._bagSystem:getItemCount(self._itemId),
		scaleRatio = IconFactory.ScaleRatio.itemScaleRatio
	}
	local icon = IconFactory:createItemIcon(info)

	icon:addTo(iconPanel):center(iconPanel:getContentSize())

	local nameLabel = self._mainPanel:getChildByFullName("namelabel")

	nameLabel:setString(Strings:get(self._itemConfig.Name))
	nameLabel:setTextColor(GameStyle:getColor(self._itemConfig.Quality))
	GameStyle:setQualityText(nameLabel, self._itemConfig.Quality)

	local desLabel = self._mainPanel:getChildByFullName("deslabel")

	desLabel:setString(Strings:get(self._itemConfig.Desc))
end

function MasterBuyAuraItemMediator:refreshView()
	if self._curCount <= 1 then
		self._curCount = 1
	end

	local costNumLabel = self._mainPanel:getChildByFullName("costnumlabel")
	local costDimond = self._onceCostNum * self._curCount
	local colorNum = costDimond <= self._developSystem:getDiamonds() and 1 or 6

	costNumLabel:setString(tostring(costDimond))
	costNumLabel:setTextColor(GameStyle:getColor(colorNum))
	self._numLabel:setString(tostring(self._curCount) .. "/" .. self._maxNum)
	self._slider:setPercent(self._curCount / self._maxNum * 100)
	self._minusBtn:setGray(self._curCount == 1)
	self._addBtn:setGray(self._curCount == self._maxNum)
	self._mainPanel:getChildByFullName("numLabel"):setString(Strings:get("HEROS_UI18", {
		num = self._bagSystem:getItemCount(self._itemId)
	}))
end

function MasterBuyAuraItemMediator:onBuyClicked()
	local costDimond = self._onceCostNum * self._curCount

	if costDimond > self._developSystem:getDiamonds() then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Tips_3010008")
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Confirm", false)

	local function callfun()
		self:refreshViewByBuyEatItem()
	end

	self._masterSystem:requestBuyAuraItem(self._curCount, callfun)
end

function MasterBuyAuraItemMediator:onBackClicked()
	self:close()
end

function MasterBuyAuraItemMediator:onChangeClicked(sender, eventType)
	if eventType == ccui.TouchEventType.began then
		self._isAdd = sender == self._addBtn

		local canAdd = self:checkEngouh(true)

		if not canAdd then
			self:refreshView()
			AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

			return
		end

		self:createChangeScheduler()
		AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)
	elseif eventType == ccui.TouchEventType.canceled or eventType == ccui.TouchEventType.ended then
		self:refreshView()
		self:closeChangeScheduler()
	end
end

function MasterBuyAuraItemMediator:onMaxClicked()
	if self._curCount == self._maxNum then
		return
	end

	self._curCount = self._maxNum

	self:refreshView()
end

function MasterBuyAuraItemMediator:checkEngouh(hasTip)
	if self._isAdd and self._curCount >= self._maxNum then
		self._curCount = self._maxNum

		self:closeChangeScheduler()

		return false
	elseif not self._isAdd and self._curCount <= 0 then
		self._curCount = 1

		self:closeChangeScheduler()

		return false
	end

	return true
end

function MasterBuyAuraItemMediator:checkCostDimond(hasTip)
	local costDimond = self._onceCostNum * self._curCount
	local hasCostTip = false

	if costDimond > self._developSystem:getDiamonds() and hasTip then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Tips_3010008")
		}))

		hasCostTip = true
	end

	return hasCostTip
end

function MasterBuyAuraItemMediator:update()
	local addNum = self._isAdd and 1 or -1

	self._curCount = self._curCount + addNum
	self._curCount = math.ceil(self._curCount)

	if self._curCount <= 1 then
		self._curCount = 1
	end

	if self._curCount >= self._maxNum then
		self._curCount = self._maxNum

		self:closeChangeScheduler()
	end

	self:refreshView()
end

function MasterBuyAuraItemMediator:createChangeScheduler()
	self:closeChangeScheduler()

	if self._changeScheduler == nil then
		self._changeScheduler = LuaScheduler:getInstance():schedule(function()
			self:update()
		end, 0.1, true)
	end
end

function MasterBuyAuraItemMediator:closeChangeScheduler()
	if self._changeScheduler then
		LuaScheduler:getInstance():unschedule(self._changeScheduler)

		self._changeScheduler = nil
	end
end
