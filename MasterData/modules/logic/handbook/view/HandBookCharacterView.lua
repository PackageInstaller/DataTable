-- chunkname: @modules/logic/handbook/view/HandBookCharacterView.lua

module("modules.logic.handbook.view.HandBookCharacterView", package.seeall)

local HandBookCharacterView = class("HandBookCharacterView", BaseView)

function HandBookCharacterView:onInitView()
	self._goContainer = gohelper.findChild(self.viewGO, "#go_center/handbookcharacterview")
	self._simagebg = gohelper.findChildSingleImage(self._goContainer, "bg/#simage_bg")
	self._simageline = gohelper.findChildSingleImage(self._goContainer, "bg/#simage_line")
	self._gocover = gohelper.findChild(self._goContainer, "#go_cover")
	self._simagecoverbg2 = gohelper.findChildSingleImage(self._goContainer, "#go_cover/#simage_coverbg2")
	self._txttitleName = gohelper.findChildText(self._goContainer, "#go_cover/left/#txt_titleName")
	self._simagecovericon = gohelper.findChildSingleImage(self._goContainer, "#go_cover/left/mask/#simage_covericon")
	self._gocoverrightpage = gohelper.findChild(self._goContainer, "#go_cover/right/#go_coverrightpage")
	self._simagepagebg = gohelper.findChild(self._goContainer, "#simage_pagebg")
	self._gocharacteritem = gohelper.findChild(self._goContainer, "#go_characteritem")
	self._goleftpage = gohelper.findChild(self._goContainer, "#go_leftpage")
	self._goleftarrow = gohelper.findChild(self._goContainer, "#go_leftarrow")
	self._gorightpage = gohelper.findChild(self._goContainer, "#go_rightpage")
	self._gorightarrow = gohelper.findChild(self._goContainer, "#go_rightarrow")
	self._gocoverrightarrow = gohelper.findChild(self._goContainer, "#go_coverrightarrow")
	self._btnrarerank = gohelper.findChildButtonWithAudio(self.viewGO, "#go_center/handbookcharacterview/#go_upleft/#btn_rarerank")
	self._goarrow = gohelper.findChild(self.viewGO, "#go_center/handbookcharacterview/#go_upleft/#btn_rarerank/btn2/txt/#go_arrow")
	self._btnclassify = gohelper.findChildButtonWithAudio(self.viewGO, "#go_center/handbookcharacterview/#go_upleft/#btn_classify")
	self._txtpagecount = gohelper.findChildText(self.viewGO, "#go_center/handbookcharacterview/#txt_pagecount")
	self._gohumantip = gohelper.findChild(self._goContainer, "#go_tips")
	self._gohumantipAnimtor = self._gohumantip:GetComponent(gohelper.Type_Animator)
	self._gohumansubtip = gohelper.findChild(self._goContainer, "#go_tips/Tips")
	self._gotipclose = gohelper.findChild(self._goContainer, "#go_tipclose")
	self._gohumantipbutton = gohelper.findChildButtonWithAudio(self._goContainer, "#go_tips/Button")
	self._gotipcloseclick = gohelper.getClickWithDefaultAudio(self._gotipclose)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function HandBookCharacterView:addEvents()
	self._btnrarerank:AddClickListener(self._btnrarerankOnClick, self)
	self._btnclassify:AddClickListener(self._btnclassifyOnClick, self)
	self._gohumantipbutton:AddClickListener(self.onClickTipBtn, self)
	self._gotipcloseclick:AddClickListener(self.onClickCloseTipBtn, self)
end

function HandBookCharacterView:removeEvents()
	self._btnrarerank:RemoveClickListener()
	self._btnclassify:RemoveClickListener()
	self._gohumantipbutton:RemoveClickListener()
	self._gotipcloseclick:RemoveClickListener()
end

function HandBookCharacterView:onClickTipBtn()
	if self.heroType ~= 6 then
		return
	end

	gohelper.setActive(self._gohumansubtip, true)
	gohelper.setActive(self._gotipclose, true)
end

function HandBookCharacterView:onClickCloseTipBtn()
	if self.heroType ~= 6 then
		return
	end

	gohelper.setActive(self._gohumansubtip, false)
	gohelper.setActive(self._gotipclose, false)
