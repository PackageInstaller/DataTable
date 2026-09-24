-- chunkname: @modules/logic/towercompose/view/herogroup/TowerComposeHeroGroupEditView.lua

module("modules.logic.towercompose.view.herogroup.TowerComposeHeroGroupEditView", package.seeall)

local TowerComposeHeroGroupEditView = class("TowerComposeHeroGroupEditView", HeroGroupEditView)

function TowerComposeHeroGroupEditView:_btnconfirmOnClick()
	if self._isShowQuickEdit then
		local newHeroUids = HeroGroupQuickEditListModel.instance:getHeroUids()

		if newHeroUids and #newHeroUids > 0 then
			if self._adventure then
				for k, heroUid in pairs(newHeroUids) do
					local mo = HeroModel.instance:getById(heroUid)

					if mo then
						local cd = WeekWalkModel.instance:getCurMapHeroCd(mo.heroId)

						if cd > 0 then
							GameFacade.showToast(ToastEnum.HeroGroupEdit)

							return
						end
					end
				end
			elseif self._isWeekWalk_2 then
				for k, heroUid in pairs(newHeroUids) do
					local mo = HeroModel.instance:getById(heroUid)

					if mo then
						local cd = WeekWalk_2Model.instance:getCurMapHeroCd(mo.heroId)

						if cd > 0 then
							GameFacade.showToast(ToastEnum.HeroGroupEdit)

							return
						end
					end
				end
			elseif self._isTowerBattle then
				for k, heroUid in pairs(newHeroUids) do
					local mo = HeroModel.instance:getById(heroUid)

					if mo and TowerModel.instance:isHeroBan(mo.heroId) then
						GameFacade.showToast(ToastEnum.TowerHeroGroupEdit)

						return
					end
				end
			end

			for index, heroUid in pairs(newHeroUids) do
				local editAssistMoList = HeroGroupModel.instance:getAssistMoList(true)

				for _, pickAssistHeroMo in ipairs(editAssistMoList) do
					if pickAssistHeroMo.heroUid == heroUid then
						HeroSingleGroupModel.instance:removeFrom(index)
					end
				end
			end
		end

		self:_saveQuickGroupInfo()
		self:closeThis()

		return
	end

	if not self:_normalEditHasChange() then
		self:closeThis()

		return
	end

	local singleGroupMO = HeroSingleGroupModel.instance:getById(self._singleGroupMOId)

	if singleGroupMO.trialPos then
		GameFacade.showToast(ToastEnum.TrialCantTakeOff)

		return
	end

	local recordFightParam = TowerComposeModel.instance:getRecordFightParam()
	local themeId = recordFightParam.themeId
	local planeId = Mathf.Ceil(self._singleGroupMOId / 4)
	local isInLockPlane = TowerComposeModel.instance:checkPlaneLock(themeId, planeId)
	local themeMo = TowerComposeModel.instance:getThemeMo(themeId)
	local planeMo = themeMo:getPlaneMo(planeId)

	if isInLockPlane and planeMo.hasFight then
		GameFacade.showToast(ToastEnum.TowerComposeRecordRoleLock)

		return
	end

	if self._heroMO then
		local isEditorAssist = false

		for _, editorAssistMo in ipairs(HeroGroupModel.instance:getAssistMoList(true)) do
			if editorAssistMo.heroUid == self._heroMO.uid then
				isEditorAssist = true

				break
			end
		end

		if isEditorAssist then
			local isInSupport = TowerComposeHeroGroupModel.instance:checkEquipedSupportHero(self._heroMO.heroId)

			if isInSupport then
				GameFacade.showToast(ToastEnum.TrialIsJoin)

				return
			end

			local recordFightParam = TowerComposeModel.instance:getRecordFightParam()

			if recordFightParam.plane == TowerComposeEnum.PlaneType.Twice then
				local targetPlane = Mathf.Ceil(self._singleGroupMOId / 4)
				local canSelect, assistPlane = TowerComposeHeroGroupModel.instance:checkCanSelectAssistHero(self._heroMO.uid, self._singleGroupMOId, self._singleGroupMOId)

				if not canSelect then
					TowerComposeController.instance:showPlaneAssistToast(assistPlane)

					return
				end
			end

			self:_saveCurGroupInfo()
			self:closeThis()

			return
		end

		if self._adventure then
			local cd = WeekWalkModel.instance:getCurMapHeroCd(self._heroMO.heroId)

			if cd > 0 then
				GameFacade.showToast(ToastEnum.HeroGroupEdit)

				return
			end
		elseif self._isWeekWalk_2 then
			local cd = WeekWalk_2Model.instance:getCurMapHeroCd(self._heroMO.heroId)

			if cd > 0 then
				GameFacade.showToast(ToastEnum.HeroGroupEdit)

				return
			end
		elseif self._isTowerBattle and TowerModel.instance:isHeroBan(self._heroMO.heroId) then
			GameFacade.showToast(ToastEnum.TowerHeroGroupEdit)

			return
		end

		if self._heroMO.isPosLock then
			GameFacade.showToast(ToastEnum.TrialCantTakeOff)

			return
		end

		if self._heroMO:isTrial() and not TowerComposeHeroGroupModel.instance:checkCanSelectTrialHero(self._heroMO.trialCo, self._singleGroupMOId) then
			TowerComposeController.instance:showPlaneTrialLimitToast(Mathf.Ceil(self._singleGroupMOId / 4))

			return
		end

		local hasHero, hasHeroIndex = HeroSingleGroupModel.instance:hasHeroUids(self._heroMO.uid, self._singleGroupMOId)

		if hasHero then
			HeroSingleGroupModel.instance:removeFrom(hasHeroIndex)
			HeroSingleGroupModel.instance:addTo(self._heroMO.uid, self._singleGroupMOId)

			if self._heroMO:isTrial() then
				singleGroupMO:setTrial(self._heroMO.trialCo.id, self._heroMO.trialCo.trialTemplate)
			else
				singleGroupMO:setTrial()
			end

			FightAudioMgr.instance:playHeroVoiceRandom(self._heroMO.heroId, CharacterEnum.VoiceType.HeroGroup)
			self:_saveCurGroupInfo()
			self:closeThis()

			return
		end

		if HeroSingleGroupModel.instance:isAidConflict(self._heroMO.heroId) then
			GameFacade.showToast(ToastEnum.HeroIsAidConflict)

			return
		end

		HeroSingleGroupModel.instance:addTo(self._heroMO.uid, self._singleGroupMOId)

		if self._heroMO:isTrial() then
			singleGroupMO:setTrial(self._heroMO.trialCo.id, self._heroMO.trialCo.trialTemplate)
		else
			singleGroupMO:setTrial()
		end

		FightAudioMgr.instance:playHeroVoiceRandom(self._heroMO.heroId, CharacterEnum.VoiceType.HeroGroup)
		self:_saveCurGroupInfo()
		self:closeThis()
	else
		HeroSingleGroupModel.instance:removeFrom(self._singleGroupMOId)
		self:_saveCurGroupInfo()
		self:closeThis()
	end
