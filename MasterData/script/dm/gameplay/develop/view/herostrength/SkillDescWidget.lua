-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/herostrength/SkillDescWidget.lua

SkillDescWidget = class("SkillDescWidget", BaseWidget, _M)

local listWidth = 391

function SkillDescWidget.class:createWidgetNode()
	local resFile = "asset/ui/SkillDescWidget.csb"

	return cc.CSLoader:createNode(resFile)
end

function SkillDescWidget:initialize(view, data)
	super.initialize(self, view)

	self._skill = data.skill
	self._mediator = data.mediator

	self:initSubviews(view)
end

function SkillDescWidget:dispose()
	super.dispose(self)
end

function SkillDescWidget:initSubviews(view)
	self._view = view
	self._skillTipPanel = self._view:getChildByName("skillTipPanel")

	local nextPanel = self._skillTipPanel:getChildByName("nextPanel")

	nextPanel:setVisible(false)

	local skillTouchPanel = self._skillTipPanel:getChildByFullName("skillTouchPanel")

	skillTouchPanel:setSwallowTouches(false)
	skillTouchPanel:addClickEventListener(function()
		self:hide()
	end)

	self._desc = self._skillTipPanel:getChildByName("desc")
	self._nextPanel = nextPanel
end

function SkillDescWidget:refreshInfo(skill, role, isMaster, tipHeight)
	self._maxHeight = tipHeight or 500
	self._role = role
	self._isMaster = isMaster

	local infoNode = self._skillTipPanel:getChildByFullName("infoNode")
	local iconPanel = infoNode:getChildByFullName("iconPanel")

	iconPanel:removeAllChildren()

	if self._isMaster then
		local skillIcon = IconFactory:createMasterSkillIcon({
			levelHide = true,
			id = skill:getId(),
			skillType = skill:getSkillType()
		})

		skillIcon:addTo(iconPanel):posite(10, 16)
		skillIcon:setScale(0.5)
	else
		local newSkillNode = IconFactory:createHeroSkillIcon({
			id = skill:getSkillId(),
			isLock = not skill:getEnable()
		}, {
			hideLevel = true
		})

		newSkillNode:addTo(iconPanel):center(iconPanel:getContentSize())
		newSkillNode:setScale(0.7)
	end

	local skillType = skill:getType()
	local skillAnimPanel = infoNode:getChildByFullName("skillAnim")

	skillAnimPanel:removeChildByName("SkillAnim")

	local skillPanel1 = skillAnimPanel:getChildByFullName("skillTypeIcon")

	skillPanel1:setVisible(true)

	local skillPanel2 = skillAnimPanel:getChildByFullName("skillTypeBg")

	skillPanel2:setVisible(true)

	local icon1, icon2

	if self._isMaster then
		skillType = skill:getSkillType()
		icon1, icon2 = self._mediator._masterSystem:getSkillTypeIcon(skillType)
	else
		icon1, icon2 = self._mediator._heroSystem:getSkillTypeIcon(skillType)
	end

	local skillTypeIcon = skillPanel1:getChildByFullName("icon")

	skillTypeIcon:loadTexture(icon1)

	local skillTypeBg = skillPanel2:getChildByFullName("bg")

	skillTypeBg:loadTexture(icon2)
	skillTypeBg:setCapInsets(cc.rect(4, 15, 6, 16))

	local typeNameLabel = skillPanel2:getChildByFullName("skillType")

	if self._isMaster then
		typeNameLabel:setString(self._mediator._masterSystem:getSkillTypeName(skillType))
	else
		typeNameLabel:setString(self._mediator._heroSystem:getSkillTypeName(skillType))
	end

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

	local name = infoNode:getChildByFullName("name")

	name:setString(skill:getName())

	if not self._isMaster then
		self._nextPanel:removeFromParent()
	end

	local bg = self._skillTipPanel:getChildByName("Image_bg")
	local desc = self._desc

	desc:setString("")
	desc:removeAllChildren()

	local descStr = {}
	local height = 0
	local height_bottom = 0

	if self._isMaster ~= true then
		self._starAttrs = self._role:getStarAttrs()

		local nextPanel = self._nextPanel

		nextPanel:addTo(desc)

		local titleStr = ""
		local nextDes = ""
		local check_star = 0

		for i = 1, #self._starAttrs do
			local params = self._starAttrs[i]

			if params.star then
				check_star = params.star

				local var_6_0 = "Hero_Star_UI_Effect_Desc"
				local var_6_1 = {}

				var_6_1.star = params.star == 7 and Strings:get("AWAKE_TITLE") or params.star
				titleStr = Strings:get(var_6_0, var_6_1)
			end

			if params.info and check_star > self._role:getStar() then
				for index = 1, #params.info do
					local value = params.info[index]

					if value.isHide == 0 and value.beforeSkillId and value.beforeSkillId == skill:getSkillId() then
						nextDes = value.desc

						break
					end
				end
			end

			if nextDes ~= "" then
				break
			end
		end

		if titleStr ~= "" and nextDes ~= "" then
			nextPanel:setVisible(true)

			local Text_title = nextPanel:getChildByName("Text_title")
			local Image_line_1 = nextPanel:getChildByName("Image_line_1")
			local Image_line_2 = nextPanel:getChildByName("Image_line_2")

			Text_title:setString(titleStr)

			if Text_title:getContentSize().width > 400 then
				Text_title:getVirtualRenderer():setOverflow(cc.LabelOverflow.SHRINK)
				Text_title:getVirtualRenderer():setDimensions(400, 38)
			end

			Image_line_1:setContentSize(cc.size(208 - Text_title:getContentSize().width / 2 - 5, 1.3))
			Image_line_2:setContentSize(cc.size(208 - Text_title:getContentSize().width / 2 - 5, 1.3))

			local newPanel = self:createEffectDescPanel(nextDes)

			newPanel:setAnchorPoint(cc.p(0, 0))
			newPanel:addTo(desc)

			height = height + newPanel:getContentSize().height
			height = height + 50
			height_bottom = height

			nextPanel:setPosition(-10, height - 25.5)
		else
			nextPanel:setVisible(false)
		end
	end

	local skillDesc = self._isMaster and skill:getMasterSkillDescKey() or skill:getDesc()

	if skillDesc and skillDesc ~= "" then
		local newPanel = self:createSkillDescPanel(skillDesc, skill, (not self._isMaster or nil) and {
			fontSize = 20,
			SkillRate = self._role:getSkillRateShow(),
			fontName = TTF_FONT_FZYH_R
		})

		newPanel:setAnchorPoint(cc.p(0, 0))
		newPanel:addTo(desc)
		table.insert(descStr, {
			newPanel = newPanel,
			height = newPanel:getContentSize().height
		})

		height = height + newPanel:getContentSize().height
	end

	local skillProto = PrototypeFactory:getInstance():getSkillPrototype(skill:getSkillProId())

	if skillProto then
		local style = {
			fontSize = 20,
			fontName = TTF_FONT_FZYH_R
		}
		local attrDescs = skillProto:getAttrDescs(skill:getLevel(), style) or {}

		for i = 1, #attrDescs do
			local newPanel = self:createEffectDescPanel(attrDescs[i])

			newPanel:setAnchorPoint(cc.p(0, 0))
			newPanel:addTo(desc)
			table.insert(descStr, {
				newPanel = newPanel,
				height = newPanel:getContentSize().height
			})

			height = height + newPanel:getContentSize().height
		end
	end

	for i = #descStr, 1, -1 do
		local newPanel = descStr[i].newPanel

		if i == #descStr then
			newPanel:setPositionY(0 + height_bottom)
		else
			local posY = descStr[i + 1].height + height_bottom

			newPanel:setPositionY(posY)
		end
	end

	height = height + 110

	if height > self._maxHeight then
		if not self._listView then
			local listView = ccui.ListView:create()

			listView:setScrollBarEnabled(false)
			listView:addTo(self._skillTipPanel):posite(10, 15)

			self._listView = listView

			self._listView:setContentSize(cc.size(432, self._maxHeight - 100))
		end

		local layout = ccui.Layout:create()

		layout:setContentSize(cc.size(432, height - 110))
		desc:changeParent(layout):posite(0, 0)
		self._listView:removeAllChildren()
		self._listView:pushBackCustomItem(layout)
		bg:setContentSize(cc.size(432, self._maxHeight))
		infoNode:setPositionY(self._maxHeight - 90)
	else
		desc:changeParent(self._skillTipPanel):posite(13, 18)
		bg:setContentSize(cc.size(432, height))
		infoNode:setPositionY(height - 90)
	end
