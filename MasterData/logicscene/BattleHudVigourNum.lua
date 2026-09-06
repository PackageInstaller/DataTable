-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/battle/hud/BattleHudVigourNum.lua

module("logicscene.scene.unit.component.battle.hud.BattleHudVigourNum", package.seeall)

local BattleHudVigourNum = class("BattleHudVigourNum", BattleHudHurtNum)

function BattleHudVigourNum:ctor(damageGo, go, pool)
	BattleHudVigourNum.super.ctor(self, damageGo, go, pool)

	self._imageRect = self._restriction:GetComponent("RectTransform")
end

function BattleHudVigourNum:start()
	BattleHudVigourNum.super.start(self)

	local txt = self._imageNum:GetText()
	local len = #txt
	local width = self._imageNum.horizontalSpace * len
	local imgWidth = self._imageRect.sizeDelta.x

	Framework.TransformUtil.SetLocalPos(self._imageRect.transform, -0.5 * width, 0, 0)
	Framework.TransformUtil.SetLocalPos(self._imageNum.transform, 0.5 * imgWidth, 0, 0)
end

return BattleHudVigourNum
