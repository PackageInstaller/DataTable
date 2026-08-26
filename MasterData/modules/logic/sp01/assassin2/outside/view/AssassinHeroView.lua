-- chunkname: @modules/logic/sp01/assassin2/outside/view/AssassinHeroView.lua

module("modules.logic.sp01.assassin2.outside.view.AssassinHeroView", package.seeall)

local AssassinHeroView = class("AssassinHeroView", BaseView)

function AssassinHeroView:onInitView()
	self._gopick = gohelper.findChild(self.viewGO, "root/#go_pick")
	self._txtpicktitle = gohelper.findChildText(self.viewGO, "root/#go_pick/txt_pick")
	self._goheroContent = gohelper.findChild(self.viewGO, "root/left/#scroll_hero/Viewport/Content")
	self._goheroItem = gohelper.findChild(self.viewGO, "root/left/#scroll_hero/Viewport/Content/#go_heroItem")
	self._txtnamecn = gohelper.findChildText(self.viewGO, "root/heroInfo/#txt_namecn")
	self._txtnameen = gohelper.findChildText(self.viewGO, "root/heroInfo/#txt_namecn/#txt_nameen")
	self._imagecareericon = gohelper.findChildImage(self.viewGO, "root/heroInfo/#image_careericon")
	self._simagehero = gohelper.findChildSingleImage(self.viewGO, "root/heroInfo/Mask/#simage_hero")
	self._goequipcontainer = gohelper.findChild(self.viewGO, "root/heroInfo/#go_equipcontainer")
	self._simageequipicon = gohelper.findChildSingleImage(self.viewGO, "root/heroInfo/#go_equipcontainer/#simage_equipicon")
	self._txtequiplv = gohelper.findChildText(self.viewGO, "root/heroInfo/#go_equipcontainer/#txt_lv")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "root/right/#go_assassinCareer/#go_assassinEquip/#simage_icon")
	self._goswitch = gohelper.findChild(self.viewGO, "root/right/#go_assassinCareer/#go_assassinEquip/#switch_equip")
	self._txtEquipName = gohelper.findChildText(self.viewGO, "root/right/#go_assassinCareer/#go_assassinEquip/#txt_name")
	self._txtcareer = gohelper.findChildText(self.viewGO, "root/right/#go_assassinCareer/#go_assassinEquip/career/#txt_career")
	self._goattrLayout = gohelper.findChild(self.viewGO, "root/right/#go_assassinCareer/#go_assassinEquip/#go_attrLayout")
	self._goattrItem = gohelper.findChild(self.viewGO, "root/right/#go_assassinCareer/#go_assassinEquip/#go_attrLayout/#go_attrItem")
	self._gochange = gohelper.findChild(self.viewGO, "root/right/#go_assassinCareer/#go_assassinEquip/#go_change")
	self._btnchange = gohelper.findChildClickWithAudio(self.viewGO, "root/right/#go_assassinCareer/#go_assassinEquip/#go_change/#btn_change", AudioEnum2_9.StealthGame.play_ui_cikeshang_skillopen)
	self._txtdesc = gohelper.findChildText(self.viewGO, "root/right/#go_assassinCareer/#go_assassinSkill/ScrollView/Viewport/#txt_desc")
	self._goitemLayout = gohelper.findChild(self.viewGO, "root/right/Layout/#go_itemLayout")
	self._goitem = gohelper.findChild(self.viewGO, "root/right/Layout/#go_itemLayout/#go_item")
	self._goenterGame = gohelper.findChild(self.viewGO, "root/right/Layout/#go_enterGame")
	self._goAble = gohelper.findChild(self.viewGO, "root/right/Layout/#go_enterGame/#go_Able")
	self._btnenter1 = gohelper.findChildButtonWithAudio(self.viewGO, "root/right/Layout/#go_enterGame/#go_Able/#btn_enter", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	self._txtenter1 = gohelper.findChildText(self.viewGO, "root/right/Layout/#go_enterGame/#go_Able/#btn_enter/txt_Enter")
	self._txtpick1 = gohelper.findChildText(self.viewGO, "root/right/Layout/#go_enterGame/#go_Able/#txt_pick")
	self._goDisAble = gohelper.findChild(self.viewGO, "root/right/Layout/#go_enterGame/#go_DisAble")
	self._btnenter2 = gohelper.findChildButtonWithAudio(self.viewGO, "root/right/Layout/#go_enterGame/#go_DisAble/#btn_enter", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	self._txtenter2 = gohelper.findChildText(self.viewGO, "root/right/Layout/#go_enterGame/#go_DisAble/#btn_enter/txt_Enter")
	self._txtpick2 = gohelper.findChildText(self.viewGO, "root/right/Layout/#go_enterGame/#go_DisAble/#txt_pick")
	self._btnInfo = gohelper.findChildButtonWithAudio(self.viewGO, "root/heroInfo/#btn_Info", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AssassinHeroView:addEvents()
	self._btnInfo:AddClickListener(self._btnInfoOnClick, self)
	self._btnchange:AddClickListener(self._btnchangeOnClick, self)
	self._btnenter1:AddClickListener(self._btnenterOnClick, self)
	self._btnenter2:AddClickListener(self._btnenterOnClick, self)
	self._btnequip:AddClickListener(self._btnequipOnClick, self)
	self._animEventWrap:AddEventListener("changeHero", self._onChangeHero, self)
	self.addEventCb(self, AssassinController.instance, AssassinEvent.OnChangeAssassinHeroCareer, self._onChangeAssassinHeroCareer, self)
	self.addEventCb(self, AssassinController.instance, AssassinEvent.OnChangeEquippedItem, self._onChangeEquippedItem, self)
	self.addEventCb(self, AssassinController.instance, AssassinEvent.OnUnlockQuestContent, self._onUnlockQuestContent, self)
	self.addEventCb(self, DungeonController.instance, DungeonEvent.OnStartDungeonExtraParams, self.onEnterFightSetParams, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self.onOpenViewFinish, self)
end

function AssassinHeroView:removeEvents()
	self._btnInfo:RemoveClickListener()
	self._btnchange:RemoveClickListener()
	self._btnenter1:RemoveClickListener()
	self._btnenter2:RemoveClickListener()
	self._btnequip:RemoveClickListener()
	self._animEventWrap:RemoveAllEventListener()

	if self._heroItemList then
		for _, heroItem in ipairs(self._heroItemList) do
			heroItem.btnClick:RemoveClickListener()
		end
	end

	if self._itemGridList then
		for _, itemGrid in ipairs(self._itemGridList) do
			itemGrid.btnClick:RemoveClickListener()
		end
	end

	self.removeEventCb(self, AssassinController.instance, AssassinEvent.OnChangeAssassinHeroCareer, self._onChangeAssassinHeroCareer, self)
	self.removeEventCb(self, AssassinController.instance, AssassinEvent.OnChangeEquippedItem, self._onChangeEquippedItem, self)
	self.removeEventCb(self, AssassinController.instance, AssassinEvent.OnUnlockQuestContent, self._onUnlockQuestContent, self)
	self.removeEventCb(self, DungeonController.instance, DungeonEvent.OnStartDungeonExtraParams, self.onEnterFightSetParams, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnOpenViewFinish, self.onOpenViewFinish, self)
end

function AssassinHeroView:_btnInfoOnClick()
	local curShowAssassinHeroId = self:getCurShowAssassinHeroId()

	AssassinController.instance:openHeroStatsView({
		assassinHeroId = curShowAssassinHeroId
	})
end

function AssassinHeroView:_btnchangeOnClick()
	local curShowAssassinHeroId = self:getCurShowAssassinHeroId()
	local isHasSecondCareer = AssassinConfig.instance:isAssassinHeroHasSecondCareer(curShowAssassinHeroId)

	if not isHasSecondCareer then
		return
	end

	AssassinController.instance:openAssassinEquipView({
		assassinHeroId = curShowAssassinHeroId
	})
end

function AssassinHeroView:_btnenterOnClick()
	if not self._questId then
		return
	end

	if self._isFightQuest then
		AssassinController.instance:enterQuestFight(self._questId)
		self:saveHeroCache()
	else
		local pickCount = AssassinStealthGameModel.instance:getPickHeroCount()

		if pickCount < self.needHeroCount then
			return
		end

		AssassinHelper.lockScreen(AssassinEnum.BlockKey.EnterStealthGameEff, true)
		self._animatorPlayer:Play("to_game", self._enterAssassinStealthGame, self)
		AudioMgr.instance:trigger(AudioEnum2_9.StealthGame.play_ui_cikeshang_movestart)
		self:saveHeroCache()
	end
end

function AssassinHeroView:_enterAssassinStealthGame()
	AssassinStealthGameController.instance:startStealthGame(self._questId)
	AssassinHelper.lockScreen(AssassinEnum.BlockKey.EnterStealthGameEff, false)
end

function AssassinHeroView:_btnHeroItemOnClick(index)
	self:_selectHero(index, true)
end

function AssassinHeroView:_selectHero(index, checkAnim)
	local assassinHeroId = self:getAssassinHeroId(index)
	local isUnlocked = AssassinHeroModel.instance:isUnlockAssassinHero(assassinHeroId)

	if not isUnlocked then
		return
	end

	local isChangShowHero = AssassinStealthGameController.instance:pickAssassinHeroItemInHeroView(self._questId, assassinHeroId, self._isFightQuest)

	if isChangShowHero then
		local playAnim = checkAnim and self._curShowIndex ~= index

		self._curShowIndex = index

		if playAnim then
			self._animatorPlayer:Play("switch")
		else
			self:refresh()
		end
	end
end

function AssassinHeroView:_btnItemOnClick(index)
	local curShowAssassinHeroId = self:getCurShowAssassinHeroId()
	local assassinCareerId = AssassinHeroModel.instance:getAssassinCareerId(curShowAssassinHeroId)
	local bagCapacity = AssassinConfig.instance:getAssassinCareerCapacity(assassinCareerId)

	if bagCapacity < index then
		return
	end

	AssassinController.instance:openAssassinBackpackView({
		assassinHeroId = curShowAssassinHeroId,
		carryIndex = index
	})
end

function AssassinHeroView:_btnequipOnClick()
	local curShowAssassinHeroId = self:getCurShowAssassinHeroId()
	local heroMo = AssassinHeroModel.instance:getHeroMo(curShowAssassinHeroId)
	local equipMo = AssassinHeroModel.instance:getAssassinHeroEquipMo(curShowAssassinHeroId)
	local viewParam = {
		heroMo = heroMo,
		equipMo = equipMo,
		fromView = EquipEnum.FromViewEnum.FromAssassinHeroView
	}

	EquipController.instance:openEquipInfoTeamView(viewParam)
end

function AssassinHeroView:_onChangeHero()
	self:refresh()
end

function AssassinHeroView:_onChangeAssassinHeroCareer()
	self:refreshCareerEquipInfo(true)
	self:refreshItemGridList()
end

function AssassinHeroView:_onChangeEquippedItem()
	self:refreshItemGridList()
end

function AssassinHeroView:_onUnlockQuestContent()
	self:refreshHeroItemIsUnlocked()
	self:refreshHeroItemSelected()
end

function AssassinHeroView:onEnterFightSetParams(req, episodeConfig)
	if not self._isFightQuest then
		return
	end

	if episodeConfig and episodeConfig.type == DungeonEnum.EpisodeType.Assassin2Outside then
		local questId = AssassinOutsideModel.instance:getEnterFightQuest()

		req.params = tostring(questId)
	end
end

function AssassinHeroView:onOpenViewFinish(viewName)
	if viewName == ViewName.AssassinStealthGameView then
		self:closeThis()
	end
end

local DEFAULT_SELECTED_INDEX = 1

function AssassinHeroView:_editableInitView()
	self._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)
	self._animEventWrap = self.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))
	self._btnequip = gohelper.getClick(self._goequipcontainer)
	self._goranks = self:getUserDataTb_()

	for i = 1, 3 do
		self._goranks[i] = gohelper.findChild(self.viewGO, "root/heroInfo/level/rankobj/rank" .. i)
	end

	self._txtherolv = gohelper.findChildText(self.viewGO, "root/heroInfo/level/lv/lvltxt")
	self._goexskill = gohelper.findChild(self.viewGO, "root/heroInfo/#go_exskill")
	self._imageexskill = gohelper.findChildImage(self.viewGO, "root/heroInfo/#go_exskill/#image_exskill")

	AssassinStealthGameModel.instance:clearPickHeroData()
	gohelper.setActive(self._goswitch, false)
