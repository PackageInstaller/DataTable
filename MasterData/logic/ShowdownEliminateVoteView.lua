-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/showdown/view/ShowdownEliminateVoteView.lua

module("logic.extensions.showdown.view.ShowdownEliminateVoteView", package.seeall)

local ShowdownEliminateVoteView = class("ShowdownEliminateVoteView", ViewComponent)

function ShowdownEliminateVoteView:ctor()
	ShowdownEliminateVoteView.super.ctor(self)
end

function ShowdownEliminateVoteView:unbindEvents()
	ShowdownEliminateVoteView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnCancel)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
	GameUtil.addClickHandler(self._btnMin, self._onClickMin, self)
	GameUtil.addClickHandler(self._btnMax, self._onClickMax, self)
	GameUtil.addClickHandler(self._btnAdd, self._onClickAdd, self)
	GameUtil.addClickHandler(self._btnLess, self._onClickLess, self)
end

function ShowdownEliminateVoteView:bindEvents()
	ShowdownEliminateVoteView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnCancel, self.close, self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self._onClickSure, self)
	GameUtil.addClickHandler(self._btnMin, self._onClickMin, self)
	GameUtil.addClickHandler(self._btnMax, self._onClickMax, self)
	GameUtil.addClickHandler(self._btnAdd, self._onClickAdd, self)
	GameUtil.addClickHandler(self._btnLess, self._onClickLess, self)
	self._inputField:AddOnValueChanged(self._onInputValueChange, self)
end

function ShowdownEliminateVoteView:buildUI()
	ShowdownEliminateVoteView.super.buildUI(self)

	self._txtName = self:getTxt("headCol/txtName")
	self._txtPower = self:getTxt("headCol/txtPower")
	self._iconHeat = self:getGo("headCol/txtPower/icon")
	self._head = self:getGo("headCol/head")
	self._inputField = self:getInput("batchBuyRoot/IptItem")
	self._txtLimit = self:getTxt("txtLimit")
	self._icon = self:getGo("txtLimit/icon")
	self._btnSure = self:getGo("btnSure")
	self._btnCancel = self:getGo("btnCancel")
	self._btnClose = self:getGo("btnClose")
	self._btnMin = self:getGo("batchBuyRoot/Marks/btnMin")
	self._btnMax = self:getGo("batchBuyRoot/Marks/btnMax")
	self._btnAdd = self:getGo("batchBuyRoot/Marks/btnAdd")
	self._btnLess = self:getGo("batchBuyRoot/Marks/btnLess")
	self._txtTipEx = self:getGo("txtTipEx")
end

function ShowdownEliminateVoteView:onExit()
	ShowdownEliminateVoteView.super.onExit(self)
	MaterialMgr.resetAll(self._icon)
	uGuiUtil.clearImage(self._iconHeat)
	ShowDownController.instance:clearTeamHeadCellRoot(self._head)
end

