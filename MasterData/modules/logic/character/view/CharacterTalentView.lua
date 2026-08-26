-- chunkname: @modules/logic/character/view/CharacterTalentView.lua

module("modules.logic.character.view.CharacterTalentView", package.seeall)

local CharacterTalentView = class("CharacterTalentView", BaseView)

function CharacterTalentView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "commen/#simage_bg")
	self._simagelefticon = gohelper.findChildSingleImage(self.viewGO, "commen/#simage_lefticon")
	self._simagerighticon = gohelper.findChildSingleImage(self.viewGO, "commen/#simage_righticon")
	self._simagerighticon2 = gohelper.findChildSingleImage(self.viewGO, "commen/#simage_righticon2")
	self._simagemask = gohelper.findChildSingleImage(self.viewGO, "commen/#simage_mask")
	self._simageglowleftdown = gohelper.findChildSingleImage(self.viewGO, "commen/rentouxiang/ani/glow_leftdown")
	self._simageglowrighttop = gohelper.findChildSingleImage(self.viewGO, "commen/rentouxiang/ani/glow_righttop")
	self._simagegglowrighdown = gohelper.findChildSingleImage(self.viewGO, "commen/rentouxiang/ani/glow_righdown")
	self._simageglowmiddle = gohelper.findChildSingleImage(self.viewGO, "commen/rentouxiang/ani/glow_middle")
	self._simageglow = gohelper.findChildSingleImage(self.viewGO, "commen/rentouxiang/ani/bg_04/glow")
	self._simageglow2 = gohelper.findChildSingleImage(self.viewGO, "commen/rentouxiang/ani/icon04/glow")
	self._simagecurve1 = gohelper.findChildSingleImage(self.viewGO, "commen/rentouxiang/ani/bg_04/bg04/curve01")
	self._simagecurve2 = gohelper.findChildSingleImage(self.viewGO, "commen/rentouxiang/ani/bg_04/bg04/curve02")
	self._simagecurve3 = gohelper.findChildSingleImage(self.viewGO, "commen/rentouxiang/ani/bg_04/bg04/curve03")
	self._simagequxian3 = gohelper.findChildSingleImage(self.viewGO, "commen/rentouxiang/ani/bg_04/quxian/quxian3")
	self._simagebg2 = gohelper.findChildSingleImage(self.viewGO, "commen/rentouxiang/ani/bg_02/image")
	self._golinemax = gohelper.findChild(self.viewGO, "commen/rentouxiang/ani/bg_02/#linemax")
	self._simageline = gohelper.findChildSingleImage(self.viewGO, "commen/rentouxiang/ani/bg01/simage_line")
	self._simagezhigantu = gohelper.findChildSingleImage(self.viewGO, "commen/rentouxiang/ani/zhigantu")
	self._gotouPos = gohelper.findChild(self.viewGO, "commen/rentouxiang/ani/tou")
	self._gobtns = gohelper.findChild(self.viewGO, "#go_btns")
	self._btnchessboard = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_chessboard")
	self._gomeshContainer = gohelper.findChild(self.viewGO, "#btn_chessboard/#go_meshContainer")
	self._gomeshItem = gohelper.findChild(self.viewGO, "#btn_chessboard/#go_meshContainer/#go_meshItem")
	self._gochessContainer = gohelper.findChild(self.viewGO, "#btn_chessboard/#go_chessContainer")
	self._gochessitem = gohelper.findChild(self.viewGO, "#btn_chessboard/#go_chessContainer/#go_chessitem")
	self._goattrContent = gohelper.findChild(self.viewGO, "attribute/#go_attrContent")
	self._goattrEmpty = gohelper.findChild(self.viewGO, "attribute/#go_attrEmpty")
	self._goattrItem = gohelper.findChild(self.viewGO, "attribute/#go_attrContent/#go_attrItem")
	self._btninsight = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_insight")
	self._txttalentcn = gohelper.findChildText(self.viewGO, "#btn_insight/txt")
	self._txtinsightLv = gohelper.findChildText(self.viewGO, "#btn_insight/#txt_insightLv")
	self._gotalentreddot = gohelper.findChild(self.viewGO, "#btn_insight/#go_talentreddot")
	self._goEsonan = gohelper.findChild(self.viewGO, "commen/rentouxiang/ani/icon02/esonan")
	self._goEsoning = gohelper.findChild(self.viewGO, "commen/rentouxiang/ani/icon02/easoning")
	self._btnstyle = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_style")
	self._gostylechange = gohelper.findChild(self.viewGO, "#btn_chessboard/#go_stylechange")
	self._txtstyle = gohelper.findChildText(self.viewGO, "#btn_chessboard/#go_stylechange/#txt_label")
	self._styleslot = gohelper.findChildImage(self.viewGO, "#btn_chessboard/#go_stylechange/slot")
	self._styleicon = gohelper.findChildImage(self.viewGO, "#btn_chessboard/#go_stylechange/slot/icon")
	self._styleglow = gohelper.findChildImage(self.viewGO, "#btn_chessboard/#go_stylechange/slot/glow")
	self._styleupdate = gohelper.findChild(self.viewGO, "#btn_chessboard/#go_stylechange/update")
	self._dropresonategroup = gohelper.findChildDropdown(self.viewGO, "#btn_chessboard/#drop_resonategroup")
	self._txtgroupname = gohelper.findChildText(self.viewGO, "#btn_chessboard/#drop_resonategroup/txt_groupname")
	self._btnchangetemplatename = gohelper.findChildClickWithAudio(self.viewGO, "#btn_chessboard/#drop_resonategroup/#btn_changetemplatename")
	self._dropClick = gohelper.getClick(self._dropresonategroup.gameObject)
	self._goStyleRed = gohelper.findChild(self.viewGO, "#btn_style/#go_talentreddot")
	self._txtTitleStyle = gohelper.findChildText(self.viewGO, "#btn_style/txt_style")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterTalentView:addEvents()
	self._btnchessboard:AddClickListener(self._btnchessboardOnClick, self)
	self._btninsight:AddClickListener(self._btninsightOnClick, self)
	self._btnstyle:AddClickListener(self._btnstyleOnClick, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.RefreshCubeList, self._refreshUI, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.successHeroTalentUp, self._refreshUI, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.playTalentViewBackAni, self._onplayBackAni, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.onUseTalentStyleReply, self._onUseTalentStyleReply, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.RenameTalentTemplateReply, self._onRenameTalentTemplateReply, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.UseTalentTemplateReply, self._onUseTalentTemplateReply, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.onTalentStyleRead, self._refreshTalentStyleRed, self)
	self.addEventCb(self, HeroResonanceController.instance, HeroResonanceEvent.UseShareCode, self._onUseShareCode, self)
	self._dropresonategroup:AddOnValueChanged(self._opDropdownChange, self)
	self._btnchangetemplatename:AddClickListener(self._onBtnChangeTemplateName, self)
