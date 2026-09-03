-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/heroshow/HeroShowOwnMediator.lua

HeroShowOwnMediator = class("HeroShowOwnMediator", DmAreaViewMediator, _M)

HeroShowOwnMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
HeroShowOwnMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")
HeroShowOwnMediator:has("_gallerySystem", {
	is = "r"
}):injectWith("GallerySystem")
HeroShowOwnMediator:has("_surfaceSystem", {
	is = "r"
}):injectWith("SurfaceSystem")

local kBtnHandlers = {
	["mainpanel.buttonPanel.detailbtn"] = {
		clickAudio = "Se_Click_Open_2",
		func = "onClickDetail"
	},
	["mainpanel.buttonPanel.soundbtn"] = {
		clickAudio = "Se_Click_Open_2",
		func = "onClickSound"
	},
	["mainpanel.buttonPanel.surfacebtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickSurface"
	},
	["mainpanel.buttonPanel.bustbtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickBust"
	},
	["mainpanel.buttonPanel.storybtn"] = {
		clickAudio = "Se_Click_Open_2",
		func = "onClickStory"
	},
	["mainpanel.buttonPanel.rebornbtn"] = {
		clickAudio = "Se_Click_Open_2",
		func = "onRebornBtn"
	},
	["mainpanel.changebtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickChange"
	},
	["mainpanel.tipBtn.tipBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickHeroCardDesc"
	},
	["mainpanel.levelNode.levelUpBtn"] = {
		clickAudio = "Se_Click_Open_2",
		func = "onClickLevelUpBtn"
	}
}
local heroVoiceList = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Hero_VoiceList", "content")
local showRarityTipHero = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Hero_WivesTeam", "content")
local HeroSkillShow = ConfigReader:getDataByNameIdAndKey("ConfigValue", "Hero_Skill_Show", "content")
local kBgAnimAndImage = {
	[GalleryPartyType.kBSNCT] = "asset/ui/gallery/party_icon_businiao.png",
	[GalleryPartyType.kXD] = "asset/ui/gallery/party_icon_xide.png",
	[GalleryPartyType.kMNJH] = "asset/ui/gallery/party_icon_monv.png",
	[GalleryPartyType.kDWH] = "asset/ui/gallery/party_icon_dongwenhui.png",
	[GalleryPartyType.kWNSXJ] = "asset/ui/gallery/party_icon_weinasi.png",
	[GalleryPartyType.kSSZS] = "asset/ui/gallery/party_icon_she.png",
	[GalleryPartyType.kUNKNOWN] = "asset/ui/gallery/party_icon_unknown.png"
}
local kHeroRarityAnim = {
	[15] = {
		70
	},
	[14] = {
		70
	},
	[13] = {
		45
	},
	[12] = {
		35
	},
	[11] = {
		35
	}
}
local kAttrType = {
	"ATK",
	"HP",
	"DEF",
	"SPEED"
}

function HeroShowOwnMediator:initialize()
	super.initialize(self)
end

function HeroShowOwnMediator:dispose()
	self._mainPanel:stopAllActions()

	if self._mainPanel.timer then
		self._mainPanel.timer:stop()

		self._mainPanel.timer = nil
	end

	super.dispose(self)
end

function HeroShowOwnMediator:userInject()
	return
end

function HeroShowOwnMediator:onRegister()
	super.onRegister(self)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_REFRESH_PUSH_PACAKGE_DONE, self, self.createPushBackBoxIcon)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_BUY_PACKAGE_SUCC, self, self.createPushBackBoxIcon)

	self._bagSystem = self._developSystem:getBagSystem()
	self._heroSystem = self._developSystem:getHeroSystem()
	self._equipSystem = self._developSystem:getEquipSystem()

	self:mapButtonHandlersClick(kBtnHandlers)
end

function HeroShowOwnMediator:setupView(parentMedi, data)
	self._parentMedi = parentMedi
	self._idList = data.idList

	for i = 1, #self._idList do
		if self._idList[i].id == data.id then
			self._curIdIndex = i

			break
		end
	end

	self._heroTouchEventTag = false

	self:refreshData(data.id)
	self:initNodes()
	self:createPushBackBoxIcon()
end

function HeroShowOwnMediator:refreshData(heroId)
	self._starAnimNm = 1
	self._heroData = self._heroSystem:getHeroById(heroId)
	self._maxStar = self._heroData:getMaxStar()
end

