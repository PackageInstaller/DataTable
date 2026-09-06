-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/formation/controller/FormationController.lua

module("logic.extensions.formation.controller.FormationController", package.seeall)

local FormationController = class("FormationController", BaseController)

function FormationController:onInit()
	self._hasModify = false
	self._hasTeamModify = false
	self._buffFormModify = false
	self._hasRaceChange = true
	self.onRecomentSelCallback = nil
	self.onRecomentSelCallbackObj = nil

	self.registerNotify(self, GlobalNotify.ShowFormation, self._onShowFormation, self)
	GlobalDispatcher:addListener(GlobalNotify.SceneLoaded, self._OnSceneChanged, self)
end

function FormationController:_OnSceneChanged(type, sid)
	print("FormationController 进入的场景：>>>>>>>>>>>>>", type, sid)

	if SceneMgr.instance:getCurSceneType() == SceneType.City and self.pupupGetView then
		UIStateManager.instance:push(ViewName.FormationGetView, self.pupupGetView)

		self.pupupGetView = nil
	end
end

function FormationController:onReset()
	self.onRecomentSelCallback = nil
	self.onRecomentSelCallbackObj = nil
end

function FormationController:_onShowFormation(params)
	UIStateManager.instance:push(ViewName.FormationShow, params)
end

function FormationController:ChangeTeamId(id)
	printInfo("队伍选择：=", id, "初始改变状态是 = ", self._hasTeamModify)

	self._hasTeamModify = FormationNewModel.instance:SetCurTeamId(id) or self._hasTeamModify

	printInfo("当前队伍是否发生修改", self._hasTeamModify)
end

function FormationController:setRaceChange()
	self._hasRaceChange = true
end

function FormationController:setTeamTabName(tabId, tabName)
	FormationNewModel.instance:setTeamTabName(tabId, tabName)
end

function FormationController:GetHeroSkillId()
	return FormationNewModel.instance:GetCurTeam():GetCurFormation():GetHeroSkillId()
end

function FormationController:getTeamId()
	return FormationNewModel.instance:GetCurTeamId()
end

function FormationController:setCurrBuffFormInfo(formStrengthId)
	self._buffFormModify = FormationNewModel.instance:setCurrBuffFormInfo(formStrengthId)
end

function FormationController:ChangePosition(pos, value)
	FormationNewModel.instance:GetCurTeam():GetCurFormation():SetPosition(pos, value)
end

function FormationController:setPositionForce(positions, forceDispatch)
	FormationNewModel.instance:GetCurTeam():GetCurFormation():setPositionForce(positions, forceDispatch)
end

function FormationController:ResetCurFormation()
	FormationNewModel.instance:GetCurTeam():GetCurFormation():ResetPosition()
end

function FormationController:ResetHasPet()
	FormationNewModel.instance:GetCurTeam():GetCurFormation():resetHasPet()
end

