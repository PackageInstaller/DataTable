-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/equip/EquipStarMediator.lua

EquipStarMediator = class("EquipStarMediator", DmAreaViewMediator, _M)

local kBtnHandlers = {}

function EquipStarMediator:initialize()
	super.initialize(self)
end

function EquipStarMediator:dispose()
	super.dispose(self)
end

function EquipStarMediator:userInject()
	self._heroSystem = self:getInjector():getInstance(DevelopSystem):getHeroSystem()
	self._equipSystem = self:getInjector():getInstance(DevelopSystem):getEquipSystem()
	self._bagSystem = self:getInjector():getInstance(DevelopSystem):getBagSystem()
end

function EquipStarMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_EQUIP_STARUP_SUCC, self, self.onStarUpSuccCallback)

	self._main = self:getView():getChildByName("main")
	self._nodeDesc = self._main:getChildByFullName("nodeDesc")
	self._nodeAttr = self._main:getChildByName("nodeAttr")
	self._itemPanel = self._main:getChildByName("itemPanel")
	self._starUpBtn = self._itemPanel:getChildByName("starUpBtn")
	self._starUpMax = self._main:getChildByName("Image_max")

	self._starUpMax:setVisible(false)

	self._starUpWidget = self:bindWidget("main.itemPanel.starUpBtn", OneLevelViceButton, {
		handler = {
			ignoreClickAudio = true,
			func = bind1(self.onClickGrowUp, self)
		},
		btnSize = {
			width = 222,
			height = 108
		}
	})

	local animNode1 = self._nodeAttr:getChildByFullName("animNode")

	if not animNode1:getChildByFullName("BgAnim") then
		local anim = cc.MovieClip:create("fangxingkuang_jiemianchuxian")

		anim:addCallbackAtFrame(13, function()
			anim:stop()
		end)
		anim:addTo(animNode1)
		anim:setName("BgAnim")
		anim:offset(0, -3)
	end

	self._bgAnim1 = animNode1:getChildByFullName("BgAnim")

	local itemCost = self._itemPanel:getChildByFullName("itemCost")
	local panel = itemCost:getChildByFullName("costBg")
	local addImg = panel:getChildByFullName("addImg")

	addImg:getChildByFullName("touchPanel"):addClickEventListener(function()
		self:onClickItem()
	end)

	local equipCost = self._itemPanel:getChildByFullName("equipCost")
	local panel = equipCost:getChildByFullName("costBg")
	local addImg = panel:getChildByFullName("addImg")
	local touchPanel = addImg:getChildByFullName("touchPanel")

	touchPanel:setVisible(true)
	touchPanel:setTouchEnabled(true)
	touchPanel:addClickEventListener(function()
		self:onClickEquipItem()
	end)
	GameStyle:setCostNodeEffect(equipCost)
	GameStyle:setCostNodeEffect(itemCost)
end

function EquipStarMediator:setupView(data)
	self:initData(data)
end

function EquipStarMediator:initData(data)
	self._equipId = data.equipId
	self._mediator = data.mediator
	self._oldMaxLevel = 0
end

function EquipStarMediator:refreshData()
	self._equipData = self._equipSystem:getEquipById(self._equipId)
	self._starConsumeItem = self._equipSystem:getStarConsumeItem()
end

function EquipStarMediator:refreshView()
	self:refreshData()
	self:refreshEquipBaseInfo()
	self:refreshEquipInfo()
end

function EquipStarMediator:refreshEquipByClick()
	self:refreshData()
	self:refreshEquipInfo()
end

function EquipStarMediator:refreshEquipBaseInfo()
	local name = self._equipData:getName()
	local rarity = self._equipData:getRarity()
	local level = self._equipData:getLevel()
	local star = self._equipData:getStar()
	local levelMax = self._equipData:getMaxLevel()
	local node = self._nodeDesc:getChildByFullName("node")

	node:removeAllChildren()

	local param = {
		id = self._equipData:getEquipId(),
		level = level,
		star = star,
		rarity = rarity
	}
	local equipIcon = IconFactory:createEquipIcon(param, {
		hideStar = true
	})

	equipIcon:addTo(node):center(node:getContentSize())
	equipIcon:setScale(0.84)

	local nameLabel = self._nodeDesc:getChildByFullName("name")

	nameLabel:setString(name)

	local levelLabel = self._nodeDesc:getChildByFullName("level")

	levelLabel:setString(Strings:get("Strenghten_Text78", {
		level = level .. "/" .. levelMax
	}))
	levelLabel:setPositionX(nameLabel:getPositionX() + nameLabel:getContentSize().width + 20)

	local starNode = self._nodeDesc:getChildByFullName("starNode")

	self:createStarNode(starNode, star)
end

