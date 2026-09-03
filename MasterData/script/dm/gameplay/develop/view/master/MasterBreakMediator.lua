-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/master/MasterBreakMediator.lua

MasterBreakMediator = class("MasterBreakMediator", DmAreaViewMediator, _M)

MasterBreakMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kBtnHandlers = {}

function MasterBreakMediator:initialize()
	super.initialize(self)
end

function MasterBreakMediator:dispose()
	super.dispose(self)
end

function MasterBreakMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._bagSystem = self._developSystem:getBagSystem()
	self._masterSystem = self._developSystem:getMasterSystem()

	self:bindWidget("mainpanel.skilllistpanel.levelBtn", OneLevelViceButton, {
		handler = {
			ignoreClickAudio = true,
			func = bind1(self.onClickSkillLevelUp, self)
		}
	})
	self.mapEventListener(self, self:getEventDispatcher(), EVT_MASTER_SYNC_UPDATE_BREAK, self, self.onBreakSucc)
end

function MasterBreakMediator:setupView(parentMedi, data)
	self._mediator = parentMedi

	self:initNodes()
	self:refreshData(data.id)
end

function MasterBreakMediator:initNodes()
	self._mainPanel = self:getView():getChildByFullName("mainpanel")
	self._skillListPanel = self._mainPanel:getChildByFullName("skilllistpanel")

	local text = self._skillListPanel:getChildByFullName("text")

	text:setContentSize(cc.size(99, 40))

	self._lockText = self._skillListPanel:getChildByFullName("unlockTips")

	local costBg = self._skillListPanel:getChildByFullName("costNode_1.costBg")
	local addImg = costBg:getChildByFullName("addImg")
	local touchPanel = addImg:getChildByFullName("touchPanel")

	touchPanel:setVisible(true)
	touchPanel:setTouchEnabled(true)
	touchPanel:addClickEventListener(function()
		self:onTouchItemClicked1()
	end)

	local costBg = self._skillListPanel:getChildByFullName("costNode_2.costBg")
	local addImg = costBg:getChildByFullName("addImg")
	local touchPanel = addImg:getChildByFullName("touchPanel")

	touchPanel:setVisible(true)
	touchPanel:setTouchEnabled(true)
	touchPanel:addClickEventListener(function()
		self:onTouchItemClicked2()
	end)
	self._skillListPanel:getChildByFullName("text"):enableOutline(cc.c4b(53, 43, 41, 219.29999999999998), 1)
	GameStyle:setCostNodeEffect(self._skillListPanel:getChildByFullName("costNode_1"))
	GameStyle:setCostNodeEffect(self._skillListPanel:getChildByFullName("costNode_2"))
end

function MasterBreakMediator:refreshView(masterId)
	self:refreshData(self._masterId)
	self:refreshInnerPointPanel()
	self:refreshCost()
end

function MasterBreakMediator:refreshData(masterId)
	self._masterId = masterId
	self._masterData = self._masterSystem:getMasterById(self._masterId)
	self._breakPointData = self._masterData:getBreakPointData()
	self._level = self._breakPointData:getBreakPointLevel()

	local text = self._skillListPanel:getChildByFullName("text")

	text:setString(Strings:get("LeadPower_UI1", {
		factor1 = self._level
	}))

	if self._level == 0 then
		text:setVisible(false)
	else
		text:setVisible(true)
	end

	local selectImg = self._skillListPanel:getChildByFullName("selectimg")

	selectImg:setVisible(false)

	self._condition = self._breakPointData:getShowCondition()

	if self._condition then
		self._lockText:setString(self._condition)
	else
		self._lockText:setString("")
	end
end

local innerAttributeMap = {
	[9] = {
		1,
		2,
		3,
		4,
		5,
		6,
		7,
		8,
		9
	}
}

