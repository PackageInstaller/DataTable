-- chunkname: @modules/logic/character/view/CharacterTalentChessView.lua

module("modules.logic.character.view.CharacterTalentChessView", package.seeall)

local CharacterTalentChessView = class("CharacterTalentChessView", BaseView)

function CharacterTalentChessView:onInitView()
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._goblock = gohelper.findChild(self.viewGO, "#go_block")
	self._gochessContainer = gohelper.findChild(self.viewGO, "chessboard/#go_chessContainer")
	self._gomeshContainer = gohelper.findChild(self.viewGO, "chessboard/#go_meshContainer")
	self._gomeshItem = gohelper.findChild(self.viewGO, "chessboard/#go_meshContainer/#go_meshItem")
	self._godragAnchor = gohelper.findChild(self.viewGO, "chessboard/#go_dragAnchor")
	self._godragContainer = gohelper.findChild(self.viewGO, "chessboard/#go_dragAnchor/#go_dragContainer")
	self._gocellModel = gohelper.findChild(self.viewGO, "chessboard/#go_dragAnchor/#go_cellModel")
	self._gochessitem = gohelper.findChild(self.viewGO, "chessboard/#go_chessitem")
	self._goraychessitem = gohelper.findChild(self.viewGO, "chessboard/#go_raychessitem")
	self._btnroleAttribute = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_roleAttribute")
	self._txttalentcn = gohelper.findChildText(self.viewGO, "#btn_roleAttribute/#txt_talentcn")
	self._txttalentEn = gohelper.findChildText(self.viewGO, "#btn_roleAttribute/txtEn")
	self._scrollinspiration = gohelper.findChildScrollRect(self.viewGO, "#scroll_inspiration")
	self._goContent = gohelper.findChild(self.viewGO, "#scroll_inspiration/Viewport/#go_Content")
	self._goinspirationItem = gohelper.findChild(self.viewGO, "#scroll_inspiration/Viewport/#go_Content/#go_inspirationItem")
	self._goEmpty = gohelper.findChild(self.viewGO, "#scroll_inspiration/Empty")
	self._gotip = gohelper.findChild(self.viewGO, "#go_tip")
	self._gosingleTipsContent = gohelper.findChild(self.viewGO, "#go_tip/attributetip/#go_singleTipsContent")
	self._gosingleAttributeItem = gohelper.findChild(self.viewGO, "#go_tip/attributetip/#go_singleTipsContent/#go_singleAttributeItem")
	self._btnclosetipArea = gohelper.findChildButtonWithAudio(self.viewGO, "bg/#btn_closetipArea")
	self._btntakeoffallcube = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_removeAll")
	self._btnrecommend = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_recommend")
	self._goupdatetips = gohelper.findChild(self.viewGO, "#go_updatetips")
	self._goupdatetipscontent = gohelper.findChild(self.viewGO, "#go_updatetips/attributetip/#go_updateTipsContent")
	self._goupdateattributeitem = gohelper.findChild(self.viewGO, "#go_updatetips/attributetip/#go_updateTipsContent/#go_updateAttributeItem")
	self._dropresonategroup = gohelper.findChildDropdown(self.viewGO, "#drop_resonategroup")
	self._txtgroupname = gohelper.findChildText(self.viewGO, "#drop_resonategroup/txt_groupname")
	self._btnchangetemplatename = gohelper.findChildClickWithAudio(self.viewGO, "#drop_resonategroup/#btn_changetemplatename")
	self._dropClick = gohelper.getClick(self._dropresonategroup.gameObject)
	self._gostylechange = gohelper.findChild(self.viewGO, "#go_stylechange")
	self._txtlabel = gohelper.findChildText(self.viewGO, "#go_stylechange/#txt_label")
	self._btnstylechange = gohelper.findChildButtonWithAudio(self.viewGO, "#go_stylechange/#btn_check")
	self._goMaxLevel = gohelper.findChild(self.viewGO, "#go_check")
	self._btnMaxLevel = gohelper.findChildButtonWithAudio(self.viewGO, "#go_check/#btn_check")
	self._styleslot = gohelper.findChildImage(self.viewGO, "#go_stylechange/slot")
	self._styleicon = gohelper.findChildImage(self.viewGO, "#go_stylechange/slot/icon")
	self._styleglow = gohelper.findChildImage(self.viewGO, "#go_stylechange/slot/glow")
	self._styleupdate = gohelper.findChild(self.viewGO, "#go_stylechange/update")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterTalentChessView:addEvents()
	self._btnchangetemplatename:AddClickListener(self._onBtnChangeTemplateName, self)
	self._btnroleAttribute:AddClickListener(self._btnroleAttributeOnClick, self)
	self._btnclosetipArea:AddClickListener(self._btnCloseTipOnClick, self)
	self._btntakeoffallcube:AddClickListener(self._onBtnTakeOffAllCube, self)
	self._btnrecommend:AddClickListener(self._showQuickLayoutPanel, self)
	self._dropresonategroup:AddOnValueChanged(self._opDropdownChange, self)
	self._dropClick:AddClickListener(self._onDropClick, self)
	self._btnstylechange:AddClickListener(self._onStyleChangeClick, self)
	self._btnMaxLevel:AddClickListener(self._onMaxLevelClick, self)
end

function CharacterTalentChessView:removeEvents()
	self._btnchangetemplatename:RemoveClickListener()
	self._btnroleAttribute:RemoveClickListener()
	self._btnclosetipArea:RemoveClickListener()
	self._btntakeoffallcube:RemoveClickListener()
	self._btnrecommend:RemoveClickListener()
	self._dropresonategroup:RemoveOnValueChanged()
	self._dropClick:RemoveClickListener()
	self._btnstylechange:RemoveClickListener()
	self._btnMaxLevel:RemoveClickListener()
end

function CharacterTalentChessView:_btnroleAttributeOnClick()
	CharacterController.instance:openCharacterTalentTipView({
		open_type = 0,
		hero_id = self.hero_id
	})
end

function CharacterTalentChessView:_onBtnTakeOffAllCube()
	GameFacade.showMessageBox(MessageBoxIdDefine.TakeOffAllTalentCube, MsgBoxEnum.BoxType.Yes_No, function()
		self:_releaseDragItem()
		HeroRpc.instance:TakeoffAllTalentCubeRequest(self.hero_id)
	end)
end

function CharacterTalentChessView:_btnCloseTipOnClick()
	local cell_data = self.cur_select_cell_data

	if cell_data then
		local target_transform = gohelper.findChild(self._gochessContainer, string.format("%s_%s_%s_%s", cell_data.cubeId, cell_data.direction, cell_data.posX, cell_data.posY))

		if target_transform then
			target_transform = target_transform.transform

			local scale = 1.35

			transformhelper.setLocalScale(target_transform, scale, scale, scale)
			gohelper.setActive(target_transform:Find("icon").gameObject, false)
		end
	end

	self.cur_select_cell_data = nil

	gohelper.setActive(self._gotip, false)

	if self._quickLayoutPanel and self._quickLayoutPanel.gameObject.activeSelf then
		self:_hideQuickLayoutPanel()
	end
end

function CharacterTalentChessView:_editableInitView()
	self.bg_ani = gohelper.findChildComponent(self.viewGO, "", typeof(UnityEngine.Animator))
	self.go_yanwu = gohelper.findChild(self.viewGO, "chessboard/yanwu")

	gohelper.addUIClickAudio(self._btnroleAttribute.gameObject, AudioEnum.UI.play_ui_admission_open)
	gohelper.addUIClickAudio(self._btntakeoffallcube.gameObject, AudioEnum.UI.Play_UI_Universal_Click)

	self._gomaxselect = gohelper.findChild(self.viewGO, "#go_check/#btn_check/selected")
	self._gomaxunselect = gohelper.findChild(self.viewGO, "#go_check/#btn_check/unselect")
	self._leftContentAnim = self._goContent:GetComponent(typeof(UnityEngine.Animator))
	self._quickLayoutIcon = gohelper.findChild(self.viewGO, "#btn_recommend/cn/image_Arrow")

	self.addEventCb(self, CharacterController.instance, CharacterEvent.RefreshCubeList, self._onRefreshCubeList, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.ClickFirstResonanceCellItem, self._clickFirstResonanceCellItem, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.ShowGuideDragEffect, self._showGuideDragEffect, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.CopyTalentData, self._onCopyTalentData, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.UseTalentTemplateReply, self._onUseTalentTemplateReply, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.RenameTalentTemplateReply, self._onRenameTalentTemplateReply, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.onUseTalentStyleReply, self._onUseTalentStyleReply, self)
	self.addEventCb(self, HeroResonanceController.instance, HeroResonanceEvent.UseShareCode, self._onUseShareCode, self)
