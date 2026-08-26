-- chunkname: @modules/logic/stresstip/view/StressTipView.lua

module("modules.logic.stresstip.view.StressTipView", package.seeall)

local StressTipView = class("StressTipView", BaseView)

function StressTipView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._scrollenemystress = gohelper.findChildScrollRect(self.viewGO, "#scroll_enemystress")
	self._goenemystressitem = gohelper.findChild(self.viewGO, "#scroll_enemystress/viewport/content/#go_enemystressitem")
	self._txttitle = gohelper.findChildText(self.viewGO, "#scroll_enemystress/viewport/content/#go_enemystressitem/layout/#txt_title")
	self._txtdec = gohelper.findChildText(self.viewGO, "#scroll_enemystress/viewport/content/#go_enemystressitem/#txt_dec")
	self._gorolestressitem = gohelper.findChild(self.viewGO, "#scroll_enemystress/viewport/content/#go_rolestressitem")
	self._herotiptxt = gohelper.findChildText(self.viewGO, "#scroll_enemystress/viewport/content/#go_rolestressitem/#txt_title")
	self._goroletip = gohelper.findChild(self.viewGO, "#go_rolestresstip")
	self._goroletiptxt = gohelper.findChildText(self.viewGO, "#go_rolestresstip/#txt_roletip")
	self._btnclosedetail = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_closetip")
	self._goclosetip = self._btnclosedetail.gameObject

	if self._editableInitView then
		self:_editableInitView()
	end
end

function StressTipView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnclosedetail:AddClickListener(self._btnclosedetailOnClick, self)
end

function StressTipView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnclosedetail:RemoveClickListener()
end

function StressTipView:_btncloseOnClick()
	self:closeThis()
end

function StressTipView:_btnclosedetailOnClick()
	gohelper.setActive(self._goclosetip, false)
	gohelper.setActive(self._goroletip, false)
end

function StressTipView:_editableInitView()
	gohelper.setActive(self._gorolestressitem, false)
	gohelper.setActive(self._goenemystressitem, false)
	gohelper.setActive(self._goclosetip, false)
	gohelper.setActive(self._goroletip, false)

	self.heroTipHyperLinkClick = gohelper.onceAddComponent(self._herotiptxt, typeof(ZProj.TMPHyperLinkClick))

	self.heroTipHyperLinkClick:SetClickListener(self.onClickHeroTip, self)

	self.enemyStressItemList = {}
	self.rectTrEnemy = self._scrollenemystress:GetComponent(gohelper.Type_RectTransform)
	self.rectTrViewGo = self.viewGO:GetComponent(gohelper.Type_RectTransform)
	self.rectRoleTip = self._goroletip:GetComponent(gohelper.Type_RectTransform)
	self.enemyScrollWidth = recthelper.getWidth(self.rectTrEnemy)
end

function StressTipView:onClickHeroTip(identityId)
	local identityCo = lua_stress_identity.configDict[tonumber(identityId)]

	if not identityCo then
		return
	end

	local title = string.format("<color=#d2c197>%s</color>", identityCo.name)

	self._goroletiptxt.text = title .. "\n" .. identityCo.desc

	gohelper.setActive(self._goclosetip, true)
	gohelper.setActive(self._goroletip, true)
	ZProj.UGUIHelper.RebuildLayout(self.rectRoleTip)

	local height = recthelper.getHeight(self.rectRoleTip)
	local anchorX = recthelper.getAnchorX(self.rectTrEnemy)
	local anchorY = recthelper.getAnchorY(self.rectTrEnemy)
	local intervalY = 10

	anchorY = anchorY + height + intervalY

	recthelper.setAnchor(self.rectRoleTip, anchorX, anchorY)
end

StressTipView.OpenEnum = {
	Act183 = 3,
	Hero = 2,
	Monster = 1
}

function StressTipView:onOpen()
	self.openEnum = self.viewParam.openEnum
	self.co = self.viewParam.co
	self.clickPosition = self.viewParam.clickPosition

	if self.openEnum == StressTipView.OpenEnum.Act183 then
		self:refreshAct183UI()

		return
	end

	self:refreshHero()
	self:refreshEnemy()
