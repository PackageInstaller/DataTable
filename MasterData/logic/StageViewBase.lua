-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/plotcopy/view/StageViewBase.lua

module("logic.extensions.plotcopy.view.StageViewBase", package.seeall)

local StageViewBase = class("StageViewBase", ViewComponent)

function StageViewBase:ctor()
	self.costStrengthNum = -1
end

function StageViewBase:buildUI()
	self._closeButton = self:getBtn("btnClose")
	self._btnStory = self:getBtn("main/top/btnStory")
	self._txtProgress = self:getGo("main/top/txtProgress"):GetComponent(goutil.Type_UIText)
	self._txtDesc = self:getGo("main/top/txtDesc"):GetComponent(goutil.Type_UIText)
	self._starContainer = self:getGo("main/top/stars")
	self._txtRecmdPower = self:getGo("main/top/fightpower/txtRecmdPower"):GetComponent(goutil.Type_UIText)
	self._perfectPass = self:getGo("main/top/perfectPass")
	self._passCondition = self:getGo("main/top/passCondition")
	self._passConditionPos1 = self:getGo("main/top/passConditionPos1")
	self._btnAuto = self:getBtn("main/bottom/btnAuto")
	self._btnStart = self:getBtn("main/bottom/btnStart")
	self._txtStart = goutil.findChild(self._btnStart, "Text"):GetComponent(goutil.Type_UIText)
	self._costPower = self:getGo("main/bottom/costPower")
	self._txtCostNum = self:getGo("main/bottom/costPower/txtCostNum"):GetComponent(goutil.Type_UIText)
	self._btnQuickPass = self:getBtn("main/bottom/btnQuickPass")
	self._tableview = self:getGo("main/bottom/rewardList"):GetComponent("UITableview")
	self._tableCell = self:getGo("main/bottom/rewardList/item")

	self._tableCell:SetActive(false)

	self._txtPassDesc = self:getTxt("main/top/passCondition/condition1/txtPassDesc")
	self._line = self:getGo("main/bottom/costPower/txtCostNum/line")
end

function StageViewBase:bindEvents()
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnStart:AddClickListener(self._onClickStart, self)
	self._btnAuto:AddClickListener(self._onClickAuto, self)
	self._btnQuickPass:AddClickListener(self._onClickQuickPass, self)
end

function StageViewBase:unbindEvents()
	self._closeButton:RemoveClickListener()
	self._btnStart:RemoveClickListener()
	self._btnAuto:RemoveClickListener()
	self._btnQuickPass:RemoveClickListener()
end

function StageViewBase:onEnter()
	GlobalDispatcher:addListener(GlobalNotify.CopyZdlSecKillRes, self._onCopyZdlSecKillRes, self)

	local params = self:getOpenParam()

	if not params or not params[1] or not params[2] then
		return
	end

	self._chapterId = params[1]
	self._stageId = params[2]

	self:setBtnStartState(true)
	self._btnStory.gameObject:SetActive(false)
	self._btnAuto.gameObject:SetActive(false)

	if not goutil.isNil(self._line) then
		self._line:SetActive(false)
	end

	self._perfectPass:SetActive(false)
	self:setComponentPos()
	self._tableview:RegisterCallback(self._numInView, self._cellSize, self._cellAtIndex, self)

	self._curViewDatas = {}

	self:_refreshView()
end

function StageViewBase:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.CopyZdlSecKillRes, self._onCopyZdlSecKillRes, self)
	self:_clearItems()

	self._curPower = nil
end

function StageViewBase:_clearItems()
	self._tableview:Travel(self._clearTableview, self)

	self._curViewDatas = {}

	self._tableview:UnRegisterAllCallbacks()
end

function StageViewBase:_onCopyZdlSecKillRes()
	self:_onClickClose()
end

function StageViewBase:_onClickClose()
	self:close()
end

function StageViewBase:_onClickAuto()
	MopupModel.instance:cliclMainPlotSweep(self._chapterId, self._stageId, 1)
end