end

function HandBookCharacterView:_btnrarerankOnClick()
	self._isSortL2H = not self._isSortL2H

	self:_refreshFilterState()
	self:_refreshShowFirstPage()
end

function HandBookCharacterView:_btnclassifyOnClick()
	local param = {}

	param.dmgs = {}
	param.attrs = {}

	tabletool.addValues(param.dmgs, self._selectDmgs)
	tabletool.addValues(param.attrs, self._selectCareers)
	CharacterController.instance:openCharacterFilterView(param)
end

function HandBookCharacterView:_onFilterList(param)
	if self:_isAllHeroType() then
		for i = 1, #param.dmgs do
			self._selectDmgs[i] = param.dmgs[i]
		end

		for i = 1, #param.attrs do
			self._selectCareers[i] = param.attrs[i]
		end

		self._dmgFilterCount = self:_findFilterCount(self._selectDmgs)
		self._careerFilterCount = self:_findFilterCount(self._selectCareers)
		self._tagsFilterTotalCount = 0
		self._selectTags = CharacterSearchFilterModel.instance:getSelectLocalTags()

		if self._selectTags then
			for type, list in pairs(self._selectTags) do
				if list then
					if not #list then
						local count = 0

						self._tagsFilterTotalCount = self._tagsFilterTotalCount + count
					end
				end
			end
		end

		self:_refreshFilterState()
		self:_refreshShowFirstPage()
	end
end

function HandBookCharacterView:_findFilterCount(filters)
	local count = 0

	for k, v in pairs(filters) do
		if v then
			count = count + 1
		end
	end

	return count
end

HandBookCharacterView.DragAbsPositionX = 50
HandBookCharacterView.AnimatorBlockName = "animatorBlockName"

function HandBookCharacterView:_editableInitView()
	self._simagecoverbg1peper1 = gohelper.findChildSingleImage(self._goContainer, "#go_cover/#simage_coverbg1/peper1")
	self._simagecoverbg1peper2 = gohelper.findChildSingleImage(self._goContainer, "#go_cover/#simage_coverbg1/peper2")
	self._coverAnim = self._gocover:GetComponent(typeof(UnityEngine.Animator))
	self._containerAnim = ZProj.ProjAnimatorPlayer.Get(self._goContainer)

	gohelper.setActive(self._gocharacteritem, false)

	self._goarrowTrs = self._goarrow.transform
	self.items = {}
	self.coveritems = {}
	self.characterClickTabs = self:getUserDataTb_()

	local temGo = self._btnclassify.gameObject

	self._goFiltering = gohelper.findChild(temGo, "btn2")
	self._goFilterno = gohelper.findChild(temGo, "btn1")

	for i = 1, 7 do
		self["_gocharacter" .. i] = i >= 4 and gohelper.findChild(self._gorightpage, "#go_character" .. i) or gohelper.findChild(self._goleftpage, "#go_character" .. i)

		local characterClick = gohelper.getClick(self["_gocharacter" .. i])

		characterClick:AddClickListener(self.characterOnClick, self, i)
		table.insert(self.characterClickTabs, characterClick)
		table.insert(self.items, self:findItemSubNodes(self["_gocharacter" .. i]))
	end

	for i = 4, 7 do
		self["_gocorvercharacter" .. i] = gohelper.findChild(self._gocoverrightpage, "#go_corvercharacter" .. i)

		local corvercharacterClick = gohelper.getClick(self["_gocorvercharacter" .. i])

		corvercharacterClick:AddClickListener(self.characterOnClick, self, i)
		table.insert(self.characterClickTabs, corvercharacterClick)
		table.insert(self.coveritems, self:findItemSubNodes(self["_gocorvercharacter" .. i]))
	end

	self._leftArrowClick = gohelper.findChildClickWithAudio(self._goleftarrow, "clickArea", AudioEnum.UI.play_ui_screenplay_photo_click)
	self._rightArrowClick = gohelper.findChildClickWithAudio(self._gorightarrow, "clickArea", AudioEnum.UI.play_ui_screenplay_photo_click)
	self._coverRightArrowClick = gohelper.findChildClickWithAudio(self._gocoverrightarrow, "clickArea", AudioEnum.UI.play_ui_screenplay_photo_click)

	self._leftArrowClick:AddClickListener(self.leftPageOnClick, self)
	self._rightArrowClick:AddClickListener(self.rightPageOnClick, self)
	self._coverRightArrowClick:AddClickListener(self.rightPageOnClick, self)

	self.currentPage = 1
	self.maxPage = 1
	self.startDragPosX = 0
	self._firstPageNum = 4
	self._isSortL2H = false
	self._dmgFilterCount = 0
	self._careerFilterCount = 0
	self._tagsFilterTotalCount = 0
	self._selectDmgs = {
		false,
		false
	}
	self._selectCareers = {
		false,
		false,
		false,
		false,
		false,
		false
	}

	self._simagebg:LoadImage(ResUrl.getHandbookCharacterIcon("full/bg111"))
	self._simageline:LoadImage(ResUrl.getHandbookCharacterIcon("bg_xian"))
	self._simagecoverbg2:LoadImage(ResUrl.getHandbookCharacterIcon("zhi2"))
	self._simagecoverbg1peper1:LoadImage(ResUrl.getHandbookCharacterIcon("peper_01"))
	self._simagecoverbg1peper2:LoadImage(ResUrl.getHandbookCharacterIcon("peper_02"))
