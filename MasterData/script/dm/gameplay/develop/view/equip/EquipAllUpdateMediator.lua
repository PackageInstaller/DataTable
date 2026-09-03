-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/equip/EquipAllUpdateMediator.lua

EquipAllUpdateMediator = class("EquipAllUpdateMediator", DmAreaViewMediator)

EquipAllUpdateMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local HeroEquipSkillLevel = ConfigReader:getDataByNameIdAndKey("ConfigValue", "HeroEquipSkillLevel", "content")
local kBtnHandlers = {
	["btnPanel.left.button"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickLeft"
	},
	["btnPanel.right.button"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickRight"
	}
}

function EquipAllUpdateMediator:initialize()
	super.initialize(self)
end

function EquipAllUpdateMediator:dispose()
	self:closeProgrScheduler()
	super.dispose(self)
end

function EquipAllUpdateMediator:userInject()
	self._heroSystem = self._developSystem:getHeroSystem()
	self._equipSystem = self._developSystem:getEquipSystem()
	self._bagSystem = self._developSystem:getBagSystem()
end

function EquipAllUpdateMediator:onRegister()
	super.onRegister(self)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_EQUIP_LEVELUP_SUCC, self, self.onStrengthenSuccCallback)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_EQUIP_STARUP_SUCC, self, self.onStarUpSuccCallback)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._strengthenSucc = self:getView():getChildByName("strengthenSucc")

	self._strengthenSucc:setVisible(false)

	self._main = self:getView():getChildByName("main")
	self._nodeDesc = self._main:getChildByFullName("nodeDesc")
	self._nodeAttr = self._main:getChildByName("nodeAttr")
	self._nodeSkill = self._main:getChildByName("nodeSkill")

	if getCurrentLanguage() ~= GameLanguageType.CN then
		local img = self._nodeSkill:getChildByFullName("Image_125")

		img:setContentSize(cc.size(643.89, 110))
		img:setPositionY(-7)
	end

	self._itemPanel = self._main:getChildByName("itemPanel")
	self._btnPanel = self:getView():getChildByName("btnPanel")

	self._btnPanel:setVisible(false)

	self._starPanel = self._main:getChildByName("starPanel")
	self._allMaxNode = self._main:getChildByName("allMaxNode")

	self._allMaxNode:setVisible(false)

	self._strengthenBtn = self._itemPanel:getChildByName("strengthenBtn")
	self._strengthenTenBtn = self._itemPanel:getChildByName("strengthenTenBtn")
	self._strengthenWidget = self:bindWidget("main.itemPanel.strengthenBtn", OneLevelViceButton, {
		handler = {
			ignoreClickAudio = true,
			func = bind1(self.onClickStrengthen, self)
		},
		btnSize = {
			width = 222,
			height = 108
		}
	})
	self._strengthenTenWidget = self:bindWidget("main.itemPanel.strengthenTenBtn", OneLevelViceButton, {
		handler = {
			ignoreClickAudio = true,
			func = bind1(self.onClickStrengthenTen, self)
		},
		btnSize = {
			width = 222,
			height = 108
		}
	})
	self._starUpWidget = self:bindWidget("main.starPanel.starUpBtn", OneLevelViceButton, {
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

	local animNode1 = self._nodeSkill:getChildByFullName("animNode")

	if not animNode1:getChildByFullName("BgAnim") then
		local anim = cc.MovieClip:create("fangxingkuang_jiemianchuxian")

		anim:addCallbackAtFrame(13, function()
			anim:stop()
		end)
		anim:addTo(animNode1)
		anim:setName("BgAnim")
		anim:offset(0, -3)
	end

	self._bgAnim2 = animNode1:getChildByFullName("BgAnim")

	local goldCost = self._itemPanel:getChildByFullName("goldCost")
	local panel = goldCost:getChildByFullName("costBg")
	local addImg = panel:getChildByFullName("addImg")

	addImg:getChildByFullName("touchPanel"):addClickEventListener(function()
		CurrencySystem:buyCurrencyByType(self, CurrencyType.kGold)
	end)

	local itemCost = self._starPanel:getChildByFullName("itemCost")
	local panel = itemCost:getChildByFullName("costBg")
	local addImg = panel:getChildByFullName("addImg")

	addImg:getChildByFullName("touchPanel"):addClickEventListener(function()
		self:onClickItem()
	end)

	local equipCost = self._starPanel:getChildByFullName("equipCost")
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

	local desc1 = self._nodeAttr:getChildByFullName("desc_1")
	local desc2 = self._nodeAttr:getChildByFullName("desc_2")

	GameStyle:setCommonOutlineEffect(desc1:getChildByFullName("name"), 219.29999999999998)
	GameStyle:setCommonOutlineEffect(desc2:getChildByFullName("name"), 219.29999999999998)
	GameStyle:setCommonOutlineEffect(desc1:getChildByFullName("text"), 142.8)
	GameStyle:setCommonOutlineEffect(desc2:getChildByFullName("text"), 142.8)
	GameStyle:setCostNodeEffect(self._itemPanel:getChildByFullName("goldCost"))

	local leftBtn = self:getView():getChildByFullName("btnPanel.left.leftBtn")
	local rightBtn = self:getView():getChildByFullName("btnPanel.right.rightBtn")

	CommonUtils.runActionEffect(leftBtn, "Node_1.leftBtn", "LeftRightArrowEffect", "anim1", true)
	CommonUtils.runActionEffect(rightBtn, "Node_2.rightBtn", "LeftRightArrowEffect", "anim1", true)

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
end

function EquipAllUpdateMediator:setupView(data)
	self:initData(data)
end

function EquipAllUpdateMediator:initData(data)
	self._addExp = 0
	self._oldSkillLevel = 0
	self._equipId = data.equipId
	self._mediator = data.mediator
	self._addAnimData = {}
	self._addAnimData.oldArr = {}
	self._addAnimData.newArr = {}
	self._addAnimData.curArr = {}
	self._allHeroEquips = {}
	self._currentHeroEquipsIndex = 0
	self._equipData = self._equipSystem:getEquipById(self._equipId)

	if self._equipData then
		local heroId = self._equipData:getHeroId()

		if heroId ~= nil and heroId ~= "" then
			self._heroData = self._heroSystem:getHeroById(heroId)

			for k, v in pairs(self._heroData:getEquipIds()) do
				self._allHeroEquips[#self._allHeroEquips + 1] = v

				if self._equipId == v then
					self._currentHeroEquipsIndex = #self._allHeroEquips
				end
			end
		end
	end

	self._oldLevel = self._equipData:getLevel()
	self._preLevel = self._oldLevel + 1
end

function EquipAllUpdateMediator:refreshData()
	self._equipData = self._equipSystem:getEquipById(self._equipId)
	self._preLevel = self._equipData:getLevel() + 1
end

function EquipAllUpdateMediator:runBtnAnim()
	if self._equipData and self._heroData and #self._allHeroEquips > 1 then
		self._btnPanel:setVisible(true)
	else
		return
	end
end

function EquipAllUpdateMediator:refreshView()
	self:runBtnAnim()
	self:refreshData()
	self:refreshEquipBaseInfo()
	self:refreshEquipInfo()
end

function EquipAllUpdateMediator:refreshEquipByClick()
	self:refreshData()
	self:refreshEquipInfo()
end

function EquipAllUpdateMediator:refreshEquipBaseInfo()
	local name = self._equipData:getName()
	local rarity = self._equipData:getRarity()
	local level = self._equipData:getLevel()
	local star = self._equipData:getStar()
	local levelMax = self._equipData:getMaxLevel()
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
	equipIcon:setScale(0.84)

	local nameLabel = self._nodeDesc:getChildByFullName("name")

	nameLabel:setString(name)

	local levelLabel = self._nodeDesc:getChildByFullName("level")

	levelLabel:setString(Strings:get("Strenghten_Text78", {
		level = level .. "/" .. levelMax
	}))

	local starNode = self._nodeDesc:getChildByFullName("starNode")

	self:createStarNode(starNode, star)

	local limitDesc = self._nodeDesc:getChildByFullName("text")
	local limitNode = self._nodeDesc:getChildByFullName("limitNode")

	limitNode:removeAllChildren()

	if occupationDesc ~= "" then
		limitDesc:setVisible(true)
	else
		limitDesc:setVisible(false)

		if occupationType == nil or occupationType == 0 then
			if equipOccu then
				for i = 1, #equipOccu do
					local occupationName, occupationIcon = GameStyle:getHeroOccupation(equipOccu[i])
					local image = ccui.ImageView:create(occupationIcon)

					image:setAnchorPoint(cc.p(0.5, 0.5))
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

				headImgName:setAnchorPoint(cc.p(0.5, 0.5))
				headImgName:setPosition(cc.p(40 * (i - 1), 0))
				headImgName:addTo(limitNode)
			end
		end
	end
end

function EquipAllUpdateMediator:refreshEquipInfo()
	self:refreshItems()
	self:refreshExp()
	self:refreshAttr()
	self:refreshSkill()
	self:refreshStar()
end

function EquipAllUpdateMediator:refreshExp()
	local level = self._equipData:getLevel()
	local levelMax = self._equipData:getMaxLevel()
	local previewNode = self._nodeDesc:getChildByFullName("previewNode")
	local levelLabel = self._nodeDesc:getChildByFullName("level")

	levelLabel:setString(Strings:get("Strenghten_Text78", {
		level = level .. "/" .. levelMax
	}))
	previewNode:setVisible(false)
end

function EquipAllUpdateMediator:refreshAttr()
	local attrList = self._equipData:getAttrListShow()
	local attrPreMap = self._equipData:getAttrPreListByLevel(self._preLevel)

	for i = 1, 2 do
		local attrPanel = self._nodeAttr:getChildByFullName("desc_" .. i)

		attrPanel:setVisible(false)

		if attrList[i] then
			attrPanel:setVisible(true)

			local attrType = attrList[i].attrType
			local attrNum = attrList[i].attrNum
			local attrName = AttributeCategory:getAttName(attrType)
			local attrTypeImage = AttrTypeImage[attrType]
			local attrImage = attrPanel:getChildByFullName("image")

			attrImage:loadTexture(attrTypeImage, 1)

			local name = attrPanel:getChildByFullName("name")

			name:setString(attrName)
			name:setPositionX(30)

			local image = attrPanel:getChildByFullName("image")

			image:setVisible(true)

			local attrText = attrPanel:getChildByFullName("text")

			attrText:setPositionX(171)

			if self._addAnimData.oldArr[i] == nil then
				self._addAnimData.oldArr[i] = attrList[i].attrNum
				self._addAnimData.curArr[i] = attrList[i].attrNum

				attrText:setString(attrNum)
			else
				self._addAnimData.newArr[i] = attrList[i].attrNum

				if self:checkAndDoLabelAnim(attrType) then
					self:createProgrScheduler()
				else
					self:createProgrScheduler()
					attrText:setString(attrNum)
				end
			end

			if AttributeCategory:getAttNameAttend(attrType) ~= "" then
				attrText:setString(attrNum * 100 .. "%")
			end

			local extendText = attrPanel:getChildByFullName("extendText")

			extendText:setVisible(true)

			if attrPreMap[attrType] then
				local preAttrNum = attrPreMap[attrType].attrNum
				local addAttrNum = preAttrNum - attrNum

				if addAttrNum > 0 then
					extendText:setString("+" .. addAttrNum)

					if AttributeCategory:getAttNameAttend(attrType) ~= "" then
						extendText:setString("+" .. addAttrNum * 100 .. "%")
					end
				end
			else
				extendText:setString("")
			end
		end
	end
end

function EquipAllUpdateMediator:refreshSkill()
	local skill = self._equipData:getSkill()

	if skill then
		self._nodeSkill:setVisible(true)

		local skillName = self._nodeSkill:getChildByFullName("name")
		local skillNameBg = self._nodeSkill:getChildByFullName("nameBg")
		local skillLevel = self._nodeSkill:getChildByFullName("level")
		local skillDesc = self._descScrollView

		skillDesc:removeAllChildren()

		local style = {
			fontSize = 20
		}
		local name = skill:getName()
		local level = skill:getLevel()
		local desc = skill:getSkillDesc(style)

		skillName:setString(name)
		skillLevel:setString(Strings:get("Strenghten_Text78", {
			level = level
		}))
		skillNameBg:setContentSize(cc.size(skillName:getContentSize().width + 25, 50))

		local canSkillUp = self._equipData:canSkillUp()
		local skillTip = self._nodeSkill:getChildByFullName("skillTip")
		local levelTip = skillTip:getChildByFullName("levelTip")
		local text = skillTip:getChildByFullName("text")

		skillTip:setString(Strings:get("Equip_UI36"))
		levelTip:setVisible(not self._equipData:isSkillMaxLevel())
		text:setVisible(not self._equipData:isSkillMaxLevel())

		if self._equipData:isSkillMaxLevel() then
			skillTip:setString(Strings:get("Strenghten_Text78", {
				level = "Max"
			}))
		else
			desc = skill:getSkillDesc(style, level + 1)

			skillTip:setString(Strings:get("Equip_UI47"))

			local equipLevel = self._equipData:getLevel()
			local upLevel = equipLevel
			local skillUpLV = HeroEquipSkillLevel
			local URUPSkillLV = ConfigReader:getDataByNameIdAndKey("HeroEquipBase", self._equipData:getEquipId(), "URUPSkillLV")

			if URUPSkillLV then
				skillUpLV = URUPSkillLV
			end

			for i = 1, #skillUpLV do
				upLevel = math.max(upLevel, skillUpLV[i])

				if upLevel ~= equipLevel then
					break
				end
			end

			levelTip:setString(Strings:get("Strenghten_Text78", {
				level = upLevel
			}))

			if canSkillUp then
				text:setString(Strings:get("Equip_UI49"))
			else
				text:setString(Strings:get("Equip_UI48"))
			end

			local tipWidth = skillTip:getContentSize().width

			levelTip:setPositionX(tipWidth + 2)
			text:setPositionX(tipWidth + levelTip:getContentSize().width + 4)

			local color = level == 0 and cc.c3b(195, 195, 195) or cc.c3b(255, 255, 255)

			skillTip:setColor(color)
			levelTip:setColor(color)
			text:setColor(color)
		end

		if level == 0 then
			skillLevel:setVisible(false)
			skillTip:setPositionX(skillNameBg:getPositionX() + skillNameBg:getContentSize().width + 10)
		else
			skillLevel:setVisible(true)
			skillLevel:setPositionX(skillNameBg:getPositionX() + skillNameBg:getContentSize().width + 10)
			skillTip:setPositionX(skillLevel:getPositionX() + skillLevel:getContentSize().width + 10)
		end

		local width = skillDesc:getContentSize().width
		local height = skillDesc:getContentSize().height
		local label = ccui.RichText:createWithXML(desc, {})

		label:renderContent(width, 0)
		label:setAnchorPoint(cc.p(0, 1))
		label:setPosition(cc.p(0, height))
		label:addTo(skillDesc)

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
	else
		self._nodeSkill:setVisible(false)
	end
end

function EquipAllUpdateMediator:refreshItems()
	if self._equipData:isMaxLevel() then
		self._itemPanel:setVisible(false)

		return
	end

	self._itemPanel:setVisible(true)

	local goldCost = self._itemPanel:getChildByFullName("goldCost")
	local ownCount = CurrencySystem:getCurrencyCount(self, CurrencyIdKind.kGold)
	local needCount = self._equipData:getLevelGold()

	self._goldEnough = needCount <= ownCount

	local panel = goldCost:getChildByFullName("costBg")
	local iconpanel = panel:getChildByFullName("iconpanel")

	iconpanel:removeAllChildren()

	local icon = IconFactory:createPic({
		scaleRatio = 0.7,
		id = CurrencyIdKind.kGold
	}, {
		largeIcon = true
	})

	icon:addTo(iconpanel):center(iconpanel:getContentSize())

	local enoughImg = panel:getChildByFullName("bg.enoughImg")
	local cost = panel:getChildByFullName("cost")

	cost:setVisible(true)
	cost:setString(needCount)

	local colorNum1 = self._goldEnough and 1 or 7

	cost:setTextColor(GameStyle:getColor(colorNum1))
	enoughImg:setVisible(self._goldEnough)

	local addImg = panel:getChildByFullName("addImg")

	addImg:setVisible(not self._goldEnough)
	icon:setGray(not self._goldEnough)

	if self._equipData:isMaxStar() then
		self._starPanel:setVisible(false)
	else
		self:refreshItemCost()
		self:refreshEquipCost()
	end
end

function EquipAllUpdateMediator:refreshItemCost()
	local itemData = self._equipData:getStarItem()[1]
	local itemCost = self._starPanel:getChildByFullName("itemCost")
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

	self._itemEnough = needNum <= hasNum

	local colorNum1 = self._itemEnough and 1 or 7
	local enoughImg = panel:getChildByFullName("bg.enoughImg")

	enoughImg:setVisible(self._itemEnough)

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

	local addImg = panel:getChildByFullName("addImg.Image_1")

	addImg:setVisible(not self._itemEnough)
	iconpanel:setGray(not self._itemEnough)
end

function EquipAllUpdateMediator:refreshEquipCost()
	local tipdesc = self._starPanel:getChildByFullName("tipdesc")

	tipdesc:setString(Strings:get("Equip_lvup_tip"))
	tipdesc:setVisible(false)

	local needCostControl = self._equipData:getEquipNeedControl()

	if needCostControl == 1 then
		local commonItemId = self._equipData:getCommonItemId()
		local needNum = self._equipData:getEquipItemNum()

		if self._equipData:getRarity() == 15 then
			local pos = self._bagSystem:getComposePos(commonItemId)

			if pos then
				local equipCost = self._starPanel:getChildByFullName("equipCost")
				local panel = equipCost:getChildByFullName("costBg")
				local iconpanel = panel:getChildByFullName("iconpanel")

				iconpanel:removeAllChildren()

				local hasNum = self._equipSystem:getEquipStarUpItem().stiveNum

				self._equipEnough = needNum <= hasNum

				local debrisIcon = ccui.ImageView:create((self._equipEnough or nil) and composePosImage_icon[pos][2], 1)

				debrisIcon:addTo(iconpanel):center(iconpanel:getContentSize())

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

				local addImg = panel:getChildByFullName("addImg.Image_1")

				addImg:setVisible(not self._equipEnough)
				iconpanel:setGray(not self._equipEnough)
				equipCost:setVisible(needNum > 0)

				return
			end
		end

		if needNum > 0 then
			local equipCost = self._starPanel:getChildByFullName("equipCost")
			local panel = equipCost:getChildByFullName("costBg")
			local iconpanel = panel:getChildByFullName("iconpanel")

			iconpanel:removeAllChildren()

			local icon = IconFactory:createPic({
				scaleRatio = 0.7,
				id = commonItemId
			}, {
				largeIcon = true
			})

			icon:addTo(iconpanel):center(iconpanel:getContentSize())

			local hasNum = CurrencySystem:getCurrencyCount(self, commonItemId)

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

			local addImg = panel:getChildByFullName("addImg.Image_1")

			addImg:setVisible(not self._equipEnough)
			iconpanel:setGray(not self._equipEnough)
		end

		return
	end

	local needNum = self._equipData:getEquipItemNum()

	if needNum > 0 then
		local equipCost = self._starPanel:getChildByFullName("equipCost")
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

		local addImg = panel:getChildByFullName("addImg.Image_1")

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
		tipdesc:setVisible(true)

		local equipCost = self._starPanel:getChildByFullName("equipCost")
		local panel = equipCost:getChildByFullName("costBg")
		local iconpanel = panel:getChildByFullName("iconpanel")

		iconpanel:removeAllChildren()

		local debrisIcon = ccui.ImageView:create("yinghun_img_weapon_icon.png", 1)

		debrisIcon:addTo(iconpanel):center(iconpanel:getContentSize())

		local hasNum = self._equipSystem:getEquipStarUpItem().stiveNum

		if hasNum == 0 then
			hasNum = self._equipData:getOverflowStarExp()
		end

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

		local addImg = panel:getChildByFullName("addImg.Image_1")

		addImg:setVisible(not self._equipEnough)
		iconpanel:setGray(not self._equipEnough)
		equipCost:setVisible(needNum > 0)

		return
	end

	assert(false, "装备突破配置错误 HeroEquipStar-id=" .. self._equipData:getStarId())
end

function EquipAllUpdateMediator:refreshStar()
	local previewNode = self._nodeDesc:getChildByFullName("previewNode")
	local preDes = self._nodeAttr:getChildByFullName("preDesc_1")

	self._allMaxNode:setVisible(false)

	if self._equipData:isStarMaxExp() and self._equipData:isMaxLevel() then
		self._allMaxNode:setVisible(true)
		self._starPanel:setVisible(false)
		self._itemPanel:setVisible(false)
		previewNode:setVisible(false)
		preDes:setVisible(false)

		return
	end

	if self._equipData:isStarMaxExp() == false then
		previewNode:setVisible(false)
		self._starPanel:setVisible(false)
		self._itemPanel:setVisible(true)
		preDes:setVisible(false)

		return
	end

	self._starPanel:setVisible(true)
	previewNode:setVisible(true)
	self._itemPanel:setVisible(false)
	self:setProgrViewToAll()

	local level = self._equipData:getLevel()
	local levelMax = self._equipData:getMaxLevel()
	local starPreData = self._equipData:getStarPreData()
	local previewNode = self._nodeDesc:getChildByFullName("previewNode")
	local desc1 = self._nodeAttr:getChildByFullName("desc_1")

	desc1:getChildByName("text"):setString(Strings:get("Equip_UI41", {
		level = level .. "/" .. levelMax
	}))
	desc1:getChildByName("text"):setPositionX(205)
	desc1:getChildByName("extendText"):setVisible(false)
	desc1:getChildByName("name"):setPositionX(10)
	desc1:getChildByName("name"):setString(Strings:get("Equip_UI46"))
	desc1:getChildByName("image"):setVisible(false)

	local desc2 = self._nodeAttr:getChildByFullName("desc_2")

	desc2:setVisible(false)

	local preDesc = self._nodeAttr:getChildByFullName("preDesc_1")

	if starPreData then
		previewNode:setVisible(true)
		preDesc:setVisible(true)

		local starPre = starPreData.star
		local maxLevel = starPreData.maxLevel
		local text1 = preDesc:getChildByName("text_1")

		text1:setString(maxLevel)

		local text2 = preDesc:getChildByName("text_2")

		text2:setString(Strings:get("Equip_UI41", {
			level = level .. "/"
		}))
		text2:setPositionX(text1:getPositionX() - text1:getContentSize().width)

		local levelLable = previewNode:getChildByName("level")

		levelLable:setString(level)

		local maxLevelLable = previewNode:getChildByName("maxLevel")

		maxLevelLable:setString("/" .. maxLevel)

		local starNode = previewNode:getChildByFullName("starNode")

		self:createStarNode(starNode, starPre)
	else
		preDesc:setVisible(false)
		previewNode:setVisible(false)
	end
end

function EquipAllUpdateMediator:onStrengthenSuccCallback(event)
	local level = self._equipData:getLevel()
	local skill = self._equipData:getSkill()
	local showUpAnim = false
	local skillUpLV = HeroEquipSkillLevel
	local URUPSkillLV = ConfigReader:getDataByNameIdAndKey("HeroEquipBase", self._equipData:getEquipId(), "URUPSkillLV")

	if URUPSkillLV then
		skillUpLV = URUPSkillLV
	end

	for i = 1, #skillUpLV do
		if self._oldLevel < skillUpLV[i] and level >= skillUpLV[i] then
			showUpAnim = true

			break
		end
	end

	self._oldLevel = level

	if showUpAnim and skill then
		local view = self:getInjector():getInstance("EquipSkillUpView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			maskOpacity = 0
		}, {
			equipId = self._equipId,
			oldSkillLevel = self._oldSkillLevel
		}))
	else
		AudioEngine:getInstance():playRoleEffect("Se_Alert_Equip_Powerup", false)
		self._strengthenSucc:setVisible(true)
		performWithDelay(self:getView(), function()
			if DisposableObject:isDisposed(self) then
				return
			end

			self._strengthenSucc:setVisible(false)
		end, 1)
	end
end

function EquipAllUpdateMediator:runStartAction()
	self:showInfoAni()
	self._main:stopAllActions()

	local action = cc.CSLoader:createTimeline("asset/ui/EquipAllUpdate.csb")

	self._main:runAction(action)
	action:clearFrameEventCallFunc()
	action:gotoFrameAndPlay(0, 51, false)
	action:setTimeSpeed(2)

	local costNode1 = self._itemPanel:getChildByFullName("goldCost")

	costNode1:setOpacity(0)

	local costNode2 = self._starPanel:getChildByFullName("equipCost")

	costNode2:setOpacity(0)

	local costNode3 = self._starPanel:getChildByFullName("itemCost")

	costNode3:setOpacity(0)

	local function onFrameEvent(frame)
		if frame == nil then
			return
		end

		local str = frame:getEvent()

		if str == "CostAnim1" then
			costNode1:setOpacity(255)
			GameStyle:runCostAnim(costNode1)
			costNode2:setOpacity(255)
			GameStyle:runCostAnim(costNode2)
		end

		if str == "CostAnim2" then
			costNode3:setOpacity(255)
			GameStyle:runCostAnim(costNode3)
		end

		if str == "EndAnim" then
			-- block empty
		end
	end

	action:setFrameEventCallFunc(onFrameEvent)
end

function EquipAllUpdateMediator:showInfoAni()
	self._bgAnim1:gotoAndPlay(1)
	self._bgAnim2:gotoAndPlay(1)
	self._strengthenBtn:stopAllActions()
	self._strengthenBtn:setScale(1)
	self._strengthenBtn:setOpacity(255)
	self._strengthenTenBtn:stopAllActions()
	self._strengthenTenBtn:setScale(1)
	self._strengthenTenBtn:setOpacity(255)

	local node = self._nodeDesc:getChildByFullName("node")

	node:setScale(1)
	node:setOpacity(255)
	node:stopAllActions()
	self._equipSystem:runIconShowAction(node, 1)
	self._equipSystem:runIconShowAction(self._strengthenBtn, 4)
	self._equipSystem:runIconShowAction(self._strengthenTenBtn, 5)

	local pancel1 = self._nodeAttr:getChildByFullName("Image_125")

	pancel1:setOpacity(0)
	pancel1:setScaleX(0.4)
	pancel1:runAction(cc.FadeIn:create(0.3))
	pancel1:runAction(cc.Sequence:create({
		cc.ScaleTo:create(0.2, 1.05, 1),
		cc.ScaleTo:create(0.1, 1, 1)
	}))

	local pancel1 = self._nodeSkill:getChildByFullName("Image_125")

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

function EquipAllUpdateMediator:onStarUpSuccCallback(event)
	local view = self:getInjector():getInstance("EquipStarUpView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		maskOpacity = 0
	}, {
		equipId = self._equipId,
		oldMaxLevel = self._oldMaxLevel,
		oldAttrList = self._oldAttrList
	}))
	self:refreshEquipInfo()
