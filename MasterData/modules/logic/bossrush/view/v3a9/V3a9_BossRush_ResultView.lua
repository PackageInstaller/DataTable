-- chunkname: @modules/logic/bossrush/view/v3a9/V3a9_BossRush_ResultView.lua

module("modules.logic.bossrush.view.v3a9.V3a9_BossRush_ResultView", package.seeall)

local V3a9_BossRush_ResultView = class("V3a9_BossRush_ResultView", V3a2_BossRush_ResultView)

function V3a9_BossRush_ResultView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG")
	self._simageFullBG1 = gohelper.findChildSingleImage(self.viewGO, "#simage_FullBG1")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "Title/title/#simage_Title")
	self._txtEn = gohelper.findChildText(self.viewGO, "Title/title/#txt_En")
	self._txtName = gohelper.findChildText(self.viewGO, "Title/title/#txt_Name")
	self._btnRank = gohelper.findChildButtonWithAudio(self.viewGO, "Title/title/#btn_Rank")
	self._simagePlayerHead = gohelper.findChildSingleImage(self.viewGO, "Player/PlayerHead/#simage_PlayerHead")
	self._txtPlayerName = gohelper.findChildText(self.viewGO, "Player/#txt_PlayerName")
	self._txtTime = gohelper.findChildText(self.viewGO, "Player/#txt_Time")
	self._simageDec = gohelper.findChildSingleImage(self.viewGO, "Right/#simage_Dec")
	self._txtScore = gohelper.findChildText(self.viewGO, "Right/Score/image_ScoreBG/#txt_Score")
	self._btnInfo = gohelper.findChildButtonWithAudio(self.viewGO, "Right/Score/image_ScoreBG/#txt_Score/#btn_Info")
	self._goNewRecord = gohelper.findChild(self.viewGO, "Right/Score/image_ScoreBG/#txt_Score/#go_NewRecord")
	self._gotips = gohelper.findChild(self.viewGO, "Right/Score/image_ScoreBG/#txt_Score/#go_tips")
	self._gotipsbg = gohelper.findChild(self.viewGO, "Right/Score/image_ScoreBG/#txt_Score/#go_tips/#go_tipsbg")
	self._txtdesc = gohelper.findChildText(self.viewGO, "Right/Score/image_ScoreBG/#txt_Score/#go_tips/#go_tipsbg/#txt_desc")
	self._btntipclose = gohelper.findChildButtonWithAudio(self.viewGO, "Right/Score/image_ScoreBG/#txt_Score/#go_tips/#btn_tipclose")
	self._goGroup = gohelper.findChild(self.viewGO, "Right/#go_Group")
	self._goNotEmpty = gohelper.findChild(self.viewGO, "Right/#go_NotEmpty")
	self._goAssessIcon = gohelper.findChild(self.viewGO, "Right/#go_AssessIcon")
	self._goEvaluate = gohelper.findChild(self.viewGO, "Right/#go_Evaluate")
	self._scrollaffix = gohelper.findChildScrollRect(self.viewGO, "Right/#go_Evaluate/#scroll_affix")
	self._goAffixItem = gohelper.findChild(self.viewGO, "Right/#go_Evaluate/#scroll_affix/Viewport/Content/#go_AffixItem")
	self._txtAffix = gohelper.findChildText(self.viewGO, "Right/#go_Evaluate/#scroll_affix/Viewport/Content/#go_AffixItem/#txt_Affix")
	self._btnaffix = gohelper.findChildButtonWithAudio(self.viewGO, "Right/#go_Evaluate/#scroll_affix/#btn_affix")
	self._scrollTips = gohelper.findChildScrollRect(self.viewGO, "Right/#go_Evaluate/Tips/#scroll_Tips")
	self._txtAffixDescr = gohelper.findChildText(self.viewGO, "Right/#go_Evaluate/Tips/#scroll_Tips/Viewport/Content/#txt_AffixDescr")
	self._goAffixTitle = gohelper.findChild(self.viewGO, "Right/#go_Evaluate/Tips/#scroll_Tips/Viewport/Content/#txt_AffixDescr/#go_AffixTitle")
	self._imageSliderFG = gohelper.findChildImage(self.viewGO, "Right/rank/#image_SliderFG")
	self._txtrank = gohelper.findChildText(self.viewGO, "Right/rank/#txt_rank")
	self._goBonds = gohelper.findChild(self.viewGO, "Right/InfoLayoutGroup/#go_Bonds")
	self._goRole = gohelper.findChild(self.viewGO, "Right/InfoLayoutGroup/#go_Role")
	self._goItem = gohelper.findChild(self.viewGO, "Right/InfoLayoutGroup/#go_Role/#go_Item")
	self._goEmpty = gohelper.findChild(self.viewGO, "Right/InfoLayoutGroup/#go_Role/#go_Item/#go_Empty")
	self._goHas = gohelper.findChild(self.viewGO, "Right/InfoLayoutGroup/#go_Role/#go_Item/#go_Has")
	self._goHead = gohelper.findChild(self.viewGO, "Right/InfoLayoutGroup/#go_Head/go_HeroItem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a9_BossRush_ResultView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnRank:AddClickListener(self._btnRankOnClick, self)
	self._btnInfo:AddClickListener(self._btnInfoOnClick, self)
	self._btntipclose:AddClickListener(self._btntipcloseOnClick, self)
	self._btnaffix:AddClickListener(self._btnaffixOnClick, self)
end

function V3a9_BossRush_ResultView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnRank:RemoveClickListener()
	self._btnInfo:RemoveClickListener()
	self._btntipclose:RemoveClickListener()
	self._btnaffix:RemoveClickListener()
end

function V3a9_BossRush_ResultView:_editableInitView()
	gohelper.setActive(self._goItem, false)
	gohelper.setActive(self._goHead, false)

	self._fontItems = self:getUserDataTb_()
	self._backItems = self:getUserDataTb_()

	local param = {
		isShowMaxNum = false,
		isOpenTipView = false,
		isPlayAnim = false
	}

	self._bondGroupGrid = MonoHelper.addNoUpdateLuaComOnceToGo(self._goBonds, V3a9_BossRush_ExpandBondsGrid, param)

	local path = self.viewContainer:getSetting().otherRes[2]
	local itemRes = self.viewContainer:getRes(path)

	self._bondGroupGrid:setItemRes(itemRes)
	V3a9_BossRush_ResultView.super._editableInitView(self)
end

function V3a9_BossRush_ResultView:onOpen()
	V3a9_BossRush_ResultView.super.onOpen(self)
end

function V3a9_BossRush_ResultView:_initHeroGroup()
	self._curStage, self._curLayer, self._actId = BossRushModel.instance:getBattleStageAndLayer()

	local stageMo = V3a9_BossRushModel.instance:getStageMo(self._actId, self._curStage)

	if stageMo then
		local equipList = V3a9_BossRushModel.instance:getEquipUIds(self._curStage)

		for i = 1, 4 do
			local item = self:_getFontHeroItem(i)
			local heroMo, isAssist = V3a9_BossRushModel.instance:getTeamHeroMo(i, self._curStage)
			local heroId = heroMo and heroMo.heroId
			local isHasHero = heroMo ~= nil

			if isHasHero then
				local config = HeroConfig.instance:getHeroCO(heroId)
				local name = config.name
				local level = heroMo.level

				if not heroMo.skin then
					if isAssist then
						item.heroIcon:onUpdateHeroId(heroId, heroMo.skin)
						item.heroIcon:showLevel(level)
					else
						item.heroIcon:onUpdateMO(heroMo)
					end

					item.txtName.text = name

					local _level, rank = HeroConfig.instance:getShowLevel(level)

					for j = 1, 3 do
						gohelper.setActive(item.goranks[j].gameObject, j == rank - 1)
					end

					item.txtLv.text = _level

					item.heroIcon:isShowRare(false)
					item.heroIcon:setScale(1.3)
				end
			end

			local equipUId = equipList[i]

			if equipUId then
				::label_6_0::

				local equipMo = EquipModel.instance:getEquip(equipUId)

				if equipMo then
					UISpriteSetMgr.instance:setHerogroupEquipIconSprite(item.equipIcon, equipMo.config.icon)

					item.equiptxtlv.text = "LV." .. equipMo.level

					local rareIcon = "bianduixingxian_" .. equipMo.config.rare

					UISpriteSetMgr.instance:setHeroGroupSprite(item.equipRare, rareIcon)
				end

				gohelper.setActive(item.goEquipEmpty, equipMo == nil)
				gohelper.setActive(item.goEquipHas, equipMo ~= nil)
				gohelper.setActive(item.goEmpty, not isHasHero)
				gohelper.setActive(item.goHas, isHasHero)
				gohelper.setActive(item.go, true)
			end
		end

		for i = 5, 8 do
			local item = self:_getBackHeroItem(i)
			local heroMo, isAssist = V3a9_BossRushModel.instance:getTeamHeroMo(i, self._curStage)
			local heroId = heroMo and heroMo.heroId
			local isHasHero = heroMo ~= nil
			local config = HeroConfig.instance:getHeroCO(heroId)

			if isHasHero then
				local level = heroMo.level

				if not heroMo.skin then
					local skin = config.skinId

					if isAssist then
						item.heroIcon:onUpdateHeroId(heroId, skin)
						item.heroIcon:showLevel(level)
					else
						item.heroIcon:onUpdateMO(heroMo)
					end
				end
			end

			item.heroIcon:isShowRare(false)
			item.heroIcon:setScale(0.6)
			gohelper.setActive(item.go, true)
			gohelper.setActive(item.goEmpty, not isHasHero)
		end
	end

	self._bondGroupGrid:refreshExpandBonds()
end

function V3a9_BossRush_ResultView:_getFontHeroItem(index)
	local item = self._fontItems[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.cloneInPlace(self._goItem)
		item.goEmpty = gohelper.findChild(item.go, "#go_Empty")
		item.goHas = gohelper.findChild(item.go, "#go_Has")
		item.index = index
		item.txtName = gohelper.findChildText(item.goHas, "Name")
		item.goranks = self:getUserDataTb_()

		for i = 1, 3 do
			local rank = gohelper.findChild(item.goHas, "layout/rankobj/rank" .. i)

			table.insert(item.goranks, rank)
		end

		item.txtLv = gohelper.findChildText(item.goHas, "layout/lv/lvnum")
		item.rootHero = gohelper.findChild(item.goHas, "go_HeroItem/go_Hero")
		item.heroIcon = IconMgr.instance:getCommonHeroIconNew(item.rootHero)
		item.goEquipEmpty = gohelper.findChild(item.goHas, "go_EquipItem/go_Empty")
		item.goEquipHas = gohelper.findChild(item.goHas, "go_EquipItem/equip")
		item.moveContainer = gohelper.findChild(item.goEquipHas, "moveContainer")
		item.equipIcon = gohelper.findChildImage(item.goEquipHas, "moveContainer/equipIcon")
		item.equipRare = gohelper.findChildImage(item.goEquipHas, "moveContainer/equiprare")
		item.equiptxten = gohelper.findChildText(item.goEquipHas, "equiptxten")
		item.equiptxtlv = gohelper.findChildText(item.goEquipHas, "moveContainer/equiplv/txtequiplv")
		item.equipGolv = gohelper.findChild(item.goEquipHas, "moveContainer/equiplv")
		self._fontItems[index] = item
	end

	return item
end

function V3a9_BossRush_ResultView:_getBackHeroItem(index)
	local item = self._backItems[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.cloneInPlace(self._goHead)
		item.rootHero = gohelper.findChild(item.go, "go_Hero")
		item.goEmpty = gohelper.findChild(item.go, "#go_Empty")
		item.heroIcon = IconMgr.instance:getCommonHeroIconNew(item.rootHero)
		item.index = index
		self._backItems[index] = item
	end

	return item
end

function V3a9_BossRush_ResultView:refreshRankUI()
	gohelper.setActive(self._imagerankIcon.gameObject, false)
end

function V3a9_BossRush_ResultView:_initBoss()
	if self._curStage then
		self._simageFullBG:LoadImage(BossRushConfig.instance:getBossDetailFullPath(self._curStage, self._actId))
		self._simageTitle:LoadImage(BossRushConfig.instance:getBossDetailTitlePath(self._curStage, self._actId))

		for i = 1, 3 do
			local bgGo = gohelper.findChild(self.viewGO, "boss_topbg" .. i)

			gohelper.setActive(bgGo, i == self._curStage)
		end

		local stageCO = BossRushConfig.instance:getStageCO(self._curStage, self._actId)

		self._txtName.text = stageCO.name
		self._txtEn.text = stageCO.name_en
	end
end

return V3a9_BossRush_ResultView
