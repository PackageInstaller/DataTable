-- chunkname: @modules/logic/versionactivity2_3/act174/view/info/Act174CharacterInfo.lua

module("modules.logic.versionactivity2_3.act174.view.info.Act174CharacterInfo", package.seeall)

local Act174CharacterInfo = class("Act174CharacterInfo", LuaCompBase)

function Act174CharacterInfo:ctor(teamView)
	self._view = teamView
end

Act174CharacterInfo.AttrIdList = {
	CharacterEnum.AttrId.Attack,
	CharacterEnum.AttrId.Defense,
	CharacterEnum.AttrId.Technic,
	CharacterEnum.AttrId.Hp,
	CharacterEnum.AttrId.Mdefense
}

function Act174CharacterInfo:init(go)
	self._go = go
	self.imageDmgType = gohelper.findChildImage(go, "go_characterinfo/image_dmgtype")
	self.imageRare = gohelper.findChildImage(go, "go_characterinfo/character/rare")
	self.heroIcon = gohelper.findChildSingleImage(go, "go_characterinfo/character/heroicon")
	self.imageCareer = gohelper.findChildImage(go, "go_characterinfo/character/career")
	self.txtName = gohelper.findChildText(go, "go_characterinfo/name/txt_name")
	self.goSkill = gohelper.findChild(go, "go_characterinfo/go_skill")
	self.txtPassiveName = gohelper.findChildText(go, "go_characterinfo/passiveskill/bg/txt_passivename")
	self.btnPassiveSkill = gohelper.findChildButtonWithAudio(go, "go_characterinfo/passiveskill/btn_passiveskill")

	self.addClickCb(self, self.btnPassiveSkill, self.onClickPassiveSkill, self)

	for i = 1, 5 do
		local attributeGo = gohelper.findChild(go, "go_characterinfo/attribute/go_attribute/attribute" .. i)

		self["txtAttr" .. i] = gohelper.findChildText(attributeGo, "txt_attribute")
		self["txtAttrName" .. i] = gohelper.findChildText(attributeGo, "name")
	end

	for i = 1, 3 do
		self["goPassiveSkill" .. i] = gohelper.findChild(go, "go_characterinfo/passiveskill/go_passiveskills/passiveskill" .. i)
	end

	self._detailPassiveTables = {}
	self.goDetail = gohelper.findChild(go, "go_characterinfo/go_detailView")

	if self.goDetail then
		self.btnCloseDetail = gohelper.findChildButtonWithAudio(go, "go_characterinfo/go_detailView/btn_detailClose")
		self.goDetailItem = gohelper.findChild(go, "go_characterinfo/go_detailView/scroll_content/viewport/content/go_detailpassiveitem")

		self.addClickCb(self, self.btnCloseDetail, self.onClickCloseDetail, self)
	end

	if self._view then
		if self._view.__cname == "Act174GameTeamView" then
			self.skillItem1 = self:getUserDataTb_()
			self.skillItem1.btnSkill = gohelper.findChildButtonWithAudio(self.goSkill, "line/go_skills/skillicon1/btn_first")
			self.skillItem1.gogray = gohelper.findChild(self.goSkill, "line/go_skills/skillicon1/btn_first/grey")
			self.skillItem1.gohighlight = gohelper.findChild(self.goSkill, "line/go_skills/skillicon1/btn_first/highlight")

			self.addClickCb(self, self.skillItem1.btnSkill, self.onClickSkill, self, 1)

			self.skillItem2 = self:getUserDataTb_()
			self.skillItem2.btnSkill = gohelper.findChildButtonWithAudio(self.goSkill, "line/go_skills/skillicon2/btn_first")
			self.skillItem2.gogray = gohelper.findChild(self.goSkill, "line/go_skills/skillicon2/btn_first/grey")
			self.skillItem2.gohighlight = gohelper.findChild(self.goSkill, "line/go_skills/skillicon2/btn_first/highlight")

			self.addClickCb(self, self.skillItem2.btnSkill, self.onClickSkill, self, 2)

			self.btnUnEquip = gohelper.findChildButtonWithAudio(go, "go_characterinfo/btn_unequip")

			self.addClickCb(self, self.btnUnEquip, self.onClickUnEquip, self)
		end

		self.goNoneCollection = gohelper.findChild(go, "go_characterinfo/go_collection/none")
		self.goCollection = gohelper.findChild(go, "go_characterinfo/go_collection/equip")
		self.colletionRare = gohelper.findChildImage(go, "go_characterinfo/go_collection/equip/rare")
		self.collectionIcon = gohelper.findChildSingleImage(go, "go_characterinfo/go_collection/equip/collectionicon")
		self.btnCollection = gohelper.findChildButtonWithAudio(go, "go_characterinfo/go_collection/equip/collectionicon")

		self.addClickCb(self, self.btnCollection, self.onClickCollection, self)
	end

	self._skillContainer = MonoHelper.addNoUpdateLuaComOnceToGo(self.goSkill, Act174SkillContainer)
end

function Act174CharacterInfo:onDestroy()
	if self.heroIcon then
		self.heroIcon:UnLoadImage()
	end

	if self.collectionIcon then
		self.collectionIcon:UnLoadImage()
	end
end

