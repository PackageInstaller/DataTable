-- chunkname: @modules/logic/versionactivity2_7/act191/view/Act191FetterTipView.lua

module("modules.logic.versionactivity2_7.act191.view.Act191FetterTipView", package.seeall)

local Act191FetterTipView = class("Act191FetterTipView", BaseView)

function Act191FetterTipView:onInitView()
	self._txtName = gohelper.findChildText(self.viewGO, "title/#txt_Name")
	self._imageIcon = gohelper.findChildImage(self.viewGO, "title/#image_Icon")
	self._scrollDetails = gohelper.findChildScrollRect(self.viewGO, "#scroll_Details")
	self._goSpecDesc = gohelper.findChild(self.viewGO, "#scroll_Details/Viewport/Content/#go_SpecDesc")
	self._goUseTime = gohelper.findChild(self.viewGO, "#scroll_Details/Viewport/Content/#go_SpecDesc/#go_UseTime")
	self._txtUseTime = gohelper.findChildText(self.viewGO, "#scroll_Details/Viewport/Content/#go_SpecDesc/#go_UseTime/txt_title/#txt_UseTime")
	self._txtSpecDesc = gohelper.findChildText(self.viewGO, "#scroll_Details/Viewport/Content/#go_SpecDesc/#txt_SpecDesc")
	self._txtDesc = gohelper.findChildText(self.viewGO, "#scroll_Details/Viewport/Content/#txt_Desc")
	self._goFetterDesc = gohelper.findChild(self.viewGO, "#scroll_Details/Viewport/Content/#go_FetterDesc")
	self._scrollHeros = gohelper.findChildScrollRect(self.viewGO, "#scroll_Heros")
	self._goHeroItem = gohelper.findChild(self.viewGO, "#scroll_Heros/Viewport/Content/#go_HeroItem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act191FetterTipView:addEvents()
	return
end

function Act191FetterTipView:removeEvents()
	return
end

function Act191FetterTipView:onClickModalMask()
	AudioMgr.instance:trigger(AudioEnum2_7.Act191.play_ui_yuzhou_dqq_panel_close)
	self:closeThis()
end

function Act191FetterTipView:_editableInitView()
	gohelper.setActive(self._goSpecDesc, false)

	self.actId = Activity191Model.instance:getCurActId()

	SkillHelper.addHyperLinkClick(self._txtDesc, Activity191Helper.clickHyperLinkSkill)
end

function Act191FetterTipView:onOpen()
	Act191StatController.instance:onViewOpen(self.viewName)

	self.activeLvl = 0
	self.tag = self.viewParam.tag
	self.fetterCoList = Activity191Config.instance:getRelationCoList(self.tag)

	local simpleCo = self.fetterCoList[0]

	self._txtName.text = simpleCo.name

	Activity191Helper.setFetterIcon(self._imageIcon, simpleCo.icon)

	local fetterDesc

	if self.viewParam.isFight then
		self.activeCnt = self.viewParam.count or 0

		for _, co in ipairs(self.fetterCoList) do
			local go = gohelper.cloneInPlace(self._goFetterDesc)
			local txtDesc = gohelper.findChildText(go, "")

			SkillHelper.addHyperLinkClick(txtDesc, Activity191Helper.clickHyperLinkSkill)

			local desc = SkillHelper.addLink(co.levelDesc)

			desc = Activity191Helper.buildDesc(desc, Activity191Enum.HyperLinkPattern.SkillDesc)

			if self.activeCnt >= co.activeNum then
				if self.activeLvl < co.level then
					self.activeLvl = co.level
				end

				txtDesc.text = string.format("<color=#9c8052>（%d/%d）%s</color>", self.activeCnt, co.activeNum, desc)
			else
				txtDesc.text = string.format("（<color=#ad2319>%d</color>/%d）%s", self.activeCnt, co.activeNum, desc)
			end

			self:_fixHeight(txtDesc)
		end

		gohelper.setActive(self._goFetterDesc, false)
		gohelper.setActive(self._scrollHeros, false)
		recthelper.setHeight(self._scrollDetails.gameObject.transform, 647)

		fetterDesc = string.gsub(self.fetterCoList[self.activeLvl].desc, "（(.-)）", "")
		fetterDesc = SkillHelper.addLink(fetterDesc)
		fetterDesc = Activity191Helper.buildDesc(fetterDesc, Activity191Enum.HyperLinkPattern.SkillDesc)
		self._txtDesc.text = fetterDesc

		return
	end

	self.gameInfo = Activity191Model.instance:getActInfo():getGameInfo()

	if self.viewParam.isPreview then
		for _, co in ipairs(self.fetterCoList) do
			local go = gohelper.cloneInPlace(self._goFetterDesc)
			local txtDesc = gohelper.findChildText(go, "")

			SkillHelper.addHyperLinkClick(txtDesc, Activity191Helper.clickHyperLinkSkill)

			local desc = SkillHelper.addLink(co.levelDesc)

			desc = Activity191Helper.buildDesc(desc, Activity191Enum.HyperLinkPattern.SkillDesc)
			txtDesc.text = string.format("<color=#9c8052>（%d）%s</color>", co.activeNum, desc)

			self:_fixHeight(txtDesc)
		end

		self.fetterHeroList = Activity191Config.instance:getFetterHeroList(self.tag, self.actId)
		fetterDesc = string.gsub(self.fetterCoList[0].desc, "（(.-)）", "")
	elseif self.viewParam.isEnemy then
		local matchMo = self.gameInfo:getNodeDetailMo().matchInfo

		self.fetterHeroList = matchMo:getFetterHeroList(self.tag)

		local fetterCntDic = matchMo:getTeamFetterCntDic()

		self.activeCnt = fetterCntDic[self.tag] or 0

		for _, co in ipairs(self.fetterCoList) do
			local go = gohelper.cloneInPlace(self._goFetterDesc)
			local txtDesc = gohelper.findChildText(go, "")

			SkillHelper.addHyperLinkClick(txtDesc, Activity191Helper.clickHyperLinkSkill)

			local desc = SkillHelper.addLink(co.levelDesc)

			desc = Activity191Helper.buildDesc(desc, Activity191Enum.HyperLinkPattern.SkillDesc)

			if self.activeCnt >= co.activeNum then
				if self.activeLvl < co.level then
					self.activeLvl = co.level
				end

				txtDesc.text = string.format("<color=#9c8052>（%d/%d）%s</color>", self.activeCnt, co.activeNum, desc)
			else
				txtDesc.text = string.format("（<color=#ad2319>%d</color>/%d）%s", self.activeCnt, co.activeNum, desc)
			end

			self:_fixHeight(txtDesc)
		end

		fetterDesc = string.gsub(self.fetterCoList[0].desc, "（(.-)）", "")
	else
		local specDesc = simpleCo.specDesc

		if not string.nilorempty(specDesc) then
			gohelper.setActive(self._goUseTime, simpleCo.tag == Activity191Enum.GreenDeer)

			self._txtUseTime.text = self.gameInfo:getSkillCount(Activity191Enum.GreenDeerSkillIds)
			self._txtSpecDesc.text = specDesc

			gohelper.setActive(self._goSpecDesc, true)
		end

		self.fetterHeroList = self.gameInfo:getFetterHeroList(self.tag)

		local fetterCntDic = self.gameInfo:getTeamFetterCntDic()

		self.activeCnt = fetterCntDic[self.tag] or 0

		for _, co in ipairs(self.fetterCoList) do
			local go = gohelper.cloneInPlace(self._goFetterDesc)
			local txtDesc = gohelper.findChildText(go, "")

			SkillHelper.addHyperLinkClick(txtDesc, Activity191Helper.clickHyperLinkSkill)

			local desc = SkillHelper.addLink(co.levelDesc)

			desc = Activity191Helper.buildDesc(desc, Activity191Enum.HyperLinkPattern.SkillDesc)

			if self.activeCnt >= co.activeNum then
				if self.activeLvl < co.level then
					self.activeLvl = co.level
				end

				txtDesc.text = string.format("<color=#9c8052>（%d/%d）%s</color>", self.activeCnt, co.activeNum, desc)
			else
				txtDesc.text = string.format("（<color=#ad2319>%d</color>/%d）%s", self.activeCnt, co.activeNum, desc)
			end

			self:_fixHeight(txtDesc)
		end

		local relationCo = self.fetterCoList[self.activeLvl]

		fetterDesc = self.gameInfo:getRelationDesc(relationCo)
	end

	fetterDesc = SkillHelper.addLink(fetterDesc)
	fetterDesc = Activity191Helper.buildDesc(fetterDesc, Activity191Enum.HyperLinkPattern.SkillDesc)
	self._txtDesc.text = fetterDesc

	gohelper.setActive(self._goFetterDesc, false)
	self:refreshHeroHead()
end

function Act191FetterTipView:onClose()
	local manual = self.viewContainer:isManualClose()

	Act191StatController.instance:statViewClose(self.viewName, manual, self.fetterCoList[0].name)
end

function Act191FetterTipView:refreshHeroHead()
	local param = {
		noClick = true,
		noFetter = true
	}

	for _, data in ipairs(self.fetterHeroList) do
		local parent = gohelper.cloneInPlace(self._goHeroItem)
		local go = self:getResInst(Activity191Enum.PrefabPath.HeroHeadItem, parent)
		local item = MonoHelper.addNoUpdateLuaComOnceToGo(go, Act191HeroHeadItem, param)

		item:setData(nil, data.config.id)

		if data.inBag == 0 then
			item:setNotOwn()
		elseif data.inBag == 2 then
			item:setActivation(true)
		end
	end

	self._scrollHeros.horizontalNormalizedPosition = 0

	gohelper.setActive(self._goHeroItem, false)
end

function Act191FetterTipView:_fixHeight(textComp)
	local fixTmp = MonoHelper.addNoUpdateLuaComOnceToGo(textComp.gameObject, FixTmpBreakLine)

	fixTmp:refreshTmpContent(textComp)
end

return Act191FetterTipView
