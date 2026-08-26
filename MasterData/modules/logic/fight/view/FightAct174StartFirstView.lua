-- chunkname: @modules/logic/fight/view/FightAct174StartFirstView.lua

module("modules.logic.fight.view.FightAct174StartFirstView", package.seeall)

local FightAct174StartFirstView = class("FightAct174StartFirstView", FightBaseView)

function FightAct174StartFirstView:onInitView()
	self._playerFirst = gohelper.findChild(self.viewGO, "titlebg/#simage_player")
	self._enemyFirst = gohelper.findChild(self.viewGO, "titlebg/#simage_enemy")
	self._title = gohelper.findChild(self.viewGO, "titlebg/#simage_title")
	self._title1 = gohelper.findChild(self.viewGO, "titlebg/#simage_title1")
	self._playerPoint = gohelper.findChildText(self.viewGO, "player/#txt_num")
	self._playPointEffect = gohelper.findChildText(self.viewGO, "player/#txt_eff")
	self._enemyPoint = gohelper.findChildText(self.viewGO, "enemy/#txt_num")
	self._enemyPointEffect = gohelper.findChildText(self.viewGO, "enemy/#txt_eff")
	self._titlebgGo = gohelper.findChild(self.viewGO, "titlebg")
	self._ttitlebgAnimator = self._titlebgGo:GetComponent(gohelper.Type_Animator)
end

function FightAct174StartFirstView:onConstructor(actEffectData)
	self.actEffectData = actEffectData
end

function FightAct174StartFirstView:onOpen()
	local isPlayer = self.actEffectData.reserveId == "1"

	self:com_registTimer(self.disposeSelf, FightEnum.PerformanceTime.DouQuQuXianHouShou)

	local point = string.splitToNumber(self.actEffectData.reserveStr, "#")

	if isPlayer then
		if not point[1] then
			local playerPint = point[2]

			self._playerPoint.text = playerPint
			self._playPointEffect.text = playerPint

			if not isPlayer then
				if not point[1] then
					local enemyPoint = point[2]

					self._enemyPoint.text = enemyPoint
					self._enemyPointEffect.text = enemyPoint

					self._ttitlebgAnimator:Play(isPlayer and "player" or "enemy", 0, 0)
					AudioMgr.instance:trigger(AudioEnum.Act174.play_ui_shenghuo_dqq_dice)
				end
			end
		end
	end
end

return FightAct174StartFirstView
