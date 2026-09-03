-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/herostrength/HeroStrengthAwakenMediator.lua

HeroStrengthAwakenMediator = class("HeroStrengthAwakenMediator", DmAreaViewMediator, _M)

HeroStrengthAwakenMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kBtnHandlers = {
	["mainpanel.infoPanel.button"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onAwakenDetailClicked"
	},
	["mainpanel.infoPanel.boxPanel.button"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickBox"
	},
	["mainpanel.awakenBtn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickAwakenBtn"
	},
	["mainpanel.reviewBtn"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickAwakenReplaceBtn"
	},
	["mainpanel.costPanel.btn_translate"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onTranslateClicked"
	}
}
local kHeroRarityAnim = {
	[15] = {
		35
	},
	[14] = {
		35
	},
	[13] = {
		10
	},
	[12] = {
		0
	},
	[11] = {
		0
	}
}
local kBgAnimAndImage = {
	[GalleryPartyType.kBSNCT] = "asset/ui/gallery/party_icon_businiao.png",
	[GalleryPartyType.kXD] = "asset/ui/gallery/party_icon_xide.png",
	[GalleryPartyType.kMNJH] = "asset/ui/gallery/party_icon_monv.png",
	[GalleryPartyType.kDWH] = "asset/ui/gallery/party_icon_dongwenhui.png",
	[GalleryPartyType.kWNSXJ] = "asset/ui/gallery/party_icon_weinasi.png",
	[GalleryPartyType.kSSZS] = "asset/ui/gallery/party_icon_she.png",
	[GalleryPartyType.kUNKNOWN] = "asset/ui/gallery/party_icon_unknown.png"
}
local Hero_GeneralFragmentLimit = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Hero_GeneralFragmentLimit", "content")
local AWAKEN_STAR_ICON = "jx_img_star.png"

function HeroStrengthAwakenMediator:initialize()
	super.initialize(self)
end

function HeroStrengthAwakenMediator:dispose()
	self._heroSystem:cleanAwakeHeroFragIdAndDebrisCostCount()
	super.dispose(self)
end

function HeroStrengthAwakenMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_HEROAWAKEN_SUCC, self, self.awakenSuccess)
end

function HeroStrengthAwakenMediator:initNodes()
	self._main = self:getView():getChildByFullName("mainpanel")
	self._nodeAnim = self._main:getChildByFullName("animNode")
	self._infoPanel = self._main:getChildByFullName("infoPanel")
	self._infoNode = self._main:getChildByFullName("infoPanel.infoNode")
	self._starNode = self._main:getChildByFullName("infoPanel.starBg")
	self._ssrNode = self._main:getChildByFullName("infoPanel.infoNode.rarityIcon")
	self._nameNode = self._main:getChildByFullName("infoPanel.infoNode.nameLabel")
	self._occNode = self._main:getChildByFullName("infoPanel.infoNode.occupation")
	self._diNode = self._main:getChildByFullName("infoPanel.infoNode.nameBg")
	self._awakeBtn = self._main:getChildByFullName("awakenBtn")
	self._awakeReplaceBtn = self._main:getChildByFullName("reviewBtn")
	self._awakeBtnAnimNode = self._main:getChildByFullName("awakenBtn.anim")
	self._awakeBtnBG = self._main:getChildByFullName("awakenBtn.BG")
	self._awakedescNode1 = self._main:getChildByFullName("Node_66.Text_95")
	self._awakedescNode2 = self._main:getChildByFullName("Node_66.Text_94")
	self._awakedescNode3 = self._main:getChildByFullName("Node_66.Text_93")
	self._awakedescNodeDi1 = self._main:getChildByFullName("Node_66.BG1")
	self._awakedescNodeDi2 = self._main:getChildByFullName("Node_66.BG2")
	self._awakedescNodeDi3 = self._main:getChildByFullName("Node_66.BG3")
	self._awakeRoleNode = self._main:getChildByFullName("heropanel")
	self._awakeAreaRoleNode = self._main:getChildByFullName("infoPanel.Role")
	self._costPanel = self._main:getChildByFullName("costPanel")
	self._combat = self._main:getChildByFullName("infoPanel.combatNode.combat")
	self._combatDi = self._main:getChildByFullName("infoPanel.combatNode.Image_90")
	self._seekBtn = self._main:getChildByFullName("infoPanel.button")
	self._boxBtn = self._main:getChildByFullName("infoPanel.boxPanel.button")
	self._boxBg = self._main:getChildByFullName("infoPanel.boxPanel.BG")
	self._itemDi = self._main:getChildByFullName("costPanel.Bg2")
	self._topinfo_node = self:getView():getChildByFullName("topinfo_node")

	self._topinfo_node:setVisible(false)

	self._translteBtn = self._costPanel:getChildByFullName("btn_translate")