function FormationController:SaveFormationEx(callback, callbackObj)
	if FormationNewModel.instance:isInArena() then
		local formInfo = FormationNewModel.instance:GetCurTeam():GetCurFormation()
		local req = ArenaExtension_pb.SetMyArenaFormationReq()

		formInfo:createFormPb(req.simpleForm)
		ArenaAgent.instance:sendSetMyArenaFormationReq(req)

		return true
	elseif FormationNewModel.instance:isRecordTeam() then
		return true
	elseif FormationNewModel.instance:isFamilyWarTeam() then
		return true
	else
		local arr = {}
		local formZdlDetail_pb
		local teams = FormationNewModel.instance:GetAllTeams()

		for teamId, teamInfo in pairs(teams) do
			local userFormTab = FormationExtension_pb.PM_UserFormTab()

			userFormTab.tabId = teamId
			userFormTab.curFormId = teamInfo:GetCurFormationId()
			userFormTab.tabName = teamInfo:getTabName()

			local formations = teamInfo:GetAllFormations()
			local change = false

			for formId, formInfo in pairs(formations) do
				local compare = FormationNewModel.instance:compareSeverData(teamId, formId, formInfo)

				if compare ~= 0 then
					change = true

					formInfo:createFormPb(userFormTab.simpleForm)
				end
			end

			if change then
				table.insert(arr, userFormTab)

				if enableDebug then
					local fmo = FormationModel.instance:getTeamFormation()

					if fmo then
						GMView.currErrorClientPets = {}

						local posList = fmo:GetPositions()

						for k, v in pairs(posList) do
							if checknumber(v) > 0 then
								table.insert(GMView.currErrorClientPets, checknumber(v))
							end
						end

						local power, _ = fmo:getPowerAndSpeed()

						formZdlDetail_pb = FormationExtension_pb.PM_CurFormZdlDetail()
						formZdlDetail_pb.formZdl = power

						if RankRaceController.instance:getAvoidFormZdlDetailFlag() then
							formZdlDetail_pb = nil
						end
					end
				end
			end
		end

		if self._hasTeamModify or self._hasRaceChange or #arr > 0 then
			FormationAgent.instance:sendPM_UserFormGlobalInfoEx(FormationNewModel.instance:GetCurTeamId(), arr, formZdlDetail_pb, function(msg, status)
				if status == 0 and callback then
					if callbackObj then
						callback(callbackObj)
					else
						callback()
					end
				end

				if enableDebug and status == 0 and msg.formZdlDetail and checknumber(msg.formZdlDetail.formZdl) > 0 then
					TipsFacade.instance:openCommonTips(lang("当前出战阵型总战力 跟后端不符 ！！，请仔细检查"))

					local formPetZdl = msg.formZdlDetail.formPetZdl
					local list = {}

					for i, v in ipairs(formPetZdl) do
						table.insert(list, v)
					end

					GMView.currErrorDetail = msg.formZdlDetail
					GMView.currErrorDetailClient = formZdlDetail_pb

					GMView.petCompareForm(nil)
				end
			end)

			self._hasTeamModify = false
			self._hasRaceChange = false

			return true
		end
	end

	return false
end

function FormationController:getTeamAndFormation(curForm)
	local team = {}
	local formations = {}
	local speed = 0

	for idx, v in ipairs(curForm:GetPositions()) do
		if v > 0 then
			local pet = BagPetsController.instance:getPet(v)

			if pet then
				table.insert(team, pet)

				formations[idx] = pet

				if not pet:isSummonedPet() then
					speed = speed + pet._speed
				end
			end
		end
	end

	local fid = 0
	local flvl = 0
	local info = curForm:GetFormStrengthInfo()

	if info and info.formStrengthId and info.formStrengthId > 0 then
		fid = info.formStrengthId
		flvl = info.formStrengthLv
	end

	local heroSkillId = curForm:GetHeroSkillId()

	return team, formations, speed, heroSkillId, fid, flvl
end

function FormationController:OnViewClose()
	printInfo("222保存阵型执行了！")
	self:SaveFormationEx()
end

function FormationController:showGainNewFormation(msg)
	local arr = {}
	local tabForm = msg.tabForm

	for k, v in ipairs(tabForm) do
		print(k, v)

		local simpleForm = v.simpleForm

		if simpleForm ~= nil then
			local formId = simpleForm.formId

			if FormationNewModel.instance:checkHasFormId(formId) then
				table.insert(arr, formId)
				print("找到了一个 新的阵型 开启")
			end
		end
	end

	if BattleController.instance:isBattling() or SceneMgr.instance.isGogingToEnterBattleScene then
		self.pupupGetView = msg

		print("找到了一个 新的阵型 开启  战斗中 或者 加载地图中。暂时不处理")
	else
		UIStateManager.instance:push(ViewName.FormationGetView, msg)
		print("找到了一个 新的阵型 开启  show !!!!")
	end

	FormationNewModel.instance:FormChanged(msg.tabForm)
end

function FormationController:isGuidingBuzhen()
	local guideIds = {
		2,
		30,
		32,
		81,
		88
	}

	for i, id in ipairs(guideIds) do
		if GuideController.instance:checkBranchIsGuiding(id) then
			return true
		end
	end

	return false
end

function FormationController:checkCanSort(curViewDatas)
	local limit = ConstConfig.instance:getPetLimltCount()

	if limit > 0 and curViewDatas and limit <= #curViewDatas then
		TipsFacade.instance:openCommonTips(ConstConfig.instance:getPetLimltTips())

		return false
	end

	return true
end

FormationController.instance = FormationController.New()

return FormationController
