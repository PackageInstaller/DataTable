-- chunkname: @modules/logic/versionactivity2_5/challenge/view/repress/Act183RepressView.lua

module("modules.logic.versionactivity2_5.challenge.view.repress.Act183RepressView", package.seeall)

local Act183RepressView = class("Act183RepressView", BaseView)
local NoneSelectHeroIndex = 0
local NoneSelectRuleIndex = 0
local DefaultSelectRuleIndex = 1

function Act183RepressView:onInitView()
	self._goheroitem = gohelper.findChild(self.viewGO, "root/herocontainer/#go_heroitem")
	self._goruleitem = gohelper.findChild(self.viewGO, "root/rules/#go_ruleitem")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_confirm")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Act183RepressView:addEvents()
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
end

function Act183RepressView:removeEvents()
	self._btnconfirm:RemoveClickListener()
end

function Act183RepressView:_btnconfirmOnClick()
	local hasSelectHero = self._selectHeroIndex ~= NoneSelectHeroIndex
	local hasSelectRule = self._selectRuleIndex ~= NoneSelectRuleIndex

	if hasSelectHero ~= hasSelectRule then
		return
	end

	if not hasSelectHero and not hasSelectRule then
		GameFacade.showMessageBox(MessageBoxIdDefine.Act183UnselectAnyRepress, MsgBoxEnum.BoxType.Yes_No, self._sendRpcToChooseRepress, nil, nil, self)

		return
	end

	self:_sendRpcToChooseRepress()
end

function Act183RepressView:_sendRpcToChooseRepress()
	Act183Controller.instance:tryChooseRepress(self._activityId, self._episodeId, self._selectRuleIndex, self._selectHeroIndex, function()
		self:closeThis()
	end, self)
end

function Act183RepressView:_editableInitView()
	return
end

function Act183RepressView:onUpdateParam()
	return
end

function Act183RepressView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.Act183_OpenRepressView)

	self._activityId = self.viewParam and self.viewParam.activityId
	self._episodeMo = self.viewParam and self.viewParam.episodeMo
	self._episodeId = self._episodeMo and self._episodeMo:getEpisodeId()
	self._fightResultMo = self.viewParam and self.viewParam.fightResultMo
	self._heroes = self._fightResultMo and self._fightResultMo:getHeroes()
	self._heroes = self._heroes or self._episodeMo:getHeroes()
	self._repressMo = self._episodeMo and self._episodeMo:getRepressMo()
	self._ruleDescs = Act183Config.instance:getEpisodeAllRuleDesc(self._episodeId)
	self._heroItemTab = self:getUserDataTb_()
	self._ruleItemTab = self:getUserDataTb_()
	self._hasRepress = self._repressMo:hasRepress() and not self._fightResultMo
	self._selectHeroIndex = self._hasRepress and self._repressMo:getHeroIndex() or NoneSelectHeroIndex
	self._selectRuleIndex = self._hasRepress and self._repressMo:getRuleIndex() or NoneSelectRuleIndex

	self:refreshHeroList()
	self:refreshRuleList()
end

function Act183RepressView:refreshHeroList()
	if not self._heroes then
		logError("编队数据为空")

		return
	end

	for index, heroMo in ipairs(self._heroes) do
		local heroItem = self:_getOrCreateHeroItem(index)
		local isSelect = self:_isSelectRepressHero(index)
		local heroInfo = heroMo:getHeroMo()

		heroItem.item:onUpdateMO(heroInfo)
		heroItem.item:setSelect(isSelect)
		heroItem.item:setNewShow(false)
		gohelper.setActive(heroItem.viewGO, true)
	end
end

function Act183RepressView:_getOrCreateHeroItem(index)
	local heroItem = self._heroItemTab[index]

	if not heroItem then
		heroItem = self:getUserDataTb_()
		heroItem.viewGO = gohelper.cloneInPlace(self._goheroitem, "heroitem_" .. index)
		heroItem.gopos = gohelper.findChild(heroItem.viewGO, "go_pos")
		heroItem.item = IconMgr.instance:getCommonHeroItem(heroItem.gopos)

		heroItem.item:setStyle_CharacterBackpack()

		heroItem.btnclick = gohelper.findChildButtonWithAudio(heroItem.viewGO, "btn_click")

		heroItem.btnclick:AddClickListener(self._onClickHeroItem, self, index)

		self._heroItemTab[index] = heroItem
	end

	return heroItem