end

function HeroStrengthAwakenMediator:enterWithData(data)
	self:setupView(nil, data)

	if data and data.fromAlbum then
		self._fromAlbum = data.fromAlbum or false
	end

	self._heroId = data and data.heroId

	if self._heroId ~= nil and self._fromAlbum then
		self._heroSystem = self._developSystem:getHeroSystem()
		self._heroData = self._heroSystem:getHeroById(self._heroId)

		if self._heroData then
			self._heroAwakeFinished = self._heroData:heroAwaked()

			self._heroSystem:resetHeroStarUpItem()
			self._heroSystem:cleanAwakeHeroFragIdAndDebrisCostCount()
		end

		self._topinfo_node:setVisible(true)
		self:setupTopInfoWidget()
		self:refreshViewWithHeroId()
		self:runStartAction()
	end
end

function HeroStrengthAwakenMediator:setupView(parent, data)
	self._baseView = parent
	self._fromAlbum = false
	self._heroAwakeAvail = true
	self._heroAwakeFinished = false
	self._animRunning = false

	self:initNodes()
	self:resetView()
end

function HeroStrengthAwakenMediator:resetView()
	self._starNode:setOpacity(0)
	self._occNode:setPositionY(237)
	self._combatDi:setPositionX(-15)
	self._boxBg:setPositionX(-20)
	self._awakedescNode1:setPositionX(-23)
	self._awakedescNode2:setPositionX(-70)
	self._awakedescNode3:setPositionX(-150)
	self._awakedescNodeDi1:setPositionX(6)
	self._awakedescNodeDi2:setPositionX(30)
	self._awakedescNodeDi3:setPositionX(55)
end