end

function HandBookCharacterView:characterOnClick(index)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Player_Interface_Open)

	local currentPageStartIndex = (self.currentPage - 2) * 7 + self:getFirstPageHeroNum()
	local heroCfg = self.configHeroList[currentPageStartIndex + index]

	if not heroCfg then
		return
	end

	local heroId = heroCfg.id
	local heroMo = HeroModel.instance:getByHeroId(heroId)

	if self:_isAllHeroType() then
		local param = {
			heroId = heroId,
			skinId = heroCfg.skinId
		}

		if not heroMo then
			param.skinColorStr = "#1A1A1A"
		end

		ViewMgr.instance:openView(ViewName.SummonHeroDetailView, param)
	elseif heroMo then
		self:openCharacterView(heroId)
	else
		GameFacade.showToast(ToastEnum.HandBook1)
	end

	if heroMo and not HandbookModel.instance:isRead(HandbookEnum.Type.Character, heroId) then
		HandbookRpc.instance:sendHandbookReadRequest(HandbookEnum.Type.Character, heroId)

		if self.currentPage == 1 and not self:_isAllHeroType() then
			gohelper.setActive(self.coveritems[index - 3].gonew, false)
		else
			gohelper.setActive(self.items[index].gonew, false)
		end
	end
end

function HandBookCharacterView:openCharacterView(heroId)
	CharacterController.instance:openCharacterDataView({
		fromHandbookView = true,
		heroId = heroId
	})
end

function HandBookCharacterView:onUpdateParam()
	return
end

function HandBookCharacterView:onOpen()
	self.addEventCb(self, HandbookController.instance, HandbookController.EventName.OnShowSubCharacterView, self.reallyOpenView, self)
	self.addEventCb(self, HandbookController.instance, HandbookController.EventName.PlayCharacterSwitchCloseAnim, self._playCloseViewAnim, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseFullView, self._onCloseFullView, self, LuaEventSystem.Low)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.FilterBackpack, self._onFilterList, self)
end

function HandBookCharacterView:findItemSubNodes(goItem)
	local characterItemGO = gohelper.clone(self._gocharacteritem, goItem)

	gohelper.setActive(characterItemGO, true)

	local o = {}

	o.gohero = gohelper.findChild(characterItemGO, "hero")
	o.gonohero = gohelper.findChild(characterItemGO, "nohero")
	o.goempty = gohelper.findChild(characterItemGO, "#go_empty")
	o.gocircle = gohelper.findChild(characterItemGO, "circle")
	o.simagehero = gohelper.findChildSingleImage(characterItemGO, "hero/simage_hero")
	o.simagesignature = gohelper.findChildSingleImage(characterItemGO, "hero/simage_signature")
	o.careerIcon = gohelper.findChildImage(characterItemGO, "hero/image_career")
	o.gonew = gohelper.findChild(characterItemGO, "hero/go_new")
	o.txtname = gohelper.findChildTextMesh(characterItemGO, "hero/txt_name")
	o.gostars = {}

	for i = 1, 6 do
		table.insert(o.gostars, gohelper.findChild(characterItemGO, "hero/star/star" .. i))
	end

	o.simagenohero = gohelper.findChildSingleImage(characterItemGO, "nohero/simage_nohero")
	o.txtnoheroname = gohelper.findChildTextMesh(characterItemGO, "nohero/txt_noheroname")

	gohelper.setActive(o.gonew, false)

	return o
