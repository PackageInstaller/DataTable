-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formation/controller/FormationSetDefenseController.lua

module("logic.extensions.formation.controller.FormationSetDefenseController", package.seeall)

local FormationSetDefenseController = class("FormationSetDefenseController", BaseController)

function FormationSetDefenseController:onInit()
	self:onReset()
	GlobalDispatcher:addListener(GlobalNotify.StartEnterGame, self._bindLocalNotity, self)
end

function FormationSetDefenseController:onReset()
	self:clear()
end

function FormationSetDefenseController:_bindLocalNotity()
	ArenaController.instance:registerLocalNotify("RefreshOtherForm", self._refreshFromation, self)
	GlobalDispatcher:addListener(GlobalNotify.RankingMatchGetMyDefenseFormRes, self._onRankingMatchGetMyDefenseFormRes, self)
	GlobalDispatcher:addListener(GlobalNotify.HandlePM_KingArenaViewFormRes, self._onHandlePM_KingArenaViewFormRes, self)
	GlobalDispatcher:addListener(GlobalNotify.OneKeySetDefenseSelectPrefabTab, self._onOneKeySetDefenseSelectPrefabTab, self)
	GlobalDispatcher:addListener(ArenaAgent.SetMyArenaFormationRes, self._onSetDefenseFmtFinish, self)
	GlobalDispatcher:addListener(GlobalNotify.PeakTournamentFormRes, self._onPeakTournamentFormRes, self)
	GlobalDispatcher:addListener(GlobalNotify.PeakTournamentSetFormRes, self._onSetDefenseFmtFinish, self)
	GlobalDispatcher:addListener(GlobalNotify.RankSetDefenseForm, self._onSetDefenseFmtFinish, self)
	GlobalDispatcher:addListener(GlobalNotify.OneKeySetDefenseSaveFmtFailed, self._onOneKeySetDefenseSaveFmtFailed, self)
	GlobalDispatcher:addListener(Arena3v3Agent.Arena3v3SetMyDefenseFormationRes, self._onArena3v3SetMyDefenseFormationRes, self)
	GlobalDispatcher:addListener(GlobalNotify.HandlePM_KingArenaSetDefenseFormRes, self._onHandlePM_KingArenaSetDefenseFormRes, self)
end

function FormationSetDefenseController:sendGetData(tabType)
	self._sendGetDataTabType = tabType

	if tabType == FormationsetdefenseView.TabType.Jingjichang then
		ArenaAgent.instance:sendGetMyArenaFormationReq()
	elseif tabType == FormationsetdefenseView.TabType.Pk3v3 then
		if SeniorArenaController.instance:getIsOpen(true) then
			SeniorArenaController.instance:checkMyDefendForms(self._onGetSeniorArena, self)
		else
			self:_onGetSeniorArena()
		end
	elseif tabType == FormationsetdefenseView.TabType.Paiweisai1 then
		RankRaceFmtController.instance:onlySendGetDefenseFormData(RankRaceController.MatchTypeClassics)
	elseif tabType == FormationsetdefenseView.TabType.Paiweisai2 then
		RankRaceFmtController.instance:onlySendGetDefenseFormData(RankRaceController.MatchTypeLimit)
	elseif tabType == FormationsetdefenseView.TabType.Dianfengsai then
		local actId = PeakTournamentController.instance:getCurActivityId()

		actId = checknumber(actId)

		if actId <= 0 then
			self:_onPeakTournamentFormRes()
		else
			PeakTournamentController.instance:sendPM_PeakTournamentGetFormReq(actId, true)
		end
	elseif tabType == FormationsetdefenseView.TabType.KingArea then
		KingArenaAgent.instance:sendPM_KingArenaViewFormReq(checknumber(RoleModel.instance:getUserId()))
	end
end

