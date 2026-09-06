-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingdragonchallenge/view/DivineKingDragonChallengeStageTeamView.lua

module("logic.extensions.divinekingdragonchallenge.view.mainGodKingDragonChallengeStageView", package.seeall)

local DivineKingDragonChallengeStageTeamView = class("DivineKingDragonChallengeStageTeamView", ViewComponent)

function DivineKingDragonChallengeStageTeamView:buildUI()
	DivineKingDragonChallengeStageTeamView.super.buildUI(self)

	self._topCol = goutil.findChild(self.mainGO, "topCol")
	self._btnClose = goutil.findChild(self._topCol, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self._topCol, "leftTop/btnTip")
	self._btnRestart = goutil.findChild(self._topCol, "btnRestart")
	self._btnChallenge = goutil.findChild(self._topCol, "btnChallenge")
	self._txtDesc = goutil.findChildTextComponent(self._topCol, "descCol/txtDesc")
	self._blackMask = goutil.findChild(self.mainGO, "blackMask")
	self._stageView = goutil.findChild(self.mainGO, "stageView")

	local stageChildren = GameUtil.getChildren(self._stageView)

	self._stageCellList = {}
	self._stageAnimParms = {}

	for idx, mainGo in ipairs(stageChildren) do
		local cell = {}

		cell.idx = idx
		cell.mainGo = mainGo
		cell.imgBg = goutil.findChild(mainGo, "imgBg")
		cell.imgPass = goutil.findChild(mainGo, "imgPass")
		cell.txtName = goutil.findChildTextComponent(mainGo, "txtName")
		cell.petView = goutil.findChild(mainGo, "petCol/petView")
		cell.effRoot = goutil.findChild(mainGo, "effRoot")
		cell.canvasGroup = mainGo:GetComponent(ComponentType.CanvasGroup)
		cell.canvas = mainGo:GetComponent(ComponentType.Canvas)
		cell.animParm = nil
		cell.info = nil
		self._stageCellList[idx] = cell

		local posX, posY, posZ = Framework.TransformUtil.GetLocalPos(mainGo.transform, 0, 0, 0)
		local scaleX, scaleY, scaleZ = Framework.TransformUtil.GetLocalScale(mainGo.transform, 0, 0, 0)

		self._stageAnimParms[idx] = {
			posX = posX,
			posY = posY,
			scale = scaleX,
			localPos = Vector3.zero
		}
	end

	self._cellCount = #self._stageCellList

	local num = self._cellCount / 2
	local intNum = checkint(num)

	self._medianNum = num - intNum >= 0.5 and intNum + 1 or intNum
	self._sorts = {}
	self._viewSortingOrder = UGUIToolHelper.GetNodeCanvansSortingOrder(self.mainGO)

	for i = 1, self._medianNum do
		self._sorts[i] = self._viewSortingOrder + i - 1
	end

	self._blackMaskSortingOrder = self._sorts[self._medianNum]
	self._sorts[self._medianNum] = self._blackMaskSortingOrder + 1
	self._blackMask:GetComponent("Canvas").sortingOrder = self._blackMaskSortingOrder
	self._drag = Framework.UIDragTrigger.Get(self._stageView)
end

function DivineKingDragonChallengeStageTeamView:bindEvents()
	DivineKingDragonChallengeStageTeamView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickBtnClose, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickBtnChallenge, self)
	GameUtil.addClickHandler(self._btnRestart, self._onClickBtnRestart, self)
	self._drag:AddDragListener(self._onDrag, self)
	self._drag:AddBeginDragListener(self._onBeginDrag, self)
	self._drag:AddEndDragListener(self._onEndDrag, self)
end

function DivineKingDragonChallengeStageTeamView:unbindEvents()
	DivineKingDragonChallengeStageTeamView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnChallenge)
	self._drag:RemoveDragListener()
	self._drag:RemoveBeginDragListener()
	self._drag:RemoveEndDragListener()
end

function DivineKingDragonChallengeStageTeamView:onEnter()
	DivineKingDragonChallengeStageTeamView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])
	self._stageId = checknumber(params[2])

	local isInTime = DivineKingDragonChallengeController.instance:isInActivityTime(self._activityId)

	if not isInTime then
		local text = string.format("活动不在开启期限内( activityId = %d )", self._activityId)

		local function func()
			self:close()
		end

		TipsFacade.instance:openTipWindow("提示", text, func, "确定", UnityEngine.TextAnchor.MiddleCenter)

		return
	end

	self._divineKingDragonMo = DivineKingDragonChallengeController.instance:getDivineKingDragonMo(self._activityId)
	self._stageData = DivineKingDragonChallengeConfig.instance:getDkdStageData(self._activityId, self._stageId)

	self:_onUpdate()
	self.addGEvent(self, GlobalNotify.DivineKingDragonGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.DivineKingDragonResetRes, self._onUpdate, self)
end

