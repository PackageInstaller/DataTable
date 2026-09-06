-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/view/LotteryeffectView.lua

module("logic.extensions.lottery.view.LotteryeffectView", package.seeall)

local LotteryeffectView = class("LotteryeffectView", ViewComponent)

function LotteryeffectView:ctor()
	LotteryeffectView.super.ctor(self)
end

function LotteryeffectView:buildUI()
	LotteryeffectView.super.buildUI(self)

	self._btnJump = self:getBtn("bg/jump")

	self._btnJump.gameObject:SetActive(false)
end

function LotteryeffectView:bindEvents()
	LotteryeffectView.super.bindEvents(self)
	self._btnJump:AddClickListener(self._onClickBtnJump, self)
end

function LotteryeffectView:unbindEvents()
	LotteryeffectView.super.unbindEvents(self)
	self._btnJump:RemoveClickListener()
end

function LotteryeffectView:destroyUI()
	LotteryeffectView.super.destroyUI(self)
	self:ClearTimer()
	self:_clearFmodEvents()
	self:_clearPrefabRes()
end

function LotteryeffectView:onEnter()
	LotteryeffectView.super.onEnter(self)

	self._clickJumpClose = false
	self._ssrShowDone = {}
	self._checkClickEffect = false
	self._isTouchedDown = false

	settimer(0.02, self._tickClickUnit, self)

	self._fmodEvtInstances = {}

	LotteryController.instance:playDrawBgmMusic()

	self._targetObj = {}

	for i = 1, 10 do
		self._targetObj[i] = self:getGo("Target" .. i - 1)

		self._targetObj[i].transform:SetParent(nil)
		GameUtil.setLocalScale(self._targetObj[i], 1, 1, 1)
	end

	self._hudRoot = SceneRoot2DMgr.instance:getRoot(SceneRoot2DType.NameBar)

	if self._hudRoot then
		self._hudRoot.gameObject:SetActive(false)
	end

	GlobalDispatcher:addListener(GlobalNotify.LotteryAniContinue, self._onLotteryAniContinue, self)

	self.items = self:getFirstParam()
	self.need = LotteryController.instance:GetRecordNeedCount()
	self.kapai_prefab_go = {}

	WaitingView.instance:show()
	self:_initPrefabResLoad()

	self._loadPetSpineCount = 0
end

function LotteryeffectView:_onClickBtnJump()
	self._clickJumpClose = true

	if self.need == 1 then
		self:_showPetPopView()
	else
		self:JumpSkipTenDraw()
	end
end

function LotteryeffectView:JumpSkipTenDraw()
	self:_clearAnimationPlayer()
	self:_clearEffectObj()

	local openPetView = false

	if self._ssrShowDone then
		self._petRareList = LotteryController.instance:GetPetRareList()
		self._petFaceList = LotteryController.instance:GetPetCurFaceList()

		if self._petRareList and self._petFaceList then
			for i = 1, 10 do
				if self._petRareList[i] and self._petRareList[i] == GameEnum.PetRare.SSR and self._petFaceList and self._petFaceList[i] and self._petFaceList[i].petId then
					local showed = false

					for k, v in ipairs(self._ssrShowDone) do
						if v == self._petFaceList[i].petId then
							showed = true

							break
						end
					end

					if not showed then
						local pet = BagModel.instance:getPet(self._petFaceList[i].petId)

						table.insert(self._ssrShowDone, self._petFaceList[i].petId)

						if pet then
							openPetView = true

							UIStateManager.instance:open(ViewName.PetDisplay, pet)

							break
						end
					end
				end
			end
		end
	end

	if not openPetView and LotteryController.instance:GetInLotteryLogic() then
		self:close()
		LotteryController.instance:clearLottery()
	end
end

function LotteryeffectView:_tickClickUnit()
	if not self._checkClickEffect then
		return
	end

	if not self._isTouchedDown and UGUIToolHelper.IsTouchDown() then
		self._isTouchedDown = true
		UnityEngine.Time.timeScale = 2
	end
end

function LotteryeffectView:onEnterFinished()
	LotteryeffectView.super.onEnterFinished(self)
end

