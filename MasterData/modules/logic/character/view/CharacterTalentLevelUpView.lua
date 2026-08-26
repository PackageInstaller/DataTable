-- chunkname: @modules/logic/character/view/CharacterTalentLevelUpView.lua

module("modules.logic.character.view.CharacterTalentLevelUpView", package.seeall)

local CharacterTalentLevelUpView = class("CharacterTalentLevelUpView", BaseViewExtended)

function CharacterTalentLevelUpView:onInitView()
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")
	self._gotalent = gohelper.findChild(self.viewGO, "#go_talent")
	self._gocaneasycombinetip = gohelper.findChild(self.viewGO, "#go_talent/txt_onceCombine")
	self._btntalent = gohelper.findChildButtonWithAudio(self.viewGO, "#go_talent/#btn_talent")
	self._txtbtntalentcn = gohelper.findChildText(self.viewGO, "#go_talent/#btn_talent/cn")
	self._gorequest = gohelper.findChild(self.viewGO, "#go_talent/items/#go_request")
	self._goinsight = gohelper.findChild(self.viewGO, "#go_talent/items/#go_insight")
	self._goinsighticon1 = gohelper.findChild(self.viewGO, "#go_talent/items/#go_insight/#go_insighticon1")
	self._txtinsightlevel = gohelper.findChildText(self.viewGO, "#go_talent/items/#go_insight/#txt_insightlevel")
	self._goinsighticon2 = gohelper.findChild(self.viewGO, "#go_talent/items/#go_insight/#go_insighticon2")
	self._goinsighticon3 = gohelper.findChild(self.viewGO, "#go_talent/items/#go_insight/#go_insighticon3")
	self._goframe = gohelper.findChild(self.viewGO, "#go_talent/items/#go_frame")
	self._txtcurlevel = gohelper.findChildText(self.viewGO, "#go_talent/info/#txt_curlevel")
	self._txtnextlevel = gohelper.findChildText(self.viewGO, "#go_talent/info/#txt_nextlevel")
	self._gomaxtalent = gohelper.findChild(self.viewGO, "#go_maxtalent")
	self._golevelupbeffect = gohelper.findChild(self.viewGO, "#go_talent/#btn_talent/#go_levelupbeffect")
	self._txttalentresult = gohelper.findChildText(self.viewGO, "#go_maxtalent/#txt_talentresult")
	self._btnpreview = gohelper.findChildButtonWithAudio(self.viewGO, "#go_talent/info/#btn_preview")
	self._btnload = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_load")
	self._gorighttop = gohelper.findChild(self.viewGO, "#go_righttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterTalentLevelUpView:addEvents()
	self._btntalent:AddClickListener(self._btntalentOnClick, self)
	self._btnpreview:AddClickListener(self._btnpreviewOnClick, self)
	self._btnload:AddClickListener(self._btnloadOnClick, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroTalentUp, self._onSuccessHeroTalentUp, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.RefreshTalentLevelUpView, self.onOpen, self)
	self.addEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self.onOpen, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.onOpen, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.playTalentLevelUpViewInAni, self._onPlayTalentLevelUpViewInAni, self)
end

function CharacterTalentLevelUpView:removeEvents()
	self._btntalent:RemoveClickListener()
	self._btnpreview:RemoveClickListener()
	self._btnload:RemoveClickListener()
end

function CharacterTalentLevelUpView:_btntalentOnClick()
	if not self.hero_mo_data then
		return
	end

	if self.hero_mo_data.rank < self.next_config.requirement then
		GameFacade.showToast(ToastEnum.CharacterTalentLevelUp)

		return
	end

	local notEnoughItemName, enough, icon = ItemModel.instance:hasEnoughItemsByCellData(self.item_list)

	if not enough then
		if self._canEasyCombine then
			PopupCacheModel.instance:setViewIgnoreGetPropView(self.viewName, true, MaterialEnum.GetApproach.RoomProductChange)
			RoomProductionHelper.openRoomFormulaMsgBoxView(self._easyCombineTable, self._lackedItemDataList, RoomProductLineEnum.Line.Spring, nil, nil, self._onEasyCombineFinished, self)

			return
		else
			GameFacade.showToastWithIcon(ToastEnum.NotEnoughId, icon, notEnoughItemName)

			return
		end
	end

	HeroRpc.instance:sendHeroTalentUpRequest(self.hero_id)