function DivineKingDragonChallengeStageTeamView:onExit()
	DivineKingDragonChallengeStageTeamView.super.onExit(self)

	if self._tweenPool then
		for k, v in pairs(self._tweenPool) do
			v:Kill(true)

			self._tweenPool[k] = nil
		end
	end

	if self._selectEff then
		UIEffectManager.instance:stopEffect(self._selectEff)

		self._selectEff = nil
	end

	self:_onClearStageCell()
end

function DivineKingDragonChallengeStageTeamView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()

	local tipsContent = "关卡已通关"

	local function okFunc()
		self:close()
	end

	local alignment = UnityEngine.TextAnchor.MiddleCenter

	if self._divineKingDragonMo:isPassOfStage(self._stageId) then
		TipsFacade.instance:openTipWindowNoX("提示", tipsContent, okFunc, "确定", alignment)
	end
end

function DivineKingDragonChallengeStageTeamView:_onUpdateData()
	return
end

function DivineKingDragonChallengeStageTeamView:_onUpdateUI()
	self._curSwithId = self._divineKingDragonMo:getTeamIdRecord(self._stageId)
	self._curSwithId = Mathf.Clamp(self._curSwithId, 1, self._cellCount)

	if self._divineKingDragonMo:isPassOfTeam(self._stageId, self._curSwithId) then
		for teamId = 1, self._cellCount do
			if not self._divineKingDragonMo:isPassOfTeam(self._stageId, teamId) then
				self._curSwithId = teamId

				break
			end
		end
	end

	for teamId = 1, self._cellCount do
		local cell = self._stageCellList[teamId]
		local data = DivineKingDragonChallengeConfig.instance:getDkdTeamDataByStage(self._activityId, self._stageId, teamId)
		local isPass = self._divineKingDragonMo:isPassOfTeam(self._stageId, teamId)
		local lockPetIds = self._divineKingDragonMo:getLockPetIdsOfTeam(self._stageId, teamId)

		cell.txtName.text = data and data.stageDesc

		cell.imgBg:GetComponent("UIImageSpriteChange"):ChangeSprite(data.bgPath)
		GameUtil.setUIImageSpriteIdx(cell.imgPass, isPass and 0 or 1)

		cell.canvasGroup.alpha = 1

		local curId = teamId - (self._curSwithId - self._medianNum)

		curId = (curId - 1) % self._cellCount + 1

		local animParm = self._stageAnimParms[curId]
		local dis1 = Mathf.Abs(teamId - self._curSwithId)
		local dis2 = Mathf.Abs(self._cellCount - dis1)
		local sortIdx = self._medianNum - Mathf.Min(dis1, dis2)

		cell.canvas.sortingOrder = self._sorts[sortIdx]

		for idx, go in ipairs(GameUtil.getChildren(cell.petView)) do
			local petId = checknumber(lockPetIds[idx])
			local petMo = petId > 0 and self._divineKingDragonMo:getLockPetBagMoOfTeam(petId)
			local icon = goutil.findChild(go, "icon")

			if petMo then
				MaterialMgr.setIcon(icon, MatType.Pet, petMo.curFaceId, nil, nil)
				GameUtil.SetActive(go, true)
			else
				MaterialMgr.resetAll(icon)
				GameUtil.SetActive(go, false)
			end
		end

		GameUtil.setAnchoredPos(cell.mainGo, animParm.posX, animParm.posY)
		GameUtil.setLocalScale(cell.mainGo, animParm.scale, animParm.scale, animParm.scale)

		animParm.localPos = GameUtil.getLocalPos(cell.mainGo)
	end

	self:_updateSwitchUI()
end

function DivineKingDragonChallengeStageTeamView:_onClearStageCell()
	if self._stageCellList == nil then
		return
	end

	for teamId, cell in ipairs(self._stageCellList) do
		for idx, go in ipairs(GameUtil.getChildren(cell.petView)) do
			local icon = goutil.findChild(go, "icon")

			MaterialMgr.resetAll(icon)
		end
	end
end

function DivineKingDragonChallengeStageTeamView:_onDrag(eventData)
	self._disMove = self._disMove + eventData.delta.x

	if self._ableToMove then
		if self._disMove > 120 then
			self:switchNext(1)

			self._ableToMove = false
		elseif self._disMove < -120 then
			self:switchNext(-1)

			self._ableToMove = false
		end
	end
end

function DivineKingDragonChallengeStageTeamView:_onBeginDrag(eventData)
	self._curMoveStep = 0
	self._disMove = 0
	self._needMoveStep = 0
	self._ableToMove = true
end

function DivineKingDragonChallengeStageTeamView:_onEndDrag(eventData)
	self._curMoveStep = 0
	self._disMove = 0
	self._needMoveStep = 0
	self._ableToMove = false
end

