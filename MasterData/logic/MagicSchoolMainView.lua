-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/magicschool/view/MagicSchoolMainView.lua

module("logic.extensions.magicschool.view.MagicSchoolMainView", package.seeall)

local MagicSchoolMainView = class("MagicSchoolMainView", ViewComponent)
local BAO_DAO_IDX = 1
local BAI_FANG_IDX = 2
local ZHEN_YING_IDX = 3
local JIAN_XI_IDX = 4

function MagicSchoolMainView:ctor()
	MagicSchoolMainView.super.ctor(self)
end

function MagicSchoolMainView:unbindEvents()
	MagicSchoolMainView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnTip)
	GameUtil.rmClickHandler(self._btnHead1)
	GameUtil.rmClickHandler(self._btnHead2)
	GameUtil.rmClickHandler(self._btnHead3)
	GameUtil.rmClickHandler(self._btnHead4)
	GameUtil.rmClickHandler(self._btnStory)
	GameUtil.rmClickHandler(self._btnFakeProgress)
end

function MagicSchoolMainView:bindEvents()
	MagicSchoolMainView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnTip, self._onClickBtnTip, self)
	GameUtil.addClickHandler(self._btnStory, self._onClickBtnStory, self)
	GameUtil.addClickHandler(self._btnFakeProgress, self._onClickBtnFakeProgress, self)
	GameUtil.addClickHandler(self._btnHead1, GameUtil.handler(self._onClickBtnHead, self, 1))
	GameUtil.addClickHandler(self._btnHead2, GameUtil.handler(self._onClickBtnHead, self, 2))
	GameUtil.addClickHandler(self._btnHead3, GameUtil.handler(self._onClickBtnHead, self, 3))
	GameUtil.addClickHandler(self._btnHead4, GameUtil.handler(self._onClickBtnHead, self, 4))
end

function MagicSchoolMainView:buildUI()
	MagicSchoolMainView.super.buildUI(self)

	self._btnClose = self:getGo("leftTop/btnClose")
	self._btnTip = self:getGo("leftTop/btnTip")
	self._txtBubbleDesc = self:getTxt("right/bubble/txtDesc")
	self._btnStory = self:getGo("left/btnStory")
	self._redPointBtnStory = self:getGo("left/btnStory/redPoint")
	self._con = self:getGo("left/con")
	self._btnFakeProgress = self:getGo("right/btnFakeProgress")
	self._fakeProgressRedPoint = self:getGo("right/btnFakeProgressRedPoint")
	self._btnHead1 = self:getGo("left/btnHead1/imgHead")
	self._btnHead2 = self:getGo("left/btnHead2/imgHead")
	self._btnHead3 = self:getGo("left/btnHead3/imgHead")
	self._btnHead4 = self:getGo("left/btnHead4/imgHead")
	self._item = self:getGo("left/reward/item")
	self._eff = self:getGo("left/reward/eff")
	self._geted = self:getGo("left/reward/geted")
	self._txtOpenTime = self:getTxt("txtOpenTime/txt")
	self._cellGoList = {}

	for i = 1, 4 do
		local cell = self:getGo("right/scroll/Viewport/Content/cell" .. i)

		table.insert(self._cellGoList, cell)
	end

	self._btnHeadGoList = {}

	for i = 1, 4 do
		local btnHead = self:getGo("left/btnHead" .. i)

		table.insert(self._btnHeadGoList, btnHead)
	end
end

function MagicSchoolMainView:onExit()
	MagicSchoolMainView.super.onExit(self)

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	self._rotateSequence:Kill(true)

	self._rotateSequence = nil

	MaterialMgr.resetAll(self._item)
	self:stopViewEffectUniGo(self._eff)
	self:_clearRedPoint()
	self:_clearSchoolList()

	for i, btnHeadGo in ipairs(self._btnHeadGoList) do
		local imgHead = goutil.findChild(btnHeadGo, "imgHead")

		MaterialMgr.clearIcon(imgHead)
	end

	RedPointController.instance:unregRedPoint(self._fakeProgressRedPoint)
end

