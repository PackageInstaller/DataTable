-- chunkname: @modules/logic/towercompose/view/TowerComposeRoleView.lua

module("modules.logic.towercompose.view.TowerComposeRoleView", package.seeall)

local TowerComposeRoleView = class("TowerComposeRoleView", BaseView)

function TowerComposeRoleView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._btnsupportTips = gohelper.findChildButtonWithAudio(self.viewGO, "scroll_alllist/viewport/content/supportcontent/title/txt/#btn_supportTips")
	self._gosupportTipPos = gohelper.findChild(self.viewGO, "scroll_alllist/viewport/content/supportcontent/title/#go_supportTipPos")
	self._gosupportContent = gohelper.findChild(self.viewGO, "scroll_alllist/viewport/content/supportcontent/#go_supportContent")
	self._btnextraTips = gohelper.findChildButtonWithAudio(self.viewGO, "scroll_alllist/viewport/content/extraContent/title/txt/#btn_extraTips")
	self._goextraTipPos = gohelper.findChild(self.viewGO, "scroll_alllist/viewport/content/extraContent/title/#go_extraTipPos")
	self._goextraContent = gohelper.findChild(self.viewGO, "scroll_alllist/viewport/content/extraContent/#go_extraContent")
	self._goheroItem = gohelper.findChild(self.viewGO, "#go_heroItem")
	self._gotips = gohelper.findChild(self.viewGO, "#go_tips")
	self._txttipDesc = gohelper.findChildText(self.viewGO, "#go_tips/#txt_tipDesc")
	self._btncloseTip = gohelper.findChildButtonWithAudio(self.viewGO, "#go_tips/#btn_closeTip")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function TowerComposeRoleView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnsupportTips:AddClickListener(self._btnsupportTipsOnClick, self)
	self._btnextraTips:AddClickListener(self._btnextraTipsOnClick, self)
	self._btncloseTip:AddClickListener(self._btncloseTipOnClick, self)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.HeroUpdatePush, self.refreshUI, self)
end

function TowerComposeRoleView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnsupportTips:RemoveClickListener()
	self._btnextraTips:RemoveClickListener()
	self._btncloseTip:RemoveClickListener()
	self.removeEventCb(self, CharacterController.instance, CharacterEvent.HeroUpdatePush, self.refreshUI, self)
end

function TowerComposeRoleView:_btnsupportTipsOnClick()
	self:refreshTips(TowerComposeEnum.ConstId.SupportRoleDesc, self._gosupportTipPos)
	gohelper.setActive(self._gotips, true)
end

function TowerComposeRoleView:_btnextraTipsOnClick()
	self:refreshTips(TowerComposeEnum.ConstId.ExtraRoleDesc, self._goextraTipPos)
	gohelper.setActive(self._gotips, true)
end

function TowerComposeRoleView:_btncloseOnClick()
	self:closeThis()
end

function TowerComposeRoleView:_btncloseTipOnClick()
	gohelper.setActive(self._gotips, false)
end

function TowerComposeRoleView:_btnHeroItemOnClick(heroItem)
	if heroItem.canShow then
		if heroItem.trialHeroMo then
			CharacterController.instance:openCharacterView(heroItem.trialHeroMo)
		elseif heroItem.heroMo then
			CharacterController.instance:openCharacterView(heroItem.heroMo)
		end
	end
end

function TowerComposeRoleView:_editableInitView()
	gohelper.setActive(self._goheroItem, false)
	gohelper.setActive(self._gotips, false)

	self.supportHeroItemMap = self:getUserDataTb_()
	self.extraHeroItemMap = self:getUserDataTb_()
end

function TowerComposeRoleView:onUpdateParam()
	return
end

function TowerComposeRoleView:onOpen()
	self.curThemeId = self.viewParam.themeId

	local trialHeroList = TowerComposeConfig.instance:getThemeTrialHeroList(self.curThemeId)

	self.trialHeroCoDataList = TowerHeroTrialListModel.instance:getTrialHeroCoDataList(trialHeroList)

	self:refreshUI()
