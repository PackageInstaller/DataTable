-- chunkname: @modules/logic/abyss/view/AbyssHeroGroupFightViewLevel.lua

module("modules.logic.abyss.view.AbyssHeroGroupFightViewLevel", package.seeall)

local AbyssHeroGroupFightViewLevel = class("AbyssHeroGroupFightViewLevel", HeroGroupFightViewLevel)

function AbyssHeroGroupFightViewLevel:onInitView()
	AbyssHeroGroupFightViewLevel.super.onInitView(self)

	self._goabyssconditionitem = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/cloudredemption/conditionsList/#go_conditionstxt")
	self._goabyssconditionContent = gohelper.findChild(self.viewGO, "#go_container/#scroll_info/infocontain/cloudredemption")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AbyssHeroGroupFightViewLevel:_refreshTarget()
	gohelper.setActive(self._gotargetlist.transform.parent.gameObject, false)

	local conditionList = AbyssHelper.getEpisodeConditionDescList(self._episodeId)
	local haveCondition = conditionList and next(conditionList)

	gohelper.setActive(self._goabyssconditionContent, haveCondition)

	if not haveCondition then
		return
	end

	gohelper.CreateObjList(self, self.onCreateTargetItem, conditionList, nil, self._goabyssconditionitem)
end

function AbyssHeroGroupFightViewLevel:onCreateTargetItem(itemGo, desc, index)
	local text = gohelper.findChildTextMesh(itemGo, "#go_txt")
	local starUnlock = gohelper.findChild(itemGo, "#go_txt/star1")
	local starFinish = gohelper.findChild(itemGo, "#go_txt/star2")
	local starUnlock2 = gohelper.findChild(itemGo, "#go_txt/star3")
	local starFinish2 = gohelper.findChild(itemGo, "#go_txt/star4")
	local stageInfo = AbyssModel.instance:getCurStageMo()

	if stageInfo then
		::label_3_0::

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

function AbyssHeroGroupFightViewLevel:_recommendCareer()
	local actId = AbyssModel.instance:getCurActId()
	local stageId = AbyssModel.instance:getCurStageId()
	local episodeConfig = AbyssConfig.instance:getEpisodeConfig(actId, stageId)
	local recommended

	if episodeConfig and not string.nilorempty(episodeConfig.careerPrefer) then
		recommended = string.splitToNumber(episodeConfig.careerPrefer, "#")
	else
		logError("新深渊 关卡推荐属性为空 活动id: " .. tostring(actId) .. " 关卡id: " .. tostring(stageId))

		recommended = {}
	end

	gohelper.CreateObjList(self, self._onRecommendCareerItemShow, recommended, gohelper.findChild(self._gorecommendattr.gameObject, "attrlist"), self._goattritem)

	self._txtrecommonddes.text = #recommended == 0 and luaLang("new_common_none") or ""
end

function AbyssHeroGroupFightViewLevel:_showEnemyList()
	AbyssHeroGroupFightViewLevel.super._showEnemyList(self)

	local actId = AbyssModel.instance:getCurActId()
	local stageId = AbyssModel.instance:getCurStageId()
	local episodeConfig = AbyssConfig.instance:getEpisodeConfig(actId, stageId)

	self._txtrecommendlevel.text = AbyssHelper.getRecommendTeamList(episodeConfig.teamRecommend)
end

function AbyssHeroGroupFightViewLevel:_btnenemyOnClick()
	AbyssHeroGroupFightViewLevel.super._btnenemyOnClick(self)
	AbyssController.instance:statCheckInformation(StatEnum.AbyssEntranceEnum.EnemyInformation, self._episodeId)
end

return AbyssHeroGroupFightViewLevel