end

function CharacterTalentView:removeEvents()
	self._btnchessboard:RemoveClickListener()
	self._btninsight:RemoveClickListener()
	self._btnstyle:RemoveClickListener()
	self._dropresonategroup:RemoveOnValueChanged()
	self._btnchangetemplatename:RemoveClickListener()
end

function CharacterTalentView:_btnchessboardOnClick()
	if self.rentou_ani then
		self.rentou_ani.enabled = true

		gohelper.setActive(self.rentou_ani.gameObject, true)
		self.rentou_ani:Play("1_3", 0, 0)
	end

	self._rentou_in_ani.enabled = false

	gohelper.setActive(self._rentou_in_ani.gameObject, false)
	self:_hideTalentStyle()
	self.view_ani:Play("charactertalentup_out")
	self.bg_ani:Play("ani_1_3")
	self.chess_ani:Play("chessboard_click")
	CharacterController.instance:openCharacterTalentChessView(self.hero_id)
end

function CharacterTalentView:_btninsightOnClick()
	if self.rentou_ani then
		self.rentou_ani.enabled = true

		gohelper.setActive(self.rentou_ani.gameObject, true)
		self.rentou_ani:Play("1_2", 0, 0)
	end

	self._rentou_in_ani.enabled = false

	gohelper.setActive(self._rentou_in_ani.gameObject, false)
	self:_hideTalentStyle()
	self.view_ani:Play("charactertalentup_out")
	self.bg_ani:Play("ani_1_2")
	self.chess_ani:Play("chessboard_out")

	if not ViewMgr.instance:isOpen(ViewName.CharacterTalentLevelUpView) or not self.viewParam.isBack then
		self.hero_id = self.hero_id or self.viewParam.heroid
		self.hero_mo_data = self.hero_mo_data or HeroModel.instance:getByHeroId(self.hero_id)

		CharacterController.instance:openCharacterTalentLevelUpView({
			self.hero_id
		})
	end