function MasterBreakMediator:refreshInnerPointPanel()
	local innerAttr = self._breakPointData
	local map = innerAttr:getMap()
	local list = innerAttr:getList()
	local breakPointLevel = innerAttr:getBreakPointLevel()
	local currentBreakId = innerAttr:getBreakPointId()
	local scale = 1
	local config = ConfigReader:getRecordById("MasterPowerBreaking", currentBreakId)
	local canUnlockId
	local floor = breakPointLevel ~= 0 and breakPointLevel or 1
	local breakPointMap = innerAttr:getBreakPointMap()[floor]

	for i = 1, 9 do
		local breakPointId = breakPointMap[i]
		local config = ConfigReader:getRecordById("MasterPowerBreaking", breakPointId)
		local iconParent = self._skillListPanel:getChildByFullName("node_" .. i)

		iconParent:setBackGroundColorOpacity(0)

		local isVisible = i <= 9

		iconParent:setVisible(isVisible)

		if iconParent.lightIcon then
			iconParent.lightIcon:setVisible(false)
		end

		if isVisible then
			local innerAttribute = list[i]
			local attrType = innerAttribute:getConfig().AttrType[1]
			local lockState = innerAttribute:getLockState()
			local lock = innerAttribute:getLock()

			pathStr = "master_break_unlock.png"

			if lockState == 2 then
				pathStr = config.Icon .. ".png"
			elseif ((not innerAttr:isMaxLevel() or nil) and (breakPointLevel ~= 0 and config.NextQuality and config.NextQuality or "Master_PowerBreaking_1")) == breakPointMap[i] then
				pathStr = "master_break_unlock.png"

				if not iconParent.lightIcon then
					iconParent.lightIcon = ccui.ImageView:create("img_master_break_kexuan.png", 1)

					iconParent.lightIcon:addTo(iconParent, 1):center(iconParent:getContentSize()):offset(0, 0)
					iconParent.lightIcon:setRotation(-45)
					iconParent.lightIcon:setScale(scale)
				end

				iconParent.lightIcon:setVisible(true)
			end

			local path = pathStr
			local refreshTag = path

			if not iconParent.icon then
				iconParent.icon = ccui.ImageView:create(path, ccui.TextureResType.plistType)

				iconParent.icon:addTo(iconParent):center(iconParent:getContentSize())
				iconParent.icon:setRotation(-45)
				iconParent.icon:setScale(scale)
			elseif not iconParent.icon.refreshTag or iconParent.icon.refreshTag ~= refreshTag then
				iconParent.icon:loadTexture(path, 1)
			end

			iconParent.icon.refreshTag = refreshTag

			local attrStr = AttributeCategory:getAttName(attrType)
			local attrNum = innerAttribute:getConfig().Value[1][1]

			if AttributeCategory:isAttRateType(attrType) then
				attrNum = attrNum * 100 .. "%"
			end

			if not iconParent.nameLabel then
				iconParent.nameLabel = cc.Label:createWithTTF("", TTF_FONT_FZYH_M, 24)

				iconParent.nameLabel:setRotation(-45)
				iconParent.nameLabel:addTo(iconParent, 2):setPosition(24, 58)
				iconParent.nameLabel:enableOutline(cc.c4b(0, 0, 0, 255), 1)
			end

			iconParent.nameLabel:setString(attrStr)

			iconParent.nameLabel.refreshTag = attrStr .. attrType .. lockState

			if not iconParent.numLabel then
				iconParent.numLabel = cc.Label:createWithTTF("", TTF_FONT_FZYH_M, 18)

				iconParent.numLabel:setRotation(-45)
				iconParent.numLabel:addTo(iconParent, 2):setPosition(48, 35)
				iconParent.numLabel:enableOutline(cc.c4b(0, 0, 0, 255), 1)
			end

			iconParent.numLabel:setString("+" .. attrNum)

			local refreshTag = attrNum .. attrType .. lockState

			if iconParent.numLabel.refreshTag and iconParent.numLabel.refreshTag ~= refreshTag then
				-- block empty
			end

			iconParent.numLabel.refreshTag = refreshTag

			iconParent:setTouchEnabled(true)

			if not iconParent.hasHittingShape then
				self:setTabButtonHittingShape(iconParent.icon)

				iconParent.hasHittingShape = true
			end

			GameStyle:setBtnClickEffect(iconParent.icon, function()
				return self:refreshView()
			end, function()
				if lockState == 0 then
					self:dispatch(ShowTipEvent({
						tip = Strings:get("Strenghten_Text124")
					}))

					return
				elseif lockState == 2 then
					self:dispatch(ShowTipEvent({
						tip = Strings:get("已激活")
					}))

					return
				end

				return true
			end)
		end
	end
