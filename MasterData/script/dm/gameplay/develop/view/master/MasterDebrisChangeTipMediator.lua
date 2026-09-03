-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/master/MasterDebrisChangeTipMediator.lua

MasterDebrisChangeTipMediator = class("MasterDebrisChangeTipMediator", DmPopupViewMediator, _M)

MasterDebrisChangeTipMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local DebrisItemId = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Master_GeneralFragment", "content")
local kBtnHandlers = {
	["mainpanel.minusbtn"] = {
		ignoreClickAudio = true,
		eventType = 4,
		func = "onChangeClicked"
	},
	["mainpanel.addbtn"] = {
		ignoreClickAudio = true,
		eventType = 4,
		func = "onChangeClicked"
	},
	["mainpanel.maxbtn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onMaxClicked"
	}
}

function MasterDebrisChangeTipMediator:initialize()
	super.initialize(self)
end

function MasterDebrisChangeTipMediator:dispose()
	self._viewClose = true

	super.dispose(self)
end

function MasterDebrisChangeTipMediator:onRemove()
	super.onRemove(self)
end

function MasterDebrisChangeTipMediator:onRegister()
	super.onRegister(self)
	self:bindWidget("mainpanel.changeone", OneLevelViceButton, {
		handler = {
			ignoreClickAudio = true,
			func = bind1(self.onExchangeClicked, self)
		}
	})
	self.mapEventListener(self, self:getEventDispatcher(), EVT_MASTERDEBRISCHANGE_SUCC, self, self.refreshViewByDebrisChange)
	self:bindWidget("mainpanel.changeone", OneLevelViceButton, {
		handler = {
			ignoreClickAudio = true,
			func = bind1(self.onExchangeClicked, self)
		}
	})
end

function MasterDebrisChangeTipMediator:userInject()
	self._masterSystem = self._developSystem:getMasterSystem()
	self._bagSystem = self._developSystem:getBagSystem()
end

function MasterDebrisChangeTipMediator:enterWithData(masterid)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._masterId = masterid
	self._masterData = self._masterSystem:getShowMaster(masterid)
	self._masterItemId = self._masterData:getStarUpItemId()
	self._debrisItemNum = self._bagSystem:getItemCount(DebrisItemId)
	self._masterDebrisNum = self._bagSystem:getItemCount(self._masterItemId)
	self._curCount = self._debrisItemNum > 0 and 1 or 0

	self:createView()
	self:refreshView()
	self:bindBackBtnFlash(self._mainPanel, cc.p(760, 496))
end

function MasterDebrisChangeTipMediator:refreshViewByDebrisChange()
	self._debrisItemNum = self._bagSystem:getItemCount(DebrisItemId)

	local _, name = self._bagSystem:getColorByItemId(self._masterItemId)

	self:dispatch(ShowTipEvent({
		duration = 0.2,
		tip = "获得" .. name .. "*" .. self._curCount
	}))

	self._curCount = self._debrisItemNum > 0 and 1 or 0

	self:refreshView()
end

function MasterDebrisChangeTipMediator:createView()
	self._mainPanel = self:getView():getChildByFullName("mainpanel")
	self._progPanel = self._mainPanel:getChildByFullName("progpanel")
	self._progLabel = self._progPanel:getChildByFullName("prolabel")

	local bgNode = self._mainPanel:getChildByFullName("tipnode")

	bindWidget(self, bgNode, PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onBackClicked, self)
		},
		title = Strings:get("debris_UI1"),
		bgSize = {
			width = 700,
			height = 520
		}
	})
	self._mainPanel:getChildByFullName("text"):setString(Strings:get("Master_Starup_Need"))

	self._slider = self._progPanel:getChildByFullName("slider")

	self._slider:addEventListener(function(sender, eventType)
		if eventType == ccui.SliderEventType.percentChanged then
			if self._curCount == 0 then
				self._slider:setPercent(0)
			else
				local percent = self._slider:getPercent()

				if percent == 0 then
					self._curCount = 1
				else
					local count = math.ceil(percent / 100 * self._debrisItemNum)

					self._curCount = math.min(count, self._debrisItemNum)
				end

				self:refreshView()
				self:closeChangeScheduler()
			end
		end
	end)

	self._minusBtn = self._mainPanel:getChildByFullName("minusbtn")
	self._addBtn = self._mainPanel:getChildByFullName("addbtn")
end