function FormationSetDefenseController:sendModifyFormation(tabType, nextTabType, notCheckEmpty, closeViewName)
	local positionsList = FormationSetDefenseModel.instance:getDefenseFmtPositions(tabType)

	if not notCheckEmpty then
		for i, v in ipairs(positionsList) do
			if v.formationMo:isEmpty() then
				local text = "存在未布置的守阵，是否保存？"

				TipsFacade.instance:openPopupWindow("提示", text, function()
					self:sendModifyFormation(tabType, nextTabType, true, closeViewName)
				end)

				return false
			end
		end
	end

	self._sendSetTabType = tabType
	self._nextTabType = nextTabType

	if tabType == FormationsetdefenseView.TabType.Jingjichang then
		local positions = positionsList[1]
		local req = ArenaExtension_pb.SetMyArenaFormationReq()

		positions.formationMo:createFormPb(req.simpleForm)
		ArenaAgent.instance:sendSetMyArenaFormationReq(req)
	elseif tabType == FormationsetdefenseView.TabType.Pk3v3 then
		if not SeniorArenaController.instance:getIsOpen(true) then
			self:revertFormation(tabType)
			GlobalDispatcher:dispatch(GlobalNotify.OneKeySetDefenseRefreshView)
			FloatWordMgr.instance:show("不在活动范围内，无法设置")

			return
		end

		local simpleFormList = {}

		for i, v in ipairs(positionsList) do
			local form = Arena3v3Extension_pb.Arena3v3SetFormNO()

			form.formId = v.index

			FormationFacade.createFormPb(form.simpleForm, v.formationMo)
			table.insert(simpleFormList, form)
		end

		Arena3v3Agent.instance:sendArena3v3SetMyDefenseFormationReq(simpleFormList)
	elseif tabType == FormationsetdefenseView.TabType.Paiweisai1 then
		local form = positionsList[1].formationMo:createFormPb()

		RankingMatchAgent.instance:sendRM_SetDefenseFormReq(RankRaceController.MatchTypeClassics, form)
	elseif tabType == FormationsetdefenseView.TabType.Paiweisai2 then
		local form = positionsList[1].formationMo:createFormPb()

		RankingMatchAgent.instance:sendRM_SetDefenseFormReq(RankRaceController.MatchTypeLimit, form)
	elseif tabType == FormationsetdefenseView.TabType.Dianfengsai then
		local actId = PeakTournamentController.instance:getCurActivityId()

		actId = checknumber(actId)

		if actId <= 0 then
			self:revertFormation(tabType)
			GlobalDispatcher:dispatch(GlobalNotify.OneKeySetDefenseRefreshView)
			FloatWordMgr.instance:show("不在活动范围内，无法设置")
			self:_dispatchSwithTab()

			return
		end

		local simpleFormList = {}

		for i, v in ipairs(positionsList) do
			if v.formationMo:isEmpty() then
				FloatWordMgr.instance:show(string.format("阵型%s不能设置空阵", v.index))

				if self._nextTabType then
					self:revertFormation(tabType)
				end

				self:_dispatchSwithTab()

				return
			end

			table.insert(simpleFormList, v.formationMo:createFormPb())
		end

		PeakTournamentController.instance:sendPM_PeakTournamentSetFormReq(actId, simpleFormList, true)
	elseif tabType == FormationsetdefenseView.TabType.KingArea then
		local form = positionsList[1].formationMo:createFormPb()

		KingArenaAgent:sendPM_KingArenaSetDefenseFormReq(form)
	end

	if closeViewName then
		UIStateManager.instance:popByName(closeViewName)
	end

	return true
end

function FormationSetDefenseController:_refreshFromation()
	if self._sendGetDataTabType ~= FormationsetdefenseView.TabType.Jingjichang then
		return
	end

	local teamMo = FormationNewModel.instance:GetTeam(FormationNewModel.arenaTeamId)
	local positionsList

	if teamMo then
		local formationMo = teamMo:GetCurFormation()
		local positions = formationMo:GetPositions()

		positionsList = {}

		table.insert(positionsList, {
			index = 1,
			formationMo = formationMo
		})
	end

	positionsList = self:_fillPositionList(positionsList, 1)

	FormationSetDefenseModel.instance:setDefenseFmtPositions(FormationsetdefenseView.TabType.Jingjichang, positionsList)
	GlobalDispatcher:dispatch(GlobalNotify.OneKeySetDefenseRefreshView)
end

function FormationSetDefenseController:_onGetSeniorArena()
	if self._sendGetDataTabType ~= FormationsetdefenseView.TabType.Pk3v3 then
		return
	end

	local mos = SeniorArenaModel.instance:getMyDefendFormMos()
	local positionsList = {}

	if mos then
		for formId, playerFormMo in pairs(mos) do
			local positions = {}

			for i = 1, 9 do
				local petMo = playerFormMo:getPetMoByIdx(i)

				if petMo then
					positions[i] = petMo.petId
				end
			end

			local data = {
				index = playerFormMo:getFormId(),
				formationMo = FormationMO.New()
			}

			table.insert(positionsList, data)

			if playerFormMo._curForm then
				data.formationMo:SetData(playerFormMo._curForm)
			end
		end
	end

	positionsList = self:_fillPositionList(positionsList, 3)

	FormationSetDefenseModel.instance:setDefenseFmtPositions(FormationsetdefenseView.TabType.Pk3v3, positionsList)
	GlobalDispatcher:dispatch(GlobalNotify.OneKeySetDefenseRefreshView)