function DivineKingDragonChallengeStageTeamView:switchNext(delta)
	local leftestId = 0

	if delta > 0 then
		leftestId = self._curSwithId + (self._cellCount - self._medianNum)
	elseif delta < 0 then
		leftestId = self._curSwithId - (self._cellCount - self._medianNum)
	else
		return
	end

	leftestId = (leftestId - 1) % self._cellCount + 1

	self._stageCellList[leftestId].mainGo.transform:SetAsFirstSibling()

	self._tweenPool = self._tweenPool or {}

	for curId = 1, self._cellCount do
		local curIdx = curId - (self._curSwithId - self._medianNum)
		local nextId = (curIdx - 1 + delta) % self._cellCount + 1
		local cell = self._stageCellList[curId]
		local animParm = self._stageAnimParms[nextId]
		local duration = 0.5
		local tweenMove = cell.mainGo.transform:DOLocalMove(animParm.localPos, duration):SetEase(DG.Tweening.Ease.Linear)
		local newScale = Vector3.New(animParm.scale, animParm.scale, animParm.scale)
		local tweenScale = cell.mainGo.transform:DOScale(newScale, duration):SetEase(DG.Tweening.Ease.Linear)
		local tweenAlpha

		if leftestId == curId then
			local function updateHander(val)
				cell.canvasGroup.alpha = val
			end

			local endHander
			local luaTarget = self
			local easeType = DG.Tweening.Ease.OutQuad

			tweenAlpha = TweenUtil.ValueTo(1, 0.3, duration / 2, updateHander, endHander, luaTarget, easeType)

			tweenAlpha:SetLoops(2, DG.Tweening.LoopType.Yoyo)
		end

		self._tweenPool[tweenMove] = tweenMove
		self._tweenPool[tweenMove] = tweenMove

		if tweenAlpha then
			self._tweenPool[tweenAlpha] = tweenAlpha
		end
	end

	self._curSwithId = (self._curSwithId - 1 - delta) % self._cellCount + 1

	for curId = 1, self._cellCount do
		local dis1 = Mathf.Abs(curId - self._curSwithId)
		local dis2 = Mathf.Abs(self._cellCount - dis1)
		local sortIdx = self._medianNum - Mathf.Min(dis1, dis2)
		local cell = self._stageCellList[curId]

		cell.canvas.sortingOrder = self._sorts[sortIdx]
	end

	self._divineKingDragonMo:setTeamIdRecord(self._stageId, self._curSwithId)
	self:_updateSwitchUI()
end

function DivineKingDragonChallengeStageTeamView:_updateSwitchUI()
	local curTeamId = self._curSwithId
	local teamData = DivineKingDragonChallengeConfig.instance:getDkdTeamDataByStage(self._activityId, self._stageId, curTeamId)
	local isPass = self._divineKingDragonMo:isPassOfTeam(self._stageId, curTeamId)

	GameUtil.SetActive(self._btnChallenge, not isPass)
	GameUtil.SetActive(self._btnRestart, isPass)

	self._txtDesc.text = teamData.tipsDesc

	if self._selectEff then
		self._selectEff:setParent(self._stageCellList[self._curSwithId].effRoot.transform)
		self._selectEff:setScale(1)
		self._selectEff:setLocalPos(0, 0, 0)
	else
		self._selectEff = UIEffectManager.instance:playEffect(self, "20231027/tianzhanshenyaowangzhelong/fx_ui_wzl_select.prefab", nil, 0, 0, true, false, nil, function(target, eff)
			eff:setParent(self._stageCellList[self._curSwithId].effRoot.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1)

			eff.hideEffWhileNotOnTop = true
		end)
	end
end

function DivineKingDragonChallengeStageTeamView:_onClickBtnClose()
	self:close()
end

function DivineKingDragonChallengeStageTeamView:_onClickBtnTip()
	return
end

function DivineKingDragonChallengeStageTeamView:_onClickBtnChallenge()
	local result, tips = self._divineKingDragonMo:getTryFightTeamOfResultAndTips(self._activityId, self._stageId, self._curSwithId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	UIJumper.instance:clear()
	UIJumper.instance:pushOneStack(ViewName.DivineKingDragonChallengeMainView, nil, self._activityId)
	UIJumper.instance:pushOneStack(ViewName.DivineKingDragonChallengeStageView, nil, self._activityId)
	UIJumper.instance:pushOneStack(self._viewPresentor.viewName, nil, self._activityId, self._stageId)
	DivineKingDragonChallengeController.instance:enterBattleOfNorClg(self._activityId, self._stageId, self._curSwithId)
end

function DivineKingDragonChallengeStageTeamView:_onClickBtnRestart()
	local result, tips = self._divineKingDragonMo:getTryRestartTeamOfResultAndTips(self._activityId, self._stageId, self._curSwithId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	local tipsContent = "是否重置本关卡？"

	local function okFunc()
		DivineKingDragonChallengeController.instance:sendPM_DivineKingDragonResetReq(self._activityId, self._stageId, self._curSwithId)
	end

	local function cencelFunc()
		return
	end

	TipsFacade.instance:openPopupWindow("提示", tipsContent, okFunc, cencelFunc, "确定", "取消")
end

return DivineKingDragonChallengeStageTeamView