function HeroShowOwnMediator:initNodes()
	self._mainPanel = self:getView():getChildByFullName("mainpanel")
	self._infoPanel = self._mainPanel:getChildByFullName("infoPanel")
	self._specialPanel = self._infoPanel:getChildByFullName("specialPanel")
	self._equipPanel = self._mainPanel:getChildByFullName("equipPanel")
	self._skillPanel = self._mainPanel:getChildByFullName("skillPanel")
	self._skillAnim = self._skillPanel:getChildByFullName("skillAnim")

	self._skillAnim:setVisible(false)
	self._skillAnim:setScale(0.86)

	local listView = self._skillPanel:getChildByFullName("listView")

	listView:setScrollBarEnabled(false)

	self._specialClone = self._specialPanel:getChildByFullName("specialClone")

	self._specialClone:setVisible(false)

	self._infoNode = self._infoPanel:getChildByFullName("infoNode")
	self._levelNode = self._mainPanel:getChildByFullName("levelNode")
	self._toastPanel = self._mainPanel:getChildByFullName("toastPanel")

	self._toastPanel:setVisible(false)

	local bg = self._toastPanel:getChildByFullName("bg")

	bg:ignoreContentAdaptWithSize(true)

	self._primeTextPosX = self._toastPanel:getChildByFullName("clipNode.text"):getPositionX()
	self._primeTextPosY = self._toastPanel:getChildByFullName("clipNode.text"):getPositionY()

	self._toastPanel:getChildByFullName("clipNode.text"):getVirtualRenderer():setDimensions(330, 0)

	self._heroPanel = self._mainPanel:getChildByFullName("heropanel")

	self._toastPanel:setTouchEnabled(true)
	self._toastPanel:addClickEventListener(function()
		if self._toastPanel:isVisible() then
			self._toastPanel:setVisible(false)
		end
	end)

	self._starTouchPanel = self._infoPanel:getChildByFullName("starBg.starTouchPanel")

	self._starTouchPanel:addClickEventListener(function()
		self:onClickStar()
	end)
	self._equipPanel:setTouchEnabled(true)
	self._equipPanel:addClickEventListener(function()
		self:onClickEquip()
	end)

	self._attrTouchLayer = self._infoPanel:getChildByFullName("attrPanel.touchLayer")

	self._attrTouchLayer:setTouchEnabled(true)
	self._attrTouchLayer:addClickEventListener(function(sender, eventType)
		self:onClickAttribute()
	end)

	local occupation = self._infoNode:getChildByFullName("occupation.occupation")

	occupation:setTouchEnabled(true)
	occupation:addClickEventListener(function()
		local view = self:getInjector():getInstance("battlerofessionalRestraintView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {}))
	end)

	local levelUpBtn = self._levelNode:getChildByFullName("levelUpBtn")

	levelUpBtn:removeChildByName("LevelTimer")

	local barImage = cc.Sprite:createWithSpriteFrameName("yh_jt_lq2.png")

	self._progrLoading = cc.ProgressTimer:create(barImage)

	self._progrLoading:setType(0)
	self._progrLoading:setReverseDirection(false)
	self._progrLoading:setAnchorPoint(cc.p(0.5, 0.5))
	self._progrLoading:setMidpoint(cc.p(0.5, 0.5))
	self._progrLoading:addTo(levelUpBtn, 100)
	self._progrLoading:setPosition(cc.p(58, 59))
	self._progrLoading:setName("LevelTimer")

	self._rarityTipBtn = self._infoNode:getChildByFullName("costBg.rarityTip")

	self._rarityTipBtn:setVisible(false)
	self._rarityTipBtn:addClickEventListener(function()
		self:onClickRarityTip()
	end)

	self._buttonPanel = self._mainPanel:getChildByFullName("buttonPanel")
	self._surfaceBtn = self._buttonPanel:getChildByFullName("surfacebtn")
	self._storyBtn = self._buttonPanel:getChildByFullName("storybtn")
	self._bustBtn = self._buttonPanel:getChildByFullName("bustbtn")
	self._rebornBtn = self._buttonPanel:getChildByFullName("rebornbtn")

	self._rebornBtn:setVisible(false)

	local result, tip = self._systemKeeper:isUnlock("Hero_Reborn_Unlock")

	if result then
		self._rebornBtn:setVisible(true)
	end

	self._buttonPanel:getChildByFullName("detailbtn.text"):setString(Strings:get("Hero_button_1"))
	self._buttonPanel:getChildByFullName("surfacebtn.text"):setString(Strings:get("Hero_button_2"))
	self._buttonPanel:getChildByFullName("soundbtn.text"):setString(Strings:get("Hero_button_3"))
	self._buttonPanel:getChildByFullName("storybtn.text"):setString(Strings:get("Hero_button_4"))
	self._buttonPanel:getChildByFullName("bustbtn.text"):setString(Strings:get("Hero_button_5"))

	local redPoint = self._surfaceBtn:getChildByFullName("RedPoint")

	if not redPoint then
		redPoint = ccui.ImageView:create(IconFactory.redPointPath1, 1)

		redPoint:addTo(self._surfaceBtn):posite(45, 50)
		redPoint:setName("RedPoint")
		redPoint:setVisible(false)
	end

	self._storyBtn:setVisible(false)
	self._bustBtn:setPositionX(self._storyBtn:getPositionX())
	self:setEffect()
end

function HeroShowOwnMediator:setEffect()
	GameStyle:setCommonOutlineEffect(self._infoNode:getChildByFullName("cvname.cvname"))
end

function HeroShowOwnMediator:refreshAllView(hideAnim)
	self:refreshInfoPanel()
	self:refreshRarityTip()
	self:refreshName()
	self:refreshStar()

	if not hideAnim then
		self:initHeroAnim()
	end

	self:refreshHero()
end

function HeroShowOwnMediator:refreshStory()
	local unlock, tips = self._systemKeeper:isUnlock("Hero_Gallery")

	if not unlock then
		return
	end

	local heroRewards = self._gallerySystem:getHeroRewards()
	local canGet = not heroRewards[self._heroData:getId()]

	if canGet then
		local redPoint = ccui.ImageView:create(IconFactory.redPointPath1, 1)

		redPoint:addTo(self._storyBtn):posite(45, 50)
		redPoint:setName("RewardRed")
	end
end

function HeroShowOwnMediator:refreshInfoPanel()
	local costnumlabel = self._infoNode:getChildByFullName("costBg.costnumlabel")

	costnumlabel:setString(self._heroData:getCost())

	local occupationName, occupationImg = GameStyle:getHeroOccupation(self._heroData:getType())
	local occupation = self._infoNode:getChildByFullName("occupation.occupation")

	occupation:loadTexture(occupationImg)

	if self._progrLoading then
		local curExp = self._heroData:getExp()
		local nextExp = self._heroSystem:getNextLvlAddExp(self._heroData:getId(), self._heroData:getLevel())

		self._progrLoading:setPercentage(curExp / nextExp * 100)
	end

	local levelNode = self._levelNode:getChildByFullName("levelNode")
	local levelStr = levelNode:getChildByName("levelStr")
	local label = levelNode:getChildByName("levelNum")
	local level = self._heroData:getLevel()

	label:setString(level)
	levelStr:setPositionX(-9)
	label:setPositionX(27)
	levelNode:setContentSize(cc.size(levelStr:getContentSize().width + label:getContentSize().width - 20, 50))
	self:checkShowLevelUpAnim()
	self:refreshAttr()

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

	local tagDesc1 = ConfigReader:getDataByNameIdAndKey("RoleModel", self._heroData:getModel(), "TagDesc")
	local tagDesc = table.deepcopy(tagDesc1 or {}, {})

	if #tagDesc <= 0 then
		self._specialPanel:setVisible(false)
	else
		self._specialPanel:setVisible(true)
	end

	self._specialNode = {}

	for i = 1, 4 do
		local panel = self._specialPanel:getChildByName("node_" .. i)

		if panel then
			panel:removeAllChildren()

			local data = table.remove(tagDesc, #tagDesc)

			if data then
				local cell = self._specialClone:clone()

				cell:setVisible(true)

				local label = cell:getChildByName("desc")

				label:setString(Strings:get(data.code))
				label:setTextColor(GameStyle:stringToColor(data.color))
				cell:addTo(panel):posite(0, 0)
				table.insert(self._specialNode, cell)
			end
		end
	end

	local redPoint = self._surfaceBtn:getChildByFullName("RedPoint")
	local isRed = self._surfaceSystem:getRedPointByHeroId(self._heroData:getId())

	redPoint:setVisible(isRed)
end

function HeroShowOwnMediator:refreshAttr()
	local attrPanel = self._infoPanel:getChildByFullName("attrPanel")
	local des_1 = attrPanel:getChildByFullName("des_1")

	if des_1:getChildByFullName("DescNode") then
		local attrNum = {
			[kAttrType[1]] = self._heroData:getAttack(),
			[kAttrType[2]] = self._heroData:getHp(),
			[kAttrType[3]] = self._heroData:getDefense(),
			[kAttrType[4]] = self._heroData:getSpeed()
		}

		for i = 1, #kAttrType do
			local node = attrPanel:getChildByFullName("des_" .. i)
			local desNode = node:getChildByFullName("DescNode")
			local text = desNode:getChildByFullName("text")

			text:setString(attrNum[kAttrType[i]])
		end
	end
end

function HeroShowOwnMediator:refreshInnerAttrPanel()
	self._attrShowWidget:showAttribute(self._heroData, Strings:get("HEROS_UI22"))
end

function HeroShowOwnMediator:refreshRarityTip()
	self._rarityTipBtn:setVisible(false)
	self._rarityTipBtn:removeAllChildren()

	if not table.indexof(showRarityTipHero, self._heroData:getId()) then
		return
	end

	local rarity = self._heroData:getRarity()
	local star = self._heroData:getStar()
	local starAttr = self:checkIsShowSkill()

	if starAttr then
		rarity = starAttr.rarity or rarity
		star = starAttr.star or star
	end

	if rarity ~= self._heroData:getRarity() and star > self._heroData:getStar() then
		self._rarityTipBtn:setVisible(true)

		local anim = cc.MovieClip:create("zizhitishengtishi_zizhitishengtishi")

		anim:addTo(self._rarityTipBtn):center(self._rarityTipBtn:getContentSize())
		anim:setName("RarityAnim")
		self._rarityTipBtn:getChildByName("RarityAnim"):gotoAndStop(0)
	end
end

function HeroShowOwnMediator:checkIsShowSkill()
	local list = self._heroSystem:getSkillShowList(self._heroData:getId())

	for i = 1, #list do
		local data = list[i]

		if data and self._heroData:getStar() < data.star and data.effectType and data.effectType == SpecialEffectType.kChangeRarity then
			return {
				rarity = data.parameter.value,
				star = data.star
			}
		end
	end

	return nil
end

function HeroShowOwnMediator:showDateToast(label)
	if AudioEngine:getInstance():getRoleEffectOff() then
		return
	end

	local HideVoice = ConfigReader:getDataByNameIdAndKey("ConfigValue", "HideVoice", "content")
	local isHide = table.indexof(HideVoice, self._heroData:getId())

	if isHide then
		return
	end

	if label then
		local qipaoAnim = self._toastPanel:getChildByFullName("QiPaoAnim")

		if not qipaoAnim then
			local qipao = self._toastPanel:clone()

			qipao:setVisible(true)
			qipao:setPosition(cc.p(0, 12))
			qipao:setName("ToastPanel")
			self._toastPanel:removeAllChildren()

			qipaoAnim = cc.MovieClip:create("qipao_haogandutisheng")

			qipaoAnim:addTo(self._toastPanel)
			qipaoAnim:setName("QiPaoAnim")
			qipaoAnim:setPosition(cc.p(0, 0))
			qipaoAnim:addCallbackAtFrame(21, function()
				qipaoAnim:stop()
			end)

			self._qipaoAnimPanel = qipaoAnim:getChildByFullName("qipaoPanel")

			qipao:addTo(self._qipaoAnimPanel)
		end

		qipaoAnim:gotoAndPlay(0)
		self._toastPanel:stopAllActions()
		self._toastPanel:setVisible(true)

		local text = self._qipaoAnimPanel:getChildByFullName("ToastPanel.clipNode.text")

		text:setString(label)
		text:stopAllActions()
		text:setPosition(cc.p(self._primeTextPosX, self._primeTextPosY))
		self:setTextAnim()
	else
		self._toastPanel:setOpacity(255)
		self._toastPanel:setVisible(false)
	end
end

function HeroShowOwnMediator:setTextAnim()
	local clipNode = self._qipaoAnimPanel:getChildByFullName("ToastPanel.clipNode")
	local text = self._qipaoAnimPanel:getChildByFullName("ToastPanel.clipNode.text")
	local textSizeHeight = text:getContentSize().height
	local clipNodeSizeHeight = clipNode:getContentSize().height

	if textSizeHeight > clipNodeSizeHeight - 5 then
		local offset = textSizeHeight - clipNodeSizeHeight + 10

		text:runAction(cc.Sequence:create(cc.DelayTime:create(3), cc.MoveTo:create(2.5 * (offset / 25), cc.p(self._primeTextPosX, self._primeTextPosY + offset))))
	end
end

function HeroShowOwnMediator:onClickHelp()
	local heroId = self._heroData:getId()

	if not self._heroTouchEventTag then
		self._heroTouchEventTag = true

		self._parentMedi:stopHeroEffect()

		local length = 0
		local sounds = {}

		for i = 1, #heroVoiceList do
			local index = heroVoiceList[i]
			local soundId = "Voice_" .. heroId .. "_" .. index
			local pkgName = ConfigReader:getDataByNameIdAndKey("Sound", soundId, "PkgName")

			if pkgName ~= "common/Default" then
				local unlock = self:isSoundUnlock(soundId)

				if unlock then
					table.insert(sounds, soundId)

					length = length + 1
				end
			end
		end

		if length > 0 then
			local listTag = math.random(1, length)
			local soundId = sounds[listTag]
			local audioEffect = AudioEngine:getInstance():playRoleEffect(soundId, false, function()
				self._heroTouchEventTag = false

				self:showDateToast()
			end)
			local desc = ConfigReader:getDataByNameIdAndKey("Sound", soundId, "SoundDesc")
			local str = Strings:get(desc)

			if str ~= "" then
				self:showDateToast(str)
			end

			self._heroSystem:setUiHeroEffectId(audioEffect)
			performWithDelay(self:getView(), function()
				self._heroTouchEventTag = false
			end, 2)
		end
	end
end

function HeroShowOwnMediator:isSoundUnlock(soundId)
	local soundObj = self._heroData:getSounds()
	local sound = soundObj[soundId]

	if not sound then
		return true
	end

	return (not sound:getUnlock() or nil) and self._heroSystem:getSoundUnlock(self._heroData, sound)
end

function HeroShowOwnMediator:onClickSurface()
	AudioEngine:getInstance():playEffect("Se_Click_Open_2", false)

	if #self._heroData:getSurfaceList() > 0 then
		self._surfaceSystem:tryEnter({
			id = self._heroData:getId(),
			surfaceType = SurfaceViewType.kHero
		})
	end
end

function HeroShowOwnMediator:onClickSound()
	self._parentMedi:stopHeroEffect()

	local systemKeeper = self:getInjector():getInstance(SystemKeeper)
	local unlock, tips = systemKeeper:isUnlock("Hero_Sound")

	if not unlock then
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = tips
		}))
	else
		local view = self:getInjector():getInstance("HeroSoundView")

		self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
			id = self._heroData:getId()
		}))
	end