function StageViewBase:_getRecZdl()
	local cfg = CopyConfig.instance:getStageById(self._chapterId, self._stageId)

	if cfg then
		local creepsMasterId = cfg.teamIds
		local cfgTeam = CopyConfig.instance:getTeamCfg(creepsMasterId)

		return (self:_getRecommendZdl(creepsMasterId, checknumber((cfgTeam or nil) and cfgTeam.heroSkillId)))
	end

	return 0
end

function StageViewBase:_onClickQuickPass()
	local isPass = self:_isStagePassed()

	if isPass then
		FloatWordMgr.instance:show("您已通关")

		return
	end

	local cfg = CopyConfig.instance:getStageById(self._chapterId, self._stageId)

	if cfg then
		if not cfg.zdlPercent then
			local factor = 100
			local recZdl = self:_getRecZdl()
			local curZdl = self:_getCurPower()
			local compareZdl = Mathf.Ceil(recZdl * (factor / 100))

			printInfo("test 当前战斗力：秒杀战力:推荐战力 =", factor, curZdl, compareZdl, recZdl)

			if curZdl <= compareZdl then
				FloatWordMgr.instance:show(string.format("全阵战力超过 %d 可秒杀", compareZdl))

				return
			end

			PlotChallengeAgent.instance:sendZdlSecKillReq(self._chapterId, self._stageId)
		end
	end
end

function StageViewBase:_onClickStart()
	if not self:isStartConditionReach() then
		return
	end

	self:_openCopyMissionView()
end

function StageViewBase:isStartConditionReach()
	local isEnough = PlotCopyModel.instance:isPowerEnough(self._chapterId, self._stageId)

	if not isEnough then
		ViewMgr.instance:open(ViewName.RecoveryTili)

		return false
	end

	return true
end

function StageViewBase:_openCopyMissionView()
	self:_onClickClose()
	UIStateManager.instance:popByName(ViewName.ItemGet)
	UIStateManager.instance:push(ViewName.CopyMissionView, self._chapterId, self._stageId)
end

function StageViewBase:_refreshView()
	self.costStrengthNum = -1

	local cfg = CopyConfig.instance:getStageById(self._chapterId, self._stageId)

	if cfg then
		self._txtDesc.text = cfg.desc
		self._txtProgress.text = cfg.stageName

		local creepsMasterId = cfg.teamIds
		local cfgTeam = CopyConfig.instance:getTeamCfg(creepsMasterId)
		local heroSkillId = 0

		if cfgTeam then
			heroSkillId = cfgTeam.heroSkillId

			self:setCostPower()

			self._txtCostNum.text = cfgTeam.strengthConsumption
			self.costStrengthNum = cfgTeam.strengthConsumption

			self:_updateRewardList(cfgTeam)
		end

		local recZdl = self:_getRecommendZdl(creepsMasterId, checknumber(heroSkillId))

		self._txtRecmdPower.text = recZdl
		self._txtStart.text = "前往挑战"

		local isPass = PlotCopyModel.instance:isStagePassed(self._chapterId, self._stageId)

		self._btnAuto.gameObject:SetActive(isPass)

		if not goutil.isNil(self._line) then
			self._line:SetActive(not isPass)
		end

		self._txtPassDesc.text = cfg.passDesc

		self:_setBtnQuickPassActive(recZdl, isPass, cfg.zdlPercent, cfg.isMs)
	end
end

function StageViewBase:_updateRewardList(cfgTeam)
	if not self:_isStagePassed() and cfgTeam and not string.nilorempty(cfgTeam.firstPassPrize) then
		local items = string.split(cfgTeam.firstPassPrize, "#")
		local length = #items

		for i = 1, length do
			local index = #self._curViewDatas + 1

			self._curViewDatas[index] = self._curViewDatas[index] or {}
			self._curViewDatas[index].rewardStr = items[i]
			self._curViewDatas[index].isPerfect = false
			self._curViewDatas[index].isFirst = true
		end
	end

	if cfgTeam and not string.nilorempty(cfgTeam.reward) then
		local str2 = MaterialMgr.changeItemStr(cfgTeam.reward)
		local rewardItems = string.split(str2, "#")
		local length2 = #rewardItems

		for i = 1, length2 do
			if not string.nilorempty(rewardItems[i]) then
				local index = #self._curViewDatas + 1

				self._curViewDatas[index] = self._curViewDatas[index] or {}
				self._curViewDatas[index].rewardStr = rewardItems[i]
				self._curViewDatas[index].isPerfect = false
				self._curViewDatas[index].isFirst = false
			end
		end
	end

	self._tableview:ReloadData()
