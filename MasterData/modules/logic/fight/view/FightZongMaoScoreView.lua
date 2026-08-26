-- chunkname: @modules/logic/fight/view/FightZongMaoScoreView.lua

module("modules.logic.fight.view.FightZongMaoScoreView", package.seeall)

local FightZongMaoScoreView = class("FightZongMaoScoreView", FightBaseView)

function FightZongMaoScoreView:onInitView()
	self.imgBg = gohelper.findChildImage(self.viewGO, "root/image_BG")
	self.text_score = gohelper.findChildText(self.viewGO, "root/#txt_ScoreNum")
	self.animation = self.text_score:GetComponent(typeof(UnityEngine.Animation))
	self.text_score1 = gohelper.findChildText(self.viewGO, "root/#txt_ScoreNum/#txt_ScoreNum1")
	self.scoreIcon = gohelper.findChild(self.viewGO, "root/#image_gradebadge")
	self.img_gradeBadge = gohelper.findChildSingleImage(self.viewGO, "root/#image_gradebadge")
end

function FightZongMaoScoreView:addEvents()
	self:com_registFightEvent(FightEvent.OnIndicatorChange, self.onIndicatorChange)
end

function FightZongMaoScoreView:onConstructor()
	return
end

function FightZongMaoScoreView:onOpen()
	self._curStage, self._curLayer = BossRushModel.instance:getBattleStageAndLayer()
	self.special = BossRushModel.instance:isSpecialLayer(self._curLayer)

	recthelper.setAnchorX(self.viewGO.transform, -136)
	self:refreshScore()
end

function FightZongMaoScoreView:onIndicatorChange(indicatorId)
	if indicatorId == FightEnum.IndicatorId.V1a4_BossRush_ig_ScoreTips or indicatorId == FightEnum.IndicatorId.ZongMaoTechniqueScore or indicatorId == FightEnum.IndicatorId.Rouge2Boss then
		self:refreshScore()
	end
end

function FightZongMaoScoreView:refreshScore()
	local score = 0
	local data = FightDataHelper.fieldMgr.indicatorDict[FightEnum.IndicatorId.V1a4_BossRush_ig_ScoreTips]

	score = score + ((data or nil) and (data.num or 0))
	data = FightDataHelper.fieldMgr.indicatorDict[FightEnum.IndicatorId.ZongMaoTechniqueScore]
	score = score + ((FightDataHelper.fieldMgr.indicatorDict[FightEnum.IndicatorId.ZongMaoTechniqueScore] or nil) and (data.num or 0))
	data = FightDataHelper.fieldMgr.indicatorDict[FightEnum.IndicatorId.Rouge2Boss]
	score = score + ((FightDataHelper.fieldMgr.indicatorDict[FightEnum.IndicatorId.Rouge2Boss] or nil) and (data.num or 0))

	local scoreText = BossRushConfig.instance:getScoreStr(score)

	self.text_score.text = scoreText
	self.text_score1.text = scoreText

	self.animation:Rewind()
	self.animation:Play()

	local spriteName = BossRushConfig.instance:getAssessSpriteName(self._curStage, score, BossRushEnum.AssessType.V3a2)

	if spriteName ~= self.lastSpriteName then
		self.lastSpriteName = spriteName

		if spriteName == "" then
			gohelper.setActive(self.scoreIcon, false)
		else
			gohelper.setActive(self.scoreIcon, true)
			self.img_gradeBadge:LoadImage(ResUrl.getV1a4BossRushAssessIcon(spriteName))
		end

		local res, level = BossRushConfig.instance:getAssessBattleIconBgName(self._curStage, score, BossRushEnum.AssessType.V3a2)

		UISpriteSetMgr.instance:setV1a4BossRushSprite(self.imgBg, res, true)
	end
end

return FightZongMaoScoreView