end

function AssassinHeroView:onUpdateParam()
	self._questId = self.viewParam and self.viewParam.questId

	if self._questId then
		local questType = AssassinConfig.instance:getQuestType(self._questId)

		self._isFightQuest = questType == AssassinEnum.QuestType.Fight
		self._recommendHeroList = AssassinConfig.instance:getQuestRecommendHeroList(self._questId)

		if self._isFightQuest then
			local strEpisodeId = AssassinConfig.instance:getQuestParam(self._questId)
			local episodeId = tonumber(strEpisodeId)
			local episodeCO = episodeId and lua_episode.configDict[episodeId]
			local battleCO = episodeCO and lua_battle.configDict[episodeCO.battleId]

			if battleCO then
				self.needHeroCount = battleCO.playerMax or ModuleEnum.HeroCountInGroup
			end
		else
			local strMapId = AssassinConfig.instance:getQuestParam(self._questId)

			self.needHeroCount = AssassinConfig.instance:getStealthMapNeedHeroCount(tonumber(strMapId))
		end
	end
end

function AssassinHeroView:onOpen()
	self:onUpdateParam()
	self:initBagItemGrid()
	self:initAssassinHeroList()
	self:checkIsPickMode()
	self:_selectHero(DEFAULT_SELECTED_INDEX)
	AudioMgr.instance:trigger(AudioEnum2_9.StealthGame.play_ui_cikeshang_training)
