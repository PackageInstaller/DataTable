-- chunkname: @modules/logic/meilanni/view/MeilanniBossInfoView.lua

module("modules.logic.meilanni.view.MeilanniBossInfoView", package.seeall)

local MeilanniBossInfoView = class("MeilanniBossInfoView", BaseView)

function MeilanniBossInfoView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._gobg = gohelper.findChild(self.viewGO, "#go_bg")
	self._txtbossname = gohelper.findChildText(self.viewGO, "#txt_bossname")
	self._btnpreview = gohelper.findChildButtonWithAudio(self.viewGO, "#txt_bossname/#btn_preview")
	self._simagebossicon = gohelper.findChildSingleImage(self.viewGO, "#simage_bossicon")
	self._scrollproperty = gohelper.findChildScrollRect(self.viewGO, "#scroll_property")
	self._gocontent = gohelper.findChild(self.viewGO, "#scroll_property/Viewport/#go_content")
	self._gopropertyitem = gohelper.findChild(self.viewGO, "#scroll_property/Viewport/#go_content/#go_propertyitem")
	self._txtgossipdesc = gohelper.findChildText(self.viewGO, "#txt_gossipdesc")
	self._btnclose1 = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close1")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MeilanniBossInfoView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnpreview:AddClickListener(self._btnpreviewOnClick, self)
	self._btnclose1:AddClickListener(self._btnclose1OnClick, self)
end

function MeilanniBossInfoView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnpreview:RemoveClickListener()
	self._btnclose1:RemoveClickListener()
end

function MeilanniBossInfoView:_btncloseOnClick()
	self:closeThis()
end

function MeilanniBossInfoView:_btnpreviewOnClick()
	EnemyInfoController.instance:openEnemyInfoViewByBattleId(self._battleId)
end

function MeilanniBossInfoView:_btnclose1OnClick()
	self:closeThis()
end

function MeilanniBossInfoView:_editableInitView()
	return
end

function MeilanniBossInfoView:onUpdateParam()
	return
end

function MeilanniBossInfoView:onOpen()
	self._mapId = self.viewParam.mapId
	self._mapInfo = MeilanniModel.instance:getMapInfo(self._mapId)
	self._mapConfig = lua_activity108_map.configDict[self._mapId]
	self._ruleGoList = self:getUserDataTb_()
	self._ruleGoThreatList = self:getUserDataTb_()
	self._showExcludeRules = self.viewParam.showExcludeRules

	if self._showExcludeRules then
		local rulesInfo = self.viewParam.rulesInfo

		self._oldRules = rulesInfo[1]
		self._newRules = rulesInfo[2]
	end

	self:_showBossDetail()

	if self._showExcludeRules then
		TaskDispatcher.runDelay(self._adjustScrollPos, self, 0.1)
		TaskDispatcher.runDelay(self._showExcludeRuleEffect, self, 1)
		TaskDispatcher.runDelay(self.closeThis, self, 2)
	end

	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_details_open)
end

function MeilanniBossInfoView:_adjustScrollPos()
	for i = #self._oldRules + 1, #self._newRules do
		local ruleId = self._newRules[i]
		local go = self._ruleGoList[ruleId]
		local siblingIndex = go.transform:GetSiblingIndex()

		if siblingIndex >= 2 then
			local posY = math.abs(recthelper.getAnchorY(go.transform))

			recthelper.setAnchorY(self._gocontent.transform, posY - 20)
		end
	end
end

function MeilanniBossInfoView:_showExcludeRuleEffect()
	for i = #self._oldRules + 1, #self._newRules do
		local ruleId = self._newRules[i]
		local go = self._ruleGoList[ruleId]

		self:_setGoExcludeRule(go, true)
		self:_addThreat(go, ruleId, true)
	end

	AudioMgr.instance:trigger(AudioEnum.Meilanni.play_ui_mln_delete_features)
end

