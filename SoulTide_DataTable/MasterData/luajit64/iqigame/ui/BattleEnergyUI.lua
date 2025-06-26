-- chunkname: @IQIGame\\UI\\BattleEnergyUI.lua

local BattleEnergyUI = Base:Extend("BattleEnergyUI", "IQIGame.Onigao.UI.BattleEnergyUI", {
	_currentSkillID = 0,
	_currentSkillShowTime = 0,
	_unitMonsterCfgId = 0,
	_isShowSkill = false,
	_cvSoundId = 0,
	_currentSkillShowTotalTime = 0,
	_skillUITable = {},
	EffectPlayIDList = {}
})

function BattleEnergyUI:OnInit()
	function self.DelegateOnPrepareCastSkillUI(unitId, monsterCid, skillCid, skillActionCid, needPlayCG)
		self:OnPrepareCastSkillUI(unitId, monsterCid, skillCid, skillActionCid, needPlayCG)
	end

	function self.DelegateFinishUltimateSkillEffect()
		self:FinishUltimateSkillEffect()
	end
end

function BattleEnergyUI:GetPreloadAssetPaths()
	return nil
end

function BattleEnergyUI:GetOpenPreloadAssetPaths(userData)
	return nil
end

function BattleEnergyUI:OnOpen(userData)
	return
end

function BattleEnergyUI:OnAddListeners()
	EventDispatcher.AddEventListener(EventID.BattlePrepareCastSkill, self.DelegateOnPrepareCastSkillUI)
end

function BattleEnergyUI:OnRemoveListeners()
	EventDispatcher.RemoveEventListener(EventID.BattlePrepareCastSkill, self.DelegateOnPrepareCastSkillUI)
end

function BattleEnergyUI:OnPrepareCastSkillUI(unitId, monsterCid, skillCid, skillActionCid, needPlayCG)
	local cfgSkillActionData = CfgSkillActionTable[skillActionCid]

	if cfgSkillActionData.UIModelName ~= "" then
		self._currentSkillID = skillCid
		self._unitMonsterCfgId = monsterCid
		self._currentSkillActionData = cfgSkillActionData
		self._currentSkillShowTotalTime = cfgSkillActionData.UIShowTime

		local actionList = cfgSkillActionData.UISpineNormalAction
		local delayList = cfgSkillActionData.UISpineNormalActionDelayTime

		if self.DelayTimer ~= nil then
			self.DelayTimer:Stop()
		end

		self.DelayTimer = Timer.New(function()
			self.DelayTimer = nil
			self.SpineAnimQueue = Queue.New()

			for i = 1, #actionList do
				self.SpineAnimQueue:Enqueue({
					name = actionList[i],
					delay = delayList[i]
				})
			end

			self.EffectList = {}

			for i = 1, #cfgSkillActionData.UISpineEffectID do
				table.insert(self.EffectList, {
					id = cfgSkillActionData.UISpineEffectID[i],
					point = cfgSkillActionData.UISpineEffectPoint[i],
					delay = cfgSkillActionData.UISpineEffectDelayTime[i]
				})
			end

			local skillPrefabPath = AssetPath.Get(GlobalKey.UIPrefabPath, "_BattleUI/" .. cfgSkillActionData.UIModelName)

			AssetUtil.LoadAsset(self, skillPrefabPath, self.OnLoadSucceed, self.OnLoadFailed, "model")
		end, cfgSkillActionData.UIDelayTime)

		self.DelayTimer:Start()
	end
end

function BattleEnergyUI:ShowSkillUI(asset)
	self:DestroySkillUINode()

	self._skillUINode = UnityEngine.Object.Instantiate(asset)

	self._skillUINode.transform:SetParent(self.UIController.transform, false)
	LuaCodeInterface.BindOutlet(self._skillUINode, self._skillUITable)

	local cfgSkillData = CfgSkillTable[self._currentSkillID]

	if cfgSkillData.Type == Constant.Skill.TYPE_DEAD then
		local monsterData = CfgMonsterTable[self._unitMonsterCfgId]
		local cvData = CfgCVTable[monsterData.DieCVID]

		if self._cvSoundId > 0 then
			GameEntry.Sound:StopSound(self._cvSoundId)
		end

		if cvData ~= nil and cvData.SoundID > 0 then
			self._cvSoundId = GameEntry.Sound:PlaySound(cvData.SoundID, Constant.SoundGroup.CHARACTER)
		end
	end

	local sortComponents = self._skillUINode:GetComponentsInChildren(typeof(IQIGame.Onigao.Game.SortedComponentOrder))

	for i = 0, sortComponents.Length - 1 do
		sortComponents[i].UIRootCanvas = self.battleEnergyUI:GetComponent("Canvas")
	end

	local cfgMonsterData = CfgMonsterTable[self._unitMonsterCfgId]

	if self._skillUITable.SkillCasterBg ~= nil then
		local rolePrefabPath

		if cfgSkillData.Type == Constant.Skill.TYPE_ULTIMATE then
			rolePrefabPath = cfgMonsterData.SpecialSpine
		else
			rolePrefabPath = cfgMonsterData.SkillSpine
		end

		AssetUtil.LoadAsset(self, UIGlobalApi.GetBattleUIPrefab(rolePrefabPath), self.OnLoadSucceed, self.OnLoadFailed, "spine")
	end

	if self._skillUITable.SkillTxt ~= nil then
		local nameParts = string.split(cfgSkillData.UIModelName, "|")

		for i = 1, #nameParts do
			local textFieldTrans = self._skillUITable.SkillTxt.transform:Find("SkillTxt_" .. i)

			if textFieldTrans ~= nil then
				textFieldTrans:GetComponent("TextMeshProUGUI").text = nameParts[i]
			end
		end
	end

	if self._skillUITable.SkillCasterNameTxt ~= nil then
		self._skillUITable.SkillCasterNameTxt:GetComponent("Text").text = cfgMonsterData.Name
	end

	self._currentSkillShowTime = 0
	self._isShowSkill = true
