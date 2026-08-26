-- chunkname: @modules/logic/playercard/view/NewPlayerCardView.lua

module("modules.logic.playercard.view.NewPlayerCardView", package.seeall)

local NewPlayerCardView = class("NewPlayerCardView", BaseView)

function NewPlayerCardView:init(go)
	self.viewGO = go

	self:onInitView()
end

function NewPlayerCardView:canOpen(tempSkinId)
	self:onOpen(tempSkinId)
	self:addEvents()
end

function NewPlayerCardView:onInitView()
	self._root = gohelper.findChild(self.viewGO, "root")
	self._simagerole = gohelper.findChildSingleImage(self.viewGO, "root/main/top/role/skinnode/#simage_role")
	self._imageIcon = gohelper.findChildImage(self.viewGO, "root/main/top/role/skinnode/#simage_role")
	self._btnrole = gohelper.findChildButtonWithAudio(self.viewGO, "root/main/top/role/skinnode/#simage_role/#btn_role")
	self._btnleftcontent = gohelper.findChildButtonWithAudio(self.viewGO, "root/main/top/leftcontent/#btn_leftcontent")
	self._btnrightcontent = gohelper.findChildButtonWithAudio(self.viewGO, "root/main/top/rightcontent/#btn_rightcontent")
	self._txtdungeon = gohelper.findChildText(self.viewGO, "root/main/top/rightcontent/#txt_dungeon")
	self._gocritter = gohelper.findChild(self.viewGO, "root/main/critter/go_critter")
	self._gocritterlight = gohelper.findChild(self.viewGO, "root/main/critter/light")
	self._btncritter = gohelper.findChildButton(self.viewGO, "root/main/critter/#btn_critter")
	self._goBgEffect = gohelper.findChild(self.viewGO, "#bg_effect")
	self._goTopEffect = gohelper.findChild(self.viewGO, "#top_effect")
	self._gocritterroot = gohelper.findChild(self.viewGO, "root/main/critter")
	self._gobadgeroot = gohelper.findChild(self.viewGO, "root/main/badge")
	self._openswitchskin = false
	self._progressItemList = {}
	self._baseInfoItemList = {}
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._has_onInitView = true

	if self._editableInitView then
		self:_editableInitView()
	end
end

function NewPlayerCardView:addEvents()
	self._btnrole:AddClickListener(self._btnroleOnClick, self)
	self._btnleftcontent:AddClickListener(self._btnleftcontentOnClick, self)
	self._btnrightcontent:AddClickListener(self._btnrightcontentOnClick, self)
	self._btncritter:AddClickListener(self._btncritterOnClick, self)
	self.addEventCb(self, PlayerCardController.instance, PlayerCardEvent.RefreshSwitchView, self._onRefreshSwitchView, self)
	self.addEventCb(self, PlayerCardController.instance, PlayerCardEvent.RefreshProgressView, self._refreshProgress, self)
	self.addEventCb(self, PlayerCardController.instance, PlayerCardEvent.RefreshBaseInfoView, self._refreshBaseInfo, self)
	self.addEventCb(self, PlayerCardController.instance, PlayerCardEvent.SelectCritter, self._onRefreshCritter, self)
	self.addEventCb(self, PlayerCardController.instance, PlayerCardEvent.OnCloseHeroView, self._onCloseHeroView, self)
	self.addEventCb(self, PlayerCardController.instance, PlayerCardEvent.OnCloseProgressView, self._onCloseProgressView, self)
	self.addEventCb(self, PlayerCardController.instance, PlayerCardEvent.OnCloseBaseInfoView, self._onCloseBaseInfoView, self)
	self.addEventCb(self, PlayerCardController.instance, PlayerCardEvent.OnCloseCritterView, self._onCloseCritterView, self)
	self.addEventCb(self, PlayerCardController.instance, PlayerCardEvent.CutEquipType, self._onCutEquipType, self)
end

function NewPlayerCardView:removeEvents()
	self._btnrole:RemoveClickListener()
	self._btnleftcontent:RemoveClickListener()
	self._btnrightcontent:RemoveClickListener()
	self._btncritter:RemoveClickListener()

	if self._btnSwtichBadge then
		self._btnSwtichBadge:RemoveClickListener()
	end
end

function NewPlayerCardView:_editableInitView()
	self:_initProgress()
	self:_initBaseInfo()
end

