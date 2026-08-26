-- chunkname: @modules/logic/rouge2/backpack/view/Rouge2_CommonSkillItem.lua

module("modules.logic.rouge2.backpack.view.Rouge2_CommonSkillItem", package.seeall)

local Rouge2_CommonSkillItem = class("Rouge2_CommonSkillItem", LuaCompBase)

function Rouge2_CommonSkillItem.Get(go)
	return MonoHelper.addNoUpdateLuaComOnceToGo(go, Rouge2_CommonSkillItem)
end

Rouge2_CommonSkillItem.PercentColor = "#B84E32"
Rouge2_CommonSkillItem.BracketColor = "#245AC8"
Rouge2_CommonSkillItem.IncludeDescType_OnlyLevelUp = {
	Rouge2_Enum.RelicsDescType.LevelUp
}

function Rouge2_CommonSkillItem:init(go)
	self.go = go
	self._simageBg = gohelper.findChildSingleImage(self.go, "root/BG_dissolve")
	self._simageBg2 = gohelper.findChildSingleImage(self.go, "root/BG/image_BG")
	self._scrollContent = gohelper.findChild(self.go, "root/#scroll_Content"):GetComponent(typeof(ZProj.LimitedScrollRect))
	self._goIcon = gohelper.findChild(self.go, "root/#scroll_Content/Viewport/Content/Header/#go_Icon")
	self._goLevel = gohelper.findChild(self.go, "root/#scroll_Content/Viewport/Content/Level")
	self._btnDetail = gohelper.findChildButtonWithAudio(self.go, "root/#scroll_Content/Viewport/Content/Level/#btn_Detail")
	self._goConditionList = gohelper.findChild(self.go, "root/#scroll_Content/Viewport/Content/Level/#go_ConditionList")
	self._goConditionItem = gohelper.findChild(self.go, "root/#scroll_Content/Viewport/Content/Level/#go_ConditionList/#go_ConditionItem")
	self._goLevelUp = gohelper.findChild(self.go, "root/#scroll_Content/Viewport/Content/Desc/#go_LevelUp")
	self._txtLevelUp = gohelper.findChildText(self.go, "root/#scroll_Content/Viewport/Content/Desc/#go_LevelUp/#txt_LevelUp")
	self._goNewReddot = gohelper.findChild(self.go, "root/#scroll_Content/Viewport/Content/Desc/#go_LevelUp/#txt_LevelUp/#go_NewReddot")
	self._txtDesc = gohelper.findChildText(self.go, "root/#scroll_Content/Viewport/Content/Desc/#txt_Desc")
	self._btnClick = gohelper.getClickWithDefaultAudio(self.go)
	self._btnClick2 = gohelper.findChildClickWithDefaultAudio(self.go, "root/#scroll_Content/Viewport")
	self._goReddot = gohelper.findChild(self.go, "root/#go_Reddot")
	self._goSelect = gohelper.findChild(self.go, "root/#go_Select")
	self._goTrialTips = gohelper.findChild(self.go, "root/#go_TrialTips")
	self._txtTrialTips = gohelper.findChildText(self.go, "root/#go_TrialTips/#txt_TrialTips")
	self._goRecommend = gohelper.findChild(self.go, "root/#go_Recommend")
	self._goFightPower = gohelper.findChild(self.go, "root/#scroll_Content/Viewport/Content/Desc/#go_Effect")
	self._goFightPowerItem = gohelper.findChild(self._goFightPower, "go_pointLayout/go_item")

	gohelper.setActive(self._goFightPowerItem, false)

	self._animator = SLFramework.AnimatorPlayer.Get(self.go)

	gohelper.setActive(self._goReddot, false)
	gohelper.setActive(self._goSelect, false)

	self._listener = Rouge2_CommonItemDescModeListener.Get(self.go)

	self._listener:initCallback(self.refreshItemDesc, self)

	self._teamTipsParam = {}
	self._teamTipsLoader = Rouge2_TeamRecommendTipsLoader.Load(self._goRecommend, Rouge2_Enum.TeamRecommendTipType.ItemRecommend)
	self._commonIconItem = Rouge2_CommonSkillIconItem.Get(self._goIcon, Rouge2_Enum.CommonSkillIconType.Type_2)

	self:initEffectTab()
	self:onSelect(false)
end

function Rouge2_CommonSkillItem:addEventListeners()
	self._btnDetail:AddClickListener(self._btnDetailOnClick, self)
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
	self._btnClick2:AddClickListener(self._btnClickOnClick, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.OnSelectDropSkillItem, self._onSelectDropSkillItem, self)
end

