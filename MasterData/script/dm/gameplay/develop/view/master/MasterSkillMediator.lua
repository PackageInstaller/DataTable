-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/master/MasterSkillMediator.lua

MasterSkillMediator = class("MasterSkillMediator", DmAreaViewMediator, _M)

MasterSkillMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kBtnHandlers = {}
local maxSkillCount = 4

function MasterSkillMediator:initialize()
	super.initialize(self)
end

function MasterSkillMediator:dispose()
	super.dispose(self)
end

function MasterSkillMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._bagSystem = self._developSystem:getBagSystem()
	self._masterSystem = self._developSystem:getMasterSystem()

	self:bindWidget("mainpanel.detailPanel.levelBtn", OneLevelViceButton, {
		handler = {
			ignoreClickAudio = true,
			func = bind1(self.onClickSkillLevelUp, self)
		}
	})
end

function MasterSkillMediator:setupView(parentMedi, data)
	self._mediator = parentMedi
	self._skillNodes = {}
	self._skillLevelMax = self._masterSystem:getSkillLevelMax()

	self:refreshData(data.id)
	self:initNodes()
	self:createSkillListPanel()
	self:refreshSkillNode()
end

function MasterSkillMediator:initNodes()
	self._mainPanel = self:getView():getChildByFullName("mainpanel")
	self._skillListPanel = self._mainPanel:getChildByFullName("skilllistpanel")
	self._detailPanel = self._mainPanel:getChildByFullName("detailPanel")

	local listView = self._detailPanel:getChildByFullName("listview")

	listView:setScrollBarEnabled(false)

	local text = self._skillListPanel:getChildByFullName("text")

	text:setContentSize(cc.size(99, 40))

	self._lockText = self._detailPanel:getChildByFullName("lockText")

	local costBg = self._detailPanel:getChildByFullName("costNode_1.costBg")
	local addImg = costBg:getChildByFullName("addImg")
	local touchPanel = addImg:getChildByFullName("touchPanel")

	touchPanel:setVisible(true)
	touchPanel:setTouchEnabled(true)
	touchPanel:addClickEventListener(function()
		self:onTouchItemClicked()
	end)

	local costBg = self._detailPanel:getChildByFullName("costNode_2.costBg")
	local addImg = costBg:getChildByFullName("addImg")
	local touchPanel = addImg:getChildByFullName("touchPanel")

	touchPanel:setVisible(true)
	touchPanel:setTouchEnabled(true)
	touchPanel:addClickEventListener(function()
		AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)
		CurrencySystem:buyCurrencyByType(self, CurrencyType.kCrystal)
	end)

	local iconpanel = costBg:getChildByFullName("iconpanel")

	iconpanel:removeAllChildren()

	local icon = IconFactory:createResourcePic({
		scaleRatio = 0.7,
		id = CurrencyIdKind.kCrystal
	}, {
		largeIcon = true
	})

	icon:addTo(iconpanel):center(iconpanel:getContentSize())
	self._skillListPanel:getChildByFullName("text"):enableOutline(cc.c4b(53, 43, 41, 219.29999999999998), 1)

	local skillLevel = self._detailPanel:getChildByFullName("levelNode.skillLevel")

	GameStyle:setCommonOutlineEffect(skillLevel, 127.5, 2)
	GameStyle:setCommonOutlineEffect(skillLevel:getChildByFullName("text"), 127.5, 2)
	GameStyle:setCostNodeEffect(self._detailPanel:getChildByFullName("costNode_1"))
	GameStyle:setCostNodeEffect(self._detailPanel:getChildByFullName("costNode_2"))
end

function MasterSkillMediator:refreshView(masterId)
	self:createSkillListPanel()
	self:refreshSkillNode()
end

function MasterSkillMediator:refreshData(masterId)
	self._masterId = masterId
	self._masterData = self._masterSystem:getMasterById(self._masterId)
	self._masterSkills = self._masterSystem:getShowMasterSkillList(self._masterId)
	self._skillNum = #self._masterSkills
	self._curSkillId = self:checkIsSkillExist()

	for i = 1, self._skillNum do
		local skill = self._masterSkills[i]
		local skillId = skill:getId()

		if self._curSkillId == skillId then
			self._curSkillIndex = i
		end
	end
end

function MasterSkillMediator:checkIsSkillExist()
	if self._curSkillId then
		for i = 1, self._skillNum do
			local skill = self._masterSkills[i]
			local skillId = skill:getId()

			if self._curSkillId == skillId then
				return self._curSkillId
			end
		end
	end

	return self._masterSkills[1]:getId()
end