end

function EquipAllUpdateMediator:createStarNode(starNode, star)
	starNode:removeAllChildren()

	local index = 0
	local posXOffset

	for i = 1, 5 do
		if star - i >= 5 then
			index = index + 1

			local image = ccui.ImageView:create("asset/common/yinghun_img_star_color.png")

			image:addTo(starNode):setScale(0.8)
			image:setPosition(cc.p(13 + 35 * (index - 1), 15))
		elseif star - i >= 0 then
			posXOffset = posXOffset or index == 0 and 17 or 13
			index = index + 1

			local image = ccui.ImageView:create("img_yinghun_img_star_full.png", 1)

			image:addTo(starNode):setScale(0.5)
			image:setPosition(cc.p(posXOffset + 37 * (index - 1), 16))
		end
	end

	starNode:setContentSize(cc.size(36 * index, 43))
end

function EquipAllUpdateMediator:onClickStrengthen(sender, eventType)
	self:setProgrViewToAll()

	local equipData = self._equipData

	if equipData:isMaxLevel() then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Equip_UI61")
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
	end

	if equipData:isStarMaxExp() then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Equip_UI44")
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	if not self._goldEnough then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Tips_3010010")
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	local skill = equipData:getSkill()

	if skill then
		self._oldSkillLevel = skill:getLevel()
	end

	local param = {
		equipIntensifyId = self._equipId
	}

	self._equipSystem:requestEquipIntensify(param)