end

function CharacterTalentView:_openCharacterTalentLevelUpView()
	TaskDispatcher.cancelTask(self._openCharacterTalentLevelUpView, self)
	CharacterController.instance:openCharacterTalentLevelUpView({
		self.hero_id
	})
end

function CharacterTalentView:_btnstyleOnClick()
	CharacterController.instance:openCharacterTalentStyleView({
		hero_id = self.hero_id
	})
end

function CharacterTalentView:_onUseTalentStyleReply()
	self:_refreshUI()
	self:_initTemplateList()
	self:_refreshStyleTag()
	self:_refreshMainStyleCubeItem()
	TaskDispatcher.cancelTask(self._hideStyleUpdateAnim, self)
	gohelper.setActive(self._styleupdate, true)
	TaskDispatcher.runDelay(self._hideStyleUpdateAnim, self, 0.6)
end

function CharacterTalentView:_hideStyleUpdateAnim()
	gohelper.setActive(self._styleupdate, false)
end

function CharacterTalentView:_onplayBackAni(name, not_play_in, bg_ani_name, isReturnView)
	if not not_play_in then
		self.view_ani:Play("charactertalentup_in")
		self.chess_ani:Play("chessboard_in")
	end

	if bg_ani_name then
		self.bg_ani:Play(bg_ani_name)
	end

	if bg_ani_name == "ani_3_1" then
		self.chess_ani:Play("chessboard_back")
	end

	self._rentou_in_ani.enabled = false

	if self.rentou_ani then
		self.rentou_ani.enabled = true

		gohelper.setActive(self.rentou_ani.gameObject, true)
		self.rentou_ani:Play(name, 0, 0)
	end

	gohelper.setActive(self._rentou_in_ani.gameObject, false)

	if not not_play_in then
		self:_showTalentStyle()
	end

	CharacterController.instance:dispatchEvent(CharacterEvent.CharacterTalentViewAnimFinished)

	if isReturnView then
		CharacterController.instance:dispatchEvent(CharacterEvent.onReturnTalentView, self.hero_id)
	end
end

