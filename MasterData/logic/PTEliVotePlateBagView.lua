-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/peaktournament/view/eliminator/PTEliVotePlateBagView.lua

module("logic.extensions.peaktournament.view.eliminator.PTEliVotePlateBagView", package.seeall)

local PTEliVotePlateBagView = class("PTEliVotePlateBagView", ViewComponent)

function PTEliVotePlateBagView:buildUI()
	PTEliVotePlateBagView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._btnSure = goutil.findChild(self.mainGO, "btnSure")
	self._btnCancel = goutil.findChild(self.mainGO, "btnCancel")
	self._txtLimit = goutil.findChildTextComponent(self.mainGO, "txtLimit")
	self._limitIcon = goutil.findChild(self.mainGO, "txtLimit/icon")
	self._head = goutil.findChild(self.mainGO, "headCol/head")
	self._txtPower = goutil.findChildTextComponent(self.mainGO, "headCol/txtPower")
	self._txtName = goutil.findChildTextComponent(self.mainGO, "headCol/txtName")
	self._inputField = self:getInput("batchBuyRoot/IptItem")
	self._btnLess = goutil.findChild(self.mainGO, "batchBuyRoot/Marks/btnLess")
	self._btnAdd = goutil.findChild(self.mainGO, "batchBuyRoot/Marks/btnAdd")
	self._btnMin = goutil.findChild(self.mainGO, "batchBuyRoot/Marks/btnMin")
	self._btnMax = goutil.findChild(self.mainGO, "batchBuyRoot/Marks/btnMax")
end

function PTEliVotePlateBagView:bindEvents()
	PTEliVotePlateBagView.super.bindEvents(self)
	self._inputField:AddOnValueChanged(self._onValueChanged, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnCancel, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickBtnSure, self)
end

function PTEliVotePlateBagView:unbindEvents()
	PTEliVotePlateBagView.super.unbindEvents(self)
	self._inputField:RemoveOnValueChanged()
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnCancel)
	GameUtil.rmClickHandler(self._btnSure)
end

function PTEliVotePlateBagView:onEnter()
	PTEliVotePlateBagView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId == 0 then
		FloatWordMgr.instance:show("缺失活动id")

		return
	end

	self._eliRoundId = checknumber(params[2])

	if self._eliRoundId == 0 then
		FloatWordMgr.instance:show("缺失轮次id")

		return
	end

	self._resultInfoMo = params[3]
	self._isMe = params[4]
	self._eliminatorMgr = PeakTournamentController.instance:getEliminatorMgr()

	if self._eliminatorMgr == nil then
		printError("缺失[ EliminatorMgr模块 ],无法运行")

		return
	end

	self._votePlateData = PeakTournamentConfig.instance:getPtEliVotePlateDataById(self._activityId, self._eliRoundId)
	self._minNumLimit = self._votePlateData.minVoteScore
	self._maxNumLimit = self._votePlateData.maxVoteScore
	self._scoreDelta = self._votePlateData.voteScoreDelta
	self._myVoteCount = PeakTournamentController.instance:getMyVoteCount()
	self._hasVoteCount = PeakTournamentController.instance:getHasVoteCount()
	self._remainVoteScoreLimit = PeakTournamentController.instance:getRemainVoteScoreLimit(self._activityId, self._eliRoundId)

	self._inputField:SetText(tostring(self._minNumLimit))
	GameUtil.addClickHandler(self._btnLess, self._onClickBtnLess, self)
	GameUtil.addClickHandler(self._btnAdd, self._onClickBtnAdd, self)
	GameUtil.addClickHandler(self._btnMin, self._onClickBtnMin, self)
	GameUtil.addClickHandler(self._btnMax, self._onClickBtnMax, self)
	GlobalDispatcher:addListener(GlobalNotify.PeakTournamentKnockoutGuessRes, self._handleGuessRes, self)
	GlobalDispatcher:addListener(GlobalNotify.EliminatorMgrNotifyChangeNewPeriod, self._handleNotifyChangeNewPeriod, self)

	local headInfo = self._resultInfoMo:getHeadInfo(self._isMe)

	HeadItemController.instance:setHeadCellByInfo(self._head, headInfo)

	self._txtPower.text = self._resultInfoMo:getEverMaxZdl(self._isMe)
	self._txtName.text = self._resultInfoMo:getUserNameAddAreaId(self._isMe)
	self._txtLimit.text = string.format("%s/%s", self._hasVoteCount, self._maxNumLimit)

	local matStr = PeakTournamentConfig.instance:getVoteMate()
	local matType, matId, matNum = MaterialMgr.getMatParams(matStr)

	MaterialMgr.setIcon(self._limitIcon, matType, matId, nil, nil)
