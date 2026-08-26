-- chunkname: @modules/logic/herogroup/view/HeroGroupFightRuleDescView.lua

module("modules.logic.herogroup.view.HeroGroupFightRuleDescView", package.seeall)

local HeroGroupFightRuleDescView = class("HeroGroupFightRuleDescView", BaseView)

function HeroGroupFightRuleDescView:onInitView()
	self._btncloserule = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_closerule")
	self._gorule = gohelper.findChild(self.viewGO, "#go_rule")
	self._goruleDescList = gohelper.findChild(self.viewGO, "#go_rule/#scroll_rule/Viewport/#go_ruleDescList")
	self._goruleitem = gohelper.findChild(self.viewGO, "#go_rule/#scroll_rule/Viewport/#go_ruleDescList/#go_ruleitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function HeroGroupFightRuleDescView:addEvents()
	self._btncloserule:AddClickListener(self._btncloseruleOnClick, self)
end

function HeroGroupFightRuleDescView:removeEvents()
	self._btncloserule:RemoveClickListener()
end

function HeroGroupFightRuleDescView:_editableInitView()
	self._rulesimagelineList = self:getUserDataTb_()
	self._cloneRuleGos = self:getUserDataTb_()

	gohelper.setActive(self._goruleitem, false)
end

function HeroGroupFightRuleDescView:onOpen()
	self:_refreshUI()
end

function HeroGroupFightRuleDescView:_btncloseruleOnClick()
	self:closeThis()

	if self._isHardMode then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.HardModeHideRuleDesc)
	end
end

function HeroGroupFightRuleDescView:_refreshUI()
	local ruleList = self.viewParam.ruleList

	if self.viewParam.offSet then
		recthelper.setAnchor(self._gorule.transform, self.viewParam.offSet[1], self.viewParam.offSet[2])
	end

	if self.viewParam.pivot then
		self._gorule.transform.pivot = self.viewParam.pivot
	end

	for i, v in ipairs(ruleList) do
		local targetId = v[1]
		local ruleId = v[2]
		local ruleCo = lua_rule.configDict[ruleId]

		if ruleCo then
			self:_setRuleDescItem(ruleCo, targetId)
		end

		if i == #ruleList then
			gohelper.setActive(self._rulesimagelineList[i], false)
		end
	end
end

function HeroGroupFightRuleDescView:_setRuleDescItem(ruleCo, targetId)
	local tagColor = {
		"#6680bd",
		"#d05b4c",
		"#c7b376"
	}
	local go = gohelper.clone(self._goruleitem, self._goruleDescList, ruleCo.id)

	gohelper.setActive(go, true)
	table.insert(self._cloneRuleGos, go)

	local icon = gohelper.findChildImage(go, "icon")

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(icon, ruleCo.icon)

	local line = gohelper.findChild(go, "line")

	table.insert(self._rulesimagelineList, line)

	local tag = gohelper.findChildImage(go, "tag")

	UISpriteSetMgr.instance:setCommonSprite(tag, "wz_" .. targetId)

	local desc = gohelper.findChildText(go, "desc")

	SkillHelper.addHyperLinkClick(desc)

	local srcDesc = ruleCo.desc
	local descContent = SkillHelper.buildDesc(srcDesc, nil, "#6680bd")
	local side = luaLang("dungeon_add_rule_target_" .. targetId)
	local color = tagColor[targetId]

	desc.text = formatLuaLang("fight_rule_desc", color, side, descContent)
end

function HeroGroupFightRuleDescView:onClose()
	return
end

function HeroGroupFightRuleDescView:onDestroyView()
	return
end

return HeroGroupFightRuleDescView
