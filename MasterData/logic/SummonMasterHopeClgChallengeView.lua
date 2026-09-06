-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/summonmasterhopeclg/view/SummonMasterHopeClgChallengeView.lua

module("logic.extensions.summonmasterhopeclg.view.SummonMasterHopeClgChallengeView", package.seeall)

local SummonMasterHopeClgChallengeView = class("SummonMasterHopeClgChallengeView", ViewComponent)

function SummonMasterHopeClgChallengeView:buildUI()
	SummonMasterHopeClgChallengeView.super.buildUI(self)

	self._topCol = goutil.findChild(self.mainGO, "topCol")
	self._btnClose = goutil.findChild(self._topCol, "leftTop/btnClose")
	self._btnTip = goutil.findChild(self._topCol, "leftTop/btnTip")
	self._btnRestart = goutil.findChild(self._topCol, "btnRestart")
	self._btnChallenge = goutil.findChild(self._topCol, "btnChallenge")
	self._imgRestart = self._btnRestart:GetComponent("Image")
	self._txtDesc1 = self:getTxt("topCol/descCol/desireCollege/txtDesc1")
	self._txtDesc2 = self:getTxt("topCol/descCol/txtDesc2")
	self._txtDesc3 = self:getTxt("topCol/descCol/txtDesc3")
	self._blackMask = goutil.findChild(self.mainGO, "blackMask")
	self._stageView = goutil.findChild(self.mainGO, "stageView")

	local stageChildren = GameUtil.getChildren(self._stageView)

	self._stageCellList = {}
	self._stageAnimParms = {}

	for idx, mainGo in ipairs(stageChildren) do
		local cell = {}

		cell.idx = idx
		cell.mainGo = mainGo
		cell.imgPass = goutil.findChild(mainGo, "imgPass")
		cell.imgPass2 = goutil.findChild(mainGo, "imgPass2")
		cell.txtName = goutil.findChildTextComponent(mainGo, "txtName")
		cell.txtDescGo = goutil.findChildTextComponent(mainGo, "Text")
		cell.txtDesc = goutil.findChildTextComponent(mainGo, "Text")
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
			localPos = Vector3.New(posX, posY, posZ)
		}
	end

	self._curSwithId = 1
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

function SummonMasterHopeClgChallengeView:bindEvents()
	SummonMasterHopeClgChallengeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickBtnClose, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnChallenge, self._onClickBtnChallenge, self)
	GameUtil.addClickHandler(self._btnRestart, self._onClickBtnReChallenge, self)
	self._drag:AddDragListener(self._onDrag, self)
	self._drag:AddBeginDragListener(self._onBeginDrag, self)
	self._drag:AddEndDragListener(self._onEndDrag, self)
end

function SummonMasterHopeClgChallengeView:unbindEvents()
	SummonMasterHopeClgChallengeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnChallenge)
	GameUtil.rmClickHandler(self._btnRestart)
	self._drag:RemoveDragListener()
	self._drag:RemoveBeginDragListener()
	self._drag:RemoveEndDragListener()
end

function SummonMasterHopeClgChallengeView:onEnter()
	SummonMasterHopeClgChallengeView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	local isInTime = SummonMasterHopeClgController.instance:isInActivityTime(self._activityId)

	self._stageNum = SummonMasterHopeClgConfig.instance:getStageNum(self._activityId)

	self.addGEvent(self, GlobalNotify.PM_SummonMasterHopeClgGetInfoRes, self._onUpdate, self)
	SummonMasterHopeClgController.instance:sendPM_SummonMasterHopeClgGetInfoReq(self._activityId)
end

function SummonMasterHopeClgChallengeView:onExit()
	SummonMasterHopeClgChallengeView.super.onExit(self)

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

function SummonMasterHopeClgChallengeView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function SummonMasterHopeClgChallengeView:_onUpdateData()
	return
end

