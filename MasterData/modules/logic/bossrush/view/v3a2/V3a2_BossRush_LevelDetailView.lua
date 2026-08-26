-- chunkname: @modules/logic/bossrush/view/v3a2/V3a2_BossRush_LevelDetailView.lua

module("modules.logic.bossrush.view.v3a2.V3a2_BossRush_LevelDetailView", package.seeall)

local V3a2_BossRush_LevelDetailView = class("V3a2_BossRush_LevelDetailView", BaseView)

function V3a2_BossRush_LevelDetailView:onInitView()
	self._simagefull = gohelper.findChildSingleImage(self.viewGO, "#simage_full")
	self._gospines = gohelper.findChild(self.viewGO, "#go_spines")
	self._simageMask = gohelper.findChildSingleImage(self.viewGO, "#simage_Mask")
	self._simageFrame = gohelper.findChildSingleImage(self.viewGO, "#simage_Frame")
	self._goAssessIcon = gohelper.findChild(self.viewGO, "Left/score/#go_AssessIcon")
	self._txtScoreNum = gohelper.findChildText(self.viewGO, "Left/score/#txt_ScoreNum")
	self._btnbonus = gohelper.findChildButtonWithAudio(self.viewGO, "Left/#btn_bonus")
	self._goRedPoint1 = gohelper.findChild(self.viewGO, "Left/#btn_bonus/#go_RedPoint1")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "DetailPanel/Title/title/#simage_Title")
	self._imageIssxIcon = gohelper.findChildImage(self.viewGO, "DetailPanel/Title/title/#simage_Title/#image_IssxIcon")
	self._txtEn = gohelper.findChildText(self.viewGO, "DetailPanel/Title/title/#simage_Title/#txt_Name/#txt_En")
	self._txtName = gohelper.findChildText(self.viewGO, "DetailPanel/Title/title/#simage_Title/#txt_Name")
	self._btnSearchIcon = gohelper.findChildButtonWithAudio(self.viewGO, "DetailPanel/Title/title/#btn_SearchIcon")
	self._scrolldesc = gohelper.findChildScrollRect(self.viewGO, "DetailPanel/#scroll_desc")
	self._txtDescr = gohelper.findChildText(self.viewGO, "DetailPanel/#scroll_desc/Viewport/#txt_Descr")
	self._gostrategy = gohelper.findChild(self.viewGO, "DetailPanel/#go_strategy")
	self._scrollstrategy = gohelper.findChildScrollRect(self.viewGO, "DetailPanel/#go_strategy/type/#scroll_strategy")
	self._scrollConditionIcons = gohelper.findChildScrollRect(self.viewGO, "DetailPanel/Condition/#scroll_ConditionIcons")
	self._btnadditionRuleclick = gohelper.findChildButtonWithAudio(self.viewGO, "DetailPanel/Condition/#scroll_ConditionIcons/#btn_additionRuleclick")
	self._goruletemp = gohelper.findChild(self.viewGO, "DetailPanel/Condition/#scroll_ConditionIcons/#go_ruletemp")
	self._imagetagicon = gohelper.findChildImage(self.viewGO, "DetailPanel/Condition/#scroll_ConditionIcons/#go_ruletemp/#image_tagicon")
	self._goresilience = gohelper.findChild(self.viewGO, "DetailPanel/#go_resilience")
	self._btnInfo = gohelper.findChildButtonWithAudio(self.viewGO, "DetailPanel/#go_resilience/Info/#btn_Info")
	self._txtresilienceValue = gohelper.findChildText(self.viewGO, "DetailPanel/#go_resilience/#txt_resilienceValue")
	self._gotips = gohelper.findChild(self.viewGO, "DetailPanel/#go_tips")
	self._txtdesc = gohelper.findChildText(self.viewGO, "DetailPanel/#go_tips/tipsbg/#txt_desc")
	self._btntipClose = gohelper.findChildButtonWithAudio(self.viewGO, "DetailPanel/#go_tips/#btn_tipClose")
	self._btnGo = gohelper.findChildButtonWithAudio(self.viewGO, "DetailPanel/#btn_Go")
	self._txtDoubleTimes = gohelper.findChildText(self.viewGO, "DetailPanel/#btn_Go/#txt_DoubleTimes")
	self._gorank = gohelper.findChild(self.viewGO, "DetailPanel/#go_rank")
	self._goweak = gohelper.findChild(self.viewGO, "DetailPanel/#go_weak")
	self._goweakicon = gohelper.findChild(self.viewGO, "DetailPanel/#go_weak/tipsbg/icon")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a2_BossRush_LevelDetailView:addEvents()
	self._btnbonus:AddClickListener(self._btnbonusOnClick, self)
	self._btnSearchIcon:AddClickListener(self._btnSearchIconOnClick, self)
	self._btnInfo:AddClickListener(self._btnInfoOnClick, self)
	self._btntipClose:AddClickListener(self._btntipCloseOnClick, self)
	self._btnGo:AddClickListener(self._btnGoOnClick, self)
	self.addEventCb(self, BossRushController.instance, BossRushEvent.onReceiveAct128GetExpReply, self.playRankBtnAnim, self)
