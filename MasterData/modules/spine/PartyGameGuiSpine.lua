-- chunkname: @modules/spine/PartyGameGuiSpine.lua

module("modules.spine.PartyGameGuiSpine", package.seeall)

local PartyGameGuiSpine = class("PartyGameGuiSpine", GuiSpine)

PartyGameGuiSpine.Type_PartyGameGuiSpineCS = typeof(PartyGame.Runtime.Spine.PartyGameGuiSpineCS)

function PartyGameGuiSpine.Create(gameObj)
	return (MonoHelper.addNoUpdateLuaComOnceToGo(gameObj, PartyGameGuiSpine))
end

function PartyGameGuiSpine:_onResLoaded()
	PartyGameGuiSpine.super._onResLoaded(self)

	local csUISpineEvt = self._spineGo:GetComponent(self._animationEvent)

	csUISpineEvt:SetAnimEventCallback(self.onAnimEventCallback, self)

	if self.partyGameGuiSpineCS == nil then
		self.partyGameGuiSpineCS = gohelper.onceAddComponent(self._spineGo, PartyGameGuiSpine.Type_PartyGameGuiSpineCS)
	end

	self.partyGameGuiSpineCS:SetSkins(self.body, self.head, self.trousers, self.shoes, self.hat, self.clothes)

	self._skeletonComponent = self._spineGo:GetComponent(GuiSpine.TypeSkeletonGraphic)
	self._mat = UnityEngine.Object.Instantiate(self._skeletonComponent.material)
	self._skeletonComponent.material = self._mat

	self:play("idle", true)
end

function PartyGameGuiSpine:setSkin(resMap)
	self.body = resMap[PartyClothEnum.ClothType.Body] or ""
	self.head = resMap[PartyClothEnum.ClothType.Head] or ""
	self.trousers = resMap[PartyClothEnum.ClothType.Pant] or ""
	self.shoes = resMap[PartyClothEnum.ClothType.Shoes] or ""
	self.hat = resMap[PartyClothEnum.ClothType.Hat] or ""
	self.clothes = resMap[PartyClothEnum.ClothType.Jacket] or ""

	if self.partyGameGuiSpineCS then
		self.partyGameGuiSpineCS:SetSkins(self.body, self.head, self.trousers, self.shoes, self.hat, self.clothes)
	end
end

function PartyGameGuiSpine:play(bodyName, loop, isBackToIdle, isAudio)
	self._curBodyName = bodyName

	self:setBodyAnimation(bodyName, loop, 0.2)

	if isBackToIdle then
		self.setActionEventCb(self, self.onPlayScoreAnimEnd, self)
	end

	if isAudio then
		if bodyName == "happyLoop" then
			AudioMgr.instance:trigger(AudioEnum3_4.PartyGame.coommon_hero_happy)
		elseif bodyName == "sad" then
			AudioMgr.instance:trigger(AudioEnum3_4.PartyGame.coommon_hero_sad)
		end
	end
end

function PartyGameGuiSpine:onPlayScoreAnimEnd()
	self:clearActionEventCb()
	self:play("idle", true)
end

function PartyGameGuiSpine:setActionEventCb(animEvtCb, animEvtCbObj)
	self._actionCb = animEvtCb
	self._actionCbObj = animEvtCbObj
end

function PartyGameGuiSpine:clearActionEventCb()
	self._actionCb = nil
	self._actionCbObj = nil
end

function PartyGameGuiSpine:setGraphicMatPropFloat(nameId, value)
	if not self:getSkeletonGraphic() then
		return
	end

	local mat = self:getSkeletonGraphic().material

	if not mat then
		return
	end

	mat:SetFloat(nameId, value)
end

function PartyGameGuiSpine:onAnimEventCallback(actName, evtName, args)
	if actName == SpineAnimState.idle1 or evtName == SpineAnimEvent.ActionStart then
		return
	end

	if self._actionCb then
		self._actionCb(self._actionCbObj, actName, evtName, args)
	end
end

function PartyGameGuiSpine:onDestroy()
	if self._mat then
		gohelper.destroy(self._mat)

		self._mat = nil
	end

	PartyGameGuiSpine.super.onDestroy(self)
end

return PartyGameGuiSpine