end

function StageViewBase:setCostPower()
	self._costPower:SetActive(true)
end

function StageViewBase:_isStagePassed()
	return PlotCopyModel.instance:isStagePassed(self._chapterId, self._stageId)
end

function StageViewBase:_getRecommendZdl(creepsMasterId, heroSkillId)
	local cCfgs = CopyConfig.instance:getTeamPets(creepsMasterId)

	if not cCfgs then
		return 0
	end

	return (FightingPowerFormula.instance:getFightingPowerOfFmt(cCfgs, heroSkillId))
end

function StageViewBase:_numInView()
	return #self._curViewDatas
end

function StageViewBase:_cellSize(view, idx)
	if idx + 1 == #self._curViewDatas then
		return 110, 90
	end

	return 90, 90
end

function StageViewBase:_cellAtIndex(view, index)
	local cell = view:DequeueCell()

	cell = cell or view:AddChild(self._tableCell)

	local data = self._curViewDatas[index + 1]

	self:_updateCell(view, cell, data)

	return cell
end

function StageViewBase:_updateCell(view, cell, data)
	local parentGo = goutil.findChild(cell.gameObject, "node")

	Framework.TransformUtil.SetLocalScale(parentGo.transform, 0.8, 0.8, 0.8)

	local imgFirstPass = goutil.findChild(cell.gameObject, "imgFirstPass")
	local imgPerfect = goutil.findChild(cell.gameObject, "imgPerfect")

	imgPerfect:SetActive(data.isPerfect)
	imgFirstPass:SetActive(data.isFirst)

	return (MaterialMgr.setCellByCfg(data.rewardStr, parentGo))
end

function StageViewBase:_clearTableview(cell)
	local parentGo = goutil.findChild(cell.gameObject, "node")

	MaterialMgr.resetAll(parentGo)
end

function StageViewBase:setComponentPos()
	if self._passCondition and self._passConditionPos1 then
		self._passCondition.transform.position = self._passConditionPos1.transform.position
	end
end

function StageViewBase:setBtnStartState(isInteractable)
	self._btnStart.btn.interactable = isInteractable
end

function StageViewBase:_setBtnQuickPassActive(recZdl, isPassStage, zdlPercent, isMs)
	if isMs then
		local curZdl = self:_getCurPower()
		local compareZdl = Mathf.Ceil(recZdl * (zdlPercent / 100))

		goutil.setActive(self._btnQuickPass.gameObject, not isPassStage)
	else
		goutil.setActive(self._btnQuickPass.gameObject, false)
	end
end

function StageViewBase:_getCurPower()
	if self._curPower then
		return self._curPower
	end

	local curForm = FormationNewModel.instance:GetCurTeam():GetCurFormation()
	local team = {}
	local heroSkillId = curForm:GetHeroSkillId()
	local fid = 0
	local flv = 0

	for idx, v in ipairs(curForm:GetPositions()) do
		if v > 0 then
			local pet = BagPetsController.instance:getPet(v)

			if pet then
				table.insert(team, pet)
			end
		end
	end

	local info = curForm:GetFormStrengthInfo()

	if info and info.formStrengthId and info.formStrengthId > 0 then
		fid = info.formStrengthId
		flv = info.formStrengthLv
	end

	local eleMap = curForm:getCurElementRelationMap()
	local cutePetRaceId, cutePetQuality = curForm:getCutePetInfo()
	local masterId = curForm:GetSummonMasterPetId()
	local summonId = curForm:GetSummonPetId()

	self._curPower = FightingPowerFormula.instance:getTeamFightingPower(team, heroSkillId, fid, flv, eleMap, cutePetRaceId, cutePetQuality, masterId, summonId)

	return self._curPower
end

return StageViewBase