end

function HeroShowOwnMediator:onClickDetail()
	local heroShowDetailsView = self:getInjector():getInstance("HeroShowDetailsView")

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, heroShowDetailsView, {}, {
		heroId = self._heroData:getId()
	}))
end

function HeroShowOwnMediator:onClickBust()
	if self._soundId then
		AudioEngine:getInstance():stopEffect(self._soundId)

		self._soundId = nil
	end

	local view = self:getInjector():getInstance("HeroShowHeroPicView")

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
		id = self._heroData:getId()
	}))
end

function HeroShowOwnMediator:onClickHeroCardDesc()
	local view = self:getInjector():getInstance("HeroCardView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		type = "card"
	}))
end

function HeroShowOwnMediator:onClickChange()
	self._heroSystem:setShowHeroType(self._heroSystem:getShowHeroType() == 1 and 2 or 1)
	self:refreshHero()
end

function HeroShowOwnMediator:onClickAttribute(sender, eventType)
	if not self._attrTipNode then
		self._attrTipNode = cc.CSLoader:createNode("asset/ui/MasterAttrShowTip.csb")

		self._attrTipNode:setVisible(false)
		self._attrTipNode:addTo(self._parentMedi:getView()):posite(250, 45)

		self._attrShowWidget = self:autoManageObject(self:getInjector():injectInto(MasterAttrShowTipWidget:new(self._attrTipNode)))
	end

	if self._attrTipNode:isVisible() then
		self._attrTipNode:setVisible(false)
	else
		self._attrTipNode:setVisible(true)
		self:refreshInnerAttrPanel()
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
	end
