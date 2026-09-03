-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/herostrength/HeroEquipDressedMediator.lua

HeroEquipDressedMediator = class("HeroEquipDressedMediator", DmAreaViewMediator, _M)

HeroEquipDressedMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
HeroEquipDressedMediator:has("_systemKeeper", {
	is = "r"
}):injectWith("SystemKeeper")

local kBtnHandlers = {}

function HeroEquipDressedMediator:initialize()
	super.initialize(self)
end

function HeroEquipDressedMediator:dispose()
	self._viewClose = true

	if self._equipListView then
		self._equipListView:dispose()

		self._equipListView = nil
	end

	super.dispose(self)
end

function HeroEquipDressedMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._bagSystem = self._developSystem:getBagSystem()
	self._heroSystem = self._developSystem:getHeroSystem()
	self._equipSystem = self._developSystem:getEquipSystem()
	self._equipBtnWidget = self:bindWidget("mainpanel.equipPanel.equipBtn", OneLevelViceButton, {
		handler = {
			ignoreClickAudio = true,
			func = bind1(self.onClickEquipBtn, self)
		}
	})

	self.mapEventListener(self, self:getEventDispatcher(), EVT_EQUIP_MOUNTING_SUCC, self, self.refreshWithData)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_EQUIP_DEMOUNT_SUCC, self, self.refreshWithData)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_EQUIP_REPLACE_SUCC, self, self.refreshWithData)
end

function HeroEquipDressedMediator:enterWithData(data)
	self:setupTopInfoWidget()
	self:initData(data)
	self:initNodes()
end

