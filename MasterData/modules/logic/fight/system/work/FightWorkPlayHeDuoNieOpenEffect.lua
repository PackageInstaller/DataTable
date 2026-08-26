-- chunkname: @modules/logic/fight/system/work/FightWorkPlayHeDuoNieOpenEffect.lua

module("modules.logic.fight.system.work.FightWorkPlayHeDuoNieOpenEffect", package.seeall)

local FightWorkPlayHeDuoNieOpenEffect = class("FightWorkPlayHeDuoNieOpenEffect", BaseWork)

function FightWorkPlayHeDuoNieOpenEffect:onConstructor()
	return
end

function FightWorkPlayHeDuoNieOpenEffect:onStart()
	local cardInfoMo = self.context.cardMo
	local skillId = cardInfoMo and cardInfoMo.skillId

	if not FightHelper.isHeDuoNieSkill(skillId) then
		return self:onDone(true)
	end

	local uiPath = FightViewCardItem.GetHeDuoNieUiPath()

	self.loader = MultiAbLoader.New()

	self.loader:addPath(uiPath)
	self.loader:startLoad(self.onLoadHeDuoNieUiDone, self)
end

function FightWorkPlayHeDuoNieOpenEffect:onLoadHeDuoNieUiDone()
	local cardItem = self.context.handCardItem

	if not cardItem then
		return self:onDone(true)
	end

	cardItem:playHeDuoNieOpenAnim(self.onPlayAnimDone, self)
end

function FightWorkPlayHeDuoNieOpenEffect:onPlayAnimDone()
	self:onDone(true)
end

function FightWorkPlayHeDuoNieOpenEffect:clearWork()
	if self.loader then
		self.loader:dispose()

		self.loader = nil
	end
end

return FightWorkPlayHeDuoNieOpenEffect