function LotteryeffectView:onExit()
	LotteryeffectView.super.onExit(self)
	LotteryController.instance:setLotteryBgEffectType(0)
	GlobalDispatcher:removeListener(GlobalNotify.LotteryAniContinue, self._onLotteryAniContinue, self)

	if self._hudRoot then
		self._hudRoot.gameObject:SetActive(true)

		self._hudRoot = nil
	end

	removetimer(self._tickClickUnit, self)

	self._checkClickEffect = false
	UnityEngine.Time.timeScale = 1

	self:ClearTimer()
	WaitingView.instance:hide()
	self:DrawEffectTimer()
	self:_clearPrefabRes()
	self:_clearPetSpineParentEffect()
	self:_clearPetSpine()
	self:_clearAnimationPlayer()
	self:_clearEffectObj()

	self._maxRare = nil
	self._maxRareKey = nil
	self._commonRareList = nil
	self.effect_info = nil

	if self.need == 1 then
		LotteryController.instance:startStopDrawBgmMusic()
	end

	self:_clearFmodEvents()
	forcePrint("LotteryeffectView self:_clearFmodEvents() self.need = ", self.need)

	self.need = nil
end

function LotteryeffectView:_showPetPopView()
	self:close()
	LotteryController.instance:showPetItemGet()
	LotteryController.instance:SetInLotteryLogicOneAndTen(nil)
end

function LotteryeffectView:onExitFinished()
	LotteryeffectView.super.onExitFinished(self)
end

function LotteryeffectView:_playFirstEffect()
	if not self.need then
		return
	end

	if self._btnJump then
		self._btnJump.gameObject:SetActive(true)
	end

	if self.need ~= 1 then
		LotteryController.instance:SetInLotteryLogic(true)
	end

	LotteryController.instance:SetInLotteryLogicOneAndTen(true)

	local _tongyongEffectPath = "fx_chouka/fx_chouka_tongyong.prefab"

	self._tongyongEffect = UIEffectManager.instance:playEffect(self, _tongyongEffectPath, nil, 0, 0, true, nil, function(finishHandlerTarget, eff)
		WaitingView.instance:hide()
	end, function(finishHandlerTarget, eff)
		WaitingView.instance:hide()
		table.insert(self._fmodEvtInstances, AudioPlayerEx.instance:playEffect(30402))
		self._tongyongEffect:setLayer(SceneLayer.SkillEffects_Value)
		settimer(1.3, self._waitFirstEffect, self, false)
	end)
end

function LotteryeffectView:_waitFirstEffect()
	self:_playChoukaEffect()
	removetimer(self._waitFirstEffect, self)
end

function LotteryeffectView:_playChoukaEffect()
	if not self.need then
		return
	end

	local pet_rare_list = LotteryController.instance:GetPetRareList()

	if not pet_rare_list then
		return
	end

	local _danchouRareEffectPath = {
		"fx_chouka/danchou/fx_chouka_baise.prefab",
		"fx_chouka/danchou/fx_chouka_lanse.prefab",
		"fx_chouka/danchou/fx_chouka_zise.prefab",
		"fx_chouka/danchou/fx_chouka_jinse.prefab"
	}

	if self.need == 1 then
		local _petRare = pet_rare_list[1]

		if _petRare then
			self._rareEffect = UIEffectManager.instance:playEffect(self, _danchouRareEffectPath[_petRare], nil, 0, 0, true, nil, function(finishHandlerTarget, eff)
				return
			end, function(finishHandlerTarget, eff)
				self._rareEffect:setLayer(SceneLayer.SkillEffects_II_Value)
				self:_playStarsAudio()
				settimer(1, self._destroyTongYongEffectTimer, self, false)
			end)
		end
	else
		local _effectPath = self._maxRare == 4 and "fx_chouka/shichou/fx_chouka_shichou_jin.prefab" or "fx_chouka/shichou/fx_chouka_shichou.prefab"

		self._rareEffect = UIEffectManager.instance:playEffect(self, _effectPath, nil, 0, 0, true, nil, function(finishHandlerTarget, eff)
			return
		end, function(finishHandlerTarget, eff)
			self._rareEffect:setLayer(SceneLayer.SkillEffects_II_Value)
			self:_changeShiChouPrefab(eff)
			self:_playStarsAudio()
			settimer(1, self._destroyTongYongEffectTimer, self, false)
		end)
	end

	local effect_time = _need == 1 and 5.1 or 5.1

	settimer(effect_time - 0.2, self._playShadowEffectTimer, self, false)
	settimer(effect_time, self.DrawEffectTimer, self, false)
