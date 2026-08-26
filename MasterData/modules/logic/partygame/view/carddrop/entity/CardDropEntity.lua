-- chunkname: @modules/logic/partygame/view/carddrop/entity/CardDropEntity.lua

module("modules.logic.partygame.view.carddrop.entity.CardDropEntity", package.seeall)

local CardDropEntity = class("CardDropEntity", UserDataDispose)

function CardDropEntity:init(uid, go)
	self:__onInit()

	self.uid = uid
	self.stringUid = tostring(self.uid)
	self.go = go
	self.containerTransform = go.transform.parent
	self.goContainer = self.containerTransform.gameObject
	self.animator = self.go:GetComponent(gohelper.Type_Animator)

	gohelper.setActive(self.go, false)

	self.compList = {}

	self:addComp("effect", CardDropEntityEffectComp)
end

function CardDropEntity:addComp(compName, compCls)
	local comp = compCls.New()

	comp:init(self.uid, self)
	table.insert(self.compList, comp)

	self[compName] = comp
end

function CardDropEntity:getUid()
	return self.uid
end

function CardDropEntity:getContainerTransform()
	return self.containerTransform
end

function CardDropEntity:getSpineGo()
	return self.go
end

function CardDropEntity:playAnim(animName)
	self.animator:SetTrigger(animName)
end

function CardDropEntity:getScreenPos()
	if self.screenPos then
		return self.screenPos
	end

	local mainCamera = CameraMgr.instance:getMainCamera()

	self.screenPos = mainCamera:WorldToScreenPoint(self.go.transform.position)

	return self.screenPos
end

local bornEffect = "v3a4_games/game_common04"

function CardDropEntity:show()
	gohelper.setActive(self.go, true)
	self.animator:SetLayerWeight(2, 1)

	self.bornEffect = self.effect:addLocalEffect(bornEffect)

	self.bornEffect:setLocalScale(2)
	AudioMgr.instance:trigger(340154)
	TaskDispatcher.runDelay(self.removeBornEffect, self, 2)
end

function CardDropEntity:removeBornEffect()
	self.effect:removeLocalEffect(self.bornEffect)
end

function CardDropEntity:getSide()
	if not self.side then
		local myUid = PartyGameCSDefine.CardDropInterfaceCs.GetMyPlayerUid()

		if tostring(myUid) == self.stringUid then
			self.side = CardDropEnum.Side.My or CardDropEnum.Side.Enemy
		end
	end

	return self.side
end

function CardDropEntity:destroy()
	TaskDispatcher.cancelTask(self.removeBornEffect, self)

	for _, comp in ipairs(self.compList) do
		comp:destroy()
	end

	self:__onDispose()
end

return CardDropEntity
