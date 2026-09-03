-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/master/MasterStarMediator.lua

MasterStarMediator = class("MasterStarMediator", DmAreaViewMediator, _M)

MasterStarMediator:has("_shopSystem", {
	is = "r"
}):injectWith("ShopSystem")

local StarState = {
	1,
	2,
	3
}
local kBtnHandlers = {
	["main.starNode.costPanel.debrisbtn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onStarDebrisClicked"
	}
}

function MasterStarMediator:initialize()
	super.initialize(self)
end

function MasterStarMediator:dispose()
	super.dispose(self)
end

function MasterStarMediator:onRegister()
	super.onRegister(self)

	self._developSystem = self:getInjector():getInstance("DevelopSystem")
	self._masterSystem = self._developSystem:getMasterSystem()
	self._bagSystem = self._developSystem:getBagSystem()

	self:mapButtonHandlersClick(kBtnHandlers)
	self:bindWidget("main.starNode.costPanel.innerUpBtn", OneLevelViceButton, {
		handler = {
			ignoreClickAudio = true,
			func = bind1(self.onClickStarUpgrade, self)
		}
	})
	self.mapEventListener(self, self:getEventDispatcher(), EVT_MASTER_STARUP_SUCC, self, self.starUpSucc)
end

function MasterStarMediator:setupView(parentMedi, data)
	self._mediator = parentMedi

	self:refreshData(data.id)
	self:initNodes()
	self:refreshViewState()
	self:setupClickEnvs()
end

function MasterStarMediator:refreshData(masterId)
	self._masterId = masterId
	self._masterData = self._masterSystem:getMasterById(self._masterId)
end

function MasterStarMediator:initNodes()
	self._main = self:getView():getChildByFullName("main")
	self._mainPanel = self:getView():getChildByFullName("main.starNode")
	self._starPanel = self._mainPanel:getChildByFullName("staruppanel")
	self._descBg = self._starPanel:getChildByFullName("descBg")
	self._costPanel = self._mainPanel:getChildByFullName("costPanel")
	self._debrisBtn = self._costPanel:getChildByFullName("debrisbtn")
	self._title = self._mainPanel:getChildByFullName("text")

	self._debrisBtn:getChildByName("text"):setLocalZOrder(3)
	self._debrisBtn:getChildByName("particle"):setLocalZOrder(2)

	local anim = cc.MovieClip:create("wannengsuipian_wannengsuipian")

	anim:addTo(self._debrisBtn)
	anim:setLocalZOrder(1)
	anim:setPosition(cc.p(50, 46))

	local addImg = self._costPanel:getChildByFullName("costNode1.costBg.addImg")
	local touchPanel = addImg:getChildByFullName("touchPanel")

	touchPanel:setVisible(true)
	touchPanel:setTouchEnabled(true)
	touchPanel:addClickEventListener(function()
		self:onClickMasterPieces()
	end)

	local goldAddImg = self._costPanel:getChildByFullName("costNode2.costBg.addImg")
	local touchPanel = goldAddImg:getChildByFullName("touchPanel")

	touchPanel:setVisible(true)
	touchPanel:setTouchEnabled(true)
	touchPanel:addClickEventListener(function()
		CurrencySystem:buyCurrencyByType(self, CurrencyType.kCrystal)
	end)
	self._title:enableOutline(cc.c4b(53, 43, 41, 219.29999999999998), 1)
	self._descBg:getChildByFullName("des_1.text"):enableOutline(cc.c4b(68, 42, 25, 147.89999999999998), 2)
	self._descBg:getChildByFullName("des_2.text"):enableOutline(cc.c4b(68, 42, 25, 147.89999999999998), 2)
	GameStyle:setCostNodeEffect(self._costPanel:getChildByFullName("costNode1"))
	GameStyle:setCostNodeEffect(self._costPanel:getChildByFullName("costNode2"))
end

function MasterStarMediator:refreshStarPanel(showAnim)
	self:refreshStarNodes(showAnim)
end