function CharacterTalentView:_editableInitView()
	self._simagebg:LoadImage(ResUrl.getCommonIcon("full/bg_fmand2"))
	self._simagelefticon:LoadImage(ResUrl.getCommonIcon("bg_leftdown"))
	self._simagerighticon:LoadImage(ResUrl.getCommonIcon("bg_rightdown"))
	self._simagerighticon2:LoadImage(ResUrl.getCommonIcon("bg_rightup"))
	self._simagemask:LoadImage(ResUrl.getCommonIcon("full/bg_noise2"))
	self._simageglowleftdown:LoadImage(ResUrl.getCharacterTalentUpTexture("glow_left"))
	self._simageglowrighttop:LoadImage(ResUrl.getCharacterTalentUpTexture("glow_righttop"))
	self._simagegglowrighdown:LoadImage(ResUrl.getCharacterTalentUpTexture("glow_rightdown"))
	self._simageglowmiddle:LoadImage(ResUrl.getCharacterTalentUpTexture("glow_middle"))
	self._simageglow:LoadImage(ResUrl.getCharacterTalentUpTexture("shinne"))
	self._simageglow2:LoadImage(ResUrl.getCharacterTalentUpTexture("shinne"))
	self._simagecurve1:LoadImage(ResUrl.getCharacterTalentUpTexture("curve02"))
	self._simagecurve2:LoadImage(ResUrl.getCharacterTalentUpTexture("curve03"))
	self._simagecurve3:LoadImage(ResUrl.getCharacterTalentUpTexture("curve04"))
	self._simagequxian3:LoadImage(ResUrl.getCharacterTalentUpTexture("quxian3"))
	self._simagebg2:LoadImage(ResUrl.getCharacterTalentUpTexture("glow_top"))
	self._simageline:LoadImage(ResUrl.getCharacterTalentUpIcon("line001"))
	self._simagezhigantu:LoadImage(ResUrl.getCharacterTalentUpTexture("zhigan"))

	self.view_ani = gohelper.findChildComponent(self.viewGO, "", typeof(UnityEngine.Animator))
	self.bg_ani = gohelper.findChildComponent(self.viewGO, "commen/rentouxiang/ani", typeof(UnityEngine.Animator))
	self.chess_ani = gohelper.findChildComponent(self.viewGO, "#btn_chessboard", typeof(UnityEngine.Animator))
	self._rentou_in_ani = gohelper.findChildComponent(self.viewGO, "commen/rentouxiang/ani/tou/tou_in", typeof(UnityEngine.Animator))

	AudioMgr.instance:trigger(AudioEnum.Talent.play_ui_resonate_open)
	gohelper.addUIClickAudio(self._btnchessboard.gameObject, AudioEnum.Talent.play_ui_resonate_property_open)
	gohelper.addUIClickAudio(self._btninsight.gameObject, AudioEnum.UI.play_ui_admission_open)

	self._animStylebtn = self._btnstyle.gameObject:GetComponent(typeof(UnityEngine.Animator))
end

function CharacterTalentView:onUpdateParam()
	return
end

function CharacterTalentView:_playAni(name, forward)
	self._ani:StartPlayback()

	self._ani.speed = forward and 1 or -1

	self._ani:Play(name)
end

function CharacterTalentView:onOpen()
	self._tou_url = "ui/viewres/character/charactertalentup/tou.prefab"
	self._tou_loader = MultiAbLoader.New()

	self._tou_loader:addPath(self._tou_url)
	self._tou_loader:startLoad(self._addTouPrefab, self)
	self:_refreshUI()
	CharacterController.instance:statTalentStart(self.hero_id)
	CharacterController.instance:dispatchEvent(CharacterEvent.CharacterTalentViewAnimFinished)
	self:_hideStyleUpdateAnim()
	self:_showTalentStyle()
end