end

function HeroShowOwnMediator:onClickStar()
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	local systemKeeper = self:getInjector():getInstance(SystemKeeper)
	local unlock, tips = systemKeeper:isUnlock("Hero_StarUp")

	if not unlock then
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = tips
		}))

		return
	end

	self._parentMedi:stopHeroEffect()
	self._parentMedi._tabController:selectTabByTag(3)
end

function HeroShowOwnMediator:onClickEquip()
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	local systemKeeper = self:getInjector():getInstance(SystemKeeper)
	local unlock, tips = systemKeeper:isUnlock("Hero_Equip")

	if not unlock then
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = tips
		}))

		return
	end

	self._parentMedi:stopHeroEffect()
	self._parentMedi._tabController:selectTabByTag(5)
end

function HeroShowOwnMediator:onClickSkill(skill)
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	if not self._skillWidget then
		self._skillWidget = self:autoManageObject(self:getInjector():injectInto(SkillDescWidget:new(SkillDescWidget:createWidgetNode(), {
			skill = skill,
			mediator = self._parentMedi
		})))

		self._skillWidget:getView():addTo(self._parentMedi:getView())
		self._skillWidget:getView():setPosition(cc.p(self._skillPanel:getPosition())):offset(-240, -48)
	end

	self._skillWidget:refreshInfo(skill, self._heroData)
	self._skillWidget:show()
end

function HeroShowOwnMediator:onClickRelationInfo()
	local systemKeeper = self:getInjector():getInstance(SystemKeeper)
	local unlock, tips = systemKeeper:isUnlock("Hero_Relation")

	if not unlock then
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = tips
		}))

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Open_2", false)
	self._parentMedi:stopHeroEffect()

	local view = self:getInjector():getInstance("HeroRelationView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {
		heroId = self._heroData:getId()
	}))
end

function HeroShowOwnMediator:onClickLevelUpBtn()
	self._parentMedi:stopHeroEffect()
	self._heroSystem:tryEnterLevel({
		id = self._heroData:getId()
	})
end

function HeroShowOwnMediator:onRebornBtn()
	self._parentMedi:stopHeroEffect()

	local invalidIds = ConfigReader:requireDataByNameIdAndKey("ConfigValue", "Hero_Reborn_Forb", "content")
	local canGet = true

	for k, v in ipairs(invalidIds) do
		if v == self._heroData:getId() then
			canGet = false

			break
		end
	end

	if canGet then
		self._heroSystem:tryEnterReborn({
			reborn = true,
			id = self._heroData:getId()
		})
	else
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Hero_Reborn_UI6")
		}))
	end
end

function HeroShowOwnMediator:onClickStory()
	local unlock, tips = self._systemKeeper:isUnlock("Hero_Gallery")

	if not unlock then
		self:dispatch(ShowTipEvent({
			duration = 0.35,
			tip = tips
		}))

		return
	end

	local heroId = self._heroData:getId()

	if not self._gallerySystem:isPastOpen(heroId) then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("HeroStory_SecondaryEntrance")
		}))

		return
	end

	local heroInfos = self._gallerySystem:getHeroInfos(heroId)
	local storyArray = self._gallerySystem:getHeroStory(heroId)
	local view = self:getInjector():getInstance("GalleryPartnerPastView")

	self:dispatch(ViewEvent:new(EVT_PUSH_VIEW, view, nil, {
		id = heroId,
		bg = heroInfos.bg,
		storyArray = storyArray
	}))
end

function HeroShowOwnMediator:onClickRarityTip()
	local view = self:getInjector():getInstance("HeroRarityTipView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {
		data = self._heroData
	}))
end

function HeroShowOwnMediator:checkShowLevelUpAnim()
	local hasLvlRedPoint = self._heroSystem:hasRedPointByLevel(self._heroData:getId())
	local hasEvoRedPoint = self._heroSystem:hasRedPointByEvolution(self._heroData:getId())
	local levelUp = self._levelNode:getChildByFullName("levelUpBtn")
	local levelBg = levelUp:getChildByFullName("levelBg")

	levelUp:removeChildByName("LevelUp")
	levelUp:removeChildByName("RedPoint")

	if hasLvlRedPoint then
		local mc = cc.MovieClip:create("jhao_yinghun")

		mc:addTo(levelUp)
		mc:setPosition(cc.p(58, 58))
		mc:setName("LevelUp")
		mc:setPlaySpeed(0.6)
	elseif hasEvoRedPoint then
		local mc = cc.MovieClip:create("shengjt_yinghun")

		mc:addTo(levelUp)
		mc:setPosition(cc.p(58, 58))
		mc:setName("LevelUp")
		mc:setPlaySpeed(0.6)

		local redPoint = ccui.ImageView:create(IconFactory.redPointPath, 1)

		redPoint:addTo(levelUp, 101):posite(90, 90)
		redPoint:setName("RedPoint")
	end

	levelBg:setVisible(not hasLvlRedPoint)