end

function LotteryeffectView:_playStarsAudio()
	table.insert(self._fmodEvtInstances, AudioPlayerEx.instance:playEffect(30403))
	settimer(1.1333333333333333, self._doPlayStarsAudio, self, false)
	settimer(2.6666666666666665, self._doPlayStarsBombAudio, self, false)
end

function LotteryeffectView:_getMaxRare()
	if self._maxRare then
		return self._maxRare
	end

	local pet_rare_list = LotteryController.instance:GetPetRareList()

	self._maxRare = 1
	self._maxRareKey = -1
	self._commonRareList = {}

	for i = 1, 10 do
		if self._maxRare < pet_rare_list[i] then
			self._maxRare = pet_rare_list[i]
			self._maxRareKey = i
		end
	end

	for i = 1, 10 do
		if i ~= self._maxRareKey then
			table.insert(self._commonRareList, pet_rare_list[i])
		end
	end
end

function LotteryeffectView:_changeShiChouPrefab(eff)
	if not eff or not self.need then
		return
	end

	local pet_rare_list = LotteryController.instance:GetPetRareList()

	if not pet_rare_list then
		self.effect_info = {
			eff,
			self.need
		}

		return
	end

	if not self.effect_prefab_res then
		self.effect_info = {
			eff,
			self.need
		}

		return
	end

	if self.need ~= 1 then
		for i = 1, 10 do
			local order = "1"

			order = i == 10 and "10" or "0" .. i

			local _kapaiGo, _kapaiTuoweiGo
			local _petRare = pet_rare_list[i]

			if i == 1 then
				_kapaiGo = goutil.findChild(eff.effGo, "shichou_camera_anim/shichou_ka/ka01/1")
				_kapaiTuoweiGo = goutil.findChild(eff.effGo, "shichou_camera_anim/shichou_ka/ka01/1_tuowei")
				_petRare = self._maxRare
			else
				_kapaiGo = goutil.findChild(eff.effGo, "shichou_camera_anim/shichou_ka/ka" .. order .. "/" .. i)
				_kapaiTuoweiGo = goutil.findChild(eff.effGo, "shichou_camera_anim/shichou_ka/ka" .. order .. "/" .. i .. "_tuowei")
				_petRare = self._commonRareList[i]
			end

			if _petRare then
				local _kapaiPrefabAsset, _kapaiTuoweiPrefabAsset

				_kapaiPrefabAsset = self.effect_prefab_res and self.effect_prefab_res[_petRare] and self.effect_prefab_res[_petRare]:GetMainAsset()
				_kapaiTuoweiPrefabAsset = self.effect_prefab_res and self.effect_prefab_res[_petRare + 4] and self.effect_prefab_res[_petRare + 4]:GetMainAsset()

				if _kapaiPrefabAsset and _kapaiTuoweiPrefabAsset then
					local _kapaiPrefabAssetGo = goutil.clone(_kapaiPrefabAsset)

					_kapaiPrefabAssetGo.transform:SetParent(_kapaiGo.transform)
					GameUtil.setLocalPos(_kapaiPrefabAssetGo, 0, 0, 0)
					Framework.TransformUtil.SetLocalRotation(_kapaiPrefabAssetGo.transform, 0, 0, 0)
					table.insert(self.kapai_prefab_go, _kapaiPrefabAssetGo)

					local _kapaiTuoweiPrefabAssetGo = goutil.clone(_kapaiTuoweiPrefabAsset)

					_kapaiTuoweiPrefabAssetGo.transform:SetParent(_kapaiTuoweiGo.transform)
					GameUtil.setLocalPos(_kapaiTuoweiPrefabAssetGo, 0, 0, 0)
					Framework.TransformUtil.SetLocalRotation(_kapaiTuoweiPrefabAssetGo.transform, 0, 0, 0)
					table.insert(self.kapai_prefab_go, _kapaiTuoweiPrefabAssetGo)
				end
			end
		end
	end
end

function LotteryeffectView:_playShadowEffectTimer()
	self:PlayShadowEffect(self.need)
