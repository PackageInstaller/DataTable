-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/develop/view/herostrength/SkillTipWidget.lua

SkillTipWidget = class("SkillTipWidget", BaseWidget, _M)

local listWidth = 264

function SkillTipWidget.class:createWidgetNode()
	local resFile = "asset/ui/SkillTipWidget.csb"

	return cc.CSLoader:createNode(resFile)
end

function SkillTipWidget:initialize(view, data)
	super.initialize(self, view)

	self._skill = data.skill
	self._mediator = data.mediator

	self:initSubviews(view)
end

function SkillTipWidget:dispose()
	super.dispose(self)
end

function SkillTipWidget:initSubviews(view)
	self._view = view
	self._descPanel = self._view:getChildByName("descPanel")
	self._bg = self._descPanel:getChildByName("bg")
	self._icon = self._descPanel:getChildByName("icon")
	self._name = self._descPanel:getChildByName("name")
	self._listView = self._descPanel:getChildByName("listView")

	self._listView:setScrollBarEnabled(false)
end

function SkillTipWidget:refreshInfo(skill, isHero)
	self._skill = skill or self._skill

	self._name:setString(self._skill:getName())
	self._icon:removeChildByName("SkillType1")
	self._icon:removeChildByName("SkillType2")

	if isHero then
		local var_5_0 = self._skill:getType()

		if not var_5_0 then
			var_5_0 = self._skill:getSkillType()

			local skillType = var_5_0
			local icon1, icon2, typeName

			if isHero then
				icon1, icon2 = self._mediator._heroSystem:getSkillTypeIcon(skillType)
				typeName = self._mediator._heroSystem:getSkillTypeName(skillType)
			else
				icon1, icon2 = self._mediator._masterSystem:getSkillTypeIcon(skillType)
				typeName = self._mediator._masterSystem:getSkillTypeName(skillType)
			end

			local skillTypeBg = ccui.Scale9Sprite:create(icon2)

			skillTypeBg:addTo(self._icon):posite(14, 14)
			skillTypeBg:setName("SkillType2")
			skillTypeBg:setCapInsets(cc.rect(4, 15, 6, 16))
			skillTypeBg:setAnchorPoint(cc.p(0, 0.5))

			local skillTypeIcon = ccui.ImageView:create(icon1)

			skillTypeIcon:addTo(self._icon):posite(14, 14)
			skillTypeIcon:setName("SkillType1")
			skillTypeIcon:setScale(0.8)

			local typeNameLabel = self._icon:getChildByName("name")

			typeNameLabel:setString(typeName)
			typeNameLabel:setTextColor(GameStyle:getSkillTypeColor(skillType))
			typeNameLabel:setLocalZOrder(2)

			local width = typeNameLabel:getContentSize().width + 30

			skillTypeBg:setContentSize(cc.size(width, 38))
			self._icon:setContentSize(cc.size(width, 32))
			self:refreshDesc(isHero)
		end
	end
end

function SkillTipWidget:refreshDesc(isHero)
	self._listView:removeAllItems()

	local height = 0

	if isHero then
		if self._skill:getDesc() and self._skill:getDesc() ~= "" then
			local newPanel = self:createSkillDescPanel(self._skill:getDesc())

			height = height + newPanel:getContentSize().height

			self._listView:pushBackCustomItem(newPanel)
		end

		local skillProto = PrototypeFactory:getInstance():getSkillPrototype(self._skill:getSkillProId())

		if not skillProto then
			return
		end

		local attrDescs = skillProto:getAttrDescs(self._skill:getLevel(), {
			fontSize = 16
		}) or {}

		for i = 1, #attrDescs do
			local newPanel = self:createEffectDescPanel(attrDescs[i])

			height = height + newPanel:getContentSize().height

			self._listView:pushBackCustomItem(newPanel)
		end
	else
		if self._skill:getMasterSkillDescKey() and self._skill:getMasterSkillDescKey() ~= "" then
			local newPanel = self:createSkillDescPanel(self._skill:getMasterSkillDescKey())

			height = height + newPanel:getContentSize().height

			self._listView:pushBackCustomItem(newPanel)
		end

		local skillProto = PrototypeFactory:getInstance():getSkillPrototype(self._skill:getId())

		if not skillProto then
			return
		end

		local attrDescs = skillProto:getAttrDescs(self._skill:getLevel()) or {}

		for i = 1, #attrDescs do
			local newPanel = self:createEffectDescPanel(attrDescs[i])

			height = height + newPanel:getContentSize().height

			self._listView:pushBackCustomItem(newPanel)
		end
	end

	self._listView:setContentSize(cc.size(listWidth, height))
	self._bg:setContentSize(cc.size(300, height + 80))
end

function SkillTipWidget:createSkillDescPanel(title, otherHeight)
	otherHeight = otherHeight or 6

	local layout = ccui.Layout:create()
	local desc = ConfigReader:getEffectDesc("Skill", title, self._skill:getSkillProId(), self._skill:getLevel(), {
		fontSize = 16
	})
	local label = ccui.RichText:createWithXML(desc, {})

	label:setVerticalSpace(4)
	label:renderContent()
	label:ignoreContentAdaptWithSize(false)
	label:setContentSize(listWidth, 0)
	label:rebuildElements()
	label:formatText()
	label:setAnchorPoint(cc.p(0, 1))
	label:renderContent()

	local height = label:getContentSize().height

	layout:setContentSize(cc.size(listWidth, height + otherHeight))
	label:addTo(layout)
	label:setPosition(cc.p(0, height + otherHeight))

	return layout
end

function SkillTipWidget:createEffectDescPanel(desc, otherHeight)
	otherHeight = otherHeight or 6

	local layout = ccui.Layout:create()
	local label = ccui.RichText:createWithXML(desc, {})

	label:setVerticalSpace(4)
	label:renderContent()
	label:ignoreContentAdaptWithSize(false)
	label:setContentSize(listWidth, 0)
	label:rebuildElements()
	label:formatText()
	label:setAnchorPoint(cc.p(0, 1))
	label:renderContent()

	local height = label:getContentSize().height

	layout:setContentSize(cc.size(listWidth, height + otherHeight))
	label:addTo(layout)
	label:setPosition(cc.p(0, height + otherHeight))

	return layout
end

function SkillTipWidget:getWidth()
	return self._bg:getContentSize().width
end

function SkillTipWidget:getHeight()
	return self._bg:getContentSize().height
end