function SummonMasterHopeClgChallengeView:_onUpdateUI()
	self._curSwithId = Mathf.Clamp(self._curSwithId, 1, self._stageNum)

	if SummonMasterHopeClgModel.instance:isPass(self._activityId, self._curSwithId) then
		for stageId = 1, self._stageNum do
			if not SummonMasterHopeClgModel.instance:isPass(self._activityId, stageId) then
				self._curSwithId = stageId

				local cellIdx = self:_getCurMiddleCellIndex()

				if self._stageCellList[cellIdx].idx ~= self._medianNum then
					self._curSwithId = self._stageCellList[cellIdx].idx
				end

				break
			end
		end
	end

	for stageId = 1, self._cellCount do
		local cell = self._stageCellList[stageId]
		local curIndexStage = self._curSwithId - (math.ceil(self._cellCount / 2) - cell.idx)
		local stage = (curIndexStage - 1) % self._stageNum + 1
		local data = SummonMasterHopeClgConfig.instance:getSMHClgStageData(self._activityId, stage)
		local isPass = SummonMasterHopeClgModel.instance:isPass(self._activityId, stage)

		cell.txtName.text = data and data.stageId

		local numsArr = SummonMasterHopeClgModel.instance:getTagsNum(self._activityId, stage)

		cell.txtDesc.text = string.format("生命：%s\n力量：%s\n勇气：%s", numsArr[1], numsArr[2], numsArr[3])
		cell.canvasGroup.alpha = 1

		local animParm = self._stageAnimParms[cell.idx]
		local dis1 = Mathf.Abs(cell.idx - self._medianNum)
		local dis2 = Mathf.Abs(self._cellCount - dis1)
		local sortIdx = self._medianNum - Mathf.Min(dis1, dis2)

		cell.canvas.sortingOrder = self._sorts[sortIdx]

		GameUtil.setAnchoredPos(cell.mainGo, animParm.posX, animParm.posY)
		GameUtil.setLocalScale(cell.mainGo, animParm.scale, animParm.scale, animParm.scale)

		cell.canvas.overrideSorting = not (GameUtil.getLocalPos(cell.mainGo).x < -445 or GameUtil.getLocalPos(cell.mainGo).x > 480)

		GameUtil.setUIImageSpriteIdx(cell.imgPass, isPass and 0 or 1)
		GameUtil.setUIImageSpriteIdx(cell.imgPass2, isPass and 0 or 1)
	end

	self:_updateSwitchUI()
end

function SummonMasterHopeClgChallengeView:_updateCellUI(index)
	local cell = self._stageCellList[index]
	local curIndexStage = self._curSwithId - (math.ceil(self._cellCount / 2) - cell.idx)
	local stage = (curIndexStage - 1) % self._stageNum + 1
	local data = SummonMasterHopeClgConfig.instance:getSMHClgStageData(self._activityId, stage)
	local isPass = SummonMasterHopeClgModel.instance:isPass(self._activityId, stage)

	cell.txtName.text = data and data.stageId

	local numsArr = SummonMasterHopeClgModel.instance:getTagsNum(self._activityId, stage)

	cell.txtDesc.text = string.format("生命：%s\n力量：%s\n勇气：%s", numsArr[1], numsArr[2], numsArr[3])
	cell.canvasGroup.alpha = 1
	cell.canvas.overrideSorting = not (GameUtil.getLocalPos(cell.mainGo).x < -445 or GameUtil.getLocalPos(cell.mainGo).x > 480)

	GameUtil.setUIImageSpriteIdx(cell.imgPass, isPass and 0 or 1)
	GameUtil.setUIImageSpriteIdx(cell.imgPass2, isPass and 0 or 1)
end

function SummonMasterHopeClgChallengeView:_onClearStageCell()
	if self._stageCellList == nil then
		return
	end
end

function SummonMasterHopeClgChallengeView:_onDrag(eventData)
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

function SummonMasterHopeClgChallengeView:_onBeginDrag(eventData)
	self._curMoveStep = 0
	self._disMove = 0
	self._needMoveStep = 0
	self._ableToMove = true
end

function SummonMasterHopeClgChallengeView:_onEndDrag(eventData)
	self._curMoveStep = 0
	self._disMove = 0
	self._needMoveStep = 0
	self._ableToMove = false
end