end

function EquipAllUpdateMediator:onClickStrengthenTen(sender, eventType)
	self:setProgrViewToAll()

	local equipData = self._equipData

	if equipData:isMaxLevel() then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Equip_UI61")
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
	end

	if equipData:isStarMaxExp() then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Equip_UI44")
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	if not self._goldEnough then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Tips_3010010")
		}))
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	local skill = equipData:getSkill()

	if skill then
		self._oldSkillLevel = skill:getLevel()
	end

	local param = {
		equipIntensifyId = self._equipId
	}

	self._equipSystem:requestEquipIntensifyTen(param)
end

function EquipAllUpdateMediator:onClickGrowUp(sender, eventType)
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

	if not self._itemEnough then
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

	local needCostControl = self._equipData:getEquipNeedControl()

	if needCostControl == 1 and self._equipData:getRarity() ~= 15 then
		local commonItemId = self._equipData:getCommonItemId()
		local needNum = self._equipData:getEquipItemNum()

		if needNum > 0 then
			items[commonItemId] = needNum
		end
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	local param = {
		equipId = self._equipId,
		consumeList = equips,
		items = items
	}

	dump(param, "======= param")
	self._equipSystem:requestEquipStarUp(param)
end

function EquipAllUpdateMediator:onClickEquipItem()
	local needCostControl = self._equipData:getEquipNeedControl()

	if needCostControl == 1 then
		local commonItemId = self._equipData:getCommonItemId()
		local needNum = self._equipData:getEquipItemNum()

		if needNum > 0 then
			if self._equipData:getRarity() == 15 then
				local pos = self._bagSystem:getComposePos(commonItemId)

				if pos then
					AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

					local view = self:getInjector():getInstance("EquipStarLevelView")

					self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
						transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
					}, {
						useCompose = true,
						equipId = self._equipId,
						needNum = needNum,
						itemId = commonItemId,
						callback = function()
							self:refreshEquipCost()
						end
					}, nil))
				end

				return
			end

			AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

			local itemData = self._equipData:getStarItem()[1]
			local hasCount = CurrencySystem:getCurrencyCount(self, commonItemId)
			local param = {
				itemId = commonItemId,
				hasNum = hasCount,
				needNum = needNum
			}
			local view = self:getInjector():getInstance("sourceView")

			self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
				transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
			}, param))
		end

		return
	end

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

