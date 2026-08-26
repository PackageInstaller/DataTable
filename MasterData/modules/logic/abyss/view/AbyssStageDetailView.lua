-- chunkname: @modules/logic/abyss/view/AbyssStageDetailView.lua

module("modules.logic.abyss.view.AbyssStageDetailView", package.seeall)

local AbyssStageDetailView = class("AbyssStageDetailView", BaseView)

function AbyssStageDetailView:onInitView()
	self._txtchaptertitle = gohelper.findChildText(self.viewGO, "#txt_chaptertitle")
	self._goCareer = gohelper.findChild(self.viewGO, "recommend/carreer/#go_Career")
	self._goCareerItem = gohelper.findChild(self.viewGO, "recommend/carreer/#go_Career/#go_CareerItem")
	self._txtrecommonddes = gohelper.findChildText(self.viewGO, "recommend/carreer/#go_Career/#txt_recommonddes")
	self._txtDesc = gohelper.findChildText(self.viewGO, "recommend/level/#txt_desc")
	self._gorconditionitem = gohelper.findChild(self.viewGO, "chapterconditions/scroll_info/viewport/content/#go_rconditionitem")
	self._gostar2 = gohelper.findChild(self.viewGO, "chapterconditions/scroll_info/viewport/content/#go_rconditionitem/#go_star2")
	self._gostar1 = gohelper.findChild(self.viewGO, "chapterconditions/scroll_info/viewport/content/#go_rconditionitem/#go_star1")
	self._gorules = gohelper.findChild(self.viewGO, "right/#go_rules")
	self._godescitem = gohelper.findChild(self.viewGO, "right/#go_rules/scroll_buffdesc/viewport/content/#go_descitem")
	self._simagebufficon = gohelper.findChildSingleImage(self.viewGO, "right/#go_rules/scroll_buffdesc/viewport/content/#go_descitem/#simage_bufficon")
	self._btnrules = gohelper.findChildButtonWithAudio(self.viewGO, "right/#go_rules/#btn_rules")
	self._goreset = gohelper.findChild(self.viewGO, "right/#go_reset")
	self._gocurherogroup = gohelper.findChild(self.viewGO, "right/#go_reset/#go_curherogroup")
	self._goherogItem = gohelper.findChild(self.viewGO, "right/#go_reset/#go_curherogroup/#go_herogItem")
	self._btnreset = gohelper.findChildButtonWithAudio(self.viewGO, "right/#go_reset/#btn_reset")
	self._btnstart = gohelper.findChildButtonWithAudio(self.viewGO, "right/#btn_start")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._btnclosebg = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_closebg")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AbyssStageDetailView:addEvents()
	self._btnrules:AddClickListener(self._btnrulesOnClick, self)
	self._btnreset:AddClickListener(self._btnresetOnClick, self)
	self._btnstart:AddClickListener(self._btnstartOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnclosebg:AddClickListener(self._btncloseOnClick, self)
	self._btnRecommend:AddClickListener(self._btnRecommendOnClick, self)
	self.addEventCb(self, AbyssController.instance, AbyssEvent.OnResetStage, self.refreshUI, self)
	self.addEventCb(self, AbyssController.instance, AbyssEvent.OnUpdateStageInfo, self.refreshUI, self)
end

function AbyssStageDetailView:removeEvents()
	self._btnrules:RemoveClickListener()
	self._btnreset:RemoveClickListener()
	self._btnstart:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self._btnclosebg:RemoveClickListener()
	self._btnRecommend:RemoveClickListener()
	self.removeEventCb(self, AbyssController.instance, AbyssEvent.OnResetStage, self.refreshUI, self)
	self.removeEventCb(self, AbyssController.instance, AbyssEvent.OnUpdateStageInfo, self.refreshUI, self)
end

function AbyssStageDetailView:_btnrulesOnClick()
	if not self.ruleList and next(self.ruleList) == nil then
		return
	end

	ViewMgr.instance:openView(ViewName.HeroGroupFightRuleDescView, {
		ruleList = self.ruleList,
		closeCb = self._btncloseruleOnClick,
		closeCbObj = self
	})
	AbyssController.instance:statCheckInformation(StatEnum.AbyssEntranceEnum.Conditions, self.episodeConfig.id)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.HardModeShowRuleDesc)