end

function CharacterTalentChessView:_showGuideDragEffect(param)
	if self._dragEffectLoader then
		self._dragEffectLoader:dispose()

		self._dragEffectLoader = nil
	end

	local visible = tonumber(param) == 1

	gohelper.setActive(self._goblock, visible)

	if visible then
		self._dragEffectLoader = PrefabInstantiate.Create(self.viewGO)

		self._dragEffectLoader:startLoad("ui/viewres/guide/guide_character.prefab", self._onDragEffectLoaded, self)
	end
end

function CharacterTalentChessView:_onDragEffectLoaded()
	local item1 = self.own_cube_list[1]
	local config = HeroResonanceConfig.instance:getCubeConfig(item1.id)
	local list = config.shape and string.split(config.shape, "#") or {}
	local height = #list
	local go = self._dragEffectLoader:getInstGO()

	gohelper.setActive(gohelper.findChild(go, "guide1").gameObject, height <= 2)
	gohelper.setActive(gohelper.findChild(go, "guide2").gameObject, height >= 3)
end

function CharacterTalentChessView:_clickFirstResonanceCellItem()
	for i, v in ipairs(self._rabbet_cell_list) do
		if v.is_filled then
			v:clickCube()

			break
		end
	end
end

function CharacterTalentChessView:onUpdateParam()
	return
end

function CharacterTalentChessView:onOpen()
	gohelper.setActive(self._gotip, false)
	gohelper.setActive(self._godragContainer, false)

	self.cell_length = 76.2
	self.half_length = 38.1

	if type(self.viewParam) == "table" then
		self.hero_id = self.viewParam.hero_id

		if self.viewParam.aniPlayIn2 then
			self.viewGO:GetComponent(typeof(UnityEngine.Animator)):Play("charactertalentchess_in2", 0, 0)
		end
	else
		self.hero_id = self.viewParam
	end

	self.hero_mo_data = HeroModel.instance:getByHeroId(self.hero_id)
	self._mainCubeId = self.hero_mo_data.talentCubeInfos.own_main_cube_id
	self._canPlayCubeAnim = false
	self._mainCubeItem = nil

	if not self.hero_mo_data then
		print("打印我所拥有的英雄~~~~~~~~~~~~~")

		for k, v in pairs(HeroModel.instance._heroId2MODict) do
			print("英雄id：" .. v.heroId)
		end

		error("找不到英雄数据~~~~~~~~~~~~~~~~id:" .. self.hero_id)

		return
	end

	self:_setChessboardData()
	self:_setDebrisData()
	TaskDispatcher.runDelay(self._playScrollTween, self, 0.3)

	self._last_add_attr = self.hero_mo_data:getTalentGain()

	self:_initTemplateList()

	self._txttalentcn.text = luaLang("talent_charactertalentlevelup_leveltxt" .. self.hero_mo_data:getTalentTxtByHeroType())
	self._txttalentEn.text = luaLang("talent_charactertalentchess_staten" .. self.hero_mo_data:getTalentTxtByHeroType())

	self:_refreshStyleTag()

	self._showMaxLVBtn = true

	self:_showMaxLvBtn()
	self:_hideStyleUpdateAnim()
	self:_initQuickLayoutItem()
end

function CharacterTalentChessView:_playScrollTween()
	self._isPlayScrollTween = true

	if self.own_cube_list then
		self.cubeItemList = self.cubeItemList or self:getUserDataTb_()
		self._goContent:GetComponent(typeof(UnityEngine.UI.ContentSizeFitter)).enabled = false
		self._goContent:GetComponent(gohelper.Type_VerticalLayoutGroup).enabled = false
		self.parallel_sequence = self.parallel_sequence or FlowParallel.New()

		for i, v in ipairs(self.own_cube_list) do
			local transform = self._goContent.transform:GetChild(i - 1)
			local pos_y = recthelper.getAnchorY(transform)

			recthelper.setAnchorY(transform, pos_y - 200)

			local tween_sequence = FlowSequence.New()

			tween_sequence:addWork(WorkWaitSeconds.New(0.03 * (i - 1)))

			local paraller = FlowParallel.New()

			paraller:addWork(TweenWork.New({
				type = "DOAnchorPosY",
				t = 0.35,
				tr = transform,
				to = pos_y,
				ease = EaseType.OutCubic
			}))
			paraller:addWork(TweenWork.New({
				from = 0,
				type = "DOFadeCanvasGroup",
				to = 1,
				t = 0.6,
				go = transform.gameObject
			}))
			tween_sequence:addWork(paraller)

			if i == #self.own_cube_list then
				tween_sequence:addWork(FunctionWork.New(function()
					self._goContent:GetComponent(gohelper.Type_VerticalLayoutGroup).enabled = true
					self._goContent:GetComponent(typeof(UnityEngine.UI.ContentSizeFitter)).enabled = true
					self._isPlayScrollTween = nil
				end))
			end

			self.parallel_sequence:addWork(tween_sequence)

			local cangroup = transform:GetComponent(typeof(UnityEngine.CanvasGroup))
			local item = self:getUserDataTb_()

			item.tr = transform
			item.cangroup = cangroup
			item.anchorY = pos_y

			table.insert(self.cubeItemList, item)
		end

		self.parallel_sequence:start({})
	end
end

function CharacterTalentChessView:_onRefreshCubeList()
	if self.ignore_refresh_list then
		self.ignore_refresh_list = nil

		return
	end

	self._goinspirationItem:GetComponent(typeof(UnityEngine.CanvasGroup)).alpha = 1

	self:_setChessboardData()
	self:_setDebrisData()

	if self.drag_data then
		self:_detectDragResult()
	end

	if self._last_add_attr then
		local temp_list = {}
		local new_add_attr = self.hero_mo_data:getTalentGain()

		for k, v in pairs(new_add_attr) do
			if self._last_add_attr[v.key] then
				local nowValue = v.value
				local lastValue = self._last_add_attr[v.key].value
				local _value = nowValue - lastValue

				if _value > 0 then
					local config = HeroConfig.instance:getHeroAttributeCO(HeroConfig.instance:getIDByAttrType(v.key))

					if config.type == 1 then
						_value = math.floor(nowValue) - math.floor(lastValue)
					end

					if _value > 0 then
						table.insert(temp_list, {
							key = v.key,
							value = _value
						})
					end
				end
			else
				table.insert(temp_list, {
					key = v.key,
					value = v.value
				})
			end
		end

		self:_showAttrTip(temp_list)

		self._last_add_attr = new_add_attr
	end
end

function CharacterTalentChessView:_showAttrTip(temp_list)
	table.sort(temp_list, function(item1, item2)
		return HeroConfig.instance:getIDByAttrType(item1.key) < HeroConfig.instance:getIDByAttrType(item2.key)
	end)
	gohelper.CreateObjList(self, self._showUpdateAttributeTips, temp_list, self._goupdatetipscontent, self._goupdateattributeitem)
	gohelper.setActive(self._goupdatetips, true)

	self._update_attr_tips_ani = self._update_attr_tips_ani or FlowParallel.New()

	self._update_attr_tips_ani:destroy()
	self._update_attr_tips_ani:ctor()

	local data_len = #temp_list

	for i, v in ipairs(temp_list) do
		local transform = self._goupdatetipscontent.transform:GetChild(i - 1)
		local tween_sequence = FlowSequence.New()

		tween_sequence:addWork(WorkWaitSeconds.New(0.06 * (i - 1)))
		tween_sequence:addWork(FunctionWork.New(function()
			gohelper.setActive(transform.gameObject, true)
		end))
		tween_sequence:addWork(TweenWork.New({
			from = 0,
			type = "DOFadeCanvasGroup",
			to = 1,
			t = 0.2,
			go = transform.gameObject
		}))
		tween_sequence:addWork(WorkWaitSeconds.New(1))
		tween_sequence:addWork(TweenWork.New({
			from = 1,
			type = "DOFadeCanvasGroup",
			to = 0,
			t = 0.2,
			go = transform.gameObject
		}))

		if i == data_len then
			tween_sequence:addWork(FunctionWork.New(function()
				gohelper.setActive(self._goupdatetips, false)
			end))
		end

		self._update_attr_tips_ani:addWork(tween_sequence)
	end

	self._update_attr_tips_ani:start({})
end