function EquipStarMediator:createStarNode(starNode, star)
	starNode:removeAllChildren()

	local index = 0
	local posXOffset

	for i = 1, 5 do
		if star - i >= 5 then
			index = index + 1

			local image = ccui.ImageView:create("asset/common/yinghun_img_star_color.png")

			image:addTo(starNode)
			image:setPosition(cc.p(13 + 35 * (index - 1), 19.5))
		elseif star - i >= 0 then
			posXOffset = posXOffset or index == 0 and 17 or 13
			index = index + 1

			local image = ccui.ImageView:create("img_yinghun_img_star_full.png", 1)

			image:addTo(starNode):setScale(0.625)
			image:setPosition(cc.p(posXOffset + 37 * (index - 1), 21.5))
		end
	end

	starNode:setContentSize(cc.size(36 * index, 43))
end

function EquipStarMediator:refreshEquipInfo()
	self:refreshItems()
	self:refreshStar()
end

function EquipStarMediator:refreshStar()
	local level = self._equipData:getLevel()
	local levelMax = self._equipData:getMaxLevel()
	local starPreData = self._equipData:getStarPreData()
	local previewNode = self._nodeDesc:getChildByFullName("previewNode")
	local desc1 = self._nodeAttr:getChildByFullName("desc_1")

	desc1:getChildByName("text"):setString(Strings:get("Equip_UI41", {
		level = level .. "/" .. levelMax
	}))

	local desc2 = self._nodeAttr:getChildByFullName("preDesc_1")

	if starPreData then
		previewNode:setVisible(true)
		desc2:setVisible(true)

		local starPre = starPreData.star
		local maxLevel = starPreData.maxLevel
		local text1 = desc2:getChildByName("text_1")

		text1:setString(maxLevel)

		local text2 = desc2:getChildByName("text_2")

		text2:setString(Strings:get("Equip_UI41", {
			level = level .. "/"
		}))
		text2:setPositionX(text1:getPositionX() - text1:getContentSize().width)

		local starNode = previewNode:getChildByFullName("starNode")

		self:createStarNode(starNode, starPre)
	else
		desc2:setVisible(false)
		previewNode:setVisible(false)
	end
end

function EquipStarMediator:refreshItems()
	if self._equipData:isMaxStar() then
		self._starUpMax:setVisible(true)
		self._itemPanel:setVisible(false)

		return
	end

	self._starUpMax:setVisible(false)
	self._itemPanel:setVisible(true)
	self:refreshItemCost()
	self:refreshEquipCost()
end

function EquipStarMediator:refreshItemCost()
	local itemData = self._equipData:getStarItem()[1]
	local itemCost = self._itemPanel:getChildByFullName("itemCost")
	local panel = itemCost:getChildByFullName("costBg")
	local iconpanel = panel:getChildByFullName("iconpanel")

	iconpanel:removeAllChildren()

	local icon = IconFactory:createPic({
		scaleRatio = 0.7,
		id = itemData.itemId
	}, {
		largeIcon = true
	})

	icon:addTo(iconpanel):center(iconpanel:getContentSize())

	local hasNum = CurrencySystem:getCurrencyCount(self, itemData.itemId)
	local needNum = itemData.amount

	self._goldEnough = needNum <= hasNum

	local colorNum1 = self._goldEnough and 1 or 7
	local enoughImg = panel:getChildByFullName("bg.enoughImg")

	enoughImg:setVisible(self._goldEnough)

	local costPanel = panel:getChildByFullName("costPanel")

	costPanel:setVisible(true)

	local cost = costPanel:getChildByFullName("cost")
	local costLimit = costPanel:getChildByFullName("costLimit")

	cost:setString(hasNum)
	costLimit:setString("/" .. needNum)
	costLimit:setPositionX(cost:getContentSize().width)
	costPanel:setContentSize(cc.size(cost:getContentSize().width + costLimit:getContentSize().width, 40))
	cost:setTextColor(GameStyle:getColor(colorNum1))
	costLimit:setTextColor(GameStyle:getColor(colorNum1))

	local addImg = panel:getChildByFullName("addImg")

	addImg:setVisible(not self._goldEnough)
	iconpanel:setGray(not self._goldEnough)
end