end

function AssassinHeroView:initBagItemGrid()
	self._itemGridList = {}

	local gridList = {}
	local maxBagCapacity = AssassinConfig.instance:getAssassinConst(AssassinEnum.ConstId.MaxBagCapacity, true)

	for i = 1, maxBagCapacity do
		gridList[i] = {
			index = i
		}
	end

	gohelper.CreateObjList(self, self._onCreateItemGrid, gridList, self._goitemLayout, self._goitem)
end

function AssassinHeroView:_onCreateItemGrid(obj, data, index)
	local itemGrid = self:getUserDataTb_()

	itemGrid.go = obj
	itemGrid.index = data
	itemGrid.golocked = gohelper.findChild(itemGrid.go, "#go_locked")
	itemGrid.gounlocked = gohelper.findChild(itemGrid.go, "#go_unlocked")
	itemGrid.goaddIcon = gohelper.findChild(itemGrid.go, "#go_unlocked/#go_addIcon")
	itemGrid.imageitem = gohelper.findChildImage(itemGrid.go, "#go_unlocked/#simage_item")
	itemGrid.goitemicon = itemGrid.imageitem.gameObject
	itemGrid.txtnum = gohelper.findChildText(itemGrid.go, "#go_unlocked/#simage_item/#txt_num")
	itemGrid.goswitch = gohelper.findChild(itemGrid.go, "#go_unlocked/#switch_item")
	itemGrid.btnClick = gohelper.findChildClickWithAudio(itemGrid.go, "#btn_click", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)

	itemGrid.btnClick:AddClickListener(self._btnItemOnClick, self, index)
	gohelper.setActive(itemGrid.golocked, true)
	gohelper.setActive(itemGrid.gounlocked, false)
	gohelper.setActive(itemGrid.goswitch, false)

	self._itemGridList[index] = itemGrid
