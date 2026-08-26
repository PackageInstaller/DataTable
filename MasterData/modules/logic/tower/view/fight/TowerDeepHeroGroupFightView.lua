-- chunkname: @modules/logic/tower/view/fight/TowerDeepHeroGroupFightView.lua

module("modules.logic.tower.view.fight.TowerDeepHeroGroupFightView", package.seeall)

local TowerDeepHeroGroupFightView = class("TowerDeepHeroGroupFightView", TowerHeroGroupFightView)

function TowerDeepHeroGroupFightView:_editableInitView()
	TowerDeepHeroGroupFightView.super._editableInitView(self)
end

function TowerDeepHeroGroupFightView:_enterFight()
	if HeroGroupModel.instance.episodeId then
		self._closeWithEnteringFight = true

		local result = FightController.instance:setFightHeroSingleGroup()

		if result then
			self.viewContainer:dispatchEvent(HeroGroupEvent.BeforeEnterFight)

			local fightParam = FightModel.instance:getFightParam()

			fightParam.isReplay = false
			fightParam.multiplication = 1

			DungeonFightController.instance:sendStartDungeonRequest(fightParam.chapterId, fightParam.episodeId, fightParam, 1)
			AudioMgr.instance:trigger(AudioEnum.UI.Stop_HeroNormalVoc)
		end
	else
		logError("没选中关卡，无法开始战斗")
	end
end

return TowerDeepHeroGroupFightView
