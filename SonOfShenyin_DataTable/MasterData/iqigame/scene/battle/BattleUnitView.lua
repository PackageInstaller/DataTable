-- chunkname: @IQIGame\\Scene\\Battle\\BattleUnitView.lua

local BattleBuffView = require("IQIGame.Scene.Battle.BattleBuffView")
local BattleUnitView = {
	size = 1,
	autoResetIdle = true,
	uniqueEntityID = 0,
	battleUnitID = 0,
	state = 0,
	hideSpine = false,
	canSelected = false,
	disableGlobalAlpha = true,
	isReadyToShow = false,
	buffsViewData = {},
	animList = {}
}

function BattleUnitView.New(battleUnitID)
	local obj = Clone(BattleUnitView)

	obj:__Init(battleUnitID)

	return obj
end

function BattleUnitView:__Init(battleUnitID)
	self.battleUnitID = battleUnitID
	self.isReadyToShow = false
	self.autoResetIdle = false
	self.state = BattleConstant.BattleUnitState.idle
	self.parentPositionOffset = Vector3.zero
	self.controlType = Constant.ControlType.NONE

	function self.delegateShowEntitySuccessEvent(sender, args)
		self:__OnShowEntitySuccess(sender, args)
	end

	self.buffsViewData = {}
	self.buffEffectCacheTable = {}

	self:__InitDelegateFunc()
end

function BattleUnitView:__InitDelegateFunc()
	function self.__delegateOnBattleUnitAddBuff(battleUnitID, buffCid)
		self:__OnBattleUnitAddBuff(battleUnitID, buffCid)
	end

	function self.__delegateOnBattleUnitUpdateBuff(battleUnitID, buffCid, stackDifference, roundDifference)
		self:__OnBattleUnitUpdateBuff(battleUnitID, buffCid, stackDifference, roundDifference)
	end

	function self.__delegateOnBattleUnitTriggerBuff(battleUnitID, buffCid)
		self:__OnBattleUnitTriggerBuff(battleUnitID, buffCid)
	end

	function self.__delegateOnBattleUnitRemoveBuff(battleUnitID, buffCid)
		self:__OnBattleUnitRemoveBuff(battleUnitID, buffCid)
	end

	function self.__delegateOnBattleUnitStatusChange(battleUnitID, fightStatusID, value)
		self:OnBattleUnitStatusChange(battleUnitID, fightStatusID, value)
	end

	function self.__delegateOnBattleUnitWakeNumChange(battleUnitID)
		self:OnBattleUnitWakeNumChange(battleUnitID)
	end
end

function BattleUnitView:__AddListeners()
	EventDispatcher.AddEventListener(EventID.BattleUnitAddBuff, self.__delegateOnBattleUnitAddBuff)
	EventDispatcher.AddEventListener(EventID.BattleUnitUpdateBuff, self.__delegateOnBattleUnitUpdateBuff)
	EventDispatcher.AddEventListener(EventID.BattleUnitTriggerBuff, self.__delegateOnBattleUnitTriggerBuff)
	EventDispatcher.AddEventListener(EventID.BattleUnitRemoveBuff, self.__delegateOnBattleUnitRemoveBuff)
	EventDispatcher.AddEventListener(EventID.BattleUnitStatusChange, self.__delegateOnBattleUnitStatusChange)
	EventDispatcher.AddEventListener(EventID.BattleUnitWakeNumChange, self.__delegateOnBattleUnitWakeNumChange)
end

function BattleUnitView:__RemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.BattleUnitAddBuff, self.__delegateOnBattleUnitAddBuff)
	EventDispatcher.RemoveEventListener(EventID.BattleUnitUpdateBuff, self.__delegateOnBattleUnitUpdateBuff)
	EventDispatcher.RemoveEventListener(EventID.BattleUnitTriggerBuff, self.__delegateOnBattleUnitTriggerBuff)
	EventDispatcher.RemoveEventListener(EventID.BattleUnitRemoveBuff, self.__delegateOnBattleUnitRemoveBuff)
	EventDispatcher.RemoveEventListener(EventID.BattleUnitStatusChange, self.__delegateOnBattleUnitStatusChange)
	EventDispatcher.RemoveEventListener(EventID.BattleUnitWakeNumChange, self.__delegateOnBattleUnitWakeNumChange)

	if self.playableDirector == nil then
		return
	end

	self.playableDirector.played = self.playableDirector.played - self.__delegateOnTimelinePlayed
	self.playableDirector.stopped = self.playableDirector.stopped - self.__delegateOnTimelineStopped