end

function HandBookCharacterView:_onCloseFullView()
	if self.currentPage == 1 then
		self._coverAnim:Play(UIAnimationName.Open, 0, 0)
	end

	self._containerAnim:Play(UIAnimationName.Open)
end

function HandBookCharacterView:leftPageOnClick()
	if self.currentPage > 1 then
		UIBlockMgr.instance:startBlock(HandBookCharacterView.AnimatorBlockName)
		self._containerAnim:Play("right_out", function(self)
			self:refreshCharacterBook(self.currentPage - 1)
			self._containerAnim:Play("right_in")
			UIBlockMgr.instance:endBlock(HandBookCharacterView.AnimatorBlockName)
		end, self)
	end
end

function HandBookCharacterView:rightPageOnClick()
	if self.currentPage < self.maxPage then
		UIBlockMgr.instance:startBlock(HandBookCharacterView.AnimatorBlockName)
		self._containerAnim:Play("left_out", function(self)
			self:refreshCharacterBook(self.currentPage + 1)
			self._containerAnim:Play("left_in")
			UIBlockMgr.instance:endBlock(HandBookCharacterView.AnimatorBlockName)
		end, self)
	end
end

function HandBookCharacterView:reallyOpenView(heroType)
	self.heroType = heroType

	self:refreshHumanTip()
	self:_resetFilterParam()

	self.configHeroList = self:_getConfigHeroList()
	self.maxPage = self:calculateMaxPageNum()

	self:refreshCharacterBook(1)
	self:refreshCoverInfo()

	self._drag = SLFramework.UGUI.UIDragListener.Get(self._goContainer)

	self._drag:AddDragBeginListener(self.onDragBeginHandle, self)
	self._drag:AddDragEndListener(self.onDragEndHandle, self)
	self._coverAnim:Play(UIAnimationName.Open, 0, 0)
	self._gohumantipAnimtor:Play(UIAnimationName.Open, 0, 0)
	self:_refreshFilterState()
end

function HandBookCharacterView:refreshHumanTip()
	gohelper.setActive(self._gohumantip, self.heroType == 6)
	gohelper.setActive(self._gohumansubtip, false)
	gohelper.setActive(self._gotipclose, false)
end

function HandBookCharacterView:_resetFilterParam()
	self:_resetFilterList(self._selectDmgs)
	self:_resetFilterList(self._selectCareers)

	self._dmgFilterCount = 0
	self._careerFilterCount = 0
	self._tagsFilterTotalCount = 0
	self._isSortL2H = false
end

function HandBookCharacterView:_resetFilterList(filterList)
	for i = 1, #filterList do
		filterList[i] = false
	end
end

function HandBookCharacterView:_refreshShowFirstPage()
	self.configHeroList = self:_getConfigHeroList()
	self.maxPage = self:calculateMaxPageNum()

	self:refreshCharacterBook(1)
	self:refreshCoverInfo()
end

function HandBookCharacterView:_refreshFilterState()
	if self:_isAllHeroType() then
		local isFiltering = CharacterSearchFilterModel.instance:hasFilter()

		gohelper.setActive(self._goFiltering, isFiltering)
		gohelper.setActive(self._goFilterno, not isFiltering)
		transformhelper.setLocalScale(self._goarrowTrs, 1, self._isSortL2H and -1 or 1, 1)
	end
end

function HandBookCharacterView:_getConfigHeroList()
	local cfgList = {}
	local allList = HeroConfig.instance:getHeroesList()

	self._selectDestiny = CharacterSearchFilterModel.instance:getSelectDestiny()

	for _, cfg in ipairs(allList) do
		if self:_checkConfig(cfg) then
			table.insert(cfgList, cfg)
		end
	end

	table.sort(cfgList, (self:_isAllHeroType() and self._isSortL2H or nil) and HandBookCharacterView._sortFuncL2H)

	return cfgList