end

function MasterBreakMediator:setTabButtonHittingShape(widget)
	local vertices = {
		cc.p(37.5, 105),
		cc.p(95, 47.5),
		cc.p(152.5, 105),
		cc.p(95, 162.5)
	}
	local shape = ccui.HittingPolygon:create(vertices)

	widget:setHittingShape(shape)
end

function MasterBreakMediator:refreshCost()
	local costNode1 = self._skillListPanel:getChildByFullName("costNode_1")
	local costNode2 = self._skillListPanel:getChildByFullName("costNode_2")
	local levelBtn = self._skillListPanel:getChildByFullName("levelBtn")

	levelBtn:setVisible(false)
	costNode1:setVisible(false)
	costNode2:setVisible(false)

	local canup = not self._breakPointData:isMaxLevel()

	if canup then
		levelBtn:setVisible(true)
		costNode1:setVisible(true)
		costNode2:setVisible(true)

		self._costItem1 = {
			itemId = "",
			count = 0
		}

		local costItem = self._breakPointData:getCost1()
		local itemId, count = next(costItem)

		self._costItem1.count = count

		local hasNum, needNum

		hasNum = self._masterSystem:getMasterBreakUpItem().stiveNum
		self._itemEnough1 = count <= stiveNum

		local iconpanel = costNode1:getChildByFullName("costBg.iconpanel")

		iconpanel:removeAllChildren()

		local costIcon = ccui.ImageView:create("asset/items/IR_MasterStive.png"):setScale(0.3)

		costIcon:addTo(iconpanel):center(iconpanel:getContentSize())
		costIcon:setGray(not self._itemEnough1)

		local addImg = costNode1:getChildByFullName("costBg.addImg")

		addImg:setVisible(not self._itemEnough1)

		local enoughImg = costNode1:getChildByFullName("costBg.bg.enoughImg")
		local costPanel = costNode1:getChildByFullName("costBg.costPanel")

		costPanel:setVisible(true)

		local cost = costPanel:getChildByFullName("cost")
		local costLimit = costPanel:getChildByFullName("costLimit")

		cost:setString(hasNum)
		costLimit:setString("/" .. count)
		costLimit:setPositionX(cost:getContentSize().width)
		costPanel:setContentSize(cc.size(cost:getContentSize().width + costLimit:getContentSize().width + 15, 40))

		local colorNum1 = self._itemEnough1 and 1 or 7

		cost:setTextColor(GameStyle:getColor(colorNum1))
		costLimit:setTextColor(GameStyle:getColor(colorNum1))
		enoughImg:setVisible(self._itemEnough1)

		self._costItem2 = {
			itemId = "",
			hasNum = 0,
			count = 0
		}

		local costItem = self._breakPointData:getCost2()

		itemId, count = next(costItem)

		local hasNum = self._bagSystem:getItemCount(itemId)

		self._costItem2.itemId = itemId
		self._costItem2.count = count
		self._costItem2.hasNum = hasNum
		self._itemEnough2 = hasNum >= self._costItem2.count

		local iconpanel = costNode2:getChildByFullName("costBg.iconpanel")

		iconpanel:removeAllChildren()

		local costIcon = IconFactory:createPic({
			scaleRatio = 1.5,
			id = self._costItem2.itemId
		})

		costIcon:addTo(iconpanel)
		costIcon:setPosition(cc.p(iconpanel:getContentSize().width / 2, iconpanel:getContentSize().height / 2))
		costIcon:setGray(not self._itemEnough2)

		local addImg = costNode2:getChildByFullName("costBg.addImg")

		addImg:setVisible(not self._itemEnough2)

		local enoughImg = costNode2:getChildByFullName("costBg.bg.enoughImg")
		local costPanel = costNode2:getChildByFullName("costBg.costPanel")

		costPanel:setVisible(true)

		local cost = costPanel:getChildByFullName("cost")
		local costLimit = costPanel:getChildByFullName("costLimit")

		cost:setString(hasNum)
		costLimit:setString("/" .. self._costItem2.count)
		costLimit:setPositionX(cost:getContentSize().width)
		costPanel:setContentSize(cc.size(cost:getContentSize().width + costLimit:getContentSize().width + 15, 40))

		local colorNum1 = self._itemEnough2 and 1 or 7

		cost:setTextColor(GameStyle:getColor(colorNum1))
		costLimit:setTextColor(GameStyle:getColor(colorNum1))
		enoughImg:setVisible(self._itemEnough2)
	else
		levelBtn:setVisible(false)
		costNode1:setVisible(false)
		costNode2:setVisible(false)
	end
