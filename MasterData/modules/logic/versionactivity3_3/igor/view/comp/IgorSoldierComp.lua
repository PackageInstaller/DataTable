-- chunkname: @modules/logic/versionactivity3_3/igor/view/comp/IgorSoldierComp.lua

module("modules.logic.versionactivity3_3.igor.view.comp.IgorSoldierComp", package.seeall)

local IgorSoldierComp = class("IgorSoldierComp", LuaCompBase)

function IgorSoldierComp:init(go)
	self.go = go
	self.transform = self.go.transform
	self.goRoot = gohelper.findChild(self.go, "root")
	self.imgBg = gohelper.findChildImage(self.goRoot, "bg")
	self.imgBgLight = gohelper.findChildImage(self.goRoot, "bg/bg_light")
	self.goBgLight = self.imgBgLight.gameObject
	self.goHp = gohelper.findChild(self.goRoot, "HP")
	self.trsHp = self.goHp.transform
	self.imgHp = gohelper.findChildImage(self.goHp, "image_FG")
	self.hpCanvasGroup = gohelper.onceAddComponent(self.goHp, typeof(UnityEngine.CanvasGroup))
	self.anim = self.goRoot:GetComponent(typeof(UnityEngine.Animator))
	self.goGold = gohelper.findChild(self.goRoot, "bg/bg_goldlight")
end

function IgorSoldierComp:addEventListeners()
	return
end

function IgorSoldierComp:removeEventListeners()
	return
end

function IgorSoldierComp:playAnimation(state, time, force)
	if self.state == state and not force then
		return
	end

	self.state = state

	self.anim:Play(state, 0, 0)
	TaskDispatcher.cancelTask(self.onAnimationDone, self)

	if time and time > 0 then
		TaskDispatcher.runDelay(self.onAnimationDone, self, time)
	end
end

function IgorSoldierComp:onAnimationDone()
	if self.state == IgorEnum.EntityAnimName.Die and self.deadCallback then
		self.deadCallback(self.deadCallbackObj, self)
	end

	self.state = nil
end

function IgorSoldierComp:setDeadCallback(callback, callbackObj)
	self.deadCallback = callback
	self.deadCallbackObj = callbackObj
end

function IgorSoldierComp:setUnitId(unitId, campType, soldierType)
	self.campType = campType
	self.unitId = unitId
	self.soldierType = soldierType

	self:refresh()
end

function IgorSoldierComp:refresh()
	local mo = self:getEntityMo()

	self:refreshSoldierInfo()
	self:refreshHp()
	self:updatePos()
end

function IgorSoldierComp:refreshSoldierInfo()
	local mo = self:getEntityMo()
	local isOur = self.campType == IgorEnum.CampType.Ourside
	local resName = isOur and string.format("img_bingren_our_%s", self.soldierType) or string.format("img_bingren_%s", self.soldierType)

	UISpriteSetMgr.instance:setV3a3IgorSprite(self.imgBg, resName, true)
	UISpriteSetMgr.instance:setV3a3IgorSprite(self.imgBgLight, resName, true)

	local posX, posY = mo:getPos()

	recthelper.setAnchor(self.transform, posX, posY)
	transformhelper.setLocalScale(self.goRoot.transform, isOur and 1 or -1, 1, 1)
	gohelper.setActive(self.goGold, mo.config.isHero == 1)
	SLFramework.UGUI.GuiHelper.SetColor(self.imgHp, isOur and "#6C9CD3" or "#A25B5B")
end

function IgorSoldierComp:refreshHp(tween)
	local mo = self:getEntityMo()

	if not mo then
		return
	end

	local hp = mo:getHealth()

	hp = math.max(0, hp)

	local maxHp = mo:getMaxHealth()

	if hp == self.lastHp and maxHp == self.lastMaxHp then
		return
	end

	if self.lastHp then
		local isHit = hp < self.lastHp

		self:clearHpTween()

		self.lastHp = hp
		self.lastMaxHp = maxHp

		local endValue = hp / maxHp

		gohelper.setActive(self.goHp, endValue ~= 1)

		self.hpCanvasGroup.alpha = 1

		if tween then
			self.hpTweenId = ZProj.TweenHelper.DOFillAmount(self.imgHp, endValue, 0.2, self.onHpTweenComplete, self, nil, EaseType.Linear)
		else
			self.imgHp.fillAmount = endValue
		end

		if isHit then
			self:onHit()
		end
	end
end

function IgorSoldierComp:onHpTweenComplete()
	if self.lastHp and self.lastHp <= 0 then
		self:onDead()
	end
end

function IgorSoldierComp:onUpdate(deltaTime)
	self:updatePos()
	self:updateState()
