-- chunkname: @modules/logic/versionactivity1_6/dungeon/view/boss/VersionActivity1_6_BossFightIndicatorView.lua

module("modules.logic.versionactivity1_6.dungeon.view.boss.VersionActivity1_6_BossFightIndicatorView", package.seeall)

local VersionActivity1_6_BossFightIndicatorView = class("VersionActivity1_6_BossFightIndicatorView", FightIndicatorBaseView)
local kAllResPath = {
	VersionActivity1_6DungeonEnum.ResPath.BossFightScoreTips
}

function VersionActivity1_6_BossFightIndicatorView:startLoadPrefab()
	self._abLoader = MultiAbLoader.New()

	self._abLoader:setPathList(kAllResPath)
	self._abLoader:startLoad(self._onResLoadFinish, self)
end

function VersionActivity1_6_BossFightIndicatorView:_onResLoadFinish()
	VersionActivity1_6DungeonController.instance:registerCallback(VersionActivity1_6DungeonEvent.DungeonBossFightScoreChange, self._onScoreChange, self)
	self:_initView()
end

function VersionActivity1_6_BossFightIndicatorView:_initView()
	local key = VersionActivity1_6DungeonEnum.ResPath.BossFightScoreTips
	local assetItem = self._abLoader:getAssetItem(key)
	local src = assetItem:GetResource(key)

	self._go = gohelper.clone(src, self.goIndicatorRoot, "VersionActivity1_6_BossFightIndicatorView")
	self._txtScoreNum = gohelper.findChildText(self._go, "Tips/#txt_ScoreNum")
	self._txtScoreNum1 = gohelper.findChildText(self._go, "Tips/#txt_ScoreNum/#txt_ScoreNum1")
	self._goAssessIcon = gohelper.findChild(self._go, "Tips/#go_AssessIcon")
	self.imgtipbg = gohelper.findChildImage(self._go, "Tips/image_BG")
	self._aniScoreNum = self._txtScoreNum.gameObject:GetComponent(typeof(UnityEngine.Animation))
	self._animtip = self._go.gameObject:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(self._goAssessIcon, false)
	self:_setScore(VersionActivity1_6DungeonBossModel.instance:getFightScore())
end

function VersionActivity1_6_BossFightIndicatorView:_onScoreChange(last, cur)
	self:_setScore(cur)
end

function VersionActivity1_6_BossFightIndicatorView:_setScore(score)
	local desc = score ~= 0 and score or luaLang("v1a4_bossRush_ig_scoretips_txt_scorenum")

	self._txtScoreNum.text = desc
	self._txtScoreNum1.text = desc

	self._aniScoreNum:Stop()
	self._aniScoreNum:Play()
end

function VersionActivity1_6_BossFightIndicatorView:onDestroy()
	VersionActivity1_6DungeonController.instance:unregisterCallback(VersionActivity1_6DungeonEvent.DungeonBossFightScoreChange, self._onScoreChange, self)

	if self._abLoader then
		self._abLoader:dispose()
	end

	self._abLoader = nil

	VersionActivity1_6_BossFightIndicatorView.super.onDestroy(self)
end

return VersionActivity1_6_BossFightIndicatorView