function NewPlayerCardView:_creatBgEffect()
	local bgPath = PlayerCardConfig.instance:getBgPath(self.themeId)
	local effectPath = PlayerCardConfig.instance:getTopEffectPath()

	if bgPath or effectPath then
		self._bgLoder = MultiAbLoader.New()

		if bgPath then
			self._bgLoder:addPath(bgPath)
		end

		if effectPath then
			self._bgLoder:addPath(effectPath)
		end

		self._bgLoder:startLoad(self._loadBgDone, self)
	end
end

function NewPlayerCardView:_loadBgDone()
	local bgAssetItem = self._bgLoder:getAssetItem(PlayerCardConfig.instance:getBgPath(self.themeId))

	if bgAssetItem and self._goBgEffect then
		self._bgGo = gohelper.clone(bgAssetItem:GetResource(), self._goBgEffect, "bg")
	end
end

function NewPlayerCardView:_initProgress()
	for i = 1, 5 do
		local progressnode = self:getUserDataTb_()

		progressnode.pos = i
		progressnode.go = gohelper.findChild(self.viewGO, "root/main/top/leftcontent/node" .. i)
		progressnode.gofull = gohelper.findChild(progressnode.go, "fill")
		progressnode.goempty = gohelper.findChild(progressnode.go, "empty")
		progressnode.imgpic = gohelper.findChildImage(progressnode.gofull, "#image_pic")
		progressnode.imgicon = gohelper.findChildImage(progressnode.gofull, "#image_icon")
		progressnode.txtname = gohelper.findChildText(progressnode.gofull, "#txt_name")
		progressnode.anim = progressnode.gofull:GetComponent(typeof(UnityEngine.Animator))

		gohelper.setActive(progressnode.gofull, false)
		gohelper.setActive(progressnode.goempty, true)
		table.insert(self._progressItemList, progressnode)
	end
end

function NewPlayerCardView:_initBaseInfo()
	for i = 1, 4 do
		local baseInfoNode = self:getUserDataTb_()

		baseInfoNode.pos = i
		baseInfoNode.go = gohelper.findChild(self.viewGO, "root/main/top/rightcontent/node" .. i)
		baseInfoNode.imgBg = gohelper.findChildImage(baseInfoNode.go, "#image_bg")
		baseInfoNode.gofull = gohelper.findChild(baseInfoNode.go, "fill")
		baseInfoNode.goempty = gohelper.findChild(baseInfoNode.go, "empty")
		baseInfoNode.anim = baseInfoNode.gofull:GetComponent(typeof(UnityEngine.Animator))

		table.insert(self._baseInfoItemList, baseInfoNode)
	end
end

function NewPlayerCardView:onOpen(tempSkinId)
	self._animator.enabled = true

	if self.viewParam and self.viewParam.userId then
		self.userId = self.viewParam.userId
	end

	self.playercardinfo = PlayerCardModel.instance:getCardInfo(self.userId)

	if self.playercardinfo:isSelf() then
		PlayerCardController.instance:statStart()
	end

	if not tempSkinId then
		::label_11_0::

		local themeId = self.playercardinfo:getThemeId()

		if themeId == 0 or string.nilorempty(themeId) then
			themeId = nil
		end

		self.themeId = themeId

		self:_creatBgEffect()

		local heroId, skinId, _, isL2d = self.playercardinfo:getMainHero()

		self:_updateHero(heroId, skinId)
		self:_refreshProgress()
		self:_refreshBaseInfo()
		self:_initCritter()

		if self._playingAudioId then
			AudioMgr.instance:stopPlayingID(self._playingAudioId)
		end

		local themeInfo = PlayerCardEnum.Theme[themeId]

		if themeInfo then
			if not themeInfo.OpenAudioId then
				local audioId = AudioEnum.PlayerCard.play_ui_diqiu_card_open_1

				self._playingAudioId = AudioMgr.instance:trigger(audioId)
				self.progressopen = false
				self.baseinfoopen = false

				self:_initBadge()
				self:_onCutEquipType()

				if themeInfo and themeInfo.EnterAnim then
					local type = self.playercardinfo:getShowEnterAnimType(themeId)
					local enterAnim = themeInfo.EnterAnim[type]

					if enterAnim and not string.nilorempty(enterAnim.aniName) then
						self._animator:Play(enterAnim.aniName)
					end
				end

				if self.viewParam and self.viewParam.justOpenBadgeView then
					self:_btncritterOnClick()

					self.viewParam.justOpenBadgeView = nil
				end
			end
		end
	end