function MasterStarMediator:refreshStarNodes(showAnim)
	local star = self._masterData:getStar()
	local starMax = self._masterData:getMaxStar()
	local isMaxStar = star == starMax

	for i = 1, starMax do
		local starBg = self._starPanel:getChildByFullName("starBg" .. i)

		if not starBg:getChildByName("StarAnim1") then
			local anim1 = cc.MovieClip:create("aa_yinghunshengxing")

			anim1:addTo(starBg)
			anim1:setName("StarAnim1")
			anim1:addEndCallback(function()
				anim1:gotoAndPlay(30)
			end)
			anim1:gotoAndPlay(1)
			anim1:setPosition(cc.p(34, 45))
		end

		if not starBg:getChildByName("StarAnim2") then
			local anim2 = cc.MovieClip:create("banx_yinghunshengxing")

			anim2:addTo(starBg)
			anim2:setName("StarAnim2")
			anim2:setPosition(cc.p(32, 32.5))
		end

		starBg:getChildByName("StarAnim1"):setVisible(false)
		starBg:getChildByName("StarAnim2"):setVisible(false)

		if i <= star then
			starBg:getChildByName("StarAnim1"):setVisible(true)
		end
	end

	self._descBg:setVisible(not isMaxStar)
	self._costPanel:setVisible(not isMaxStar)
	self._mainPanel:getChildByFullName("Image_starBg"):setVisible(not isMaxStar)
	self._mainPanel:getChildByFullName("Node_starLv"):setVisible(not isMaxStar)
	self._mainPanel:getChildByFullName("maxTip"):setVisible(isMaxStar)

	if not isMaxStar then
		self:refreshStarPointView()
		self:refreshStarUpCostPanel()
	end
end

function MasterStarMediator:refreshStarPointView()
	local starPointIds = self._masterData:getCurStarPoints()
	local starPointData = self._masterData:getCurStarPointConfig()
	local maxStarNum = self._masterData:getMaxStar()
	local node_starLv = self._mainPanel:getChildByFullName("Node_starLv")
	local pointDataNext

	for i = 1, maxStarNum do
		local node = node_starLv:getChildByFullName("Node_" .. i)

		if node then
			if not node:getChildByName("StarAnim1") then
				local sp = ccui.ImageView:create("asset/common/yinghun_xingxing.png")

				sp:addTo(node)
				sp:setName("StarAnim1")
				sp:setScale(0.88)
				sp:setRotation(4)
				sp:setPosition(cc.p(1, 2))
			end

			if not node:getChildByName("StarAnim2") then
				local anim2 = cc.MovieClip:create("banx_yinghunshengxing")

				anim2:addTo(node)
				anim2:setName("StarAnim2")
				anim2:setScale(0.8)
				anim2:rotate(5)
				anim2:setPosition(cc.p(1, 2))
			end

			node:getChildByName("StarAnim1"):setVisible(false)
			node:getChildByName("StarAnim2"):setVisible(false)

			if self._masterData:getStar() == self._masterData:getMaxStar() then
				node:getChildByName("StarAnim1"):setVisible(true)
			elseif starPointIds[i] then
				local pointId = starPointIds[i]
				local pointData = starPointData[pointId]

				if pointData:getState() == StarState[3] then
					node:getChildByName("StarAnim1"):setVisible(true)
				elseif pointData:getState() == StarState[2] then
					node:getChildByName("StarAnim2"):setVisible(true)

					pointDataNext = pointData
				end
			end
		end

		if i == maxStarNum and starPointIds[i] then
			local pointId = starPointIds[i]
			local pointData = starPointData[pointId]

			if pointData:getState() == StarState[2] then
				pointDataNext = pointData
			end
		end
	end

	if pointDataNext then
		self._descBg:setVisible(true)
		self._descBg:getChildByFullName("des_1"):setVisible(true)
		self._descBg:getChildByFullName("des_2"):setVisible(true)

		local att = pointDataNext:getAttrTypeArray()

		if type(att) == "table" then
			if #att == 1 then
				self._descBg:getChildByFullName("des_2"):setVisible(false)

				local att1 = att[1]
				local attNum = MasterAttribute:getAttrNumByType(att1, nil, self._masterData) or 0

				attNum = AttributeCategory:getAttNameAttend(att1) == "" and math.round(attNum) or string.format("%.1f%%", attNum * 100)

				if not AttrTypeImage[att1] then
					local attrImage = AttrTypeImage.SPEED

					self._descBg:getChildByFullName("des_1.image"):loadTexture(attrImage, ccui.TextureResType.plistType)
					self._descBg:getChildByFullName("des_1.text"):setString(attNum)
					self._descBg:getChildByFullName("des_1.extandText"):setString("+" .. pointDataNext:getShowValue())
				end
			else
				local att1 = att[1]
				local attNum1 = MasterAttribute:getAttrNumByType(att1, nil, self._masterData) or 0

				attNum1 = AttributeCategory:getAttNameAttend(att1) == "" and math.round(attNum1) or string.format("%.1f%%", attNum1 * 100)

				if not AttrTypeImage[att1] then
					local attrImage = AttrTypeImage.SPEED

					self._descBg:getChildByFullName("des_1.image"):loadTexture(attrImage, ccui.TextureResType.plistType)
					self._descBg:getChildByFullName("des_1.text"):setString(attNum1)
					self._descBg:getChildByFullName("des_1.extandText"):setString("+" .. pointDataNext:getShowValueByType(1))

					local att2 = att[2]
					local attNum2 = MasterAttribute:getAttrNumByType(att2, nil, self._masterData) or 0

					attNum2 = AttributeCategory:getAttNameAttend(att2) == "" and math.round(attNum2) or string.format("%.1f%%", attNum2 * 100)

					if not AttrTypeImage[att2] then
						local attrImage = AttrTypeImage.SPEED

						self._descBg:getChildByFullName("des_2.image"):loadTexture(attrImage, ccui.TextureResType.plistType)
						self._descBg:getChildByFullName("des_2.text"):setString(attNum2)
						self._descBg:getChildByFullName("des_2.extandText"):setString("+" .. pointDataNext:getShowValueByType(2))
					end
				end
			end
		end
	else
		self._descBg:setVisible(false)
	end