end

function IgorSoldierComp:updateState()
	local mo = self:getEntityMo()

	if not mo then
		return
	end

	local isStateChange = mo:getIsStateChange()

	if not isStateChange then
		return
	end

	local state = mo:getCurState()

	if state == IgorEnum.EntityState.In then
		gohelper.setActive(self.go, true)
		self:playAnimation(IgorEnum.EntityAnimName.In, 0.8)
		AudioMgr.instance:trigger(AudioEnum3_3.Igor.play_ui_yuanzheng_igor_place)
	elseif state == IgorEnum.EntityState.Move then
		self:playAnimation(IgorEnum.EntityAnimName.Move)
	elseif state == IgorEnum.EntityState.Die then
		self:playAnimation(IgorEnum.EntityAnimName.Die, 0.5)
	elseif state == IgorEnum.EntityState.Attack then
		self:playAnimation(IgorEnum.EntityAnimName.Attack, 0.33)

		if self.soldierType == IgorEnum.SoldierType.Infantry or self.soldierType == IgorEnum.SoldierType.Chariot then
			AudioMgr.instance:trigger(AudioEnum3_3.Igor.play_ui_yuanzheng_igor_infantry)
		elseif self.soldierType == IgorEnum.SoldierType.Artillery then
			AudioMgr.instance:trigger(AudioEnum3_3.Igor.play_ui_yuanzheng_igor_artillery)
		elseif self.soldierType == IgorEnum.SoldierType.Cavalry then
			AudioMgr.instance:trigger(AudioEnum3_3.Igor.play_ui_yuanzheng_igor_sword)
		end
	elseif state == IgorEnum.EntityState.WaitAttack then
		if self.state ~= IgorEnum.EntityAnimName.Attack then
			self:playAnimation(IgorEnum.EntityAnimName.Idle)
		end
	else
		self:playAnimation(IgorEnum.EntityAnimName.Idle)
	end

	if state == IgorEnum.EntityState.Move then
		self:playMoveAudio()
	else
		self:stopMoveAudio()
	end
end

function IgorSoldierComp:updatePos()
	local mo = self:getEntityMo()
	local posX = mo:getPos()
	local curPosX = recthelper.getAnchorX(self.transform)

	if math.abs(curPosX - posX) < 0.01 then
		return
	end

	self:moveToPosX(self.transform, posX)
end

function IgorSoldierComp:moveToPosX(transform, posX, tween)
	self:clearPosTween()

	self.posTweenId = ZProj.TweenHelper.DOAnchorPosX(transform, posX, 0.05, nil, nil, nil, EaseType.Linear)
end

function IgorSoldierComp:getEntityMo()
	local gameMo = IgorModel.instance:getCurGameMo()

	return (gameMo:getEntityMoByUnitId(self.unitId, self.campType))
end

function IgorSoldierComp:clearHpTween()
	if self.hpTweenId then
		ZProj.TweenHelper.KillById(self.hpTweenId)

		self.hpTweenId = nil
	end
end

function IgorSoldierComp:clearPosTween()
	if self.posTweenId then
		ZProj.TweenHelper.KillById(self.posTweenId)

		self.posTweenId = nil
	end
end

function IgorSoldierComp:onHit()
	gohelper.setActive(self.goBgLight, false)
	gohelper.setActive(self.goBgLight, true)
end

function IgorSoldierComp:onDead()
	self:onRelease()
	self:playAnimation("die", 0.5)

	self.hpAplhaTween = ZProj.TweenHelper.DOFadeCanvasGroup(self.goHp, 1, 0, 0.3)
end

function IgorSoldierComp:playMoveAudio()
	if self.moveAudioId then
		return
	end

	self.moveAudioId = AudioMgr.instance:trigger(AudioEnum3_3.Igor.play_ui_yuanzheng_igor_move)
end

function IgorSoldierComp:stopMoveAudio()
	if self.moveAudioId then
		AudioMgr.instance:trigger(AudioEnum3_3.Igor.stop_ui_yuanzheng_igor_move)

		self.moveAudioId = nil
	end
end

function IgorSoldierComp:clear()
	self:stopMoveAudio()
	TaskDispatcher.cancelTask(self.onAnimationDone, self)
	self:clearPosTween()
	self:clearHpTween()

	if self.hpAplhaTween then
		ZProj.TweenHelper.KillById(self.hpAplhaTween)

		self.hpAplhaTween = nil
	end
end

function IgorSoldierComp:onRelease()
	self:clear()
end

function IgorSoldierComp:onDestroy()
	self:clear()
end

return IgorSoldierComp