function EquipStarMediator:refreshEquipCost()
	local needNum = self._equipData:getEquipItemNum()

	if needNum > 0 then
		local equipCost = self._itemPanel:getChildByFullName("equipCost")
		local panel = equipCost:getChildByFullName("costBg")
		local iconpanel = panel:getChildByFullName("iconpanel")

		iconpanel:removeAllChildren()

		local hasNum = self._equipSystem:getEquipStarUpItem().stiveNum

		self._equipEnough = needNum <= hasNum

		local colorNum1 = self._equipEnough and 1 or 7
		local enoughImg = panel:getChildByFullName("bg.enoughImg")

		enoughImg:setVisible(self._equipEnough)

		local costPanel = panel:getChildByFullName("costPanel")

		costPanel:setVisible(true)

		local cost = costPanel:getChildByFullName("cost")
		local costLimit = costPanel:getChildByFullName("costLimit")

		cost:setString(hasNum)
		costLimit:setString("/" .. needNum)
		costLimit:setPositionX(cost:getContentSize().width)
		costPanel:setContentSize(cc.size(cost:getContentSize().width + costLimit:getContentSize().width, 40))
		cost:setTextColor(GameStyle:getColor(colorNum1))
		costLimit:setTextColor(GameStyle:getColor(colorNum1))

		local addImg = panel:getChildByFullName("addImg")

		addImg:setVisible(not self._equipEnough)
		iconpanel:setGray(not self._equipEnough)

		if not self._equipEnough then
			local rarity = self._equipData:getRarity()
			local param = {
				id = self._equipData:getEquipId(),
				rarity = rarity
			}
			local equipIcon = IconFactory:createEquipIcon(param, {
				hideStar = true,
				hideLevel = true
			})

			equipIcon:addTo(iconpanel):center(iconpanel:getContentSize())
			equipIcon:setScale(0.65)
		else
			local id = next(self._equipSystem:getEquipStarUpItem().items)

			if id then
				local info = {
					id = id
				}
				local icon = IconFactory:createIcon(info, {
					showAmount = false
				})

				icon:addTo(iconpanel):center(iconpanel:getContentSize())
				icon:setScale(0.65)
			else
				id = next(self._equipSystem:getEquipStarUpItem().equips)

				if id then
					local baseId = self._equipSystem:getEquipStarUpItem().equips[id].baseId
					local rarity = self._equipData:getRarity()
					local param = {
						id = baseId,
						rarity = rarity
					}
					local equipIcon = IconFactory:createEquipIcon(param, {
						hideStar = true,
						hideLevel = true
					})

					equipIcon:addTo(iconpanel):center(iconpanel:getContentSize())
					equipIcon:setScale(0.65)
				end
			end
		end

		equipCost:setVisible(needNum > 0)

		return
	end

	needNum = self._equipData:getEquipStarExp()

	if needNum > 0 then
		local equipCost = self._itemPanel:getChildByFullName("equipCost")
		local panel = equipCost:getChildByFullName("costBg")
		local iconpanel = panel:getChildByFullName("iconpanel")

		iconpanel:removeAllChildren()

		local debrisIcon = ccui.ImageView:create("yinghun_img_weapon_icon.png", 1)

		debrisIcon:addTo(iconpanel):center(iconpanel:getContentSize())

		local hasNum = self._equipSystem:getEquipStarUpItem().stiveNum

		self._equipEnough = needNum <= hasNum

		local colorNum1 = self._equipEnough and 1 or 7
		local enoughImg = panel:getChildByFullName("bg.enoughImg")

		enoughImg:setVisible(self._equipEnough)

		local costPanel = panel:getChildByFullName("costPanel")

		costPanel:setVisible(true)

		local cost = costPanel:getChildByFullName("cost")
		local costLimit = costPanel:getChildByFullName("costLimit")

		cost:setString(hasNum)
		costLimit:setString("/" .. needNum)
		costLimit:setPositionX(cost:getContentSize().width)
		costPanel:setContentSize(cc.size(cost:getContentSize().width + costLimit:getContentSize().width, 40))
		cost:setTextColor(GameStyle:getColor(colorNum1))
		costLimit:setTextColor(GameStyle:getColor(colorNum1))

		local addImg = panel:getChildByFullName("addImg")

		addImg:setVisible(not self._equipEnough)
		iconpanel:setGray(not self._equipEnough)
		equipCost:setVisible(needNum > 0)

		return
	end

	assert(false, "装备突破配置错误 HeroEquipStar-id=" .. self._equipData:getStarId())
end

function EquipStarMediator:onClickGrowUp(sender, eventType)
	if self._equipData:isMaxStar() then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Equip_UI62_1")
		}))

		return
	end

	local level = self._equipData:getLevel()
	local levelMax = self._equipData:getMaxLevel()

	if level < levelMax then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Equip_UI42")
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	if not self._goldEnough then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Equip_UI80")
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	if not self._equipEnough then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Equip_UI32")
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	self._oldMaxLevel = levelMax
	self._oldAttrList = self._equipData:getAttrListShow()

	local items = {}

	for id, value in pairs(self._equipSystem:getEquipStarUpItem().items) do
		items[id] = value.eatCount
	end

	local equips = {}

	for id, value in pairs(self._equipSystem:getEquipStarUpItem().equips) do
		table.insert(equips, id)
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	local param = {
		equipId = self._equipId,
		consumeList = equips,
		items = items
	}

	self._equipSystem:requestEquipStarUp(param)