end

function MasterStarMediator:refreshStarUpCostPanel()
	local isMaxStar = self._masterData:getStar() == self._masterData:getMaxStar()

	if isMaxStar then
		return
	end

	local starItemId = self._masterData:getStarUpItemId()
	local hasNum = self._bagSystem:getItemCount(starItemId)
	local needNum = self._masterData:getStarUpItemCostByStar()

	self._debrisEnough = needNum <= hasNum

	local iconpanel = self._costPanel:getChildByFullName("costNode1.costBg.iconpanel")

	iconpanel:removeAllChildren()

	local icon = IconFactory:createIcon({
		id = self._masterData:getStarUpItemId()
	}, {
		showAmount = false
	})

	icon:setScale(0.46)
	icon:addTo(iconpanel):center(iconpanel:getContentSize())

	local colorNum1 = self._debrisEnough and 1 or 7
	local enoughImg = self._costPanel:getChildByFullName("costNode1.costBg.bg.enoughImg")

	enoughImg:setVisible(self._debrisEnough)

	local costPanel = self._costPanel:getChildByFullName("costNode1.costBg.costPanel")

	costPanel:setVisible(true)

	local cost = costPanel:getChildByFullName("cost")
	local costLimit = costPanel:getChildByFullName("costLimit")

	cost:setString(hasNum)
	costLimit:setString("/" .. needNum)
	costLimit:setPositionX(cost:getContentSize().width)
	costPanel:setContentSize(cc.size(cost:getContentSize().width + costLimit:getContentSize().width, 40))
	cost:setTextColor(GameStyle:getColor(colorNum1))
	costLimit:setTextColor(GameStyle:getColor(colorNum1))

	local addImg = self._costPanel:getChildByFullName("costNode1.costBg.addImg")

	addImg:setVisible(not self._debrisEnough)
	iconpanel:setGray(not self._debrisEnough)

	local costNum = self._masterData:getStarUpMoneyCostByStar()
	local scourcePanel = self._costPanel:getChildByFullName("costNode2.costBg")
	local iconpanel = scourcePanel:getChildByFullName("iconpanel")

	iconpanel:removeAllChildren()

	local icon = IconFactory:createResourcePic({
		scaleRatio = 0.7,
		id = CurrencyIdKind.kCrystal
	}, {
		largeIcon = true
	})

	icon:addTo(iconpanel):center(iconpanel:getContentSize())

	local addImg = scourcePanel:getChildByFullName("addImg")
	local iconpanel = scourcePanel:getChildByFullName("iconpanel")
	local enoughImg = scourcePanel:getChildByFullName("bg.enoughImg")
	local costNumLabel = scourcePanel:getChildByFullName("cost")

	costNumLabel:setVisible(true)
	costNumLabel:setString(costNum)

	self._costNum = costNum
	self._crystalEnough = costNum <= self._developSystem:getCrystal()

	enoughImg:setVisible(self._crystalEnough)
	addImg:setVisible(not self._crystalEnough)
	iconpanel:setGray(not self._crystalEnough)

	local colorNum = self._crystalEnough and 1 or 7

	costNumLabel:setTextColor(GameStyle:getColor(colorNum))