end

function NewPlayerCardView:onClose()
	self:resetSpine()

	if self.playercardinfo and self.playercardinfo:isSelf() then
		PlayerCardController.instance:statEnd()
	end

	self:removeEvents()

	self._has_onInitView = false

	if self._scrollView then
		self._scrollView:onDestroyViewInternal()
		self._scrollView:__onDispose()
	end

	gohelper.destroy(self.goskinpreview)

	self._scrollView = nil

	if self._playingAudioId then
		AudioMgr.instance:stopPlayingID(self._playingAudioId)
	end

	self._playingAudioId = nil
end

function NewPlayerCardView:_btnroleOnClick()
	if self.playercardinfo:isSelf() then
		ViewMgr.instance:openView(ViewName.PlayerCardCharacterSwitchView)
		self._animator:Update(0)
		self._animator:Play("to_role")
	end
end

function NewPlayerCardView:_btnleftcontentOnClick()
	if self.playercardinfo:isSelf() then
		ViewMgr.instance:openView(ViewName.PlayerCardProgressView, self.playercardinfo)

		self.progressopen = true

		self._animator:Update(0)
		self._animator:Play("to_left")
	end
end

function NewPlayerCardView:_btnrightcontentOnClick()
	if self.playercardinfo:isSelf() then
		ViewMgr.instance:openView(ViewName.PlayerCardBaseInfoView, self.playercardinfo)

		self.baseinfoopen = true

		self._animator:Update(0)
		self._animator:Play("to_right")
	end
end

function NewPlayerCardView:_btncritterOnClick()
	if self.playercardinfo:isSelf() then
		self._animator:Update(0)
		self._animator:Play("to_critter")
		ViewMgr.instance:openView(ViewName.PlayerCardCritterPlaceView)
	end
end

function NewPlayerCardView:_onCloseHeroView()
	self._animator:Update(0)
	self._animator:Play("back_role")
	AudioMgr.instance:trigger(AudioEnum.PlayerCard.play_ui_diqiu_card_open_2)
end

function NewPlayerCardView:_onCloseProgressView()
	self._animator:Update(0)
	self._animator:Play("back_left")
	AudioMgr.instance:trigger(AudioEnum.PlayerCard.play_ui_diqiu_card_open_2)
end

function NewPlayerCardView:_onCloseBaseInfoView()
	self._animator:Update(0)
	self._animator:Play("back_right")
	AudioMgr.instance:trigger(AudioEnum.PlayerCard.play_ui_diqiu_card_open_2)
end

function NewPlayerCardView:_onCloseCritterView()
	self._animator:Update(0)
	self._animator:Play("back_critter")
	AudioMgr.instance:trigger(AudioEnum.PlayerCard.play_ui_diqiu_card_open_2)
end

function NewPlayerCardView:_onCutEquipType()
	if not self.playercardinfo then
		return
	end

	local equipType = self.playercardinfo:getShowSettingByType(PlayerCardEnum.ShowSettingsType.ShowEquipType)

	gohelper.setActive(self._gocritter, equipType == PlayerCardEnum.EquipType.Critter)
	gohelper.setActive(self._gobadgeroot, equipType == PlayerCardEnum.EquipType.Badge)
end

function NewPlayerCardView:backBottomView()
	self._animator:Play("back_bottom")
end

function NewPlayerCardView:toBottomView()
	self._animator:Play("to_bottom")
end

function NewPlayerCardView:_onRefreshSwitchView(param)
	self:_updateHero(param.heroId, param.skinId, param.isL2d)
end

