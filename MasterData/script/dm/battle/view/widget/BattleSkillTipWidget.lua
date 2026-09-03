-- chunkname: @/tmp/or_script/lua_compile/dm/battle/view/widget/BattleSkillTipWidget.lua

BattleSkillTipWidget = class("BattleSkillTipWidget", BattleWidget, _M)

function BattleSkillTipWidget:initialize(view)
	super.initialize(self, view)
	self:_setupUI()
end

function BattleSkillTipWidget:_setupUI()
	self._bg = self:getView():getChildByFullName("bg"):offset(0, -3)
	self._bgWidth = self._bg:getContentSize().width

	local descLabel = self:getView():getChildByFullName("skillDesc")

	descLabel:setVisible(false)

	local richText = ccui.RichText:createWithXML("", {})

	richText:setAnchorPoint(descLabel:getAnchorPoint())
	richText:setPosition(cc.p(descLabel:getPosition()))
	richText:addTo(descLabel:getParent())

	self._desc = richText
	self._descWidth = descLabel:getContentSize().width
end

function BattleSkillTipWidget:showSkillTip(skillId, level)
	if skillId then
		::label_3_0::

		local config = ConfigReader:getRecordById("Skill", skillId)

		if config == nil then
			return
		end

		local descKey = config.Desc_short

		if descKey == nil or descKey == "" then
			return
		end

		local desc = ConfigReader:getEffectDesc("Skill", descKey, skillId, level)
		local tmpl = TextTemplate:new(desc)

		desc = tmpl:stringify({
			fontSize = 12,
			fontName = TTF_FONT_FZYH_R
		})

		self._desc:setString(desc)
		self._desc:ignoreContentAdaptWithSize(true)
		self._desc:rebuildElements()
		self._desc:formatText()
		self._desc:renderContent(self._descWidth, 0)
		self._bg:setContentSize(cc.size(self._bgWidth, self._desc:getContentSize().height + 9))
		self:getView():setVisible(true)
	end
end

function BattleSkillTipWidget:hide()
	self:getView():setVisible(false)
end

function BattleSkillTipWidget:setPosition(pos)
	self:getView():setPosition(self:getView():getParent():convertToNodeSpace(pos))

	local rightPos = self._bg:convertToWorldSpace(cc.p(self._bgWidth, 0))

	if rightPos.x > AdjustUtils.winSize.width - AdjustUtils.safeAreaInset.right then
		self:getView():offset(AdjustUtils.winSize.width - AdjustUtils.safeAreaInset.right - rightPos.x, 0)
	end
end
