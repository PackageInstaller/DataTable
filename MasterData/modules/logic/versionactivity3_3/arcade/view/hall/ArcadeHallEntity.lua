-- chunkname: @modules/logic/versionactivity3_3/arcade/view/hall/ArcadeHallEntity.lua

module("modules.logic.versionactivity3_3.arcade.view.hall.ArcadeHallEntity", package.seeall)

local ArcadeHallEntity = class("ArcadeHallEntity", LuaCompBase)

function ArcadeHallEntity:initEntity(go, mo, loader)
	self.go = go
	self.trans = self.go.transform
	self.mo = mo
	self._posList = {}
	self.root = gohelper.findChild(go, "ani/scale")

	self:refreshPosition()
	self:_refreshTrans()

	self.loader = loader

	self:initComponents()
end

function ArcadeHallEntity:refreshEntity(mo)
	self.mo = mo

	self:refreshPosition()
end

function ArcadeHallEntity:initComponents()
	self:_clearComps()
	self:_addComp("effectComp", ArcadeHallEntityEffectComp, true)
end

function ArcadeHallEntity:_clearComps()
	if self._compList then
		for _, comp in ipairs(self._compList) do
			local compName = comp:getCompName()

			self[compName] = nil

			comp:clear()
		end
	end

	self._compList = {}
end

function ArcadeHallEntity:_addComp(compName, compClass, useNewGO)
	local go = self.go

	if useNewGO then
		go = gohelper.findChild(self.go, compName)
		go = go or gohelper.create3d(self.go, compName)
	end

	local compInst = MonoHelper.addNoUpdateLuaComOnceToGo(go, compClass, {
		entity = self,
		compName = compName,
		loader = self.loader
	})

	self[compName] = compInst

	table.insert(self._compList, compInst)
end

function ArcadeHallEntity:_refreshTrans()
	local mo = self:getMO()

	if not mo then
		return
	end

	local co = mo:getCfg()

	if co.posOffset then
		local x = tonumber(co.posOffset[1])

		if co.posOffset then
			local y = tonumber(co.posOffset[2])

			if co.posOffset and y then
				transformhelper.setLocalPos(self.root.transform, co.posOffset, y, mo:getPosZ())
			end

			local scaleX = 1.5
			local scaleY = 1.5

			if co.scale then
				scaleX = tonumber(co.scale[1]) or scaleX
				scaleY = tonumber(co.scale[2]) or scaleY
			end

			transformhelper.setLocalScale(self.root.transform, scaleX, scaleY, 1)
		end
	end
end

function ArcadeHallEntity:showEntity(isShow)
	gohelper.setActive(self.go, isShow)
end

function ArcadeHallEntity:isShowEntity()
	return self.go.activeSelf
end

function ArcadeHallEntity:refreshPosition()
	if self._tweenIdMove then
		ZProj.TweenHelper.KillById(self._tweenIdMove)

		self._tweenIdMove = nil
	end

	self._posList = {}

	local mo = self:getMO()

	if not mo then
		return
	end

	local posX, posY = mo:getEntityPos()

	transformhelper.setLocalPos(self.trans, posX, posY, mo:getPosZ())

	self._gridX, self._gridY = mo:getGridPos()
end

function ArcadeHallEntity:doMove(callback, callbackObj)
	local mo = self:getMO()

	if not mo then
		return
	end

	local posX, posY = mo:getEntityPos()
	local _posX, _posY = transformhelper.getLocalPos(self.trans)

	if _posX == posX and _posY == posY then
		callback(callbackObj)

		return
	end

	self._finishMoveCb = callback
	self._finishMoveCbObj = callbackObj

	self:_onMove({
		x = posX,
		y = posY
	})
end

function ArcadeHallEntity:_onMove(pos)
	local pos1 = self._posList[1]

	if not pos1 or pos1.x ~= pos.x or pos1.y ~= pos.y then
		table.insert(self._posList, 1, pos)
	end

	if #self._posList == 1 then
		self:_onMoveCB(pos)
	end
end

