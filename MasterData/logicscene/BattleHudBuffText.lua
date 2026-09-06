-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/component/battle/hud/BattleHudBuffText.lua

module("logicscene.scene.unit.component.battle.hud.BattleHudBuffText", package.seeall)

local BattleHudBuffText = class("BattleHudBuffText", BattleHudBase)

function BattleHudBuffText:ctor(go, pool)
	BattleHudBuffText.super.ctor(self, go, pool)

	self._imageComp = goutil.findChildImageComponent(go, "ani/Image")
	self._imageCompState = self._imageComp:GetComponent("UIImageSpriteChange")
	self._imageCompRect = self._imageComp.transform
	self._arrow = goutil.findChild(go, "ani/Image_2").transform
	self._arrowWidth = self._arrow.sizeDelta.x
	self._glowNode = goutil.findChild(go, "ani/mod_glow_01").transform

	Framework.TransformUtil.SetLocalPos(self.go.transform, 0, 0, 0)
	Framework.TransformUtil.SetLocalScale(self.go.transform, 1, 1, 1)
end

function BattleHudBuffText:start()
	self.time = 0

	BattleHudBuffDamage.super.start(self)
	Framework.TransformUtil.SetLocalPos(self.go.transform, 0, 0, 0)
	Framework.TransformUtil.SetLocalScale(self.go.transform, 1, 1, 1)

	if self.textId then
		self._imageCompState:ChangeStateNow(self.textId)
		self._imageComp:SetNativeSize()

		self.deltaWidth = self._imageCompRect.sizeDelta.x

		Framework.TransformUtil.SetLocalPos(self._arrow, self.deltaWidth * 0.5, 0, 0)
		Framework.TransformUtil.SetLocalPos(self._glowNode, self.deltaWidth * 0.5, 0, 0)

		self.deltaWidth = self.deltaWidth + self._arrowWidth
	end

	self.go:SetActive(true)
end

function BattleHudBuffText:update(deltaTime)
	self.time = self.time + deltaTime
end

function BattleHudBuffText:forcePositionOut()
	return
end

function BattleHudBuffText:isFadingIn()
	return self.time < 0.56
end

function BattleHudBuffText:isDone()
	return self.time >= 1.2
end

return BattleHudBuffText
