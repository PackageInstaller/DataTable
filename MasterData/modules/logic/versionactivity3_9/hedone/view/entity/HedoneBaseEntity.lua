-- chunkname: @modules/logic/versionactivity3_9/hedone/view/entity/HedoneBaseEntity.lua

module("modules.logic.versionactivity3_9.hedone.view.entity.HedoneBaseEntity", package.seeall)

local HedoneBaseEntity = class("HedoneBaseEntity", LuaCompBase)

function HedoneBaseEntity:ctor()
	self:onCtor()
end

function HedoneBaseEntity:init(go)
	self._go = go
	self._trans = self._go.transform
	self._originalScaleX, self._originalScaleY = transformhelper.getLocalScale(self._trans)
	self._goEffectsNode = gohelper.findChild(self._go, "#go_effects")
	self._canvasGroup = gohelper.onceAddComponent(self._go, gohelper.Type_CanvasGroup)
	self._effectGODict = self:getUserDataTb_()
	self._prefabTransDict = self:getUserDataTb_()
	self._effectName2PSComp = self:getUserDataTb_()

	self:_onInit()
end

function HedoneBaseEntity:setUid(uid)
	self._uid = uid

	local mo = self:getMO()

	self._id = mo:getId()
	self._entityType = mo:getEntityType()
	self._go.name = string.format("%s-%s-%s", self._entityType, self._id, self._uid)
	self._curAnim = nil

	self:_onSetUid()
	self:_doActiveGO()
end

function HedoneBaseEntity:_doActiveGO()
	self:refreshScale()
	self:refreshPosition()

	self._canvasGroup.alpha = 1
end

function HedoneBaseEntity:refreshScale()
	local scaleFactor = HedoneGameEnum.Const.BaseScaleFactor
	local mo = self:getMO()

	if mo then
		scaleFactor = mo:getScaleFactor()
	end

	local scaleX = self._originalScaleX * scaleFactor
	local scaleY = self._originalScaleY * scaleFactor

	transformhelper.setLocalScale(self._trans, scaleX, scaleY, 1)
end

function HedoneBaseEntity:refreshPosition()
	local mo = self:getMO()

	if not mo then
		return
	end

	local x, y = mo:getPosition()

	transformhelper.setLocalPos(self._trans, x, y, 0)
	self:_onRefreshPosition()
end

function HedoneBaseEntity:setPrefab(obj, res)
	if not obj or string.nilorempty(res) then
		return
	end

	self:_clearPrefabGO()

	local cachedTrans = self._prefabTransDict[res]

	if not cachedTrans then
		local go = gohelper.clone(obj, self._go)

		cachedTrans = go.transform
		self._prefabTransDict[res] = go.transform
	end

	recthelper.setAnchorX(cachedTrans, 0)

	self._curPrefabTrans = cachedTrans
end

function HedoneBaseEntity:playAnim(animName, cb, cbObj, cbParams)
	if not self._animator or not self._animatorPlayer or string.nilorempty(animName) or self._curAnim == animName then
		return
	end

	local mo = self:getMO()
	local isAlive = mo and mo:getIsAlive()

	if not isAlive and animName ~= HedoneGameEnum.EntityAnimName.Die then
		return
	end

	self._curAnim = animName

	if cb then
		self._animatorPlayer:Play(animName, cb, cbObj, cbParams)
	else
		self._animator:Play(animName, 0, 0)
	end
end

function HedoneBaseEntity:addEffect(effectName, effectObj)
	local isNeedLoad = self:getIsNeedLoadEffect(effectName)

	if not isNeedLoad or not effectObj then
		return
	end

	local effectGO = gohelper.clone(effectObj, self._goEffectsNode)

	if gohelper.isNil(effectGO) then
		return
	end

	self._effectGODict[effectName] = effectGO
	self._effectName2PSComp[effectName] = effectGO:GetComponent(typeof(Coffee.UIExtensions.UIParticle))
end

function HedoneBaseEntity:playEffect(effectName)
	local psComp = self._effectName2PSComp[effectName]

	if not psComp then
		return
	end

	psComp:Play()
end

function HedoneBaseEntity:getEntityType()
	return self._entityType
end

function HedoneBaseEntity:getUid()
	return self._uid
end

function HedoneBaseEntity:getId()
	return self._id
end

function HedoneBaseEntity:getMO()
	local entityType = self:getEntityType()
	local uid = self:getUid()
	local mo = HedoneGameModel.instance:getEntityMO(uid, entityType)

	if not mo then
		logError(string.format("HedoneBaseEntity.getMO error, entityType:%s, id:%s, uid:%s, mo is nil", self._entityType, self._id, self._uid))
	end

	return mo
end

function HedoneBaseEntity:getIsNeedLoadEffect(effectName)
	if gohelper.isNil(self._goEffectsNode) or string.nilorempty(effectName) then
		return false
	end

	return gohelper.isNil(self._effectGODict[effectName])
end

function HedoneBaseEntity:recycle()
	self._uid = nil
	self._id = nil
	self._entityType = nil
	self._go.name = HedoneGameEnum.Const.EntityDefaultName
	self._curAnim = nil

	self:_disableAllEffect()
	self:onRecycle()

	self._canvasGroup.alpha = 0
end

function HedoneBaseEntity:_clearPrefabGO()
	if self._curPrefabTrans then
		recthelper.setAnchorX(self._curPrefabTrans, HedoneGameEnum.Const.DisablePos)
	end

	self._curPrefabTrans = nil
end

function HedoneBaseEntity:_disableAllEffect()
	for _, psComp in pairs(self._effectName2PSComp) do
		psComp:Stop()
		psComp:Clear()
	end
end

function HedoneBaseEntity:onCtor()
	return
end

function HedoneBaseEntity:_onInit()
	return
end

function HedoneBaseEntity:addEventListeners()
	return
end

function HedoneBaseEntity:removeEventListeners()
	return
end

function HedoneBaseEntity:_onSetUid()
	return
end

function HedoneBaseEntity:getPrefabResPath()
	return
end

function HedoneBaseEntity:_onRefreshPosition()
	return
end

function HedoneBaseEntity:onTakeDamage(damage, isCrit)
	return
end

function HedoneBaseEntity:onRecycle()
	return
end

function HedoneBaseEntity:onDestroy()
	return
end

return HedoneBaseEntity
