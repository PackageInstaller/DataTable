-- chunkname: @modules/logic/character/view/CharacterTalentLevelUpPreview.lua

module("modules.logic.character.view.CharacterTalentLevelUpPreview", package.seeall)

local CharacterTalentLevelUpPreview = class("CharacterTalentLevelUpPreview", BaseViewExtended)

function CharacterTalentLevelUpPreview:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._scrollup = gohelper.findChildScrollRect(self.viewGO, "#scroll_up")
	self._goContent = gohelper.findChild(self.viewGO, "#scroll_up/Viewport/#go_Content")
	self._gocapacity = gohelper.findChild(self.viewGO, "#scroll_up/Viewport/#go_Content/#go_capacity")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterTalentLevelUpPreview:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroTalentUp, self.onOpen, self)
end

function CharacterTalentLevelUpPreview:removeEvents()
	self._btnclose:RemoveClickListener()
end

function CharacterTalentLevelUpPreview:_btncloseOnClick()
	self:closeThis()
end

function CharacterTalentLevelUpPreview:_editableInitView()
	return
end

function CharacterTalentLevelUpPreview:onUpdateParam()
	return
end

function CharacterTalentLevelUpPreview:onRefreshViewParam(hero_mo_data)
	self.hero_mo_data = hero_mo_data
end

function CharacterTalentLevelUpPreview:onOpen()
	self.hero_mo_data = self.viewParam
	self._scrollup.verticalNormalizedPosition = 1

	self:_bootLogic(self.hero_mo_data.talent + 1, self.hero_mo_data.talent)
end

function CharacterTalentLevelUpPreview:_bootLogic(target_lv, old_level)
	self.target_lv = target_lv
	self.old_level = old_level

	local old_talent_config = HeroResonanceConfig.instance:getTalentConfig(self.hero_mo_data.heroId, old_level) or {}
	local target_talent_config = HeroResonanceConfig.instance:getTalentConfig(self.hero_mo_data.heroId, target_lv)

	self.old_model_config = HeroResonanceConfig.instance:getTalentModelConfig(self.hero_mo_data.heroId, old_level) or {}
	self.target_model_config = HeroResonanceConfig.instance:getTalentModelConfig(self.hero_mo_data.heroId, target_lv)

	gohelper.setActive(self._goContent, self.target_model_config ~= nil)

	if not self.target_model_config then
		return
	end

	local data_list = {}

	if self.target_model_config.allShape ~= self.old_model_config.allShape then
		table.insert(data_list, {
			up_type = CharacterTalentLevelUpResultView.DebrisType.Chess,
			value = self.target_model_config.allShape
		})
	end

	if target_talent_config.exclusive ~= old_talent_config.exclusive then
		local gain_tab = {}
		local target_value_tab = {}
		local old_value_tab = {}
		local old_arr = string.splitToNumber(old_talent_config.exclusive, "#") or {}
		local target_arr = string.splitToNumber(target_talent_config.exclusive, "#") or {}

		for index, value in ipairs(target_arr) do
			if value ~= old_arr[index] then
				gain_tab[index] = value - (old_arr[index] or 0)
			end

			target_value_tab[index] = value
			old_value_tab[index] = old_arr[index]
		end

		if not string.nilorempty(target_talent_config.exclusive) then
			table.insert(data_list, {
				cube_id = target_arr[1],
				up_type = CharacterTalentLevelUpResultView.DebrisType.Exclusive,
				new_debris = #old_arr == 0,
				value = gain_tab,
				target_value_tab = target_value_tab,
				old_value_tab = old_value_tab
			})
		end
	end

	for i = 10, 20 do
		local temp_type = "type" .. i
		local old_value = self.old_model_config[temp_type]
		local target_value = self.target_model_config[temp_type]

		if old_value ~= target_value and not string.nilorempty(target_value) then
			local gain_tab = {}
			local target_value_tab = {}
			local old_value_tab = {}
			local old_arr = string.splitToNumber(old_value, "#") or {}
			local target_arr = string.splitToNumber(target_value, "#") or {}

			for index, value in ipairs(target_arr) do
				if value ~= old_arr[index] then
					gain_tab[index] = value - (old_arr[index] or 0)
				end

				target_value_tab[index] = value
				old_value_tab[index] = old_arr[index]
			end

			local up_type

			if gain_tab[1] then
				up_type = gain_tab[2] and CharacterTalentLevelUpResultView.DebrisType.DebrisCountAndLevel or CharacterTalentLevelUpResultView.DebrisType.DebrisCount
			elseif gain_tab[2] then
				up_type = CharacterTalentLevelUpResultView.DebrisType.DebrisLevel
			end

			table.insert(data_list, {
				cube_id = i,
				up_type = up_type,
				new_debris = #old_arr == 0,
				value = gain_tab,
				target_value_tab = target_value_tab,
				old_value_tab = old_value_tab
			})
		end
	end

	self.obj_list = self:getUserDataTb_()

	gohelper.CreateObjList(self, self._onItemShow, data_list, self._goContent, self._gocapacity)
