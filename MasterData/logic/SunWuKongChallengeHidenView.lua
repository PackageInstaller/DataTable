-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sunwukongchallenge/view/SunWuKongChallengeHidenView.lua

module("logic.extensions.sunwukongchallenge.view.SunWuKongChallengeHidenView", package.seeall)

local SunWuKongChallengeHidenView = class("SunWuKongChallengeHidenView", ViewComponent)

function SunWuKongChallengeHidenView:ctor()
	SunWuKongChallengeHidenView.super.ctor(self)
end

function SunWuKongChallengeHidenView:buildUI()
	SunWuKongChallengeHidenView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnDetail = self:getBtn("btnDetail")
	self._btnGoto = self:getBtn("btnGoto")
	self._txtTitle = self:getTxt("titleTxt")
	self._taskTitle = self:getTxt("challengeInfo/challengeDetail/txtTitle")
	self._txtDetail = self:getTxt("challengeInfo/challengeDetail/txtDetail")
	self._itemDetail = self:getGo("challengeInfo/challengeDetail/itemDetail")
	self._txtCost = self:getTxt("challengeInfo/challengeDetail/itemDetail/itemCost/txtNum")
	self._iconCost = self:getGo("challengeInfo/challengeDetail/itemDetail/itemCost/txtNum/icon")
	self._txtOwn = self:getTxt("challengeInfo/challengeDetail/itemDetail/itemOwn/txtNum")
	self._iconOwn = self:getGo("challengeInfo/challengeDetail/itemDetail/itemOwn/txtNum/icon")
	self._txtGoto = self:getTxt("btnGoto/txt")
	self._prizeTableView = self:getGo("challengeInfo/prizeInfo/prizeList")
	self._prizeTableCell = self:getGo("challengeInfo/prizeInfo/prizeList/item")
	self._prizeList = ItemGroup.New(self._prizeTableView, self._prizeTableCell)
	self._petCon = self:getGo("petInfo/con")
end

function SunWuKongChallengeHidenView:bindEvents()
	SunWuKongChallengeHidenView.super.buildUI(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnDetail, self._onClickDetail, self)
	GameUtil.addClickHandler(self._btnGoto, self._onClickGoto, self)
end

function SunWuKongChallengeHidenView:unbindEvents()
	SunWuKongChallengeHidenView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnDetail)
	GameUtil.rmClickHandler(self._btnGoto)
end

function SunWuKongChallengeHidenView:onEnter()
	SunWuKongChallengeHidenView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.PM_SunWuKongChallengeDoHiddenTaskRes, self._PM_SunWuKongChallengeDoHiddenTaskRes, self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._stageId = params[2]
	self._actCfg = SunWuKongChallengeConfig.instance:getActivityCfg(self._activityId)
	self._stageCfg = SunWuKongChallengeConfig.instance:getStageCfg(self._actCfg.stagePlanId, self._stageId)

	if checknumber(self._stageCfg.hiddenTaskId) <= 0 then
		return
	end

	local hiddentTaskCfg = SunWuKongChallengeConfig.instance:getHiddendTaskInfo(self._stageCfg.hiddenTaskId)
	local hiddenTaskInfo = hiddentTaskCfg.taskParams

	self._type = SunWuKongChallengeModel.HiddenType.Battle

	if hiddentTaskCfg.taskType == "Battle" then
		self._type = SunWuKongChallengeModel.HiddenType.Battle
		self._txtGoto.text = lang("挑战")
	elseif hiddentTaskCfg.taskType == "CollectMaterials" then
		self._type = SunWuKongChallengeModel.HiddenType.CollectMaterials
		self._txtGoto.text = lang("上交道具")
	elseif hiddentTaskCfg.taskType == "VerifyPet" then
		self._type = SunWuKongChallengeModel.HiddenType.VerifyPet
		self._txtGoto.text = lang("选择精灵")
	elseif hiddentTaskCfg.taskType == "SmallGame" then
		if checknumber(hiddenTaskInfo.type) == SunWuKongChallengeModel.MiniGameType.Balloon then
			self._type = SunWuKongChallengeModel.HiddenType.Balloon
			self._txtGoto.text = lang("前往")
		elseif checknumber(hiddenTaskInfo.type) == SunWuKongChallengeModel.MiniGameType.FlipGame then
			self._type = SunWuKongChallengeModel.HiddenType.FilpGame
			self._txtGoto.text = lang("前往")
		end
	end

	GameUtil.SetActive(self._txtDetail, self._type ~= SunWuKongChallengeModel.HiddenType.CollectMaterials)
	GameUtil.SetActive(self._itemDetail, self._type == SunWuKongChallengeModel.HiddenType.CollectMaterials)

	self._txtDetail.text = hiddentTaskCfg.taskDatail
	self._taskTitle.text = hiddentTaskCfg.taskDemand
	self._txtTitle.text = hiddentTaskCfg.name

	if self._type == SunWuKongChallengeModel.HiddenType.CollectMaterials then
		local matType, matId, num = MaterialMgr.getMatParams(hiddenTaskInfo.materials)

		self._txtCost.text = num

		MaterialMgr.setIcon(self._iconCost, matType, matId)

		self._txtOwn.text = MaterialModel.instance:getMaterialsNumber(matType, matId)

		MaterialMgr.setIcon(self._iconOwn, matType, matId)
	end

	local prizeCfg = SunWuKongChallengeConfig.instance:getHiddenPrize(hiddentTaskCfg.prizePlanId)

	GameUtil.SetActive(self._btnDetail, #prizeCfg > 1)

	local prize = ""

	for i, v in ipairs(prizeCfg) do
		prize = MaterialMgr.combineStrs(prize, v.prize)
	end

	local prizeList = string.split(prize, "#")

	self._prizeList:updateWithMoArray(prizeList, self._updateCell, self)

	local modelCo = CharacterConfig.instance:getModelCo(checknumber(hiddentTaskCfg.faceId))

	if not modelCo then
		printError("t_model id not exist:" .. hiddentTaskCfg.faceId)

		return
	end

	uGuiUtil.setSpriteToImage(self._petCon, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCo.cardName))
