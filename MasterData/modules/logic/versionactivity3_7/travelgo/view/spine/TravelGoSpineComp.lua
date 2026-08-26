-- chunkname: @modules/logic/versionactivity3_7/travelgo/view/spine/TravelGoSpineComp.lua

module("modules.logic.versionactivity3_7.travelgo.view.spine.TravelGoSpineComp", package.seeall)

local TravelGoSpineComp = class("TravelGoSpineComp", LuaCompBase)

function TravelGoSpineComp:init(viewGO)
	self.viewGO = viewGO
	self.transform = viewGO.transform
	self.animator = self.viewGO:GetComponent(gohelper.Type_Animator)
	self.bar = gohelper.findChild(self.viewGO, "root/bar")
	self.spine = gohelper.findChild(self.viewGO, "root/spine")
	self.go_Counter = gohelper.findChild(self.viewGO, "root/#go_Counter")
	self.go_Combo = gohelper.findChild(self.viewGO, "root/#go_Combo")
	self.textComboNum = gohelper.findChildText(self.viewGO, "root/#go_Combo/container/textComboNum")
	self.battleBar = GameFacade.createLuaCompByGo(self.bar, TravelGoBattleBar, nil, self.viewContainer)
end

function TravelGoSpineComp:addEventListeners()
	self.addEventCb(self, TravelGoController.instance, TravelGoEvent.OnEntityAttack, self.onEntityAttack, self)
	self.addEventCb(self, TravelGoController.instance, TravelGoEvent.OnEntityHit, self.onEntityHit, self)
	self.addEventCb(self, TravelGoController.instance, TravelGoEvent.OnEntityDie, self.onEntityDie, self)
	self.addEventCb(self, TravelGoController.instance, TravelGoEvent.OnPlaySpineAnim, self.playSpineAnim, self)
	self.addEventCb(self, TravelGoController.instance, TravelGoEvent.OnBattleStart, self.onBattleStart, self)
	self.addEventCb(self, TravelGoController.instance, TravelGoEvent.OnBattleEventFinish, self.onBattleEventFinish, self)
	self.addEventCb(self, TravelGoController.instance, TravelGoEvent.OnComboTip, self.onComboTip, self)
	self.addEventCb(self, TravelGoController.instance, TravelGoEvent.OnCounterTip, self.onCounterTip, self)
end

function TravelGoSpineComp:onBattleStart()
	self:setSkeletonTimeScale(true)
end

function TravelGoSpineComp:onBattleEventFinish()
	self:setSkeletonTimeScale()
end

function TravelGoSpineComp:onComboTip(uid, comboCount)
	if self.entity.uid ~= uid then
		return
	end

	gohelper.setActive(self.go_Combo, true)

	self.textComboNum.text = "×" .. comboCount

	TaskDispatcher.runDelay(self.onComboTipFinish, self, 0.5)
end

function TravelGoSpineComp:onComboTipFinish()
	gohelper.setActive(self.go_Combo, false)
	TaskDispatcher.cancelTask(self.onComboTipFinish, self)
end

function TravelGoSpineComp:onCounterTip(uid)
	if self.entity.uid ~= uid then
		return
	end

	gohelper.setActive(self.go_Counter, true)
	TaskDispatcher.runDelay(self.onCounterTipFinish, self, 0.5)
end

function TravelGoSpineComp:onCounterTipFinish()
	gohelper.setActive(self.go_Counter, false)
	TaskDispatcher.cancelTask(self.onCounterTipFinish, self)
end

function TravelGoSpineComp:setSkeletonTimeScale(isInBattle)
	if not self.skeleton then
		return
	end

	self.skeleton.timeScale = isInBattle and (TravelGoConfig.instance:getConsValue(TravelGoModel.instance.activityId, TravelGoConst.ConstId.BattleSpeed, true) or 1) or TravelGoConfig.instance:getConsValue(TravelGoModel.instance.activityId, TravelGoConst.ConstId.NormalSpeed, true) or 1
end

function TravelGoSpineComp:playSpineAnim(uid, animName, isLoop, isBackToIdle)
	if not self.skeleton then
		return
	end

	if self.entity.uid ~= uid then
		return
	end

	if string.nilorempty(animName) then
		return
	end

	if isLoop == nil then
		isLoop = false
	end

	if isBackToIdle == nil then
		isBackToIdle = true
	end

	self:play(animName, isLoop, isBackToIdle)
end

function TravelGoSpineComp:onEntityAttack(uid)
	self:playSpineAnim(uid, "attack", false, true)
end

function TravelGoSpineComp:onEntityHit(uid)
	self:playSpineAnim(uid, "hit", false, true)
end

function TravelGoSpineComp:onEntityDie(uid)
	self:playSpineAnim(uid, "die", false, false)

	if self.entity.uid == uid then
		if self.entityType == TravelGoBattleEnum.EntityType.Player then
			AudioMgr.instance:trigger(AudioEnum3_7.TravelGo.play_ui_beiai_xran_death)
		else
			AudioMgr.instance:trigger(AudioEnum3_7.TravelGo.play_ui_beiai_xran_monster_death)
		end
	end