end

function HeroShowOwnMediator:initHeroAnim()
	local outSelf = self

	if not self._heroPanelAnim then
		self._heroPanel:removeChildByName("HeroAnim")

		self._heroPanelAnim = cc.MovieClip:create("renwu_yinghun")

		self._heroPanelAnim:addTo(self._heroPanel)
		self._heroPanelAnim:setName("HeroAnim")
		self._heroPanelAnim:addCallbackAtFrame(30, function()
			outSelf._heroPanelAnim:stop()
		end)
		self._heroPanelAnim:setPosition(cc.p(300, 275))
		self._heroPanelAnim:setPlaySpeed(1.5)

		self._heroAnimPanel = self._heroPanelAnim:getChildByName("heroPanel")
		self._showAnim = false
	end
end

function HeroShowOwnMediator:refreshHero()
	if not self._heroPanelAnim then
		self:initHeroAnim()
	end

	if self._showAnim then
		self._heroPanelAnim:gotoAndPlay(0)
	else
		self._heroPanelAnim:gotoAndPlay(29)

		self._showAnim = true
	end

	self:runStartAnim()

	self._touchTimes = 0

	if self._heroPanelAnim then
		local panel = self._heroAnimPanel

		panel:removeAllChildren()

		if self._heroSystem:getShowHeroType() == 1 then
			local heroAnim = self._heroSystem:getHeroAnim()

			if heroAnim then
				heroAnim:setVisible(true)
				heroAnim:changeParent(panel)
				heroAnim:setPosition(cc.p(60, -110))

				local size = heroAnim:getContentSize()
				local offSetX = size.width / 2
				local picInfo = self._heroSystem:getHeroPicInfo()
				local surfaceId = self._heroData:getSurfaceId()
				local surfaceData = ConfigReader:getDataByNameIdAndKey("Surface", surfaceId, "ClickAction")
				local num = #surfaceData

				for i = 1, num do
					local _info = surfaceData[i]
					local touchPanel = ccui.Layout:create()

					touchPanel:setAnchorPoint(cc.p(0.5, 0.5))

					local point = _info.point

					if point[1] == "all" then
						local size = heroAnim:getContentSize()

						touchPanel:setContentSize(cc.size(size.width / 2 * picInfo.zoom, size.height * picInfo.zoom))
						touchPanel:setPosition(size.width / 2 + picInfo.Deviation[1], size.height / 2 + picInfo.Deviation[2])
					else
						touchPanel:setContentSize(cc.size(_info.range[1] * picInfo.zoom, _info.range[2] * picInfo.zoom))
						touchPanel:setPosition(cc.p(_info.point[1] * picInfo.zoom + picInfo.Deviation[1] + offSetX, _info.point[2] * picInfo.zoom + picInfo.Deviation[2]))
					end

					if GameConfigs.HERO_TOUCHVIEW_DEBUG then
						touchPanel:setBackGroundColorType(1)
						touchPanel:setBackGroundColor(cc.c3b(255, 0, 0))
						touchPanel:setBackGroundColorOpacity(180)
					end

					touchPanel:setTouchEnabled(true)
					touchPanel:addTouchEventListener(function(sender, eventType)
						if eventType == ccui.TouchEventType.began then
							if self._sharedSpine and self._sharedSpine:hasAnimation(_info.action) then
								self._sharedSpine:playAnimation(0, _info.action, true)
							end

							if self._soundId then
								return
							end

							self._touchTimes = self._touchTimes + 1

							local soundId = AudioTimerSystem:getHeroTouchSoundByPart(self._heroData:getId(), _info.part, self._touchTimes)

							self._soundId = AudioEngine:getInstance():playRoleEffect(soundId, false, function()
								self:showDateToast()

								self._soundId = nil
							end)

							self._parentMedi:setHeroEffectId(self._soundId)

							local desc = ConfigReader:getDataByNameIdAndKey("Sound", soundId, "SoundDesc")
							local str = Strings:get(desc)

							if str ~= "" then
								self:showDateToast(str)
							end

							self._parentMedi:setIgnoreSoundEffect(true)
						end
					end)
					touchPanel:addTo(heroAnim, num + 1 - i)
				end

				self._heroSystem:setHeroAnim(nil)

				return
			end

			local img, path, spineani, picInfo = IconFactory:createRoleIconSpriteNew({
				useAnim = true,
				frameId = "bustframe9",
				id = self._heroData:getModel()
			})

			panel:addChild(img)
			img:setPosition(cc.p(60, -110))

			local size = img:getContentSize()
			local offSetX = size.width / 2
			local surfaceId = self._heroData:getSurfaceId()
			local surfaceData = ConfigReader:getDataByNameIdAndKey("Surface", surfaceId, "ClickAction")
			local num = #surfaceData

			for i = 1, num do
				local _info = surfaceData[i]
				local touchPanel = ccui.Layout:create()

				touchPanel:setAnchorPoint(cc.p(0.5, 0.5))

				local point = _info.point

				if point[1] == "all" then
					local size = img:getContentSize()

					touchPanel:setContentSize(cc.size(size.width / 2 * picInfo.zoom, size.height * picInfo.zoom))
					touchPanel:setPosition(size.width / 2 + picInfo.Deviation[1], size.height / 2 + picInfo.Deviation[2])
				else
					touchPanel:setContentSize(cc.size(_info.range[1] * picInfo.zoom, _info.range[2] * picInfo.zoom))
					touchPanel:setPosition(cc.p(_info.point[1] * picInfo.zoom + picInfo.Deviation[1] + offSetX, _info.point[2] * picInfo.zoom + picInfo.Deviation[2]))
				end

				if GameConfigs.HERO_TOUCHVIEW_DEBUG then
					touchPanel:setBackGroundColorType(1)
					touchPanel:setBackGroundColor(cc.c3b(255, 0, 0))
					touchPanel:setBackGroundColorOpacity(180)
				end

				touchPanel:setTouchEnabled(true)
				touchPanel:addTouchEventListener(function(sender, eventType)
					if eventType == ccui.TouchEventType.began then
						if self._sharedSpine and self._sharedSpine:hasAnimation(_info.action) then
							self._sharedSpine:playAnimation(0, _info.action, true)
						end

						if self._soundId then
							return
						end

						self._touchTimes = self._touchTimes + 1

						local soundId = AudioTimerSystem:getHeroTouchSoundByPart(self._heroData:getId(), _info.part, self._touchTimes)

						self._soundId = AudioEngine:getInstance():playRoleEffect(soundId, false, function()
							self:showDateToast()

							self._soundId = nil
						end)

						self._parentMedi:setHeroEffectId(self._soundId)

						local desc = ConfigReader:getDataByNameIdAndKey("Sound", soundId, "SoundDesc")
						local str = Strings:get(desc)

						if str ~= "" then
							self:showDateToast(str)
						end

						self._parentMedi:setIgnoreSoundEffect(true)
					end
				end)
				touchPanel:addTo(img, num + 1 - i)
			end
		elseif self._heroSystem:getShowHeroType() == 2 then
			local anim, jsonPath = RoleFactory:createHeroAnimation(self._heroData:getModel())

			panel:addChild(anim)
			anim:setAnchorPoint(cc.p(0.5, 0.5))
			anim:setPosition(cc.p(panel:getContentSize().width / 2, panel:getContentSize().height / 2 - 60))
		end
	end