end

function V3a2_BossRush_LevelDetailView:removeEvents()
	self._btnbonus:RemoveClickListener()
	self._btnSearchIcon:RemoveClickListener()
	self._btnadditionRuleclick:RemoveClickListener()
	self._btnInfo:RemoveClickListener()
	self._btntipClose:RemoveClickListener()
	self._btnGo:RemoveClickListener()
	self.removeEventCb(self, BossRushController.instance, BossRushEvent.onReceiveAct128GetExpReply, self.playRankBtnAnim, self)
end

function V3a2_BossRush_LevelDetailView:_btntipCloseOnClick()
	self:_showResilienceTip(false)
end

function V3a2_BossRush_LevelDetailView:_btnInfoOnClick()
	self:_showResilienceTip(true)
end

function V3a2_BossRush_LevelDetailView:_btnbonusOnClick()
	BossRushController.instance:openBonusView(self.viewParam)
end

function V3a2_BossRush_LevelDetailView:_btnSearchIconOnClick()
	local actId = BossRushConfig.instance:getActivityId()

	EnemyInfoController.instance:openBossRushEnemyInfoView(actId, self._stage, self._layer)
end

function V3a2_BossRush_LevelDetailView:_btnGoOnClick()
	BossRushController.instance:enterFightScene(self._stage, self._layer)
end

function V3a2_BossRush_LevelDetailView:_editableInitView()
	self._lurkInfoItems = self:getUserDataTb_()
	self._weakItems = self:getUserDataTb_()
	self._gomask = gohelper.findChild(self.viewGO, "mask")

	gohelper.setActive(self._txtdesc.gameObject, false)
	gohelper.setActive(self._gomask, false)
	self:_initAssessIcon()
end

function V3a2_BossRush_LevelDetailView:onUpdateParam()
	return
end

function V3a2_BossRush_LevelDetailView:onOpen()
	self._stage = self.viewParam.stage
	self._layer = 1
	self._stageCO = self.viewParam.stageCO
	self._activityId = self._stageCO.activityId
	self._handBookMo = V3a2_BossRushModel.instance:getHandBookMoByStage(self._stage, self._activityId)
	self._stageLayerInfos = BossRushModel.instance:getStageLayersInfo(self._stage, self._activityId)
	self._layerCO = self._stageLayerInfos[self._layer].layerCO

	self:_refreshMonster()
	self:_refreshRedDot()
	self:_refreshContent()
	self:_showResilienceTip(false)
end

function V3a2_BossRush_LevelDetailView:_initAssessIcon()
	local itemClass = V1a4_BossRush_AssessIcon
	local go = self.viewContainer:getResInst(BossRushEnum.ResPath.v1a4_bossrush_leveldetail_assessicon, self._goAssessIcon, itemClass.__cname)

	self._assessIcon = MonoHelper.addNoUpdateLuaComOnceToGo(go, itemClass)

	self._assessIcon:initData(self, false)