end

function BattleUnitView:Dispose()
	if self.hitColorCoroutine then
		self.hitColorCoroutine:Stop()
	end

	BattleEffectModule.DisposeBattleUnitRendererFeatureComponent(self)
	self:__RemoveListeners()

	self.autoResetIdle = false
	self.isReadyToShow = false

	if self.skinEntityGo ~= nil then
		self.skinEntityGo = nil
		self.spineRoot = nil
		self.boxCollider = nil
		self.playableDirector = nil
		self.skeletonAnimation.timeScale = 1
		self.skeletonAnimation = nil
	end

	for _, _buffView in pairs(self.buffsViewData) do
		_buffView:Dispose()
	end

	self.buffsViewData = nil

	GameEntry.Entity:HideEntity(self.uniqueEntityID)

	self.uniqueEntityID = nil
end

function BattleUnitView:CreateView(battleUnitData, oldView, parent)
	self.size = battleUnitData.PODData.Size

	local monsterCfg = CfgMonsterTable[battleUnitData.monsterConfigID]

	self.hideSpine = monsterCfg.IsVisiable
	self.disableGlobalAlpha = monsterCfg.IsNotEnableGloablAlpha
	self.uniqueEntityID = GameEntry.Entity:GenerateEntityID()

	GameEntry.LuaEvent:Subscribe(ShowEntitySuccessEventArgs.EventId, self.delegateShowEntitySuccessEvent)
	GameEntry.Entity:ShowBattleElement(self.uniqueEntityID, battleUnitData.entityConfigID, 0, parent, Vector3.New(0, 0, 0))

	local elementEntityCfg = CfgElementEntityTable[battleUnitData.entityConfigID]
	local offsetCfg = elementEntityCfg.MonsterPosition
	local offsetX = type(offsetCfg[1]) == "number" and offsetCfg[1] or 0
	local offsetY = type(offsetCfg[2]) == "number" and offsetCfg[2] or 0

	self.parentPositionOffset = Vector3.New(offsetX, offsetY, 0)
end

function BattleUnitView:__OnShowEntitySuccess(sender, args)
	local uniqueEntityId = args.Entity.Id

	if self.uniqueEntityID ~= uniqueEntityId then
		return
	end

	GameEntry.LuaEvent:Unsubscribe(ShowEntitySuccessEventArgs.EventId, self.delegateShowEntitySuccessEvent)

	self.skinEntityGo = args.Entity.gameObject
	self.skinEntityGo.name = self.battleUnitID

	self:__InitBattleViewComponents()
end