function EquipAllUpdateMediator:onClickItem()
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

function EquipAllUpdateMediator:onClickLeft()
	if #self._allHeroEquips == 1 then
		return
	end

	local leftIndex = 1

	leftIndex = self._currentHeroEquipsIndex == 1 and #self._allHeroEquips or self._currentHeroEquipsIndex - 1
	self._addExp = 0
	self._oldSkillLevel = 0
	self._equipId = self._allHeroEquips[leftIndex]
	self._currentHeroEquipsIndex = leftIndex

	self._equipSystem:resetEquipStarUpItem()
	self:closeProgrScheduler()

	self._addAnimData = {}
	self._addAnimData.oldArr = {}
	self._addAnimData.newArr = {}
	self._addAnimData.curArr = {}

	self:refreshView()
	self:runStartAction()
end

function EquipAllUpdateMediator:onClickRight()
	if #self._allHeroEquips == 1 then
		return
	end

	local rightIndex = 1

	rightIndex = self._currentHeroEquipsIndex == #self._allHeroEquips and 1 or self._currentHeroEquipsIndex + 1
	self._addExp = 0
	self._oldSkillLevel = 0
	self._equipId = self._allHeroEquips[rightIndex]
	self._currentHeroEquipsIndex = rightIndex

	self._equipSystem:resetEquipStarUpItem()
	self:closeProgrScheduler()

	self._addAnimData = {}
	self._addAnimData.oldArr = {}
	self._addAnimData.newArr = {}
	self._addAnimData.curArr = {}

	self:refreshView()
	self:runStartAction()