end

function Act183RepressView:_onClickHeroItem(index)
	local isSelect = self:_isSelectRepressHero(index)

	self:_onSelectRepressHero(index, not isSelect)
end

function Act183RepressView:_isSelectRepressHero(heroIndex)
	return self._selectHeroIndex == heroIndex
end

function Act183RepressView:_onSelectRepressHero(heroIndex, isSelect)
	self._selectHeroIndex = isSelect and heroIndex or NoneSelectHeroIndex

	if isSelect and self._selectRuleIndex == NoneSelectRuleIndex then
		self._selectRuleIndex = DefaultSelectRuleIndex
	elseif not isSelect then
		self._selectRuleIndex = NoneSelectRuleIndex
	end

	self:refreshHeroList()
	self:refreshRuleList()
end

function Act183RepressView:releaseAllHeroItems()
	if self._heroItemTab then
		for _, heroItem in pairs(self._heroItemTab) do
			heroItem.btnclick:RemoveClickListener()
		end
	end
end

function Act183RepressView:refreshRuleList()
	for index, ruleDesc in ipairs(self._ruleDescs) do
		local ruleItem = self:_getOrCreateRuleItem(index)
		local isSelect = self:_isSelectRepressRule(index)

		ruleItem.txtdesc.text = HeroSkillModel.instance:skillDesToSpot(ruleDesc)

		gohelper.setActive(ruleItem.viewGO, true)
		gohelper.setActive(ruleItem.goselect, isSelect)
		gohelper.setActive(ruleItem.gorepress, isSelect)
		Act183Helper.setRuleIcon(self._episodeId, index, ruleItem.imageicon)
		ruleItem.animrepress:Play(isSelect and "in" or "idle", 0, 0)
	end
end

function Act183RepressView:_getOrCreateRuleItem(index)
	local ruleItem = self._ruleItemTab[index]

	if not ruleItem then
		ruleItem = self:getUserDataTb_()
		ruleItem.viewGO = gohelper.cloneInPlace(self._goruleitem, "ruleitem_" .. index)
		ruleItem.imageicon = gohelper.findChildImage(ruleItem.viewGO, "image_icon")
		ruleItem.gorepress = gohelper.findChild(ruleItem.viewGO, "image_icon/go_repress")
		ruleItem.animrepress = gohelper.onceAddComponent(ruleItem.gorepress, gohelper.Type_Animator)
		ruleItem.txtdesc = gohelper.findChildText(ruleItem.viewGO, "txt_desc")
		ruleItem.goselect = gohelper.findChild(ruleItem.viewGO, "go_select")
		ruleItem.btnclick = gohelper.findChildButtonWithAudio(ruleItem.viewGO, "btn_click")

		ruleItem.btnclick:AddClickListener(self._onClickRuleItem, self, index)

		self._ruleItemTab[index] = ruleItem
	end

	return ruleItem
end

function Act183RepressView:_onClickRuleItem(index)
	self:_onSelectRepressRule(index, true)
end

function Act183RepressView:releaseAllRuleItems()
	if self._ruleItemTab then
		for _, ruleItem in pairs(self._ruleItemTab) do
			ruleItem.btnclick:RemoveClickListener()
		end
	end
end

function Act183RepressView:_isSelectRepressRule(ruleIndex)
	return self._selectRuleIndex == ruleIndex
end

function Act183RepressView:_onSelectRepressRule(ruleIndex, isSelect)
	self._selectRuleIndex = isSelect and ruleIndex or NoneSelectRuleIndex

	if isSelect then
		self._selectHeroIndex = self._selectHeroIndex or NoneSelectHeroIndex
	end

	if isSelect and self._selectHeroIndex == NoneSelectHeroIndex then
		self._selectHeroIndex = 1
	end

	self:refreshRuleList()
	self:refreshHeroList()
end

function Act183RepressView:onClose()
	self:releaseAllHeroItems()
	self:releaseAllRuleItems()
end

function Act183RepressView:onDestroyView()
	return
end

return Act183RepressView