function CharacterTalentChessView:_showUpdateAttributeTips(obj, data, index)
	local transform = obj.transform
	local image = transform:Find("iconroot/icon"):GetComponent(gohelper.Type_Image)
	local label = transform:Find("name"):GetComponent(gohelper.Type_TextMesh)
	local num = transform:Find("num"):GetComponent(gohelper.Type_TextMesh)
	local config = HeroConfig.instance:getHeroAttributeCO(HeroConfig.instance:getIDByAttrType(data.key))

	data.value = config.type ~= 1 and "+" .. tonumber(string.format("%.3f", data.value / 10)) .. "%" or "+" .. math.floor(data.value)
	num.text = data.value
	label.text = config.name

	UISpriteSetMgr.instance:setCommonSprite(image, "icon_att_" .. config.id, true)
	gohelper.setActive(obj, false)
end

function CharacterTalentChessView:getRabbetCell()
	return self._rabbet_cell
end

function CharacterTalentChessView:_setChessboardData()
	local x_y = string.splitToNumber(HeroResonanceConfig.instance:getTalentAllShape(self.hero_mo_data.heroId, self.hero_mo_data.talent), ",")

	if self.last_talent_level ~= self.hero_mo_data.talent then
		self:_releaseCellList()

		self._rabbet_cell = {}
		self._rabbet_cell_list = {}

		local create_count = 0

		for y = 0, x_y[2] - 1 do
			self._rabbet_cell[y] = {}

			for x = 0, x_y[1] - 1 do
				local game_obj = create_count < self._gomeshContainer.transform.childCount and self._gomeshContainer.transform:GetChild(create_count) or gohelper.clone(self._gomeshItem, self._gomeshContainer)
				local offset_x = x - (x_y[1] - 1) / 2
				local offset_y = (x_y[2] - 1) / 2 - y

				recthelper.setAnchor(game_obj.transform, offset_x * self.cell_length, offset_y * self.cell_length)

				self._rabbet_cell[y][x] = ResonanceCellItem.New(game_obj.gameObject, x, y, self)

				table.insert(self._rabbet_cell_list, self._rabbet_cell[y][x])

				create_count = create_count + 1
			end
		end
	end

	self.last_talent_level = self.hero_mo_data.talent

	for i, v in ipairs(self._rabbet_cell_list) do
		v.is_filled = false
		v.cell_data = nil
	end

	self.cube_data = self.hero_mo_data.talentCubeInfos.data_list

	self:_checkMainCubeNil()
	gohelper.CreateObjList(self, self._onCubeItemShow, self.cube_data, self._gochessContainer, self._gochessitem)
	self:RefreshAllCellLine(true)

	if self.effect_showed then
		self.effect_showed = nil
		self.put_cube_ani = nil
	end

	self:_checkAttenuation()
end

function CharacterTalentChessView:_checkMainCubeNil()
	if self.cube_data then
		for _, v in pairs(self.cube_data) do
			if v.cubeId == self._mainCubeId then
				return
			end
		end
	end

	self._mainCubeItem = nil
end

function CharacterTalentChessView:_checkAttenuation()
	local countDict = {}

	for i, v in ipairs(self.cube_data) do
		countDict[v.cubeId] = countDict[v.cubeId] or countDict[v.cubeId] + 1
	end

	for k, v in pairs(countDict) do
		if v >= 4 then
			CharacterController.instance:dispatchEvent(CharacterEvent.OnGuideAttenuation)

			return
		end
	end
end

function CharacterTalentChessView:playChessIconOutAni()
	if self.cube_data then
		for i, v in ipairs(self.cube_data) do
			local ani = self._gochessContainer.transform:GetChild(i - 1):GetComponent(typeof(UnityEngine.Animator))

			ani:Play("chessitem_out")
		end
	end
end

function CharacterTalentChessView:RefreshAllCellLine(show_effect)
	if self._rabbet_cell_list then
		for i, v in ipairs(self._rabbet_cell_list) do
			v:SetNormal(show_effect)
		end
	end
end

function CharacterTalentChessView:setChessCubeIconAlpha(data)
	if self.cube_data then
		for i, v in ipairs(self.cube_data) do
			local canvas_group = self._gochessContainer.transform:GetChild(i - 1):GetComponent(typeof(UnityEngine.CanvasGroup))

			if not data then
				canvas_group.alpha = 1
			elseif v == data then
				canvas_group.alpha = 0.5
			end
		end
	end
end

function CharacterTalentChessView:_onCubeItemShow(obj, data, index)
	local transform = obj.transform

	obj.name = string.format("%s_%s_%s_%s", data.cubeId, data.direction, data.posX, data.posY)

	local image = transform:GetComponent(gohelper.Type_Image)
	local icon = gohelper.findChildImage(obj, "icon")
	local glow_icon = gohelper.findChildImage(obj, "glow")
	local cell_icon = gohelper.findChildImage(obj, "cell")
	local anim = obj:GetComponent(typeof(UnityEngine.Animator))
	local origin_mat = HeroResonanceConfig.instance:getCubeMatrix(data.cubeId)
	local mat = self:_rotationMatrix(origin_mat, data.direction)
	local isMainCube = self._mainCubeId == data.cubeId

	if self.cur_select_cell_data then
		if self.cur_select_cell_data.cubeId == data.cubeId and self.cur_select_cell_data.direction == data.direction and self.cur_select_cell_data.posX == data.posX and self.cur_select_cell_data.posY == data.posY then
			-- block empty
		else
			gohelper.setActive(icon.gameObject, isMainCube)
			transformhelper.setLocalScale(transform, 1.35, 1.35, 1.35)
		end
	else
		gohelper.setActive(icon.gameObject, isMainCube)
		transformhelper.setLocalScale(transform, 1.35, 1.35, 1.35)
	end

	UISpriteSetMgr.instance:setCharacterTalentSprite(image, "ky_" .. HeroResonanceConfig.instance:getCubeConfig(data.cubeId).icon, true)
	UISpriteSetMgr.instance:setCharacterTalentSprite(icon, HeroResonanceConfig.instance:getCubeConfig(data.cubeId).icon, true)
	UISpriteSetMgr.instance:setCharacterTalentSprite(glow_icon, "glow_" .. HeroResonanceConfig.instance:getCubeConfig(data.cubeId).icon, true)

	local pos_x = self._rabbet_cell[data.posY][data.posX].transform.anchoredPosition.x
	local pos_y = self._rabbet_cell[data.posY][data.posX].transform.anchoredPosition.y

	transformhelper.setLocalRotation(transform, 0, 0, -data.direction * 90)

	local temp_width = self.cell_length * GameUtil.getTabLen(origin_mat[0])
	local temp_height = self.cell_length * GameUtil.getTabLen(origin_mat)
	local not_rotational = data.direction % 2 == 0

	pos_x = pos_x + (not_rotational and temp_width or temp_height) / 2
	pos_y = pos_y + -(not_rotational and temp_height or temp_width) / 2
	pos_x = pos_x - self.half_length
	pos_y = pos_y + self.half_length

	recthelper.setAnchor(transform, pos_x, pos_y)

	local rightful_list = {}
	local y = GameUtil.getTabLen(mat) - 1
	local x = GameUtil.getTabLen(mat[0]) - 1

	for i = 0, y do
		for j = 0, x do
			if mat[i][j] == 1 then
				table.insert(rightful_list, {
					data.posX + j,
					data.posY + i
				})
			end
		end
	end

	for i, v in ipairs(rightful_list) do
		self._rabbet_cell[v[2]][v[1]].is_filled = true

		self._rabbet_cell[v[2]][v[1]]:setCellData(data)
	end

	if isMainCube then
		if not self._mainCubeItem and self._isCanPlaySwitch then
			anim:Play("chessitem_switch", 0, 0)

			self._isCanPlaySwitch = false
		end

		self._mainCubeItem = {
			bg = image,
			icon = icon,
			glow_icon = glow_icon,
			cell_icon = cell_icon,
			anim = anim
		}

		self:_refreshMainStyleCubeItem()
		gohelper.setActive(icon.gameObject, true)
	else
		gohelper.setActive(cell_icon.gameObject, false)
	end
end