function MasterSkillMediator:createSkillListPanel()
	self._skillNodes = {}

	for i = 1, maxSkillCount do
		local panel = self._skillListPanel:getChildByFullName("node_" .. i .. ".panel")

		panel:addClickEventListener(function()
			self:onClickSkillIcon(i)
		end)
		panel:removeAllChildren()

		local skillAnim = cc.MovieClip:create("jinenganniu_yinghun_jinenganniu")

		skillAnim:addTo(panel):center(panel:getContentSize())
		skillAnim:addCallbackAtFrame(30, function()
			skillAnim:stop()
		end)
		skillAnim:gotoAndStop(1)
		skillAnim:setScale(0.8)
		skillAnim:setPlaySpeed(1.6)

		local iconNode = skillAnim:getChildByFullName("icon")

		iconNode:removeAllChildren()

		local skill = self._masterSkills[i]
		local skillId = skill:getId()
		local info = {
			id = skillId,
			quality = skill:getQuality(),
			isLock = not skill:getEnable(),
			skillType = skill:getSkillType(),
			level = skill:getLevel()
		}
		local newSkillNode = IconFactory:createMasterSkillIcon(info, {
			hideLevel = true
		})

		newSkillNode:setScale(1.15)
		iconNode:addChild(newSkillNode)
		newSkillNode:setPosition(cc.p(-54.5, -51.5))

		skillAnim.id = skillId
		self._skillNodes[#self._skillNodes + 1] = skillAnim
	end
end

function MasterSkillMediator:refreshSkillNode(showAnim)
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

	local skill = self._masterSkills[self._curSkillIndex]
	local level = skill:getLevel()
	local skillType = skill:getType()
	local skillNode = self._detailPanel:getChildByFullName("skillNode")
	local nameLabel = skillNode:getChildByFullName("skillName")

	nameLabel:setString(skill:getName())

	local skillAnimPanel = self._detailPanel:getChildByFullName("skillAnim")

	skillAnimPanel:removeChildByName("SkillAnim")

	local skillPanel1 = skillAnimPanel:getChildByFullName("skillTypeIcon")

	skillPanel1:setVisible(true)

	local skillPanel2 = skillAnimPanel:getChildByFullName("skillTypeBg")

	skillPanel2:setVisible(true)

	local icon1, icon2 = self._masterSystem:getSkillTypeIcon(skill:getSkillType())
	local skillTypeIcon = skillPanel1:getChildByFullName("icon")

	skillTypeIcon:loadTexture(icon1)

	local skillTypeBg = skillPanel2:getChildByFullName("bg")

	skillTypeBg:loadTexture(icon2)
	skillTypeBg:setCapInsets(cc.rect(4, 15, 6, 16))

	local typeNameLabel = skillPanel2:getChildByFullName("skillType")

	typeNameLabel:setString(self._masterSystem:getSkillTypeName(skill:getSkillType()))
	typeNameLabel:setTextColor(GameStyle:getSkillTypeColor(skill:getSkillType()))

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
	skillLevel:setVisible(false)
	self:refreshSkillDesc(skill)
	self:refreshSkillCost()

	local panel = self._skillListPanel:getChildByFullName("node_" .. self._curSkillIndex)
	local skillTip = self._detailPanel:getChildByFullName("skillTip")
	local targetPos = panel:getParent():convertToWorldSpace(cc.p(panel:getPosition()))

	targetPos = skillTip:getParent():convertToNodeSpace(targetPos)

	skillTip:setPositionX(targetPos.x)
end

function MasterSkillMediator:refreshSkillCost()
	local skill = self._masterSkills[self._curSkillIndex]
	local enable = skill:getEnable()
	local skillLv = skill:getLevel()
	local skilltiplabel = self._detailPanel:getChildByFullName("skilltiplabel")
	local costNode1 = self._detailPanel:getChildByFullName("costNode_1")
	local costNode2 = self._detailPanel:getChildByFullName("costNode_2")
	local levelBtn = self._detailPanel:getChildByFullName("levelBtn")

	skilltiplabel:setVisible(false)
	levelBtn:setVisible(false)
	costNode1:setVisible(false)
	costNode2:setVisible(false)

	do return end

	if enable then
		local contype, con = skill:getUnlockLevel()
		local canup = false

		canup = contype and contype == "star" and con <= self._masterData:getStar() and skillLv < self._skillLevelMax or skillLv < self._skillLevelMax

		if canup then
			levelBtn:setVisible(true)
			costNode1:setVisible(true)
			costNode2:setVisible(true)

			local costNum = skill:getCurLevelUpCost() or skill:getLastLevelUpCost()
			local costBg = costNode2:getChildByFullName("costBg")
			local iconpanel = costBg:getChildByFullName("iconpanel")
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

			self._costItem = {
				itemId = "",
				hasNum = 0,
				count = 0
			}

			local costItem = self._masterSystem:getSkillLevelUpItemCost(self._masterData:getId(), skill:getSkillProId())
			local hasNum = self._bagSystem:getItemCount(costItem.itemId)

			self._costItem.itemId = costItem.itemId
			self._costItem.count = costItem.count
			self._costItem.hasNum = hasNum
			self._itemEnough = hasNum >= self._costItem.count

			local iconpanel = costNode1:getChildByFullName("costBg.iconpanel")

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

			local enoughImg = costNode1:getChildByFullName("costBg.bg.enoughImg")
			local costPanel = costNode1:getChildByFullName("costBg.costPanel")

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
			levelBtn:setVisible(false)
			costNode1:setVisible(false)
			costNode2:setVisible(false)
			skilltiplabel:setVisible(true)

			local text = Strings:get("MASTER_SKILL_LEVELUP_TIP", {
				level = con
			})

			skilltiplabel:setString((skillLv >= self._skillLevelMax or nil) and Strings:get("EXPLORE_Mechanism_UI4"))
		end
	else
		levelBtn:setVisible(false)
		costNode1:setVisible(false)
		costNode2:setVisible(false)
		skilltiplabel:setVisible(true)

		local contype, con = skill:getUnlockUse()
		local canup = false

		if contype and contype == "star" then
			canup = con <= self._masterData:getStar()
		elseif contype and contype == "lv" then
			canup = con <= self._developSystem:getLevel()
		end

		local text = ""

		if contype == "star" then
			text = Strings:get("MASTER_SKILL_UNLOCK_TIP_STAR", {
				level = con
			})
		elseif contype == "lv" then
			text = Strings:get("MASTER_SKILL_UNLOCK_TIP_LV", {
				level = con
			})
		end

		skilltiplabel:setString(text)
	end
end

function MasterSkillMediator:refreshSkillDesc(skill)
	local listView = self._detailPanel:getChildByFullName("listview")

	listView:removeAllItems()

	if skill:getMasterSkillDescKey() and skill:getMasterSkillDescKey() ~= "" then
		local newPanel = self:createSkillDescPanel(skill:getMasterSkillDescKey())

		listView:pushBackCustomItem(newPanel)
	end

	local skillProto = PrototypeFactory:getInstance():getSkillPrototype(skill:getId())

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

	if skill:getEnable() == false then
		self._lockText:setVisible(true)

		local des, unlockLevel = skill:getUnlockUse()

		self._lockText:setString(Strings:get("Master_Skill_Unlock_Level", {
			Num = unlockLevel
		}))
	else
		self._lockText:setVisible(false)
	end
end

local listWidth = 710

function MasterSkillMediator:createSkillDescPanel(title, otherHeight)
	otherHeight = otherHeight or 8

	local layout = ccui.Layout:create()
	local skill = self._masterSkills[self._curSkillIndex]
	local style = {
		fontName = TTF_FONT_FZYH_M
	}
	local desc = ConfigReader:getEffectDesc("Skill", title, skill:getId(), skill:getLevel(), style)
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

function MasterSkillMediator:createEffectDescPanel(desc, otherHeight)
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

function MasterSkillMediator:refreshAllView()
	self:refreshView()
end

function MasterSkillMediator:onClickSkillLevelUp()
	local id = self._masterData:getId()
	local skill = self._masterSkills[self._curSkillIndex]
	local cost = skill:getCurLevelUpCost()

	if skill:getLevel() >= self._skillLevelMax then
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)
		self:dispatch(ShowTipEvent({
			duration = 0.2,
			tip = Strings:get("Error_10056")
		}))

		return
	end

	if not self._itemEnough then
		self:onTouchItemClicked()

		return
	end

	if cost > self._developSystem:getCrystal() then
		CurrencySystem:buyCurrencyByType(self, CurrencyType.kCrystal)
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	self._masterSystem:sendApplyMasterSkillLevelUp(id, skill:getId())
	AudioEngine:getInstance():playEffect("Se_Alert_Character_Levelup", false)
end

function MasterSkillMediator:onTouchItemClicked()
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

function MasterSkillMediator:onClickSkillIcon(index)
	if self._curSkillIndex ~= index then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

		self._curSkillIndex = index
		self._curSkillId = self._masterSkills[index]:getId()

		self:refreshSkillNode(true)
	end
end

function MasterSkillMediator:runStartAction()
	self._mainPanel:stopAllActions()

	local action = cc.CSLoader:createTimeline("asset/ui/MasterSkill.csb")

	self._mainPanel:runAction(action)
	action:clearFrameEventCallFunc()
	action:gotoFrameAndPlay(0, 32, false)
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
