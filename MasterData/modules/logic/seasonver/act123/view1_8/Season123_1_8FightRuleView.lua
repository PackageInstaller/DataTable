-- chunkname: @modules/logic/seasonver/act123/view1_8/Season123_1_8FightRuleView.lua

module("modules.logic.seasonver.act123.view1_8.Season123_1_8FightRuleView", package.seeall)

local Season123_1_8FightRuleView = class("Season123_1_8FightRuleView", BaseView)

function Season123_1_8FightRuleView:onInitView()
	self._content = gohelper.findChild(self.viewGO, "mask/Scroll View/Viewport/Content")
	self._simagedecorate = gohelper.findChildSingleImage(self.viewGO, "mask/#simage_decorate")
	self._goItem = gohelper.findChild(self._content, "#go_ruleitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Season123_1_8FightRuleView:addEvents()
	return
end

function Season123_1_8FightRuleView:removeEvents()
	return
end

function Season123_1_8FightRuleView:_editableInitView()
	gohelper.setActive(self._goItem, false)
end

function Season123_1_8FightRuleView:onOpen()
	self:refreshRule()
end

function Season123_1_8FightRuleView:refreshRule()
	local dataList = Season123_1_8FightRuleView.getRuleList() or {}

	self.itemList = self.itemList or self:getUserDataTb_()

	for i = 1, math.max(#self.itemList, #dataList) do
		local data = dataList[i]

		if not self.itemList[i] then
			local item = self:createItem(i)

			self:updateItem(self.itemList[i], data)
		end
	end

	self:setDecorateVisible(#dataList <= 1)
end

function Season123_1_8FightRuleView:createItem(index)
	local item = {}
	local go = gohelper.clone(self._goItem, self._content, string.format("item%s", index))

	item.go = go
	item.txtEffectDesc = gohelper.findChildTextMesh(go, "txt_effectdesc")
	item.imgTag = gohelper.findChildImage(go, "rulecontain/image_tag")
	item.imgIcon = gohelper.findChildImage(go, "rulecontain/image_icon")
	self.itemList[index] = item

	return item
end

function Season123_1_8FightRuleView:updateItem(item, data)
	if not data or string.nilorempty(data[2]) then
		gohelper.setActive(item.go, false)

		return
	end

	gohelper.setActive(item.go, true)

	local config = lua_rule.configDict[data[2]]
	local targetId = data[1]
	local tagColor = {
		"#6680bd",
		"#d05b4c",
		"#c7b376"
	}
	local descContent = string.gsub(config.desc, "%【(.-)%】", "<color=#6680bd>[%1]</color>")
	local wordContent = "\n" .. HeroSkillModel.instance:getEffectTagDescFromDescRecursion(config.desc, tagColor[1])
	local side = luaLang("dungeon_add_rule_target_" .. targetId)
	local color = tagColor[targetId]

	item.txtEffectDesc.text = string.format("<color=%s>[%s]</color>%s%s", color, side, descContent, wordContent)

	UISpriteSetMgr.instance:setCommonSprite(item.imgTag, "wz_" .. data[1])
	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(item.imgIcon, config.icon)
end

function Season123_1_8FightRuleView:destroyItem(item)
	return
end

function Season123_1_8FightRuleView.getRuleList()
	local fightParam = FightModel.instance:getFightParam()

	if not fightParam then
		return
	end

	local battleConfig = lua_battle.configDict[fightParam.battleId]

	if not battleConfig then
		return
	end

	local additionRule = battleConfig.additionRule
	local data_list = GameUtil.splitString2(additionRule, true, "|", "#")
	local context = Season123Model.instance:getBattleContext()

	if context then
		data_list = Season123HeroGroupModel.filterRule(context.actId, data_list)

		if context.stage then
			data_list = Season123Config.instance:filterRule(data_list, context.stage)
		end
	end

	return data_list
end

function Season123_1_8FightRuleView:setDecorateVisible(isVisible)
	gohelper.setActive(self._simagedecorate.gameObject, isVisible)

	if isVisible then
		self._simagedecorate:LoadImage(ResUrl.getSeasonIcon("img_zs2.png"))
	end
end

function Season123_1_8FightRuleView:onClose()
	return
end

function Season123_1_8FightRuleView:onDestroyView()
	if self.itemList then
		for k, v in pairs(self.itemList) do
			self:destroyItem(v)
		end

		self.itemList = nil
	end
end

return Season123_1_8FightRuleView