function SummonMasterHopeClgChallengeView:switchNext(delta)
	local leftestId = 0

	if delta > 0 then
		leftestId = self._curSwithId + (self._cellCount - self._medianNum)
	elseif delta < 0 then
		leftestId = self._curSwithId - (self._cellCount - self._medianNum)
	else
		return
	end

	leftestId = (leftestId - 1) % self._cellCount + 1
	self._tweenPool = self._tweenPool or {}
	self._curSwithId = (self._curSwithId - 1 - delta) % self._stageNum + 1

	for curId = 1, self._cellCount do
		local cell = self._stageCellList[curId]

		if delta == 1 then
			if not (cell.idx % self._cellCount + 1) then
				local nextId = (cell.idx + self._medianNum) % self._cellCount + 1
				local animParm = self._stageAnimParms[nextId]
				local duration = 0.5
				local tweenMove = cell.mainGo.transform:DOLocalMove(animParm.localPos, duration):SetEase(DG.Tweening.Ease.Linear):OnStart(function()
					cell.idx = nextId

					local dis1 = Mathf.Abs(cell.idx - self._medianNum)
					local dis2 = Mathf.Abs(self._cellCount - dis1)
					local sortIdx = self._medianNum - Mathf.Min(dis1, dis2)

					cell.canvas.sortingOrder = self._sorts[sortIdx]
					cell.canvas.overrideSorting = not (cell.idx == 1 or cell.idx == self._cellCount)

					self:_updateSwitchUI()
				end):OnComplete(function()
					local dis1 = Mathf.Abs(cell.idx - self._medianNum)
					local dis2 = Mathf.Abs(self._cellCount - dis1)
					local sortIdx = self._medianNum - Mathf.Min(dis1, dis2)

					cell.canvas.sortingOrder = self._sorts[sortIdx]

					self:_updateCellUI(curId)
				end)
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
		end
	end
end

function SummonMasterHopeClgChallengeView:_updateSwitchUI()
	local commonData = SummonMasterHopeClgConfig.instance:getCommonData(self._activityId)
	local middleCellId = self:_getCurMiddleCellIndex()
	local isPass = SummonMasterHopeClgModel.instance:isPass(self._activityId, self._curSwithId)

	GameUtil.SetActive(self._btnChallenge, not isPass)
	GameUtil.SetActive(self._btnRestart, isPass)

	self._imgRestart.color = not SummonMasterHopeClgModel.instance:allStageIsPass(self._activityId) and GameUtil.getColorByHexColor("A5A5A5FF") or GameUtil.getColorByHexColor("FFFFFFFF")

	local numsArr = SummonMasterHopeClgModel.instance:getAllTagsNum(self._activityId)

	self._txtDesc1.text = string.format("<color=#feea67>生命：</color>       <color=#89fe80>%s</color>\n\n<color=#feea67>力量：</color>       <color=#89fe80>%s</color>\n\n<color=#feea67>勇气：</color>       <color=#89fe80>%s</color>", numsArr[1], numsArr[2], numsArr[3])
	self._txtDesc2.text = SummonMasterHopeClgModel.instance:getCurScore(self._activityId) .. ""
	self._txtDesc3.text = commonData.ruleExplain

	if self._selectEff then
		self._selectEff:setParent(self._stageCellList[middleCellId].effRoot.transform)
		self._selectEff:setScale(1)
		self._selectEff:setLocalPos(0, 0, 0)
	else
		self._selectEff = UIEffectManager.instance:playEffect(self, "20231027/tianzhanshenyaowangzhelong/fx_ui_wzl_select.prefab", nil, 0, 0, true, false, nil, function(target, eff)
			eff:setParent(self._stageCellList[middleCellId].effRoot.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1)

			eff.hideEffWhileNotOnTop = true
		end)
	end
end

function SummonMasterHopeClgChallengeView:_onClickBtnClose()
	self:close()
end

function SummonMasterHopeClgChallengeView:_onClickBtnTip()
	local key = SummonMasterHopeClgConfig.instance:getCommonData(self._activityId).ruleKeyMain

	TipsFacade.instance:openRulesView(key)
end

function SummonMasterHopeClgChallengeView:_onClickBtnChallenge()
	UIJumper.instance:clear()
	UIJumper.instance:pushOneStack(ViewName.SummonMasterHopeClgMainView, nil)
	UIJumper.instance:pushOneStack(self._viewPresentor.viewName, nil, self._activityId, self._curSwithId)
	SummonMasterHopeClgController.instance:enterBattleClg(self._activityId, self._curSwithId)
end

function SummonMasterHopeClgChallengeView:_onClickBtnReChallenge()
	if not SummonMasterHopeClgModel.instance:allStageIsPass(self._activityId) then
		FloatWordMgr.instance:show("必须通关所有关卡后可重新挑战此关卡")

		return
	end

	UIJumper.instance:clear()
	UIJumper.instance:pushOneStack(ViewName.SummonMasterHopeClgMainView, nil)
	UIJumper.instance:pushOneStack(self._viewPresentor.viewName, nil, self._activityId, self._curSwithId)
	SummonMasterHopeClgController.instance:enterBattleClg(self._activityId, self._curSwithId)
end

function SummonMasterHopeClgChallengeView:_getCurMiddleCellIndex()
	for i, v in ipairs(self._stageCellList) do
		if v.idx == self._medianNum then
			return i
		end
	end

	return nil
end

return SummonMasterHopeClgChallengeView