end

function HeroShowOwnMediator:refreshStar()
	local star1 = self._infoPanel:getChildByFullName("starBg.star_1")

	if star1:getChildByFullName("star") then
		for i = 1, HeroStarCountMax do
			local node = self._infoPanel:getChildByFullName("starBg.star_" .. i)

			node:setVisible(i <= self._maxStar)

			local star = node:getChildByFullName("star")
			local path = i <= self._heroData:getStar() and "img_yinghun_img_star_full.png" or i == self._heroData:getStar() + 1 and self._heroData:getLittleStar() and "img_yinghun_img_star_half.png" or "img_yinghun_img_star_empty.png"

			if self._heroData:getAwakenStar() > 0 then
				path = "jx_img_star.png"

				if i <= self._heroData:getIdentityAwakenLevel() then
					path = "yinghun_img_awake_star.png"
				end
			end

			star:loadTexture(path, 1)
		end
	end
end

function HeroShowOwnMediator:refreshEquip()
	self._equipNode = {}

	for index = 1, #EquipPositionToType do
		local panel = self._equipPanel:getChildByFullName("node_" .. index)
		local equipType = EquipPositionToType[index]
		local equipId = self._heroData:getEquipIdByType(equipType)

		panel:removeAllChildren()

		local equipIcon

		if equipId then
			local equipData = self._equipSystem:getEquipById(equipId)
			local rarity = equipData:getRarity()
			local level = equipData:getLevel()
			local star = equipData:getStar()
			local param = {
				id = equipData:getEquipId(),
				level = level,
				star = star,
				rarity = rarity
			}

			equipIcon = IconFactory:createEquipIcon(param, {
				hideLevel = true
			})

			equipIcon:setScale(0.6)
		else
			equipIcon = IconFactory:createEquipEmpty(equipType)

			local id = self._heroData:getId()
			local hasRed = self._heroSystem:hasRedPointByEquipReplace(id, equipType)

			if hasRed then
				local redPoint = ccui.ImageView:create(IconFactory.redPointPath, 1)

				redPoint:addTo(equipIcon):posite(33, 32)
			end
		end

		equipIcon:addTo(panel):center(panel:getContentSize())

		self._equipNode[index] = equipIcon
	end
end

