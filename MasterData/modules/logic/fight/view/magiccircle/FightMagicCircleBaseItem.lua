-- chunkname: @modules/logic/fight/view/magiccircle/FightMagicCircleBaseItem.lua

module("modules.logic.fight.view.magiccircle.FightMagicCircleBaseItem", package.seeall)

local FightMagicCircleBaseItem = class("FightMagicCircleBaseItem", UserDataDispose)

function FightMagicCircleBaseItem:init(go)
	self:__onInit()

	self.go = go
	self.destroyed = nil
	self._aniPlayer = ZProj.ProjAnimatorPlayer.Get(self.go)
	self._ani = self.go:GetComponent(gohelper.Type_Animator)

	self:initView()
end

function FightMagicCircleBaseItem:destroy()
	self.destroyed = true

	if self._aniPlayer then
		self._aniPlayer:Stop()
	end

	self:hideGo()
	self:__onDispose()
end

function FightMagicCircleBaseItem:getUIType()
	return FightEnum.MagicCircleUIType.Normal
end

function FightMagicCircleBaseItem:hideGo()
	gohelper.setActive(self.go, false)
end

function FightMagicCircleBaseItem:showGo()
	gohelper.setActive(self.go, true)
end

function FightMagicCircleBaseItem:initView()
	return
end

function FightMagicCircleBaseItem:onCreateMagic(magicMo, magicConfig)
	self:showGo()
	self:playAnim("open")
	self:refreshUI(magicMo, magicConfig)
end

function FightMagicCircleBaseItem:onUpdateMagic(magicMo, magicConfig, fromId)
	self:refreshUI(magicMo, magicConfig, fromId)
end

function FightMagicCircleBaseItem:onRemoveMagic()
	self:destroy()
end

function FightMagicCircleBaseItem:playAnim(animName, callback, callbackObj)
	self._ani.speed = FightModel.instance:getSpeed()

	self._aniPlayer:Play(animName, callback, callbackObj)
end

function FightMagicCircleBaseItem:refreshUI(magicMo, magicConfig, fromId)
	return
end

return FightMagicCircleBaseItem