function HeroEquipDressedMediator:setupTopInfoWidget()
	local topInfoNode = self:getView():getChildByFullName("topinfo_node")
	local currencyInfoWidget = self._systemKeeper:getResourceBannerIds("Hero_Quality")
	local currencyInfo = {}

	for i = #currencyInfoWidget, 1, -1 do
		currencyInfo[#currencyInfoWidget - i + 1] = currencyInfoWidget[i]
	end

	local config = {
		style = 1,
		currencyInfo = currencyInfo,
		btnHandler = {
			clickAudio = "Se_Click_Close_1",
			func = bind1(self.onClickBack, self)
		},
		title = Strings:get("HEROS_UI26")
	}
	local injector = self:getInjector()

	self._topInfoWidget = self:autoManageObject(injector:injectInto(TopInfoWidget:new(topInfoNode)))

	self._topInfoWidget:updateView(config)
end

function HeroEquipDressedMediator:initNodes()
	self._mainPanel = self:getView():getChildByFullName("mainpanel")
	self._listNode = self._mainPanel:getChildByFullName("listNode")
	self._equipPanel = self._mainPanel:getChildByFullName("equipPanel")
	self._nodeDesc = self._equipPanel:getChildByFullName("nodeDesc")
	self._nodeAttr = self._equipPanel:getChildByFullName("nodeAttr")
	self._nodeSkill = self._equipPanel:getChildByFullName("nodeSkill")
	self._skillLock = self._equipPanel:getChildByFullName("skillLock")
	self._equipBtn = self._equipPanel:getChildByFullName("equipBtn")
	self.text1 = self._nodeAttr:getChildByFullName("text")
	self.text2 = self._nodeSkill:getChildByFullName("text")
	self.text3 = self._nodeDesc:getChildByFullName("text")

	if getCurrentLanguage() ~= GameLanguageType.CN then
		for i = 1, 2 do
			local str = self["text" .. i]:getString()

			str = string.split(str, " ")

			local width = 0

			for k, v in pairs(str) do
				if width < #v then
					width = #v
				end
			end

			width = width * 10 > 75 and 75 or width * 10

			self["text" .. i]:setContentSize(cc.size(width, 60))
		end

		self.text3:setContentSize(cc.size(400, 80))
	end

	local listViewData = {
		mediator = self,
		mainNode = self._listNode,
		data = {
			viewType = EquipsShowType.kReplace,
			params = {
				heroId = self._heroData:getId(),
				position = self._equipType,
				occupation = self._heroData:getType()
			}
		}
	}

	self._equipListView = self._heroSystem:enterEquipListView(listViewData)

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

	local animNode2 = self._nodeSkill:getChildByFullName("animNode")

	if not animNode2:getChildByFullName("BgAnim") then
		local anim = cc.MovieClip:create("fangxingkuang_jiemianchuxian")

		anim:addCallbackAtFrame(13, function()
			anim:stop()
		end)
		anim:addTo(animNode2)
		anim:setName("BgAnim")
		anim:offset(0, -4)
	end

	self._bgAnim2 = animNode2:getChildByFullName("BgAnim")

	local loadingBar = self._nodeDesc:getChildByFullName("exp.loadingBar")

	loadingBar:setScale9Enabled(true)
	loadingBar:setCapInsets(cc.rect(1, 1, 1, 1))

	local desc1 = self._nodeAttr:getChildByFullName("desc_1")
	local desc2 = self._nodeAttr:getChildByFullName("desc_2")

	GameStyle:setCommonOutlineEffect(desc1:getChildByFullName("name"))
	GameStyle:setCommonOutlineEffect(desc2:getChildByFullName("name"))
	GameStyle:setCommonOutlineEffect(desc1:getChildByFullName("text"), 142.8)
	GameStyle:setCommonOutlineEffect(desc2:getChildByFullName("text"), 142.8)

	local desc = self._nodeSkill:getChildByFullName("desc")
	local size = desc:getContentSize()
	local x, y = desc:getPosition()
	local descScrollView = ccui.ScrollView:create()

	descScrollView:setTouchEnabled(true)
	descScrollView:setBounceEnabled(true)
	descScrollView:setDirection(ccui.ScrollViewDir.vertical)
	descScrollView:setContentSize(size)
	descScrollView:setPosition(cc.p(x, y))
	descScrollView:setAnchorPoint(cc.p(0, 1))
	self._nodeSkill:addChild(descScrollView, desc:getLocalZOrder())

	self._descScrollView = descScrollView

	desc:setVisible(false)
	self._equipListView:showTableCellAni()
	self:refreshEquipInfo()
end

function HeroEquipDressedMediator:initData(data)
	self._heroId = data.heroId
	self._equipType = data.equipType
	self._heroData = self._heroSystem:getHeroById(self._heroId)
end

function HeroEquipDressedMediator:canReplace()
	if self._heroData then
		local type = self._heroData:getType()
		local heroId = self._heroData:getId()
		local typeRange = self._equipData:getOccupation()
		local occupationType = self._equipData:getOccupationType()

		if occupationType == nil or occupationType == 0 then
			if table.indexof(typeRange, type) then
				return true
			end
		elseif occupationType == 1 and table.indexof(typeRange, heroId) then
			return true
		end
	end

	return false
end

function HeroEquipDressedMediator:canEquip()
	local ownerId = self._equipData:getHeroId()

	return ownerId ~= self._heroId
end

function HeroEquipDressedMediator:refreshEquipInfo()
	self._selectEquipId = self._equipListView:getSelectEquipId()

	if self._selectEquipId == "" then
		return
	end

	self._equipData = self._equipSystem:getEquipById(self._selectEquipId)

	self._equipBtn:setVisible(self:canReplace())

	if self._equipBtn:isVisible() then
		local canEquip = self:canEquip()

		if canEquip then
			local var_12_0 = Strings:get("Equip_Text1")

			if not var_12_0 then
				var_12_0 = Strings:get("Equip_UI22")

				local name = var_12_0

				if canEquip then
					local var_12_1 = Strings:get("UIEQUIP_EN_Zhuangbei")

					if not var_12_1 then
						var_12_1 = Strings:get("UIEQUIP_EN_Xiexia")

						local name1 = var_12_1

						self._equipBtnWidget:setButtonName(name, name1)
					end
				end
			end
		end
	end

	self:refreshDesc()
	self:refreshAttr()
	self:refreshSkill()
	self:showInfoAni()
end

function HeroEquipDressedMediator:refreshDesc()
	local isMaxLevel = self._equipData:isMaxLevel()
	local name = self._equipData:getName()
	local rarity = self._equipData:getRarity()
	local level = self._equipData:getLevel()
	local levelMax = self._equipData:getMaxLevel()
	local star = self._equipData:getStar()
	local curExp = self._equipData:getExp()
	local targetExp = self._equipData:getLevelNextExp()
	local equipOccu = self._equipData:getOccupation()
	local occupationDesc = self._equipData:getOccupationDesc()
	local occupationType = self._equipData:getOccupationType()
	local node = self._nodeDesc:getChildByFullName("node")

	node:removeAllChildren()

	local param = {
		id = self._equipData:getEquipId(),
		level = level,
		star = star,
		rarity = rarity
	}
	local equipIcon = IconFactory:createEquipIcon(param)

	equipIcon:addTo(node):center(node:getContentSize())
	equipIcon:setScale(0.74)

	local nameLabel = self._nodeDesc:getChildByFullName("name")

	nameLabel:setString(name)

	local levelLabel = self._nodeDesc:getChildByFullName("level")

	levelLabel:setString(Strings:get("Strenghten_Text78", {
		level = level .. "/" .. levelMax
	}))
	levelLabel:setPositionX(nameLabel:getPositionX() + nameLabel:getContentSize().width + 5)

	local loadingBar = self._nodeDesc:getChildByFullName("exp.loadingBar")

	if isMaxLevel then
		loadingBar:setPercent(100)
	end

	local limitDesc = self._nodeDesc:getChildByFullName("text")
	local limitNode = self._nodeDesc:getChildByFullName("limit")

	limitNode:removeAllChildren()

	if occupationDesc ~= "" then
		limitDesc:setString(Strings:get("Equip_UI24") .. " " .. Strings:get(occupationDesc))
	else
		limitDesc:setString(Strings:get("Equip_UI24"))

		if occupationType == nil or occupationType == 0 then
			if equipOccu then
				for i = 1, #equipOccu do
					local occupationName, occupationIcon = GameStyle:getHeroOccupation(equipOccu[i])
					local image = ccui.ImageView:create(occupationIcon)

					image:setAnchorPoint(cc.p(0, 0.5))
					image:setPosition(cc.p(40 * (i - 1), 0))
					image:setScale(0.5)
					image:addTo(limitNode)
				end
			end
		elseif occupationType == 1 and equipOccu then
			for i = 1, #equipOccu do
				local heroInfo = {
					id = IconFactory:getRoleModelByKey("HeroBase", equipOccu[i])
				}
				local headImgName = IconFactory:createRoleIconSpriteNew(heroInfo)

				headImgName:setScale(0.2)

				headImgName = IconFactory:addStencilForIcon(headImgName, 2, cc.size(31, 31))

				headImgName:setAnchorPoint(cc.p(0, 0.5))
				headImgName:setPosition(cc.p(40 * (i - 1), 0))
				headImgName:addTo(limitNode)
			end
		end
	end

	limitNode:setPositionX(limitDesc:getPositionX() + limitDesc:getContentSize().width)
end

function HeroEquipDressedMediator:refreshAttr()
	local attrList = self._equipData:getAttrListShow()

	for i = 1, 2 do
		local attrPanel = self._nodeAttr:getChildByFullName("desc_" .. i)

		attrPanel:setVisible(false)

		if attrList[i] then
			attrPanel:setVisible(true)

			local attrType = attrList[i].attrType
			local attrNum = attrList[i].attrNum
			local attrImage = attrPanel:getChildByFullName("image")

			attrImage:loadTexture(AttrTypeImage[attrType], 1)

			local attrText = attrPanel:getChildByFullName("text")

			attrText:setString(attrNum)

			if AttributeCategory:getAttNameAttend(attrType) ~= "" then
				attrText:setString(attrNum * 100 .. "%")
			end

			local name = attrPanel:getChildByFullName("name")

			name:setString(AttributeCategory:getAttName(attrType))
		end
	end
end

function HeroEquipDressedMediator:refreshSkill()
	local skillNameBg = self._nodeSkill:getChildByFullName("nameBg")
	local skillName = self._nodeSkill:getChildByFullName("name")
	local skillLevel = self._nodeSkill:getChildByFullName("level")
	local skillLock = self._nodeSkill:getChildByFullName("skillLock")
	local skillDesc = self._descScrollView
	local equipData = self._equipData
	local isHaveSkill = equipData:isHaveSkill()

	skillNameBg:setVisible(isHaveSkill)
	skillName:setVisible(isHaveSkill)
	skillLevel:setVisible(isHaveSkill)
	skillDesc:setVisible(isHaveSkill)
	skillLock:setVisible(not isHaveSkill)

	local skillAttr = equipData:getSkill()

	if isHaveSkill and skillAttr then
		local name = skillAttr:getName()
		local level = skillAttr:getLevel()

		skillName:setString(name)
		skillNameBg:setScaleX((skillName:getContentSize().width + 29) / skillNameBg:getContentSize().width)

		local width = skillDesc:getContentSize().width
		local height = skillDesc:getContentSize().height

		skillDesc:removeAllChildren()

		local desc = skillAttr:getSkillDesc()

		if level == 0 then
			desc = skillAttr:getSkillDesc({
				fontColor = "#7B7474"
			})

			local unlockLevel = equipData:getUnLockSkillLevel()
			local tip = Strings:get("Equip_UI47") .. Strings:get("Strenghten_Text78", {
				level = unlockLevel
			}) .. Strings:get("Equip_UI48")

			skillLevel:setString(tip)
			skillLevel:setColor(cc.c3b(147, 147, 147))
		else
			skillLevel:setColor(cc.c3b(255, 255, 255))

			if equipData:isSkillMaxLevel() then
				skillLevel:setString(Strings:get("Strenghten_Text79"))
			else
				skillLevel:setString(Strings:get("Strenghten_Text78", {
					level = level
				}))
			end
		end

		skillLevel:setPositionX(skillName:getPositionX() + skillName:getContentSize().width + 20)

		local label = ccui.RichText:createWithXML(desc, {})

		label:renderContent(width, 0)
		label:setAnchorPoint(cc.p(0, 1))
		label:addTo(skillDesc)
		label:setPosition(cc.p(0, height))

		local descScrollView = skillDesc
		local size = skillDesc:getContentSize()

		size.height = label:getContentSize().height

		if size.height > descScrollView:getContentSize().height then
			descScrollView:setTouchEnabled(true)
		else
			size = descScrollView:getContentSize()

			descScrollView:setTouchEnabled(false)
		end

		descScrollView:setInnerContainerSize(size)
		label:setPositionY(size.height)
	end
end

function HeroEquipDressedMediator:refreshWithData()
	self:dismiss()
end

function HeroEquipDressedMediator:onClickBack()
	self:dismiss()
end

function HeroEquipDressedMediator:onClickEquipBtn()
	local params = {
		heroId = self._heroId,
		equipId = self._selectEquipId
	}
	local ownerId = self._equipData:getHeroId()

	if self:canEquip() then
		if ownerId ~= "" then
			AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

			local data = {
				title = Strings:get("SHOP_REFRESH_DESC_TEXT1"),
				content = Strings:get("Equip_UI23"),
				sureBtn = {},
				cancelBtn = {}
			}
			local outSelf, delegate = self, {}

			function delegate:willClose(popupMediator, data)
				if data.response == "ok" then
					outSelf._equipSystem:requestEquipReplace(params)
				elseif data.response == "cancel" then
					-- block empty
				elseif data.response == "close" then
					-- block empty
				end
			end

			local view = self:getInjector():getInstance("AlertView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
			}, data, delegate))
		else
			self._equipSystem:requestEquipMounting(params)
		end
	else
		AudioEngine:getInstance():playEffect("Se_Click_Takeoff", false)
		self._equipSystem:requestEquipDemount(params)
	end