function MagicSchoolMainView:onEnter()
	MagicSchoolMainView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_MagicSchoolGetInfoRes, self._onUpdate, self)
	self.addGEvent(self, ActivitySummaryAgent.PM_ActivitySummaryInviteInfoRes, self._onInviteInfoRes, self)
	self.addGEvent(self, ActivitySummaryAgent.PM_ActivitySummaryAcceptInviteRes, self._onAcceptInviteRes, self)
	self.addGEvent(self, GlobalNotify.GeneralWorldProgressGetInfo, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_MagicSchoolJoinCampRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.PM_MagicSchoolVisitRes, self._onVisitRes, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId <= 0 then
		self._activityId = 514001
	end

	self._actCfg = MagicSchoolConfig.instance:getActCfg(self._activityId)
	self._prizeCfgs = MagicSchoolConfig.instance:getPrizeCfg(self._activityId)
	self._listPrizePreviewCfgs = MagicSchoolConfig.instance:getListPrizePreviewCfgs(self._activityId)
	self._campStageCfgs = MagicSchoolConfig.instance:getStageCfgs(self._activityId)
	self._fakeActivityId = self._actCfg.activityProgressId
	self._summaryId = self._actCfg.activitySummaryId
	self._selectHeadIdx = 1
	self._rotateRate = 0.05
	self._stopRate = 1
	self._rotateLeft = Vector3.New(0, 0, 5)
	self._rotateRight = Vector3.New(0, 0, -5)
	self._tableviewMap = {}
	self._curPrizeCfg = self._prizeCfgs[self._selectHeadIdx]

	self:_onSetUI()
	self:_changeRole()

	if self._txtOpenTime then
		self._txtOpenTime.text = ActivityDefineController.instance:getActTimeShow(self._activityId)
	end

	MagicSchoolController.instance:sendPM_MagicSchoolGetInfoReq(self._activityId)
	GeneralWorldProgressController.instance:getInfo(self._fakeActivityId)
	OpSummaryController.instance:getInvitationInfo(self._summaryId)
	ActivitySummaryAgent.instance:sendPM_ActivitySummaryInviteInfoReq(self._summaryId)
end

function MagicSchoolMainView:_onSetUI()
	self:_initRedPoint()
	self:_initSchoolList()
	self:_initYuanZhangHead()

	if self._rotateSequence then
		self._rotateSequence:Kill(true)

		self._rotateSequence = nil
	end

	self._rotateSequence = DG.Tweening.DOTween.Sequence()

	for i = 1, 6 do
		local rotateLeftTween = self._btnFakeProgress.transform:DORotate(self._rotateLeft, self._rotateRate, DG.Tweening.RotateMode.Fast):SetEase(DG.Tweening.Ease.OutQuad)
		local rotateMiddleTween = self._btnFakeProgress.transform:DORotate(Vector3.zero, self._rotateRate, DG.Tweening.RotateMode.Fast):SetEase(DG.Tweening.Ease.OutQuad)
		local rotateRightTween = self._btnFakeProgress.transform:DORotate(self._rotateRight, self._rotateRate, DG.Tweening.RotateMode.Fast):SetEase(DG.Tweening.Ease.OutQuad)

		self._rotateSequence:Append(rotateLeftTween)
		self._rotateSequence:Append(rotateMiddleTween)
		self._rotateSequence:Append(rotateRightTween)
		self._rotateSequence:Append(rotateMiddleTween)
	end

	local rotateMiddleTween = self._btnFakeProgress.transform:DORotate(Vector3.zero, self._stopRate, DG.Tweening.RotateMode.Fast):SetEase(DG.Tweening.Ease.OutQuad)

	self._rotateSequence:Append(rotateMiddleTween)
	self._rotateSequence:SetLoops(-1)
end

function MagicSchoolMainView:_onUpdate()
	self._info = MagicSchoolModel.instance:getInfo(self._activityId)
	self._curPrizeCfg = self._prizeCfgs[self._selectHeadIdx]

	local hasGainReward = table.indexof(self._info.invitePrizeIds, self._selectHeadIdx)
	local curProgress = GeneralWorldProgressModel.instance:getCurProgress()

	self._txtBubbleDesc.text = string.format("已有%d名奥奇成功加入魔法学院,达成指定数量即可领取奖励!", curProgress)

	MaterialMgr.setCellByCfg(self._curPrizeCfg.prize, self._item)
	GameUtil.SetActive(self._geted, hasGainReward)
	GameUtil.SetActive(self._redPointBtnStory, not hasGainReward)
	self:_updateSchoolLists()
	self:_updateBtnHeads()
end

function MagicSchoolMainView:_changeRole()
	local skinId = self._prizeCfgs[self._selectHeadIdx].raceId

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)
end

function MagicSchoolMainView:_initRedPoint()
	RedPointController.instance:regRedPoint(self._fakeProgressRedPoint, self._actCfg.fakeProgressRedPointId)

	for i, cellGo in ipairs(self._cellGoList) do
		local redPoint = goutil.findChild(cellGo, "btnGoto/redPoint")
		local key = string.format("%s_%d_%d", "MagicSchoolSchoolListRedPoint", self._activityId, i)

		RedPointController.instance:regRedPoint(redPoint, key)
	end
end

function MagicSchoolMainView:_clearRedPoint()
	for i, cellGo in ipairs(self._cellGoList) do
		local redPoint = goutil.findChild(cellGo, "btnGoto/redPoint")

		RedPointController.instance:unregRedPoint(redPoint)
	end