end

function HandBookCharacterView:_checkConfig(cfg)
	if cfg.stat == CharacterEnum.StatType.NotStat and not HeroModel.instance:getByHeroId(cfg.id) then
		return false
	end

	if not self:_isAllHeroType() then
		local heroMo = HeroModel.instance:getByHeroId(cfg.id)

		if heroMo then
			return heroMo:getHeroType() == self.heroType
		end

		return cfg.heroType == self.heroType
	end

	local isDmg = self._dmgFilterCount == 0 or self._selectDmgs[cfg.dmgType]
	local destiny = CharacterModel.instance:filterHerobyDestiny(cfg.id, self._selectDestiny)
	local isCareers = self._careerFilterCount == 0 or CharacterModel.instance:filterHerobyCareer_1(self._selectCareers, cfg.career)
	local isFilterTag = true
	local isFilterTag

	if self._tagsFilterTotalCount ~= 0 then
		isFilterTag = self._selectTags and CharacterModel.instance:isFilterTagByBattleTags(self._selectTags, cfg.battleTag, cfg.id)
	end

	if isDmg and destiny and isCareers and isFilterTag then
		return true
	end

	return false
end

function HandBookCharacterView._sortFuncH2L(a, b)
	if a.rare ~= b.rare then
		return a.rare > b.rare
	else
		return a.id < b.id
	end
end

function HandBookCharacterView._sortFuncL2H(a, b)
	if a.rare ~= b.rare then
		return a.rare < b.rare
	else
		return a.id < b.id
	end
end

function HandBookCharacterView:refreshCoverInfo()
	local isShow = not self:_isAllHeroType()

	gohelper.setActive(self._txttitleName, isShow)
	gohelper.setActive(self._simagecovericon, isShow)

	if isShow then
		local heroTypeCo = lua_handbook_character.configDict[self.heroType]

		self._txttitleName.text = heroTypeCo.name

		self._simagecovericon:LoadImage(ResUrl.getHandbookCharacterIcon("coer" .. heroTypeCo.icon))
	end
end

function HandBookCharacterView:refreshCharacterBook(page)
	if page > self.maxPage then
		page = self.maxPage
	end

	if page < 1 then
		page = 1
	end

	self.currentPage = page

	if page == 1 then
		local leftNum = self:getFirstPageLeftHeroNum()

		gohelper.setActive(self._gocover, true)
		gohelper.setActive(self._simagepagebg.gameObject, false)
		gohelper.setActive(self._goleftpage, leftNum > 0)
		gohelper.setActive(self._gorightpage, false)

		for i = 1, 4 do
			self:showBookItem(self.coveritems[i], self.configHeroList[i + leftNum], i + 3, true)
		end

		for i = 1, leftNum do
			self:showBookItem(self.items[i], self.configHeroList[i], i, false)
		end
	else
		gohelper.setActive(self._gocover, false)
		gohelper.setActive(self._simagepagebg.gameObject, true)
		gohelper.setActive(self._goleftpage, true)
		gohelper.setActive(self._gorightpage, true)

		local startIndex = (page - 2) * 7 + self:getFirstPageHeroNum()

		for i = 1, 7 do
			self:showBookItem(self.items[i], self.configHeroList[startIndex + i], i, false)
		end
	end

	gohelper.setActive(self._goleftarrow, self.currentPage > 1)
	gohelper.setActive(self._gorightarrow, self.currentPage < self.maxPage)
	gohelper.setActive(self._gocoverrightarrow, self.currentPage < self.maxPage)
	gohelper.setActive(self._txtpagecount, self:_isAllHeroType())

	if self:_isAllHeroType() then
		self._txtpagecount.text = self.currentPage .. "/" .. self.maxPage
	end
end