function MasterDebrisChangeTipMediator:refreshView()
	self._debrisItemNum = self._bagSystem:getItemCount(DebrisItemId)
	self._masterDebrisPanel = self._mainPanel:getChildByFullName("debris1panel")

	self._masterDebrisPanel:removeAllChildren()

	self._masterItemIcon = self._bagSystem:createItemIcon(DebrisItemId)

	self._masterItemIcon:addTo(self._masterDebrisPanel):center(self._masterDebrisPanel:getContentSize())

	self._masterDebrisNum = self._bagSystem:getItemCount(self._masterItemId)

	local icon = IconFactory:createIcon({
		id = self._masterItemId,
		amount = self._masterDebrisNum
	}, {
		showAmount = true
	})

	self._heroDebrisPanel = self._mainPanel:getChildByFullName("debris2panel")

	self._heroDebrisPanel:removeAllChildren()
	icon:addTo(self._heroDebrisPanel):center(self._heroDebrisPanel:getContentSize())
	icon:setNotEngouhState(false)

	local endNum = self._masterData:getStarUpItemCostByStar()

	self._endNum = self._masterData:getStarUpItemCostByStar()
	endNum = endNum - self._masterDebrisNum < 0 and 0 or endNum - self._masterDebrisNum

	self._mainPanel:getChildByFullName("numLabel"):setString(RewardSystem:getName({
		id = self._masterItemId
	}) .. "*" .. endNum)

	local percentNum = self._curCount / self._debrisItemNum

	if self._masterData:getStar() >= 7 then
		self._slider:setPercent(0)
		self._progLabel:setString(tostring(self._curCount) .. "/" .. tostring(self._debrisItemNum))

		return
	end

	self._progLabel:setString(tostring(self._curCount) .. "/" .. tostring(self._debrisItemNum))
	self._slider:setPercent(percentNum * 100)
	self._minusBtn:setGray(self._curCount <= 1)
	self._addBtn:setGray(self._curCount >= self._debrisItemNum)
	self._mainPanel:getChildByFullName("changeone.button"):setGray(self._curCount <= 0)
end

function MasterDebrisChangeTipMediator:onBackClicked(sender, eventType)
	self:close()
end

function MasterDebrisChangeTipMediator:onExchangeClicked(sender, eventType)
	local debrisNum = self._bagSystem:getItemCount(DebrisItemId)
	local star = self._masterData:getStar()

	if star < 7 and self._masterDebrisNum == self._endNum then
		self:dispatch(ShowTipEvent({
			tip = Strings:get(30000004)
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	if debrisNum == 0 then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Tips_3010013")
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Confirm", false)
	self._bagSystem:requestMasterDebrisChange(self._masterId, self._curCount)
end

function MasterDebrisChangeTipMediator:onChangeClicked(sender, eventType)
	if eventType == ccui.TouchEventType.began then
		self._isAdd = sender == self._addBtn

		local canAdd = self:checkEngouh(true)

		if not canAdd then
			self:refreshView()

			return
		end

		self:createChangeScheduler()
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
	elseif eventType == ccui.TouchEventType.canceled or eventType == ccui.TouchEventType.ended then
		self:refreshView()
		self:closeChangeScheduler()
	end
end

function MasterDebrisChangeTipMediator:onMaxClicked(sender, eventType)
	if self._curCount == self._debrisItemNum and self._curCount == 0 then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Tips_3010013")
		}))

		return
	end

	self._curCount = self._debrisItemNum

	self:refreshView()
end

function MasterDebrisChangeTipMediator:update()
	local addNum = self._isAdd and 1 or -1

	self._curCount = self._curCount + addNum
	self._curCount = math.ceil(self._curCount)

	if self._curCount <= 1 then
		self._curCount = 1
	end

	if self._curCount >= self._debrisItemNum then
		self._curCount = self._debrisItemNum

		self:closeChangeScheduler()
	end

	self:refreshView()
end

function MasterDebrisChangeTipMediator:createChangeScheduler()
	self:closeChangeScheduler()

	if self._changeScheduler == nil then
		self._changeScheduler = LuaScheduler:getInstance():schedule(function()
			self:update()
		end, 0.1, true)
	end
end

function MasterDebrisChangeTipMediator:closeChangeScheduler()
	if self._changeScheduler then
		LuaScheduler:getInstance():unschedule(self._changeScheduler)

		self._changeScheduler = nil
	end
end

function MasterDebrisChangeTipMediator:checkEngouh(hasTip)
	if self._isAdd and self._curCount >= self._debrisItemNum then
		self._curCount = self._debrisItemNum

		self:closeChangeScheduler()

		return false
	elseif not self._isAdd and self._curCount <= 0 then
		self._curCount = 0

		self:closeChangeScheduler()

		return false
	end

	return true
end