end

function CharacterTalentLevelUpPreview:_onItemShow(obj, data, index)
	obj.name = data.cube_id or "shape"

	local transform = obj.transform
	local icon = transform:Find("cellicon/cell_bg/icon"):GetComponent(gohelper.Type_Image)
	local icon_bg = transform:Find("cellicon/cell_bg"):GetComponent(gohelper.Type_Image)
	local go_capacityTip = transform:Find("info/go_capacityTip").gameObject
	local go_numTip = transform:Find("info/go_numTip").gameObject
	local attr = transform:Find("info/attr").gameObject
	local go_level = transform:Find("info/go_level").gameObject
	local cube_level = transform:Find("info/go_level/value"):GetComponent(gohelper.Type_TextMesh)
	local cube_add_level = transform:Find("info/go_level/addvalue"):GetComponent(gohelper.Type_TextMesh)

	gohelper.setActive(go_capacityTip, data.up_type == CharacterTalentLevelUpResultView.DebrisType.Chess)
	gohelper.setActive(go_numTip, (data.up_type ~= CharacterTalentLevelUpResultView.DebrisType.Chess or nil) and (data.new_debris or data.up_type == CharacterTalentLevelUpResultView.DebrisType.DebrisCount))
	gohelper.setActive(attr, data.up_type ~= CharacterTalentLevelUpResultView.DebrisType.Chess)

	if data.up_type == CharacterTalentLevelUpResultView.DebrisType.Exclusive then
		gohelper.setActive(go_level, true)

		cube_level.text = "LV." .. data.target_value_tab[2]
		cube_add_level.text = "+" .. data.value[2]
	elseif data.up_type == CharacterTalentLevelUpResultView.DebrisType.DebrisLevel then
		gohelper.setActive(go_level, true)

		cube_level.text = "LV." .. data.target_value_tab[2]
		cube_add_level.text = "+" .. data.value[2]
	elseif data.up_type == CharacterTalentLevelUpResultView.DebrisType.DebrisCountAndLevel then
		gohelper.setActive(go_level, true)

		cube_level.text = "LV." .. data.target_value_tab[2]
		cube_add_level.text = "+" .. data.value[2]
	else
		gohelper.setActive(go_level, false)
	end

	if data.new_debris then
		cube_add_level.text = ""
	end

	if data.up_type == CharacterTalentLevelUpResultView.DebrisType.Chess then
		UISpriteSetMgr.instance:setCharacterTalentSprite(icon, "icon_danao01", true)

		icon_bg.enabled = false
		go_capacityTip.transform:Find("name"):GetComponent(gohelper.Type_TextMesh).text = luaLang("talent_capacity_up")
		go_capacityTip.transform:Find("value"):GetComponent(gohelper.Type_TextMesh).text = string.gsub(self.old_model_config.allShape, ",", luaLang("multiple"))
		go_capacityTip.transform:Find("addvalue"):GetComponent(gohelper.Type_TextMesh).text = string.gsub(data.value, ",", luaLang("multiple"))

		local star_data = {}
		local max_shape_level = HeroResonanceConfig.instance:getTalentModelShapeMaxLevel(self.hero_mo_data.heroId)
		local target_shape_level = HeroResonanceConfig.instance:getCurTalentModelShapeLevel(self.hero_mo_data.heroId, self.target_lv)

		for i = 1, max_shape_level do
			star_data[i] = {}
			star_data[i].cur_level = target_shape_level
		end
	else
		local target_attr_config = HeroConfig.instance:getTalentCubeAttrConfig(data.cube_id, data.target_value_tab[2])

		if not target_attr_config then
			logError(data.cube_id, data.target_value_tab[2])
		end

		local star_data = {}

		for i = 1, HeroConfig.instance:getTalentCubeMaxLevel(data.cube_id) do
			star_data[i] = {}
			star_data[i].cur_level = target_attr_config.level
		end

		if data.new_debris then
			go_numTip.transform:Find("name"):GetComponent(gohelper.Type_TextMesh).text = "<color=#975129>" .. luaLang("talent_new_debris") .. "</color>"
			go_numTip.transform:Find("value"):GetComponent(gohelper.Type_TextMesh).text = ""
			go_numTip.transform:Find("addvalue"):GetComponent(gohelper.Type_TextMesh).text = ""
		elseif data.up_type == CharacterTalentLevelUpResultView.DebrisType.DebrisCount or data.up_type == CharacterTalentLevelUpResultView.DebrisType.DebrisCountAndLevel then
			go_numTip.transform:Find("name"):GetComponent(gohelper.Type_TextMesh).text = luaLang("talent_cube_count_up")
			go_numTip.transform:Find("value"):GetComponent(gohelper.Type_TextMesh).text = data.target_value_tab[1]
			go_numTip.transform:Find("addvalue"):GetComponent(gohelper.Type_TextMesh).text = "+" .. data.value[1]
		end

		local attr_target_tab = {}

		self.hero_mo_data:getTalentStyleCubeAttr(data.cube_id, attr_target_tab, nil, nil, data.target_value_tab[2])

		local attr_old_tab = {}

		if (data.up_type == CharacterTalentLevelUpResultView.DebrisType.Exclusive or data.up_type == CharacterTalentLevelUpResultView.DebrisType.DebrisCountAndLevel or data.up_type == CharacterTalentLevelUpResultView.DebrisType.DebrisLevel) and data.old_value_tab[2] then
			self.hero_mo_data:getTalentStyleCubeAttr(data.cube_id, attr_old_tab, nil, nil, data.old_value_tab[2] or 0)
		end

		local temp_list = {}
		local old_attr_config = HeroConfig.instance:getTalentCubeAttrConfig(data.cube_id, data.old_value_tab[2])

		old_attr_config = old_attr_config or target_attr_config

		for k, v in pairs(attr_target_tab) do
			table.insert(temp_list, {
				key = k,
				value = v,
				add_value = (attr_old_tab[k] or nil) and v - attr_old_tab[k],
				is_special = target_attr_config.calculateType == 1,
				config = target_attr_config,
				old_attr_config = old_attr_config
			})
		end

		table.sort(temp_list, function(item1, item2)
			return HeroConfig.instance:getIDByAttrType(item1.key) < HeroConfig.instance:getIDByAttrType(item2.key)
		end)
		gohelper.CreateObjList(self, self._onShowSingleCubeAttr, temp_list, attr, attr.transform:Find("go_attrItem").gameObject)

		icon_bg.enabled = true

		local sp_name = HeroResonanceConfig.instance:getCubeConfig(data.cube_id).icon

		UISpriteSetMgr.instance:setCharacterTalentSprite(icon, "glow_" .. sp_name, true)

		local temp_attr = string.split(sp_name, "_")

		UISpriteSetMgr.instance:setCharacterTalentSprite(icon_bg, "gz_" .. temp_attr[#temp_attr], true)
	end

	table.insert(self.obj_list, transform)
end

function CharacterTalentLevelUpPreview:_onDebrisStarItemShow(obj, data, index)
	local transform = obj.transform

	gohelper.setActive(transform:Find("lighticon").gameObject, index <= data.cur_level)
end

function CharacterTalentLevelUpPreview:_onShowSingleCubeAttr(obj, data, index)
	local transform = obj.transform
	local icon = transform:Find("icon"):GetComponent(gohelper.Type_Image)
	local name = transform:Find("name"):GetComponent(gohelper.Type_TextMesh)
	local value = transform:Find("value"):GetComponent(gohelper.Type_TextMesh)
	local addvalue = transform:Find("addvalue"):GetComponent(gohelper.Type_TextMesh)
	local config = HeroConfig.instance:getHeroAttributeCO(HeroConfig.instance:getIDByAttrType(data.key))

	name.text = config.name

	UISpriteSetMgr.instance:setCommonSprite(icon, "icon_att_" .. config.id)

	local temp_add_value = data.add_value

	if config.type ~= 1 then
		data.value = data.value / 10 .. "%"
		data.add_value = data.add_value / 10 .. "%"
	elseif not data.is_special then
		data.value = data.config[data.key] / 10 .. "%"
		data.add_value = (data.config[data.key] - data.old_attr_config[data.key]) / 10 .. "%"
	else
		data.value = math.floor(data.value)
		data.add_value = math.floor(data.add_value)
	end

	value.text = data.value
	addvalue.text = temp_add_value == 0 and "" or "+" .. data.add_value
end

function CharacterTalentLevelUpPreview:onClose()
	return
end

function CharacterTalentLevelUpPreview:onDestroyView()
	return
end

function CharacterTalentLevelUpPreview:definePrefabUrl()
	self:setPrefabUrl("ui/viewres/character/charactertalentup/charactertalentleveluppreview.prefab")
end

return CharacterTalentLevelUpPreview