end

function AssassinHeroView:initAssassinHeroList()
	self._heroItemList = {}

	local assassinHeroList = AssassinHeroModel.instance:getAssassinHeroIdList()

	gohelper.CreateObjList(self, self._onCreateAssassinHeroItem, assassinHeroList, self._goheroContent, self._goheroItem)
end

function AssassinHeroView:_onCreateAssassinHeroItem(obj, data, index)
	local heroItem = self:getUserDataTb_()

	heroItem.go = obj
	heroItem.id = data
	heroItem.gounselected = gohelper.findChild(heroItem.go, "#go_unselected")
	heroItem.goframe1 = gohelper.findChild(heroItem.go, "#go_unselected/#go_frame")
	heroItem.gonormalFrame1 = gohelper.findChild(heroItem.go, "#go_unselected/#go_frame/#go_normalFrame")
	heroItem.gorequiredFrame1 = gohelper.findChild(heroItem.go, "#go_unselected/#go_frame/#go_requiredFrame")
	heroItem.simageheroIcon1 = gohelper.findChildSingleImage(heroItem.go, "#go_unselected/#simage_heroIcon")
	heroItem.txtindex1 = gohelper.findChildText(heroItem.go, "#go_unselected/#txt_index")
	heroItem.goRecommand1 = gohelper.findChild(heroItem.go, "#go_unselected/#go_Recommand")
	heroItem.goselected = gohelper.findChild(heroItem.go, "#go_selected")
	heroItem.goframe2 = gohelper.findChild(heroItem.go, "#go_selected/#go_frame")
	heroItem.gonormalFrame2 = gohelper.findChild(heroItem.go, "#go_selected/#go_frame/#go_normalFrame")
	heroItem.gorequiredFrame2 = gohelper.findChild(heroItem.go, "#go_selected/#go_frame/#go_requiredFrame")
	heroItem.simageheroIcon2 = gohelper.findChildSingleImage(heroItem.go, "#go_selected/#simage_heroIcon")
	heroItem.txtindex2 = gohelper.findChildText(heroItem.go, "#go_selected/#txt_index")
	heroItem.goRecommand2 = gohelper.findChild(heroItem.go, "#go_selected/#go_Recommand")
	heroItem.golocked = gohelper.findChild(heroItem.go, "#go_locked")
	heroItem.simageheroIcon3 = gohelper.findChildSingleImage(heroItem.go, "#go_locked/#simage_heroIcon")
	heroItem.btnClick = gohelper.findChildClickWithAudio(heroItem.go, "#btn_click", AudioEnum2_9.StealthGame.play_ui_cikeshang_herochoose)

	heroItem.btnClick:AddClickListener(self._btnHeroItemOnClick, self, index)

	local heroIcon = AssassinConfig.instance:getAssassinHeroIcon(heroItem.id)

	if not string.nilorempty(heroIcon) then
		local iconPath = ResUrl.getSp01AssassinSingleBg("hero/headicon/" .. heroIcon)

		heroItem.simageheroIcon1:LoadImage(iconPath)
		heroItem.simageheroIcon2:LoadImage(iconPath)
		heroItem.simageheroIcon3:LoadImage(iconPath)
	end

	local isRequired = AssassinHeroModel.instance:isRequiredAssassin(heroItem.id)

	if isRequired then
		AssassinStealthGameController.instance:pickAssassinHeroItemInHeroView(self._questId, heroItem.id, self._isFightQuest)
	end

	gohelper.setActive(heroItem.gorequiredFrame1, false)
	gohelper.setActive(heroItem.gorequiredFrame2, false)
	gohelper.setActive(heroItem.gonormalFrame1, false)
	gohelper.setActive(heroItem.gonormalFrame2, false)
	gohelper.setActive(heroItem.gounselected, false)
	gohelper.setActive(heroItem.goselected, false)
	gohelper.setActive(heroItem.golocked, true)

	if self._recommendHeroList then
		local isRecommend = tabletool.indexOf(self._recommendHeroList, data)

		gohelper.setActive(heroItem.goRecommand1, self._recommendHeroList)
		gohelper.setActive(heroItem.goRecommand2, self._recommendHeroList)

		self._heroItemList[index] = heroItem
	end