function HeroStrengthAwakenMediator:runStartAction()
	if self._animRunning then
		return
	end

	self._animRunning = true

	self._nodeAnim:removeAllChildren()

	local animAwaken = cc.MovieClip:create("juexingzhuanchang_juexingrukou")

	animAwaken:addTo(self._nodeAnim)
	animAwaken:gotoAndPlay(0)

	local starNode = animAwaken:getChildByFullName("star_base.star")
	local ssrNode = animAwaken:getChildByFullName("ssr_base.ssr")
	local ziNode = animAwaken:getChildByFullName("name.zi")
	local tuNode = animAwaken:getChildByFullName("name.tu")
	local diNode = animAwaken:getChildByFullName("name.di")
	local zhanli = animAwaken:getChildByFullName("zhanli.num")
	local zhanlidi = animAwaken:getChildByFullName("zhanli.di")
	local seekBtn = animAwaken:getChildByFullName("seek.btn")
	local boxBtn = animAwaken:getChildByFullName("box.btn")
	local boxBg = animAwaken:getChildByFullName("box.di")
	local jxNode = animAwaken:getChildByFullName("juexing.jx")
	local dyjNode = animAwaken:getChildByFullName("desc.dyj")
	local dejNode = animAwaken:getChildByFullName("desc.dej")
	local dsjNode = animAwaken:getChildByFullName("desc.dsj")
	local dyjDiNode = animAwaken:getChildByFullName("desc.dyjdi")
	local dejDiNode = animAwaken:getChildByFullName("desc.dejdi")
	local dsjDiNode = animAwaken:getChildByFullName("desc.dsjdi")
	local nodeToActionMap = {}

	nodeToActionMap[self._starNode] = starNode
	nodeToActionMap[self._ssrNode] = ssrNode
	nodeToActionMap[self._nameNode] = ziNode
	nodeToActionMap[self._occNode] = tuNode
	nodeToActionMap[self._diNode] = diNode
	nodeToActionMap[self._combat] = zhanli
	nodeToActionMap[self._combatDi] = zhanlidi
	nodeToActionMap[self._seekBtn] = seekBtn
	nodeToActionMap[self._boxBtn] = boxBtn
	nodeToActionMap[self._boxBg] = boxBg
	nodeToActionMap[self._awakeBtnAnimNode] = jxNode
	nodeToActionMap[self._awakedescNode1] = dyjNode
	nodeToActionMap[self._awakedescNode2] = dejNode
	nodeToActionMap[self._awakedescNode3] = dsjNode
	nodeToActionMap[self._awakedescNodeDi1] = dyjDiNode
	nodeToActionMap[self._awakedescNodeDi2] = dejDiNode
	nodeToActionMap[self._awakedescNodeDi3] = dsjDiNode
	nodeToActionMap[self._awakeRoleNode] = animAwaken:getChildByFullName("role.role1")
	nodeToActionMap[self._itemDi] = animAwaken:getChildByFullName("item.di")

	local startFunc, stopFunc = CommonUtils.bindNodeToActionNode(nodeToActionMap, self._nodeAnim)

	startFunc()

	local childs = animAwaken:getChildren()

	for i = 1, #childs do
		if childs[i] then
			childs[i]:addEndCallback(function()
				childs[i]:stop()
			end)
		end
	end

	animAwaken:getChildByFullName("role"):addCallbackAtFrame(30, function(cid, mc)
		self._animRunning = false

		stopFunc()
	end)
	self._main:stopAllActions()

	local action = cc.CSLoader:createTimeline("asset/ui/StrengthenAwaken.csb")

	self._main:runAction(action)
	action:clearFrameEventCallFunc()
	action:gotoFrameAndPlay(0, 30, false)
	action:setTimeSpeed(1.2)

	local costNode0 = self._costPanel:getChildByFullName("costNode1")
	local costNode1 = self._costPanel:getChildByFullName("costNode2")
	local costNode2 = self._costPanel:getChildByFullName("costNode3")

	local function onFrameEvent(frame)
		if frame == nil then
			return
		end

		local str = frame:getEvent()

		if str == "CostAnim1" then
			GameStyle:runCostAnim(costNode0:getChildByFullName("costBg"))
		end

		if str == "CostAnim2" then
			GameStyle:runCostAnim(costNode1:getChildByFullName("costBg"))
		end

		if str == "CostAnim3" then
			GameStyle:runCostAnim(costNode2:getChildByFullName("costBg"))
		end
	end

	action:setFrameEventCallFunc(onFrameEvent)
	self._awakeReplaceBtn:setOpacity(0)
	self._awakeReplaceBtn:runAction(cc.Sequence:create(cc.DelayTime:create(0.5), cc.FadeIn:create(0.3)))
end

function HeroStrengthAwakenMediator:refreshData(heroId)
	self._heroId = heroId
	self._heroSystem = self._developSystem:getHeroSystem()
	self._heroData = self._heroSystem:getHeroById(self._heroId)
	self._heroAwakeFinished = self._heroData:heroAwaked()

	self._heroSystem:resetHeroStarUpItem()
	self._heroSystem:cleanAwakeHeroFragIdAndDebrisCostCount()
end

function HeroStrengthAwakenMediator:refreshAllView(hideAnim)
	self:refreshInfoNode()
	self:refreshAwakeBtn()
	self:refreshAwakeRole()
	self:refreshStarUpCostPanel()
end