end

function LotteryeffectView:_destroyTongYongEffectTimer()
	self:_destroyTongYongEffect()
	removetimer(self._destroyTongYongEffectTimer, self)
end

function LotteryeffectView:_doPlayStarsAudio()
	table.insert(self._fmodEvtInstances, AudioPlayerEx.instance:playEffect(30404))
	removetimer(self._doPlayStarsAudio, self)
end

function LotteryeffectView:_doPlayStarsBombAudio()
	table.insert(self._fmodEvtInstances, AudioPlayerEx.instance:playEffect(30405))
	removetimer(self._doPlayStarsBombAudio, self)
end

function LotteryeffectView:_destroyTongYongEffect()
	if self._tongyongEffect then
		UIEffectManager.instance:stopEffect(self._tongyongEffect)

		self._tongyongEffect = nil
	end
end

function LotteryeffectView:DrawEffectTimer()
	if self._rareEffect then
		UIEffectManager.instance:stopEffect(self._rareEffect)

		self._rareEffect = nil
	end

	self:_destroyTongYongEffect()
end

function LotteryeffectView:ClearTimer()
	removetimer(self.DrawEffectTimer, self)
	removetimer(self._playShadowEffectTimer, self)
	removetimer(self._waitFirstEffect, self)
	removetimer(self._destroyTongYongEffectTimer, self)
	removetimer(self._doPlayStarsAudio, self)
	removetimer(self._doPlayStarsBombAudio, self)
end

function LotteryeffectView:PlayShadowEffect(need)
	if need then
		if need == 1 then
			LotteryController.instance:SetTenDrawCardNeedShow(nil)
		else
			LotteryController.instance:SetTenDrawCardNeedShow(true)
		end
	end

	self:_loadPetSpineParentEffect(need)

	if need and need == 1 then
		LotteryController.instance:SetPetRareList(nil)
	end

	LotteryController.instance:SetRecordNeedCount(nil)
end

function LotteryeffectView:_loadPetSpineParentEffect(_need)
	if not _need then
		return
	end

	local _petRareList = LotteryController.instance:GetPetRareList()

	if not _petRareList then
		return
	end

	local _petSpineParentEff = {
		{
			"fx_chouka/huode/fx_chouka_huode_baise.prefab",
			"baise"
		},
		{
			"fx_chouka/huode/fx_chouka_huode_lanse.prefab",
			"lanse"
		},
		{
			"fx_chouka/huode/fx_chouka_huode_zise.prefab",
			"zise"
		},
		{
			"fx_chouka/huode/fx_chouka_huode_jinse.prefab",
			"jinse"
		}
	}

	if _need == 1 then
		self:_showPetPopView()
	else
		self._petSpineParentEffect = self._petSpineParentEffect or {}

		for i = 1, 10 do
			local effect_path = _petSpineParentEff[_petRareList[i]][1]

			self._petSpineParentEffect[i] = UIEffectManager.instance:playEffect(self, effect_path, nil, 0, 0, true, nil, function(finishHandlerTarget, eff)
				return
			end, function(finishHandlerTarget, eff)
				Framework.TransformUtil.SetLocalPos(eff.effGo.transform, 0, 0, 0)
				GameUtil.setLocalScale(eff.effGo, 1, 1, 1)
				self._petSpineParentEffect[i]:setLayer(SceneLayer.SkillEffects_II_Value)

				local _jingLingObj = goutil.findChild(eff.effGo.transform, _petSpineParentEff[_petRareList[i]][2] .. "/jingling")

				self:_loadPetSpine(_jingLingObj, i, _need)
			end)

			self._petSpineParentEffect[i]:setParent(self._targetObj[i].transform)
		end
	end
end

function LotteryeffectView:_clearPetSpineParentEffect()
	if self._petSpineParentEffect then
		for i = 1, 10 do
			if self._petSpineParentEffect[i] then
				UIEffectManager.instance:stopEffect(self._petSpineParentEffect[i])

				self._petSpineParentEffect[i] = nil
			end
		end
	end
end

