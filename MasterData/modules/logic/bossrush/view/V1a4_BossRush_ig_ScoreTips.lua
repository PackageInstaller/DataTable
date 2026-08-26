-- chunkname: @modules/logic/bossrush/view/V1a4_BossRush_ig_ScoreTips.lua

module("modules.logic.bossrush.view.V1a4_BossRush_ig_ScoreTips", package.seeall)

local V1a4_BossRush_ig_ScoreTips = class("V1a4_BossRush_ig_ScoreTips", FightIndicatorBaseView)
local kAllResPath = {
	BossRushEnum.ResPath.v1a4_bossrush_ig_scoretips,
	BossRushEnum.ResPath.v1a4_bossrush_battle_assessicon
}

function V1a4_BossRush_ig_ScoreTips:startLoadPrefab()
	self._abLoader = MultiAbLoader.New()

	self._abLoader:setPathList(kAllResPath)
	self._abLoader:startLoad(self._onResLoadFinish, self)
end

function V1a4_BossRush_ig_ScoreTips:_onResLoadFinish()
	self._curStage, self._curLayer = BossRushModel.instance:getBattleStageAndLayer()

	self:_initView()
	BossRushController.instance:registerCallback(BossRushEvent.OnScoreChange, self._onScoreChange, self)
end

function V1a4_BossRush_ig_ScoreTips:_initView()
	local key = BossRushEnum.ResPath.v1a4_bossrush_ig_scoretips
	local assetItem = self._abLoader:getAssetItem(key)
	local src = assetItem:GetResource(key)

	self.viewContainer.rightElementLayoutView:showElement(FightRightElementEnum.Elements.BossRush)

	local goContainer = self.viewContainer.rightElementLayoutView:getElementContainer(FightRightElementEnum.Elements.BossRush)

	self._go = gohelper.clone(src, goContainer, "v1a4_bossrush_ig_scoretips")
	self._txtScoreNum = gohelper.findChildText(self._go, "Tips/#txt_ScoreNum")
	self._txtScoreNum1 = gohelper.findChildText(self._go, "Tips/#txt_ScoreNum/#txt_ScoreNum1")
	self._goAssessIcon = gohelper.findChild(self._go, "Tips/#go_AssessIcon")
	self.imgtipbg = gohelper.findChildImage(self._go, "Tips/image_BG")
	self.vx = gohelper.findChild(self._goAssessIcon, "vx_iconglow"):GetComponent(typeof(UnityEngine.ParticleSystem))
	self._goeffnormal = gohelper.findChild(self._go, "Tips/#txt_ScoreNum/eff_normal")
	self._goefflayer4 = gohelper.findChild(self._go, "Tips/#txt_ScoreNum/eff_layer4")
	self._goeffnormal_1 = gohelper.findChild(self._go, "Tips/vx_levelup/eff_normal")
	self._goefflayer4_1 = gohelper.findChild(self._go, "Tips/vx_levelup/eff_layer4")
	self._aniScoreNum = self._txtScoreNum.gameObject:GetComponent(typeof(UnityEngine.Animation))
	self._animtip = self._go.gameObject:GetComponent(typeof(UnityEngine.Animator))
	self.isSpecial = BossRushModel.instance:isSpecialLayerCurBattle()

	gohelper.setActive(self._goeffnormal.gameObject, false)
	gohelper.setActive(self._goefflayer4.gameObject, false)
	gohelper.setActive(self._goeffnormal_1.gameObject, not self.isSpecial)
	gohelper.setActive(self._goefflayer4_1.gameObject, self.isSpecial)

	self._assessLevel = nil

	self:_initAssessIcon()
	self:_setScore(BossRushModel.instance:getFightScore())
end

function V1a4_BossRush_ig_ScoreTips:_initAssessIcon()
	local itemClass = V1a4_BossRush_AssessIcon
	local key = BossRushEnum.ResPath.v1a4_bossrush_battle_assessicon
	local assetItem = self._abLoader:getAssetItem(key)
	local src = assetItem:GetResource(key)
	local go = gohelper.clone(src, self._goAssessIcon, itemClass.__cname)

	self._assessIcon = MonoHelper.addNoUpdateLuaComOnceToGo(go, itemClass)

	self._assessIcon:initData(self, true)
end

function V1a4_BossRush_ig_ScoreTips:_onScoreChange(last, cur)
	self:_setScore(cur)
end

function V1a4_BossRush_ig_ScoreTips:_setScore(score)
	local stage = self._curStage
	local special = BossRushModel.instance:isSpecialLayer(self._curLayer)

	if special then
		if not BossRushEnum.AssessType.Layer4 then
			local type = BossRushEnum.AssessType.Normal

			self._assessIcon:setData(stage, score, type)

			local desc = score ~= 0 and BossRushConfig.instance:getScoreStr(score) or luaLang("v1a4_bossRush_ig_scoretips_txt_scorenum")

			self._txtScoreNum.text = desc
			self._txtScoreNum1.text = desc

			local res, level = BossRushConfig.instance:getAssessBattleIconBgName(stage, score, type)

			UISpriteSetMgr.instance:setV1a4BossRushSprite(self.imgtipbg, res)

			local isChange = level > 0 and self._assessLevel ~= level

			self._aniScoreNum:Stop()

			if score > 0 then
				gohelper.setActive(self._goeffnormal.gameObject, not self.isSpecial)
				gohelper.setActive(self._goefflayer4.gameObject, self.isSpecial)
				self._aniScoreNum:Play()

				if isChange then
					self._animtip:Play(BossRushEnum.AnimScoreTips.LevelUp, 0, 0)
					self._assessIcon:playVX()
					AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_smalluncharted_refresh)

					self._assessLevel = level
				end
			end
		end
	end
end

function V1a4_BossRush_ig_ScoreTips:onDestroy()
	BossRushController.instance:unregisterCallback(BossRushEvent.OnScoreChange, self._onScoreChange, self)

	if self._abLoader then
		self._abLoader:dispose()
	end

	self._abLoader = nil
	self._assessLevel = nil

	V1a4_BossRush_ig_ScoreTips.super.onDestroy(self)
end

function V1a4_BossRush_ig_ScoreTips:playVX()
	if self.vx then
		gohelper.setActive(self.vx.gameObject, false)
	end
end

function V1a4_BossRush_ig_ScoreTips:stopVX()
	if self.vx then
		-- block empty
	end
end

return V1a4_BossRush_ig_ScoreTips