function BattleUnitView:__InitBattleViewComponents()
	function self.__delegateOnTimelineStopped(playableDirector)
		if self.playableDirector == nil then
			logError("战斗单位 {0} 数据错误,timeline 播放完成之前就被销毁了", self.battleUnitID)

			return
		end

		self.playableDirector.stopped = self.playableDirector.stopped - self.__delegateOnTimelineStopped

		self:__OnTimelineCompleted(playableDirector)
	end

	self.playableDirector = self.skinEntityGo:GetComponent(typeof(UnityEngine.Playables.PlayableDirector))
	self.playableDirector.playOnAwake = false

	function self.__delegateOnTimelinePlayed()
		self.playableDirector.stopped = self.playableDirector.stopped + self.__delegateOnTimelineStopped
	end

	self.playableDirector.played = self.playableDirector.played + self.__delegateOnTimelinePlayed
	self.spineRoot = self.skinEntityGo.transform:Find(Battle.BattleTimelineManager.SPINE_ROOT_PATH).gameObject

	local spineGo = self.skinEntityGo.transform:Find(Battle.BattleTimelineManager.SPINE_PATH).gameObject

	spineGo.transform.localScale = Vector3.one
	self.roleEffect = BattleEffectModule.InitBattleUnitRendererFeatureComponent(self.battleUnitID, spineGo)

	if self.disableGlobalAlpha then
		self.roleEffect:SetEnable(false)
	end

	if self.hideSpine then
		self.roleEffect:SetEnable(false)

		local mr = spineGo:GetComponent(typeof(UnityEngine.MeshRenderer))

		mr.enabled = false
	end

	self.instanceID = spineGo:GetInstanceID()
	self.boxCollider = spineGo:GetComponent(typeof(UnityEngine.BoxCollider))
	self.boxCollider.enabled = false
	self.skeletonAnimation = spineGo:GetComponent(typeof(Spine.Unity.SkeletonAnimation))
	self.skeletonAnimation.loop = false

	self.skeletonAnimation:Initialize(true)

	self.hudFollowTarget = self.skinEntityGo.transform:FindChildByName("Ui/hud")

	if self.hudFollowTarget == nil then
		warning("战斗单位 {0} 预制体错误，找不到HUD绑点 Ui/hud", self.battleUnitID)

		self.hudFollowTarget = self.skinEntityGo.transform:FindChildByName("Ui")
	end

	self.lineTargetRoot = self.skinEntityGo.transform:FindChildByName("LineTarget")

	if self.lineTargetRoot == nil then
		logError("战斗单位 {0} 预制体错误，找不到LineTarget节点", self.battleUnitID)
	end

	self.hudFollowTarget.gameObject:SetActive(false)
	self:__InitCanvasProperty()

	self.autoResetIdle = true
	self.isReadyToShow = true
end

function BattleUnitView:__InitCanvasProperty()
	self.skillSelectPoint = self.skinEntityGo.transform:FindChildByName("Ui/tf_target").gameObject

	for i = 0, self.skillSelectPoint.transform.childCount - 1 do
		self.skillSelectPoint.transform:GetChild(i).gameObject:SetActive(false)
	end

	self.skillSelectPoint:SetActive(false)

	local targetDamage = self.skillSelectPoint.transform:FindChildByName("targetDamage0").gameObject

	targetDamage:SetActive(true)
end

function BattleUnitView:JoinBattle(parent, isUnitFlip, createType)
	self:ChangeParent(parent, isUnitFlip)

	if createType == BattleConstant.BattleUnitCreateType.Substitute then
		self:PlaySubstituteMonsterBornEffect()
	elseif createType == BattleConstant.BattleUnitCreateType.Summon then
		self:PlaySummonMonsterBornEffect()
	end
end

function BattleUnitView:OnJoinBattleComplete()
	self:PlayIdleAnim()
	self:__InitRendererTransferView()
	self:__InitBuffView()
	self:__AddListeners()
	BattleEffectModule.RefreshUnitRendererFeature(self.battleUnitID)
end

function BattleUnitView:SetVisible(active)
	self.spineRoot:SetActive(active)
end

function BattleUnitView:SetHeroPropertyActive(active)
	EventDispatcher.Dispatch(EventID.ChangeBattleUnitHUDActive, self.battleUnitID, active)
end

function BattleUnitView:SetSkillSelectPointActive(active)
	self.skillSelectPoint:SetActive(active)
end

function BattleUnitView:ChangeParent(parent, isUnitFlip)
	self.skinEntityGo.transform:SetParent(parent)

	self.skinEntityGo.transform.localRotation = UnityEngine.Quaternion.identity
	self.skinEntityGo.transform.localPosition = self.parentPositionOffset
	self.skinEntityGo.transform.localScale = Vector3.New(self.size, self.size, self.size)
	self.spineRoot.transform.localScale = isUnitFlip and Vector3(-1, 1, 1) or Vector3.one
end

function BattleUnitView:GetLineTargetPos()
	if self.lineTargetRoot == nil then
		return nil
	end

	return self.lineTargetRoot.transform.position
end

function BattleUnitView:ChangeSize(size)
	self.size = size
	self.skinEntityGo.transform.localScale = Vector3.New(self.size, self.size, self.size)
end