function ArcadeHallEntity:_onMoveCB(pos)
	local posX, posY = pos.x, pos.y

	self._tweenIdMove = ZProj.TweenHelper.DOLocalMove(self.trans, posX, posY, self.mo:getPosZ(), ArcadeHallEnum.HeroMoveSpeed, self._onFinishMoveCB, self, nil, EaseType.OutExpo)

	self:playMoveAni()
	self:_setRotation()

	local mo = self:getMO()

	self._gridX, self._gridY = mo:getGridPos()
end

function ArcadeHallEntity:_onFinishMoveCB()
	local index = #self._posList

	if index > 0 then
		table.remove(self._posList, index)
	end

	index = #self._posList

	if #self._posList == 0 then
		if self._finishMoveCb and self._finishMoveCbObj then
			self._finishMoveCb(self._finishMoveCbObj)
		end

		return
	end

	local pos = self._posList[index]

	self:_onMoveCB(pos)
end

function ArcadeHallEntity:_setRotation()
	local mo = self:getMO()
	local gridX, gridY = mo:getGridPos()

	if not self._gridX or not self._gridY then
		self._gridX, self._gridY = mo:getGridPos()
	end

	if gridX < self._gridX then
		transformhelper.setLocalRotation(self.trans, 0, 0, 0)
	elseif gridX > self._gridX then
		transformhelper.setLocalRotation(self.trans, 0, 180, 0)
	end
end

function ArcadeHallEntity:getWorldPos()
	return self.trans.position
end

function ArcadeHallEntity:getMO()
	return self.mo
end

function ArcadeHallEntity:playBornAni()
	local co = ArcadeConfig.instance:getActionShowCfg(ArcadeEnum.ActionShow.Born)

	if not co then
		return
	end

	local effectIds = co.effectIds

	if effectIds then
		self:_playAnim(effectIds, 1)
	end

	AudioMgr.instance:trigger(AudioEnum3_3.Arcade.play_ui_yuanzheng_transmit)
end

function ArcadeHallEntity:playMoveAni()
	local co = ArcadeConfig.instance:getActionShowCfg(ArcadeEnum.ActionShow.Move)

	if not co then
		return
	end

	local effectIds = co.effectIds

	if effectIds then
		self:_playAnim(effectIds, 1)
	end

	AudioMgr.instance:trigger(AudioEnum3_3.Arcade.play_ui_yuanzheng_move)
end

function ArcadeHallEntity:playIdleAnim()
	local co = ArcadeConfig.instance:getStateShowCfg(ArcadeEnum.StateShow.Idle)
	local effectId = co.effectId

	self:_playEffect(effectId, true)
end

function ArcadeHallEntity:_playAnim(list, index)
	if index > #list then
		self:playIdleAnim()

		return
	end

	local effectId = list[index]

	self._playEffect(self, effectId, false, function()
		self:_playAnim(list, index + 1)
	end, self)
end

function ArcadeHallEntity:_playEffect(effectId, isIdle, callback, callbackObj)
	local co = ArcadeConfig.instance:getArcadeEffectCfg(effectId)

	if self.effectComp then
		self.effectComp:playEffect(effectId)
	end

	local animName = co.triggerAnimation

	if string.nilorempty(animName) then
		return
	end

	if isIdle then
		self:_playAnimator(animName)
	else
		self:_playAnimatorPlayer(co.triggerAnimation, callback, callbackObj)
	end
end

function ArcadeHallEntity:_playAnimatorPlayer(animName, callback, callbackObj)
	self._animPlayer = self._animPlayer or SLFramework.AnimatorPlayer.Get(self.go)

	self._animPlayer:Play(animName, callback, callbackObj)
end

function ArcadeHallEntity:_playAnimator(animName)
	self._anim = self._anim or self.go:GetComponent(typeof(UnityEngine.Animator))
	self._anim.enabled = true

	self._anim:Play(animName, 0, 0)
end

function ArcadeHallEntity:clear()
	if self._tweenIdMove then
		ZProj.TweenHelper.KillById(self._tweenIdMove)

		self._tweenIdMove = nil
	end

	self._posList = {}
end

function ArcadeHallEntity:onDestroy()
	self:clear()
	self:_clearComps()
end

return ArcadeHallEntity