end

function SunWuKongChallengeHidenView:onExit()
	SunWuKongChallengeHidenView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PM_SunWuKongChallengeDoHiddenTaskRes, self._PM_SunWuKongChallengeDoHiddenTaskRes, self)
	MaterialMgr.resetAll(self._iconCost)
	MaterialMgr.resetAll(self._iconOwn)
	self._prizeList:dispose(self._clearCell, self)
end

function SunWuKongChallengeHidenView:_updateCell(cell, data, i)
	local go = cell.mainGO

	MaterialMgr.setCellByCfg(data, go)
end

function SunWuKongChallengeHidenView:_clearCell(cell)
	local go = cell.mainGO

	MaterialMgr.resetAll(go)
end

function SunWuKongChallengeHidenView:_onClickGoto()
	SunWuKongChallengeController.instance:setLatestStage(self._stageId)

	if self._type == SunWuKongChallengeModel.HiddenType.CollectMaterials then
		self:_onClickSubmitItem()
	elseif self._type == SunWuKongChallengeModel.HiddenType.VerifyPet then
		self:_onClickSubmitRole()
	elseif self._type == SunWuKongChallengeModel.HiddenType.Battle then
		self:_onClickFight()
	elseif self._type == SunWuKongChallengeModel.HiddenType.Balloon then
		self:_onClickBalloonGame()
	elseif self._type == SunWuKongChallengeModel.HiddenType.FilpGame then
		self:_onClickFlipGame()
	end
end

function SunWuKongChallengeHidenView:_onClickSubmitItem()
	local hiddentTaskCfg = SunWuKongChallengeConfig.instance:getHiddendTaskInfo(self._stageCfg.hiddenTaskId)
	local matType, matId, num = MaterialMgr.getMatParams(hiddentTaskCfg.taskParams.materials)

	if MaterialModel.instance:IsEnough(matType, matId, num) == true then
		SunWuKongChallengeAgent.instance:sendPM_SunWuKongChallengeDoHiddenTaskReq(self._activityId, self._stageId, "")
	else
		FloatWordMgr.instance:show(lang("所需道具不足"))
	end
end

function SunWuKongChallengeHidenView:_onClickSubmitRole()
	local hiddentTaskCfg = SunWuKongChallengeConfig.instance:getHiddendTaskInfo(self._stageCfg.hiddenTaskId)

	if not hiddentTaskCfg.taskParams then
		if not hiddentTaskCfg.taskParams.pet then
			local petStr = ""
			local temp = string.split(petStr, "&")
			local arr = string.split(temp[1] or "", "$")
			local raceId = checknumber(arr[2])

			local function filterFunc(petMo)
				return petMo.raceId == raceId
			end

			PetSelectController.instance:OpenView(true, lang("精灵选择"), filterFunc, GameUtil.handler(self._submitRole, self))
		end
	end
end

function SunWuKongChallengeHidenView:_onClickFight()
	local fmtMo = SunWuKongChallengeModel.instance:getFmtMo()

	fmtMo:initParams(self._activityId, self._stageId, true)
	CustomFmtController.instance:showMissionView(fmtMo)
	self:close()
end

function SunWuKongChallengeHidenView:_onClickBalloonGame()
	UIStateManager.instance:push(ViewName.SunWuKongChallengeBalloonView, self._activityId, self._stageId)
	self:close()
end

function SunWuKongChallengeHidenView:_onClickFlipGame()
	UIStateManager.instance:push(ViewName.SunWuKongFlipGameMainView, self._activityId, self._stageId)
	self:close()
end

function SunWuKongChallengeHidenView:_onClickDetail()
	local hiddentTaskCfg = SunWuKongChallengeConfig.instance:getHiddendTaskInfo(self._stageCfg.hiddenTaskId)

	UIStateManager.instance:push(ViewName.SunWuKongChallengeRewardView, hiddentTaskCfg.prizePlanId)
end

function SunWuKongChallengeHidenView:_onClickClose()
	SunWuKongChallengeController.instance:setLatestStage(nil)
	self:close()
end

function SunWuKongChallengeHidenView:_submitRole(petId)
	local hiddentTaskCfg = SunWuKongChallengeConfig.instance:getHiddendTaskInfo(self._stageCfg.hiddenTaskId)
	local petMo = BagPetsController.instance:getPet(petId)

	if petMo then
		local isMatch = ConditionValidator.instance:isMatch(hiddentTaskCfg.taskParams.pet, FormationValidatorController._doSingleValidator, petMo)

		if isMatch == true then
			SunWuKongChallengeAgent.instance:sendPM_SunWuKongChallengeDoHiddenTaskReq(self._activityId, self._stageId, langPara("%d", petId))
		else
			FloatWordMgr.instance:show(lang("未满足条件"))
		end
	end
end

function SunWuKongChallengeHidenView:_PM_SunWuKongChallengeDoHiddenTaskRes()
	self:close()
end

return SunWuKongChallengeHidenView