end

function MasterStarMediator:refreshView(heroId)
	self:refreshViewState()
end

function MasterStarMediator:refreshViewState(showAnim)
	local star = self._masterData:getStar()
	local starMax = self._masterData:getMaxStar()

	self._descBg:setVisible(star < starMax)
	self._costPanel:setVisible(star < starMax)
	self:refreshStarPanel(showAnim)
end

function MasterStarMediator:refreshAllView()
	self:refreshView()
end

function MasterStarMediator:starUpSucc(event)
	local data = event:getData()

	if data.preData and data.preData.combat then
		local preCombat = data.preData.combat

		self._mediator:showCombatAnim(preCombat, cc.p(481, 224))
	end
end

function MasterStarMediator:onClickStarUpgrade()
	local starItemId = self._masterData:getStarUpItemId()
	local number = self._bagSystem:getItemCount(starItemId)
	local maxnumber = self._masterData:getStarUpItemCostByStar()

	if not self._debrisEnough then
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		local param = {
			isNeed = true,
			itemId = self._masterData:getStarUpItemId(),
			hasNum = number,
			needNum = maxnumber
		}
		local view = self:getInjector():getInstance("sourceView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, param))

		return
	elseif not self._crystalEnough then
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
		CurrencySystem:buyCurrencyByType(self, CurrencyType.kCrystal)

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Star", false)

	local combat, attrData = self._masterData:getCombat()
	local preDatao = {
		star = self._masterData:getStar(),
		attack = attrData.attack,
		defense = attrData.defense,
		hp = attrData.hp,
		speed = self._masterData:getSpeed(),
		skills = self._masterData:getSkillList(),
		combat = combat
	}

	self._masterSystem:sendApplyMasterStarUp(self._masterData:getId(), preDatao, function(enablelist, data)
		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, self:getInjector():getInstance("MasterUpstarAniView"), {}, {
			preDatas = preDatao,
			data = data,
			enable = enablelist
		}, self))
	end)
end