end

function V3a2_BossRush_LevelDetailView:_refreshMonster()
	local skinIdList = BossRushConfig.instance:getMonsterSkinIdList(self._stage, self._activityId)
	local skinScaleList = BossRushConfig.instance:getMonsterSkinScaleList(self._stage, self._activityId)
	local skinOffsetXYs = BossRushConfig.instance:getMonsterSkinOffsetXYs(self._stage, self._activityId)
	local heartVariantId = self._stageCO.heartVariantId

	self:_initMonsterSpines(#skinIdList)
	self:_refreshStrategy()

	for i, item in ipairs(self._uiSpineList) do
		local skinId = skinIdList[i]
		local scale = skinScaleList[i]
		local offsetXY = skinOffsetXYs[i]

		item:setData(skinId)
		item:setScale(scale)
		item:setOffsetXY(offsetXY[1], offsetXY[2])

		if heartVariantId and heartVariantId ~= 0 then
			item:settVariant(heartVariantId)
		end
	end
end

function V3a2_BossRush_LevelDetailView:_refreshStrategy()
	local strategy = BossRushConfig.instance:getBossRecommendStrategy(self._stageCO.type) or {}
	local content = self._scrollstrategy.content
	local resPath = BossRushEnum.ResPath.v3a2_bossrush_strategyitem
	local res = self.viewContainer:getRes(resPath)

	gohelper.CreateObjList(self, self._createStrategyCB, strategy, content.gameObject, res, V3a2_BossRush_StrategyItem)
end

function V3a2_BossRush_LevelDetailView:_createStrategyCB(obj, data, index)
	obj:refreshUI(data)
end

function V3a2_BossRush_LevelDetailView:_initMonsterSpines(skinCount)
	local itemClass = V1a4_BossRushLevelDetail_Spine

	if not self._uiSpineList or skinCount > #self._uiSpineList then
		self._uiSpineList = self._uiSpineList or {}

		local st = #self._uiSpineList + 1

		for i = st, skinCount do
			local go = self.viewContainer:getResInst(BossRushEnum.ResPath.v1a4_bossrushleveldetail_spine, self._gospines, itemClass.__name)

			self._uiSpineList[i] = MonoHelper.addNoUpdateLuaComOnceToGo(go, itemClass)
		end
	end
end

function V3a2_BossRush_LevelDetailView:_refreshRedDot()
	local defineId = RedDotEnum.DotNode.BossRushBossReward
	local uid = BossRushRedModel.instance:getUId(defineId, self._stage)

	RedDotController.instance:addRedDot(self._goRedPoint1, defineId, uid)
end

function V3a2_BossRush_LevelDetailView:_refreshContent()
	local layer = self._layerCO.layer
	local issxIconName = BossRushConfig.instance:getIssxIconName(self._stage, layer)
	local battleId = BossRushConfig.instance:getDungeonBattleId(self._stage, layer)

	UISpriteSetMgr.instance:setCommonSprite(self._imageIssxIcon, issxIconName)
	self._simagefull:LoadImage(BossRushConfig.instance:getBossDetailFullPath(self._stage, self._activityId))
	self:refreshScore()

	self._txtName.text = self._stageCO.name
	self._txtEn.text = self._stageCO.name_en

	if self._scrolldesc then
		self._scrolldesc.verticalNormalizedPosition = 1
	end

	self._txtDescr.text = self._layerCO.desc

	ZProj.UGUIHelper.RebuildLayout(self._txtDescr.transform)
	self._simageTitle:LoadImage(BossRushConfig.instance:getBossDetailTitlePath(self._stage, self._activityId))
	self:_doUpdateSelectIcon(battleId)
	self:_refreshLurk()
end

function V3a2_BossRush_LevelDetailView:refreshScore()
	local stageMo = V3a9_BossRushModel.instance:getStageMo(self._activityId, self._stage)

	if stageMo then
		if not stageMo.highestPoint then
			local highestPoint = 0

			self._assessIcon:setData(self._stage, highestPoint, false)

			self._txtScoreNum.text = BossRushConfig.instance:getScoreStr(highestPoint)
		end
	end
end

function V3a2_BossRush_LevelDetailView:_doUpdateSelectIcon(battleId)
	local ruleView = self.viewContainer:getBossRushViewRule()

	ruleView:refreshUI(battleId)
end

function V3a2_BossRush_LevelDetailView:_refreshLurk()
	local episodeId = self._layerCO.episodeId
	local concealCo = BossRushConfig.instance:getConcealCo(episodeId)
	local bossTypeParam = BossRushConfig.instance:getBossTypeParams(self._stageCO.type)
	local careerWeak = bossTypeParam and bossTypeParam.careerWeak
	local isConceal = concealCo and concealCo.maxConceal > 0 and (not careerWeak or #careerWeak <= 0)

	if isConceal then
		if concealCo then
			self._txtresilienceValue.text = concealCo.maxConceal or ""
		end

		local count = 0

		if not string.nilorempty(concealCo.spDesc) then
			local spDesc = string.split(concealCo.spDesc, "|")

			for i, desc in ipairs(spDesc) do
				local item = self:_getLurkInfoItem(i)

				item.txt.text = desc
			end

			count = #spDesc
		end

		for i = 1, #self._lurkInfoItems do
			gohelper.setActive(self._lurkInfoItems[i].go, i <= count)
		end
	else
		if not careerWeak then
			local monsterCO = BossRushConfig.instance:getMonsterCO(self._stage, self._layerCO.layer)

			if monsterCO and not string.nilorempty(monsterCO.career_weak) then
				careerWeak = tabletool.copy(string.splitToNumber(monsterCO.career_weak, "#"))
			end
		end

		if careerWeak then
			for i, weak in ipairs(careerWeak) do
				local item = self:_getWeekItem(i)
				local issxIconName = FightFailView.CareerToImageName[weak]

				UISpriteSetMgr.instance:setCommonSprite(item.icon, issxIconName, true)
			end
		end

		if careerWeak then
			if not #careerWeak then
				local count = 0

				for i = 1, #self._weakItems do
					gohelper.setActive(self._weakItems[i].go, i <= count)
				end
			end
		end
	end

	gohelper.setActive(self._goresilience, isConceal)
	gohelper.setActive(self._goweak, not isConceal)
	gohelper.setActive(self._imageIssxIcon.gameObject, isConceal)
end

function V3a2_BossRush_LevelDetailView:_getLurkInfoItem(index)
	local item = self._lurkInfoItems[index]

	if not item then
		item = self:getUserDataTb_()

		local go = gohelper.cloneInPlace(self._txtdesc.gameObject)

		item.go = go
		item.txt = go:GetComponent(gohelper.Type_TextMesh)
		self._lurkInfoItems[index] = item
	end

	return item
end

function V3a2_BossRush_LevelDetailView:_getWeekItem(index)
	local item = self._weakItems[index]

	if not item then
		item = self:getUserDataTb_()

		if index == 1 then
			if not self._goweakicon then
				local go = gohelper.cloneInPlace(self._goweakicon.gameObject)

				item.go = go
				item.icon = go:GetComponent(gohelper.Type_Image)
				self._weakItems[index] = item
			end
		end
	end

	return item
end

function V3a2_BossRush_LevelDetailView:_showResilienceTip(isShow)
	gohelper.setActive(self._gotips, isShow)
end

function V3a2_BossRush_LevelDetailView:playRankBtnAnim()
	return
end

function V3a2_BossRush_LevelDetailView:onClose()
	return
end

function V3a2_BossRush_LevelDetailView:onDestroyView()
	return
end

return V3a2_BossRush_LevelDetailView
