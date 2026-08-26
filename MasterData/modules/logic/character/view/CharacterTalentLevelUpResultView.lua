-- chunkname: @modules/logic/character/view/CharacterTalentLevelUpResultView.lua

module("modules.logic.character.view.CharacterTalentLevelUpResultView", package.seeall)

local CharacterTalentLevelUpResultView = class("CharacterTalentLevelUpResultView", BaseView)

function CharacterTalentLevelUpResultView:onInitView()
	self._goclickmask = gohelper.findChild(self.viewGO, "clickmask")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")
	self._scrollup = gohelper.findChildScrollRect(self.viewGO, "#scroll_up")
	self._goContent = gohelper.findChild(self.viewGO, "#scroll_up/Viewport/#go_Content")
	self._gocapacity = gohelper.findChild(self.viewGO, "#scroll_up/Viewport/#go_Content/#go_capacity")
	self._txtleveluptip = gohelper.findChildText(self.viewGO, "leveluptip/tip")
	self._txtlevelup = gohelper.findChildText(self.viewGO, "leveluptip/tip/#txt_levelup")
	self._goeasoning = gohelper.findChild(self.viewGO, "esonan/#go_easoning")
	self._goesonan = gohelper.findChild(self.viewGO, "esonan/#go_esonan")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterTalentLevelUpResultView:addEvents()
	self.addClickCb(self, gohelper.getClick(self._goclickmask), self._closeSelf, self)
end

function CharacterTalentLevelUpResultView:removeEvents()
	return
end

function CharacterTalentLevelUpResultView:_editableInitView()
	AudioMgr.instance:trigger(AudioEnum.Talent.play_ui_resonate_level_success)
end

function CharacterTalentLevelUpResultView:onUpdateParam()
	return
end

function CharacterTalentLevelUpResultView:_closeSelf()
	if ServerTime.now() - self.open_time < 2 then
		return
	end

	self:closeThis()
end

CharacterTalentLevelUpResultView.DebrisType = {
	Chess = 0,
	UnlockStyle = 5,
	Exclusive = 1,
	DebrisLevel = 3,
	DebrisCount = 2,
	DebrisCountAndLevel = 4
}

function CharacterTalentLevelUpResultView:onOpen()
	self.open_time = ServerTime.now()
	self.hero_id = self.viewParam
	self.hero_mo_data = HeroModel.instance:getByHeroId(self.hero_id)
	self._mainCubeId = self.hero_mo_data.talentCubeInfos.own_main_cube_id

	self:_bootLogic(self.hero_mo_data.talent, self.hero_mo_data.talent - 1)
	TaskDispatcher.runDelay(self._playScrollTween, self, 1.2)
	TaskDispatcher.runDelay(self._playAttrAni, self, 1.2)

	self._txtleveluptip.text = luaLang("talent_charactertalentlevelupresult_tip" .. self.hero_mo_data:getTalentTxtByHeroType())

	gohelper.setActive(self._goeasoning, self.hero_mo_data.config.heroType == CharacterEnum.HumanHeroType)
	gohelper.setActive(self._goesonan, self.hero_mo_data.config.heroType ~= CharacterEnum.HumanHeroType)
end

function CharacterTalentLevelUpResultView:_bootLogic(target_lv, old_level)
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
	local _isUnlockStyle = TalentStyleModel.instance:getLevelUnlockStyle(self._mainCubeId, target_lv)

	if _isUnlockStyle then
		table.insert(data_list, {
			up_type = CharacterTalentLevelUpResultView.DebrisType.UnlockStyle
		})
	end

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
	self._attr_ani_tab = self:getUserDataTb_()
	self._burst_effect_attr_tab = self:getUserDataTb_()

	gohelper.CreateObjList(self, self._onItemShow, data_list, self._goContent, self._gocapacity)

	self._txtlevelup.text = string.format("LV.<size=80>%s", self.target_lv)
end

function CharacterTalentLevelUpResultView:_playScrollTween()
	self._goContent:GetComponent(gohelper.Type_VerticalLayoutGroup).enabled = false
	self.parallel_sequence = self.parallel_sequence or FlowParallel.New()

	for i, v in ipairs(self.obj_list) do
		local pos_y = recthelper.getAnchorY(v)

		recthelper.setAnchorY(v, pos_y - 200)

		local tween_sequence = FlowSequence.New()

		tween_sequence:addWork(WorkWaitSeconds.New(0.03 * (i - 1)))

		local paraller = FlowParallel.New()

		paraller:addWork(TweenWork.New({
			type = "DOAnchorPosY",
			t = 0.33,
			tr = v,
			to = pos_y,
			ease = EaseType.OutQuart
		}))
		paraller:addWork(TweenWork.New({
			from = 0,
			type = "DOFadeCanvasGroup",
			to = 1,
			t = 0.6,
			go = v.gameObject
		}))
		tween_sequence:addWork(paraller)

		if i == #self.obj_list then
			tween_sequence:addWork(FunctionWork.New(function()
				self._goContent:GetComponent(gohelper.Type_VerticalLayoutGroup).enabled = true
			end))
		end

		self.parallel_sequence:addWork(tween_sequence)
	end

	self.parallel_sequence:start({})