function Act174CharacterInfo:setData(roleCo, collectionId, index)
	self.config = roleCo
	self.collectionId = collectionId
	self.index = index

	local iconPath = ResUrl.getHeadIconSmall(roleCo.skinId)

	if self.heroIcon then
		self.heroIcon:LoadImage(iconPath)
		UISpriteSetMgr.instance:setCommonSprite(self.imageRare, "bgequip" .. tostring(CharacterEnum.Color[roleCo.rare]))
		UISpriteSetMgr.instance:setCommonSprite(self.imageCareer, "lssx_" .. roleCo.career)
	end

	if self.imageDmgType then
		UISpriteSetMgr.instance:setCommonSprite(self.imageDmgType, "dmgtype" .. tostring(roleCo.dmgType))
	end

	self.txtName.text = roleCo.name

	local attrCo = lua_activity174_template.configDict[roleCo.id]

	for i = 1, 5 do
		local attrId = Act174CharacterInfo.AttrIdList[i]

		self["txtAttrName" .. i].text = lua_character_attribute.configDict[attrId].name
	end

	self["txtAttr" .. 1].text = attrCo.attack
	self["txtAttr" .. 2].text = attrCo.defense
	self["txtAttr" .. 3].text = attrCo.technic
	self["txtAttr" .. 4].text = attrCo.life
	self["txtAttr" .. 5].text = attrCo.mdefense

	local skillIds = string.splitToNumber(roleCo.passiveSkill, "|")

	self.txtPassiveName.text = lua_skill.configDict[skillIds[1]].name

	local maxRank = roleCo.type == Activity174Enum.CharacterType.Hero and #SkillConfig.instance:getheroranksCO(roleCo.heroId) - 1 or 0

	for i = 1, 3 do
		local go = self["goPassiveSkill" .. i]

		gohelper.setActive(go, i <= maxRank)
	end

	self._skillContainer:onUpdateMO(roleCo)

	if self._view and self._view.__cname == "Act174GameTeamView" then
		self.skillIndex = self._view:getPriorSkill(self.config.id)
	end

	self:refreshSkillPrior()
	self:refreshCollectionInfo()
end

function Act174CharacterInfo:onClickPassiveSkill()
	self:refreshPassiveDetail()
	gohelper.setActive(self.goDetail, true)
end

function Act174CharacterInfo:onClickSkill(index)
	if index == self.skillIndex then
		index = nil
	end

	self._view:setPriorSkill(self.config.id, index)

	self.skillIndex = index

	self:refreshSkillPrior()
end

function Act174CharacterInfo:refreshCollectionInfo()
	if self._view then
		if self.collectionId then
			local collectionCo = Activity174Config.instance:getCollectionCo(self.collectionId)

			UISpriteSetMgr.instance:setAct174Sprite(self.colletionRare, "act174_propitembg_" .. collectionCo.rare)
			self.collectionIcon:LoadImage(ResUrl.getRougeSingleBgCollection(collectionCo.icon))
		end

		gohelper.setActive(self.goCollection, self.collectionId)
		gohelper.setActive(self.goNoneCollection, not self.collectionId)
	else
		gohelper.setActive(self.goCollection, false)
		gohelper.setActive(self.goNoneCollection, true)
	end
end

function Act174CharacterInfo:refreshSkillPrior()
	if self._view and self._view.__cname == "Act174GameTeamView" then
		local isFirst = self.skillIndex == 1

		gohelper.setActive(self.skillItem1.gohighlight, isFirst)
		gohelper.setActive(self.skillItem1.gogray, not isFirst)

		local isSecond = self.skillIndex == 2

		gohelper.setActive(self.skillItem2.gohighlight, isSecond)
		gohelper.setActive(self.skillItem2.gogray, not isSecond)
	end
end

function Act174CharacterInfo:onClickCollection()
	if self.collectionId then
		local viewParam = {}

		viewParam.type = Activity174Enum.ItemTipType.Collection
		viewParam.co = Activity174Config.instance:getCollectionCo(self.collectionId)
		viewParam.showMask = true

		Activity174Controller.instance:openItemTipView(viewParam)
	end
end

function Act174CharacterInfo:refreshPassiveDetail()
	local roleId = self.config.id
	local wareHouseMo = Activity174Model.instance:getActInfo():getGameInfo():getWarehouseInfo()
	local isRepleace = not not tabletool.indexOf(wareHouseMo.enhanceRoleList, roleId)
	local passiveSkillIds = Activity174Config.instance:getHeroPassiveSkillIdList(roleId, isRepleace)
	local passiveSkillCount = #passiveSkillIds

	for i = 1, passiveSkillCount do
		local passiveSkillId = tonumber(passiveSkillIds[i])
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

function Act174CharacterInfo:onClickCloseDetail()
	gohelper.setActive(self.goDetail, false)
end

function Act174CharacterInfo:onClickHyperLink(effectId, clickPosition)
	local pos = Vector2.New(0, 0)

	CommonBuffTipController:openCommonTipViewWithCustomPos(effectId, pos)
end

function Act174CharacterInfo:onClickUnEquip()
	if self._view and self._view.__cname == "Act174GameTeamView" then
		self._view:UnInstallHero(self.index)
		gohelper.setActive(self._go, false)
	end
end

return Act174CharacterInfo