function HeroStrengthAwakenMediator:refreshViewWithHeroId()
	self._infoNode:setVisible(false)
	self._infoPanel:getChildByFullName("combatNode"):setVisible(false)
	self._infoPanel:getChildByFullName("boxPanel"):setVisible(false)
	self._seekBtn:setVisible(false)
	self._starNode:setVisible(false)
	self._awakeBtn:setVisible(false)
	self._awakeReplaceBtn:setVisible(false)
	self._costPanel:setVisible(false)
	self._awakedescNode1:setPositionX(150)
	self._awakedescNodeDi1:setPositionX(180)

	local awakenStarConfig = ConfigReader:getRecordById("HeroAwaken", self._heroId)

	self._awakedescNode2:setString(Strings:get(awakenStarConfig.Name))
	self._awakedescNode3:setString(Strings:get(awakenStarConfig.NameDesc))
	self:refreshAwakeRoleWithHeroId()
	self._main:getChildByFullName("infoPanel.BG"):setVisible(true)
end

function HeroStrengthAwakenMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")
	local config = {
		style = 1,
		currencyInfo = {},
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		}
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function HeroStrengthAwakenMediator:refreshInfoNode()
	local nameBg = self._infoNode:getChildByFullName("nameBg.nameBg")
	local name = self._infoNode:getChildByFullName("nameLabel.nameLabel")
	local nameString = self._heroData:getName()
	local qualityLevel = self._heroData:getQualityLevel() == 0 and "" or "+" .. self._heroData:getQualityLevel()

	name:setString(nameString .. qualityLevel)
	GameStyle:setHeroNameByQuality(name, self._heroData:getQuality(), 1)
	nameBg:setScaleX((name:getContentSize().width + 90) / nameBg:getContentSize().width)

	local occupationName, occupationImg = GameStyle:getHeroOccupation(self._heroData:getType())
	local occupation = self._infoNode:getChildByFullName("occupation.occupation")

	occupation:loadTexture(occupationImg)

	local rarityIcon = self._infoNode:getChildByFullName("rarityIcon.rarityIcon")

	rarityIcon:removeAllChildren()

	local rarity = IconFactory:getHeroRarityAnim(self._heroData:getRarity())

	rarity:addTo(rarityIcon):offset(kHeroRarityAnim[self._heroData:getRarity()][1], 30)

	local partyType = self._infoNode:getChildByFullName("partyType.partyType")

	if kBgAnimAndImage[self._heroData:getParty()] then
		partyType:setVisible(true)
		partyType:loadTexture(kBgAnimAndImage[self._heroData:getParty()])
	else
		partyType:setVisible(false)
	end

	for i = 1, HeroStarCountMax do
		local node = self._starNode:getChildByFullName("star_" .. i)

		if not node:getChildByName("star") and i <= self._heroData:getStar() then
			local star = ccui.ImageView:create(AWAKEN_STAR_ICON, 1)

			star:ignoreContentAdaptWithSize(true)
			star:setName("star")
			star:addTo(node)
			star:setScale(0.4)
		end
	end

	local combatNode = self._infoPanel:getChildByFullName("combatNode.combat")
	local label = combatNode:getChildByFullName("CombatLabel")

	if not label then
		local fntFile = "asset/font/heroLevel_font.fnt"

		label = ccui.TextBMFont:create("", fntFile)

		label:addTo(combatNode)
		label:setName("CombatLabel")
	end

	local combat = self._heroData:getSceneCombatByType(SceneCombatsType.kAll)

	label:setString(combat)
	self._awakedescNode2:setString(Strings:get(self._heroData:getAwakenStarConfig().Name))
	self._awakedescNode3:setString(Strings:get(self._heroData:getAwakenStarConfig().NameDesc))

	local hasStarBoxReward = self._heroData:getHasStarBoxReward()

	self._infoPanel:getChildByFullName("boxPanel.button.red"):setVisible(hasStarBoxReward)

	local hasAnim = self._heroData:hasAwakenAnimation()

	self._awakeReplaceBtn:setVisible(self._heroAwakeFinished and hasAnim)
end