end

function CharacterTalentLevelUpResultView:_playAttrAni()
	self._parallel_attr_sequence = self._parallel_attr_sequence or FlowParallel.New()

	for i = 1, #self._attr_ani_tab do
		local flow = FlowParallel.New()

		for index, attr in ipairs(self._attr_ani_tab[i]) do
			local tween_sequence = FlowSequence.New()

			tween_sequence:addWork(WorkWaitSeconds.New(0.06 * (index - 1)))

			local paraller = FlowParallel.New()

			paraller:addWork(FunctionWork.New(function()
				gohelper.findChildComponent(attr, "", gohelper.Type_CanvasGroup).alpha = 1
				gohelper.findChildComponent(attr, "", typeof(UnityEngine.Animator)).enabled = true

				gohelper.setActive(gohelper.findChild(attr, "#new"), self._burst_effect_attr_tab[i][index])
			end))
			tween_sequence:addWork(paraller)
			flow:addWork(tween_sequence)
		end

		self._parallel_attr_sequence:addWork(flow)
	end

	self._parallel_attr_sequence:start({})
end

local specialType = {
	CharacterTalentLevelUpResultView.DebrisType.Chess,
	CharacterTalentLevelUpResultView.DebrisType.UnlockStyle
}

function CharacterTalentLevelUpResultView:_onItemShow(obj, data, index)
	self._attr_ani_tab[index] = self:getUserDataTb_()
	self._burst_effect_attr_tab[index] = self:getUserDataTb_()
	obj.name = data.cube_id or "shape"

	local transform = obj.transform
	local click = transform:Find("cell/cell_bg/click").gameObject
	local icon = transform:Find("cell/cell_bg/icon"):GetComponent(gohelper.Type_Image)
	local icon_bg = transform:Find("cell/cell_bg"):GetComponent(gohelper.Type_Image)
	local go_style = transform:Find("info/go_style").gameObject
	local txt_style = transform:Find("info/go_style/txt_unlocked"):GetComponent(gohelper.Type_TextMesh)
	local go_capacityTip = transform:Find("info/go_capacityTip").gameObject
	local go_numTip = transform:Find("info/go_numTip").gameObject
	local go_new = transform:Find("cell/go_new").gameObject
	local attr = transform:Find("info/attr").gameObject
	local go_level = transform:Find("info/go_level").gameObject
	local cube_level = transform:Find("info/go_level/value"):GetComponent(gohelper.Type_TextMesh)
	local cube_add_level = transform:Find("info/go_level/addvalue"):GetComponent(gohelper.Type_TextMesh)
	local isNormal = not LuaUtil.tableContains(specialType, data.up_type)

	gohelper.setActive(go_capacityTip, data.up_type == CharacterTalentLevelUpResultView.DebrisType.Chess)
	gohelper.setActive(go_numTip, isNormal and data.up_type == CharacterTalentLevelUpResultView.DebrisType.DebrisCount)
	gohelper.setActive(go_new, isNormal and data.new_debris)
	gohelper.setActive(attr, isNormal)
	gohelper.setActive(go_style, data.up_type == CharacterTalentLevelUpResultView.DebrisType.UnlockStyle)

	local talentStr = luaLang("talent_style_title_cn_" .. self.hero_mo_data:getTalentTxtByHeroType())

	txt_style.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("talent_levelup_unlockstyle"), "#eea259", talentStr)

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

	if go_level.activeInHierarchy then
		table.insert(self._attr_ani_tab[index], go_level)
		table.insert(self._burst_effect_attr_tab[index], false)
	end

	if go_capacityTip.activeInHierarchy then
		table.insert(self._attr_ani_tab[index], go_capacityTip)
		table.insert(self._burst_effect_attr_tab[index], false)
	end

	if go_numTip.activeInHierarchy then
		table.insert(self._attr_ani_tab[index], go_numTip)
		table.insert(self._burst_effect_attr_tab[index], false)
	end

	for i, v in ipairs(self._attr_ani_tab[index]) do
		gohelper.findChildComponent(v, "", typeof(UnityEngine.Animator)).enabled = false
		gohelper.findChildComponent(v, "", gohelper.Type_CanvasGroup).alpha = 0
	end

	if data.up_type == CharacterTalentLevelUpResultView.DebrisType.Chess then
		UISpriteSetMgr.instance:setCharacterTalentSprite(icon, "icon_danao", true)

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
	elseif data.up_type == CharacterTalentLevelUpResultView.DebrisType.UnlockStyle then
		-- block empty
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

		if data.up_type == CharacterTalentLevelUpResultView.DebrisType.DebrisCount or data.up_type == CharacterTalentLevelUpResultView.DebrisType.DebrisCountAndLevel then
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
			local add_value = 0
			local is_new_attr = false

			if attr_old_tab[k] then
				add_value = v - attr_old_tab[k]
			else
				is_new_attr = true
			end

			table.insert(temp_list, {
				is_new_attr = is_new_attr,
				debris_index = index,
				key = k,
				value = v,
				add_value = add_value,
				is_special = target_attr_config.calculateType == 1,
				config = target_attr_config,
				old_attr_config = old_attr_config
			})
		end

		table.sort(temp_list, function(item1, item2)
			return HeroConfig.instance:getIDByAttrType(item1.key) < HeroConfig.instance:getIDByAttrType(item2.key)
		end)
		gohelper.CreateObjList(self, self._onShowSingleCubeAttr, temp_list, attr, attr.transform:Find("go_attrItem").gameObject)

		local sp_name = HeroResonanceConfig.instance:getCubeConfig(data.cube_id).icon
		local temp_attr = string.split(sp_name, "_")
		local cubeBg = "gz_" .. temp_attr[#temp_attr]

		if self._mainCubeId == data.cube_id then
			local cubeId = self.hero_mo_data:getHeroUseStyleCubeId()

			if cubeId ~= self._mainCubeId then
				local co = HeroResonanceConfig.instance:getCubeConfig(cubeId)

				if co then
					local icon = co.icon

					if not string.nilorempty(icon) then
						sp_name = "mk_" .. icon
						cubeBg = cubeBg .. "_2"
					end
				end
			end
		end

		icon_bg.enabled = true

		UISpriteSetMgr.instance:setCharacterTalentSprite(icon, sp_name, true)
		UISpriteSetMgr.instance:setCharacterTalentSprite(icon_bg, cubeBg, true)
	end

	table.insert(self.obj_list, transform)

	if data.up_type ~= CharacterTalentLevelUpResultView.DebrisType.Chess and data.new_debris then
		self:_setNewTipPos(go_new, data.cube_id)
	end
end

function CharacterTalentLevelUpResultView:_setNewTipPos(go_new, cubeId)
	local shapeConfig = HeroResonanceConfig.instance:getCubeConfig(cubeId).shape

	if shapeConfig == nil then
		return
	end

	local firtLineConfig = string.split(shapeConfig, "#")[1]
	local singleCubeConfig = string.splitToNumber(firtLineConfig, ",")
	local isRightEmpty = singleCubeConfig[#singleCubeConfig] == 0

	recthelper.setAnchorY(go_new.transform, isRightEmpty and 1.4 or 13.3)
end

function CharacterTalentLevelUpResultView:_onDebrisStarItemShow(obj, data, index)
	local transform = obj.transform

	gohelper.setActive(transform:Find("lighticon").gameObject, index <= data.cur_level)
end

function CharacterTalentLevelUpResultView:_onShowSingleCubeAttr(obj, data, index)
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
	gohelper.findChildComponent(obj, "", typeof(UnityEngine.Animator)).enabled = false
	gohelper.findChildComponent(obj, "", gohelper.Type_CanvasGroup).alpha = 0

	table.insert(self._attr_ani_tab[data.debris_index], obj)
	table.insert(self._burst_effect_attr_tab[data.debris_index], data.is_new_attr)
end

function CharacterTalentLevelUpResultView:_onCubeClick(obj)
	local name = obj.name

	if name ~= "shape" then
		AudioMgr.instance:trigger(AudioEnum.Talent.play_ui_resonate_property_click)

		local cube_id = tonumber(name)

		CharacterController.instance:openCharacterTalentTipView({
			open_type = 1,
			hero_id = self.hero_id,
			cube_id = cube_id
		})
	end
end

function CharacterTalentLevelUpResultView:onClose()
	if self.parallel_sequence then
		self.parallel_sequence:destroy()
	end

	if self._parallel_attr_sequence then
		self._parallel_attr_sequence:destroy()
	end

	TaskDispatcher.cancelTask(self._playScrollTween, self)
	TaskDispatcher.cancelTask(self._playAttrAni, self)
end

function CharacterTalentLevelUpResultView:onDestroyView()
	return
end

return CharacterTalentLevelUpResultView