end

function StressTipView:refreshAct183UI()
	self.identityIdList = self.viewParam.identityIdList

	for _, stressItem in ipairs(self.enemyStressItemList) do
		gohelper.setActive(stressItem.go, false)
	end

	local index = 0

	for _, identity in ipairs(self.identityIdList) do
		local stressDict = StressConfig.instance:getStressDict(identity)

		if stressDict then
			for _, behaviour in ipairs(self.StressBehaviourList) do
				local behaviourStr = FightEnum.StressBehaviourString[behaviour]
				local stressList = stressDict[behaviourStr]

				if stressList then
					index = index + 1

					local enemyStressItem = self:getEnemyStressItem(index)

					gohelper.setActive(enemyStressItem.go, true)

					enemyStressItem.txtTitle.text = StressConfig.instance:getStressBehaviourName(behaviour)

					self:refreshEnemyDesc(enemyStressItem, stressList)
				end
			end
		else
			logError(string.format("压力表，身份类型 ： %s 不存在", identity))
		end
	end

	self:setRectTrLayout(self.rectTrEnemy)
end

StressTipView.StressBehaviourList = {
	FightEnum.StressBehaviour.Positive,
	FightEnum.StressBehaviour.Negative,
	FightEnum.StressBehaviour.Meltdown,
	FightEnum.StressBehaviour.Resolute,
	FightEnum.StressBehaviour.BaseAdd,
	FightEnum.StressBehaviour.BaseReduce,
	FightEnum.StressBehaviour.BaseResolute,
	FightEnum.StressBehaviour.BaseMeltdown
}

function StressTipView:refreshEnemy()
	for _, stressItem in ipairs(self.enemyStressItemList) do
		gohelper.setActive(stressItem.go, false)
	end

	local identity

	if self.openEnum == StressTipView.OpenEnum.Monster then
		local monsterTemplateCo = lua_monster_skill_template.configDict[self.co.skillTemplate]

		identity = monsterTemplateCo and monsterTemplateCo.identity
	else
		identity = FightNameUIStressMgr.HeroDefaultIdentityId
	end

	local stressDict = StressConfig.instance:getStressDict(identity)

	if not stressDict then
		logError(string.format("压力表，身份类型 ： %s 不存在", identity))

		return
	end

	local index = 0

	for _, behaviour in ipairs(self.StressBehaviourList) do
		local behaviourStr = FightEnum.StressBehaviourString[behaviour]
		local stressList = stressDict[behaviourStr]

		if stressList then
			index = index + 1

			local enemyStressItem = self:getEnemyStressItem(index)

			gohelper.setActive(enemyStressItem.go, true)

			enemyStressItem.txtTitle.text = StressConfig.instance:getStressBehaviourName(behaviour)

			self:refreshEnemyDesc(enemyStressItem, stressList)
		end
	end

	self:setRectTrLayout(self.rectTrEnemy)
end

function StressTipView:refreshEnemyDesc(enemyStressItem, stressList)
	local innerIndex = 0

	for _, stressCo in ipairs(stressList) do
		local stressRuleCo = lua_stress_rule.configDict[tonumber(stressCo.rule)]

		if stressRuleCo and stressRuleCo.isNoShow ~= 1 then
			innerIndex = innerIndex + 1

			local descItem = self:getEnemyStressDescItem(enemyStressItem, innerIndex)

			gohelper.setActive(descItem.goDesc, true)

			descItem.txtDesc.text = "<nobr>" .. SkillHelper.buildDesc(stressRuleCo.desc)
		end
	end

	if innerIndex < 1 then
		gohelper.setActive(enemyStressItem.go, false)
	else
		local descItemList = enemyStressItem.descItemList

		for i = innerIndex + 1, #descItemList do
			gohelper.setActive(descItemList[i].goDesc, false)
		end
	end
end

function StressTipView:refreshHero()
	gohelper.setActive(self._gorolestressitem, self.openEnum == StressTipView.OpenEnum.Hero)

	if self.openEnum ~= StressTipView.OpenEnum.Hero then
		return
	end

	local heroTip = StressConfig.instance:getHeroTip()
	local identityText = StressConfig.instance:getHeroIdentityText(self.co)

	heroTip = GameUtil.getSubPlaceholderLuaLangOneParam(heroTip, identityText)
	self._herotiptxt.text = heroTip