function HeroStrengthAwakenMediator:refreshAwakeBtn()
	self._awakeBtn:setVisible(not self._heroAwakeFinished)

	if not self._heroAwakeFinished then
		self._awakeBtnAnimNode:removeAllChildren()

		if self._heroAwakeAvail then
			local animAwaken = cc.MovieClip:create("juexingrukou_juexingrukou")

			animAwaken:addTo(self._awakeBtnAnimNode):offset(-320, 137)
			animAwaken:gotoAndPlay(0)
		end

		self._awakeBtnBG:setVisible(not self._heroAwakeAvail)
	end
end

function HeroStrengthAwakenMediator:refreshAwakeRole()
	if self._heroAwakeFinished then
		local var_18_0 = self._heroData:getAwakenStarConfig().ModelId

		if not var_18_0 then
			var_18_0 = self._heroData:getAwakenStarConfig().Portrait

			local roleModel = var_18_0
			local masterIcon = IconFactory:createRoleIconSpriteNew({
				frameId = "bustframe9",
				id = roleModel,
				useAnim = self._heroAwakeFinished
			})

			self._awakeRoleNode:removeAllChildren()

			local posY = self._heroAwakeFinished and 0 or -100

			masterIcon:addTo(self._awakeRoleNode):setPosition(0, posY)
			self._main:getChildByFullName("infoPanel.BG"):setVisible(self._heroAwakeFinished)
			self._awakeAreaRoleNode:removeAllChildren()
			self._awakeRoleNode:setPositionY(320)

			if self._heroAwakeFinished or self._fromAlbum then
				if self._heroAwakeFinished then
					self._awakeRoleNode:setPositionY(180)
				end

				local heroId = self._heroData:getAwakenStarConfig().ShowHero
				local model = IconFactory:getRoleModelByKey("HeroBase", heroId)

				if not model or model == "" then
					return
				end

				model = ConfigReader:getDataByNameIdAndKey("RoleModel", model, "Model")

				local role = RoleFactory:createRoleAnimation(model)

				self._roleSpine = role

				role:setName("RoleAnim")
				role:addTo(self._awakeAreaRoleNode):setScale(0.7):posite(80, 0)
				role:registerSpineEventHandler(handler(self, self.spineCompleteHandler), sp.EventType.ANIMATION_COMPLETE)
				self._awakeAreaRoleNode:setTouchEnabled(true)
				self._awakeAreaRoleNode:addTouchEventListener(function(sender, eventType)
					if eventType == ccui.TouchEventType.ended then
						local names = {
							"skill1",
							"skill2",
							"skill3"
						}
						local num = math.random(1, 3)

						self._roleSpine:playAnimation(0, names[num], true)
					end
				end)
				self._awakedescNode1:setVisible(not self._heroAwakeFinished)
				self._awakedescNode2:setPositionX(110)
				self._awakedescNodeDi1:setVisible(not self._heroAwakeFinished)
				self._awakedescNodeDi2:setPositionX(210)
			end
		end
	end
end

function HeroStrengthAwakenMediator:refreshAwakeRoleWithHeroId()
	if self._heroData then
		self:refreshAwakeRole()

		return
	end

	local awakenStarConfig = ConfigReader:getRecordById("HeroAwaken", self._heroId)
	local roleModel = awakenStarConfig.Portrait
	local animType = "Portrait"
	local masterIcon = IconFactory:createRoleIconSpriteNew({
		useAnim = false,
		id = roleModel,
		iconType = animType
	})

	self._awakeRoleNode:removeAllChildren()
	masterIcon:addTo(self._awakeRoleNode):setPosition(0, 0)
	self._awakeAreaRoleNode:removeAllChildren()
	self._awakeRoleNode:setPositionY(320)
	self._awakeRoleNode:setPositionY(180)

	local heroId = awakenStarConfig.ShowHero
	local model = IconFactory:getRoleModelByKey("HeroBase", heroId)

	if not model or model == "" then
		return
	end

	model = ConfigReader:getDataByNameIdAndKey("RoleModel", model, "Model")

	local role = RoleFactory:createRoleAnimation(model)

	self._roleSpine = role

	role:setName("RoleAnim")
	role:addTo(self._awakeAreaRoleNode):setScale(0.7):posite(80, 0)
	role:registerSpineEventHandler(handler(self, self.spineCompleteHandler), sp.EventType.ANIMATION_COMPLETE)
	self._awakeAreaRoleNode:setTouchEnabled(true)
	self._awakeAreaRoleNode:addTouchEventListener(function(sender, eventType)
		if eventType == ccui.TouchEventType.ended then
			local names = {
				"skill1",
				"skill2",
				"skill3"
			}
			local num = math.random(1, 3)

			self._roleSpine:playAnimation(0, names[num], true)
		end
	end)
