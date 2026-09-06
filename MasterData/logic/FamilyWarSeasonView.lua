-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newfamily/view/war/FamilyWarSeasonView.lua

module("logic.extensions.newfamily.view.war.FamilyWarSeasonView", package.seeall)

local FamilyWarSeasonView = class("FamilyWarSeasonView", TableViewComponent)

function FamilyWarSeasonView:ctor()
	FamilyWarSeasonView.super.ctor(self)

	self._requestTimeInfo = nil
	self._curViewDatas = nil
end

function FamilyWarSeasonView:bindEvents()
	FamilyWarSeasonView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
	self._tipsBtn:AddClickListener(function()
		UIStateManager.instance:push(ViewName.RulesView, "familywarseason")
	end, self)
	self._seasonBtn:AddClickListener(function()
		self:_onClickRankBtn(FamilyWarController.SeasonRankType.Season)
	end, self)
	self._warBtn:AddClickListener(function()
		self:_onClickRankBtn(FamilyWarController.SeasonRankType.War)
	end, self)
	self._suppressBtn:AddClickListener(function()
		self:_onClickRankBtn(FamilyWarController.SeasonRankType.Suppress)
	end, self)
	self._awardBtn:AddClickListener(self._onClickAwardBtn, self)
end

function FamilyWarSeasonView:unbindEvents()
	FamilyWarSeasonView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
	self._tipsBtn:RemoveClickListener()
	self._seasonBtn:RemoveClickListener()
	self._warBtn:RemoveClickListener()
	self._suppressBtn:RemoveClickListener()
	self._awardBtn:RemoveClickListener()
end

function FamilyWarSeasonView:onExit()
	FamilyWarSeasonView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdataFamilySeasonRankInfo, self._updataShowBaseInfo, self)
	uGuiUtil.clearImage(self._levleImaGo)

	self._requestTimeInfo = nil
end

function FamilyWarSeasonView:destroyUI()
	FamilyWarSeasonView.super.destroyUI(self)

	self._curViewDatas = nil
end

function FamilyWarSeasonView:buildUI()
	FamilyWarSeasonView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
	self._tipsBtn = self:getBtn("tipsBtn")

	local leftInfoGo = self:getGo("leftInfoGo")

	self._levleImaGo = goutil.findChild(leftInfoGo, "levleIma")
	self._myRankTxt = goutil.findChildTextComponent(leftInfoGo, "myRankGo/myRankTxt")
	self._allScoreTxt = goutil.findChildTextComponent(leftInfoGo, "allScoreGo/allScoreTxt")
	self._wjScoreTxt = goutil.findChildTextComponent(leftInfoGo, "wjScoreGo/wjScoreTxt")
	self._warScoreTxt = goutil.findChildTextComponent(leftInfoGo, "warScoreGo/warScoreTxt")
	self._awardBtn = Framework.ButtonAdapter.GetFrom(leftInfoGo, "awardBtn")

	local rightInfoGo = self:getGo("rightInfoGo")

	self._seasonBtn = Framework.ButtonAdapter.GetFrom(rightInfoGo, "seasonBtn")
	self._warBtn = Framework.ButtonAdapter.GetFrom(rightInfoGo, "warBtn")
	self._suppressBtn = Framework.ButtonAdapter.GetFrom(rightInfoGo, "suppressBtn")
	self._seasonGrp = self._seasonBtn.gameObject:GetComponent("UIChangeGroup")
	self._warGrp = self._warBtn.gameObject:GetComponent("UIChangeGroup")
	self._suppressGrp = self._suppressBtn.gameObject:GetComponent("UIChangeGroup")
	self._emptyGo = goutil.findChild(rightInfoGo, "emptyGo")
	self._timeTxt = goutil.findChildTextComponent(self.mainGO, "timeGo/timeTxt")
end

function FamilyWarSeasonView:onEnter()
	FamilyWarSeasonView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.UpdataFamilySeasonRankInfo, self._updataShowBaseInfo, self)

	self._curCfg = self:getFirstParam()
	self._myRankTxt.text = "我的排行：未上榜"
	self._allScoreTxt.text = "0"
	self._wjScoreTxt.text = "0"
	self._warScoreTxt.text = "0"

	self:_updataViewRankShow(self._curCfg.rankType, {})

	if self._curCfg == nil then
		printError("sr---家族战     FamilyWarSeasonView:onEnter()   没传入参数？？")

		return
	end

	FamilyWarController.instance:csRequestFamilySeasonRankViewRankReq(self._curCfg.rankType, self._curCfg.seasonId)
end