end

function TravelGoSpineComp:setData(entity)
	self.uid = entity.uid
	self.entity = entity
	self.entityType = entity.entityType

	self:onSetData()

	if self.spineGO then
		gohelper.destroy(self.spineGO)

		self.spineGO = nil
	end

	if self.loader then
		self.loader:dispose()

		self.loader = nil
	end

	if not string.nilorempty(self.res) then
		self.loader = SequenceAbLoader.New()

		self.loader:addPath(self.res)
		self.loader:startLoad(self.onLoaded, self)
	end

	self.battleBar:setEntity(self.entity)
	self.entity:setGetAnimTimeFunc(self.getAnimTime, self)
end

function TravelGoSpineComp:onSetData()
	return
end

function TravelGoSpineComp:onLoaded(loader)
	local prefabAssetItem = loader:getAssetItem(self.res)

	if not prefabAssetItem then
		return
	end

	local prefab = prefabAssetItem:GetResource(self.res)

	self.spineGO = gohelper.clone(prefab, self.spine)
	self.skeleton = self.spineGO:GetComponent(typeof(Spine.Unity.SkeletonGraphic))
	self.skeleton.startingLoop = false

	local csUISpineEvt = self.spineGO:GetComponent(GuiSpine.TypeUISpineAnimationEvent)

	csUISpineEvt:SetAnimEventCallback(self.onAnimComplete, self)
	self.skeleton:SetScaleX((self.dir == SpineLookDir.Left or nil) and (SpineLookDir.Left or SpineLookDir.Right))
	self:setSkeletonTimeScale()
	self:playBorn()
	TravelGoController.instance:dispatchEvent(TravelGoEvent.OnCreateEntityComplete, self.entity.uid)
end

function TravelGoSpineComp:isPlayer()
	return self.entityType == TravelGoBattleEnum.EntityType.Player
end

function TravelGoSpineComp:isNpc()
	return self.entityType == TravelGoBattleEnum.EntityType.Npc
end

function TravelGoSpineComp:playBorn()
	self:play("idle", true, false)
end

function TravelGoSpineComp:play(animState, isLoop, isBackToIdle, callBack, context)
	if not self.skeleton then
		return
	end

	self.curAnim = animState
	self.isLoop = isLoop
	self.isBackToIdle = isBackToIdle
	self.callBack = callBack
	self.context = context

	if self.skeleton:HasAnimation(animState) then
		self.skeleton:SetAnimation(0, animState, isLoop, 0.2)
	end
end

function TravelGoSpineComp:onAnimComplete(actName, evtName, args)
	if self.curAnim ~= actName or self.isLoop or evtName == SpineAnimEvent.ActionStart then
		return
	end

	self.curAnim = nil

	if self.callBack then
		self.callBack(self.context, actName, evtName, args)

		self.callBack = nil
		self.context = nil
	end

	if self.isBackToIdle then
		self:play("idle", true)

		self.isBackToIdle = nil
	end
end

function TravelGoSpineComp:onPlayerMoveToAttack(isBack, moveTime)
	if self.attackTweenId then
		ZProj.TweenHelper.KillById(self.attackTweenId)

		self.attackTweenId = nil
	end

	local dur = 200

	if self.entityType == TravelGoBattleEnum.EntityType.Player then
		self.attackTweenId = isBack and ZProj.TweenHelper.DOAnchorPosX(self.transform, -428, moveTime) or ZProj.TweenHelper.DOAnchorPosX(self.transform, 400 - dur, moveTime)
	elseif self.entityType == TravelGoBattleEnum.EntityType.Enemy then
		self.attackTweenId = isBack and ZProj.TweenHelper.DOAnchorPosX(self.transform, 400, moveTime) or ZProj.TweenHelper.DOAnchorPosX(self.transform, -428 + dur, moveTime)
	end
end

function TravelGoSpineComp:getAnimTime(animName)
	local findAnim = self.skeleton.SkeletonData:FindAnimation(animName)

	if findAnim then
		return findAnim.Duration
	end
end

function TravelGoSpineComp:playUIAnim(animName)
	if string.nilorempty(animName) then
		return
	end

	if self.animator then
		self.animator:Play(animName, 0, 0)
	end
end

function TravelGoSpineComp:onDestroy()
	TaskDispatcher.cancelTask(self.onComboTipFinish, self)
	TaskDispatcher.cancelTask(self.onCounterTipFinish, self)

	if self.attackTweenId then
		ZProj.TweenHelper.KillById(self.attackTweenId)

		self.attackTweenId = nil
	end

	if self.loader then
		self.loader:dispose()

		self.loader = nil
	end

	self.animator = nil
end

return TravelGoSpineComp
