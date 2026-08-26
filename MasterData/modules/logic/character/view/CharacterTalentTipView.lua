-- chunkname: @modules/logic/character/view/CharacterTalentTipView.lua

module("modules.logic.character.view.CharacterTalentTipView", package.seeall)

local CharacterTalentTipView = class("CharacterTalentTipView", BaseView)

function CharacterTalentTipView:onInitView()
	self._goroleAttributeTip = gohelper.findChild(self.viewGO, "#go_roleAttributeTip")
	self._scrollattribute = gohelper.findChildScrollRect(self.viewGO, "#go_roleAttributeTip/#scroll_attribute")
	self._goattributeContent = gohelper.findChild(self.viewGO, "#go_roleAttributeTip/#scroll_attribute/Viewport/#go_attributeContent")
	self._goattributeItem = gohelper.findChild(self.viewGO, "#go_roleAttributeTip/#scroll_attribute/Viewport/#go_attributeContent/#go_attributeItem")
	self._scrollreduce = gohelper.findChildScrollRect(self.viewGO, "#go_roleAttributeTip/#scroll_reduce")
	self._goreducetitle = gohelper.findChild(self.viewGO, "#go_roleAttributeTip/#go_reducetitle")
	self._godampingContent = gohelper.findChild(self.viewGO, "#go_roleAttributeTip/#scroll_reduce/Viewport/#go_dampingContent")
	self._goreduceItem = gohelper.findChild(self.viewGO, "#go_roleAttributeTip/#scroll_reduce/Viewport/#go_dampingContent/#go_reduceItem")
	self._gotip = gohelper.findChild(self.viewGO, "#go_tip")
	self._scrollattributetip = gohelper.findChildScrollRect(self.viewGO, "#go_tip/#scroll_attributetip")
	self._gosingleContent = gohelper.findChild(self.viewGO, "#go_tip/#scroll_attributetip/Viewport/layout/#go_singleContent")
	self._gosingleattributeItem = gohelper.findChild(self.viewGO, "#go_tip/#scroll_attributetip/Viewport/layout/#go_singleContent/#go_singleattributeItem")
	self._goempty = gohelper.findChild(self.viewGO, "#go_roleAttributeTip/#go_empty")
	self._gotrialAttributeTip = gohelper.findChild(self.viewGO, "#go_trialAttributeTip")
	self._gotrialattributeContent = gohelper.findChild(self.viewGO, "#go_trialAttributeTip/scrollview/viewport/content")
	self._gotrialattributeitem = gohelper.findChild(self.viewGO, "#go_trialAttributeTip/scrollview/viewport/content/attrnormalitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterTalentTipView:addEvents()
	self.addClickCb(self, gohelper.getClick(self.viewGO), self.closeThis, self)
end

function CharacterTalentTipView:removeEvents()
	return
end

function CharacterTalentTipView:_editableInitView()
	return
end

function CharacterTalentTipView:onUpdateParam()
	return
end

function CharacterTalentTipView:onOpen()
	self.hero_id = self.viewParam.hero_id
	self.open_type = self.viewParam.open_type
	self.hero_mo_data = self.viewParam.hero_mo or HeroModel.instance:getByHeroId(self.hero_id)
	self._isOwnHero = self.viewParam.isOwnHero

	if self.viewParam.isTrial then
		gohelper.setActive(self._goroleAttributeTip, false)
		gohelper.setActive(self._gotip, false)
		gohelper.setActive(self._gotrialAttributeTip, true)
	else
		gohelper.setActive(self._goroleAttributeTip, self.open_type == 0)
		gohelper.setActive(self._gotrialAttributeTip, false)
		gohelper.setActive(self._gotip, self.open_type ~= 0)
	end

	if self.open_type == 0 then
		self:_showAllattr()
	else
		self:_showSingleCubeAttr(self.viewParam.cube_id)
	end
end

function CharacterTalentTipView:_showSingleCubeAttr(cube_id)
	local attr_tab = {}

	self.hero_mo_data:getTalentStyleCubeAttr(cube_id, attr_tab)

	local temp_list = {}
	local cube_attr_config = self.hero_mo_data:getCurTalentLevelConfig(cube_id)

	for k, v in pairs(attr_tab) do
		table.insert(temp_list, {
			key = k,
			value = v,
			is_special = cube_attr_config.calculateType == 1,
			config = cube_attr_config
		})
	end

	table.sort(temp_list, function(item1, item2)
		return HeroConfig.instance:getIDByAttrType(item1.key) < HeroConfig.instance:getIDByAttrType(item2.key)
	end)
	table.insert(temp_list, 1, {})
	table.insert(temp_list, 1, {})
	gohelper.CreateObjList(self, self._onShowSingleCubeAttrTips, temp_list, self._gosingleContent, self._gosingleattributeItem)
end

function CharacterTalentTipView:_onShowSingleCubeAttrTips(obj, data, index)
	if index ~= 1 and index ~= 2 then
		local transform = obj.transform
		local icon = transform:Find("icon"):GetComponent(gohelper.Type_Image)
		local name = transform:Find("name"):GetComponent(gohelper.Type_TextMesh)
		local num = transform:Find("num"):GetComponent(gohelper.Type_TextMesh)
		local config = HeroConfig.instance:getHeroAttributeCO(HeroConfig.instance:getIDByAttrType(data.key))

		name.text = config.name

		UISpriteSetMgr.instance:setCommonSprite(icon, "icon_att_" .. config.id)

		data.value = config.type ~= 1 and data.value / 10 .. "%" or not data.is_special and data.config[data.key] / 10 .. "%" or math.floor(data.value)
		num.text = data.value
	end
end

function CharacterTalentTipView:isOwnHero()
	if self._isOwnHero ~= nil then
		return self._isOwnHero
	end

	return self.hero_mo_data and self.hero_mo_data:isOwnHero()
end

function CharacterTalentTipView:_showAllattr()
	local gain_tab = self.hero_mo_data:getTalentGain()
	local gain_list = {}

	for k, v in pairs(gain_tab) do
		table.insert(gain_list, v)
	end

	table.sort(gain_list, function(item1, item2)
		return HeroConfig.instance:getIDByAttrType(item1.key) < HeroConfig.instance:getIDByAttrType(item2.key)
	end)

	if not self:isOwnHero() then
		gohelper.CreateObjList(self, self._onItemShow, gain_list, self._gotrialattributeContent, self._gotrialattributeitem)

		return
	end

	gohelper.CreateObjList(self, self._onItemShow, gain_list, self._goattributeContent, self._goattributeItem)

	local data = self.hero_mo_data.talentCubeInfos.data_list
	local type_dic = {}

	for i, v in ipairs(data) do
		type_dic[v.cubeId] = type_dic[v.cubeId] or {}

		table.insert(type_dic[v.cubeId], v)
	end

	local damping_tab = SkillConfig.instance:getTalentDamping()
	local show_damping_list = {}

	for k, v in pairs(type_dic) do
		if #v >= damping_tab[1][1] then
			if #v >= damping_tab[2][1] then
				if not damping_tab[2][2] then
					local damping = damping_tab[1][2]

					if not damping_tab[1][2] then
						if damping then
							table.insert(show_damping_list, {
								cube_id = k,
								damping = damping
							})
						end
					end
				end
			end
		end
	end

	local damping_list_len = GameUtil.getTabLen(show_damping_list)

	gohelper.setActive(self._goreducetitle, damping_list_len > 0)
	gohelper.setActive(self._scrollreduce.gameObject, damping_list_len > 0)
	gohelper.setActive(self._goempty, damping_list_len <= 0 and #gain_list <= 0)
	gohelper.setActive(self._scrollattribute.gameObject, #gain_list > 0)
	gohelper.CreateObjList(self, self._onDampingItemShow, show_damping_list, self._godampingContent, self._goreduceItem)
end

function CharacterTalentTipView:_onDampingItemShow(obj, data, index)
	obj.name = data.cube_id

	local transform = obj.transform
	local icon = transform:Find("icon"):GetComponent(gohelper.Type_Image)
	local reduceNum = transform:Find("reduceNum"):GetComponent(gohelper.Type_TextMesh)

	UISpriteSetMgr.instance:setCharacterTalentSprite(icon, HeroResonanceConfig.instance:getCubeConfig(data.cube_id).icon, true)

	reduceNum.text = data.damping / 10 .. "%"

	self.addClickCb(self, gohelper.getClick(transform:Find("clickarea").gameObject), self._onDampingClick, self, obj)
end

function CharacterTalentTipView:_onDampingClick(obj)
	local cube_id = tonumber(obj.name)

	gohelper.setActive(self._gotip, true)
	self:_showSingleCubeAttr(cube_id)
end

function CharacterTalentTipView:_onItemShow(obj, data, index)
	local transform = obj.transform
	local image = transform:Find("icon"):GetComponent(gohelper.Type_Image)
	local label = transform:Find("name"):GetComponent(gohelper.Type_TextMesh)
	local num = transform:Find("num"):GetComponent(gohelper.Type_TextMesh)
	local config = HeroConfig.instance:getHeroAttributeCO(HeroConfig.instance:getIDByAttrType(data.key))

	data.value = config.type ~= 1 and tonumber(string.format("%.3f", data.value / 10)) .. "%" or math.floor(data.value)
	num.text = data.value
	label.text = config.name

	UISpriteSetMgr.instance:setCommonSprite(image, "icon_att_" .. config.id, true)
end

function CharacterTalentTipView:onClose()
	return
end

function CharacterTalentTipView:onDestroyView()
	return
end

return CharacterTalentTipView