function MeilanniBossInfoView:_showBossDetail()
	if self._isShowBossDetail then
		return
	end

	self._isShowBossDetail = true
	self._txtgossipdesc.text = self._mapConfig.enemyInfo

	local monsterIcon = self._mapConfig.monsterIcon

	self._simagebossicon:LoadImage(ResUrl.getMeilanniIcon(monsterIcon))

	local eventConfig = MeilanniConfig.instance:getLastEvent(self._mapId)
	local interactParam = GameUtil.splitString2(eventConfig.interactParam, true, "|", "#")
	local battleId

	for i, v in ipairs(interactParam) do
		if v[1] == MeilanniEnum.ElementType.Battle then
			battleId = v[2]

			break
		end
	end

	if not battleId then
		return
	end

	self._battleId = battleId

	local battleConfig = lua_battle.configDict[battleId]
	local additionRule = GameUtil.splitString2(battleConfig.additionRule, true, "|", "#")

	for i, v in ipairs(additionRule) do
		local ruleId = v[2]
		local ruleCo = lua_rule.configDict[ruleId]
		local go = gohelper.cloneInPlace(self._gopropertyitem)

		gohelper.setActive(go, true)

		local descTxt = gohelper.findChildText(go, "txt_desc")
		local nameTxt = gohelper.findChildText(go, "tag/image_bg/txt_namecn")

		descTxt.text = ruleCo.desc
		nameTxt.text = ruleCo.name
		self._ruleGoList[ruleId] = go

		local isExclude = self:_isExcludeRule(ruleId)

		self:_setGoExcludeRule(go, isExclude)

		if isExclude then
			gohelper.setAsLastSibling(go)
		else
			gohelper.setAsFirstSibling(go)
		end

		self:_addThreat(go, ruleId, isExclude)
	end

	local monsterId = MeilanniView.getMonsterId(battleId)

	if not monsterId then
		return
	end

	local monsterConfig = lua_monster.configDict[monsterId]

	self._txtbossname.text = monsterConfig.highPriorityName
end

function MeilanniBossInfoView:_addThreat(go, ruleId, isExclude)
	local threatItemTemplate = gohelper.findChild(go, "tag/image_bg/txt_namecn/threat/go_threatitem")
	local threat = self:_getThreatByRuleId(ruleId)

	if not self._ruleGoThreatList[go] then
		self._ruleGoThreatList[go] = self._ruleGoThreatList[go]

		for i = 1, threat do
			if not self._ruleGoThreatList[go][i] then
				local threatItem = gohelper.cloneInPlace(threatItemTemplate)

				self._ruleGoThreatList[go][i] = threatItem

				gohelper.setActive(threatItem, true)

				local icon = gohelper.findChildImage(threatItem, "icon")

				if isExclude then
					UISpriteSetMgr.instance:setMeilanniSprite(icon, self:_getThreatIcon(threat, false))
				else
					UISpriteSetMgr.instance:setMeilanniSprite(icon, self:_getThreatIcon(threat, true))
				end
			end
		end
	end
end

function MeilanniBossInfoView:_getThreatIcon(threat, enabled)
	if threat == 1 then
		return enabled and "bg_weixiezhi" or "bg_weixiezhi_dis"
	elseif threat == 2 then
		return enabled and "bg_weixiezhi_1" or "bg_weixiezhi_1_dis"
	else
		return enabled and "bg_weixiezhi_2" or "bg_weixiezhi_2_dis"
	end
end

function MeilanniBossInfoView:_getThreatByRuleId(ruleId)
	for k, v in pairs(lua_activity108_rule.configDict) do
		if string.find(v.rules, tostring(ruleId)) then
			return v.threat
		end
	end

	return 0
end

function MeilanniBossInfoView:_setGoExcludeRule(go, isExclude)
	local descTxt = gohelper.findChildText(go, "txt_desc")
	local nameTxt = gohelper.findChildText(go, "tag/image_bg/txt_namecn")

	ZProj.UGUIHelper.SetColorAlpha(nameTxt, isExclude and 0.45 or 1)
	ZProj.UGUIHelper.SetColorAlpha(descTxt, isExclude and 0.45 or 1)

	if not isExclude then
		return
	end

	local go_disable = gohelper.findChild(go, "txt_desc/go_disable")
	local go_disable_tag = gohelper.findChild(go, "tag/image_bg/go_disable")
	local tag = gohelper.findChildImage(go, "tag/image_bg")

	gohelper.setActive(go_disable, true)
	gohelper.setActive(go_disable_tag, true)
	UISpriteSetMgr.instance:setMeilanniSprite(tag, "bg_tuya_1")
end

function MeilanniBossInfoView:_isExcludeRule(ruleId)
	if self._oldRules then
		return tabletool.indexOf(self._oldRules, ruleId)
	end

	return self._mapInfo and self._mapInfo:isExcludeRule(ruleId)
end

function MeilanniBossInfoView:onClose()
	self._simagebossicon:UnLoadImage()
	TaskDispatcher.cancelTask(self.closeThis, self)
	TaskDispatcher.cancelTask(self._showExcludeRuleEffect, self)
	TaskDispatcher.cancelTask(self._adjustScrollPos, self)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_screenplay_photo_close)
end

function MeilanniBossInfoView:onDestroyView()
	return
end

return MeilanniBossInfoView
