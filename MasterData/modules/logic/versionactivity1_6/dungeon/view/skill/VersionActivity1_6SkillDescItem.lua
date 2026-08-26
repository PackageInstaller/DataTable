-- chunkname: @modules/logic/versionactivity1_6/dungeon/view/skill/VersionActivity1_6SkillDescItem.lua

module("modules.logic.versionactivity1_6.dungeon.view.skill.VersionActivity1_6SkillDescItem", package.seeall)

local VersionActivity1_6SkillDescItem = class("VersionActivity1_6SkillDescItem", UserDataDispose)

function VersionActivity1_6SkillDescItem:init(go, skillCfg, view)
	self._skillCfg = skillCfg
	self.go = go
	self.parentView = view
	self.txtlv = gohelper.findChildText(go, "descripteitem/#txt_skillevel")
	self.txtskillDesc = gohelper.findChildText(go, "descripteitem/#txt_descripte")
	self.canvasGroup = gohelper.onceAddComponent(self.txtskillDesc.gameObject, gohelper.Type_CanvasGroup)
	self.txtlvcanvasGroup = gohelper.onceAddComponent(self.txtlv.gameObject, gohelper.Type_CanvasGroup)
	self.goCurLvFlag = gohelper.findChild(go, "descripteitem/#go_curlevel")
	self.vx = gohelper.findChild(go, "descripteitem/vx")
	self.txtCostNum = gohelper.findChildText(go, "descripteitem/#txt_descripte/Prop/#txt_Num")
	self.imageCostIcon = gohelper.findChildImage(go, "descripteitem/#txt_descripte/Prop/#simage_Prop")

	gohelper.setActive(self.vx, false)

	self._needUseSkillEffDescList = {}
	self._needUseSkillEffDescList2 = {}
end

function VersionActivity1_6SkillDescItem:refreshInfo()
	local skillId = self._skillCfg.skillId
	local attrStr = self._skillCfg.attrs

	self.lv = self._skillCfg.level
	self.txtlv.text = self._skillCfg.level
	self._hyperLinkClick = self.txtskillDesc:GetComponent(typeof(ZProj.TMPHyperLinkClick))

	self._hyperLinkClick:SetClickListener(self._onHyperLinkClick, self)

	local attrDesc = ""

	if skillId and skillId ~= 0 then
		local skillEffectCfg = FightConfig.instance:getSkillEffectCO(skillId)

		attrDesc = FightConfig.instance:getSkillEffectDesc(nil, skillEffectCfg)
	elseif attrStr then
		local attributeArr = string.splitToNumber(attrStr, "#")

		attrDesc = self._skillCfg.skillAttrDesc
	end

	attrDesc = HeroSkillModel.instance:formatDescWithColor(attrDesc, "#deaa79", "#7e99d0")
	attrDesc = self:_buildLinkTag(attrDesc)

	local height = GameUtil.getTextHeightByLine(self.txtskillDesc, attrDesc, 28, -3)

	self.height = height + 42

	recthelper.setHeight(self.go.transform, self.height)

	self.txtskillDesc.text = attrDesc
	self._fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(self.txtskillDesc.gameObject, FixTmpBreakLine)

	self._fixTmpBreakLine:refreshTmpContent(self.txtskillDesc)

	local curLvSkillCfg = Activity148Config.instance:getAct148CfgByTypeLv(self._skillCfg.type, self._skillCfg.level)

	if curLvSkillCfg then
		local costStr = curLvSkillCfg.cost
		local attribute = string.splitToNumber(costStr, "#")

		self.txtCostNum.text = attribute[3]
	end

	local currencyCfg = CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.V1a6DungeonSkill)
	local currencyname = string.format("%s_1", currencyCfg and currencyCfg.icon)

	UISpriteSetMgr.instance:setCurrencyItemSprite(self.imageCostIcon, currencyname)
end

function VersionActivity1_6SkillDescItem:_onHyperLinkClick(skillName, clickPosition)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	skillName = self._needUseSkillEffDescList2[tonumber(skillName)]

	if not self._needUseSkillEffDescList[skillName] then
		return
	end

	self.parentView:showBuffContainer(SkillConfig.instance:processSkillDesKeyWords(skillName), self._needUseSkillEffDescList[skillName], clickPosition)
end

function VersionActivity1_6SkillDescItem:_buildLinkTag(desc)
	desc = string.gsub(desc, "】", "]")
	desc = string.gsub(desc, "【", "[")

	local pos, index, arr = 0, 0, {}
	local skillName

	for st, sp in function()
		return string.find(desc, "[%[%]]", pos)
	end do
		index = index + 1
		skillName = string.sub(desc, pos, st - 1)

		if index % 2 == 0 then
			local skillIndex = self:_buildSkillEffDescCo(skillName)

			if skillIndex then
				local showName = SkillConfig.instance:processSkillDesKeyWords(skillName)

				skillName = string.format("<u><link=%s>[%s]</link></u>", skillIndex, showName)
			else
				skillName = string.format("[%s]", skillName)
			end
		end

		table.insert(arr, skillName)

		pos = sp + 1
	end

	table.insert(arr, string.sub(desc, pos))

	return table.concat(arr)
end

function VersionActivity1_6SkillDescItem:_buildSkillEffDescCo(skillName)
	for _, skillCo in ipairs(lua_skill_eff_desc.configList) do
		if skillCo.name == skillName then
			if SkillHelper.canShowTag(skillCo) then
				local index = tabletool.indexOf(self._needUseSkillEffDescList2, skillName)

				if not index then
					index = #self._needUseSkillEffDescList2 + 1
					self._needUseSkillEffDescList2[#self._needUseSkillEffDescList2 + 1] = skillName
				end

				self._needUseSkillEffDescList[skillName] = skillCo.desc

				return index
			else
				return nil
			end
		end
	end
end

return VersionActivity1_6SkillDescItem