end

function AssassinHeroView:checkIsPickMode()
	if self._questId then
		local pickTitleStr = ""
		local enterText = ""

		if self._isFightQuest then
			pickTitleStr = luaLang("assassin_quest_fight_pick_hero")
			enterText = luaLang("assassin_quest_fight_begin")
		else
			local strMapId = AssassinConfig.instance:getQuestParam(self._questId)
			local needHeroCount = AssassinConfig.instance:getStealthMapNeedHeroCount(tonumber(strMapId))

			pickTitleStr = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("assassin_stealth_game_pick_hero"), needHeroCount)
			enterText = luaLang("assassin_stealth_game_begin")
		end

		self._txtpicktitle.text = pickTitleStr
		self._txtenter1.text = enterText
		self._txtenter2.text = enterText

		self:fillHeroCache()
	end

	gohelper.setActive(self._gopick, self._questId)
	gohelper.setActive(self._goenterGame, self._questId)
end

function AssassinHeroView:getAssassinHeroId(index)
	local result

	if self._heroItemList then
		local heroItem = self._heroItemList[index]

		if heroItem then
			result = heroItem.id
		else
			logError(string.format("AssassinHeroView:getAssassinHeroId error, no heroItem, index:%s", index))
		end
	end

	return result
end

function AssassinHeroView:getCurShowAssassinHeroId()
	return (self:getAssassinHeroId(self._curShowIndex))