function LotteryeffectView:_loadPetSpine(_parent, _index, _need)
	if not _parent or not _index or not _need then
		return
	end

	local _petFaceList = LotteryController.instance:GetPetCurFaceList()

	if not _petFaceList or #_petFaceList <= 0 then
		return
	end

	self._skeletonLoader = self._skeletonLoader or {}
	self._skeletonGO = self._skeletonGO or {}

	local faceId = _petFaceList[_index].raceid
	local modelCo = CharacterConfig.instance:getModelCo(faceId)
	local url = GameUrl.getSpineUrl(modelCo.resName, modelCo.battleResName)

	self._skeletonLoader[_index] = PrefabLoader.Get(_parent)

	self._skeletonLoader[_index]:load(url, function()
		if not self._clickJumpClose and self._skeletonLoader and _index and self._skeletonLoader[_index] then
			self._skeletonGO[_index] = self._skeletonLoader[_index]:getInst()

			GameUtil.setLocalPos(self._skeletonGO[_index], 0, 0, 0)
			Framework.GameObjectUtil.SetLayerRecursively(self._skeletonGO[_index], SceneLayer.SkillEffects_II_Value)
			GoUtil.SetSortingOrder(self._skeletonGO[_index].gameObject, 300)

			self._loadPetSpineCount = self._loadPetSpineCount + 1

			if self._loadPetSpineCount >= _need then
				self:_playPetAnimation(_need)
			end
		end
	end, self, true)
end

function LotteryeffectView:_clearPetSpine()
	if self._skeletonLoader then
		for i = 1, 10 do
			if self._skeletonLoader[i] ~= nil then
				RoleObjectPool.instance:removeRole(self._skeletonLoader[i])

				self._skeletonLoader[i] = nil
			end
		end

		self._skeletonLoader = nil
	end

	if self._skeletonGO then
		for i = 1, 10 do
			self._skeletonGO[i] = nil
		end

		self._skeletonGO = nil
	end
end

function LotteryeffectView:_playPetAnimation(_need)
	if self._clickJumpClose or not _need then
		return
	end

	self._petRareList = LotteryController.instance:GetPetRareList()
	self._petFaceList = LotteryController.instance:GetPetCurFaceList()

	if _need ~= 1 then
		self._checkClickEffect = true

		local bgEffectType = LotteryController.instance:getLotteryBgEffectType()
		local _aniEffectPath = "storyconfig/animations/chouka_huode_shichou.txt"

		if bgEffectType == GameEnum.LotteryBgEffectType.MengZhiDui then
			_aniEffectPath = "storyconfig/animations/chouka_huode_shichou_mengzhidui.txt"
		elseif bgEffectType == GameEnum.LotteryBgEffectType.YiRenZhiXia then
			_aniEffectPath = "storyconfig/animations/chouka_huode_shichou_yirenzhixia.txt"
		end

		self._animationPlayer = AnimationPlayer.play(_aniEffectPath, self._onAnimPlayFinish, self._onAnimPlayStart, self, 1, true, true, self._targetObj)

		self._animationPlayer:setEvtHandler(function(_onEvtHandlerObj, evtName, go, param1, param2, param3, param4, param5)
			if not self._animationPlayer then
				return
			end

			if evtName == "SendMsg" then
				if string.find(param1, "Target") then
					self:_handleTargetMsg(param1)
				elseif param1 == "AppearSound" then
					self:_handleAppearSoundMsg(param2)
				end
			end
		end, self)
	end
end

function LotteryeffectView:_handleTargetMsg(param1)
	if self._clickJumpClose then
		return
	end

	if param1 then
		local _posS, _posE = string.find(param1, "Target")

		if _posS and _posE then
			local _order = tonumber(string.sub(param1, _posE + 1)) + 1

			if self._petRareList and self._petRareList[_order] and self._petRareList[_order] == GameEnum.PetRare.SSR and self._petFaceList and self._petFaceList[_order] and self._petFaceList[_order].petId then
				self._checkClickEffect = false

				if self._animationPlayer then
					self._animationPlayer:Pause()
				end

				local pet = BagModel.instance:getPet(self._petFaceList[_order].petId)

				if pet then
					UIStateManager.instance:open(ViewName.PetDisplay, pet)
					table.insert(self._ssrShowDone, self._petFaceList[_order].petId)
				else
					self:_onLotteryAniContinue()
				end
			end
		end
	end
end

