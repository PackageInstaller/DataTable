-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/herostrength/HeroStrengthSkillMediator.lua

HeroStrengthSkillMediator = class("HeroStrengthSkillMediator", DmAreaViewMediator, _M)

HeroStrengthSkillMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kBtnHandlers = {
	["mainpanel.skilllistpanel.tipBtn"] = {
		clickAudio = "Se_Click_Common_2",
		func = "onClickHeroCardDesc"
	},
	["mainpanel.detailPanel.levelBtn"] = {
		ignoreClickAudio = true,
		func = "onClickLevelUpBtn"
	}
}
local maxSkillCount = 6

function HeroStrengthSkillMediator:initialize()
	super.initialize(self)
end

function HeroStrengthSkillMediator:dispose()
	super.dispose(self)
end

function HeroStrengthSkillMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._bagSystem = self._developSystem:getBagSystem()
	self._heroSystem = self._developSystem:getHeroSystem()
end

function HeroStrengthSkillMediator:setupView(parentMedi, data)
	self._mediator = parentMedi
	self._skillNodes = {}
	self._skillLevelMax = self._heroSystem:getSkillLevelMax()

	self:refreshData(data.id)
	self:initNodes()
	self:createSkillListPanel()
	self:refreshSkillNode()
	self:setupClickEnvs()
end

function HeroStrengthSkillMediator:initNodes()
	self._mainPanel = self:getView():getChildByFullName("mainpanel")
	self._skillListPanel = self._mainPanel:getChildByFullName("skilllistpanel")
	self._detailPanel = self._mainPanel:getChildByFullName("detailPanel")

	local listView = self._detailPanel:getChildByFullName("listview")

	listView:setScrollBarEnabled(false)

	local addImg = self._detailPanel:getChildByFullName("costNode_1.costBg.addImg")
	local touchPanel = addImg:getChildByFullName("touchPanel")

	touchPanel:setVisible(true)
	touchPanel:setTouchEnabled(true)
	touchPanel:addClickEventListener(function()
		CurrencySystem:buyCurrencyByType(self, CurrencyType.kGold)
	end)

	local addImg = self._detailPanel:getChildByFullName("costNode_2.costBg.addImg")
	local touchPanel = addImg:getChildByFullName("touchPanel")

	touchPanel:setVisible(true)
	touchPanel:setTouchEnabled(true)
	touchPanel:addClickEventListener(function()
		self:onTouchItemClicked()
	end)
	self._skillListPanel:getChildByFullName("text"):enableOutline(cc.c4b(53, 43, 41, 219.29999999999998), 1)

	local skillLevel = self._detailPanel:getChildByFullName("levelNode.skillLevel")

	GameStyle:setCommonOutlineEffect(skillLevel, 127.5, 2)
	GameStyle:setCommonOutlineEffect(skillLevel:getChildByFullName("text"), 127.5, 2)
	GameStyle:setCostNodeEffect(self._detailPanel:getChildByFullName("costNode_1"))
	GameStyle:setCostNodeEffect(self._detailPanel:getChildByFullName("costNode_2"))
	self._detailPanel:getChildByFullName("levelBtn.name1"):enableShadow(cc.c4b(3, 1, 4, 127.5), cc.size(1, 0), 1)
end

function HeroStrengthSkillMediator:refreshView(heroId)
	heroId = heroId or self._heroId

	self:refreshData(heroId)
	self:createSkillListPanel()
	self:refreshSkillNode()
end

function HeroStrengthSkillMediator:refreshData(heroId)
	self._heroId = heroId
	self._heroData = self._heroSystem:getHeroById(self._heroId)
	self._skillIds = self._heroSystem:getShowSkillIds(self._heroData:getId())
	self._skillCache = {}
	self._curSkillId = self:checkIsSkillExist()

	for i = 1, #self._skillIds do
		local skillId = self._skillIds[i]

		self._skillCache[skillId] = self._heroSystem:getSkillById(self._heroId, skillId)

		if self._curSkillId == skillId then
			self._curSkillIndex = i
		end
	end

	self._costGold = 0
	self._costItem = {
		itemId = "",
		hasNum = 0,
		count = 0
	}