end

function AssassinHeroView:refresh()
	self:refreshHeroItemIsUnlocked()
	self:refreshHeroItemSelected()
	self:refreshHeroInfo()
	self:refreshCareerEquipInfo()
	self:refreshItemGridList()
end

function AssassinHeroView:refreshHeroItemSelected()
	if not self._heroItemList then
		return
	end

	for i, heroItem in ipairs(self._heroItemList) do
		local assassinHeroId = heroItem.id
		local isUnlocked = AssassinHeroModel.instance:isUnlockAssassinHero(assassinHeroId)

		if isUnlocked then
			local isCurShow = i == self._curShowIndex

			if self._questId then
				local pickIndex = AssassinStealthGameModel.instance:getHeroPickIndex(assassinHeroId)

				if pickIndex then
					local isRequired = AssassinHeroModel.instance:isRequiredAssassin(assassinHeroId)

					gohelper.setActive(heroItem.gorequiredFrame1, isRequired)
					gohelper.setActive(heroItem.gorequiredFrame2, isRequired)
					gohelper.setActive(heroItem.gonormalFrame1, not isRequired)
					gohelper.setActive(heroItem.gonormalFrame2, not isRequired)
				end

				heroItem.txtindex1.text = pickIndex or ""
				heroItem.txtindex2.text = pickIndex or ""

				gohelper.setActive(heroItem.goframe1, pickIndex)
				gohelper.setActive(heroItem.goframe2, pickIndex)
			else
				heroItem.txtindex1.text = ""
				heroItem.txtindex2.text = ""

				gohelper.setActive(heroItem.gonormalFrame1, isCurShow)
				gohelper.setActive(heroItem.gonormalFrame2, isCurShow)
			end

			gohelper.setActive(heroItem.goselected, isCurShow)
			gohelper.setActive(heroItem.gounselected, not isCurShow)
		else
			gohelper.setActive(heroItem.goselected, false)
			gohelper.setActive(heroItem.gounselected, false)
		end
	end

	if self._questId then
		local pickText = ""
		local pickCount = AssassinStealthGameModel.instance:getPickHeroCount()
		local isCanEnter = false

		if self._isFightQuest then
			pickText = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("assassin_stealth_game_fight_has_pick_hero"), pickCount, self.needHeroCount)
			isCanEnter = pickCount > 0
		else
			pickText = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("assassin_stealth_game_has_pick_hero"), pickCount, self.needHeroCount)
			isCanEnter = pickCount >= self.needHeroCount
		end

		self._txtpick1.text = pickText
		self._txtpick2.text = pickText

		gohelper.setActive(self._goAble, isCanEnter)
		gohelper.setActive(self._goDisAble, not isCanEnter)
	end
