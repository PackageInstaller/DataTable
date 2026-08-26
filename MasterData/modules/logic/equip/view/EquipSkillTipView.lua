-- chunkname: @modules/logic/equip/view/EquipSkillTipView.lua

module("modules.logic.equip.view.EquipSkillTipView", package.seeall)

local EquipSkillTipView = class("EquipSkillTipView", BaseView)

function EquipSkillTipView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._goskill = gohelper.findChild(self.viewGO, "#go_skill")
	self._btnclosedetail = gohelper.findChildButtonWithAudio(self.viewGO, "#go_skill/#btn_closedetail")
	self._gocontent = gohelper.findChild(self.viewGO, "#go_skill/Scroll View/Viewport/#go_content")
	self._txtattributelv = gohelper.findChildText(self.viewGO, "#go_skill/Scroll View/Viewport/#go_content/attributename/#txt_attributelv")
	self._txtmeshcurlevel = gohelper.findChildText(self.viewGO, "#go_skill/Scroll View/Viewport/#go_content/#go_suiteffect/#txt_meshcurlevel")
	self._txtmeshalllevel = gohelper.findChildTextMesh(self.viewGO, "#go_skill/Scroll View/Viewport/#go_content/allleveldesc/#txtmesh_alllevel")
	self._gocharacter = gohelper.findChild(self.viewGO, "#go_character")
	self._scrollcharacter = gohelper.findChildScrollRect(self.viewGO, "#go_character/#scroll_character")
	self._txttitle = gohelper.findChildText(self.viewGO, "#go_character/#txt_title")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function EquipSkillTipView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnclosedetail:AddClickListener(self._btnclosedetailOnClick, self)
end

function EquipSkillTipView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnclosedetail:RemoveClickListener()
end

function EquipSkillTipView:_btncloseOnClick()
	self:closeThis()
end

function EquipSkillTipView:_btnclosedetailOnClick()
	self:hideCharacter()
end

function EquipSkillTipView:_editableInitView()
	self._hyperLinkClick = gohelper.onceAddComponent(self._txtmeshalllevel.gameObject, typeof(ZProj.TMPHyperLinkClick))

	self._hyperLinkClick:SetClickListener(self._onHyperLinkClick, self)

	self._hyperLinkClick2 = gohelper.onceAddComponent(self._txtmeshcurlevel.gameObject, typeof(ZProj.TMPHyperLinkClick))

	self._hyperLinkClick2:SetClickListener(self._onHyperLinkClick, self)
end

function EquipSkillTipView:_onHyperLinkClick()
	self:showCharacter()
end

function EquipSkillTipView:onUpdateParam()
	return
end

function EquipSkillTipView:onOpen()
	self._equipMO = self.viewParam[1]

	if self._equipMO then
		self._equipId = self._equipMO.config.id or self.viewParam[2]
	end

	self._showCharacter = self.viewParam[3]
	self._characterScreenPos = self.viewParam[4]

	if self._equipMO then
		self._config = self._equipMO.config or EquipConfig.instance:getEquipCo(self._equipId)
	end

	if self._equipMO then
		self._breakLv = self._equipMO.breakLv or EquipConfig.instance:getMaxBreakLevel()
	end

	if self._equipMO then
		self._level = self._equipMO.level or EquipConfig.instance:getMaxLevel(self._breakLv)
	end

	if self._equipMO then
		self._refineLv = self._equipMO.refineLv or 1
	end

	self._equipSkillCo = EquipConfig.instance:getEquipSkillCfg(self._config.skillType, self._refineLv)

	gohelper.setActive(self._gocharacter, false)
	gohelper.setActive(self._goskill, false)
	gohelper.setActive(self._btnclosedetail.gameObject, false)

	if self._showCharacter then
		self:showCharacter()
	else
		self:showSkill()
	end

	NavigateMgr.instance:addEscape(ViewName.EquipSkillTipView, self._btncloseOnClick, self)
end

function EquipSkillTipView:showCharacter()
	gohelper.setActive(self._gocharacter, true)

	self._txttitle.text = string.format(luaLang("equip_suitable_characters"), self._config.feature)

	if not string.nilorempty(self._config.cardGroup) then
		local specials = string.split(self._config.cardGroup, "|")
		local t = {}

		for i, v in ipairs(specials) do
			table.insert(t, {
				id = tonumber(v)
			})
		end

		EquipSkillCharacterListModel.instance:setList(t)
	end

	if self._characterScreenPos then
		local localPos = recthelper.screenPosToAnchorPos(self._characterScreenPos, self.viewGO.transform)

		recthelper.setAnchor(self._gocharacter.transform, localPos.x, localPos.y)
	end

	gohelper.setActive(self._btnclosedetail.gameObject, true)
end

function EquipSkillTipView:hideCharacter()
	gohelper.setActive(self._gocharacter, false)
	gohelper.setActive(self._btnclosedetail.gameObject, false)
end

function EquipSkillTipView:showSkill()
	gohelper.setActive(self._goskill, true)
	self:showCurLevel()
	self:showAllLevel()
end

function EquipSkillTipView:showCurLevel()
	local equipSkillCo = EquipConfig.instance:getEquipSkillCfg(self._config.skillType, self._refineLv)

	self._txtattributelv.text = equipSkillCo.skillLv + 1
	self._txtmeshcurlevel.text = string.format("%s", HeroSkillModel.instance:spotSkillAttribute(equipSkillCo.baseDesc))
end

function EquipSkillTipView:showAllLevel()
	local skillType = self._config.skillType

	if skillType <= 0 then
		return
	end

	local oldHeight = self._txtmeshalllevel.preferredHeight
	local str = ""

	self._curSkillCfg = EquipConfig.instance:getEquipSkillCfg(skillType, self._refineLv)

	for i, v in pairs(lua_equip_skill.configDict[skillType]) do
		if i > 0 then
			local line = string.format("Lv.%s:%s", i + 1, HeroSkillModel.instance:spotSkillAttribute(v.upDesc))

			if not LuaUtil.isEmptyStr(v.spUpDesc) then
				line = string.format("%s\n<#4b93d6><u><link='%s'>[%s]</link></u></color>:%s", line, i, self._config.feature, HeroSkillModel.instance:spotSkillAttribute(v.spUpDesc))
			end

			if v == self._curSkillCfg then
				line = string.format("<#805e00>%s</color>", line)
			end

			str = str == "" and line or string.format("%s\n%s", str, line)
		end
	end

	self._txtmeshalllevel.text = str

	local deltaHeight = self._txtmeshalllevel.preferredHeight - oldHeight
	local h = recthelper.getHeight(self._gocontent.transform)

	recthelper.setHeight(self._gocontent.transform, h + deltaHeight)
end

function EquipSkillTipView:onClose()
	return
end

function EquipSkillTipView:onDestroyView()
	return
end

return EquipSkillTipView