end

function TowerComposeHeroGroupEditView:_saveQuickGroupInfo()
	if not HeroGroupQuickEditListModel.instance:getIsDirty() then
		return
	end

	local episodeId = HeroGroupModel.instance.episodeId
	local newHeroUids = HeroGroupQuickEditListModel.instance:getHeroUids()

	self:replaceQuickGroupHeroDefaultEquip(newHeroUids)

	local fightParam = TowerComposeModel.instance:getRecordFightParam()
	local isTwice = fightParam.plane == TowerComposeEnum.PlaneType.Twice
	local editorAssistByPlane = {}

	if isTwice then
		for planeId = 1, 2 do
			editorAssistByPlane[planeId] = HeroGroupModel.instance:getEditorAssistMo({
				planeId = planeId
			})
		end
	else
		editorAssistByPlane[fightParam.plane] = HeroGroupModel.instance:getEditorAssistMo({
			planeId = fightParam.plane
		})
	end

	local assistMoByHeroUid = {}

	for _, mo in ipairs(HeroGroupModel.instance:getAssistMoList()) do
		assistMoByHeroUid[mo.heroUid] = mo
	end

	local assistPosByPlane = {}

	for i = 1, HeroGroupModel.instance:getBattleRoleNum() do
		local heroUid = newHeroUids[i]

		if heroUid ~= nil then
			local planeParams = HeroGroupHandler.getAssistParams(episodeId, {
				singleGroupMOId = i
			})

			if heroUid ~= "0" then
				local heroMO = HeroGroupTrialModel.instance:getById(heroUid)

				if heroMO then
					for planeId, editorAssistMo in pairs(editorAssistByPlane) do
						if editorAssistMo and heroMO.heroId == editorAssistMo.heroId then
							HeroSingleGroupModel.instance:remove(heroMO.heroUid)

							break
						end
					end
				end
			end

			local isEditorAssist = false

			for _, editorAssistMo in pairs(editorAssistByPlane) do
				if editorAssistMo and heroUid == editorAssistMo.heroUid then
					isEditorAssist = true

					break
				end
			end

			if not isEditorAssist and not assistMoByHeroUid[heroUid] then
				HeroSingleGroupModel.instance:addTo(heroUid, i)

				local singleGroupMO = HeroSingleGroupModel.instance:getByIndex(i)

				if tonumber(heroUid) < 0 then
					local heroMO = HeroGroupTrialModel.instance:getById(heroUid)

					if heroMO then
						singleGroupMO:setTrial(heroMO.trialCo.id, heroMO.trialCo.trialTemplate)
					else
						singleGroupMO:setTrial()
					end
				else
					singleGroupMO:setTrial()
				end
			end
		end
	end

	if isTwice then
		for planeId = 1, 2 do
			local editorAssistMo = editorAssistByPlane[planeId]
			local startIdx, endIdx = planeId == 2 and 5 or 1, planeId == 2 and 8 or 4
			local assistPos

			if editorAssistMo then
				for i = startIdx, endIdx do
					if newHeroUids[i] == editorAssistMo.heroUid then
						local planeParams = HeroGroupHandler.getAssistParams(episodeId, {
							singleGroupMOId = i
						})

						HeroGroupModel.instance:setAssistMo(editorAssistMo, i, planeParams)

						assistPos = i

						break
					end
				end
			end

			self:_saveQuickGroupAssistPos(assistPos, {
				planeId = planeId
			})

			if assistPos then
				assistPosByPlane[planeId] = assistPos
			end
		end
	else
		local planeId = fightParam.plane
		local editorAssistMo = editorAssistByPlane[planeId]
		local assistPos

		if editorAssistMo then
			for i, heroUid in ipairs(newHeroUids) do
				if heroUid == editorAssistMo.heroUid then
					local planeParams = HeroGroupHandler.getAssistParams(episodeId, {
						singleGroupMOId = i
					})

					HeroGroupModel.instance:setAssistMo(editorAssistMo, i, planeParams)

					assistPos = i

					break
				end
			end
		end

		self:_saveQuickGroupAssistPos(assistPos)

		if assistPos then
			assistPosByPlane[planeId] = assistPos
		end
	end

	HeroGroupModel.instance:replaceSingleGroup()
	HeroGroupModel.instance:replaceSingleGroupEquips()
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
	HeroGroupModel.instance:saveCurGroupData()
end

function TowerComposeHeroGroupEditView:_saveQuickGroupAssistPos(assistPos, assistParams)
	if assistPos then
		HeroSingleGroupModel.instance:removeFrom(assistPos)
	else
		HeroGroupModel.instance:clearCurAssist(false, assistParams)
	end
end

function TowerComposeHeroGroupEditView:_editableInitView()
	TowerComposeHeroGroupEditView.super._editableInitView(self)
end

return TowerComposeHeroGroupEditView