function FamilyWarSeasonView:_updataShowBaseInfo(data)
	if data == nil or data.rankType == nil then
		return
	end

	self._allScoreTxt.text = tostring(data.myFamilyTotalScore)
	self._warScoreTxt.text = tostring(data.myFamilyBattleScore)
	self._wjScoreTxt.text = tostring(data.myFamilyTeamPlayScore)

	GameUtil.SetActive(self._awardBtn, checknumber(self._curCfg.scorePrizePlanId) > 0)

	local list = FamilyWarConfig.instance:getFamilyWarSeasonBadge()
	local icon = "scuffle_icon_jiazu_5"

	for i = 1, #list do
		if list[i] and checknumber(data.myFamilyTotalScore) > checknumber(list[i]) then
			icon = "scuffle_icon_jiazu_" .. i

			break
		end
	end

	uGuiUtil.setSpriteToImage(self._levleImaGo, uGuiUtil.SpriteType.BigBg, string.format("ui/bigbg/familynesttower/%s.png", icon))

	self._myRankTxt.text = checknumber(data.myFamilyRank) <= 0 and "我的排行：未上榜" or "我的排行：" .. data.myFamilyRank

	if data.rankType == self._curCfg.rankType then
		self:_updataViewRankShow(data.rankType, data.rankInfos)
	end
end

function FamilyWarSeasonView:_onClickRankBtn(srType)
	if self._curCfg and srType == self._curCfg.rankType then
		return
	end

	srType = srType or FamilyWarController.SeasonRankType.Season
	self._curCfg = FamilyWarModel.instance:getFamilySeasonByType(srType)

	if self._curCfg == nil then
		GameUtil.SetActive(self._awardBtn, false)

		return
	end

	FamilyWarController.instance:csRequestFamilySeasonRankViewRankReq(srType, self._curCfg.seasonId)
end

function FamilyWarSeasonView:_updataViewRankShow(srType, rankList)
	if srType == FamilyWarController.SeasonRankType.War then
		self._seasonGrp:SetState(0)
		self._warGrp:SetState(1)
		self._suppressGrp:SetState(0)
	elseif srType == FamilyWarController.SeasonRankType.Suppress then
		self._seasonGrp:SetState(0)
		self._warGrp:SetState(0)
		self._suppressGrp:SetState(1)
	else
		self._seasonGrp:SetState(1)
		self._warGrp:SetState(0)
		self._suppressGrp:SetState(0)
	end

	self._curViewDatas = rankList

	if self._curViewDatas == nil or #self._curViewDatas == 0 then
		GameUtil.SetActive(self._emptyGo, true)
	else
		GameUtil.SetActive(self._emptyGo, false)
	end

	self._tableview:ReloadData()

	if self._curCfg == nil or string.nilorempty(self._curCfg.startTime) or string.nilorempty(self._curCfg.endTime) then
		self._timeTxt.text = ""

		return
	end

	local startTime = GameUtil.string2time(self._curCfg.startTime)
	local startDate = GameUtil.time2date(startTime)
	local endTime = GameUtil.string2time(self._curCfg.endTime)
	local endDate = GameUtil.time2date(endTime)

	self._timeTxt.text = string.format("赛季时间：%s.%s.%s %02d - %s.%s.%s %02d", startDate.year, startDate.month, startDate.day, startDate.hour, endDate.year, endDate.month, endDate.day, endDate.hour)
end

function FamilyWarSeasonView:_onClickAwardBtn()
	if self._curCfg == nil or checknumber(self._curCfg.scorePrizePlanId) == 0 then
		return
	end

	UIStateManager.instance:push(ViewName.FamilySeasonAward, self._curCfg.scorePrizePlanId)
end

function FamilyWarSeasonView:_getPath()
	return {
		cellPath = "rightInfoGo/rankCell",
		viewPath = "rightInfoGo/rankListView"
	}
end

function FamilyWarSeasonView:_cellSize()
	return 940, 108
end

function FamilyWarSeasonView:_updateCell(view, cell, data)
	local rankImg = goutil.findChild(cell, "rankIma"):GetComponent("UIImageSpriteChange")
	local rankTxt = goutil.findChildTextComponent(cell, "rankTxt")
	local familyTxt = goutil.findChildTextComponent(cell, "familyTxt")
	local areaTxt = goutil.findChildTextComponent(cell, "areaTxt")
	local chiefTxt = goutil.findChildTextComponent(cell, "chiefTxt")
	local powerTxt = goutil.findChildTextComponent(cell, "powerTxt")

	if data.rank <= 3 then
		GameUtil.SetActive(rankImg, true)
		rankImg:SetState(data.rank - 1)

		rankTxt.text = ""
	else
		GameUtil.SetActive(rankImg, false)

		rankTxt.text = tostring(data.rank)
	end

	familyTxt.text = data.familyName
	areaTxt.text = data.areaName
	chiefTxt.text = data.cheifName
	powerTxt.text = tostring(data.score)
end

return FamilyWarSeasonView