function BattleUnitView:PlayAnimation(animName, loop)
	if self.skeletonAnimation == nil then
		return
	end

	if self.skeletonAnimation.state == nil then
		logError("play spine animation error, state is null. Animation name: " .. animName .. " gameObject: " .. self.skinEntityGo.name)

		return
	end

	local isLoop = loop == true and loop or false

	if self.skeletonAnimation.AnimationName == animName and not isLoop then
		return
	end

	if not self.skeletonAnimation.state.Data.SkeletonData:FindAnimation(animName) then
		logError("战斗单位找不到动画 {0}", animName)

		animName = "idle"
	end

	self.skeletonAnimation.state:SetAnimation(0, animName, isLoop)

	self.skeletonAnimation.loop = isLoop
end

function BattleUnitView:__OnAnimationUpdate()
	if self.skeletonAnimation == nil then
		return
	end

	if self.skeletonAnimation.state == nil then
		return
	end

	if not self.autoResetIdle then
		return
	end

	if self.skeletonAnimation.state:GetCurrent(0) == nil then
		local _idleAnimName = self:__GetIdleAnimName()

		self.skeletonAnimation.state:SetAnimation(0, _idleAnimName, true)

		return
	end

	if self.skeletonAnimation.state:GetCurrent(0).IsComplete then
		if self.skeletonAnimation.loop then
			return
		end

		local _animName, _loop = self:__GetNextAnimationName()

		self.skeletonAnimation.loop = _loop

		self.skeletonAnimation.state:SetAnimation(0, _animName, _loop)
	end
end

function BattleUnitView:OnUpdate()
	self:__OnAnimationUpdate()
end