function Rouge2_CommonSkillItem:removeEventListeners()
	self._btnDetail:RemoveClickListener()
	self._btnClick:RemoveClickListener()
	self._btnClick2:RemoveClickListener()
end

function Rouge2_CommonSkillItem:_btnDetailOnClick()
	if not self._detailClickCallback then
		if not self._detailClickCallbackObj then
			-- block empty
		end
	end
end

function Rouge2_CommonSkillItem:_defaultDetailClickCallback(dataType, dataId)
	local params = {
		dataType = dataType,
		dataIdList = {
			dataId
		},
		selectSkillDataId = dataId,
		showTabList = {
			Rouge2_Enum.AttrDetailTabGroupType.SkillList
		}
	}

	Rouge2_ViewHelper.openAttributeDetailView(nil, nil, params)
end

function Rouge2_CommonSkillItem:_btnClickOnClick()
	if self._clickCallback then
		self._clickCallback(self._clickCallbackObj)
	end
end

function Rouge2_CommonSkillItem:initClickCallback(clickCallback, clickCallbackObj)
	self._clickCallback = clickCallback
	self._clickCallbackObj = clickCallbackObj
end

function Rouge2_CommonSkillItem:initDetailClickCallback(clickCallback, clickCallbackObj)
	self._detailClickCallback = clickCallback
	self._detailClickCallbackObj = clickCallbackObj
end

function Rouge2_CommonSkillItem:setParentScroll(goParentScroll)
	self._scrollContent.parentGameObject = goParentScroll
end

function Rouge2_CommonSkillItem:getReddotGo()
	return self._goReddot
end

function Rouge2_CommonSkillItem:initDescModeFlag(descModeFlag)
	self._listener:setDataFlag(descModeFlag)
end

function Rouge2_CommonSkillItem:initEffectTab()
	self._effectTab = self:getUserDataTb_()

	for i = 1, math.huge do
		local goEffect = gohelper.findChild(self.go, "root/BG/#vx_" .. i)

		if gohelper.isNil(goEffect) then
			return
		end

		self._effectTab[i] = goEffect

		gohelper.setActive(goEffect, false)
	end
end

function Rouge2_CommonSkillItem:onUpdateMO(index, viewType, dataType, dataId)
	self._index = index
	self._viewType = viewType
	self._dataType = dataType
	self._dataId = dataId

	self._commonIconItem:onUpdateMO(self._dataType, self._dataId)

	self._skillCo = Rouge2_BackpackHelper.getItemCofigAndMo(dataType, dataId)
	self._skillId = self._skillCo and self._skillCo.id
	self._isSelect = false

	self:refreshUI()
end

function Rouge2_CommonSkillItem:refreshUI()
	self._listener:startListen()

	self._teamTipsParam[Rouge2_Enum.TeamRecommendParam.ItemId] = self._skillId

	self._teamTipsLoader:initInfo(nil, self._teamTipsParam)
	gohelper.setActive(self._goSelect, self._isSelect)
	Rouge2_IconHelper.setGameItemRare(self._skillId, self._simageBg, Rouge2_Enum.ItemRareIconType.Bg)
	Rouge2_IconHelper.setGameItemRare(self._skillId, self._simageBg2, Rouge2_Enum.ItemRareIconType.Bg)
	self:refreshEffect()
	self:refreshTrialHero()
	self:refreshAttrUpdateList()
	self:refreshFightPowerActive()
end

function Rouge2_CommonSkillItem:refreshEffect()
	if self._skillCo then
		for i, goEffect in pairs(self._effectTab) do
			gohelper.setActive(goEffect, i == self._skillCo)
		end
	end
end

function Rouge2_CommonSkillItem:refreshTrialHero()
	if self._viewType ~= Rouge2_MapEnum.ItemDropViewEnum.Select then
		gohelper.setActive(self._goTrialTips, false)

		return
	end

	local trialInfoList = Rouge2_CollectionConfig.instance:getTrialHeroListBySkillId(self._skillId)
	local hasTrialHero = trialInfoList and #trialInfoList > 0

	gohelper.setActive(self._goTrialTips, hasTrialHero)

	if not hasTrialHero then
		return
	end

	local heroNameList = {}

	for _, trialInfo in ipairs(trialInfoList) do
		local trialId = trialInfo[1]

		if not trialInfo[2] then
			local templateId = 0
			local trialCo = lua_hero_trial.configDict[trialId][templateId]
			local heroId = trialCo and trialCo.heroId
			local heroCo = HeroConfig.instance:getHeroCO(heroId)
			local heroName = heroCo and heroCo.name

			table.insert(heroNameList, heroName)
		end
	end

	local splitChar = luaLang("room_levelup_init_and1")
	local allHeroNameStr = table.concat(heroNameList, splitChar)

	self._txtTrialTips.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("rouge2_activeskilldropview_trialhero"), allHeroNameStr)