end

function StressTipView:getEnemyStressItem(index)
	if index <= #self.enemyStressItemList then
		return self.enemyStressItemList[index]
	end

	local enemyStressItem = self:getUserDataTb_()

	enemyStressItem.go = gohelper.cloneInPlace(self._goenemystressitem)
	enemyStressItem.txtTitle = gohelper.findChildText(enemyStressItem.go, "layout/#txt_title")
	enemyStressItem.descItemList = {}

	table.insert(self.enemyStressItemList, enemyStressItem)

	local descItem = self:getUserDataTb_()

	descItem.txtDesc = gohelper.findChildText(enemyStressItem.go, "#txt_dec")
	descItem.goDesc = descItem.txtDesc.gameObject

	SkillHelper.addHyperLinkClick(descItem.txtDesc, self.onClickDescHyperLink, self)
	table.insert(enemyStressItem.descItemList, descItem)

	return enemyStressItem
end

function StressTipView:getEnemyStressDescItem(enemyStressItem, index)
	local descItemList = enemyStressItem.descItemList

	if index <= #descItemList then
		return descItemList[index]
	end

	local srcGo = enemyStressItem.descItemList[1].goDesc
	local descItem = self:getUserDataTb_()

	descItem.goDesc = gohelper.cloneInPlace(srcGo)
	descItem.txtDesc = descItem.goDesc:GetComponent(gohelper.Type_TextMesh)

	SkillHelper.addHyperLinkClick(descItem.txtDesc, self.onClickDescHyperLink, self)
	table.insert(descItemList, descItem)

	return descItem
end

StressTipView.DefaultIntervalX = 10
StressTipView.MaxScrollHeight = 535

function StressTipView:setRectTrLayout(rectTr)
	local _, h = GameUtil.getViewSize()
	local isRight = GameUtil.checkClickPositionInRight(self.clickPosition)
	local anchorPosX, anchorPosY = recthelper.screenPosToAnchorPos2(self.clickPosition, self.rectTrViewGo)

	if isRight then
		anchorPosX = anchorPosX - StressTipView.DefaultIntervalX
	else
		local width = recthelper.getWidth(rectTr)

		anchorPosX = anchorPosX + width + StressTipView.DefaultIntervalX
	end

	recthelper.setAnchor(rectTr, anchorPosX, anchorPosY)

	local remainHeight = h - math.abs(anchorPosY)
	local height = math.min(StressTipView.MaxScrollHeight, remainHeight)

	recthelper.setHeight(rectTr, height)
end

function StressTipView:onClickDescHyperLink(effId, clickPosition)
	CommonBuffTipController.instance:openCommonTipViewWithCustomPosCallback(effId, self.setScrollPosCallback, self)
end

StressTipView.ScrollTipIntervalX = 10

function StressTipView:setScrollPosCallback(rectTrTipViewGo, rectTrScrollTip)
	local w, h = GameUtil.getViewSize()
	local halfW = w / 2
	local halfH = h / 2
	local anchorX = recthelper.getAnchorX(self.rectTrEnemy)
	local anchorY = recthelper.getAnchorY(self.rectTrEnemy)
	local remainWidth = w - math.abs(anchorX) - self.enemyScrollWidth - self.ScrollTipIntervalX
	local scrollTipWidth = recthelper.getWidth(rectTrScrollTip)
	local showLeft = scrollTipWidth <= remainWidth

	rectTrScrollTip.pivot = CommonBuffTipEnum.Pivot.Right
	anchorX = showLeft and remainWidth - halfW or halfW - math.abs(anchorX) + self.enemyScrollWidth + self.ScrollTipIntervalX
	anchorY = anchorY + halfH

	recthelper.setAnchor(rectTrScrollTip, anchorX, anchorY)
end

function StressTipView:onClose()
	return
end

function StressTipView:onDestroyView()
	return
end

return StressTipView