function BattleUnitView:PlaySetTurnAnim()
	self.state = BattleConstant.BattleUnitState.selectSkill
	self.animList = {
		"selected_1",
		"selected_2"
	}
	self.animListIndex = 1

	self:PlayAnimation(self.animList[self.animListIndex], self.animListIndex == #self.animList)
end

function BattleUnitView:PlayChooseTargetAnim()
	self.state = BattleConstant.BattleUnitState.selectTarget
	self.animList = {
		"ready_1",
		"ready_2"
	}
	self.animListIndex = 1

	self:PlayAnimation(self.animList[self.animListIndex], self.animListIndex == #self.animList)
end

function BattleUnitView:PlayIdleAnim()
	local idleAnimName = self:__GetIdleAnimName()

	self:PlayAnimation(idleAnimName, true)

	self.state = BattleConstant.BattleUnitState.idle
end

function BattleUnitView:__GetIdleAnimName()
	if self.state == BattleConstant.BattleUnitState.selectTarget then
		return "ready_3", false
	end

	if self:__IsControlState() then
		return "controlled", true
	end

	return "idle", true
end

function BattleUnitView:__IsControlState()
	local battleUnitData = BattleModule.GetBattleUnitDataByUnitID(self.battleUnitID)

	if battleUnitData:IsInFightStatus(Constant.BattleFightStatus.AP_LIMIT) then
		return true
	end

	if battleUnitData:IsInFightStatus(Constant.BattleFightStatus.CHAOS) then
		return true
	end

	if battleUnitData:IsInFightStatus(Constant.BattleFightStatus.CHARM) then
		return true
	end

	if battleUnitData:IsInFightStatus(Constant.BattleFightStatus.DIZZY) then
		return true
	end

	if battleUnitData:IsInFightStatus(Constant.BattleFightStatus.SLEEP) then
		return true
	end

	if battleUnitData.troopType == BattleModule.defineBattleTroopType and battleUnitData.PODData.WeakNum == 0 then
		return false
	end

	return false
end

function BattleUnitView:__GetNextAnimationName()
	if #self.animList > 1 and self.animListIndex < #self.animList then
		self.animListIndex = self.animListIndex + 1

		return self.animList[self.animListIndex], self.animListIndex == #self.animList
	end

	return self:__GetIdleAnimName()
end

function BattleUnitView:ResetTempData()
	self.animList = {}
	self.animListIndex = 1
	self.state = BattleConstant.BattleUnitState.idle
end

function BattleUnitView:__OnTimelineCompleted(playableDirector)
	self.playableDirector.playableAsset = nil

	self:PlayIdleAnim()

	if self.OnTimelineCompletedEvent ~= nil then
		self.OnTimelineCompletedEvent()
	end

	self.OnTimelineCompletedEvent = nil
end

function BattleUnitView:__InitBuffView()
	local battleUnitData = BattleModule.GetBattleUnitDataByUnitID(self.battleUnitID)

	for _, buffData in pairs(battleUnitData.buffsData) do
		self:__AddBuffView(buffData)
	end
end

function BattleUnitView:__AddBuffView(battleBuffData)
	local buff = self.buffsViewData[battleBuffData.cid]

	if buff ~= nil then
		return
	end

	buff = BattleBuffView.New(battleBuffData, self, Constant.UpdateScope.BattleUnit)
	self.buffsViewData[buff.cid] = buff

	self:__RefreshControllerTypeShow()
	BattleEffectModule.AddRendererFeatureByBuff(self.battleUnitID, buff)
end

function BattleUnitView:__OnBattleUnitAddBuff(battleUnitID, buffCid)
	if battleUnitID ~= self.battleUnitID then
		return
	end

	local battleUnitData = BattleModule.GetBattleUnitDataByUnitID(battleUnitID)
	local battleBuffData = battleUnitData:GetBuffData(buffCid)
	local buffConfig = CfgBuffTable[buffCid]

	self:PlaySoundWithID(buffConfig.StartBuffSound)
	self:__AddBuffView(battleBuffData)
end

function BattleUnitView:__OnBattleUnitUpdateBuff(battleUnitID, buffCid, stackDifference, roundDifference)
	if battleUnitID ~= self.battleUnitID then
		return
	end

	local battleUnitData = BattleModule.GetBattleUnitDataByUnitID(battleUnitID)
	local battleBuffData = battleUnitData:GetBuffData(buffCid)
	local buffConfig = CfgBuffTable[buffCid]

	self:PlaySoundWithID(buffConfig.UpdateBuffSound)

	local buff = self.buffsViewData[battleBuffData.cid]

	if buff == nil then
		return
	end

	buff:Update(battleBuffData.leftCount, battleBuffData.stack)
end

function BattleUnitView:__OnBattleUnitTriggerBuff(battleUnitID, buffCid)
	if battleUnitID ~= self.battleUnitID then
		return
	end

	local buffConfig = CfgBuffTable[buffCid]

	self:PlaySoundWithID(buffConfig.TriggerBuffSound)

	local buff = self.buffsViewData[buffCid]

	if buff == nil then
		return
	end

	buff:Trigger()
end

function BattleUnitView:__OnBattleUnitRemoveBuff(battleUnitID, buffCid)
	if battleUnitID ~= self.battleUnitID then
		return
	end

	local buffConfig = CfgBuffTable[buffCid]

	self:PlaySoundWithID(buffConfig.EndBuffSound)

	local buff = self.buffsViewData[buffCid]

	if buff == nil then
		return
	end

	buff:Remove()

	self.buffsViewData[buffCid] = nil

	self:__RefreshControllerTypeShow()
	BattleEffectModule.RemoveRendererFeatureByBuff(self.battleUnitID, buffCid)
end

function BattleUnitView:__RefreshControllerTypeShow()
	local tempControlType = self:__GetRealControlTypeByBuffs()

	if self.controlType == tempControlType then
		return
	end

	self.controlType = tempControlType
	self.skeletonAnimation.timeScale = self.controlType == Constant.ControlType.FREEZE and 0 or 1
end

function BattleUnitView:__GetRealControlTypeByBuffs()
	local battleUnitData = BattleModule.GetBattleUnitDataByUnitID(self.battleUnitID)
	local _controlType = Constant.ControlType.NONE

	ForPairs(battleUnitData.buffsData, function(buffCid, _)
		local buffConfig = CfgBuffTable[buffCid]

		if buffConfig.ControlType == Constant.ControlType.FREEZE then
			_controlType = Constant.ControlType.FREEZE

			return true
		elseif buffConfig.ControlType == Constant.ControlType.POISON then
			_controlType = Constant.ControlType.POISON
		end
	end)

	return _controlType
end

function BattleUnitView:OnBattleUnitStatusChange(battleUnitID, fightStatusID, value)
	if self.battleUnitID ~= battleUnitID then
		return
	end

	self:PlayIdleAnim()

	if value then
		BattleEffectModule.AddRendererFeatureByFightStatus(self.battleUnitID, fightStatusID)
	else
		BattleEffectModule.RemoveRendererFeatureByFightStatus(self.battleUnitID, fightStatusID)
	end
end

function BattleUnitView:OnBattleUnitWakeNumChange(battleUnitID)
	if self.battleUnitID ~= battleUnitID then
		return
	end

	self:PlayIdleAnim()

	local battleUnitData = BattleModule.GetBattleUnitDataByUnitID(self.battleUnitID)

	if battleUnitData.PODData.WeakNum == 0 then
		self:PlayWakeBreakEffect(battleUnitData:IsBoss())
	end
end

function BattleUnitView:PlayImmunityEffect()
	local mountPointTrans = self.skinEntityGo.transform:Find(Battle.BattleTimelineManager.SPINE_PATH .. "/fx_head")

	if mountPointTrans ~= nil then
		BattleEffectModule.PlaySceneEffect(50100, mountPointTrans.position)
	end
end

function BattleUnitView:PlayDodgeEffect()
	local mountPointTrans = self.skinEntityGo.transform:Find(Battle.BattleTimelineManager.SPINE_PATH .. "/fx_head")

	if mountPointTrans ~= nil then
		BattleEffectModule.PlaySceneEffect(50101, mountPointTrans.position)
	end
end

function BattleUnitView:PlayWakeBreakEffect(isBoss)
	self:PlaySoundWithID(BattleApi:GetWakeBreakSoundID())

	local mountPointTrans = self.skinEntityGo.transform:Find(Battle.BattleTimelineManager.SPINE_PATH .. "/fx_center")

	if mountPointTrans ~= nil then
		local effectID = BattleApi:GetWakeBreakEffectID()

		BattleEffectModule.PlaySceneEffect(effectID, mountPointTrans.position)
	end

	if isBoss then
		BattleEffectModule.PlayScreenEffect(300, 2)
	end
end

function BattleUnitView:PlaySubstituteMonsterBornEffect()
	local mountPointTrans = self.skinEntityGo.transform:Find(Battle.BattleTimelineManager.SPINE_PATH .. "/fx_foot")

	if mountPointTrans ~= nil then
		BattleEffectModule.PlaySceneEffect(42001, mountPointTrans.position)
	end
end

function BattleUnitView:PlaySummonMonsterBornEffect()
	local mountPointTrans = self.skinEntityGo.transform:Find(Battle.BattleTimelineManager.SPINE_PATH .. "/fx_foot")

	if mountPointTrans ~= nil then
		BattleEffectModule.PlaySceneEffect(42001, mountPointTrans.position)
	end
end

function BattleUnitView:PlayChangeSkinEffect()
	local mountPointTrans = self.skinEntityGo.transform:Find(Battle.BattleTimelineManager.SPINE_PATH .. "/fx_foot")

	if mountPointTrans ~= nil then
		BattleEffectModule.PlaySceneEffect(42001, mountPointTrans.position)
	end
end

function BattleUnitView:PlaySoundWithID(soundID)
	if soundID == nil then
		return
	end

	if soundID == 0 then
		return
	end

	LuaUtility.PlaySoundWithID(soundID)
end

function BattleUnitView:ShowSelectOrderState(isTrue)
	if isTrue then
		self:PlaySetTurnAnim()
		self:__SetTintColor(UnityEngine.Color.white)
		BattleEffectModule.AddRendererFeatureByManual(self.battleUnitID, BattleConstant.RendererFeatureID.Selected)
		BattleEffectModule.RemoveRendererFeatureByManual(self.battleUnitID, BattleConstant.RendererFeatureID.MoveStealth)
	else
		self:PlayIdleAnim()
		self:__SetTintColor(UnityEngine.Color.gray)
		BattleEffectModule.RemoveRendererFeatureByManual(self.battleUnitID, BattleConstant.RendererFeatureID.Selected)
		BattleEffectModule.AddRendererFeatureByManual(self.battleUnitID, BattleConstant.RendererFeatureID.MoveStealth)
	end
end

function BattleUnitView:ShowNormalState()
	self:ResetTempData()
	self:__SetTintColor(UnityEngine.Color.white)
	BattleEffectModule.RemoveTransferFeatureByType(self.battleUnitID, BattleConstant.RendererFeatureSourceType.Manual)
end

function BattleUnitView:GetInstanceID()
	return self.instanceID
end

function BattleUnitView:__SetTintColor(color)
	self.roleEffect:SetProperty("_Color", color)
end

function BattleUnitView:BeHit(hitData)
	if self.controlType ~= Constant.ControlType.DIZZY then
		if hitData.hitAnimType == 1 then
			self:PlayAnimation("hit_L")
			CVModule.PlayCV(Constant.CVActionType.FightBeLightAttack, BattleModule.GetBattleUnitDataByUnitID(self.battleUnitID):GetHeroCid())
		elseif hitData.hitAnimType == 2 then
			self:PlayAnimation("hit_H")
			CVModule.PlayCV(Constant.CVActionType.FightBeWightAttack, BattleModule.GetBattleUnitDataByUnitID(self.battleUnitID):GetHeroCid())
		end
	end

	self:PlayTransferFeature(BattleConstant.RendererFeatureID.Hit)

	local effectCid, parentTrans = self:__GetRealHitEffect(hitData)

	if effectCid ~= 0 then
		GameEntry.Effect:PlayNormalEffect(effectCid, parentTrans.position, 0, 2)
	end
end

function BattleUnitView:__GetRealHitEffect(hitData)
	if hitData.hitEffectCid ~= 0 then
		return hitData.hitEffectCid, self:__GetMountPoint(hitData.hitEffectHangingPoint)
	end

	local hitEffectCfg = BattleConstant.UnitCommonHitEffect[hitData.hitElementType]

	if hitEffectCfg == nil then
		logError("技能Hit出现找不到的 hitElementType ---> {0}", tostring(hitData.hitElementType))

		return 0
	end

	return hitEffectCfg.cid, self:__GetMountPoint(hitEffectCfg.parent)
end

function BattleUnitView:__GetMountPoint(pointName)
	if pointName == "fx_spine_stun" then
		return self.skinEntityGo.transform:FindChildByName(Battle.BattleTimelineManager.SPINE_PATH .. "/fx_stun")
	elseif pointName == "fx_spine_head" then
		return self.skinEntityGo.transform:FindChildByName(Battle.BattleTimelineManager.SPINE_PATH .. "/fx_head")
	elseif pointName == "fx_spine_center" then
		return self.skinEntityGo.transform:FindChildByName(Battle.BattleTimelineManager.SPINE_PATH .. "/fx_center")
	elseif pointName == "fx_spine_foot" then
		return self.skinEntityGo.transform:FindChildByName(Battle.BattleTimelineManager.SPINE_PATH .. "/fx_foot")
	elseif pointName == "fx_stun" then
		return self.skinEntityGo.transform:FindChildByName(Battle.BattleTimelineManager.EFFECT_PATH .. "/fx_stun")
	elseif pointName == "fx_head" then
		return self.skinEntityGo.transform:FindChildByName(Battle.BattleTimelineManager.EFFECT_PATH .. "/fx_head")
	elseif pointName == "fx_center" then
		return self.skinEntityGo.transform:FindChildByName(Battle.BattleTimelineManager.EFFECT_PATH .. "/fx_center")
	elseif pointName == "fx_foot" then
		return self.skinEntityGo.transform:FindChildByName(Battle.BattleTimelineManager.EFFECT_PATH .. "/fx_foot")
	else
		return self.skinEntityGo.transform:FindChildByName(pointName)
	end
end

function BattleUnitView:__InitRendererTransferView()
	return
end

function BattleUnitView:PlayTransferFeature(transferConfigID)
	if self.hideSpine then
		return
	end

	if self.disableGlobalAlpha then
		return
	end

	BattleEffectModule.PlayTransferFeature(transferConfigID, self, nil)
end

function BattleUnitView:RemoveTransferFeature(transferConfigID)
	if self.hideSpine then
		return
	end

	if self.disableGlobalAlpha then
		return
	end

	BattleEffectModule.RemoveTransferFeature(transferConfigID, self)
end

function BattleUnitView:SetRoleEffectEnable(enable)
	if self.hideSpine then
		return
	end

	if self.disableGlobalAlpha then
		return
	end

	self.roleEffect:SetEnable(enable)
end

return BattleUnitView