end

function BattleEnergyUI:FinishSkillShow()
	if self.DelayTimer ~= nil then
		self.DelayTimer:Stop()

		self.DelayTimer = nil
	end

	for i = 1, #self.EffectPlayIDList do
		IQIGame.Onigao.Game.BattleModule.StopEffect(self.EffectPlayIDList[i])
	end

	self.EffectPlayIDList = {}

	self:DestroySkillUINode()

	self._isShowSkill = false

	GameEntry.Sound:StopSound(self._cvSoundId)
end

function BattleEnergyUI:DestroySkillUINode()
	if self._skillUINode ~= nil then
		LuaCodeInterface.ClearOutlet(self._skillUINode, self._skillUITable)
		UnityEngine.Object.Destroy(self._skillUINode)

		self._skillUINode = nil
	end

	self.SpineGO = nil
	self.SpineAnimationComponent = nil
end

function BattleEnergyUI:OnClose(userData)
	ModuleTimerUtil.Stop(Constant.UIControllerName.BattleEnergyUI)
	self:FinishSkillShow()
end

function BattleEnergyUI:OnPause()
	return
end

function BattleEnergyUI:OnResume()
	return
end

function BattleEnergyUI:OnCover()
	return
end

function BattleEnergyUI:OnReveal()
	return
end

function BattleEnergyUI:OnRefocus(userData)
	return
end

function BattleEnergyUI:OnUpdate(elapseSeconds, realElapseSeconds)
	if self._isShowSkill then
		if self._currentSkillShowTime < self._currentSkillShowTotalTime then
			self._currentSkillShowTime = self._currentSkillShowTime + elapseSeconds

			self:CheckPlayAnimAndEffect(self._currentSkillShowTime)
		else
			self:FinishSkillShow()
		end
	end
end

function BattleEnergyUI:OnDepthChanged(uiGroupDepth, depthInUIGroup)
	return
end

function BattleEnergyUI:OnLoadSucceed(assetName, asset, duration, userData)
	if userData == "model" then
		self:ShowSkillUI(asset)
	elseif userData == "spine" then
		if self._skillUINode == nil then
			return
		end

		self.SpineGO = UnityEngine.Object.Instantiate(asset)

		self.SpineGO.transform:SetParent(self._skillUITable.SkillCasterBg.transform, false)

		self.SpineGO.transform.localPosition = Vector3(self.SpineAnimQueue.Size > 0 and 100000 or 0, 0, 0)
		self.SpineAnimationComponent = self.SpineGO:GetComponentInChildren(typeof(Spine.Unity.SkeletonAnimation))
	end
end

function BattleEnergyUI:OnLoadFailed(assetName, status, errorMessage, userData)
	return
end

function BattleEnergyUI:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self:DestroySkillUINode()
end

function BattleEnergyUI:PlayAnimation(animName)
	if self.SpineAnimationComponent ~= nil then
		self.SpineAnimationComponent.state:SetEmptyAnimation(0, 0)
		self.SpineAnimationComponent.state:SetAnimation(0, animName, false)
	end

	local timer = ModuleTimerUtil.NewFrameTimer(Constant.UIControllerName.BattleEnergyUI, function()
		if self.SpineGO == nil then
			return
		end

		local xyz = self._currentSkillActionData.UISpinePosition

		if #xyz == 0 then
			xyz = {
				0,
				0,
				0
			}
		end

		self.SpineGO.transform.localPosition = Vector3(xyz[1], xyz[2], xyz[3])
	end, 1)

	timer:Start()
end

function BattleEnergyUI:CheckPlayAnimAndEffect(timer)
	if self.SpineAnimQueue.Size > 0 then
		local animationData = self.SpineAnimQueue:Peek()

		if timer > animationData.delay then
			animationData = self.SpineAnimQueue:Dequeue()

			self:PlayAnimation(animationData.name)
		end
	end

	if #self.EffectList > 0 then
		local removeCidList

		for i = 1, #self.EffectList do
			local effectData = self.EffectList[i]

			if timer > effectData.delay then
				table.insert(self.EffectPlayIDList, IQIGame.Onigao.Game.BattleModule.PlayMountPointEffect(effectData.id, effectData.point, 0, self._skillUINode, 0, 0, LayerMask.NameToLayer("UI")))

				if removeCidList == nil then
					removeCidList = {}
				end

				table.insert(removeCidList, effectData.id)
			end
		end

		if removeCidList ~= nil then
			for i = 1, #removeCidList do
				local toRemoveEffectCid = removeCidList[i]

				for j = 1, #self.EffectList do
					local effectData = self.EffectList[j]

					if effectData.id == toRemoveEffectCid then
						table.remove(self.EffectList, j)

						break
					end
				end
			end
		end
	end
end

return BattleEnergyUI