end

function HeroStrengthSkillMediator:checkIsSkillExist()
	if self._curSkillId then
		for i = 1, #self._skillIds do
			local skillId = self._skillIds[i]

			if self._curSkillId == skillId then
				return self._curSkillId
			end
		end

		return self._skillIds[1]
	end

	return self._skillIds[1]
end

function HeroStrengthSkillMediator:createSkillListPanel()
	self._skillNodes = {}
	self._skillIcons = {}

	for i = 1, maxSkillCount do
		local panel = self._skillListPanel:getChildByFullName("node_" .. i)

		panel:removeAllChildren()

		local skillId = self._skillIds[i]

		if skillId then
			panel:addClickEventListener(function()
				self:onClickSkillIcon(i)
			end)

			local skillAnim = cc.MovieClip:create("jinenganniu_yinghun_jinenganniu")

			skillAnim:addTo(panel)
			skillAnim:setPosition(cc.p(50, 44))
			skillAnim:addCallbackAtFrame(30, function()
				skillAnim:stop()
			end)
			skillAnim:gotoAndStop(1)
			skillAnim:setScale(0.9)
			skillAnim:setPlaySpeed(1.6)

			local iconNode = skillAnim:getChildByFullName("icon")

			iconNode:removeAllChildren()

			local skill = self._skillCache[skillId]
			local isLock = not skill:getEnable()
			local level = skill:getLevel()
			local newSkillNode = IconFactory:createHeroSkillIcon({
				id = skillId,
				level = level,
				isLock = isLock
			}, {
				isWidget = true
			})

			newSkillNode:setScale(1.6)
			iconNode:addChild(newSkillNode)
			newSkillNode:setPosition(cc.p(3.3, -2.2))

			skillAnim.id = skillId
			self._skillNodes[#self._skillNodes + 1] = skillAnim

			local isKeySkill = self._heroSystem:checkIsKeySkill(self._heroId, skillId)

			if isKeySkill then
				local skillType = skill:getType()
				local icon1, icon2 = self._heroSystem:getSkillTypeIcon(skillType)
				local image = ccui.ImageView:create(icon1)

				image:addTo(iconNode):posite(70, 50)
				image:setScale(1.4)
			end
		end
	end
end

function HeroStrengthSkillMediator:refreshSkillNode(showAnim)
	for i = 1, #self._skillNodes do
		local skillNode = self._skillNodes[i]

		skillNode:gotoAndStop(1)

		if self._curSkillId == skillNode.id then
			if showAnim then
				skillNode:gotoAndPlay(1)
			else
				skillNode:gotoAndStop(30)
			end
		end
	end

	local skill = self._skillCache[self._curSkillId]
	local level = skill:getLevel()
	local skillType = skill:getType()
	local atkRange = skill:getSkillRange()
	local skillNode = self._detailPanel:getChildByFullName("skillNode")
	local nameLabel = skillNode:getChildByFullName("skillName")

	nameLabel:setString(skill:getName())

	local skillAnimPanel = self._detailPanel:getChildByFullName("skillAnim")

	skillAnimPanel:removeChildByName("SkillAnim")

	local skillPanel1 = skillAnimPanel:getChildByFullName("skillTypeIcon")

	skillPanel1:setVisible(true)

	local skillPanel2 = skillAnimPanel:getChildByFullName("skillTypeBg")

	skillPanel2:setVisible(true)

	local icon1, icon2 = self._heroSystem:getSkillTypeIcon(skillType)
	local skillTypeIcon = skillPanel1:getChildByFullName("icon")

	skillTypeIcon:loadTexture(icon1)

	local skillTypeBg = skillPanel2:getChildByFullName("bg")

	skillTypeBg:loadTexture(icon2)
	skillTypeBg:setCapInsets(cc.rect(4, 15, 6, 16))

	local typeNameLabel = skillPanel2:getChildByFullName("skillType")

	typeNameLabel:setString(self._heroSystem:getSkillTypeName(skillType))
	typeNameLabel:setTextColor(GameStyle:getSkillTypeColor(skillType))

	local width = typeNameLabel:getContentSize().width + 30

	skillTypeBg:setContentSize(cc.size(width, 38))
	skillAnimPanel:setContentSize(cc.size(width + 25, 46))

	if skillType == SkillType.kUltra or skillType == SkillType.kSuper then
		skillPanel1:setVisible(false)
		skillPanel2:setVisible(false)

		local node1 = skillPanel1:clone()

		node1:setVisible(true)

		local node2 = skillPanel2:clone()

		node2:setVisible(true)

		local anim = cc.MovieClip:create("dh_biaoshiguangxiao")

		anim:setName("SkillAnim")
		anim:addTo(skillAnimPanel)

		local panel = anim:getChildByFullName("skill")

		panel:addChild(node1)
		panel:addChild(node2)
		node2:setPosition(cc.p(-36, -19))
		node1:setPosition(cc.p(-36, 0))
		anim:setPosition(cc.p(60, 23))

		local skillClone1 = node1:clone()
		local skillClone2 = node2:clone()
		local panel1 = anim:getChildByFullName("skill1")

		panel1:addChild(skillClone2)
		panel1:addChild(skillClone1)
	end

	skillNode:setPositionX(skillAnimPanel:getPositionX() + skillAnimPanel:getContentSize().width)

	local skillLevel = self._detailPanel:getChildByFullName("levelNode.skillLevel")

	skillLevel:setString(level)

	local atkRangeImg = self._detailPanel:getChildByFullName("levelNode.image")

	if atkRange ~= "" then
		skillLevel:setPositionX(-36)
		atkRangeImg:setVisible(true)
		GameStyle:setHeroAtkRangeImage(atkRangeImg, atkRange)
	else
		skillLevel:setPositionX(1)
		atkRangeImg:setVisible(false)
	end

	self:refreshSkillDesc(skill)
	self:refreshSkillCost()

	local panel = self._skillListPanel:getChildByFullName("node_" .. self._curSkillIndex)
	local skillTip = self._detailPanel:getChildByFullName("skillTip")
	local targetPos = panel:getParent():convertToWorldSpace(cc.p(panel:getPosition()))

	targetPos = skillTip:getParent():convertToNodeSpace(targetPos)

	skillTip:setPositionX(targetPos.x)
end

function HeroStrengthSkillMediator:refreshSkillCost()
	local skill = self._skillCache[self._curSkillId]
	local isLock = skill:getLock()
	local enable = skill:getEnable()
	local isMax = skill:getLevel() >= self._skillLevelMax
	local skilltiplabel = self._detailPanel:getChildByFullName("skilltiplabel")
	local costNode1 = self._detailPanel:getChildByFullName("costNode_1")
	local costNode2 = self._detailPanel:getChildByFullName("costNode_2")
	local levelBtn = self._detailPanel:getChildByFullName("levelBtn")

	if not isLock and not isMax then
		skilltiplabel:setVisible(false)
		costNode1:setVisible(true)
		costNode2:setVisible(true)
		levelBtn:setVisible(true)

		local costNum = self._heroSystem:getSkillLevelUpCost(self._heroData:getId(), self._heroData:getRarity(), self._curSkillId)

		self._costGold = costNum

		local costBg = costNode1:getChildByFullName("costBg")
		local iconpanel = costBg:getChildByFullName("iconpanel")

		iconpanel:removeAllChildren()

		local icon = IconFactory:createResourcePic({
			scaleRatio = 0.7,
			id = CurrencyIdKind.kGold
		}, {
			largeIcon = true
		})

		icon:addTo(iconpanel):center(iconpanel:getContentSize())

		local enough = costNum <= self._developSystem:getGolds()

		iconpanel:setGray(not enough)

		local addImg = costBg:getChildByFullName("addImg")

		addImg:setVisible(not enough)

		local enoughImg = costBg:getChildByFullName("bg.enoughImg")

		enoughImg:setVisible(enough)

		local cost = costBg:getChildByFullName("cost")

		cost:setVisible(true)
		cost:setString(costNum)

		local colorNum = enough and 1 or 7

		cost:setTextColor(GameStyle:getColor(colorNum))

		local costItem = self._heroSystem:getSkillLevelUpItemCost(self._heroId, self._curSkillId)
		local hasNum = self._bagSystem:getItemCount(costItem.itemId)

		self._costItem.itemId = costItem.itemId
		self._costItem.count = costItem.count
		self._costItem.hasNum = hasNum
		self._itemEnough = hasNum >= self._costItem.count

		local iconpanel = costNode2:getChildByFullName("costBg.iconpanel")

		iconpanel:removeAllChildren()

		local costIcon = IconFactory:createPic({
			scaleRatio = 0.7,
			id = self._costItem.itemId
		})

		costIcon:addTo(iconpanel)
		costIcon:setPosition(cc.p(iconpanel:getContentSize().width / 2, iconpanel:getContentSize().height / 2))
		costIcon:setGray(not self._itemEnough)

		local addImg = costNode2:getChildByFullName("costBg.addImg")

		addImg:setVisible(not self._itemEnough)

		local enoughImg = costNode2:getChildByFullName("costBg.bg.enoughImg")
		local costPanel = costNode2:getChildByFullName("costBg.costPanel")

		costPanel:setVisible(true)

		local cost = costPanel:getChildByFullName("cost")
		local costLimit = costPanel:getChildByFullName("costLimit")

		cost:setString(hasNum)
		costLimit:setString("/" .. self._costItem.count)
		costLimit:setPositionX(cost:getContentSize().width)
		costPanel:setContentSize(cc.size(cost:getContentSize().width + costLimit:getContentSize().width, 40))

		local colorNum1 = self._itemEnough and 1 or 7

		cost:setTextColor(GameStyle:getColor(colorNum1))
		costLimit:setTextColor(GameStyle:getColor(colorNum1))
		enoughImg:setVisible(self._itemEnough)
	else
		skilltiplabel:setVisible(true)
		costNode1:setVisible(false)
		costNode2:setVisible(false)
		levelBtn:setVisible(false)
	end

	if skilltiplabel:isVisible() then
		if isMax then
			skilltiplabel:setString(Strings:get("Tips_3010014"))
		elseif isLock and enable then
			local unLockStar = self._heroSystem:getUnLockSkillStar(self._heroData:getId(), self._curSkillId)

			skilltiplabel:setString(Strings:get("Digimon_UI10", {
				star = unLockStar
			}))
		elseif isLock and not enable then
			local unLockStar = self._heroSystem:getUnLockSkillStar(self._heroData:getId(), self._curSkillId)

			skilltiplabel:setString(Strings:get("HeroPassiveUnlock_Text", {
				star = unLockStar
			}))
		end
	end
end

function HeroStrengthSkillMediator:onTouchItemClicked()
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	local outSelf, delegate = self, {}

	function delegate:willClose(popupMediator, data)
		outSelf:refreshSkillCost()
	end

	local param = {
		isNeed = true,
		hasWipeTip = true,
		itemId = self._costItem.itemId,
		hasNum = self._costItem.hasNum,
		needNum = self._costItem.count
	}
	local view = self:getInjector():getInstance("sourceView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, param, delegate))
end

function HeroStrengthSkillMediator:refreshSkillDesc(skill)
	local listView = self._detailPanel:getChildByFullName("listview")

	listView:removeAllItems()

	if skill:getDesc() and skill:getDesc() ~= "" then
		local newPanel = self:createSkillDescPanel(skill:getDesc())

		listView:pushBackCustomItem(newPanel)
	end

	local skillProto = PrototypeFactory:getInstance():getSkillPrototype(skill:getSkillProId())

	if not skillProto then
		return
	end

	local style = {
		fontName = TTF_FONT_FZYH_M
	}
	local attrDescs = skillProto:getAttrDescs(skill:getLevel(), style) or {}

	for i = 1, #attrDescs do
		local newPanel = self:createEffectDescPanel(attrDescs[i])

		listView:pushBackCustomItem(newPanel)
	end
end

local listWidth = 605

function HeroStrengthSkillMediator:createSkillDescPanel(title, otherHeight)
	otherHeight = otherHeight or 8

	local layout = ccui.Layout:create()
	local skill = self._skillCache[self._curSkillId]
	local style = {
		SkillRate = self._heroData:getSkillRateShow(),
		fontName = TTF_FONT_FZYH_M
	}
	local desc = ConfigReader:getEffectDesc("Skill", title, skill:getSkillProId(), skill:getLevel(), style)
	local label = ccui.RichText:createWithXML(desc, {})

	label:setVerticalSpace(8)
	label:renderContent(listWidth - 14, 0)
	label:setAnchorPoint(cc.p(0, 1))

	local height = label:getContentSize().height

	layout:setContentSize(cc.size(listWidth, height + otherHeight))
	label:addTo(layout)
	label:setPosition(cc.p(0, height + otherHeight))

	return layout
end

function HeroStrengthSkillMediator:createEffectDescPanel(desc, otherHeight)
	otherHeight = otherHeight or 8

	local layout = ccui.Layout:create()
	local label = ccui.RichText:createWithXML(desc, {})

	label:setVerticalSpace(8)
	label:renderContent(listWidth - 14, 0)
	label:setAnchorPoint(cc.p(0, 1))

	local height = label:getContentSize().height

	layout:setContentSize(cc.size(listWidth, height + otherHeight))
	label:addTo(layout)
	label:setPosition(cc.p(0, height + otherHeight))

	return layout
end

function HeroStrengthSkillMediator:checkUpSkill()
	local skill = self._skillCache[self._curSkillId]
	local isMax = skill:getLevel() >= self._skillLevelMax

	if isMax then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("Tips_3010014")
		}))

		return
	end

	if not self._itemEnough then
		self:onTouchItemClicked()

		return
	end

	return CurrencySystem:checkEnoughGold(self, self._costGold, nil, {
		tipType = "tip"
	})