end

function AssassinHeroView:refreshHeroItemIsUnlocked()
	if not self._heroItemList then
		return
	end

	for _, heroItem in ipairs(self._heroItemList) do
		local assassinHeroId = heroItem.id
		local isUnlocked = AssassinHeroModel.instance:isUnlockAssassinHero(assassinHeroId)

		if isUnlocked then
			gohelper.setActive(heroItem.golocked, false)
			gohelper.setActive(heroItem.goselected, false)
			gohelper.setActive(heroItem.gounselected, false)
		else
			gohelper.setActive(heroItem.golocked, true)
			gohelper.setActive(heroItem.goselected, false)
			gohelper.setActive(heroItem.gounselected, false)
		end
	end
end

local exSkillFillAmount = {
	0.2,
	0.4,
	0.6,
	0.79,
	1
}

function AssassinHeroView:refreshHeroInfo()
	local curShowAssassinHeroId = self:getCurShowAssassinHeroId()
	local nameCN, nameEn = AssassinHeroModel.instance:getAssassinHeroName(curShowAssassinHeroId)

	self._txtnamecn.text = nameCN
	self._txtnameen.text = nameEn

	local heroImg = AssassinConfig.instance:getAssassinHeroImg(curShowAssassinHeroId)

	if not string.nilorempty(heroImg) then
		local imgPath = ResUrl.getSp01AssassinSingleBg("hero/headicon/" .. heroImg)

		self._simagehero:LoadImage(imgPath)
	end

	local career = AssassinHeroModel.instance:getAssassinHeroCommonCareer(curShowAssassinHeroId)

	UISpriteSetMgr.instance:setCommonSprite(self._imagecareericon, "lssx_" .. tostring(career))

	local equipMo = AssassinHeroModel.instance:getAssassinHeroEquipMo(curShowAssassinHeroId)

	if equipMo then
		self._simageequipicon:LoadImage(ResUrl.getHeroDefaultEquipIcon(equipMo.config.icon))

		self._txtequiplv.text = equipMo.level
	end

	gohelper.setActive(self._goequipcontainer, equipMo)

	local level, rank = AssassinHeroModel.instance:getAssassinHeroShowLevel(curShowAssassinHeroId)

	self._txtherolv.text = level

	for i = 1, 3 do
		gohelper.setActive(self._goranks[i], rank and i == rank - 1)
	end

	local skillLv = AssassinHeroModel.instance:getAssassinHeroSkillLevel(curShowAssassinHeroId)

	if skillLv > 0 then
		self._imageexskill.fillAmount = exSkillFillAmount[skillLv] or 1

		gohelper.setActive(self._goexskill, true)
	else
		gohelper.setActive(self._goexskill, false)
	end
end

function AssassinHeroView:refreshCareerEquipInfo(playSwitch)
	local curShowAssassinHeroId = self:getCurShowAssassinHeroId()
	local assassinCareerId = AssassinHeroModel.instance:getAssassinCareerId(curShowAssassinHeroId)
	local pic = AssassinConfig.instance:getAssassinCareerEquipPic(assassinCareerId)
	local picPath = ResUrl.getSp01AssassinSingleBg("weapon/" .. pic)

	self._simageicon:LoadImage(picPath)

	self._txtEquipName.text = AssassinConfig.instance:getAssassinCareerEquipName(assassinCareerId)
	self._txtcareer.text = AssassinConfig.instance:getAssassinCareerTitle(assassinCareerId)

	local isHasSecondCareer = AssassinConfig.instance:isAssassinHeroHasSecondCareer(curShowAssassinHeroId)

	gohelper.setActive(self._gochange, isHasSecondCareer)

	local skillId = AssassinConfig.instance:getAssassinSkillIdByHeroCareer(curShowAssassinHeroId, assassinCareerId)

	self._txtdesc.text = AssassinConfig.instance:getAssassinCareerSkillDesc(skillId)

	local equipAttrList = AssassinConfig.instance:getAssassinCareerAttrList(assassinCareerId)

	gohelper.CreateObjList(self, self._onCreateCareerEquipAttrItem, equipAttrList, self._goattrLayout, self._goattrItem)

	if playSwitch then
		gohelper.setActive(self._goswitch, false)
		gohelper.setActive(self._goswitch, true)
	end
