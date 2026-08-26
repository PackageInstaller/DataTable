-- chunkname: @modules/logic/versionactivity2_7/act191/view/item/Act191CharacterInfo.lua

module("modules.logic.versionactivity2_7.act191.view.item.Act191CharacterInfo", package.seeall)

local Act191CharacterInfo = class("Act191CharacterInfo", LuaCompBase)

function Act191CharacterInfo:init(go)
	self._go = go
	self.goSkill = gohelper.findChild(go, "go_characterinfo/go_skill")
	self.txtPassiveName = gohelper.findChildText(go, "go_characterinfo/passiveskill/bg/txt_passivename")
	self.btnPassiveSkill = gohelper.findChildButtonWithAudio(go, "go_characterinfo/passiveskill/btn_passiveskill")

	self.addClickCb(self, self.btnPassiveSkill, self.onClickPassiveSkill, self)

	for i = 1, 5 do
		local attributeGo = gohelper.findChild(go, "go_characterinfo/attribute/go_attribute/attribute" .. i)

		self["txtAttr" .. i] = gohelper.findChildText(attributeGo, "txt_attribute")
		self["txtAttrName" .. i] = gohelper.findChildText(attributeGo, "name")
	end

	self.goPassiveSkill = gohelper.findChild(go, "go_characterinfo/passiveskill/go_passiveskills")

	for i = 1, 3 do
		self["goPassiveSkill" .. i] = gohelper.findChild(self.goPassiveSkill, "passiveskill" .. i)
	end

	self._detailPassiveTables = {}
	self.goDetail = gohelper.findChild(go, "go_detailView")
	self.btnCloseDetail = gohelper.findChildButtonWithAudio(self.goDetail, "btn_detailClose")
	self.goDetailItem = gohelper.findChild(self.goDetail, "scroll_content/viewport/content/go_detailpassiveitem")

	self.addClickCb(self, self.btnCloseDetail, self.onClickCloseDetail, self)

	self._skillContainer = MonoHelper.addNoUpdateLuaComOnceToGo(self.goSkill, Act191SkillContainer)
end

function Act191CharacterInfo:onDestroy()
	return
end

function Act191CharacterInfo:setData(roleCo)
	self.config = roleCo
	self.passiveSkillIds = Activity191Config.instance:getHeroPassiveSkillIdList(roleCo.id)

	local attrCo = lua_activity191_template.configDict[roleCo.id]

	for i = 1, 5 do
		local attrId = Activity191Enum.AttrIdList[i]

		self["txtAttrName" .. i].text = HeroConfig.instance:getHeroAttributeCO(attrId).name
		self["txtAttr" .. i].text = attrCo[Activity191Config.AttrIdToFieldName[attrId]]
	end

	local skillCo = lua_skill.configDict[self.passiveSkillIds[1]]

	if skillCo then
		self.txtPassiveName.text = skillCo.name
	end

	local maxRank = roleCo.type == Activity191Enum.CharacterType.Hero and #SkillConfig.instance:getheroranksCO(roleCo.roleId) - 1 or 0

	for i = 1, 3 do
		local go = self["goPassiveSkill" .. i]

		gohelper.setActive(go, i <= maxRank)
	end

	self._skillContainer:setData(roleCo)
end

function Act191CharacterInfo:onClickPassiveSkill()
	if self.config.type == Activity191Enum.CharacterType.Hero then
		local info = {}

		info.id = self.config.id
		info.tipPos = Vector2.New(851, -59)
		info.buffTipsX = 1603
		info.anchorParams = {
			Vector2.New(0, 0.5),
			Vector2.New(0, 0.5)
		}

		ViewMgr.instance:openView(ViewName.Act191CharacterTipView, info)
	else
		self:refreshPassiveDetail()
		gohelper.setActive(self.goDetail, true)
	end
end

function Act191CharacterInfo:refreshPassiveDetail()
	local passiveSkillCount = #self.passiveSkillIds

	for i = 1, passiveSkillCount do
		local passiveSkillId = tonumber(self.passiveSkillIds[i])
		local skillConfig = lua_skill.configDict[passiveSkillId]

		if skillConfig then
			local detailPassiveTable = self._detailPassiveTables[i]

			if not detailPassiveTable then
				local detailPassiveGO = gohelper.cloneInPlace(self.goDetailItem, "item" .. i)

				detailPassiveTable = self:getUserDataTb_()
				detailPassiveTable.go = detailPassiveGO
				detailPassiveTable.name = gohelper.findChildText(detailPassiveGO, "title/txt_name")
				detailPassiveTable.icon = gohelper.findChildSingleImage(detailPassiveGO, "title/simage_icon")
				detailPassiveTable.desc = gohelper.findChildText(detailPassiveGO, "txt_desc")

				SkillHelper.addHyperLinkClick(detailPassiveTable.desc, self.onClickHyperLink, self)

				detailPassiveTable.line = gohelper.findChild(detailPassiveGO, "txt_desc/image_line")

				table.insert(self._detailPassiveTables, detailPassiveTable)
			end

			detailPassiveTable.name.text = skillConfig.name
			detailPassiveTable.desc.text = SkillHelper.getSkillDesc(self.config.name, skillConfig)

			gohelper.setActive(detailPassiveTable.go, true)
			gohelper.setActive(detailPassiveTable.line, i < passiveSkillCount)
		else
			logError(string.format("被动技能配置没找到, id: %d", passiveSkillId))
		end
	end

	for i = passiveSkillCount + 1, #self._detailPassiveTables do
		gohelper.setActive(self._detailPassiveTables[i].go, false)
	end
end

function Act191CharacterInfo:onClickCloseDetail()
	gohelper.setActive(self.goDetail, false)
end

function Act191CharacterInfo:onClickHyperLink(effectId)
	local pos = Vector2.New(40, 0)

	CommonBuffTipController:openCommonTipViewWithCustomPos(effectId, pos)
end

return Act191CharacterInfo