end

function Rouge2_CommonSkillItem:refreshAttrUpdateList()
	if self._viewType == Rouge2_MapEnum.ItemDropViewEnum.FightTip then
		gohelper.setActive(self._goLevel, false)

		return
	end

	local updateAttrList = Rouge2_CollectionConfig.instance:getMaxSkillUpdateAttrList(self._skillId)

	gohelper.CreateObjList(self, self._refreshAttrItem, updateAttrList, self._goConditionList, self._goConditionItem)
end

function Rouge2_CommonSkillItem:_refreshAttrItem(goItem, conditionInfo, index)
	local imageAttrIcon = gohelper.findChildImage(goItem, "image_AttrIcon")
	local txtPreLv = gohelper.findChildText(goItem, "txt_PreLv")
	local txtNextLv = gohelper.findChildText(goItem, "txt_NextLv")
	local attrId = conditionInfo[1]
	local attrValue = conditionInfo[2]
	local curAttrValue = Rouge2_Model.instance:getAttrValue(attrId) or 0

	txtPreLv.text = curAttrValue
	txtNextLv.text = attrValue

	Rouge2_IconHelper.setAttributeIcon(attrId, imageAttrIcon)
	SLFramework.UGUI.GuiHelper.SetColor(txtPreLv, attrValue <= curAttrValue and "#73BE73" or "#D57E7E")
end

function Rouge2_CommonSkillItem:refreshItemDesc(descMode)
	Rouge2_ItemDescHelper.setItemDescStr(self._dataType, self._dataId, self._txtDesc, descMode, nil, Rouge2_CommonSkillItem.PercentColor, Rouge2_CommonSkillItem.BracketColor)

	if self._viewType == Rouge2_MapEnum.ItemDropViewEnum.LevelUp then
		local levelUpDesc = Rouge2_ItemDescHelper.getItemDescStr(self._dataType, self._dataId, descMode, Rouge2_CommonSkillItem.IncludeDescType_OnlyLevelUp)

		Rouge2_ItemDescHelper.buildAndSetDesc(self._txtLevelUp, levelUpDesc, Rouge2_CommonSkillItem.PercentColor, Rouge2_CommonSkillItem.BracketColor)
		gohelper.setActive(self._goLevelUp, not string.nilorempty(levelUpDesc))
	else
		gohelper.setActive(self._goLevelUp, false)
	end
end

function Rouge2_CommonSkillItem:refreshFightPowerActive()
	gohelper.setActive(self._goFightPower, self._viewType == Rouge2_MapEnum.ItemDropViewEnum.FightTip)
end

function Rouge2_CommonSkillItem:refreshFightPower(curPower, maxPower)
	if self._viewType ~= Rouge2_MapEnum.ItemDropViewEnum.FightTip then
		return
	end

	self.powerItemList = self.powerItemList or {}

	for i = 1, maxPower do
		local powerItem = self.powerItemList[i]

		if not powerItem then
			powerItem = self:getUserDataTb_()
			powerItem.go = gohelper.cloneInPlace(self._goFightPowerItem)
			powerItem.goLight = gohelper.findChild(powerItem.go, "light")

			table.insert(self.powerItemList, powerItem)
		end

		gohelper.setActive(powerItem.go, true)
		gohelper.setActive(powerItem.goLight, i <= curPower)
	end

	for i = maxPower + 1, #self.powerItemList do
		gohelper.setActive(self.powerItemList[i].go, false)
	end
end

function Rouge2_CommonSkillItem:onSelect(isSelect)
	if self._isSelect == isSelect then
		return
	end

	self._isSelect = isSelect

	gohelper.setActive(self._goSelect, isSelect)

	local animName = isSelect and "select" or "normal"

	self:playAnim(animName)
end

function Rouge2_CommonSkillItem:playAnim(animName, callback, callbackObj)
	if not self.go.activeInHierarchy then
		return
	end

	self._animator:Play(animName, callback or self._defaultOnPlayAnimDone, callbackObj or self)
end

function Rouge2_CommonSkillItem:_defaultOnPlayAnimDone()
	return
end

function Rouge2_CommonSkillItem:_onSelectDropSkillItem(index)
	self:onSelect(index == self._index)
end

function Rouge2_CommonSkillItem:onDestroy()
	return
end

return Rouge2_CommonSkillItem
