-- chunkname: @modules/logic/rouge/view/RougeResultReportItem.lua

module("modules.logic.rouge.view.RougeResultReportItem", package.seeall)

local RougeResultReportItem = class("RougeResultReportItem", ListScrollCellExtend)

RougeResultReportItem.DefaultTitleImageUrl = "singlebg_lang/txt_rouge/enter/rouge_enter_titlebg.png"

function RougeResultReportItem:onInitView()
	self._simageredbg = gohelper.findChildSingleImage(self.viewGO, "#simage_redbg")
	self._simagegreenbg = gohelper.findChildSingleImage(self.viewGO, "#simage_greenbg")
	self._simagetitle = gohelper.findChildSingleImage(self.viewGO, "#simage_title")
	self._gotime = gohelper.findChild(self.viewGO, "#go_time")
	self._txttime = gohelper.findChildText(self.viewGO, "#go_time/#txt_time")
	self._godifficulty = gohelper.findChild(self.viewGO, "#go_difficulty")
	self._txtdifficulty = gohelper.findChildText(self.viewGO, "#go_difficulty/#txt_difficulty")
	self._gofaction = gohelper.findChild(self.viewGO, "#go_faction")
	self._imageTypeIcon = gohelper.findChildImage(self.viewGO, "#go_faction/#image_TypeIcon")
	self._txtTypeName = gohelper.findChildText(self.viewGO, "#go_faction/image_NameBG/#txt_TypeName")
	self._txtLv = gohelper.findChildText(self.viewGO, "#go_faction/#txt_Lv")
	self._imagePointIcon = gohelper.findChildImage(self.viewGO, "#go_faction/layout/#image_PointIcon")
	self._goherogroup = gohelper.findChild(self.viewGO, "#go_herogroup")
	self._goitem1 = gohelper.findChild(self.viewGO, "#go_herogroup/#go_item1")
	self._goitem2 = gohelper.findChild(self.viewGO, "#go_herogroup/#go_item2")
	self._goitem3 = gohelper.findChild(self.viewGO, "#go_herogroup/#go_item3")
	self._goitem4 = gohelper.findChild(self.viewGO, "#go_herogroup/#go_item4")
	self._goitem5 = gohelper.findChild(self.viewGO, "#go_herogroup/#go_item5")
	self._goitem6 = gohelper.findChild(self.viewGO, "#go_herogroup/#go_item6")
	self._goitem7 = gohelper.findChild(self.viewGO, "#go_herogroup/#go_item7")
	self._goitem8 = gohelper.findChild(self.viewGO, "#go_herogroup/#go_item8")
	self._godec = gohelper.findChild(self.viewGO, "#go_dec")
	self._godecred = gohelper.findChild(self.viewGO, "#go_dec/#go_dec_red")
	self._godecgreen = gohelper.findChild(self.viewGO, "#go_dec/#go_dec_green")
	self._txtdec = gohelper.findChildText(self.viewGO, "#go_dec/#txt_dec")
	self._btndetails = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_details")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeResultReportItem:addEvents()
	self._btndetails:AddClickListener(self._btndetailsOnClick, self)
end

function RougeResultReportItem:removeEvents()
	self._btndetails:RemoveClickListener()
end

function RougeResultReportItem:_btndetailsOnClick()
	local params = {
		showNavigate = true,
		reviewInfo = self._mo
	}

	RougeController.instance:openRougeResultReView(params)
end

function RougeResultReportItem:_editableInitView()
	return
end

function RougeResultReportItem:_editableAddEvents()
	return
end

function RougeResultReportItem:_editableRemoveEvents()
	return
end

function RougeResultReportItem:onUpdateMO(reviewInfo)
	self._mo = reviewInfo

	self:refreshEnding(reviewInfo)
	self:refreshStyleInfo(reviewInfo)
	self:refreshPlayerInfo(reviewInfo)
	self:refreshBaseInfo(reviewInfo)
	self:refreshHeroGroup(reviewInfo)
	self:refreshTitle(reviewInfo)

	self._txtdec.text = RougeResultReView.refreshEndingDesc(reviewInfo)

	local isSucc = reviewInfo:isSucceed()

	gohelper.setActive(self._godecgreen, isSucc)
	gohelper.setActive(self._godecred, not isSucc)
	gohelper.setActive(self._simagegreenbg, isSucc)
	gohelper.setActive(self._simageredbg, not isSucc)

	if UnityEngine.Time.frameCount - RougeResultReportListModel.instance.startFrameCount < 10 then
		self._aniamtor = gohelper.onceAddComponent(self.viewGO, gohelper.Type_Animator)

		self._aniamtor:Play("open")
	end