function CharacterTalentChessView:_refreshMainStyleCubeItem()
	local mainIcon = HeroResonanceConfig.instance:getCubeConfig(self._mainCubeId).icon
	local iconbg = "ky_" .. mainIcon
	local iconmk = mainIcon
	local glowIcon = "glow_" .. mainIcon
	local temp_attr = string.split(mainIcon, "_")
	local cell_bg = "gz_" .. temp_attr[#temp_attr]
	local cubeId = self.hero_mo_data:getHeroUseStyleCubeId()

	self._showTalentStyle = cubeId

	local co = HeroResonanceConfig.instance:getCubeConfig(cubeId)
	local isOrignStyle = cubeId == self._mainCubeId

	if not isOrignStyle and co then
		local icon = co.icon

		if not string.nilorempty(icon) then
			iconbg = "ky_" .. icon
			iconmk = "mk_" .. icon
			glowIcon = "mk_" .. icon
		end
	end

	if self.drag_dic_image then
		local dragItem = self.drag_dic_image[self._mainCubeId]

		if dragItem then
			local dragIcon = dragItem:GetComponent(gohelper.Type_Image)

			UISpriteSetMgr.instance:setCharacterTalentSprite(dragIcon, iconmk, true)
		end
	end

	if self._mainCubeItem then
		UISpriteSetMgr.instance:setCharacterTalentSprite(self._mainCubeItem.bg, iconbg, true)
		UISpriteSetMgr.instance:setCharacterTalentSprite(self._mainCubeItem.icon, iconmk, true)
		UISpriteSetMgr.instance:setCharacterTalentSprite(self._mainCubeItem.glow_icon, glowIcon, true)
		UISpriteSetMgr.instance:setCharacterTalentSprite(self._mainCubeItem.cell_icon, cell_bg, true)
		gohelper.setActive(self._mainCubeItem.cell_icon.gameObject, not isOrignStyle)
	end
end

function CharacterTalentChessView:_rotationMatrix(mat, rotation_count)
	local temp_mat = mat

	while rotation_count > 0 do
		temp_mat = {}

		local m = GameUtil.getTabLen(mat)
		local n = GameUtil.getTabLen(mat[0])

		for i = 0, n - 1 do
			temp_mat[i] = {}

			for j = 0, m - 1 do
				temp_mat[i][j] = mat[m - j - 1][i]
			end
		end

		rotation_count = rotation_count - 1

		if rotation_count > 0 then
			mat = temp_mat
		end
	end

	return temp_mat
end

function CharacterTalentChessView:_setDebrisData()
	local own_cube_list = self.hero_mo_data.talentCubeInfos.own_cube_list

	self.own_cube_list = own_cube_list

	table.sort(own_cube_list, function(item1, item2)
		local config1 = HeroResonanceConfig.instance:getCubeConfig(item1.id)
		local config2 = HeroResonanceConfig.instance:getCubeConfig(item2.id)

		return config1.sort < config2.sort
	end)

	self._cubeRoot = self:getUserDataTb_()

	gohelper.CreateObjList(self, self._onDebrisItemShow, own_cube_list, self._goContent, self._goinspirationItem)
	gohelper.setActive(self._goEmpty, #own_cube_list == 0)
	gohelper.setActive(self._goMaxLevel, #own_cube_list > 0)

	local _isUnlockStyle = TalentStyleModel.instance:isUnlockStyleSystem(self.hero_mo_data.talent)

	gohelper.setActive(self._gostylechange, _isUnlockStyle)

	if self._isPlayScrollTween then
		if self.parallel_sequence then
			self.parallel_sequence:onDestroyInternal()

			self.parallel_sequence = nil
		end

		if self.cubeItemList then
			for _, item in ipairs(self.cubeItemList) do
				recthelper.setAnchorY(item.tr.transform, item.anchorY)

				item.cangroup.alpha = 1
			end
		end

		self._goContent:GetComponent(gohelper.Type_VerticalLayoutGroup).enabled = true
		self._goContent:GetComponent(typeof(UnityEngine.UI.ContentSizeFitter)).enabled = true
		self._isPlayScrollTween = nil
	end
end

function CharacterTalentChessView:_onDebrisItemShow(obj, data, index)
	local transform = obj.transform

	obj.name = index

	local cell_bg = transform:Find("item/slot"):GetComponent(gohelper.Type_Image)
	local icon = transform:Find("item/slot/icon"):GetComponent(gohelper.Type_Image)
	local countbg = transform:Find("item/slot/countbg")
	local count = transform:Find("item/slot/countbg/count"):GetComponent(gohelper.Type_TextMesh)
	local glow_icon = transform:Find("item/slot/glow"):GetComponent(gohelper.Type_Image)
	local level = transform:Find("level/level"):GetComponent(gohelper.Type_TextMesh)
	local maincubebg = transform:Find("stylebg")

	SLFramework.UGUI.UIDragListener.Get(cell_bg.gameObject):AddDragBeginListener(self._onDragBegin, self, data.id)
	SLFramework.UGUI.UIDragListener.Get(cell_bg.gameObject):AddDragListener(self._onDrag, self)
	SLFramework.UGUI.UIDragListener.Get(cell_bg.gameObject):AddDragEndListener(self._onDragEnd, self)
	SLFramework.UGUI.UIClickListener.Get(cell_bg.gameObject):AddClickDownListener(self._onClickDownHandler, self)
	recthelper.setAnchorX(countbg.transform, 3.4 - 56 * HeroResonanceConfig.instance:getLastRowfulPos(data.id))

	count.text = data.own
	level.text = "LV." .. data.level

	local cubeRoot = self._cubeRoot[data.id]

	cubeRoot = cubeRoot or {
		root = transform:Find("attributeContent").gameObject,
		item = transform:Find("attributeContent/attributeItem").gameObject,
		levelTxt = level,
		Icon = icon,
		glow_icon = glow_icon,
		cell_bg = cell_bg,
		countbg = countbg,
		anim = obj:GetComponent(typeof(UnityEngine.Animator))
	}
	self._cubeRoot[data.id] = cubeRoot

	local isMainCube = self._mainCubeId == data.id

	self:_refreshAttrItem(data.id)
	gohelper.setActive(maincubebg, isMainCube)
end

function CharacterTalentChessView:_refreshAttrItem(id, cus_cube_level)
	if not self._cubeRoot or not self._cubeRoot[id] then
		return
	end

	local root = self._cubeRoot[id].root
	local item = self._cubeRoot[id].item
	local txt = self._cubeRoot[id].levelTxt
	local anim = self._cubeRoot[id].anim
	local cube_attr_config = self.hero_mo_data:getCurTalentLevelConfig(id)
	local attr_tab = {}

	self.hero_mo_data:getTalentStyleCubeAttr(id, attr_tab, nil, nil, cus_cube_level)

	local temp_list = {}

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

	local icon = HeroResonanceConfig.instance:getCubeConfig(id).icon
	local glow_icon = "glow_" .. icon
	local temp_attr = string.split(icon, "_")
	local cell_bg = "gz_" .. temp_attr[#temp_attr]
	local styleCubeId = self:getMainStyleCube(id)

	if styleCubeId then
		local co = HeroResonanceConfig.instance:getCubeConfig(styleCubeId)

		if co then
			icon = "mk_" .. co.icon
			glow_icon = "mk_" .. co.icon
			cell_bg = cell_bg .. "_2"
		end
	end

	self._cus_cube_level = cus_cube_level

	if id == self._mainCubeId and cus_cube_level == nil and self._canPlayCubeAnim then
		anim:Play("switch", 0, 0)
		TaskDispatcher.cancelTask(self._showMainCubeItemCB, self)
		TaskDispatcher.runDelay(self._showMainCubeItemCB, self, 0.16)
	else
		txt.text = "LV." .. (cus_cube_level or cube_attr_config.level)

		gohelper.CreateObjList(self, self._onDebrisAttrItemShow, temp_list, root, item)
		UISpriteSetMgr.instance:setCharacterTalentSprite(self._cubeRoot[id].Icon, icon, true)
		UISpriteSetMgr.instance:setCharacterTalentSprite(self._cubeRoot[id].glow_icon, glow_icon, true)
		UISpriteSetMgr.instance:setCharacterTalentSprite(self._cubeRoot[id].cell_bg, cell_bg, true)

		if cus_cube_level == nil and not self._showMaxLVBtn then
			self._showMaxLVBtn = true

			self:_showMaxLvBtn()
		end
	end
end

function CharacterTalentChessView:_showMainCubeItemCB()
	self._canPlayCubeAnim = false

	self:_refreshAttrItem(self._mainCubeId, self._cus_cube_level)
end

function CharacterTalentChessView:_onDebrisAttrItemShow(obj, data, index)
	local transform = obj.transform
	local icon = transform:Find("icon"):GetComponent(gohelper.Type_Image)
	local name = transform:Find("name"):GetComponent(gohelper.Type_TextMesh)
	local num = transform:Find("name/num"):GetComponent(gohelper.Type_TextMesh)
	local config = HeroConfig.instance:getHeroAttributeCO(HeroConfig.instance:getIDByAttrType(data.key))

	name.text = config.name

	UISpriteSetMgr.instance:setCommonSprite(icon, "icon_att_" .. config.id)

	data.value = config.type ~= 1 and data.value / 10 .. "%" or not data.is_special and data.config[data.key] / 10 .. "%" or math.floor(data.value)
	num.text = "+" .. data.value
end

function CharacterTalentChessView:showCurSelectCubeAttr(cell_data)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Copies)
	gohelper.setActive(self._gotip, true)

	local attr_tab = {}

	self.hero_mo_data:getTalentStyleCubeAttr(cell_data.cubeId, attr_tab)

	local temp_list = {}
	local cube_attr_config = self.hero_mo_data:getCurTalentLevelConfig(cell_data.cubeId)

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
	gohelper.CreateObjList(self, self._onShowSingleCubeAttrTips, temp_list, self._gosingleTipsContent, self._gosingleAttributeItem)

	local target_transform = gohelper.findChild(self._gochessContainer, string.format("%s_%s_%s_%s", cell_data.cubeId, cell_data.direction, cell_data.posX, cell_data.posY))

	if target_transform then
		target_transform = target_transform.transform

		local scale = 1.45

		transformhelper.setLocalScale(target_transform, scale, scale, scale)
		gohelper.setActive(target_transform:Find("icon").gameObject, true)
	end
end

function CharacterTalentChessView:_onShowSingleCubeAttrTips(obj, data, index)
	if index ~= 1 then
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

function CharacterTalentChessView:_onContainerDragBegin(param, pointerEventData)
	self:_btnCloseTipOnClick()

	self.is_draging = true

	local temp_pos = recthelper.screenPosToAnchorPos(pointerEventData.position, self._gomeshContainer.transform)
	local temp_pos_drag_x, temp_pos_drag_y = recthelper.getAnchor(self.drag_container_transform)

	self.drag_offset_x = temp_pos_drag_x - temp_pos.x
	self.drag_offset_y = temp_pos_drag_y - temp_pos.y
end

function CharacterTalentChessView:_onContainerDrag(param, pointerEventData)
	if not self.drag_data then
		return
	end

	local temp_pos = recthelper.screenPosToAnchorPos(pointerEventData.position, self._gomeshContainer.transform)

	recthelper.setAnchor(self.drag_container_transform, temp_pos.x + (self.drag_offset_x or 0), temp_pos.y + (self.drag_offset_y or 0))
	self:_detectDragResult()
end

function CharacterTalentChessView:_onDragBegin(param, pointerEventData)
	self:_btnCloseTipOnClick()

	if self.recover_data then
		self:_setChessboardData()

		self.cur_drag_is_get = nil
		self.recover_data = nil
	end

	self:_createDragItem(param)
end

function CharacterTalentChessView:_onDrag(param, pointerEventData)
	if not self.drag_data then
		return
	end

	local temp_pos = recthelper.screenPosToAnchorPos(GamepadController.instance:getMousePosition(), self._gomeshContainer.transform)

	recthelper.setAnchor(self.drag_container_transform, temp_pos.x, temp_pos.y)
	self:_detectDragResult()
end

function CharacterTalentChessView:_detectDragResult()
	self.cur_fill_count = 0
	self.cross_point = false

	self:setChessCubeIconAlpha()

	for i, v in ipairs(self._rabbet_cell_list) do
		local cell = v

		cell:SetNormal()

		for index, cube in ipairs(self.drag_cube_child_list[self.drag_data.drag_id]) do
			local cube_transform = cube.transform
			local temp_x = recthelper.getAnchorX(cube_transform)
			local temp_y = recthelper.getAnchorY(cube_transform)
			local temp_dir = -self.drag_data.direction * 90
			local cube_anchor_pos_x = recthelper.getAnchorX(self.drag_container_transform) + temp_x * math.cos(math.rad(temp_dir)) - temp_y * math.sin(math.rad(temp_dir))
			local cube_anchor_pos_y = recthelper.getAnchorY(self.drag_container_transform) + temp_x * math.sin(math.rad(temp_dir)) + temp_y * math.cos(math.rad(temp_dir))
			local is_covered = cell:detectPosCover(cube_anchor_pos_x, cube_anchor_pos_y)

			if is_covered then
				if cube.rightful then
					if cell.is_filled then
						cell:SetRed()

						if self.setChessCubeIconAlpha then
							self:setChessCubeIconAlpha(cell.cell_data)
						end
					else
						self.cur_fill_count = self.cur_fill_count + 1
					end
				end

				if self.drag_cube_top_left_child == cube_transform then
					self.adsorbent_pos_x = cell.pos_x
					self.adsorbent_pos_y = cell.pos_y
				end

				self.cross_point = true
				self.release_offset_x = cell.position_x - cube_anchor_pos_x
				self.release_offset_y = cell.position_y - cube_anchor_pos_y
			end
		end
	end

	if self.cur_fill_count == HeroResonanceConfig.instance:getCubeRightful(self.drag_data.drag_id) then
		local y = GameUtil.getTabLen(self.cur_matrix) - 1
		local x = GameUtil.getTabLen(self.cur_matrix[0]) - 1
		local offset_x = self.adsorbent_pos_x
		local offset_y = self.adsorbent_pos_y

		for i = 0, y do
			for j = 0, x do
				if self.cur_matrix[i][j] == 1 then
					if not self._rabbet_cell[offset_y + i][offset_x + j] then
						logError(j, i, offset_x, offset_y)
					end

					if not self.cur_matrix[i - 1] or self.cur_matrix[i - 1][j] ~= 1 then
						self._rabbet_cell[offset_y + i][offset_x + j]:lightTop()
					end

					if not self.cur_matrix[i][j + 1] or self.cur_matrix[i][j + 1] ~= 1 then
						self._rabbet_cell[offset_y + i][offset_x + j]:lightRight()
					end

					if not self.cur_matrix[i + 1] or self.cur_matrix[i + 1][j] ~= 1 then
						self._rabbet_cell[offset_y + i][offset_x + j]:lightBottom()
					end

					if not self.cur_matrix[i][j - 1] or self.cur_matrix[i][j - 1] ~= 1 then
						self._rabbet_cell[offset_y + i][offset_x + j]:lightLeft()
					end

					if self.cur_matrix[i - 1] and self.cur_matrix[i - 1][j] == 1 then
						self._rabbet_cell[offset_y + i][offset_x + j]:hideTop()
					end

					if self.cur_matrix[i][j + 1] == 1 then
						self._rabbet_cell[offset_y + i][offset_x + j]:hideRight()
					end

					if self.cur_matrix[i + 1] and self.cur_matrix[i + 1][j] == 1 then
						self._rabbet_cell[offset_y + i][offset_x + j]:hideBottom()
					end

					if self.cur_matrix[i][j - 1] == 1 then
						self._rabbet_cell[offset_y + i][offset_x + j]:hideLeft()
					end
				end
			end
		end
	end
end

function CharacterTalentChessView:_onDragEnd(param, pointerEventData)
	self.is_draging = false
	self.recover_data = nil

	if not self.drag_data then
		self:_releaseDragItem()

		self.cur_fill_count = 0

		return
	end

	if self._dragEffectLoader and self.cur_fill_count < 2 then
		self.cur_fill_count = 0
		self.cross_point = nil
	end

	if self.cur_fill_count == HeroResonanceConfig.instance:getCubeRightful(self.drag_data.drag_id) then
		self.ignore_refresh_list = self.cur_drag_is_get

		self:releaseFromChess()

		self.put_cube_ani = self.drag_data
		self.drag_data.posX = self.adsorbent_pos_x
		self.drag_data.posY = self.adsorbent_pos_y

		if self.cur_select_cell_data then
			self.cur_select_cell_data.cubeId = self.put_cube_ani.drag_id
			self.cur_select_cell_data.posX = self.drag_data.posX
			self.cur_select_cell_data.posY = self.drag_data.posY
			self.cur_select_cell_data.direction = self.drag_data.direction

			self:requestPutCube()

			self.cur_fill_count = 0

			return
		end

		local temp_top_left = self._rabbet_cell[self.adsorbent_pos_y][self.adsorbent_pos_x].transform
		local temp_offset = temp_top_left:InverseTransformPoint(self.drag_cube_top_left_child.position)

		self._put_ani_flow = self._put_ani_flow or FlowParallel.New()

		self._put_ani_flow:destroy()
		self._put_ani_flow:ctor()
		self._put_ani_flow:addWork(TweenWork.New({
			type = "DOAnchorPos",
			t = 0.1,
			tr = self.drag_container_transform,
			tox = recthelper.getAnchorX(self.drag_container_transform) - temp_offset.x,
			toy = recthelper.getAnchorY(self.drag_container_transform) - temp_offset.y,
			ease = EaseType.InCubic
		}))
		self._put_ani_flow:addWork(TweenWork.New({
			toz = 1,
			type = "DOScale",
			tox = 1.35,
			toy = 1.35,
			t = 0.1,
			tr = self.drag_dic_image[self.drag_data.drag_id],
			ease = EaseType.InCubic
		}))
		self._put_ani_flow:registerDoneListener(self.onPutAniDone, self)

		if self._rabbet_cell_list then
			for i, v in ipairs(self._rabbet_cell_list) do
				v:hideEmptyBg()
			end
		end

		self.drag_data = nil

		self._put_ani_flow:start()
	elseif self.cross_point then
		AudioMgr.instance:trigger(AudioEnum.Talent.play_ui_property_fail)

		local temp_x = recthelper.getAnchorX(self.drag_container_transform)
		local temp_y = recthelper.getAnchorY(self.drag_container_transform)

		recthelper.setAnchor(self.drag_container_transform, temp_x + self.release_offset_x, temp_y + self.release_offset_y)

		if self.cur_drag_is_get then
			self.recover_data = {}
			self.recover_data.drag_id = self.drag_data.drag_id
			self.recover_data.initial_direction = self.drag_data.initial_direction
			self.recover_data.posX = self.drag_data.posX
			self.recover_data.posY = self.drag_data.posY
		end
	else
		self:releaseFromChess()
		AudioMgr.instance:trigger(AudioEnum.Talent.play_ui_resonate_property_click)
		self:_releaseDragItem()
	end

	self.cur_fill_count = 0
end

function CharacterTalentChessView:releaseFromChess()
	if self.cur_drag_is_get then
		if self.drag_data.drag_id and self.drag_data.initial_direction and self.drag_data.posX and self.drag_data.posY then
			HeroRpc.instance:PutTalentCubeRequest(self.hero_mo_data.heroId, HeroResonanceEnum.GetCube, self.drag_data.drag_id, self.drag_data.initial_direction, self.drag_data.posX, self.drag_data.posY)
		else
			self:_onRefreshCubeList()
		end
	end

	self.cur_drag_is_get = nil
end

function CharacterTalentChessView:_onClickDownHandler()
	AudioMgr.instance:trigger(AudioEnum.Talent.play_ui_resonate_property_click)
end

function CharacterTalentChessView:onPutAniDone()
	self._put_ani_flow:unregisterDoneListener(self.onPutAniDone, self)

	self.drag_data = self.put_cube_ani

	self:requestPutCube()
end

function CharacterTalentChessView:requestPutCube()
	AudioMgr.instance:trigger(AudioEnum.Talent.play_ui_property_success)
	HeroRpc.instance:PutTalentCubeRequest(self.hero_mo_data.heroId, HeroResonanceEnum.PutCube, self.drag_data.drag_id, self.drag_data.direction, self.adsorbent_pos_x, self.adsorbent_pos_y)
	self:_releaseDragItem()
end

function CharacterTalentChessView:_releaseDragItem()
	self.cross_point = false

	if self.drag_data then
		gohelper.setActive(self.drag_container_transform:Find(self.drag_data.drag_id).gameObject, false)
	end

	self.drag_data = nil

	self:RefreshAllCellLine()
	gohelper.setActive(self.drag_container, false)
end

function CharacterTalentChessView:_createDragItem(cubeId, direction, posX, posY)
	if self._dragEffectLoader and cubeId ~= 18 then
		return
	end

	if not self.drag_container then
		self.drag_container = self._godragContainer
		self.drag_container_transform = self.drag_container.transform
		self._dragContainerDragCom = SLFramework.UGUI.UIDragListener.Get(self.drag_container)

		self._dragContainerDragCom:AddDragBeginListener(self._onContainerDragBegin, self)
		self._dragContainerDragCom:AddDragListener(self._onContainerDrag, self)
		self._dragContainerDragCom:AddDragEndListener(self._onDragEnd, self)
		SLFramework.UGUI.UIClickListener.Get(self.drag_container):AddClickListener(self._rotateCube, self)
	end

	transformhelper.setLocalRotation(self.drag_container_transform, 0, 0, 0)

	local drag_cube_transform = self.drag_container_transform:Find(cubeId)

	drag_cube_transform = drag_cube_transform or gohelper.clone(self._gocellModel, self.drag_container, cubeId)

	gohelper.setActive(self.drag_container, true)

	if self.drag_data then
		gohelper.setActive(self.drag_container_transform:Find(self.drag_data.drag_id).gameObject, false)
	else
		self.drag_data = {}
	end

	self.drag_data.drag_id = cubeId
	self.drag_data.direction = direction or 0
	self.drag_data.initial_direction = direction or 0

	local drag_cube = drag_cube_transform.gameObject

	self.drag_cube_child_list = self.drag_cube_child_list or {}

	if not self.drag_cube_child_list[cubeId] then
		self.drag_cube_child_list[cubeId] = {}

		self:_createDragCubeChild(self.drag_cube_child_list[cubeId], cubeId, drag_cube)
	end

	local scale = 1.45

	transformhelper.setLocalScale(self.drag_dic_image[self.drag_data.drag_id], scale, scale, 1)
	gohelper.setActive(drag_cube, true)
	self:_setTopLeftTarget()
end

function CharacterTalentChessView:_createDragCubeChild(child_list, cubeId, drag_cube)
	local mat = self:_rotationMatrix(HeroResonanceConfig.instance:getCubeMatrix(cubeId), 0)
	local y = GameUtil.getTabLen(mat) - 1
	local x = GameUtil.getTabLen(mat[0]) - 1
	local center_pos_x = 0
	local center_pos_y = 0

	for i = 0, y do
		for j = 0, x do
			if mat[i][j] == 1 and j <= center_pos_x then
				center_pos_x = j

				if center_pos_y <= i then
					center_pos_y = i
				end
			end
		end
	end

	local temp_image

	self.drag_cube_origin_mat = self.drag_cube_origin_mat or {}
	self.drag_cube_origin_mat[cubeId] = self.drag_cube_origin_mat[cubeId] or {}

	for i = 0, y do
		self.drag_cube_origin_mat[cubeId][i] = {}

		for j = 0, x do
			local tab = self:getUserDataTb_()

			tab.gameObject = gohelper.clone(self._gocellModel, drag_cube)
			tab.transform = tab.gameObject.transform
			tab.rightful = mat[i][j] == 1

			local pos_x = (j - center_pos_x) * self.cell_length
			local pos_y = (center_pos_y - i) * self.cell_length

			recthelper.setAnchor(tab.gameObject.transform, pos_x, pos_y)

			self.drag_cube_origin_mat[cubeId][i][j] = tab.gameObject

			table.insert(child_list, tab)

			if i == 0 and j == 0 then
				local temp_obj = gohelper.clone(self._goraychessitem, tab.gameObject)

				gohelper.setActive(temp_obj, true)

				temp_image = temp_obj:GetComponent(gohelper.Type_Image)

				local icon = HeroResonanceConfig.instance:getCubeConfig(cubeId).icon
				local styleCubeId = self:getMainStyleCube(cubeId)

				if styleCubeId then
					local co = HeroResonanceConfig.instance:getCubeConfig(styleCubeId)

					if co then
						icon = "mk_" .. co.icon
					end
				end

				UISpriteSetMgr.instance:setCharacterTalentSprite(temp_image, icon, true)

				local temp_width = self.cell_length * GameUtil.getTabLen(mat[0])
				local temp_height = self.cell_length * GameUtil.getTabLen(mat)

				recthelper.setAnchor(temp_obj.transform, temp_width / 2 - self.half_length, -(temp_height / 2) + self.half_length)

				self.drag_image = self.drag_image or self:getUserDataTb_()
				self.drag_dic_image = self.drag_dic_image or self:getUserDataTb_()

				SLFramework.UGUI.UIDragListener.Get(temp_obj):AddDragBeginListener(self._onContainerDragBegin, self)
				SLFramework.UGUI.UIDragListener.Get(temp_obj):AddDragListener(self._onContainerDrag, self)
				SLFramework.UGUI.UIDragListener.Get(temp_obj):AddDragEndListener(self._onDragEnd, self)
				SLFramework.UGUI.UIClickListener.Get(temp_obj):AddClickListener(self._rotateCube, self)
				table.insert(self.drag_image, temp_obj)

				self.drag_dic_image[cubeId] = temp_obj.transform
			end
		end
	end
end

function CharacterTalentChessView:getMainStyleCube(cubeId)
	if cubeId == self._mainCubeId then
		local styleCubeId = self.hero_mo_data:getHeroUseStyleCubeId()

		if styleCubeId ~= self._mainCubeId then
			return styleCubeId
		end
	end
end

function CharacterTalentChessView:_setTopLeftTarget()
	local temp_mat = self:_rotationMatrix(self.drag_cube_origin_mat[self.drag_data.drag_id], self.drag_data.direction)

	self.drag_cube_top_left_child = temp_mat[0][0].transform
	self.cur_matrix = self:_rotationMatrix(HeroResonanceConfig.instance:getCubeMatrix(self.drag_data.drag_id), self.drag_data.direction)
end

function CharacterTalentChessView:_onGetCube(data)
	if self.recover_data then
		if self.recover_data.drag_id == data.cubeId and self.recover_data.direction == data.direction and self.recover_data.posX == data.posX and self.recover_data.posY == data.posY then
			-- block empty
		else
			if self._rabbet_cell_list then
				for i, v in ipairs(self._rabbet_cell_list) do
					v:hideEmptyBg()
				end
			end

			self:_setChessboardData()
		end

		self.cur_drag_is_get = nil
		self.recover_data = nil
	end

	if self._rabbet_cell_list then
		for i, v in ipairs(self._rabbet_cell_list) do
			if v.cell_data == data then
				v.is_filled = false
			end
		end
	end

	self.cur_fill_count = 0

	self:_createDragItem(data.cubeId, data.direction, data.posX, data.posY)
	transformhelper.setLocalRotation(self.drag_container_transform, 0, 0, -self.drag_data.direction * 90)
	self:_setTopLeftTarget()

	local temp_cell = self._rabbet_cell[data.posY][data.posX]

	recthelper.setAnchor(self.drag_container_transform, temp_cell.position_x, temp_cell.position_y)

	local temp_anchor_cube_pos = self.drag_container_transform.parent.transform:InverseTransformPoint(self.drag_cube_top_left_child.position)
	local temp_offset_x = temp_cell.position_x - temp_anchor_cube_pos.x
	local temp_offset_y = temp_cell.position_y - temp_anchor_cube_pos.y

	gohelper.setActive(self._gochessContainer.transform:Find(string.format("%s_%s_%s_%s", data.cubeId, data.direction, data.posX, data.posY)).gameObject, false)
	recthelper.setAnchor(self.drag_container_transform, temp_cell.position_x + temp_offset_x, temp_cell.position_y + temp_offset_y)

	self.cur_drag_is_get = true
	self.drag_data.posX = data.posX
	self.drag_data.posY = data.posY

	self:RefreshAllCellLine()
end

function CharacterTalentChessView:onCubeClick(data)
	self:_onGetCube(data)
	self:_rotateCube()
end

function CharacterTalentChessView:_rotateCube()
	if self.is_draging then
		return
	end

	if not self.drag_data then
		return
	end

	local direction = self.drag_data.direction + 1

	self.drag_data.direction = direction > 3 and 0 or direction

	if self.cur_select_cell_data then
		self.cur_select_cell_data.direction = self.drag_data.direction
	end

	transformhelper.setLocalRotation(self.drag_container_transform, 0, 0, -self.drag_data.direction * 90)
	self:_setTopLeftTarget()
	self:_detectDragResult()
	self:_onDragEnd()
end

function CharacterTalentChessView:onClose()
	TaskDispatcher.cancelTask(self._showMainCubeItemCB, self)
end

function CharacterTalentChessView:_releaseCellList()
	if self._rabbet_cell_list then
		for i, v in ipairs(self._rabbet_cell_list) do
			v:releaseSelf()
		end

		self._rabbet_cell_list = nil
	end
end

function CharacterTalentChessView:_onBtnPutTalentSchemeRequest()
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.PutTalent) then
		GuideModel.instance:setFlag(GuideModel.GuideFlag.PutTalent, nil)
		self:_putTalentSchemeRequest()

		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.RecommendTalentChess, MsgBoxEnum.BoxType.Yes_No, function()
		self:_putTalentSchemeRequest()
	end)
end

function CharacterTalentChessView:_putTalentSchemeRequest()
	self:_releaseOperation()

	local talent_config = HeroResonanceConfig.instance:getTalentConfig(self.hero_mo_data.heroId, self.hero_mo_data.talent)
	local talentMould = talent_config.talentMould

	HeroRpc.instance:PutTalentSchemeRequest(self.hero_mo_data.heroId, self.hero_mo_data.talent, talentMould, string.splitToNumber(talent_config.exclusive, "#")[1])
end

function CharacterTalentChessView:_initTemplateList()
	table.sort(self.hero_mo_data.talentTemplates, CharacterTalentChessView.sortTemplate)

	local tempateStr = luaLang("talent_charactertalentchess_template" .. self.hero_mo_data:getTalentTxtByHeroType())
	local nameList = {}
	local _isUnlockStyle = TalentStyleModel.instance:isUnlockStyleSystem(self.hero_mo_data.talent)

	for i, v in ipairs(self.hero_mo_data.talentTemplates) do
		if string.nilorempty(v.name) then
			if not (tempateStr .. i) then
				local name = v.name

				if _isUnlockStyle then
					local mo = TalentStyleModel.instance:getTalentStyle(self._mainCubeId, v.style)

					if mo then
						::label_65_0::

						local var_65_1 = mo._styleCo

						if mo._styleCo then
							local iconIndex = mo._styleCo.tagicon

							if not string.nilorempty(iconIndex) then
								local index = tonumber(iconIndex) - 1

								name = string.format("<sprite=%s>", index) .. name
							end
						end
					end
				end

				table.insert(nameList, name)

				if v.id == self.hero_mo_data.useTalentTemplateId then
					self._curSelectTemplateIndex = i
					self._txtgroupname.text = name
				end
			end
		end
	end

	self._dropresonategroup:ClearOptions()
	self._dropresonategroup:AddOptions(nameList)
	self._dropresonategroup:SetValue(self._curSelectTemplateIndex - 1)

	self._templateInitDone = true
end

function CharacterTalentChessView:_opDropdownChange(idx)
	if not self._templateInitDone then
		return
	end

	idx = idx or 0

	local index = idx + 1

	if self._curSelectTemplateIndex ~= index then
		self._curSelectTemplateIndex = index

		HeroRpc.instance:UseTalentTemplateRequest(self.hero_mo_data.heroId, self.hero_mo_data.talentTemplates[index].id)
	end
end

function CharacterTalentChessView:_releaseOperation()
	self:_btnCloseTipOnClick()
	self:_releaseDragItem()
	self:setChessCubeIconAlpha()
end

function CharacterTalentChessView:_onUseTalentTemplateReply()
	self._isCanPlaySwitch = true
	self._mainCubeItem = nil

	self:_chooseOtherStyleOrTemplate()
	self:_showTemplateName()
end

function CharacterTalentChessView:_playMainCubeSwitchAnim()
	if self._mainCubeItem and self._isCanPlaySwitch then
		self._mainCubeItem.anim:Play("chessitem_switch", 0, 0)

		self._isCanPlaySwitch = false
	end
end

function CharacterTalentChessView:_chooseOtherStyleOrTemplate()
	self:_releaseOperation()
	self:_refreshStyleTag()
	self:_refreshMainStyleCubeItem()
	TaskDispatcher.cancelTask(self._hideStyleUpdateAnim, self)
	gohelper.setActive(self._styleupdate, true)
	TaskDispatcher.runDelay(self._hideStyleUpdateAnim, self, 0.6)
end

function CharacterTalentChessView:_onRenameTalentTemplateReply()
	self:_initTemplateList()
end

function CharacterTalentChessView:_onUseTalentStyleReply()
	self:_cutTalentStyle()
end

function CharacterTalentChessView:_cutTalentStyle()
	local style = self.hero_mo_data:getHeroUseCubeStyleId()

	if self._showTalentStyle == style then
		return
	end

	self._showTalentStyle = style
	self._isCanPlaySwitch = true
	self._canPlayCubeAnim = true
	self._mainCubeId = self._mainCubeId or self.hero_mo_data.talentCubeInfos.own_main_cube_id

	if self._cubeRoot and self._cubeRoot[self._mainCubeId] then
		local root = self._cubeRoot[self._mainCubeId].root
		local itemPrefab = self._cubeRoot[self._mainCubeId].item

		if root and itemPrefab then
			self:_refreshAttrItem(self._mainCubeId)
		end
	end

	self:_onRefreshCubeList()
	self:_setChessboardData()
	self:_chooseOtherStyleOrTemplate()

	self._canPlayCubeAnim = true

	self:_initTemplateList()
	self:_playMainCubeSwitchAnim()
end

function CharacterTalentChessView:_hideStyleUpdateAnim()
	gohelper.setActive(self._styleupdate, false)
end

function CharacterTalentChessView:_refreshStyleTag()
	local style = self.hero_mo_data:getHeroUseCubeStyleId(self.hero_id)
	local mo = TalentStyleModel.instance:getTalentStyle(self._mainCubeId, style)
	local name, tag = mo:getStyleTag()
	local growTagIcon, nomalTagIcon = mo:getStyleTagIcon()

	self._txtlabel.text = name

	UISpriteSetMgr.instance:setCharacterTalentSprite(self._styleslot, nomalTagIcon, true)
	UISpriteSetMgr.instance:setCharacterTalentSprite(self._styleicon, growTagIcon, true)
	UISpriteSetMgr.instance:setCharacterTalentSprite(self._styleglow, growTagIcon, true)
end

function CharacterTalentChessView:_showTemplateName()
	for i, v in ipairs(self.hero_mo_data.talentTemplates) do
		if v.id == self.hero_mo_data.useTalentTemplateId then
			local tempateStr = luaLang("talent_charactertalentchess_template" .. self.hero_mo_data:getTalentTxtByHeroType())

			if string.nilorempty(v.name) then
				if not (tempateStr .. self._curSelectTemplateIndex) then
					local name = v.name
					local mo = TalentStyleModel.instance:getTalentStyle(self._mainCubeId, v.style)

					if mo then
						::label_76_0::

						local var_76_1 = mo._styleCo

						if mo._styleCo then
							local iconIndex = mo._styleCo.tagicon

							if not string.nilorempty(iconIndex) then
								local index = tonumber(iconIndex) - 1

								name = string.format("<sprite=%s>", index) .. name
							end

							self._txtgroupname.text = name
						end
					end
				end
			end
		end
	end
end

function CharacterTalentChessView:_onBtnChangeTemplateName()
	ViewMgr.instance:openView(ViewName.CharacterTalentModifyNameView, {
		self.hero_mo_data.heroId,
		self.hero_mo_data.talentTemplates[self._curSelectTemplateIndex].id
	})
end

function CharacterTalentChessView.sortTemplate(item1, item2)
	return item1.id < item2.id
end

function CharacterTalentChessView:_onDropClick()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
end

function CharacterTalentChessView:_onStyleChangeClick()
	local param = {
		heroId = self.hero_id
	}

	ViewMgr.instance:openView(ViewName.CharacterTalentChessFilterView, param)
end

function CharacterTalentChessView:_onMaxLevelClick()
	for _, cube in pairs(self.own_cube_list) do
		local id = cube.id
		local maxLevel = HeroConfig.instance:getTalentCubeMaxLevel(id)

		self:_refreshAttrItem(id, self._showMaxLVBtn and maxLevel)
	end

	self._showMaxLVBtn = not self._showMaxLVBtn

	self:_showMaxLvBtn()
	self._leftContentAnim:Play("chessview_content_open", 0, 0)
	self._leftContentAnim:Update(0)
end

function CharacterTalentChessView:_showMaxLvBtn()
	gohelper.setActive(self._gomaxselect, not self._showMaxLVBtn)
	gohelper.setActive(self._gomaxunselect, self._showMaxLVBtn)
end

function CharacterTalentChessView:_onCopyTalentData()
	local cube_data = self.hero_mo_data.talentCubeInfos.data_list
	local str = ""

	for i, v in ipairs(cube_data) do
		str = str .. table.concat({
			v.cubeId,
			v.direction,
			v.posX,
			v.posY
		}, ",")

		if i ~= #cube_data then
			str = str .. "#"
		end
	end

	ZProj.UGUIHelper.CopyText(str)
end

function CharacterTalentChessView:_initQuickLayoutItem()
	self._quickLayoutPanel = gohelper.findChild(self.viewGO, "#btn_recommend/Template")
	self._quickLayoutItems = self._quickLayoutItems or self:getUserDataTb_()

	local togglePrefab = gohelper.findChild(self._quickLayoutPanel, "Viewport/Content/Item")
	local typeCn = HeroResonaceModel.instance:getSpecialCn(self.hero_mo_data)

	for i, _type in ipairs(HeroResonanceEnum.QuickLayoutType) do
		if not self._quickLayoutItems[i] then
			local item = self:getUserDataTb_()
			local childGo = gohelper.cloneInPlace(togglePrefab, "toggle_" .. i)
			local toggle = gohelper.onceAddComponent(childGo, typeof(SLFramework.UGUI.ToggleWrap))

			toggle:AddOnValueChanged(self._onToggleValueChanged, self, i)

			item.go = childGo
			item.toggle = toggle
			item.icon = gohelper.findChild(childGo, "BG")
			item.txt = gohelper.findChildText(childGo, "Text")

			local name = luaLang(_type.name)

			item.txt.text = _type.isNeedParam and GameUtil.getSubPlaceholderLuaLangOneParam(name, typeCn) or name
			self._quickLayoutItems[i] = item

			gohelper.setActive(item.icon, false)
		end

		gohelper.setActive(self._quickLayoutItems[i].go, true)
	end
end

function CharacterTalentChessView:_onToggleValueChanged(index)
	if index == 1 then
		local code = HeroResonaceModel.instance:getCurLayoutShareCode(self.hero_mo_data)

		if not string.nilorempty(code) then
			ZProj.UGUIHelper.CopyText(code)
			GameFacade.showToast(ToastEnum.CharacterTalentShareCodeCopy)
			HeroResonaceModel.instance:saveShareCode(code)
			HeroResonanceController.instance:statShareCode(self.hero_mo_data, false)
		else
			local typecn = HeroResonaceModel.instance:getSpecialCn(self.hero_mo_data)

			ToastController.instance:showToast(ToastEnum.CharacterTalentEmptyLayout, typecn)
		end
	elseif index == 2 then
		local param = {
			heroMo = self.hero_mo_data
		}

		ViewMgr.instance:openView(ViewName.CharacterTalentChessCopyView, param)
	else
		self:_onBtnPutTalentSchemeRequest()
	end

	self:_hideQuickLayoutPanel()
end

function CharacterTalentChessView:_activeToggleGraphic(index)
	if not self._quickLayoutItems then
		return
	end

	for i, item in ipairs(self._quickLayoutItems) do
		if item.icon then
			gohelper.setActive(item.icon.gameObject, index == i)
		end
	end
end

function CharacterTalentChessView:_showQuickLayoutPanel()
	if self._quickLayoutPanel then
		local isActive = not self._quickLayoutPanel.gameObject.activeSelf

		gohelper.setActive(self._quickLayoutPanel, isActive)

		local scaleY = isActive and -1 or 1

		transformhelper.setLocalScale(self._quickLayoutIcon.transform, 1, scaleY, 1)
	end
end

function CharacterTalentChessView:_hideQuickLayoutPanel()
	gohelper.setActive(self._quickLayoutPanel, false)
	transformhelper.setLocalScale(self._quickLayoutIcon.transform, 1, 1, 1)
end

function CharacterTalentChessView:_onUseShareCode(msg)
	self:_cutTalentStyle()
	HeroResonanceController.instance:statShareCode(self.hero_mo_data, true)
end

function CharacterTalentChessView:onDestroyView()
	if self.parallel_sequence then
		self.parallel_sequence:destroy()
	end

	if self._update_attr_tips_ani then
		self._update_attr_tips_ani:destroy()
	end

	if self._put_ani_flow then
		self._put_ani_flow:unregisterDoneListener(self.onPutAniDone, self)
		self._put_ani_flow:destroy()
	end

	TaskDispatcher.cancelTask(self._playScrollTween, self)
	TaskDispatcher.cancelTask(self._hideStyleUpdateAnim, self)

	local transform = self._goContent.transform
	local child_count = transform.childCount

	for i = 0, child_count - 1 do
		local obj = transform:GetChild(i):Find("item/slot").gameObject
		local dragListener = SLFramework.UGUI.UIDragListener.Get(obj)

		dragListener:RemoveDragBeginListener()
		dragListener:RemoveDragListener()
		dragListener:RemoveDragEndListener()
		SLFramework.UGUI.UIClickListener.Get(obj):RemoveClickDownListener()
	end

	if self.drag_container then
		self._dragContainerDragCom:RemoveDragBeginListener()
		self._dragContainerDragCom:RemoveDragListener()
		self._dragContainerDragCom:RemoveDragEndListener()
		SLFramework.UGUI.UIClickListener.Get(self.drag_container):RemoveClickListener()
	end

	if self.drag_image then
		for i, v in ipairs(self.drag_image) do
			local dragListener = SLFramework.UGUI.UIDragListener.Get(v)

			dragListener:RemoveDragBeginListener()
			dragListener:RemoveDragListener()
			dragListener:RemoveDragEndListener()
			SLFramework.UGUI.UIClickListener.Get(v):RemoveClickListener()
		end
	end

	self:_releaseCellList()

	if self._dragEffectLoader then
		self._dragEffectLoader:dispose()

		self._dragEffectLoader = nil
	end

	if self._quickLayoutItems then
		for _, item in ipairs(self._quickLayoutItems) do
			item.toggle:RemoveOnValueChanged()
		end
	end
end

return CharacterTalentChessView