end

function SkillDescWidget:refreshMessageInfo(skill, isMaster)
	self._maxHeight = tipHeight or 500

	local infoNode = self._skillTipPanel:getChildByFullName("infoNode")
	local iconPanel = infoNode:getChildByFullName("iconPanel")

	iconPanel:removeAllChildren()

	if isMaster then
		local skillIcon = IconFactory:createMasterSkillIcon({
			levelHide = true,
			id = skill.Id,
			skillType = skill.skillType
		})

		skillIcon:addTo(iconPanel):posite(10, 16)
		skillIcon:setScale(0.5)
	else
		local newSkillNode = IconFactory:createHeroSkillIcon({
			id = skill.Id
		}, {
			hideLevel = true
		})

		newSkillNode:addTo(iconPanel):center(iconPanel:getContentSize())
		newSkillNode:setScale(0.7)
	end

	local skillType = skill.SkillType
	local skillAnimPanel = infoNode:getChildByFullName("skillAnim")

	skillAnimPanel:removeChildByName("SkillAnim")

	local skillPanel1 = skillAnimPanel:getChildByFullName("skillTypeIcon")

	skillPanel1:setVisible(false)

	local skillPanel2 = skillAnimPanel:getChildByFullName("skillTypeBg")

	skillPanel2:setVisible(false)

	local height = 0
	local desc = self._desc

	desc:setString("")
	desc:removeAllChildren()

	local icon1, icon2, skillTypeBg

	if isMaster then
		skillType = skill.skillType
		icon1, icon2 = self._mediator._masterSystem:getSkillTypeIcon(skill.skillType)
		skillTypeIcon = skillPanel1:getChildByFullName("icon")

		skillTypeIcon:loadTexture(icon1)

		local skillTypeBg = skillPanel2:getChildByFullName("bg")

		skillTypeBg:loadTexture(icon2)
		skillTypeBg:setCapInsets(cc.rect(4, 15, 6, 16))

		local typeNameLabel = skillPanel2:getChildByFullName("skillType")

		typeNameLabel:setString(self._mediator._masterSystem:getSkillTypeName(skillType))
		skillPanel1:setVisible(true)
		skillPanel2:setVisible(true)

		local width = typeNameLabel:getContentSize().width + 30

		skillTypeBg:setContentSize(cc.size(width, 38))
		skillAnimPanel:setContentSize(cc.size(width + 25, 46))
		typeNameLabel:setTextColor(GameStyle:getSkillTypeColor(skillType))
	end

	local skillDesc = skill.Desc

	if skillDesc and skillDesc ~= "" then
		local style = {
			fontSize = 20,
			fontName = TTF_FONT_FZYH_R
		}
		local newPanel = self:createMessageSkillDescPanel(skillDesc, skill, style)

		newPanel:setAnchorPoint(cc.p(0, 0))
		newPanel:addTo(desc)

		height = height + newPanel:getContentSize().height

		desc:setPositionY(100 - height / 2)
	end

	local name = infoNode:getChildByFullName("name")

	name:setString(Strings:get(skill.Name))