end

local progrSleepTime = 0.02

function EquipAllUpdateMediator:createProgrScheduler(sender)
	self:closeProgrScheduler()

	if self._progrScheduler == nil then
		self._progrScheduler = LuaScheduler:getInstance():schedule(function()
			self:progrNormalShow(false, sender)
		end, progrSleepTime, false)
	end
end

function EquipAllUpdateMediator:closeProgrScheduler()
	if self._progrScheduler then
		LuaScheduler:getInstance():unschedule(self._progrScheduler)

		self._progrScheduler = nil
	end
end

function EquipAllUpdateMediator:progrNormalShow(closeCheck, sender)
	local stopAll = true

	for i = 1, 2 do
		if self._addAnimData.newArr[i] and self:checkStopLabelAnim(i) == false then
			stopAll = false

			local addEatNum = 1
			local addNum = self._addAnimData.newArr[i] - self._addAnimData.oldArr[i]

			if addNum > 100 then
				addEatNum = 6

				if addNum > 300 then
					addEatNum = 9
				end
			end

			self._addAnimData.curArr[i] = self._addAnimData.curArr[i] + addEatNum

			if self._addAnimData.curArr[i] > self._addAnimData.newArr[i] then
				self._addAnimData.curArr[i] = self._addAnimData.newArr[i]
			end

			self:refreshProgrView(i, false)
		end
	end

	if stopAll then
		self:closeProgrScheduler()
	end