end

function CharacterTalentLevelUpView:_onEasyCombineFinished(cmd, resultCode, msg)
	PopupCacheModel.instance:setViewIgnoreGetPropView(self.viewName, false)

	if resultCode ~= 0 then
		return
	end

	self:_btntalentOnClick()
end

function CharacterTalentLevelUpView:_btnpreviewOnClick()
	ViewMgr.instance:openView(ViewName.CharacterTalentLevelUpPreview, self.hero_mo_data)
end

function CharacterTalentLevelUpView:_btnloadOnClick()
	self.viewContainer._head_close_ani1 = "2_3"
	self.viewContainer._head_close_ani2 = "ani_2_3"

	self:closeThis()
	CharacterController.instance:openCharacterTalentChessView({
		aniPlayIn2 = true,
		hero_id = self.hero_id
	})
end

function CharacterTalentLevelUpView:_detectLevelUp()
	if not self.hero_mo_data then
		return false
	end

	if self.hero_mo_data.rank < self.next_config.requirement then
		return false
	end

	local notEnoughItemName, enough, icon = ItemModel.instance:hasEnoughItemsByCellData(self.item_list)

	if not enough then
		return false
	end

	return true
end

function CharacterTalentLevelUpView:_editableInitView()
	self.bg_ani = gohelper.findChildComponent(self.viewGO, "", typeof(UnityEngine.Animator))
	self._godetails = gohelper.findChild(self.viewGO, "#go_details")
	self._txtdecitem = gohelper.findChild(self.viewGO, "#go_details/#txt_decitem")

	AudioMgr.instance:trigger(AudioEnum.Talent.play_ui_resonate_level_open)
end

function CharacterTalentLevelUpView:_onPlayTalentLevelUpViewInAni()
	self:onOpen()
	self.bg_ani:Play("charactertalentlevelup_in", 0, 0)
	CharacterController.instance:dispatchEvent(CharacterEvent.playTalentViewBackAni, "4_2", true, "ani_4_2", false)
end

function CharacterTalentLevelUpView:onUpdateParam()
	return
end

function CharacterTalentLevelUpView:_onSuccessHeroTalentUp()
	self.bg_ani:Play("charactertalentlevelup_out", 0, 0)
	CharacterController.instance:dispatchEvent(CharacterEvent.playTalentViewBackAni, "2_4", true, "ani_2_4", false)
	CharacterController.instance:openCharacterTalentLevelUpResultView(self.hero_id)
	gohelper.setActive(self._godetails, false)
end