end

function MagicSchoolMainView:_initSchoolList()
	for i, cellGo in ipairs(self._cellGoList) do
		local btnGoto = goutil.findChild(cellGo, "btnGoto")
		local geted = goutil.findChild(cellGo, "geted")
		local txtNum = goutil.findChildTextComponent(cellGo, "txtNum")
		local tablecell = goutil.findChild(cellGo, "tableview/tablecell")
		local tableview = goutil.findChild(cellGo, "tableview")
		local scrollview = ScrollerList.create(tableview, tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
		local curCfg = self._listPrizePreviewCfgs[i]
		local prizeArr = string.split(curCfg.prize, "#")

		self._tableviewMap[cellGo] = scrollview
		txtNum.text = "(0 / 0)"

		scrollview:reloadData(prizeArr)
		GameUtil.addClickHandler(btnGoto, GameUtil.handler(self._onClickBtnGoto, self, i))
	end
end

function MagicSchoolMainView:_initYuanZhangHead()
	for i, btnHeadGo in ipairs(self._btnHeadGoList) do
		local imgHead = goutil.findChild(btnHeadGo, "imgHead")
		local skinId = self._prizeCfgs[i].raceId

		MaterialMgr.setIcon(imgHead, MatType.Pet, skinId, nil, nil)
	end
end

function MagicSchoolMainView:_updateSchoolLists()
	for idx, cellGo in ipairs(self._cellGoList) do
		self:_updateSchoolList(cellGo, idx)
	end
end

function MagicSchoolMainView:_updateSchoolList(cellGo, idx)
	local btnGoto = goutil.findChild(cellGo, "btnGoto")
	local geted = goutil.findChild(cellGo, "geted")
	local txtNum = goutil.findChildTextComponent(cellGo, "txtNum")
	local key = string.format("%s_%d_%d", "MagicSchoolSchoolListRedPoint", self._activityId, idx)

	if idx == BAO_DAO_IDX then
		self._isHasAccept = self._isHasAccept or false

		if self._info.acceptInvite then
			local acceptInvite = self._isHasAccept
			local finishBaoDaoNum = acceptInvite and 1 or 0

			txtNum.text = string.format("(%d / 1)", finishBaoDaoNum)

			GameUtil.SetActive(geted, acceptInvite and self._isHasAccept)
			GameUtil.SetActive(btnGoto, not acceptInvite or not self._isHasAccept)
			RedPointController.instance:setRedPointInfo(key, not acceptInvite or not self._isHasAccept)
		end
	elseif idx == BAI_FANG_IDX then
		local tipGo = goutil.findChild(cellGo, "txtTip")
		local hasVisitNum = #self._info.invitePrizeIds
		local totalVisitNum = #self._prizeCfgs
		local hasFinish = totalVisitNum <= hasVisitNum

		txtNum.text = string.format("(%d / %d)", hasVisitNum, totalVisitNum)

		GameUtil.SetActive(geted, hasFinish)
		GameUtil.SetActive(tipGo, not hasFinish)
	elseif idx == ZHEN_YING_IDX then
		local curCampId = self._info.campId
		local campKey = "MagicSchoolChallengeView" .. self._activityId .. "#" .. curCampId
		local hasSaveCampId = GameUtil.getUserData(campKey)
		local hasFinishCamp = self._info.campId ~= 0 and hasSaveCampId
		local finishCampNum = hasFinishCamp and 1 or 0

		txtNum.text = string.format("(%d / 1)", finishCampNum)

		GameUtil.SetActive(geted, hasFinishCamp and hasSaveCampId)
		GameUtil.SetActive(btnGoto, not hasFinishCamp or not hasSaveCampId)
		RedPointController.instance:setRedPointInfo(key, not hasFinishCamp or not hasSaveCampId)
	elseif idx == JIAN_XI_IDX then
		local curCampId = self._info.campId

		if curCampId <= 0 then
			curCampId = 1
		end

		local totalStageNums = #self._campStageCfgs[curCampId]
		local hasFinishJianXi = totalStageNums <= checknumber(self._info.passedStageId)
		local finishJianXiNum = hasFinishJianXi and 1 or 0

		txtNum.text = string.format("(%d / 1)", finishJianXiNum)

		GameUtil.SetActive(geted, hasFinishJianXi)
		GameUtil.SetActive(btnGoto, not hasFinishJianXi)
		RedPointController.instance:setRedPointInfo(key, not hasFinishJianXi)
	end
end

function MagicSchoolMainView:_clearSchoolList()
	for i, cellGo in ipairs(self._cellGoList) do
		local btnGoto = goutil.findChild(cellGo, "btnGoto")
		local scrollview = self._tableviewMap[cellGo]

		if scrollview then
			scrollview:dispose()
		end

		self._tableviewMap[cellGo] = nil

		GameUtil.rmClickHandler(btnGoto)
	end
end

function MagicSchoolMainView:_updateCell(view, cell, data)
	MaterialMgr.setCellByCfg(data, cell.gameObject)
end

function MagicSchoolMainView:_clearCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function MagicSchoolMainView:_updateBtnHeads()
	for i, btnHeadGo in ipairs(self._btnHeadGoList) do
		local redPoint = goutil.findChild(btnHeadGo, "imgHead/redPoint")
		local imgChoose = goutil.findChild(btnHeadGo, "imgHead/imgChoose")
		local hasGainReward = table.indexof(self._info.invitePrizeIds, i)

		GameUtil.SetActive(redPoint, not hasGainReward)
		GameUtil.SetActive(imgChoose, self._selectHeadIdx == i)
	end
end

function MagicSchoolMainView:_onClickBtnTip()
	local key = self._actCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function MagicSchoolMainView:_onClickBtnHead(idx)
	self._selectHeadIdx = idx

	local petPos = self._prizeCfgs[idx].petPos

	GameUtil.setLocalPos(self._con, petPos[1], petPos[2], 0)
	GameUtil.setLocalScale(self._con, petPos[3], petPos[3], petPos[3])
	self:_changeRole()
	self:_onUpdate()
end

function MagicSchoolMainView:_onClickBtnStory()
	local hasGainReward = table.indexof(self._info.invitePrizeIds, self._selectHeadIdx)

	GlobalDispatcher:dispatch(GlobalNotify.PushStory, self._curPrizeCfg.storyId, StoryModel.StoryType.SCCopy)

	if not hasGainReward then
		MagicSchoolController.instance:sendPM_MagicSchoolVisitReq(self._activityId, self._curPrizeCfg.prizeId)
	end
end

function MagicSchoolMainView:_onClickBtnGoto(idx)
	if idx == BAO_DAO_IDX then
		local magicSchoolKey = string.format(MagicSchoolController.FIRST_ENTER_HUD_KEY, self._activityId)

		GameUtil.saveUserData(magicSchoolKey, true)
		UIStateManager.instance:push(ViewName.InvitationCardView, self._summaryId)
	elseif idx == ZHEN_YING_IDX then
		local hasVisitNum = #self._info.invitePrizeIds
		local totalVisitNum = #self._prizeCfgs
		local hasFinish = totalVisitNum <= hasVisitNum
		local hasAcceptInvite = self._info.isHasAccept

		if not hasAcceptInvite and not self._isHasAccept then
			FloatWordMgr.instance:show("尚未报到")

			return
		end

		if not hasFinish then
			FloatWordMgr.instance:show("尚未拜访完所有院长")

			return
		end

		UIStateManager.instance:push(ViewName.MagicSchoolChooseView, self._activityId, self._info.campId)
	elseif idx == JIAN_XI_IDX then
		local curCampId = self._info.campId
		local campKey = "MagicSchoolChallengeView" .. self._activityId .. "#" .. curCampId
		local hasSaveCampId = GameUtil.getUserData(campKey)
		local hasFinishCamp = self._info.campId ~= 0 and hasSaveCampId

		if not hasFinishCamp then
			FloatWordMgr.instance:show("尚未分配完阵营，请在分配完阵营后进入")

			return
		end

		UIStateManager.instance:push(ViewName.MagicSchoolRenZhengView, self._activityId, self._info.campId)
	end
end

function MagicSchoolMainView:_onVisitRes()
	self:_onUpdate()
end

function MagicSchoolMainView:_onClickBtnFakeProgress()
	local curCampId = self._info.campId
	local campKey = "MagicSchoolChallengeView" .. self._activityId .. "#" .. curCampId
	local hasSaveCampId = GameUtil.getUserData(campKey)
	local hasFinishCamp = self._info.campId ~= 0 and hasSaveCampId

	if not hasFinishCamp then
		FloatWordMgr.instance:show("尚未分配完阵营，请在分配完阵营后进入")

		return
	end

	local activityProgressId = self._actCfg.activityProgressId

	UIStateManager.instance:push(ViewName.MagicSchoolFakeProgressView, activityProgressId)
end

function MagicSchoolMainView:_onInviteInfoRes(status, msg)
	self._isHasAccept = msg.isHasAccept

	self:_onUpdate()
end

function MagicSchoolMainView:_onAcceptInviteRes()
	self._isHasAccept = true

	MagicSchoolController.instance:sendPM_MagicSchoolGetInfoReq(self._activityId)
end

return MagicSchoolMainView