end

function HeroStrengthAwakenMediator:spineCompleteHandler(event)
	if event.type == "complete" and event.animation ~= "stand1" and self._roleSpine then
		self._roleSpine:playAnimation(0, "stand1", true)
	end
end

function HeroStrengthAwakenMediator:refreshStarUpCostPanel()
	self._costPanel:setVisible(not self._heroAwakeFinished)

	if not self._heroAwakeFinished then
		local heroPrototype = self._heroData:getHeroPrototype()
		local loveNeed = self._heroData:getAwakenStarNeedLove()
		local hasloveLevel = self._heroData:getLoveLevel()
		local lovePanel = self._costPanel:getChildByFullName("costNode3.costBg")
		local loveiconpanel = lovePanel:getChildByFullName("iconpanel")

		loveiconpanel:removeAllChildren()

		local loveIcon = ccui.ImageView:create("album_bg_archives_amount_hgd.png", 1)

		loveIcon:addTo(loveiconpanel):center(loveiconpanel:getContentSize())

		self._loveEngouh = loveNeed <= hasloveLevel

		local addImg = lovePanel:getChildByFullName("addImg")
		local enoughImg = lovePanel:getChildByFullName("bg.enoughImg")
		local costPanel = lovePanel:getChildByFullName("costPanel")

		costPanel:setVisible(true)

		local costNumLabel = costPanel:getChildByFullName("cost")
		local costLimit = costPanel:getChildByFullName("costLimit")

		costNumLabel:setVisible(true)
		costNumLabel:setString(hasloveLevel)
		costLimit:setString("/" .. loveNeed)
		costLimit:setPositionX(costNumLabel:getContentSize().width)
		enoughImg:setVisible(self._loveEngouh)
		addImg:setVisible(not self._loveEngouh)
		loveiconpanel:setGray(not self._loveEngouh)

		local colorNum = self._loveEngouh and 1 or 7

		costNumLabel:setTextColor(GameStyle:getColor(colorNum))
		addImg:getChildByFullName("touchPanel"):addTouchEventListener(function(sender, eventType)
			if eventType == ccui.TouchEventType.ended then
				self:onClickLoveItem()
			end
		end)

		local costStiveNum = heroPrototype:getStarCostStarStiveByStar(self._heroData:getNextStarId(true))
		local stiveNum = self._heroSystem:getHeroStarUpItem().stiveNum
		local scourcePanel = self._costPanel:getChildByFullName("costNode2.costBg")
		local iconpanel = scourcePanel:getChildByFullName("iconpanel")

		iconpanel:removeAllChildren()

		local icon = ccui.ImageView:create("occupation_all.png", 1)

		icon:addTo(iconpanel):center(iconpanel:getContentSize())

		local addImg = scourcePanel:getChildByFullName("addImg")
		local iconpanel = scourcePanel:getChildByFullName("iconpanel")
		local enoughImg = scourcePanel:getChildByFullName("bg.enoughImg")
		local costPanel = scourcePanel:getChildByFullName("costPanel")

		costPanel:setVisible(true)

		local costNumLabel = costPanel:getChildByFullName("cost")
		local costLimit = costPanel:getChildByFullName("costLimit")

		costNumLabel:setVisible(true)
		costNumLabel:setString(stiveNum)
		costLimit:setString("/" .. costStiveNum)
		costLimit:setPositionX(costNumLabel:getContentSize().width)

		self._costNum = costStiveNum
		self._stiveEngouh = costStiveNum <= stiveNum

		enoughImg:setVisible(self._stiveEngouh)
		addImg:setVisible(not self._stiveEngouh)
		iconpanel:setGray(not self._stiveEngouh)

		local colorNum = self._stiveEngouh and 1 or 7

		costNumLabel:setTextColor(GameStyle:getColor(colorNum))
		addImg:getChildByFullName("touchPanel"):addTouchEventListener(function(sender, eventType)
			if eventType == ccui.TouchEventType.ended then
				self:onClickStiveItem()
			end
		end)

		local iconpanel = self._costPanel:getChildByFullName("costNode1.costBg.iconpanel")

		iconpanel:removeAllChildren()

		local hasDebrisNum = self._heroSystem:getHeroDebrisCount(self._heroId)
		local needDebrisNum = heroPrototype:getStarCostFragByStar(self._heroData:getNextStarId(true))

		self._debrisEngouh = needDebrisNum <= hasDebrisNum

		self._heroSystem:setAwakeHeroFragIdAndDebrisCostCount(self._heroId, needDebrisNum)

		local icon = IconFactory:createIcon({
			id = self._heroData:getFragId()
		}, {
			showAmount = false
		})

		icon:setScale(0.46)
		icon:addTo(iconpanel):center(iconpanel:getContentSize())

		local colorNum1 = self._debrisEngouh and 1 or 7

		enoughImg = self._costPanel:getChildByFullName("costNode1.costBg.bg.enoughImg")

		enoughImg:setVisible(self._debrisEngouh)

		local costPanel = self._costPanel:getChildByFullName("costNode1.costBg.costPanel")

		costPanel:setVisible(true)

		local cost = costPanel:getChildByFullName("cost")
		local costLimit = costPanel:getChildByFullName("costLimit")

		cost:setString(hasDebrisNum)
		costLimit:setString("/" .. needDebrisNum)
		costLimit:setPositionX(cost:getContentSize().width)
		costPanel:setContentSize(cc.size(cost:getContentSize().width + costLimit:getContentSize().width, 40))
		cost:setTextColor(GameStyle:getColor(colorNum1))
		costLimit:setTextColor(GameStyle:getColor(colorNum1))

		addImg = self._costPanel:getChildByFullName("costNode1.costBg.addImg")

		addImg:setVisible(not self._debrisEngouh)
		iconpanel:setGray(not self._debrisEngouh)
		addImg:getChildByFullName("touchPanel"):addTouchEventListener(function(sender, eventType)
			if eventType == ccui.TouchEventType.ended then
				self:onClickItem()
			end
		end)

		local canExchange = not table.indexof(Hero_GeneralFragmentLimit, self._heroId)

		self._translteBtn:setVisible(canExchange)

		local costNode1 = self._costPanel:getChildByFullName("costNode1")

		if self._translteBtn:isVisible() then
			costNode1:setPositionX(110)
		else
			costNode1:setPositionX(158)
		end
	end