end

function HeroStrengthSkillMediator:refreshAllView()
	self:refreshView()
end

function HeroStrengthSkillMediator:onClickLevelUpBtn()
	local isCanUp = self:checkUpSkill()

	if not isCanUp then
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
	self._heroSystem:requestHeroSkillLvlUp(self._heroId, self._curSkillId)
end

function HeroStrengthSkillMediator:onClickSkillIcon(index)
	if self._curSkillIndex ~= index then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

		self._curSkillIndex = index
		self._curSkillId = self._skillIds[index]

		self:refreshSkillNode(true)
	end
end

function HeroStrengthSkillMediator:onClickHeroCardDesc()
	local view = self:getInjector():getInstance("HeroCardView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, nil, {
		type = "skill"
	}))
end

function HeroStrengthSkillMediator:runStartAction()
	self._mainPanel:stopAllActions()

	local action = cc.CSLoader:createTimeline("asset/ui/StrengthenSkill.csb")

	self._mainPanel:runAction(action)
	action:clearFrameEventCallFunc()
	action:gotoFrameAndPlay(0, 30, false)
	action:setTimeSpeed(1.2)

	local costNode1 = self._detailPanel:getChildByFullName("costNode_1")
	local costNode2 = self._detailPanel:getChildByFullName("costNode_2")

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

function HeroStrengthSkillMediator:setupClickEnvs()
	if GameConfigs.closeGuide then
		return
	end

	local sequence = cc.Sequence:create(cc.CallFunc:create(function()
		local storyDirector = self:getInjector():getInstance(story.StoryDirector)
		local levelBtn = self:getView():getChildByFullName("mainpanel.detailPanel.levelBtn")

		storyDirector:setClickEnv("HeroStrengthSkill.levelBtn", levelBtn, function(sender, eventType)
			self:onClickLevelUpBtn()
			storyDirector:notifyWaiting("click_HeroStrengthSkill_levelBtn")
		end)
	end))

	self:getView():runAction(sequence)
end