end

function TowerComposeRoleView:refreshUI()
	self:refreshSupportRole()
	self:refreshExtraRole()
end

function TowerComposeRoleView:refreshSupportRole()
	local supportHeroCoList = TowerComposeConfig.instance:getAllSupportCoList(self.curThemeId)
	local heroCoList = self:buildHeroCoList(supportHeroCoList, false)

	for _, coData in ipairs(heroCoList) do
		local heroItem = self:createHeroItem(self.supportHeroItemMap, self._goheroItem, self._gosupportContent, coData.config.heroId, coData.config, "supportItem")

		heroItem.btnClick:AddClickListener(self._btnHeroItemOnClick, self, heroItem)
		self:refreshRoleItem(heroItem)
	end
end

function TowerComposeRoleView:refreshExtraRole()
	local extraHeroCoList = TowerComposeConfig.instance:getAllExtraCoList(self.curThemeId)
	local heroCoList = self:buildHeroCoList(extraHeroCoList, true)

	for _, coData in ipairs(heroCoList) do
		local heroItem = self:createHeroItem(self.extraHeroItemMap, self._goheroItem, self._goextraContent, coData.config.id, coData.config, "extraItem")

		heroItem.btnClick:AddClickListener(self._btnHeroItemOnClick, self, heroItem)
		self:refreshRoleItem(heroItem, true)
	end
end

function TowerComposeRoleView:buildHeroCoList(heroCoList, isExtra)
	local newHeroCoList = {}

	for index, heroCo in ipairs(heroCoList) do
		local coData = {}

		coData.index = index
		coData.config = heroCo
		coData.heroConfig = HeroConfig.instance:getHeroCO((isExtra or nil) and (heroCo.id or heroCo.heroId))
		coData.canShow = self:checkCanShow((isExtra or nil) and (heroCo.id or heroCo.heroId))

		table.insert(newHeroCoList, coData)
	end

	table.sort(newHeroCoList, function(a, b)
		if a.canShow ~= b.canShow then
			return a.canShow
		elseif a.heroConfig.rare ~= b.heroConfig.rare then
			return a.heroConfig.rare > b.heroConfig.rare
		else
			return a.index < b.index
		end
	end)

	return newHeroCoList
end

function TowerComposeRoleView:checkCanShow(heroId)
	local heroMo = HeroModel.instance:getByHeroId(heroId)

	return heroMo ~= nil
end

function TowerComposeRoleView:refreshRoleItem(heroItem, isExtra)
	gohelper.setActive(heroItem.itemGO, true)

	local heroConfig = HeroConfig.instance:getHeroCO(heroItem.heroId)

	heroItem.heroMo = HeroModel.instance:getByHeroId(heroItem.heroId)
	heroItem.isExit = heroItem.heroMo ~= nil
	heroItem.canShow = heroItem.isExit

	if heroItem.isExit then
		heroItem.skinId = heroItem.heroMo.skin

		local showLevel, rank = HeroConfig.instance:getShowLevel(heroItem.heroMo.level)
		local tmpRank = rank - 1

		for index, rankItem in ipairs(heroItem.rankList) do
			gohelper.setActive(rankItem, index == tmpRank)
		end

		gohelper.setActive(heroItem.goRank, tmpRank > 0)
	else
		local characterCo = lua_character.configDict[heroItem.heroId]

		heroItem.skinId = characterCo.skinId

		gohelper.setActive(heroItem.goRank, false)
	end

	local skinConfig = SkinConfig.instance:getSkinCo(heroItem.skinId)

	heroItem.simageHeroIcon:LoadImage(ResUrl.getRoomHeadIcon(skinConfig.headIcon))

	heroItem.txtName.text = heroConfig.name
	heroItem.txtNameEn.text = heroConfig.nameEng

	UISpriteSetMgr.instance:setCommonSprite(heroItem.imageCareer, "lssx_" .. heroConfig.career)
	UISpriteSetMgr.instance:setCommonSprite(heroItem.imageRare, "bgequip" .. CharacterEnum.Color[heroConfig.rare])
	gohelper.setActive(heroItem.goAddNum, isExtra)

	heroItem.txtAddNum.text = isExtra and string.format("+%d", heroItem.config.bossPointBase) or ""

	self:setItemGray(heroItem)
	TaskDispatcher.runDelay(self.refreshRoleContent, self, 0.01)