end

function HeroStrengthAwakenMediator:awakenSuccess()
	return
end

function HeroStrengthAwakenMediator:onClickAwakenBtn()
	local view = self:getInjector():getInstance("HeroStrengthAwakenDetailView")

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
		heroId = self._heroId
	}))
end

function HeroStrengthAwakenMediator:onClickAwakenReplaceBtn()
	local view = self:getInjector():getInstance("HeroStrengthAwakenSuccessView")

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
		close = true,
		heroId = self._heroId,
		oldStarId = self._heroData:getStarIdByNum(self._heroData:getMaxStar())
	}))
end

function HeroStrengthAwakenMediator:onAwakenDetailClicked()
	local debrisChangeTipView = self:getInjector():getInstance("HeroStarSkillView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, debrisChangeTipView, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		heroId = self._heroId
	}, nil))
end

function HeroStrengthAwakenMediator:onClickBox()
	local debrisChangeTipView = self:getInjector():getInstance("HeroStarBoxView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, debrisChangeTipView, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		heroId = self._heroId
	}, nil))
end

function HeroStrengthAwakenMediator:onClickHero()
	if self._heroData.showType == HeroShowType.kCanComp then
		local function callBack(data)
			local view = self:getInjector():getInstance("newHeroView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {
				ignoreNewRed = true,
				heroId = data.id
			}))
			self:close()
		end

		self._bagSystem:requestHeroCompose(self._config.ItemId, callBack)
	elseif self._heroData.showType == HeroShowType.kNotOwn then
		local needCount = self._heroSystem:getHeroComposeFragCount(self._heroId)
		local hasCount = self._heroSystem:getHeroDebrisCount(self._heroId)
		local param = {
			itemId = self._config.ItemId,
			hasNum = hasCount,
			needNum = needCount
		}
		local view = self:getInjector():getInstance("sourceView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, param))
	elseif self._heroData.showType == HeroShowType.kHas then
		local hasCount = self._heroSystem:getHeroDebrisCount(self._heroId)
		local heroPrototype = PrototypeFactory:getInstance():getHeroPrototype(self._heroId)
		local hero = self._heroSystem:getHeroById(self._heroId)
		local needCount = heroPrototype:getStarCostFragByStar(hero:getNextStarId())
		local param = {
			itemId = self._heroData.fragId,
			hasNum = hasCount,
			needNum = needCount
		}
		local view = self:getInjector():getInstance("sourceView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, param))
	end
end

function HeroStrengthAwakenMediator:onClickItem()
	local heroPrototype = self._heroData:getHeroPrototype()
	local needNum = heroPrototype:getStarCostFragByStar(self._heroData:getNextStarId(true))
	local hasCount = self._heroSystem:getHeroDebrisCount(self._heroId)
	local param = {
		isNeed = true,
		hasWipeTip = true,
		itemId = self._heroData:getFragId(),
		hasNum = hasCount,
		needNum = needNum
	}
	local view = self:getInjector():getInstance("sourceView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, param))
end

function HeroStrengthAwakenMediator:onClickStiveItem()
	local heroPrototype = self._heroData:getHeroPrototype()
	local costStiveNum = heroPrototype:getStarCostStarStiveByStar(self._heroData:getNextStarId(true))
	local debrisChangeTipView = self:getInjector():getInstance("HeroStarLevelView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, debrisChangeTipView, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		heroId = self._heroId,
		needNum = costStiveNum,
		callback = function()
			self:refreshStarUpCostPanel()
			self:refreshAwakeBtn()
		end
	}, nil))
end

function HeroStrengthAwakenMediator:onClickLoveItem()
	self._heroSystem:tryEnterDate(self._heroId, GalleryFuncName.kGift)
end

function HeroStrengthAwakenMediator:onClickBack(sender, eventType)
	self:dismiss()
end

function HeroStrengthAwakenMediator:onTranslateClicked()
	local data = self:getIsHaveFragmentFlag()
	local bagSystem = self._developSystem:getBagSystem()
	local hasFragmentNum = bagSystem:getItemCount(data.id)

	if hasFragmentNum <= 0 then
		local heroPrototype = self._heroData:getHeroPrototype()
		local param = {
			needNum = 0,
			isNeed = true,
			hasNum = 0,
			hasWipeTip = true,
			itemId = data.id
		}
		local view = self:getInjector():getInstance("sourceView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, param))

		return
	end

	local debrisChangeTipView = self:getInjector():getInstance("HeroGeneralFragmentView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, debrisChangeTipView, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		kind = 2,
		heroId = self._heroId
	}, nil))
end

function HeroStrengthAwakenMediator:getIsHaveFragmentFlag()
	local data
	local quality = self._heroData:getRarity()
	local info = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Hero_StarFragment", "content")

	for k, v in pairs(info) do
		if quality == tonumber(k) then
			data = {
				id = next(v),
				num = v[next(v)]
			}

			break
		end
	end

	assert(data, "no qualiy Hero_StarFragment ")

	return data
end