function CharacterTalentView:_refreshUI()
	self.cell_length = 56.2
	self.hero_id = self.viewParam.heroid
	self.hero_mo_data = HeroModel.instance:getByHeroId(self.hero_id)
	self._mainCubeId = self.hero_mo_data.talentCubeInfos.own_main_cube_id

	gohelper.setActive(self._gotalentreddot, CharacterModel.instance:heroTalentRedPoint(self.hero_id))

	local gain_tab = self.hero_mo_data:getTalentGain()
	local gain_list = {}

	for k, v in pairs(gain_tab) do
		table.insert(gain_list, v)
	end

	table.sort(gain_list, function(item1, item2)
		return HeroConfig.instance:getIDByAttrType(item1.key) < HeroConfig.instance:getIDByAttrType(item2.key)
	end)
	gohelper.setActive(self._goattrEmpty, not (GameUtil.getTabLen(gain_list) > 0))
	gohelper.setActive(self._goattrContent, GameUtil.getTabLen(gain_list) > 0)
	gohelper.CreateObjList(self, self._onItemShow, gain_list, self._goattrContent, self._goattrItem)
	self:_setChessboardData()

	local isMAXLv = HeroResonanceConfig.instance:getTalentConfig(self.hero_id, self.hero_mo_data.talent + 1) == nil

	if not isMAXLv then
		self._txtinsightLv.text = self.hero_mo_data.talent or "max"
	end

	self._txttalentcn.text = luaLang("talent_charactertalent_txt" .. self.hero_mo_data:getTalentTxtByHeroType())

	gohelper.setActive(self._goEsonan, self.hero_mo_data.config.heroType ~= CharacterEnum.HumanHeroType)
	gohelper.setActive(self._goEsoning, self.hero_mo_data.config.heroType == CharacterEnum.HumanHeroType)
	gohelper.setActive(self._golinemax, isMAXLv)

	self._txtTitleStyle.text = luaLang("talent_style_title_cn_" .. self.hero_mo_data:getTalentTxtByHeroType())

	self:_initTemplateList()
	self:_refreshTalentStyleRed()
end

function CharacterTalentView:_addTouPrefab(prefabLoader)
	local assetItem = prefabLoader:getAssetItem(self._tou_url)

	if assetItem then
		local obj = assetItem:GetResource(self._tou_url)
		local preb = gohelper.clone(obj, self._gotouPos, "tou")

		if preb then
			gohelper.setActive(preb, false)

			self.rentou_ani = preb:GetComponent(typeof(UnityEngine.Animator))
		end

		if self.viewParam.isBack and not ViewMgr.instance:isOpen(ViewName.CharacterTalentStyleView) then
			self:_btninsightOnClick()
		end
	end
end

function CharacterTalentView:_onItemShow(obj, data, index)
	local transform = obj.transform
	local image = transform:Find("icon"):GetComponent(gohelper.Type_Image)
	local label = transform:Find("name"):GetComponent(gohelper.Type_TextMesh)
	local value = transform:Find("value"):GetComponent(gohelper.Type_TextMesh)
	local config = HeroConfig.instance:getHeroAttributeCO(HeroConfig.instance:getIDByAttrType(data.key))

	data.value = config.type ~= 1 and tonumber(string.format("%.3f", data.value / 10)) .. "%" or math.floor(data.value)
	value.text = data.value
	label.text = config.name

	UISpriteSetMgr.instance:setCommonSprite(image, "icon_att_" .. config.id, true)
end

function CharacterTalentView:getRabbetCell()
	return self._rabbet_cell
end

function CharacterTalentView:_setChessboardData()
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
	self.cube_data = self.hero_mo_data.talentCubeInfos.data_list

	for i, v in ipairs(self._rabbet_cell_list) do
		v.is_filled = false
	end

	gohelper.CreateObjList(self, self._onCubeItemShow, self.cube_data, self._gochessContainer, self._gochessitem)

	for i, v in ipairs(self._rabbet_cell_list) do
		v:SetNormal()
	end
end

function CharacterTalentView:_onCubeItemShow(obj, data, index)
	local transform = obj.transform
	local image = transform:GetComponent(gohelper.Type_Image)
	local icon = gohelper.findChildImage(obj, "icon")
	local glow_icon = gohelper.findChildImage(obj, "glow")
	local cell_icon = gohelper.findChildImage(obj, "cell")
	local origin_mat = HeroResonanceConfig.instance:getCubeMatrix(data.cubeId)
	local mat = self:_rotationMatrix(origin_mat, data.direction)

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
	pos_x = pos_x - self.cell_length / 2
	pos_y = pos_y + self.cell_length / 2

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

	if self._mainCubeId == data.cubeId then
		self._mainCubeItem = {
			bg = image,
			icon = icon,
			glow_icon = glow_icon,
			cell_icon = cell_icon,
			anim = cell_icon
		}

		self:_refreshMainStyleCubeItem()
	else
		gohelper.setActive(cell_icon.gameObject, false)
	end