end

function MasterBreakMediator:onBreakSucc(event)
	local data = event:getData()

	if data.preData and data.preData.combat then
		local preCombat = data.preData.combat

		self._mediator:showCombatAnim(preCombat, cc.p(433, 208))
	end

	self:refreshView()
end

function MasterBreakMediator:refreshAllView()
	self:refreshView()
end

function MasterBreakMediator:onClickSkillLevelUp()
	local id = self._masterId

	if self._breakPointData:isMaxLevel() then
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = Strings:get("Error_10056")
		}))

		return
	end

	if not self._itemEnough1 then
		self:onTouchItemClicked1()

		return
	end

	if not self._itemEnough2 then
		self:onTouchItemClicked2()

		return
	end

	local combat, attrData = self._masterData:getCombat()
	local preData = {
		combat = combat
	}
	local items = self._masterSystem:getMasterBreakUpItem().items
	local params = {
		masterId = id,
		items = items
	}

	self._masterSystem:requestMasterBreakLevelUp(params, preData)
	AudioEngine:getInstance():playEffect("Se_Alert_Character_Levelup", false)
end

function MasterBreakMediator:onTouchItemClicked1()
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	local outSelf, delegate = self, {}

	function delegate:willClose(popupMediator, data)
		outSelf:refreshCost()
	end

	local debrisChangeTipView = self:getInjector():getInstance("MasterBreakLevelView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, debrisChangeTipView, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		masterId = self._masterId,
		needNum = self._costItem1.count,
		callback = function()
			self:refreshCost()
		end
	}, nil))
end

function MasterBreakMediator:onTouchItemClicked2()
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	local outSelf, delegate = self, {}

	function delegate:willClose(popupMediator, data)
		outSelf:refreshCost()
	end

	local param = {
		isNeed = true,
		hasWipeTip = true,
		itemId = self._costItem2.itemId,
		hasNum = self._costItem2.hasNum,
		needNum = self._costItem2.count
	}
	local view = self:getInjector():getInstance("sourceView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, param, delegate))
end

function MasterBreakMediator:runStartAction()
	self._mainPanel:stopAllActions()

	local action = cc.CSLoader:createTimeline("asset/ui/MasterBreaking.csb")

	self._mainPanel:runAction(action)
	action:clearFrameEventCallFunc()
	action:gotoFrameAndPlay(0, 32, false)
	action:setTimeSpeed(1.2)

	local costNode1 = self._skillListPanel:getChildByFullName("costNode_1")
	local costNode2 = self._skillListPanel:getChildByFullName("costNode_2")

	costNode1:setOpacity(0)
	costNode2:setOpacity(0)

	local function onFrameEvent(frame)
		if frame == nil then
			return
		end

		local str = frame:getEvent()

		if str == "CostAnim1" then
			costNode1:setOpacity(255)
			GameStyle:runCostAnim(costNode1)
		end

		if str == "CostAnim2" then
			costNode2:setOpacity(255)
			GameStyle:runCostAnim(costNode2)
		end
	end

	action:setFrameEventCallFunc(onFrameEvent)
end