end

function TowerComposeRoleView:createHeroItem(heroItemMap, itemGO, ContentGO, heroId, config, itemName)
	local heroItem = heroItemMap[heroId]

	if not heroItem then
		heroItem = {
			config = config,
			heroId = heroId,
			itemGO = gohelper.clone(itemGO, ContentGO, itemName .. heroId)
		}
		heroItem.imageRare = gohelper.findChildImage(heroItem.itemGO, "role/rare")
		heroItem.simageHeroIcon = gohelper.findChildSingleImage(heroItem.itemGO, "role/heroicon")
		heroItem.imageCareer = gohelper.findChildImage(heroItem.itemGO, "role/career")
		heroItem.txtName = gohelper.findChildText(heroItem.itemGO, "role/name")
		heroItem.txtNameEn = gohelper.findChildText(heroItem.itemGO, "role/name/nameEn")
		heroItem.goAddNum = gohelper.findChild(heroItem.itemGO, "addnum")
		heroItem.txtAddNum = gohelper.findChildText(heroItem.itemGO, "addnum/txt_num")
		heroItem.btnClick = gohelper.findChildButtonWithAudio(heroItem.itemGO, "btn_click")
		heroItem.goRank = gohelper.findChild(heroItem.itemGO, "role/Rank")
		heroItem.rankList = {}

		for rankLv = 1, 3 do
			heroItem.rankList[rankLv] = gohelper.findChild(heroItem.itemGO, "role/Rank/rank" .. rankLv)
		end

		heroItemMap[heroId] = heroItem
	end

	return heroItem
end

function TowerComposeRoleView:buildTrialHeroMo(heroId)
	for _, trialCoData in ipairs(self.trialHeroCoDataList) do
		if trialCoData.trialConfig.heroId == heroId then
			local trialHeroMo = HeroMo.New()

			trialHeroMo:initFromTrial(trialCoData.trialConfig.id)

			return trialHeroMo
		end
	end
end

function TowerComposeRoleView:refreshTips(constId, pos)
	self._txttipDesc.text = TowerComposeConfig.instance:getConstValue(constId, false, true)

	self._gotips.transform:SetParent(pos.transform)
	recthelper.setAnchor(self._gotips.transform, 0, 0)
end

function TowerComposeRoleView:setItemGray(heroItem)
	ZProj.UGUIHelper.SetGrayscale(heroItem.imageRare.gameObject, not heroItem.canShow)
	ZProj.UGUIHelper.SetGrayscale(heroItem.imageCareer.gameObject, not heroItem.canShow)
	ZProj.UGUIHelper.SetGrayscale(heroItem.simageHeroIcon.gameObject, not heroItem.canShow)
	ZProj.UGUIHelper.SetGrayscale(heroItem.goAddNum, not heroItem.canShow)
end

function TowerComposeRoleView:refreshRoleContent()
	gohelper.setActive(self._gosupportContent, false)
	gohelper.setActive(self._gosupportContent, true)
	gohelper.setActive(self._goextraContent, false)
	gohelper.setActive(self._goextraContent, true)
end

function TowerComposeRoleView:onClose()
	TaskDispatcher.cancelTask(self.refreshRoleContent, self)
end

function TowerComposeRoleView:onDestroyView()
	for _, heroItem in pairs(self.supportHeroItemMap) do
		heroItem.simageHeroIcon:UnLoadImage()
		heroItem.btnClick:RemoveClickListener()
	end

	for _, heroItem in pairs(self.extraHeroItemMap) do
		heroItem.simageHeroIcon:UnLoadImage()
		heroItem.btnClick:RemoveClickListener()
	end
end

return TowerComposeRoleView