function ShowdownEliminateVoteView:onEnter()
	ShowdownEliminateVoteView.super.onEnter(self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._teamMo = params[2]
	self._guessRank = params[3]
	self._needTips = params[4]
	self._curCount = 0
	self._actCfg = ShowDownConfig.instance:getActData(self._activityId)
	self._matType, self._matId, self._matNum = MaterialMgr.getMatParams(self._actCfg.guessItem)

	MaterialMgr.setIcon(self._icon, self._matType, self._matId)

	local heatIconPath = ShowDownConfig.instance:getCommonValue(self._activityId, "heatIconPath")
	local spriteName = string.format("%s.png", heatIconPath)

	uGuiUtil.setSpriteToImage(self._iconHeat, uGuiUtil.SpriteType.BigBg, spriteName)

	local stepId = ShowDownController.instance:getCurStepId(self._activityId)
	local showDownMo = ShowDownController.instance:getShowDownMo(self._activityId)

	self._userGuessItemNum = 0
	self._roundId = ShowDownController.instance:getRoundIdByStep(self._activityId, stepId)

	for i, v in ipairs(showDownMo:getGuessInfoByRound(self._roundId)) do
		self._userGuessItemNum = self._userGuessItemNum + checkint(v.guessValue)
	end

	goutil.setActive(self._txtTipEx, self._roundId == ShowDownEnum.Round_Eliminate_Group)

	local teambaseInfo = self._teamMo:getTeamInfoViewMo()

	self._txtName.text = teambaseInfo:getTeamName()
	self._txtPower.text = self._teamMo:getHeatValue()

	ShowDownController.instance:setTeamHeadCellRoot(self._head, self._teamMo:getLeaderHeadInfo(), self._activityId, teambaseInfo:getTeamLogo())

	self._guessCfg = ShowDownConfig.instance:getGuessData(self._activityId, self._roundId)
	self._curCount = self._guessCfg.minGuessScore

	self._inputField:SetText(self._curCount)
	self.addGEvent(self, GlobalNotify.HandlePM_ShowDown_GuessRes, self._guessSuc, self)
	self.addGEvent(self, GlobalNotify.HandlePM_ShowDown_FinalMatchGuessRes, self._guessSuc, self)
end

function ShowdownEliminateVoteView:refreshView()
	local curShowNum = self._curCount + self._userGuessItemNum

	if curShowNum > self._guessCfg.guessRoundLimit then
		curShowNum = self._guessCfg.guessRoundLimit
	end

	self._txtLimit.text = langPara("%d/%d", curShowNum, self._guessCfg.guessRoundLimit)
end

function ShowdownEliminateVoteView:_onClickSure()
	local limitUp = self._guessCfg.maxGuessScore

	if self._userGuessItemNum + limitUp > self._guessCfg.guessRoundLimit then
		limitUp = self._guessCfg.guessRoundLimit - self._userGuessItemNum
	end

	local limitDown = self._guessCfg.minGuessScore

	if limitUp < limitDown then
		limitUp = 0
		limitDown = 0
	end

	if limitDown <= self._curCount and limitUp >= self._curCount and self._curCount ~= 0 then
		local existCount = MaterialMgr.getMatCount(self._actCfg.guessItem)

		if existCount < self._curCount then
			FloatWordMgr.instance:show(langPara("%s数量不足", MaterialMgr.getMaterialsName(self._matType, self._matId)))

			return
		end

		if self._guessRank and self._guessRank > 0 then
			if self._needTips then
				local rankShow = ""

				if self._guessRank == 1 then
					rankShow = lang("冠军")
				elseif self._guessRank == 2 then
					rankShow = lang("亚军")
				elseif self._guessRank == 3 then
					rankShow = lang("季军")
				end

				local tips = langPara("是否确认应援该战队为%s,同时消耗%s*%s", rankShow, MaterialMgr.getMaterialsName(self._matType, self._matId), self._curCount)

				local function Okfunc()
					ShowDownController.instance:sendPM_ShowDown_FinalMatchGuessReq(self._activityId, self._guessRank, self._teamMo:getTeamId(), self._curCount)
				end

				TipsFacade.instance:openPopupWindowWithX(lang("tip"), tips, Okfunc, function()
					self:close()
				end)
			else
				ShowDownController.instance:sendPM_ShowDown_FinalMatchGuessReq(self._activityId, self._guessRank, self._teamMo:getTeamId(), self._curCount)
			end
		else
			ShowDownController.instance:sendPM_ShowDown_GuessReq(self._activityId, self._teamMo:getTeamId(), self._curCount)
		end
	else
		FloatWordMgr.instance:show(lang("不在可应援范围内"))
	end
end

function ShowdownEliminateVoteView:_onClickMin()
	self._inputField:SetText(self._guessCfg.minGuessScore)
end

function ShowdownEliminateVoteView:_onClickMax()
	self._inputField:SetText((self._guessCfg.guessRoundLimit - self._userGuessItemNum < self._guessCfg.maxGuessScore or nil) and self._guessCfg.guessRoundLimit - self._userGuessItemNum)
end

function ShowdownEliminateVoteView:_onClickAdd()
	if self._curCount + self._guessCfg.minGuessScore <= self._guessCfg.maxGuessScore then
		self._inputField:SetText(self._curCount + self._guessCfg.minGuessScore)
	else
		FloatWordMgr.instance:show(lang("已达最大应援注额"))
	end
end

function ShowdownEliminateVoteView:_onClickLess()
	if self._curCount <= self._guessCfg.minGuessScore then
		FloatWordMgr.instance:show(lang("已达最小应援注额"))
	end

	self._inputField:SetText(self._curCount - self._guessCfg.minGuessScore)
end

function ShowdownEliminateVoteView:_onInputValueChange(value)
	self._curCount = checknumber(value)

	local maxAdd = self._guessCfg.maxGuessScore - self._userGuessItemNum

	if self._userGuessItemNum + maxAdd > self._guessCfg.guessRoundLimit then
		maxAdd = self._guessCfg.guessRoundLimit - self._userGuessItemNum
	end

	if maxAdd < self._curCount and maxAdd > self._guessCfg.minGuessScore then
		self._inputField:SetText(maxAdd)
	elseif self._curCount < self._guessCfg.minGuessScore then
		self._inputField:SetText(self._guessCfg.minGuessScore)
	elseif self._curCount ~= 0 and self._curCount % self._guessCfg.minGuessScore ~= 0 then
		self._inputField:SetText(math.floor(self._curCount / self._guessCfg.minGuessScore) * self._guessCfg.minGuessScore)
	else
		self:refreshView()
	end
end

function ShowdownEliminateVoteView:_guessSuc()
	FloatWordMgr.instance:show(lang("应援成功"))
	self:close()
end

return ShowdownEliminateVoteView