end

function CharacterTalentView:_refreshMainStyleCubeItem()
	local mainIcon = HeroResonanceConfig.instance:getCubeConfig(self._mainCubeId).icon
	local iconbg = "ky_" .. mainIcon
	local iconmk = mainIcon
	local glowIcon = "glow_" .. mainIcon
	local temp_attr = string.split(mainIcon, "_")
	local cell_bg = "gz_" .. temp_attr[#temp_attr]
	local cubeId = self.hero_mo_data:getHeroUseStyleCubeId()
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

	if self._mainCubeItem then
		UISpriteSetMgr.instance:setCharacterTalentSprite(self._mainCubeItem.bg, iconbg, true)
		UISpriteSetMgr.instance:setCharacterTalentSprite(self._mainCubeItem.icon, iconmk, true)
		UISpriteSetMgr.instance:setCharacterTalentSprite(self._mainCubeItem.glow_icon, glowIcon, true)
		UISpriteSetMgr.instance:setCharacterTalentSprite(self._mainCubeItem.cell_icon, cell_bg, true)
		gohelper.setActive(self._mainCubeItem.cell_icon.gameObject, not isOrignStyle)
	end
end

function CharacterTalentView:playChessIconOutAni()
	if self.cube_data then
		for i, v in ipairs(self.cube_data) do
			local ani = self._gochessContainer.transform:GetChild(i - 1):GetComponent(typeof(UnityEngine.Animator))

			ani:Play("chessitem_out")
		end
	end
end

function CharacterTalentView:_rotationMatrix(mat, rotation_count)
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

function CharacterTalentView:_releaseCellList()
	if self._rabbet_cell_list then
		for i, v in ipairs(self._rabbet_cell_list) do
			v:releaseSelf()
		end

		self._rabbet_cell_list = nil
	end
end

function CharacterTalentView:_showTalentStyle()
	local _isUnlockStyle = TalentStyleModel.instance:isUnlockStyleSystem(self.hero_mo_data.talent)

	TalentStyleModel.instance:refreshUnlockInfo(self.hero_id)

	if _isUnlockStyle then
		self:_refreshStyleTag()
	end

	gohelper.setActive(self._gostylechange.gameObject, _isUnlockStyle)
	gohelper.setActive(self._btnstyle.gameObject, _isUnlockStyle)

	if _isUnlockStyle then
		if self.hero_mo_data.isShowTalentStyleRed and TalentStyleModel.instance:isPlayStyleEnterBtnAnim(self.hero_id) then
			self._animStylebtn:Play("unlock", 0, 0)
			TalentStyleModel.instance:setPlayStyleEnterBtnAnim(self.hero_id)
		else
			self._animStylebtn:Play("open", 0, 0)
		end
	end
end

function CharacterTalentView:_hideTalentStyle()
	return
end

function CharacterTalentView:_refreshStyleTag()
	local style = self.hero_mo_data:getHeroUseCubeStyleId(self.hero_id)
	local mo = TalentStyleModel.instance:getTalentStyle(self._mainCubeId, style)
	local name, tag = mo:getStyleTag()
	local growTagIcon, nomalTagIcon = mo:getStyleTagIcon()

	self._txtstyle.text = name

	UISpriteSetMgr.instance:setCharacterTalentSprite(self._styleslot, nomalTagIcon, true)
	UISpriteSetMgr.instance:setCharacterTalentSprite(self._styleicon, growTagIcon, true)
	UISpriteSetMgr.instance:setCharacterTalentSprite(self._styleglow, growTagIcon, true)
end

function CharacterTalentView:_initTemplateList()
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
						::label_29_0::

						local var_29_1 = mo._styleCo

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

function CharacterTalentView:_onBtnChangeTemplateName()
	ViewMgr.instance:openView(ViewName.CharacterTalentModifyNameView, {
		self.hero_mo_data.heroId,
		self.hero_mo_data.talentTemplates[self._curSelectTemplateIndex].id
	})
end

function CharacterTalentView.sortTemplate(item1, item2)
	return item1.id < item2.id
end

function CharacterTalentView:_opDropdownChange(idx)
	idx = idx or 0

	local index = idx + 1

	if self._curSelectTemplateIndex ~= index then
		self._curSelectTemplateIndex = index

		HeroRpc.instance:UseTalentTemplateRequest(self.hero_mo_data.heroId, self.hero_mo_data.talentTemplates[index].id)
	end
end

function CharacterTalentView:_onDropClick()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
end

function CharacterTalentView:_onRenameTalentTemplateReply()
	self:_initTemplateList()
end

function CharacterTalentView:_onUseTalentTemplateReply()
	self:_showTemplateName()
	self:_refreshStyleTag()
	self:_refreshMainStyleCubeItem()
	TaskDispatcher.cancelTask(self._hideStyleUpdateAnim, self)
	gohelper.setActive(self._styleupdate, true)
	TaskDispatcher.runDelay(self._hideStyleUpdateAnim, self, 0.6)
	GameFacade.showToast(ToastEnum.ChangeTalentTemplate)
end

function CharacterTalentView:_showTemplateName()
	for i, v in ipairs(self.hero_mo_data.talentTemplates) do
		if v.id == self.hero_mo_data.useTalentTemplateId then
			local tempateStr = luaLang("talent_charactertalentchess_template" .. self.hero_mo_data:getTalentTxtByHeroType())

			if string.nilorempty(v.name) then
				if not (tempateStr .. self._curSelectTemplateIndex) then
					local name = v.name
					local mo = TalentStyleModel.instance:getTalentStyle(self._mainCubeId, v.style)

					if mo then
						::label_36_0::

						local var_36_1 = mo._styleCo

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

function CharacterTalentView:_refreshTalentStyleRed()
	local isTalentStyleNew = self.hero_mo_data.isShowTalentStyleRed

	gohelper.setActive(self._goStyleRed, isTalentStyleNew)
end

function CharacterTalentView:_onUseShareCode(msg)
	self:_refreshUI()
end

function CharacterTalentView:onClose()
	if self._tou_loader then
		self._tou_loader:dispose()
	end

	self:_releaseCellList()
	TaskDispatcher.cancelTask(self._openCharacterTalentLevelUpView, self)
	CharacterController.instance:statTalentEnd(self.hero_id)
	TaskDispatcher.cancelTask(self._hideStyleUpdateAnim, self)
end

function CharacterTalentView:onDestroyView()
	self._simagebg:UnLoadImage()
	self._simagelefticon:UnLoadImage()
	self._simagerighticon:UnLoadImage()
	self._simagerighticon2:UnLoadImage()
	self._simagemask:UnLoadImage()
	self._simageglowleftdown:UnLoadImage()
	self._simageglowrighttop:UnLoadImage()
	self._simagegglowrighdown:UnLoadImage()
	self._simageglowmiddle:UnLoadImage()
	self._simageglow:UnLoadImage()
	self._simageglow2:UnLoadImage()
	self._simagecurve1:UnLoadImage()
	self._simagecurve2:UnLoadImage()
	self._simagecurve3:UnLoadImage()
	self._simagequxian3:UnLoadImage()
	self._simagebg2:UnLoadImage()
	self._simageline:UnLoadImage()
	self._simagezhigantu:UnLoadImage()
end

return CharacterTalentView