end

function HeroEquipDressedMediator:onClickEquipCell()
	local cellEquipId = self._equipListView:getSelectEquipId()

	if self._cellEquipId == cellEquipId then
		return
	end

	self._cellEquipId = cellEquipId

	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
	self:refreshEquipInfo()
end

function HeroEquipDressedMediator:showInfoAni()
	self._bgAnim1:gotoAndPlay(1)
	self._bgAnim2:gotoAndPlay(1)

	local node = self._nodeDesc:getChildByFullName("node")

	node:stopAllActions()
	node:setScale(1)
	node:setOpacity(255)
	self._equipBtn:setScale(1)
	self._equipBtn:setOpacity(255)
	self._equipBtn:stopAllActions()
	self._equipSystem:runIconShowAction(node, 1)
	self._equipSystem:runIconShowAction(self._equipBtn, 5)

	local pancel1 = self._nodeAttr:getChildByFullName("Image_125")

	pancel1:setOpacity(0)
	pancel1:setScaleX(0.4)
	pancel1:runAction(cc.FadeIn:create(0.3))
	pancel1:runAction(cc.Sequence:create({
		cc.ScaleTo:create(0.2, 1.05, 1),
		cc.ScaleTo:create(0.1, 1, 1)
	}))

	for i = 1, 2 do
		local attrPanel = self._nodeAttr:getChildByFullName("desc_" .. i)

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
	end

	local pancel2 = self._nodeSkill:getChildByFullName("Image_125_0")

	pancel2:setOpacity(0)
	pancel2:setScaleX(0.4)
	pancel2:runAction(cc.FadeIn:create(0.3))
	pancel2:runAction(cc.Sequence:create({
		cc.ScaleTo:create(0.2, 1.05, 1),
		cc.ScaleTo:create(0.1, 1, 1)
	}))

	local skillNameBg = self._nodeSkill:getChildByFullName("nameBg")

	skillNameBg:setOpacity(0)
	skillNameBg:runAction(cc.Sequence:create({
		cc.DelayTime:create(0.3),
		cc.FadeIn:create(0.15)
	}))

	local skillName = self._nodeSkill:getChildByFullName("name")

	skillName:setOpacity(0)
	skillName:runAction(cc.Sequence:create({
		cc.DelayTime:create(0.3),
		cc.FadeIn:create(0.15)
	}))

	local skillLevel = self._nodeSkill:getChildByFullName("level")

	skillLevel:setOpacity(0)
	skillLevel:runAction(cc.Sequence:create({
		cc.DelayTime:create(0.3),
		cc.FadeIn:create(0.15)
	}))

	local skillDesc = self._nodeSkill:getChildByFullName("desc")

	skillDesc:setOpacity(0)
	skillDesc:runAction(cc.Sequence:create({
		cc.DelayTime:create(0.4),
		cc.FadeIn:create(0.15)
	}))
end