function LotteryeffectView:_handleAppearSoundMsg(param2)
	if self._clickJumpClose then
		return
	end

	local _order = tonumber(param2)

	if self._petRareList and (self._petRareList[_order] == 4 or self._petRareList[_order] == 3) then
		table.insert(self._fmodEvtInstances, AudioPlayerEx.instance:playEffect(30406))
	else
		table.insert(self._fmodEvtInstances, AudioPlayerEx.instance:playEffect(30407))
	end
end

function LotteryeffectView:_clearAnimationPlayer()
	if self._animationPlayer then
		local animationPlayer = self._animationPlayer

		self._animationPlayer = nil

		animationPlayer:Stop()
	end
end

function LotteryeffectView:_clearEffectObj()
	if self._targetObj then
		for i = 1, 10 do
			if self._targetObj[i] then
				self._targetObj[i].transform:SetParent(self.mainGO.transform)
			end
		end
	end
end

function LotteryeffectView:_onAnimPlayFinish()
	self:_clearAnimationPlayer()
	self:_clearEffectObj()

	if LotteryController.instance:GetInLotteryLogic() then
		self:close()
		LotteryController.instance:clearLottery()
	end
end

function LotteryeffectView:_onAnimPlayStart()
	return
end

function LotteryeffectView:_onLotteryAniContinue()
	if self._clickJumpClose then
		self:JumpSkipTenDraw()
	else
		if self._animationPlayer then
			self._animationPlayer:Resume()
		end

		self._checkClickEffect = true
	end
end

function LotteryeffectView:_initPrefabResLoad(_call_back)
	if self.effect_mat_res then
		return
	end

	if not self.need then
		return
	end

	self._resLoader = MultiResLoader.New()
	self.resourcesList = {}

	if self.need == 1 then
		self:_playFirstEffect()
	else
		self:_getMaxRare()
		table.insert(self.resourcesList, "effect/prefabs/ui/fx_chouka/shichou/baise.prefab")
		table.insert(self.resourcesList, "effect/prefabs/ui/fx_chouka/shichou/lanse.prefab")
		table.insert(self.resourcesList, "effect/prefabs/ui/fx_chouka/shichou/zise.prefab")
		table.insert(self.resourcesList, "effect/prefabs/ui/fx_chouka/shichou/jinse.prefab")
		table.insert(self.resourcesList, "effect/prefabs/ui/fx_chouka/shichou/baise_tuowei.prefab")
		table.insert(self.resourcesList, "effect/prefabs/ui/fx_chouka/shichou/lanse_tuowei.prefab")
		table.insert(self.resourcesList, "effect/prefabs/ui/fx_chouka/shichou/zise_tuowei.prefab")
		table.insert(self.resourcesList, "effect/prefabs/ui/fx_chouka/shichou/jinse_tuowei.prefab")
	end

	if #self.resourcesList > 0 then
		self._resLoader:setResPaths(self.resourcesList)
		self._resLoader:load(function()
			self.effect_prefab_res = {}

			for i = 1, #self.resourcesList do
				self.effect_prefab_res[i] = self._resLoader:getResource(self.resourcesList[i])
			end

			self:_playFirstEffect()
		end, nil, self)
	end
end

function LotteryeffectView:_clearPrefabGo()
	if self.kapai_prefab_go then
		for k, v in pairs(self.kapai_prefab_go) do
			goutil.destroy(self.kapai_prefab_go[k].gameObject)

			self.kapai_prefab_go[k] = nil
		end
	end
end

function LotteryeffectView:_clearFmodEvents()
	if self._fmodEvtInstances then
		for i = 1, #self._fmodEvtInstances do
			AudioPlayerEx.instance:stopEvent(self._fmodEvtInstances[i])
		end

		self._fmodEvtInstances = nil
	end
end

function LotteryeffectView:_clearPrefabRes()
	self:_clearPrefabGo()

	if self._resLoader then
		GameUtil.unloadMultiResLoaderResource(self._resLoader)

		self._resLoader = nil
	end

	if self.effect_prefab_res then
		for i = 1, #self.effect_prefab_res do
			if self.effect_prefab_res[i] ~= nil then
				self.effect_prefab_res[i] = nil
			end
		end

		self.effect_prefab_res = nil
	end
end

return LotteryeffectView