end

function EquipAllUpdateMediator:refreshProgrView(index, toAll)
	local nowExp = tostring(self._addAnimData.curArr[index])
	local attrPanel = self._nodeAttr:getChildByFullName("desc_" .. index)

	if attrPanel then
		local attrText = attrPanel:getChildByFullName("text")

		if attrText then
			attrText:setString((toAll or nil) and tostring(self._addAnimData.newArr[index]))
		end
	end
end

function EquipAllUpdateMediator:setProgrViewToAll()
	self:closeProgrScheduler()

	for i = 1, 2 do
		if self._addAnimData.newArr[i] then
			self._addAnimData.oldArr[i] = self._addAnimData.newArr[i]
			self._addAnimData.curArr[i] = self._addAnimData.newArr[i]

			self:refreshProgrView(i, true)
			dump(self._addAnimData.curArr[i], "self._addAnimData.curArr[i")
		end
	end
end

function EquipAllUpdateMediator:checkAndDoLabelAnim(attrType)
	local result = true

	for i = 1, 2 do
		if #self._addAnimData.oldArr <= 0 then
			result = false
		end

		if #self._addAnimData.newArr <= 0 then
			result = false
		end

		if self._addAnimData.newArr[i] ~= nil and self._addAnimData.newArr[i] ~= 0 and self._addAnimData.oldArr[i] == self._addAnimData.newArr[i] then
			result = false
		end
	end

	return (AttributeCategory:getAttNameAttend(attrType) ~= "" or nil) and false
end

function EquipAllUpdateMediator:checkStopLabelAnim(index)
	local result = true

	if self._addAnimData.newArr[index] then
		if self._addAnimData.curArr[index] < self._addAnimData.newArr[index] then
			result = false
		else
			self._addAnimData.oldArr[index] = self._addAnimData.newArr[index]
			self._addAnimData.curArr[index] = self._addAnimData.newArr[index]
		end
	end

	return result
end