end

function AssassinHeroView:_onCreateCareerEquipAttrItem(obj, data, index)
	local attrIcon = gohelper.findChildImage(obj, "icon")
	local attrName = gohelper.findChildText(obj, "#txt_attrName")
	local attrValue = gohelper.findChildText(obj, "#txt_attrValue")
	local attrId = data[1]
	local attrCO = HeroConfig.instance:getHeroAttributeCO(attrId)

	CharacterController.instance:SetAttriIcon(attrIcon, attrId, GameUtil.parseColor("#675C58"))

	attrName.text = attrCO.name
	attrValue.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("add_percent_value"), (data[2] or 0) / 10)
end

function AssassinHeroView:refreshItemGridList()
	local curShowAssassinHeroId = self:getCurShowAssassinHeroId()
	local assassinCareerId = AssassinHeroModel.instance:getAssassinCareerId(curShowAssassinHeroId)
	local bagCapacity = AssassinConfig.instance:getAssassinCareerCapacity(assassinCareerId)

	for index, itemGrid in ipairs(self._itemGridList) do
		local isUnlocked = index <= bagCapacity

		if isUnlocked then
			local assassinItemId = AssassinHeroModel.instance:getCarryItemId(curShowAssassinHeroId, index)

			if assassinItemId then
				AssassinHelper.setAssassinItemIcon(assassinItemId, itemGrid.imageitem)

				itemGrid.txtnum.text = AssassinItemModel.instance:getAssassinItemCount(assassinItemId)
			end

			gohelper.setActive(itemGrid.goaddIcon, not assassinItemId)
			gohelper.setActive(itemGrid.goitemicon, assassinItemId)
		end

		gohelper.setActive(itemGrid.golocked, not isUnlocked)
		gohelper.setActive(itemGrid.gounlocked, isUnlocked)
	end
end

function AssassinHeroView:onClose()
	AssassinHelper.lockScreen(AssassinEnum.BlockKey.EnterStealthGameEff, false)
end

function AssassinHeroView:onDestroyView()
	if self._heroItemList then
		for _, heroItem in ipairs(self._heroItemList) do
			if heroItem.simageheroIcon1 then
				heroItem.simageheroIcon1:UnLoadImage()
			end

			if heroItem.simageheroIcon2 then
				heroItem.simageheroIcon2:UnLoadImage()
			end

			if heroItem.simageheroIcon3 then
				heroItem.simageheroIcon3:UnLoadImage()
			end
		end
	end

	self._simagehero:UnLoadImage()
	self._simageicon:UnLoadImage()
	self._simageequipicon:UnLoadImage()
end

function AssassinHeroView:saveHeroCache()
	local cacheHeroDic = {}
	local heroList = AssassinStealthGameModel.instance:getPickHeroList()

	for i = 2, #heroList do
		cacheHeroDic[tostring(i - 1)] = heroList[i]
	end

	GameUtil.playerPrefsSetStringByUserId(AssassinEnum.PlayerCacheDataKey.AssassinHeroGroupCache, cjson.encode(cacheHeroDic))
end

function AssassinHeroView:fillHeroCache()
	if self.needHeroCount <= 1 then
		return
	end

	local dataStr = GameUtil.playerPrefsGetStringByUserId(AssassinEnum.PlayerCacheDataKey.AssassinHeroGroupCache, "")

	if not string.nilorempty(dataStr) then
		local cacheHeroDic = cjson.decode(dataStr)

		for i = 1, self.needHeroCount - 1 do
			local assassinHeroId = cacheHeroDic[tostring(i)]

			if assassinHeroId then
				AssassinStealthGameController.instance:pickAssassinHeroItemInHeroView(self._questId, assassinHeroId, self._isFightQuest)
			end
		end
	end
end

return AssassinHeroView