function HeroShowOwnMediator:refreshSkill()
	local listView = self._skillPanel:getChildByFullName("listView")

	listView:removeAllItems()

	self._skillNode = {}

	local skillIds = self._heroData:getShowSkillIds()
	local num = math.min(4, #skillIds)
	local skills = {}

	for i = 1, num do
		local skillId = skillIds[i]
		local skill = self._heroData:getSkillById(skillId)

		table.insert(skills, skill)
	end

	for index = 1, num do
		local panel = self._skillPanel:getChildByFullName("node_" .. index)

		panel:removeAllChildren()

		local skill = skills[index]
		local skillId = skill:getSkillId()
		local isLock = not skill:getEnable()
		local skillType = skill:getType()

		panel:setTouchEnabled(true)
		panel:addClickEventListener(function()
			self:onClickSkill(skill)
		end)

		local skillIcon = IconFactory:createHeroSkillIcon({
			levelHide = true,
			id = skillId
		})

		skillIcon:addTo(panel):center(panel:getContentSize())
		skillIcon:setScale(0.7)

		if index == 1 then
			self._skillPanel:getChildByFullName("skillAnimNode.text"):setString(self._heroSystem:getSkillTypeName(skillType))
			self._skillPanel:getChildByFullName("skillName"):setString(skill:getName())

			if skill:getDesc() and skill:getDesc() ~= "" then
				local newPanel = self:createSkillDescPanel(skill:getDesc(), nil, skill)

				listView:pushBackCustomItem(newPanel)
			end

			local skillProto = PrototypeFactory:getInstance():getSkillPrototype(skill:getSkillProId())

			if not skillProto then
				return
			end

			local style = {
				fontSize = 16,
				fontName = TTF_FONT_FZYH_R
			}
			local attrDescs = skillProto:getAttrDescs(skill:getLevel(), style) or {}

			for i = 1, #attrDescs do
				local newPanel = self:createEffectDescPanel(attrDescs[i])

				listView:pushBackCustomItem(newPanel)
			end
		else
			local skillAnimPanel = self._skillAnim:clone()

			skillAnimPanel:addTo(skillIcon)
			skillAnimPanel:setVisible(true)
			skillAnimPanel:removeChildByName("SkillAnim")

			local skillPanel1 = skillAnimPanel:getChildByFullName("skillTypeIcon")

			skillPanel1:setVisible(true)

			local skillPanel2 = skillAnimPanel:getChildByFullName("skillTypeBg")

			skillPanel2:setVisible(true)

			local icon1, icon2

			if self._isMaster then
				skillType = skill:getSkillType()
				icon1, icon2 = self._masterSystem:getSkillTypeIcon(skillType)
			else
				icon1, icon2 = self._heroSystem:getSkillTypeIcon(skillType)
			end

			local skillTypeIcon = skillPanel1:getChildByFullName("icon")

			skillTypeIcon:loadTexture(icon1)

			local skillTypeBg = skillPanel2:getChildByFullName("bg")

			skillTypeBg:loadTexture(icon2)
			skillTypeBg:setCapInsets(cc.rect(4, 15, 6, 16))

			local typeNameLabel = skillPanel2:getChildByFullName("skillType")

			if self._isMaster then
				typeNameLabel:setString(self._masterSystem:getSkillTypeName(skillType))
			else
				typeNameLabel:setString(self._heroSystem:getSkillTypeName(skillType))
			end

			typeNameLabel:setTextColor(GameStyle:getSkillTypeColor(skillType))

			local width = typeNameLabel:getContentSize().width + 30

			skillTypeBg:setContentSize(cc.size(width, 38))

			width = width + 25

			skillAnimPanel:setContentSize(cc.size(width, 46))
			skillAnimPanel:setPosition(cc.p(50, 8))
		end

		if isLock then
			local lockImg = ccui.ImageView:create("yinghun_img_lock.png", 1)

			lockImg:addTo(panel):posite(54, 10)
			skillIcon:setColor(cc.c3b(127, 127, 127))
			lockImg:setScale(0.9)
		end

		local isKeySkill = self._heroSystem:checkIsKeySkill(self._heroData:getId(), skillId)

		if isKeySkill then
			local icon1, icon2 = self._heroSystem:getSkillTypeIcon(skillType)
			local image = ccui.ImageView:create(icon1)

			image:addTo(skillIcon):posite(90, 82)
		end

		self._skillNode[index] = skillIcon
	end
end

local listWidth = 230

function HeroShowOwnMediator:createSkillDescPanel(title, otherHeight, skill, width, style)
	otherHeight = otherHeight or 8

	local layout = ccui.Layout:create()
	local strWidth = width or listWidth

	style = style or {
		fontSize = 16,
		SkillRate = self._heroData:getSkillRateShow(),
		fontName = TTF_FONT_FZYH_R
	}

	local desc = ConfigReader:getEffectDesc("Skill", title, skill:getSkillProId(), skill:getLevel(), style)
	local label = ccui.RichText:createWithXML(desc, {})

	label:setVerticalSpace(1)
	label:renderContent(strWidth, 0)
	label:setAnchorPoint(cc.p(0, 1))

	local height = label:getContentSize().height

	layout:setContentSize(cc.size(strWidth, height + otherHeight))
	label:addTo(layout)
	label:setPosition(cc.p(0, height + otherHeight))

	return layout
end

function HeroShowOwnMediator:createEffectDescPanel(desc, otherHeight, width)
	local strWidth = width or listWidth

	otherHeight = otherHeight or 8

	local layout = ccui.Layout:create()
	local label = ccui.RichText:createWithXML(desc, {})

	label:setVerticalSpace(1)
	label:renderContent(strWidth, 0)
	label:setAnchorPoint(cc.p(0, 1))

	local height = label:getContentSize().height

	layout:setContentSize(cc.size(strWidth, height + otherHeight))
	label:addTo(layout)
	label:setPosition(cc.p(0, height + otherHeight))

	return layout
end

function HeroShowOwnMediator:refreshName()
	self._surfaceBtn:setVisible(#self._heroData:getSurfaceList() >= 1)

	local nameBg = self._infoNode:getChildByFullName("nameBg.nameBg")
	local name = self._infoNode:getChildByFullName("nameLabel.nameLabel")
	local linkImage = self._infoNode:getChildByFullName("nameLabel.linkImage")
	local nameString = self._heroData:getName()
	local qualityLevel = self._heroData:getQualityLevel() == 0 and "" or "+" .. self._heroData:getQualityLevel()

	name:setString(nameString .. qualityLevel)
	name:setFontSize(self:getFontSizeForName(nameString .. qualityLevel))
	GameStyle:setHeroNameByQuality(name, self._heroData:getQuality(), 1)

	if name:getContentSize().width > 270 then
		name:setString("")
		name:setTextVerticalAlignment(cc.TEXT_ALIGNMENT_CENTER)
		name:setTextHorizontalAlignment(cc.TEXT_ALIGNMENT_LEFT)
		name:getVirtualRenderer():setOverflow(cc.LabelOverflow.SHRINK)
		name:getVirtualRenderer():setDimensions(270, 71)
		name:setString(nameString .. qualityLevel)
	end

	nameBg:setScaleX((name:getContentSize().width + 90) / nameBg:getContentSize().width)

	if self._heroSystem:isLinkStageHero(self._heroData:getId()) then
		linkImage:setVisible(true)
		linkImage:setPositionX(nameBg:getContentSize().width * nameBg:getScaleX())
	else
		linkImage:setVisible(false)
	end

	local cvname = self._infoNode:getChildByFullName("cvname.cvname")
	local cvNameString = self._heroData:getCVName()

	cvname:setString(Strings:get("GALLERY_UI10", {
		cvname = cvNameString
	}))

	local rarityIcon = self._infoNode:getChildByFullName("rarityIcon.rarityIcon")

	rarityIcon:removeAllChildren()

	local rarity = IconFactory:getHeroRarityAnim(self._heroData:getRarity())

	rarity:addTo(rarityIcon):offset(kHeroRarityAnim[self._heroData:getRarity()][1], 20)

	local partyType = self._infoNode:getChildByFullName("partyType.partyType")

	if kBgAnimAndImage[self._heroData:getParty()] then
		partyType:setVisible(true)
		partyType:loadTexture(kBgAnimAndImage[self._heroData:getParty()])
	else
		partyType:setVisible(false)
	end
end

function HeroShowOwnMediator:getFontSizeForName(str)
	local fontSize = 50

	repeat
		local lvLabel = cc.Label:createWithTTF(str, CUSTOM_TTF_FONT_1, fontSize)

		fontSize = fontSize - 2
	until lvLabel:getContentSize().width < 200 or fontSize < 2

	return fontSize
end

function HeroShowOwnMediator:runStartAnim()
	self._mainPanel:stopAllActions()

	local action = cc.CSLoader:createTimeline("asset/ui/HeroShowOwn.csb")

	self._mainPanel:runAction(action)
	action:clearFrameEventCallFunc()
	action:gotoFrameAndPlay(0, 57, false)
	action:setTimeSpeed(1.1)
	self._starTouchPanel:setVisible(false)
	self._attrTouchLayer:setVisible(false)
	self._levelNode:setVisible(false)
	self._buttonPanel:setVisible(false)

	if self._specialPanel:isVisible() then
		for i = 1, #self._specialNode do
			local node = self._specialNode[i]

			node:setOpacity(0)
			node:stopAllActions()
		end
	end

	local listView = self._skillPanel:getChildByFullName("listView")

	listView:setOpacity(0)
	listView:stopAllActions()

	local skillName = self._skillPanel:getChildByFullName("skillName")

	skillName:setOpacity(0)
	skillName:stopAllActions()

	local initSkill = false

	if self._skillNode then
		initSkill = true

		for i = 1, #self._skillNode do
			local node = self._skillNode[i]

			node:setOpacity(0)
			node:stopAllActions()
		end
	end

	local detailbtnName = self._buttonPanel:getChildByFullName("detailbtn.text")
	local surfacebtnName = self._buttonPanel:getChildByFullName("surfacebtn.text")
	local soundbtnName = self._buttonPanel:getChildByFullName("soundbtn.text")
	local storybtnName = self._buttonPanel:getChildByFullName("storybtn.text")
	local bustbtnName = self._buttonPanel:getChildByFullName("bustbtn.text")

	if getCurrentLanguage() ~= GameLanguageType.CN then
		detailbtnName:setFontSize(15)
		surfacebtnName:setFontSize(15)
		soundbtnName:setFontSize(15)
		storybtnName:setFontSize(15)
		bustbtnName:setFontSize(15)
	end

	local function onFrameEvent(frame)
		if frame == nil then
			return
		end

		local str = frame:getEvent()

		if str == "HeroTipAnim" and not self._parentMedi:getIgnoreSoundEffect() then
			self._parentMedi:stopHeroEffect()

			self._soundId = AudioEngine:getInstance():playRoleEffect("Voice_" .. self._heroData:getId() .. "_10", false, function()
				self:showDateToast()

				self._soundId = nil
			end)

			self._parentMedi:setHeroEffectId(self._soundId)

			local desc = ConfigReader:getDataByNameIdAndKey("Sound", "Voice_" .. self._heroData:getId() .. "_10", "SoundDesc")
			local str = Strings:get(desc)

			if str ~= "" then
				self:showDateToast(str)
			end

			self._parentMedi:setIgnoreSoundEffect(true)
		end

		if str == "SpecialTipAnim" then
			if self._specialPanel:isVisible() then
				local delayTime = 0.06666666666666667

				for i = 1, #self._specialNode do
					local node = self._specialNode[i]

					node:setOpacity(0)
					performWithDelay(node, function()
						self:runCommonAction2(node)
					end, delayTime * (i - 1))
				end
			end

			local star1 = self._infoPanel:getChildByFullName("starBg.star_1")

			if not star1:getChildByFullName("star") then
				for i = 1, HeroStarCountMax do
					local node = self._infoPanel:getChildByFullName("starBg.star_" .. i)

					node:setVisible(i <= self._maxStar)

					local path = i <= self._heroData:getStar() and "img_yinghun_img_star_full.png" or i == self._heroData:getStar() + 1 and self._heroData:getLittleStar() and "img_yinghun_img_star_half.png" or "img_yinghun_img_star_empty.png"

					if self._heroData:getAwakenStar() > 0 then
						path = "jx_img_star.png"

						if i <= self._heroData:getIdentityAwakenLevel() then
							path = "yinghun_img_awake_star.png"
						end
					end

					local star = ccui.ImageView:create(path, 1)

					star:ignoreContentAdaptWithSize(true)
					star:setName("star")
					star:addTo(node)
					star:setScale(0.6)
				end
			end
		end

		if str == "StarTouchAnim" then
			AudioEngine:getInstance():playEffect("Se_Effect_Character_Info", false)
			self._starTouchPanel:setVisible(true)

			local attrPanel = self._infoPanel:getChildByFullName("attrPanel")
			local des_1 = attrPanel:getChildByFullName("des_1")

			if not des_1:getChildByFullName("DescNode") then
				for i = 1, #kAttrType do
					local des = attrPanel:getChildByFullName("des_" .. i)

					if not des:getChildByFullName("DescNode") then
						local node = cc.CSLoader:createNode("asset/ui/HeroAttrNode.csb")

						node:addTo(des)
						node:setName("DescNode")

						local text = node:getChildByFullName("text")
						local name = node:getChildByFullName("name")
						local image = node:getChildByFullName("image")

						GameStyle:setCommonOutlineEffect(text, 142.8)
						GameStyle:setCommonOutlineEffect(name)
						name:setString(getAttrNameByType(kAttrType[i]))
						image:loadTexture(AttrTypeImage[kAttrType[i]], 1)
					end
				end

				self:refreshAttr()
			end
		end

		if str == "AttrTouchAnim" then
			self._attrTouchLayer:setVisible(true)
		end

		if str == "LevelAnim" then
			self._levelNode:setVisible(true)
			self._levelNode:setOpacity(0)
			self._levelNode:fadeIn({
				time = 0.2
			})
			self:refreshStory()
			self:refreshSkill()

			if not initSkill then
				for i = 1, #self._skillNode do
					local node = self._skillNode[i]

					node:setOpacity(0)
					node:stopAllActions()
				end
			end

			local delayTime = 0.1

			for i = 1, #self._skillNode do
				local node = self._skillNode[i]

				node:setOpacity(0)
				performWithDelay(node, function()
					self:runCommonAction1(node)
				end, delayTime * (i - 1))
			end

			skillName:fadeIn({
				time = 0.2
			})
			listView:fadeIn({
				time = 0.2
			})
			self._buttonPanel:setVisible(true)
			detailbtnName:fadeIn({
				time = 0.2
			})
			surfacebtnName:fadeIn({
				time = 0.2
			})
			soundbtnName:fadeIn({
				time = 0.2
			})
			storybtnName:fadeIn({
				time = 0.2
			})
			bustbtnName:fadeIn({
				time = 0.2
			})
		end

		if str == "StoryAnim" then
			-- block empty
		end

		if str == "SkillAndEquipAnim" then
			-- block empty
		end
	end

	action:setFrameEventCallFunc(onFrameEvent)
end

function HeroShowOwnMediator:runStartAction()
	return
end

function HeroShowOwnMediator:runCommonAction1(node)
	if not node then
		return
	end

	local parent = node:getParent()
	local targetPos = cc.p(parent:getContentSize().width / 2, parent:getContentSize().height / 2)

	node:setPosition(cc.p(targetPos.x, targetPos.y + 100))

	local time = 0.16666666666666666
	local moveTo = cc.MoveTo:create(time, targetPos)
	local fadeIn = cc.FadeIn:create(time)
	local spawn = cc.Spawn:create(moveTo, fadeIn)
	local easeInOut = cc.EaseIn:create(spawn, 3)

	node:runAction(easeInOut)
end

function HeroShowOwnMediator:runCommonAction2(node)
	if not node then
		return
	end

	local targetPos = cc.p(0, 0)

	node:setPosition(cc.p(-100, 0))

	local time = 0.2
	local moveTo = cc.MoveTo:create(time, targetPos)
	local fadeIn = cc.FadeIn:create(time)
	local spawn = cc.Spawn:create(moveTo, fadeIn)

	node:runAction(spawn)
end

function HeroShowOwnMediator:createPushBackBoxIcon(parentNode, pos, sceneId)
	local sceneId = KShopPushPackageScene.KHeroLevelUp

	IconFactory:createPushBackBoxIcon(self._mainPanel, {
		960,
		460
	}, sceneId)
end
