-- chunkname: @modules/logic/fight/view/FightAssistBossScoreView.lua

module("modules.logic.fight.view.FightAssistBossScoreView", package.seeall)

local FightAssistBossScoreView = class("FightAssistBossScoreView", UserDataDispose)
local prefabPath = "ui/viewres/assistboss/assistbossscore.prefab"

function FightAssistBossScoreView:init(goContainer)
	self:__onInit()

	self.goAssistBossContainer = goContainer

	self.addEventCb(self, FightController.instance, FightEvent.OnAssistBossScoreChange, self.onScoreChange, self)

	self.loadDone = false

	loadAbAsset(prefabPath, false, self.onLoadCallback, self)
end

function FightAssistBossScoreView:onLoadCallback(assetItem)
	if assetItem.IsLoadSuccess then
		local oldAsstet = self._assetItem

		self.loadDone = true
		self._assetItem = assetItem

		self._assetItem:Retain()

		if oldAsstet then
			oldAsstet:Release()
		end

		self.instanceGo = gohelper.clone(self._assetItem:GetResource(prefabPath), self.goAssistBossContainer)

		gohelper.setAsFirstSibling(self.instanceGo)

		self.txtScore = gohelper.findChildText(self.instanceGo, "Score/#txt_num")
		self.txtScore1 = gohelper.findChildText(self.instanceGo, "Score/#txt_num/#txt_num1")
		self.imageScoreIcon = gohelper.findChildImage(self.instanceGo, "Score/#image_ScoreIcon")
		self.canvasGroupScoreIcon = self.imageScoreIcon.gameObject:GetComponent(typeof(UnityEngine.CanvasGroup))
		self._animLevelUp = gohelper.findChild(self.instanceGo, "Score/#ani_levelup"):GetComponent(gohelper.Type_Animator)
		self.lastLevel = 0

		self:refreshScore()

		self.animation = self.txtScore.gameObject:GetComponent(typeof(UnityEngine.Animation))
	end
end

function FightAssistBossScoreView:refreshScore()
	if not self.loadDone then
		return
	end

	local num = FightDataHelper.fieldMgr:getIndicatorNum(self.indicatorId)

	self.txtScore.text = num
	self.txtScore1.text = num

	self:refreshScoreStar(num)
end

FightAssistBossScoreView.Duration = 0.5

function FightAssistBossScoreView:onScoreChange(beforeScore, curScore)
	if not self.loadDone then
		return
	end

	self:killTween()

	self.tweenId = ZProj.TweenHelper.DOTweenFloat(beforeScore, curScore, FightAssistBossScoreView.Duration, self.onFrameCallback, nil, self, nil, EaseType.Linear)

	self.animation:Play()
end

function FightAssistBossScoreView:onFrameCallback(value)
	value = math.floor(value)
	self.txtScore.text = value
	self.txtScore1.text = value

	self:refreshScoreStar(value)
end

function FightAssistBossScoreView:refreshScoreStar(score)
	local starLevel = TowerConfig.instance:getScoreToStarConfig(score)

	if starLevel ~= self.lastLevel then
		self._animLevelUp:Play("levelup", 0, 0)

		self.lastLevel = starLevel
	end

	local starIconName = starLevel > 0 and "tower_assist_point" .. Mathf.Min(starLevel, TowerEnum.MaxShowStarNum) or "tower_assist_point1"

	UISpriteSetMgr.instance:setTowerSprite(self.imageScoreIcon, starIconName)

	self.canvasGroupScoreIcon.alpha = starLevel > 0 and 1 or 0.3
end

function FightAssistBossScoreView:killTween()
	if self.tweenId then
		ZProj.TweenHelper.KillById(self.tweenId)
	end
end

function FightAssistBossScoreView:destroy()
	removeAssetLoadCb(prefabPath, self._onLoadCallback, self)

	if self._assetItem then
		self._assetItem:Release()

		self._assetItem = nil
	end

	self:killTween()
	self:__onDispose()
end

return FightAssistBossScoreView