end

function FormationSetDefenseController:_onRankingMatchGetMyDefenseFormRes()
	if self._sendGetDataTabType ~= FormationsetdefenseView.TabType.Paiweisai1 and self._sendGetDataTabType ~= FormationsetdefenseView.TabType.Paiweisai2 then
		return
	end

	local formationMo = RankRaceFmtModel.instance:getDefenseForm(self._sendGetDataTabType == FormationsetdefenseView.TabType.Paiweisai1 and RankRaceController.MatchTypeClassics or RankRaceController.MatchTypeLimit)
	local positionsList = {}

	if formationMo then
		local data = {
			index = 1,
			formationMo = formationMo
		}

		table.insert(positionsList, data)
	end

	positionsList = self:_fillPositionList(positionsList, 1)

	FormationSetDefenseModel.instance:setDefenseFmtPositions(self._sendGetDataTabType, positionsList)
	GlobalDispatcher:dispatch(GlobalNotify.OneKeySetDefenseRefreshView)
end

function FormationSetDefenseController:_onHandlePM_KingArenaViewFormRes(status, msg)
	if self._sendGetDataTabType ~= FormationsetdefenseView.TabType.KingArea then
		return
	end

	if checknumber(msg.playerId) ~= checknumber(RoleModel.instance:getUserId()) then
		return
	end

	local positionsList = {}

	if status == 0 then
		local data = {
			index = 1,
			formationMo = FormationMO.New()
		}

		data.formationMo:SetData(msg.playerView.curForm)
		table.insert(positionsList, data)
	end

	positionsList = self:_fillPositionList(positionsList, 1)

	FormationSetDefenseModel.instance:setDefenseFmtPositions(FormationsetdefenseView.TabType.KingArea, positionsList)
	GlobalDispatcher:dispatch(GlobalNotify.OneKeySetDefenseRefreshView)
end

function FormationSetDefenseController:_fillPositionList(positionsList, count)
	if positionsList == nil then
		positionsList = {}
	end

	for i = #positionsList + 1, count do
		table.insert(positionsList, {
			index = i,
			formationMo = FormationMO.New()
		})
	end

	return positionsList
end

function FormationSetDefenseController:revertFormation(tabType)
	local oriPositionsList = FormationSetDefenseModel.instance:getOriDefenseFmtPositions(tabType)

	if oriPositionsList then
		FormationSetDefenseModel.instance:setOriDefenseFmtPositions(tabType, nil)
		FormationSetDefenseModel.instance:setDefenseFmtPositions(tabType, oriPositionsList)
	end
end

function FormationSetDefenseController:_onOneKeySetDefenseSelectPrefabTab(tabInfo)
	if tabInfo then
		local tabType, index = FormationSetDefenseModel.instance:getCurrIndex()

		if not tabType then
			return
		end

		local positionsList = FormationSetDefenseModel.instance:getDefenseFmtPositions(tabType)

		if not positionsList then
			return
		end

		local banRaceId = {}

		if tabType == FormationsetdefenseView.TabType.Dianfengsai then
			local tempBanRaceId = PeakTournamentModel.instance:getMyDefenseFormBanRaceIds()

			if tempBanRaceId then
				for i, raceId in ipairs(tempBanRaceId) do
					banRaceId[raceId] = true
				end
			end
		end

		local oriPositionsList = FormationSetDefenseModel.instance:getOriDefenseFmtPositions(tabType)

		if not oriPositionsList then
			FormationSetDefenseModel.instance:setOriDefenseFmtPositions(tabType, positionsList)
		end

		local modifyData
		local curPositionsList = {}

		for i, v in ipairs(positionsList) do
			if v.index == index then
				local positions = {}

				for i = 1, 9 do
					positions[i] = 0
				end

				for i, v in ipairs(tabInfo.simpleForm.pos) do
					positions[i] = v
				end

				modifyData = {
					index = index,
					formationMo = FormationMO.New()
				}

				table.insert(curPositionsList, modifyData)
			else
				table.insert(curPositionsList, v)
			end
		end

		FormationSetDefenseModel.instance:setDefenseFmtPositions(tabType, curPositionsList)

		if not modifyData then
			return
		end

		local formationMo = modifyData.formationMo
		local summonMasterId = checknumber(formationMo:GetSummonMasterPetId())
		local summonedPetId = checknumber(formationMo:GetSummonPetId())
		local simpleForm = tabInfo.simpleForm

		formationMo:SetData(simpleForm)

		for i, v in ipairs(curPositionsList) do
			for i = 1, 9 do
				local fmtMo = v.formationMo
				local petId = fmtMo:GetPosition(i)

				if petId ~= 0 then
					local petMo = formationMo:_getPet(petId)

					if petMo and banRaceId[petMo.raceId] then
						formationMo:SetPosition(i, 0, true)
					end
				end
			end
		end

		for i, v in ipairs(curPositionsList) do
			if v.index ~= modifyData.index then
				for i = 1, 9 do
					local petId = formationMo:GetPosition(i)

					if v.formationMo:HasPet(petId) then
						formationMo:SetPosition(i, 0, true)
					end
				end
			end
		end

		local maxPetNum = MissionModel.instance:getMaxPetNum()
		local needDeletePetCount = 0

		for i = 1, 9 do
			if formationMo:GetPosition(i) > 0 and formationMo:GetPosition(i) ~= summonedPetId then
				needDeletePetCount = needDeletePetCount + 1
			end
		end

		needDeletePetCount = needDeletePetCount - maxPetNum

		for i = 1, 9 do
			if needDeletePetCount <= 0 then
				break
			end

			local checkPetId = formationMo:GetPosition(i)

			if checkPetId > 0 and checkPetId ~= summonMasterId and checkPetId ~= summonedPetId then
				formationMo:SetPosition(i, 0, true)

				needDeletePetCount = needDeletePetCount - 1
			end
		end

		GlobalDispatcher:dispatch(GlobalNotify.OneKeySetDefenseRefreshView)
	end