function CharacterTalentLevelUpView:onOpen()
	self._exitCurrency = false
	self.hero_id = self.viewParam[1]
	self.hero_mo_data = HeroModel.instance:getByHeroId(self.hero_id)

	local resonance_str = luaLang("talent_charactertalentlevelup_leveltxt" .. self.hero_mo_data:getTalentTxtByHeroType())
	local cur_config = HeroResonanceConfig.instance:getTalentConfig(self.hero_mo_data.heroId, self.hero_mo_data.talent)

	if not cur_config then
		logError("共鸣表找不到,英雄id：", self.hero_mo_data.heroId, "共鸣等级：", self.hero_mo_data.talent)
	end

	self.next_config = HeroResonanceConfig.instance:getTalentConfig(self.hero_mo_data.heroId, self.hero_mo_data.talent + 1)

	gohelper.setActive(self._gotalent, self.next_config ~= nil)
	gohelper.setActive(self._gomaxtalent, self.next_config == nil)

	self._canEasyCombine = false

	if not self.next_config then
		self._txttalentresult.text = string.format("%s<size=18>LV</size>.%s", resonance_str, (HeroResonanceConfig.instance:getTalentConfig(self.hero_id, self.hero_mo_data.talent + 1) or nil) and (self.hero_mo_data.talent or "max"))
	else
		for i = 1, 3 do
			gohelper.setActive(self["_goinsighticon" .. i], self.next_config.requirement == i + 1)
		end

		self._txtinsightlevel.text = luaLang("p_characterrankup_promotion") .. GameUtil.getNum2Chinese(self.next_config.requirement - 1)
		self.old_color = self.old_color or self._txtinsightlevel.color
		self._txtinsightlevel.color = self.hero_mo_data.rank < self.next_config.requirement and Color.New(0.749, 0.1803, 0.0666, 1) or self.old_color
		self._txtcurlevel.text = resonance_str .. "<size=18>LV</size>." .. self.hero_mo_data.talent
		self._txtnextlevel.text = resonance_str .. "<size=18>LV</size>." .. self.hero_mo_data.talent + 1
		self._lackedItemDataList = {}
		self._occupyItemDic = {}

		local item_list = ItemModel.instance:getItemDataListByConfigStr(self.next_config.consume)

		self.item_list = item_list

		IconMgr.instance:getCommonPropItemIconList(self, self._onCostItemShow, item_list, self._gorequest)

		self._canEasyCombine, self._easyCombineTable = RoomProductionHelper.canEasyCombineItems(self._lackedItemDataList, self._occupyItemDic)
		self._occupyItemDic = nil

		recthelper.setWidth(self._goframe.transform, 350.5 + #self.item_list * 77.5)

		if cur_config.requirement ~= self.next_config.requirement then
			gohelper.setActive(self._goinsight, true)
			recthelper.setAnchor(self._gorequest.transform, -50.95, -234.6)
		else
			gohelper.setActive(self._goinsight, false)
			recthelper.setAnchor(self._gorequest.transform, -174, -234.6)
		end

		gohelper.setActive(self._golevelupbeffect, self:_detectLevelUp())
	end

	self._txtbtntalentcn.text = luaLang("talent_charactertalentlevelup_btntalent" .. self.hero_mo_data:getTalentTxtByHeroType())

	gohelper.setActive(self._gocaneasycombinetip, self._canEasyCombine)
	self:_checkTalentStyle()
end

function CharacterTalentLevelUpView:_onCostItemShow(cell_component, data, index)
	transformhelper.setLocalScale(cell_component.viewGO.transform, 0.59, 0.59, 1)
	cell_component:onUpdateMO(data)
	cell_component:setConsume(true)
	cell_component:showStackableNum2()
	cell_component:isShowEffect(true)
	cell_component:setAutoPlay(true)
	cell_component:setCountFontSize(48)

	local type = data.materilType
	local id = data.materilId
	local costQuantity = data.quantity
	local enoughText, lackedQuantity = ItemModel.instance:getItemIsEnoughText(data)

	if lackedQuantity then
		table.insert(self._lackedItemDataList, {
			type = type,
			id = id,
			quantity = lackedQuantity
		})
	else
		self._occupyItemDic[type] = self._occupyItemDic[type] or {}
		self._occupyItemDic[type][id] = (self._occupyItemDic[type][id] or 0) + costQuantity
	end

	cell_component:setCountText(enoughText)
	cell_component:setOnBeforeClickCallback(self.onBeforeClickItem, self)
	cell_component:setRecordFarmItem({
		type = type,
		id = id,
		quantity = costQuantity
	})

	if type == MaterialEnum.MaterialType.Currency then
		self._exitCurrency = true
	end

	gohelper.setActive(self._gorighttop, self._exitCurrency)
end

function CharacterTalentLevelUpView:onBeforeClickItem(param, commonItemIcon)
	local openedViewList = JumpController.instance:getCurrentOpenedView(self.viewName)

	for _, openView in ipairs(openedViewList) do
		if openView.viewName == ViewName.CharacterTalentView then
			openView.viewParam.isBack = true

			break
		end
	end

	commonItemIcon:setRecordFarmItem({
		type = commonItemIcon._itemType,
		id = commonItemIcon._itemId,
		quantity = commonItemIcon._itemQuantity,
		sceneType = GameSceneMgr.instance:getCurSceneType(),
		openedViewNameList = openedViewList
	})
end

function CharacterTalentLevelUpView:onClose()
	return
end

function CharacterTalentLevelUpView:onDestroyView()
	return
end

function CharacterTalentLevelUpView:_checkTalentStyle()
	local nowLv = self.hero_mo_data.talent
	local nextLv = self.hero_mo_data.talent + 1
	local target_model_config = HeroResonanceConfig.instance:getTalentModelConfig(self.hero_mo_data.heroId, nextLv)
	local old_model_config = HeroResonanceConfig.instance:getTalentModelConfig(self.hero_mo_data.heroId, nowLv) or {}
	local target_talent_config = HeroResonanceConfig.instance:getTalentConfig(self.hero_mo_data.heroId, nextLv)
	local old_talent_config = HeroResonanceConfig.instance:getTalentConfig(self.hero_mo_data.heroId, nowLv) or {}

	if not target_model_config then
		gohelper.setActive(self._godetails, false)

		return
	end

	gohelper.setActive(self._godetails, true)

	local upLevelTip = {}
	local _isUnlockStyle = TalentStyleModel.instance:getLevelUnlockStyle(self.hero_mo_data.talentCubeInfos.own_main_cube_id, nextLv)

	if _isUnlockStyle then
		local talentStr = luaLang("talent_style_title_cn_" .. self.hero_mo_data:getTalentTxtByHeroType())
		local str = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("talent_levelup_unlockstyle"), "#eea259", talentStr)

		table.insert(upLevelTip, {
			sort = 1,
			info = str
		})
	end

	if old_model_config.allShape ~= target_model_config.allShape then
		local old = string.gsub(old_model_config.allShape, ",", luaLang("multiple"))
		local next = string.gsub(target_model_config.allShape, ",", luaLang("multiple"))
		local str = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("talent_levelup_upcapacity"), old)

		table.insert(upLevelTip, {
			sort = 2,
			info = str,
			nextValue = next
		})
	end

	local _isNewDebris = false
	local _isDebrisCount = false
	local _isDebrisLevel = false

	for i = 10, 20 do
		local temp_type = "type" .. i
		local old_value = old_model_config[temp_type]
		local target_value = target_model_config[temp_type]
		local gain_tab = {}
		local old_arr = string.splitToNumber(old_value, "#") or {}
		local target_arr = string.splitToNumber(target_value, "#") or {}

		for index, value in ipairs(target_arr) do
			if value ~= old_arr[index] then
				gain_tab[index] = value - (old_arr[index] or 0)
			end
		end

		if old_value ~= target_value and not string.nilorempty(target_value) then
			if #old_value == 0 and not _isNewDebris then
				local str = luaLang("talent_levelup_newdebris")

				table.insert(upLevelTip, {
					sort = 3,
					info = str
				})

				_isNewDebris = true
			end

			if #old_value > 0 and gain_tab[2] ~= nil and not _isDebrisLevel then
				local str = luaLang("talent_levelup_debrislevel")

				table.insert(upLevelTip, {
					sort = 4,
					info = str
				})

				_isDebrisLevel = true
			end

			if gain_tab[1] ~= nil and gain_tab[2] == nil and not _isDebrisCount then
				local str = luaLang("talent_levelup_debriscount")

				table.insert(upLevelTip, {
					sort = 5,
					info = str
				})

				_isDebrisCount = true
			end
		else
			local exclusive = not string.nilorempty(target_talent_config.exclusive) and target_talent_config.exclusive ~= old_talent_config.exclusive

			if (exclusive or gain_tab[2] ~= nil) and not _isDebrisLevel then
				local str = luaLang("talent_levelup_debrislevel")

				table.insert(upLevelTip, {
					sort = 4,
					info = str
				})

				_isDebrisLevel = true
			end
		end
	end

	table.sort(upLevelTip, self.sortTip)
	gohelper.CreateObjList(self, self._onItemShow, upLevelTip, self._godetails, self._txtdecitem)
end

function CharacterTalentLevelUpView.sortTip(a, b)
	return a.sort < b.sort
end

function CharacterTalentLevelUpView:_onItemShow(obj, data, index)
	local txt = obj:GetComponent(gohelper.Type_TextMesh)
	local goTextValue = obj.transform:Find("nextvalue")
	local txtNextValue = obj.transform:Find("nextvalue/addvalue"):GetComponent(gohelper.Type_TextMesh)

	txt.text = data.info

	if data.nextValue then
		txtNextValue.text = data.nextValue

		gohelper.setActive(goTextValue, true)
	else
		gohelper.setActive(goTextValue, false)
	end
end

return CharacterTalentLevelUpView