function NewPlayerCardView:_refreshProgress(tempselectList)
	if not tempselectList then
		::label_25_0::

		local selectMoList = self.playercardinfo:getProgressSetting()
		local skinco = ItemConfig.instance:getItemCo(self.themeId)
		local skintypeList

		if skinco and not string.nilorempty(skinco.effect) then
			skintypeList = string.split(skinco.effect, "#")
		end

		if selectMoList and #selectMoList > 0 then
			for _, selectMo in ipairs(selectMoList) do
				local index = selectMo[2]
				local pos = selectMo[1]
				local progressnode = self._progressItemList[pos]

				if progressnode then
					if not progressnode.isload then
						progressnode.anim:Update(0)
						progressnode.anim:Play("open")

						progressnode.isload = true
					end

					local co = PlayerCardConfig.instance:getCardProgressById(index)

					gohelper.setActive(progressnode.gofull, true)
					gohelper.setActive(progressnode.goempty, false)

					for _, value in pairs(PlayerCardEnum.ProgressShowType) do
						local go = gohelper.findChild(progressnode.gofull, "type" .. value)

						gohelper.setActive(go, false)
					end

					local type = co.type

					progressnode.txtname.text = co.name
					progressnode.gotype = gohelper.findChild(progressnode.gofull, "type" .. type)

					gohelper.setActive(progressnode.gotype, true)
					self:setProgressType(progressnode.gotype, type, index)

					if skintypeList then
						local icon = skintypeList[1]
						local pic = skintypeList[2]

						if not string.nilorempty(icon) then
							UISpriteSetMgr.instance:setPlayerCardSprite(progressnode.imgicon, "playercard_progress_icon_" .. index .. "_" .. icon)
						else
							UISpriteSetMgr.instance:setPlayerCardSprite(progressnode.imgicon, "playercard_main_icon_" .. index)
						end

						if not string.nilorempty(pic) then
							UISpriteSetMgr.instance:setPlayerCardSprite(progressnode.imgpic, "playercard_main_img_" .. index .. "_" .. pic)
						else
							UISpriteSetMgr.instance:setPlayerCardSprite(progressnode.imgpic, "playercard_main_img_" .. index)
						end
					else
						UISpriteSetMgr.instance:setPlayerCardSprite(progressnode.imgpic, "playercard_main_img_" .. index)
						UISpriteSetMgr.instance:setPlayerCardSprite(progressnode.imgicon, "playercard_main_icon_" .. index)
					end
				end
			end
		end

		if self.progressopen then
			local var_25_0 = PlayerCardProgressModel.instance:getEmptyPosList()

			if not var_25_0 then
				var_25_0 = self.playercardinfo:getEmptyPosList()

				local emptyposlist = var_25_0

				for pos, empty in ipairs(emptyposlist) do
					if empty then
						local progressnode = self._progressItemList[pos]

						gohelper.setActive(progressnode.gofull, false)
						gohelper.setActive(progressnode.goempty, true)

						progressnode.isload = false
					end
				end
			end
		end
	end
end

function NewPlayerCardView:setProgressType(go, type, index)
	if type == PlayerCardEnum.ProgressShowType.Normal then
		local txtProgress = gohelper.findChildText(go, "#txt_progress")
		local goNone = gohelper.findChild(go, "none")
		local progress = self.playercardinfo:getProgressByIndex(index)
		local canshow = progress ~= -1

		gohelper.setActive(goNone, not canshow)
		gohelper.setActive(txtProgress.gameObject, canshow)

		txtProgress.text = progress
	elseif type == PlayerCardEnum.ProgressShowType.Explore then
		local exploreCollection = self.playercardinfo.exploreCollection
		local txtNum1 = gohelper.findChildText(go, "#txt_num1")
		local txtNum2 = gohelper.findChildText(go, "#txt_num2")
		local txtNum3 = gohelper.findChildText(go, "#txt_num3")

		if not string.nilorempty(exploreCollection) then
			local arr = GameUtil.splitString2(exploreCollection, true) or {}

			self:_refreshExportItem(1, arr[3], "dungeon_secretroom_btn_triangle", txtNum1)
			self:_refreshExportItem(2, arr[2], "dungeon_secretroom_btn_sandglass", txtNum2)
			self:_refreshExportItem(3, arr[1], "dungeon_secretroom_btn_box", txtNum3)
		else
			txtNum1.text = 0
			txtNum2.text = 0
			txtNum3.text = 0
		end
	elseif type == PlayerCardEnum.ProgressShowType.Room then
		local txtNum1 = gohelper.findChildText(go, "#txt_num1")
		local txtNum2 = gohelper.findChildText(go, "#txt_num2")
		local roomCollection = self.playercardinfo.roomCollection
		local arr = string.splitToNumber(roomCollection, "#")
		local landNum = arr and arr[1]

		txtNum1.text = landNum and landNum or 0

		local buildingNum = arr and arr[2]

		txtNum2.text = buildingNum and buildingNum or 0
	end
end

function NewPlayerCardView:_refreshExportItem(index, data, imageKey, txtitem)
	local num = data and data[1]
	local fullNum = data and data[2]
	local icon = gohelper.findChildImage(txtitem.gameObject, "icon")

	txtitem.text = num and num or PlayerCardEnum.EmptyString

	local isFull = num and fullNum and fullNum <= num

	if isFull then
		UISpriteSetMgr.instance:setExploreSprite(icon, imageKey .. "1", true)
	else
		UISpriteSetMgr.instance:setExploreSprite(icon, imageKey .. "2", true)
	end