end

function AbyssStageDetailView:_btncloseruleOnClick()
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.HardModeHideRuleDesc)
end

function AbyssStageDetailView:_btnresetOnClick()
	AbyssController.instance:tryResetCurStage()
end

function AbyssStageDetailView:_btnstartOnClick()
	if not AbyssModel.instance:isCurActOpen(true) then
		return
	end

	local actId = AbyssModel.instance:getCurActId()
	local stageId = AbyssModel.instance:getCurStageId()

	AbyssController.instance:startFight(actId, stageId)
end

function AbyssStageDetailView:_btncloseOnClick()
	self:closeThis()
end

function AbyssStageDetailView:_btnRecommendOnClick()
	local episodeId = self.stageConfig.episodeId

	DungeonRpc.instance:sendGetEpisodeHeroRecommendRequest(episodeId, self._receiveRecommend, self)
end

function AbyssStageDetailView:_receiveRecommend(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	HeroGroupModel.instance:setAfterUpdateRecommendState(true)
	ViewMgr.instance:openView(ViewName.HeroGroupRecommendView, msg)
end

function AbyssStageDetailView:_editableInitView()
	self._goStageParent = gohelper.findChild(self.viewGO, "#go_clipNode/clip")
	self._btnRecommend = gohelper.findChildButton(self.viewGO, "right/#btn_tuijian")
end

function AbyssStageDetailView:onUpdateParam()
	return
end

function AbyssStageDetailView:onOpen()
	AudioMgr.instance:trigger(AudioEnum3_6.Abyss.play_ui_stage_open)
	self:checkParam()
	self:refreshUI()
end

function AbyssStageDetailView:refreshUI()
	self._txtchaptertitle.text = self.episodeConfig.name

	local stagePrefabPath = self.viewContainer._viewSetting.otherRes[self.stageId]

	if stagePrefabPath then
		self:getResInst(stagePrefabPath, self._goStageParent, "stage_" .. tostring(self.stageId))
	else
		logError("新深渊 关卡特效不存在 stageId:" .. tostring(self.stageId))
	end

	self:refreshTargetList()
	self:refreshRuleInfo()
	self:refreshRecommendInfo()

	local stageInfo = AbyssModel.instance:getStageInfoMo(self.actId, self.stageId)

	self.stageInfo = stageInfo

	local haveChallenge = stageInfo:isChallenged()

	gohelper.setActive(self._goreset, haveChallenge)

	if not haveChallenge then
		return
	end

	self:refreshHeroState(stageInfo.heroList)
end

function AbyssStageDetailView:checkParam()
	local param = self.viewParam

	if not param or not param.actId or not param.stageId then
		logError("新深渊 没有活动数据")

		return
	end

	self.actId = param.actId
	self.stageId = param.stageId

	local stageConfig = AbyssConfig.instance:getEpisodeConfig(self.actId, self.stageId)

	if not stageConfig then
		logError("新深渊 没有关卡数据 actId:" .. tostring(self.actId) .. " stageid " .. tostring(self.stageId))

		return
	end

	self.stageConfig = stageConfig

	local episodeConfig = DungeonConfig.instance:getEpisodeCO(self.stageConfig.episodeId)

	if not episodeConfig then
		logError("新深渊 没有战斗关卡数据 actId:" .. tostring(self.actId) .. " stageId " .. tostring(self.stageId) .. "episodeId: " .. tostring(self.stageConfig.episodeId))

		return
	end

	self.episodeConfig = episodeConfig

	local battleId = self.episodeConfig.battleId

	self.ruleList = AbyssHelper.getRuleList(battleId)

	AbyssModel.instance:setCurStageId(self.stageId)
end

function AbyssStageDetailView:refreshTargetList()
	local conditionList = AbyssHelper.getEpisodeConditionDescList(self.stageConfig.episodeId)

	gohelper.CreateObjList(self, self.onCreateTargetItem, conditionList, nil, self._gorconditionitem)
end

function AbyssStageDetailView:onCreateTargetItem(itemGo, desc, index)
	local text = gohelper.findChildTextMesh(itemGo, "")
	local starUnlock = gohelper.findChild(itemGo, "#go_star1")
	local starFinish = gohelper.findChild(itemGo, "#go_star2")
	local starUnlock2 = gohelper.findChild(itemGo, "#go_star3")
	local starFinish2 = gohelper.findChild(itemGo, "#go_star4")
	local stageInfo = AbyssModel.instance:getCurStageMo()

	if stageInfo then
		::label_17_0::

		if stageInfo:isChallenged() then
			if stageInfo.star then
				local isFinish = true

				isFinish = index <= stageInfo.star

				local isFinal = index >= stageInfo.totalStar

				text.text = desc

				ZProj.UGUIHelper.SetColorAlpha(text, isFinish and 1 or 0.63)
				gohelper.setActive(starFinish, isFinish and not isFinal)
				gohelper.setActive(starUnlock, not isFinish and not isFinal)
				gohelper.setActive(starFinish2, isFinish and isFinal)
				gohelper.setActive(starUnlock2, not isFinish and isFinal)
			end
		end
	end
end

function AbyssStageDetailView:refreshRecommendInfo()
	self._txtDesc.text = AbyssHelper.getRecommendTeamList(self.stageConfig.teamRecommend)

	local recommended

	if not string.nilorempty(self.stageConfig.careerPrefer) then
		recommended = string.splitToNumber(self.stageConfig.careerPrefer, "#")
	else
		logError("新深渊 关卡推荐属性为空 活动id: " .. tostring(self.stageConfig.activityId) .. " 关卡id: " .. tostring(self.stageConfig.stage))

		recommended = {}
	end

	gohelper.CreateObjList(self, self._onRecommendCareerItemShow, recommended, nil, self._goCareerItem, nil, nil, nil, 1)

	local isEmpty = not recommended and next(recommended) == nil

	gohelper.setActive(self._txtrecommonddes, isEmpty)

	if isEmpty then
		self._txtrecommonddes.text = luaLang("new_common_none")
	end
end

function AbyssStageDetailView:_onRecommendCareerItemShow(obj, data, index)
	local icon = gohelper.findChildImage(obj, "")

	UISpriteSetMgr.instance:setHeroGroupSprite(icon, "career_" .. data)
end

function AbyssStageDetailView:refreshHeroState(heroList)
	gohelper.CreateObjList(self, self.onHeroItemCreate, heroList, nil, self._goherogItem, AbyssStageHeroItem)
end

function AbyssStageDetailView:onHeroItemCreate(item, heroId, index)
	item:setInfo(heroId)
end

function AbyssStageDetailView:refreshRuleInfo()
	local battleId = self.episodeConfig.battleId
	local ruleList = AbyssHelper.getRuleList(battleId)

	if not ruleList or next(ruleList) == nil then
		gohelper.setActive(self._gorules, false)

		return
	end

	gohelper.CreateObjList(self, self.onRuleItemCreate, ruleList, nil, self._godescitem)
end

function AbyssStageDetailView:onRuleItemCreate(itemGo, param, index)
	local targetId = param[1]
	local ruleId = param[2]
	local ruleCo = lua_rule.configDict[ruleId]
	local tagicon = gohelper.findChildImage(itemGo, "#image_tagicon")

	UISpriteSetMgr.instance:setCommonSprite(tagicon, "wz_" .. targetId)

	local simage = gohelper.findChildImage(itemGo, "#simage_bufficon")

	UISpriteSetMgr.instance:setDungeonLevelRuleSprite(simage, ruleCo.icon)
end

function AbyssStageDetailView:onClose()
	return
end

function AbyssStageDetailView:onDestroyView()
	return
end

return AbyssStageDetailView