function HandBookCharacterView:showBookItem(item, heroCo, characterIndex, isFirstPage)
	local isAllHeroType = self:_isAllHeroType()

	if isFirstPage then
		gohelper.setActive(self["_gocorvercharacter" .. characterIndex], isAllHeroType or heroCo)
	else
		gohelper.setActive(self["_gocharacter" .. characterIndex], isAllHeroType or heroCo)
	end

	if heroCo then
		local heroMo = HeroModel.instance:getByHeroId(heroCo.id)
		local hasHero = not not heroMo
		local showName = hasHero or isAllHeroType

		gohelper.setActive(item.gohero, showName)
		gohelper.setActive(item.gonohero, not hasHero)
		gohelper.setActive(item.simagehero, hasHero)

		if hasHero then
			item.simagehero:LoadImage(ResUrl.getHandbookheroIcon(heroCo.skinId))
		else
			item.simagenohero:LoadImage(ResUrl.getHandbookheroIcon(heroCo.skinId))
			gohelper.setActive(item.txtnoheroname, not showName)
		end

		if showName then
			item.txtname.text = heroCo.name

			item.simagesignature:LoadImage(ResUrl.getSignature(heroCo.signature))
			UISpriteSetMgr.instance:setCommonSprite(item.careerIcon, "lssx_" .. tostring(heroCo.career))

			for i = 1, 6 do
				gohelper.setActive(item.gostars[i], i <= heroCo.rare + 1)
			end
		end
	else
		gohelper.setActive(item.gohero, false)
		gohelper.setActive(item.gonohero, false)
	end

	gohelper.setActive(item.gocircle, heroCo)
	gohelper.setActive(item.goempty, isAllHeroType and not heroCo)
end

function HandBookCharacterView:calculateMaxPageNum()
	return math.ceil((#self.configHeroList - self:getFirstPageHeroNum()) / 7) + 1
end

function HandBookCharacterView:getFirstPageLeftHeroNum()
	return math.max(0, self:getFirstPageHeroNum() - 4)
end

function HandBookCharacterView:getFirstPageHeroNum()
	if self:_isAllHeroType() then
		return 7
	end

	return 4
end

function HandBookCharacterView:_isAllHeroType()
	return self.heroType == HandbookEnum.HeroType.AllHero
end

function HandBookCharacterView:onDragBeginHandle(param, pointerEventData)
	self.startDragPosX = pointerEventData.position.x
end

function HandBookCharacterView:onDragEndHandle(param, pointerEventData)
	local endDragPosX = pointerEventData.position.x

	if math.abs(endDragPosX - self.startDragPosX) > HandBookCharacterView.DragAbsPositionX then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_screenplay_photo_click)

		if endDragPosX < self.startDragPosX then
			self:rightPageOnClick()
			self:onClickCloseTipBtn()
		else
			self:leftPageOnClick()
			self:onClickCloseTipBtn()
		end
	end
end

function HandBookCharacterView:_playCloseViewAnim()
	if self.currentPage == 1 then
		self._coverAnim:Play(UIAnimationName.Close, 0, 0)
	end

	self._containerAnim:Play(UIAnimationName.Close)
	self._gohumantipAnimtor:Play(UIAnimationName.Close)
	CharacterSearchFilterModel.instance:exitParentView()
	gohelper.setActive(self._gohumansubtip, false)
	gohelper.setActive(self._gotipclose, false)
end

function HandBookCharacterView:onClose()
	self._simagebg:UnLoadImage()
	self._simageline:UnLoadImage()
	self._simagecoverbg2:UnLoadImage()
	self._simagecoverbg1peper1:UnLoadImage()
	self._simagecoverbg1peper2:UnLoadImage()
	CharacterSearchFilterModel.instance:exitParentView()
end

function HandBookCharacterView:onDestroyView()
	self._leftArrowClick:RemoveClickListener()
	self._rightArrowClick:RemoveClickListener()
	self._coverRightArrowClick:RemoveClickListener()

	for k, v in ipairs(self.characterClickTabs) do
		v:RemoveClickListener()
	end

	if self._drag then
		self._drag:RemoveDragBeginListener()
		self._drag:RemoveDragEndListener()
	end

	self.removeEventCb(self, HandbookController.instance, HandbookController.EventName.OnShowSubCharacterView, self.reallyOpenView, self)
	self.removeEventCb(self, HandbookController.instance, HandbookController.EventName.PlayCharacterSwitchCloseAnim, self._playCloseViewAnim, self)
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.FilterBackpack, self._onFilterList, self)
	self._simagecovericon:UnLoadImage()
end

return HandBookCharacterView