end

function EquipStarMediator:onClickEquipItem()
	local needNum = self._equipData:getEquipItemNum()

	if needNum ~= 0 then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

		local view = self:getInjector():getInstance("EquipStarBreakView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, {
			equipId = self._equipId,
			needNum = needNum,
			callback = function()
				self:refreshEquipCost()
			end
		}, nil))

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	local view = self:getInjector():getInstance("EquipStarLevelView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		equipId = self._equipId,
		needNum = self._equipData:getEquipStarExp(),
		callback = function()
			self:refreshEquipCost()
		end
	}, nil))
end

function EquipStarMediator:onClickItem()
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	local itemData = self._equipData:getStarItem()[1]
	local hasCount = CurrencySystem:getCurrencyCount(self, itemData.itemId)
	local param = {
		itemId = itemData.itemId,
		hasNum = hasCount,
		needNum = itemData.amount
	}
	local view = self:getInjector():getInstance("sourceView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, param))
end

function EquipStarMediator:onStarUpSuccCallback(event)
	local view = self:getInjector():getInstance("EquipStarUpView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		maskOpacity = 0
	}, {
		equipId = self._equipId,
		oldMaxLevel = self._oldMaxLevel,
		oldAttrList = self._oldAttrList
	}))
end

function EquipStarMediator:runStartAction()
	self:showInfoAni()
	self._main:stopAllActions()

	local action = cc.CSLoader:createTimeline("asset/ui/EquipStar.csb")

	self._main:runAction(action)
	action:clearFrameEventCallFunc()
	action:gotoFrameAndPlay(0, 64, false)
	action:setTimeSpeed(2)

	local equipCost = self._itemPanel:getChildByFullName("equipCost")
	local itemCost = self._itemPanel:getChildByFullName("itemCost")

	equipCost:setOpacity(0)
	itemCost:setOpacity(0)

	local function onFrameEvent(frame)
		if frame == nil then
			return
		end

		local str = frame:getEvent()

		if str == "CostAnim1" then
			-- block empty
		end

		if str == "CostAnim2" then
			equipCost:setOpacity(255)
			itemCost:setOpacity(255)
			GameStyle:runCostAnim(equipCost)
			GameStyle:runCostAnim(itemCost)
		end
	end

	action:setFrameEventCallFunc(onFrameEvent)
end

function EquipStarMediator:showInfoAni()
	self._bgAnim1:gotoAndPlay(1)
	self._starUpBtn:stopAllActions()
	self._starUpBtn:setScale(1)
	self._starUpBtn:setOpacity(255)

	local node = self._nodeDesc:getChildByFullName("node")

	node:setScale(1)
	node:setOpacity(255)
	node:stopAllActions()
	self._equipSystem:runIconShowAction(node, 1)
	self._equipSystem:runIconShowAction(self._starUpBtn, 4)

	local pancel1 = self._nodeAttr:getChildByFullName("Image_125")

	pancel1:setOpacity(0)
	pancel1:setScaleX(0.4)
	pancel1:runAction(cc.FadeIn:create(0.3))
	pancel1:runAction(cc.Sequence:create({
		cc.ScaleTo:create(0.2, 1.05, 1),
		cc.ScaleTo:create(0.1, 1, 1)
	}))

	local attrPanel = self._nodeAttr:getChildByFullName("desc_1")

	if attrPanel:isVisible() then
		attrPanel:setOpacity(0)
		attrPanel:runAction(cc.Sequence:create({
			cc.DelayTime:create(0.3),
			cc.FadeIn:create(0.15)
		}))

		local attrText = attrPanel:getChildByFullName("text")

		attrText:setOpacity(0)
		attrText:runAction(cc.Sequence:create({
			cc.DelayTime:create(0.4),
			cc.FadeIn:create(0.15)
		}))
	end

	local attrPanel = self._nodeAttr:getChildByFullName("preDesc_1")

	if attrPanel:isVisible() then
		attrPanel:setOpacity(0)
		attrPanel:runAction(cc.Sequence:create({
			cc.DelayTime:create(0.3),
			cc.FadeIn:create(0.15)
		}))

		local attrText = attrPanel:getChildByFullName("text_1")

		attrText:setOpacity(0)
		attrText:runAction(cc.Sequence:create({
			cc.DelayTime:create(0.4),
			cc.FadeIn:create(0.15)
		}))

		local attrText = attrPanel:getChildByFullName("text_2")

		attrText:setOpacity(0)
		attrText:runAction(cc.Sequence:create({
			cc.DelayTime:create(0.4),
			cc.FadeIn:create(0.15)
		}))
	end
end