function MasterStarMediator:onStarDebrisClicked()
	local debrisItemId = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Master_GeneralFragment", "content")
	local debrisItemNum = self._bagSystem:getItemCount(debrisItemId)

	if debrisItemNum == 0 then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Master_UniversalTips")
		}))

		return
	end

	if self._debrisEnough then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("HEROS_UI53")
		}))

		return
	end

	local view = self:getInjector():getInstance("MasterDebrisChangeTipView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, self._masterData:getId(), nil))
end

function MasterStarMediator:onClickMasterPieces(sender, eventType)
	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)

	local maxnumber = self._masterData:getStarUpItemCostByStar()
	local starItemId = self._masterData:getStarUpItemId()
	local number = self._bagSystem:getItemCount(starItemId)
	local param = {
		isNeed = true,
		hasWipeTip = true,
		itemId = starItemId,
		hasNum = number,
		needNum = maxnumber
	}
	local view = self:getInjector():getInstance("sourceView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, param))
end

function MasterStarMediator:runStartAction()
	self._main:stopAllActions()

	local action = cc.CSLoader:createTimeline("asset/ui/MasterStar.csb")

	self._main:runAction(action)
	action:clearFrameEventCallFunc()
	action:gotoFrameAndPlay(0, 30, false)
	action:setTimeSpeed(1.2)

	local star = self._masterData:getStar()
	local starMax = self._masterData:getMaxStar()

	for i = 1, starMax do
		local starBg = self._starPanel:getChildByFullName("starBg" .. i)

		starBg:getChildByName("StarAnim1"):setVisible(false)
		starBg:getChildByName("StarAnim2"):setVisible(false)
	end

	local bgAnim2 = self._descBg:getChildByFullName("bgAnim2")

	if not bgAnim2:getChildByFullName("BgAnim") then
		local anim = cc.MovieClip:create("fangxingkuang_jiemianchuxian")

		anim:addCallbackAtFrame(13, function()
			anim:stop()
		end)
		anim:addTo(bgAnim2)
		anim:setName("BgAnim")
	end

	bgAnim2:getChildByFullName("BgAnim"):gotoAndStop(1)

	local costNode1 = self._costPanel:getChildByFullName("costNode1")
	local costNode2 = self._costPanel:getChildByFullName("costNode2")

	costNode1:setOpacity(0)
	costNode2:setOpacity(0)

	local function onFrameEvent(frame)
		if frame == nil then
			return
		end

		local str = frame:getEvent()

		if str == "IconAnim1" then
			self:showStarAnim(star, 1)
		end

		if str == "IconAnim2" then
			self:showStarAnim(star, 2)
		end

		if str == "IconAnim3" then
			self:showStarAnim(star, 3)
		end

		if str == "IconAnim4" then
			self:showStarAnim(star, 4)
		end

		if str == "IconAnim5" then
			self:showStarAnim(star, 5)
		end

		if str == "IconAnim6" then
			self:showStarAnim(star, 6)
		end

		if str == "CostAnim1" then
			costNode1:setOpacity(255)
			GameStyle:runCostAnim(costNode1)
		end

		if str == "CostAnim2" then
			costNode2:setOpacity(255)
			GameStyle:runCostAnim(costNode2)
		end

		if str == "BgAnim2" then
			bgAnim2:getChildByFullName("BgAnim"):gotoAndPlay(1)
		end

		if str == "EndAnim" then
			-- block empty
		end
	end

	action:setFrameEventCallFunc(onFrameEvent)
end

function MasterStarMediator:showStarAnim(star, index)
	local starMax = self._masterData:getMaxStar()

	if starMax < index then
		return
	end

	local starBg = self._starPanel:getChildByFullName("starBg" .. index)

	if index <= star then
		starBg:getChildByName("StarAnim1"):setVisible(true)
		starBg:getChildByName("StarAnim1"):gotoAndPlay(1)
	end
end

function MasterStarMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local storyDirector = self:getInjector():getInstance(story.StoryDirector)
	local emblemBg = self._mainPanel:getChildByFullName("staruppanel.guide_star_bg")

	if emblemBg then
		storyDirector:setClickEnv("MasterStarMediator.guide_star_bg", emblemBg, function(sender, eventType)
			return
		end)
	end

	local embleminfo = self._mainPanel:getChildByFullName("guide_attr_bg")

	if embleminfo then
		storyDirector:setClickEnv("MasterStarMediator.guide_attr_bg", embleminfo, function(sender, eventType)
			return
		end)
	end

	local embleminfo = self._mainPanel:getChildByFullName("costPanel.innerUpBtn")

	if embleminfo then
		storyDirector:setClickEnv("MasterStarMediator.starUpBtn", embleminfo, function(sender, eventType)
			self:onClickStarUpgrade()

			local sequence = cc.Sequence:create(cc.CallFunc:create(function()
				storyDirector:notifyWaiting("click_MasterCultivateMediator_starUpBtn")
			end))

			self:getView():runAction(sequence)
		end)
	end

	local sequence = cc.Sequence:create(cc.CallFunc:create(function()
		storyDirector:notifyWaiting("enter_MasterStarMediator")
	end))

	self:getView():runAction(sequence)
end