end

function SkillDescWidget:createMessageSkillDescPanel(title, skill, otherHeight)
	local layout = ccui.Layout:create()
	local style = {
		fontName = TTF_FONT_FZYH_M
	}
	local desc = ConfigReader:getEffectDesc("Skill", title, skill.Id, 1, style)
	local label = ccui.RichText:createWithXML(desc, {})

	label:setVerticalSpace(8)
	label:renderContent(listWidth - 14, 0)
	label:setAnchorPoint(cc.p(0, 1))

	local height = label:getContentSize().height

	layout:setContentSize(cc.size(listWidth, height + 8))
	label:addTo(layout)
	label:setPosition(cc.p(0, height + 8))

	return layout
end

function SkillDescWidget:createSkillDescPanel(title, skill, style)
	local layout = ccui.Layout:create()
	local strWidth = listWidth
	local desc = ConfigReader:getEffectDesc("Skill", title, skill:getSkillProId(), skill:getLevel(), style)
	local label = ccui.RichText:createWithXML(desc, {})

	label:setVerticalSpace(1)
	label:renderContent(strWidth, 0)
	label:setAnchorPoint(cc.p(0, 1))

	local height = label:getContentSize().height

	layout:setContentSize(cc.size(strWidth, height))
	label:addTo(layout)
	label:setPosition(cc.p(0, height))

	return layout
end

function SkillDescWidget:createEffectDescPanel(desc)
	local strWidth = listWidth
	local layout = ccui.Layout:create()
	local label = ccui.RichText:createWithXML(desc, {})

	label:setVerticalSpace(1)
	label:renderContent(strWidth, 0)
	label:setAnchorPoint(cc.p(0, 1))

	local height = label:getContentSize().height

	layout:setContentSize(cc.size(strWidth, height))
	label:addTo(layout)
	label:setPosition(cc.p(0, height))

	return layout
end

function SkillDescWidget:getWidth()
	return self._bg:getContentSize().width
end

function SkillDescWidget:getHeight()
	return self._bg:getContentSize().height
end

function SkillDescWidget:show()
	self._view:setVisible(true)
end

function SkillDescWidget:hide()
	self._view:setVisible(false)
end