end

function FormationSetDefenseController:clear()
	FormationSetDefenseModel.instance:clear()

	self._sendSetTabType = nil
	self._sendGetDataTabType = nil
end

function FormationSetDefenseController:_onSetDefenseFmtFinish()
	local tabType = self._sendSetTabType

	if not tabType then
		return
	end

	FloatWordMgr.instance:show("设置阵型成功")

	local positionsList = FormationSetDefenseModel.instance:getDefenseFmtPositions(tabType)

	GlobalDispatcher:dispatch(GlobalNotify.OneKeySetDefenseUpdateFormationView, tabType, positionsList)
	FormationSetDefenseModel.instance:setOriDefenseFmtPositions(tabType, nil)
	self:_dispatchSwithTab()
end

function FormationSetDefenseController:_onPeakTournamentFormRes()
	if self._sendGetDataTabType ~= FormationsetdefenseView.TabType.Dianfengsai then
		return
	end

	local forms = PeakTournamentModel.instance:getMyFormInfoList()
	local positionsList = {}

	if forms then
		for i, v in ipairs(forms) do
			local data = {
				index = v.formId,
				formationMo = FormationMO.New()
			}

			data.formationMo:SetData(v.view.curForm)
			table.insert(positionsList, data)
		end
	end

	positionsList = self:_fillPositionList(positionsList, 3)

	FormationSetDefenseModel.instance:setDefenseFmtPositions(FormationsetdefenseView.TabType.Dianfengsai, positionsList)
	GlobalDispatcher:dispatch(GlobalNotify.OneKeySetDefenseRefreshView)
end

function FormationSetDefenseController:_onOneKeySetDefenseSaveFmtFailed()
	local tabType = self._sendSetTabType

	if not tabType then
		return
	end

	FloatWordMgr.instance:show("设置阵型失败,恢复初始状态")
	self:revertFormation(tabType)
	GlobalDispatcher:dispatch(GlobalNotify.OneKeySetDefenseRefreshView)
	self:_dispatchSwithTab()
end

function FormationSetDefenseController:_onArena3v3SetMyDefenseFormationRes(status)
	if self._sendSetTabType ~= FormationsetdefenseView.TabType.Pk3v3 then
		return
	end

	if status == 0 then
		self:_onSetDefenseFmtFinish()
	else
		self:_onOneKeySetDefenseSaveFmtFailed()
	end
end

function FormationSetDefenseController:_onHandlePM_KingArenaSetDefenseFormRes(status, msg)
	if self._sendSetTabType ~= FormationsetdefenseView.TabType.KingArea then
		return
	end

	if status == 0 then
		self:_onSetDefenseFmtFinish()
	else
		self:_onOneKeySetDefenseSaveFmtFailed()
	end
end

function FormationSetDefenseController:_dispatchSwithTab()
	if self._nextTabType then
		GlobalDispatcher:dispatch(GlobalNotify.OneKeySetDefenseSwithTabType, self._nextTabType)
	end
end

FormationSetDefenseController.instance = FormationSetDefenseController.New()

return FormationSetDefenseController