end

function NewPlayerCardView:_refreshBaseInfo(tempselectList)
	if not tempselectList then
		::label_28_0::

		local selectMoList = self.playercardinfo:getBaseInfoSetting()

		self:initfirstnode()

		if selectMoList and #selectMoList > 0 then
			for _, selectMo in ipairs(selectMoList) do
				local pos = selectMo[1]
				local id = selectMo[2]
				local baseInfoNode = self._baseInfoItemList[pos]

				if pos ~= 1 and baseInfoNode then
					if not baseInfoNode.isload then
						baseInfoNode.anim:Update(0)
						baseInfoNode.anim:Play("open")

						baseInfoNode.isload = true
					end

					local co = PlayerCardConfig.instance:getCardBaseInfoById(id)

					gohelper.setActive(baseInfoNode.gofull, true)
					gohelper.setActive(baseInfoNode.goempty, false)

					for _, value in pairs(PlayerCardEnum.BaseInfoType) do
						local go = gohelper.findChild(baseInfoNode.gofull, "type" .. value)

						gohelper.setActive(go, false)
					end

					local type = co.type

					baseInfoNode.gotype = gohelper.findChild(baseInfoNode.gofull, "type" .. type)

					gohelper.setActive(baseInfoNode.gotype, true)

					local txttitle = gohelper.findChildText(baseInfoNode.gotype, "txt_title")
					local txtnum

					if type == 2 then
						txtnum = gohelper.findChildText(baseInfoNode.gotype, "layout/#txt_num")

						local txtdec = gohelper.findChildText(baseInfoNode.gotype, "layout/#txt_dec")
						local num, desc = self.playercardinfo:getBaseInfoByIndex(id, true)

						txtnum.text = num
						txtdec.text = desc
					else
						txtnum = gohelper.findChildText(baseInfoNode.gotype, "#txt_num")
						txtnum.text = self.playercardinfo:getBaseInfoByIndex(id, true)
					end

					txttitle.text = co.name
				end
			end
		end

		if self.baseinfoopen then
			local var_28_0 = PlayerCardBaseInfoModel.instance:getEmptyPosList()

			if not var_28_0 then
				var_28_0 = self.playercardinfo:getEmptyBaseInfoPosList()

				local emptyposlist = var_28_0

				for pos, empty in ipairs(emptyposlist) do
					if empty then
						local baseInfoNode = self._baseInfoItemList[pos]

						gohelper.setActive(baseInfoNode.gofull, false)
						gohelper.setActive(baseInfoNode.goempty, true)

						baseInfoNode.isload = false
					end
				end
			end
		end
	end
end

function NewPlayerCardView:initfirstnode()
	local firstBaseInfoNode = self._baseInfoItemList[1]
	local txtnum = gohelper.findChildText(firstBaseInfoNode.gofull, "type1/txt_role/#txt_num")
	local txtrole = gohelper.findChildText(firstBaseInfoNode.gofull, "type1/txt_role")

	firstBaseInfoNode.chesslist = firstBaseInfoNode.chesslist or {}

	if #firstBaseInfoNode.chesslist <= 0 then
		for i = 1, 5 do
			firstBaseInfoNode.chesslist[i] = gohelper.findChildImage(firstBaseInfoNode.gofull, "type1/collection/collection" .. i .. "/#image_full")
		end
	end

	local heroRareNNPercent, heroRareNPercent, heroRareRPercent, heroRareSRPercent, heroRareSSRPercent = self.playercardinfo:getHeroRarePercent()

	firstBaseInfoNode.chesslist[1].fillAmount = heroRareNNPercent or 100
	firstBaseInfoNode.chesslist[2].fillAmount = heroRareNPercent or 100
	firstBaseInfoNode.chesslist[3].fillAmount = heroRareRPercent or 100
	firstBaseInfoNode.chesslist[4].fillAmount = heroRareSRPercent or 100
	firstBaseInfoNode.chesslist[5].fillAmount = heroRareSSRPercent or 100

	local co = PlayerCardConfig.instance:getCardBaseInfoById(1)

	txtnum.text = self.playercardinfo:getHeroCount()
	txtrole.text = co.name
end