end

function RougeResultReportItem:refreshHeroGroup(reviewInfo)
	if not self._heroItemList then
		self._heroItemList = self:getUserDataTb_()

		for i = 1, 8 do
			local go = self["_goitem" .. i]
			local iconRes = self._view.viewContainer._viewSetting.otherRes[2]
			local heroGo = self._view:getResInst(iconRes, go)
			local t = {}

			t.simagerolehead = gohelper.findChildSingleImage(heroGo, "#go_heroitem/#image_rolehead")
			t.frame = gohelper.findChild(heroGo, "#go_heroitem/frame")
			t.empty = gohelper.findChild(heroGo, "#go_heroitem/empty")
			self._heroItemList[i] = t
		end
	end

	for i, t in ipairs(self._heroItemList) do
		local heroLifeInfo = self._mo.teamInfo.heroLifeList[i]
		local showHero = heroLifeInfo ~= nil

		gohelper.setActive(t.simagerolehead, showHero)
		gohelper.setActive(t.frame, showHero)
		gohelper.setActive(t.empty, not showHero)

		if showHero then
			local heroId = heroLifeInfo and heroLifeInfo.heroId
			local skinCfg
			local heroMO = HeroModel.instance:getByHeroId(heroId)

			if heroMO then
				skinCfg = HeroModel.instance:getCurrentSkinConfig(heroId)
			else
				local heroCfg = HeroConfig.instance:getHeroCO(heroId)
				local skinId = heroCfg and heroCfg.skinId

				skinCfg = SkinConfig.instance:getSkinCo(skinId)
			end

			local heroIcon = skinCfg and skinCfg.headIcon

			t.simagerolehead:LoadImage(ResUrl.getHeadIconSmall(heroIcon))
		end
	end
end

function RougeResultReportItem:refreshEnding(reviewInfo)
	local endId = reviewInfo.endId
	local isWin = endId > 0

	gohelper.setActive(self._godecgreen, isWin)
	gohelper.setActive(self._godecred, not isWin)
	gohelper.setActive(self._simagegreenbg, isWin)
	gohelper.setActive(self._simageredbg, not isWin)
end

function RougeResultReportItem:refreshBaseInfo(reviewInfo)
	local season = reviewInfo.season
	local difficulty = reviewInfo.difficulty
	local difficultyCfg = lua_rouge_difficulty.configDict[season][difficulty]

	self._txtdifficulty.text = difficultyCfg and difficultyCfg.title
	self._txtLv.text = string.format("Lv.%s", reviewInfo.teamLevel)
end

function RougeResultReportItem:refreshPlayerInfo(reviewInfo)
	local finishTime = reviewInfo.finishTime / 1000

	self._txttime.text = TimeUtil.localTime2ServerTimeString(finishTime, "%Y.%m.%d %H:%M")

	local icon = ItemConfig.instance:getItemIconById(reviewInfo.portrait)
end

function RougeResultReportItem:refreshStyleInfo(reviewInfo)
	local season = reviewInfo.season
	local style = reviewInfo.style
	local styleCfg = lua_rouge_style.configDict[season][style]

	self._txtTypeName.text = styleCfg and styleCfg.name

	local styleIconName = styleCfg and styleCfg.icon

	if styleCfg then
		UISpriteSetMgr.instance:setRouge2Sprite(self._imageTypeIcon, string.format("%s_light", styleIconName))
		UISpriteSetMgr.instance:setRouge2Sprite(self._imagePointIcon, string.format("rouge_faction_smallicon_%s", styleCfg.id))
	end

	gohelper.setActive(self._gofaction, styleCfg ~= nil)
end

function RougeResultReportItem:refreshTitle(reviewInfo)
	local versions = reviewInfo:getVersions()
	local versionStr = RougeDLCHelper.versionListToString(versions)

	self._simagetitle:LoadImage(string.nilorempty(versionStr) and RougeResultReportItem.DefaultTitleImageUrl or ResUrl.getRougeDLCLangImage("logo_dlc_" .. versionStr))
end

function RougeResultReportItem:onSelect(isSelect)
	return
end

function RougeResultReportItem:onDestroyView()
	self._simagetitle:UnLoadImage()
end

return RougeResultReportItem
