-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firepowercontest/view/FirePowerContestResultView.lua

module("logic.extensions.firepowercontest.view.FirePowerContestResultView", package.seeall)

local FirePowerContestResultView = class("FirePowerContestResultView", ViewComponent)

function FirePowerContestResultView:ctor()
	FirePowerContestResultView.super.ctor(self)
end

function FirePowerContestResultView:unbindEvents()
	FirePowerContestResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnGo)
	GameUtil.rmClickHandler(self._btnDetail)
	GameUtil.rmClickHandler(self._btnShare)
end

function FirePowerContestResultView:bindEvents()
	FirePowerContestResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
	GameUtil.addClickHandler(self._btnGo, self._onClickGo, self)
	GameUtil.addClickHandler(self._btnDetail, self._onClickDetail, self)
	GameUtil.addClickHandler(self._btnShare, self._onClickShare, self)
end

function FirePowerContestResultView:buildUI()
	FirePowerContestResultView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnDetailGo = self:getGo("btnDetail")
	self._btnDetail = self:getBtn("btnDetail")
	self._btnShareGo = self:getGo("btnShare")
	self._btnShare = self:getBtn("btnShare")
	self._btnGoGo = self:getGo("btnGo")
	self._btnGo = self:getBtn("btnGo")
	self._cell = self:getGo("cell")
	self._content = self:getGo("content")
	self._txtSummary = self:getTxt("txtSummary")
	self._bg = self:getGo("bg")

	goutil.setActive(self._cell, false)

	self._cells = {}
end

function FirePowerContestResultView:_onClickClose()
	self:close()

	if not self._result or self._result.isShare or FirePowerContestController.instance:getIsTourArenaMode() then
		-- block empty
	else
		self:close()
	end
end

function FirePowerContestResultView:_onClickGo()
	self:close()
	UIStateManager.instance:open(ViewName.FirePowerContestMainView)
end

function FirePowerContestResultView:onExit()
	FirePowerContestResultView.super.onExit(self)
	uGuiUtil.clearImage(self._bg)

	for _, cell in ipairs(self._cells) do
		goutil.destroy(cell)
	end

	self._cells = {}
end

function FirePowerContestResultView:onEnter()
	FirePowerContestResultView.super.onEnter(self)

	self._result = self:getFirstParam()

	local activityConf = FirePowerContestConfig.instance:getGameActivityConf()

	if not activityConf then
		self:close()
		FloatWordMgr.instance:show(lang("FirePowerContestMainView__2"))

		return
	end

	local isTourMode = FirePowerContestController.instance:getIsTourArenaMode()

	goutil.setActive(self._btnShareGo, not self._result.isShare and self._result.score ~= 0 and not isTourMode)
	goutil.setActive(self._btnDetailGo, not self._result.isShare and not isTourMode)

	local isOpenMyShare = checknumber(self._result.userId) == checknumber(LoginModel.instance.userId)

	goutil.setActive(self._btnGoGo, (false or nil) and true)
	uGuiUtil.setSpriteToImage(self._bg, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("firepowercontest", activityConf[string.format("bgPath_%d", self._result.iconType)]))

	if isTourMode then
		local gameScore = self._result.score

		self._txtSummary.text = self._result.winState == 1 and langPara("FirePowerContestResultView__1", self._result.winTimes) or lang("FirePowerContestResultView__2")

		if self._result.winState == 1 then
			local winProgress = activityConf.winScore

			self:_addCol("本局局内积分:", langPara("FirePowerContestMainView__5", gameScore))
			self:_addCol(lang("FirePowerContestResultView__4"), langPara("FirePowerContestMainView__5", winProgress))

			gameScore = gameScore + winProgress
		else
			self:_addCol("本局局内积分:", langPara("FirePowerContestMainView__5", gameScore))
		end

		local info = {}

		info.isPass = true
		info.gameScore = gameScore

		FirePowerContestController.instance:callBackFinishTourArena(info)
	else
		local progress = FirePowerContestConfig.instance:getProgressByScore(self._result.score)

		self._txtSummary.text = self._result.winState == 1 and langPara("FirePowerContestResultView__1", self._result.winTimes) or lang("FirePowerContestResultView__2")

		if self._result.winState == 1 then
			local winProgress = activityConf.winScore

			self:_addCol(lang("FirePowerContestResultView__3"), langPara("FirePowerContestMainView__5", progress))
			self:_addCol(lang("FirePowerContestResultView__4"), langPara("FirePowerContestMainView__5", winProgress))
		else
			self:_addCol(lang("FirePowerContestResultView__3"), langPara("FirePowerContestMainView__5", progress))
		end
	end
end

function FirePowerContestResultView:_addCol(strPrefix, value)
	local cell = goutil.cloneAndSetParent(self._cell, self._content.transform)

	table.insert(self._cells, cell)
	goutil.setActive(cell, true)

	local txtPrefix = goutil.findChildTextComponent(cell, "txt")
	local txtValue = goutil.findChildTextComponent(cell, "txtNum")

	txtPrefix.text = strPrefix
	txtValue.text = tostring(value)
end

function FirePowerContestResultView:_onClickDetail()
	if self._result and not self._result.isShare then
		UIStateManager.instance:push(ViewName.FirePowerContestRecordView)
	end
end

function FirePowerContestResultView:_onClickShare()
	if self._result and not self._result.isShare then
		UIStateManager.instance:push(ViewName.Share, GameEnum.ShareType.ShareFirePowerGame, {
			winTimes = self._result.winTimes,
			score = self._result.score,
			winState = self._result.winState,
			iconType = self._result.iconType,
			userName = self._result.userName
		})
	end
end

return FirePowerContestResultView