function NewPlayerCardView:_initCritter()
	if self.playercardinfo:isSelf() then
		local isCritterOpen = PlayerCardModel.instance:getCritterOpen()

		gohelper.setActive(self._gocritterlight, isCritterOpen)

		if isCritterOpen then
			local critterId, skinId = self.playercardinfo:getCritter()

			if not critterId then
				gohelper.setActive(self._gocritterlight, false)

				return
			end

			self:setResPath(critterId, skinId)
		end
	else
		local critterId, skinId = self.playercardinfo:getCritter()

		if not critterId then
			return
		end

		self:setResPath(critterId, skinId)
	end
end

function NewPlayerCardView:_onRefreshCritter(param)
	local uid = param.uid
	local mo = CritterModel.instance:getCritterMOByUid(tostring(uid))

	if not mo then
		return
	end

	local critterId = mo:getDefineId()
	local skinId = mo:getSkinId()

	self:setResPath(critterId, skinId)
end

function NewPlayerCardView:resetSpine()
	if self._uiSpine then
		self._uiSpine:onDestroy()

		self._uiSpine = nil
	end
end

function NewPlayerCardView:_getSpine()
	self._spine = self._spine or GuiSpine.Create(self._gocritter)

	return self._spine
end

function NewPlayerCardView:resetTransform()
	if not self._spine then
		return
	end

	local go = self._spine._spineGo

	if gohelper.isNil(go) then
		return
	end

	recthelper.setAnchor(go.transform, 0, 0)
	transformhelper.setLocalScale(go.transform, 1, 1, 1)
end

function NewPlayerCardView:setResPath(critterid, skinid)
	skinid = skinid or CritterConfig.instance:getCritterNormalSkin(critterid)

	if not string.nilorempty(skinid) then
		local res = RoomResHelper.getCritterUIPath(skinid)

		self._curModel = self:_getSpine()

		self._curModel:setHeroId(critterid)
		self._curModel:showModel()
		self._curModel:setResPath(res, function()
			self:resetTransform()
		end, self, true)
	end
end

function NewPlayerCardView:_updateHero(heroId, skinId)
	local hero = HeroModel.instance:getByHeroId(heroId)
	local skinCo = SkinConfig.instance:getSkinCo(skinId or hero and hero.skin)

	if not skinCo then
		return
	end

	self.skinCo = skinCo
	self.heroCo = HeroConfig.instance:getHeroCO(self.skinCo.characterId)

	self:resetRes()
	self._simagerole:LoadImage(ResUrl.getHeadIconImg(self.skinCo.id), self._loadedImage, self)
end

function NewPlayerCardView:SetNativeSize()
	return
end

function NewPlayerCardView:resetRes()
	self._simagerole:UnLoadImage()
end

function NewPlayerCardView:_loadedImage()
	ZProj.UGUIHelper.SetImageSize(self._simagerole.gameObject)

	local offsetStr = self.skinCo.playercardViewImgOffset

	if string.nilorempty(offsetStr) then
		offsetStr = self.skinCo.characterViewImgOffset
	end

	if not string.nilorempty(offsetStr) then
		local offsets = string.splitToNumber(offsetStr, "#")

		recthelper.setAnchor(self._simagerole.transform, tonumber(offsets[1]), tonumber(offsets[2]))
		transformhelper.setLocalScale(self._simagerole.transform, tonumber(offsets[3]), tonumber(offsets[3]), tonumber(offsets[3]))
	end
end

function NewPlayerCardView:_initBadge()
	local otherRes = self.viewContainer:getSetting().otherRes

	if not self._badgeComps then
		local badgeResGO = self.viewContainer:getResInst(otherRes.badge, self._gobadgeroot)

		self._badgeComps = MonoHelper.addNoUpdateLuaComOnceToGo(badgeResGO, PlayerCardBadgeView)

		self._badgeComps:onUpdateMO(self.playercardinfo)
	end

	local goswitch = gohelper.findChild(self.viewGO, "root/main/switch")

	if self.playercardinfo:isSelf() and not self._btnSwtichBadge then
		local switchResGO = self:getResInst(otherRes.switch, goswitch)

		self._btnSwtichBadge = gohelper.findChildButtonWithAudio(switchResGO, "root/#btn_switch")

		self._btnSwtichBadge:AddClickListener(self._btncritterOnClick, self)
	end

	gohelper.setActive(goswitch, self.playercardinfo:isSelf())
end

function NewPlayerCardView:onDestroy()
	return
end

return NewPlayerCardView
