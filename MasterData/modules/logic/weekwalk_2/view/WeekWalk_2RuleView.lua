-- chunkname: @modules/logic/weekwalk_2/view/WeekWalk_2RuleView.lua

module("modules.logic.weekwalk_2.view.WeekWalk_2RuleView", package.seeall)

local WeekWalk_2RuleView = class("WeekWalk_2RuleView", BaseView)

function WeekWalk_2RuleView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "#simage_icon")
	self._goruleitem = gohelper.findChild(self.viewGO, "rule/#go_ruleitem")
	self._goruleDescList = gohelper.findChild(self.viewGO, "rule/#go_ruleDescList")
	self._btnclose2 = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close2")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function WeekWalk_2RuleView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnclose2:AddClickListener(self._btncloseOnClick, self)
end

function WeekWalk_2RuleView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnclose2:RemoveClickListener()
end

function WeekWalk_2RuleView:_btncloseOnClick()
	self:closeThis()
end

function WeekWalk_2RuleView:_editableInitView()
	self._childGoList = self:getUserDataTb_()
	self._rulesimagelineList = self:getUserDataTb_()
	self._info = WeekWalk_2Model.instance:getInfo()

	self._simagebg:LoadImage(ResUrl.getWeekWalkBg("full/guize_beijing.jpg"))
end

function WeekWalk_2RuleView:onUpdateParam()
	if self._rulesimagelineList then
		for key, _ in pairs(self._rulesimagelineList) do
			rawset(self._rulesimagelineList, key, nil)
		end
	end

	if self._childGoList then
		for key, go in pairs(self._childGoList) do
			gohelper.destroy(go)
			rawset(self._childGoList, key, nil)
		end
	end

	self:_refreshView()
end

function WeekWalk_2RuleView:onOpen()
	self:_refreshView()
end

function WeekWalk_2RuleView:_refreshView()
	local issueId

	if self.viewParam then
		issueId = self.viewParam.issueId
	elseif self._info then
		issueId = self._info.issueId
	end

	if not issueId then
		logError("WeekWalk_2RuleView._refreshView, issueId can not be nil!")

		return
	end

	local ruleConfig = lua_weekwalk_ver2_time.configDict[issueId]
	local isIncludeCn = false
	local icon

	self._simageicon:LoadImage(isIncludeCn and ResUrl.getWeekWalkIconLangPath(ruleConfig.ruleIcon) or ResUrl.getWeekWalkBg("rule/" .. ruleConfig.ruleIcon .. ".png"))

	local ruleList = {}

	if not string.nilorempty(ruleConfig.ruleFront) then
		tabletool.addValues(ruleList, GameUtil.splitString2(ruleConfig.ruleFront, true, "|", "#"))
	end

	if not string.nilorempty(ruleConfig.ruleRear) then
		tabletool.addValues(ruleList, GameUtil.splitString2(ruleConfig.ruleRear, true, "|", "#"))
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

function WeekWalk_2RuleView:_addRuleItem(ruleCo, targetId)
	local go = gohelper.clone(self._goruletemp, self._gorulelist, ruleCo.id)

	table.insert(self._childGoList, go)
	gohelper.setActive(go, true)

	local tagicon = gohelper.findChildImage(go, "#image_tagicon")

	UISpriteSetMgr.instance:setCommonSprite(tagicon, "wz_" .. targetId)

	local simage = gohelper.findChildImage(go, "")

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(simage, ruleCo.icon)
end

function WeekWalk_2RuleView:_setRuleDescItem(ruleCo, targetId)
	local tagColor = {
		"#BDF291",
		"#D05B4C",
		"#C7b376"
	}
	local go = gohelper.clone(self._goruleitem, self._goruleDescList, ruleCo.id)

	table.insert(self._childGoList, go)
	gohelper.setActive(go, true)

	local icon = gohelper.findChildImage(go, "icon")

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(icon, ruleCo.icon)

	local line = gohelper.findChild(go, "line")

	table.insert(self._rulesimagelineList, line)

	local tag = gohelper.findChildImage(go, "tag")

	UISpriteSetMgr.instance:setCommonSprite(tag, "wz_" .. targetId)

	local desc = gohelper.findChildText(go, "desc")
	local descContent = string.gsub(ruleCo.desc, "%【(.-)%】", "<color=#FF906A>[%1]</color>")
	local wordContent = "\n" .. HeroSkillModel.instance:getEffectTagDescFromDescRecursion(ruleCo.desc, tagColor[1])
	local side = luaLang("dungeon_add_rule_target_" .. targetId)
	local color = tagColor[targetId]

	desc.text = string.format("<color=%s>[%s]</color>%s%s", color, side, descContent, wordContent)
end

function WeekWalk_2RuleView:onClose()
	return
end

function WeekWalk_2RuleView:onDestroyView()
	self._simagebg:UnLoadImage()
	self._simageicon:UnLoadImage()
end

return WeekWalk_2RuleView