end

function PTEliVotePlateBagView:onExit()
	PTEliVotePlateBagView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.PeakTournamentKnockoutGuessRes, self._handleGuessRes, self)
	GlobalDispatcher:removeListener(GlobalNotify.EliminatorMgrNotifyChangeNewPeriod, self._handleNotifyChangeNewPeriod, self)

	self._eliminatorMgr = nil

	GameUtil.rmClickHandler(self._btnLess)
	GameUtil.rmClickHandler(self._btnAdd)
	GameUtil.rmClickHandler(self._btnMin)
	GameUtil.rmClickHandler(self._btnMax)
	MaterialMgr.clearIcon(self._limitIcon)
	HeadItemController.instance:resetHeadCell(self._head)
end

function PTEliVotePlateBagView:_onValueChanged(numStr)
	local num = checkint(numStr)

	num = Mathf.Clamp(num, self._minNumLimit, self._maxNumLimit)
	self._curNum = self:_isFitNum(num) and num or self._curNum or self._minNumLimit

	self._inputField:SetText(tostring(self._curNum))
end

function PTEliVotePlateBagView:_calcValue(delta)
	local num = self._curNum + checkint(delta)

	self:_onValueChanged(num)
end

function PTEliVotePlateBagView:_isFitNum(num)
	local tipsStr = ""

	if num < self._minNumLimit then
		tipsStr = "不能低于最小应援限制"
	elseif num > self._remainVoteScoreLimit then
		tipsStr = "不能超过最大应援限制"
	elseif num > self._myVoteCount then
		tipsStr = "超过所拥有的应援币"
	end

	if not string.nilorempty(tipsStr) then
		FloatWordMgr.instance:show(tipsStr)

		return false
	end

	return true
end

function PTEliVotePlateBagView:_onClickBtnLess()
	self:_calcValue(-self._scoreDelta)
end

function PTEliVotePlateBagView:_onClickBtnAdd()
	self:_calcValue(self._scoreDelta)
end

function PTEliVotePlateBagView:_onClickBtnMin()
	self:_onValueChanged(self._minNumLimit)
end

function PTEliVotePlateBagView:_onClickBtnMax()
	self:_onValueChanged(Mathf.Min(self._myVoteCount, self._remainVoteScoreLimit))
end

function PTEliVotePlateBagView:_onClickBtnSure()
	local newestEliRoundId = self._eliminatorMgr:getNewestEliRoundId()

	if newestEliRoundId ~= self._eliRoundId then
		FloatWordMgr.instance:show("比赛进程已更新，无法领取")
		self:close()

		return
	else
		local curPeriodId = self._eliminatorMgr:getCurPeriodId(self._eliRoundId)

		if curPeriodId < EliminatorMgr.PeriodId.Preparation or curPeriodId > EliminatorMgr.PeriodId.Settlement then
			FloatWordMgr.instance:show("不在可应援阶段")
			self:close()

			return
		end
	end

	if self:_isFitNum(self._curNum) then
		local userId = self._resultInfoMo:getUserId(self._isMe)

		PeakTournamentController.instance:sendPM_PeakTournamentKnockoutGuessReq(self._activityId, userId, self._curNum)
	end
end

function PTEliVotePlateBagView:_handleGuessRes()
	FloatWordMgr.instance:show("应援成功")
	self:close()
end

function PTEliVotePlateBagView:_handleNotifyChangeNewPeriod()
	FloatWordMgr.instance:show("赛程已更新")
	self:close()
end

return PTEliVotePlateBagView
