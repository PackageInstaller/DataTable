-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godstatueswar/view/GodStatuesWarSeasonRankTabFrameView.lua

module("logic.extensions.godstatueswar.view.GodStatuesWarSeasonRankTabFrameView", package.seeall)

local GodStatuesWarSeasonRankTabFrameView = class("GodStatuesWarSeasonRankTabFrameView", ViewComponent)
local TabNames_SeasonTotalRank = "赛季积分"
local TabNames_AreaEnergyRank = "战区家族战"

function GodStatuesWarSeasonRankTabFrameView:buildUI()
	GodStatuesWarSeasonRankTabFrameView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._btnTips = goutil.findChild(self.mainGO, "btnTips")
	self._timeGo_txt = goutil.findChildTextComponent(self.mainGO, "timeGo/txt")

	local tabScrView = goutil.findChild(self.mainGO, "tabCol/tabScrView")
	local tabScrCell = goutil.findChild(self.mainGO, "tabCol/tabScrCell")

	self._tabScrollList = ScrollerList.create(tabScrView, tabScrCell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
	self._contentCol = goutil.findChild(self.mainGO, "contentCol")
	self._levleIma = goutil.findChild(self.mainGO, "infoCol/levleIma")
	self._myRank_txt = goutil.findChildTextComponent(self.mainGO, "infoCol/myRank/txt")
	self._myFamilyTotalScore_txt = goutil.findChildTextComponent(self.mainGO, "infoCol/myFamilyTotalScore/txt")
	self._myFamilyBossScore_txt = goutil.findChildTextComponent(self.mainGO, "infoCol/myFamilyBossScore/txt")
	self._myFamilyWarSpaceScore_txt = goutil.findChildTextComponent(self.mainGO, "infoCol/myFamilyWarSpaceScore/txt")
	self._myFamilyWarZoneScore_txt = goutil.findChildTextComponent(self.mainGO, "infoCol/myFamilyWarZoneScore/txt")
	self._btnPrize = goutil.findChild(self.mainGO, "infoCol/btnPrize")
	self._btnAreaRank = goutil.findChild(self.mainGO, "infoCol/btnAreaRank")
end

function GodStatuesWarSeasonRankTabFrameView:bindEvents()
	GodStatuesWarSeasonRankTabFrameView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnPrize, self._onClickBtnPrize, self)
	GameUtil.addClickHandler(self._btnAreaRank, self._onClickBtnAreaRank, self)
	GameUtil.addClickHandler(self._btnTips, self._onClickBtnTips, self)
end

function GodStatuesWarSeasonRankTabFrameView:unbindEvents()
	GodStatuesWarSeasonRankTabFrameView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnPrize)
	GameUtil.rmClickHandler(self._btnAreaRank)
	GameUtil.rmClickHandler(self._btnTips)
end

function GodStatuesWarSeasonRankTabFrameView:onEnter()
	GodStatuesWarSeasonRankTabFrameView.super.onEnter(self)

	self._seasonId = FamilyWarController.instance:getSeasonIdOfNfsRank()

	local isInTime = FamilyWarController.instance:isInSeasonTimeOfNfsRank(self._seasonId)

	if not isInTime then
		printError(string.format("不在开启期限内( seasonId = %d | export_赛季配置 | j家族赛季榜(新) )", self._seasonId))
		self:close()

		return
	end

	self._seasonData = FamilySeasonRankConfig.instance:getNfsSeasonData(self._seasonId)

	self:_onUpdate()
	self.addGEvent(self, GlobalNotify.handlePM_FamilySeasonRankViewNewRankRes, self._onUpdate, self)
	self.addGEvent(self, GlobalNotify.handlePM_NewFamilyBattleGetRegistrationRes, self._onUpdateUI, self)

	local stepInCur = GodStatuesWarController.instance:getCurStepOfGsw(self._seasonId)
	local stepIntervalInCur = GodStatuesWarController.instance:getStepInterval(self._seasonId, stepInCur)

	if stepIntervalInCur >= GswEnum.StepInterval_Bat then
		GodStatuesWarController.instance:sendPM_NewFamilyBattleGetRegistrationReq()
	end
end

function GodStatuesWarSeasonRankTabFrameView:onExit()
	GodStatuesWarSeasonRankTabFrameView.super.onExit(self)
	self._tabScrollList:dispose()
	uGuiUtil.clearImage(self._levleIma)
	self:_onClearTabAt()
end

function GodStatuesWarSeasonRankTabFrameView:_onUpdate()
	self:_onUpdateData()
	self:_onUpdateUI()
end

function GodStatuesWarSeasonRankTabFrameView:_onUpdateData()
	self:_updateTabData()
end

function GodStatuesWarSeasonRankTabFrameView:_onUpdateUI()
	local tabData = self._tabDataList[self._curTabIdx]

	if tabData then
		if not tabData.tabName then
			local tabName = ""

			GameUtil.SetActive(self._btnPrize, tabName == TabNames_SeasonTotalRank)

			local result, tips = GodStatuesWarController.instance:getTryOpenAreaEnergyRankResultAndTips(self._seasonId)

			GameUtil.SetActive(self._btnAreaRank, tabName == TabNames_AreaEnergyRank)
			GameUtil.SetGray(self._btnAreaRank, result ~= GameEnum.ResultCode.Success)
			self:_onUpdateInfoColUI()
			self:_updateTabScrollerList()
			self:_showTabAt()
		end
	end
end

function GodStatuesWarSeasonRankTabFrameView:_onUpdateInfoColUI()
	local msg = FamilySeasonRankModel.instance:getNfsNewMsg()
	local myFamilyRank = checknumber(msg and msg.myFamilyRank)
	local myFamilyTotalScore = checknumber(msg and msg.myFamilyTotalScore)
	local myFamilyBattleSpaceScore = checknumber(msg and msg.myFamilyBattleSpaceScore)
	local myFamilyBattleZoneScore = checknumber(msg and msg.myFamilyBattleZoneScore)
	local myFamilyHounding = checknumber(msg and msg.myFamilyHounding)
	local iconName = "scuffle_icon_jiazu_5"
	local badgeStates = self._seasonData.badgeStates

	if badgeStates then
		for i, v in ipairs(badgeStates) do
			if v < myFamilyTotalScore then
				iconName = "scuffle_icon_jiazu_" .. i

				break
			end
		end
	end

	uGuiUtil.setSpriteToImage(self._levleIma, uGuiUtil.SpriteType.BigBg, string.format("ui/bigbg/familynesttower/%s.png", iconName))

	self._myRank_txt.text = myFamilyRank <= 0 and "我的排行：未上榜" or string.format("我的排行：%s", myFamilyRank)
	self._myFamilyTotalScore_txt.text = myFamilyTotalScore
	self._myFamilyWarSpaceScore_txt.text = myFamilyBattleSpaceScore
	self._myFamilyWarZoneScore_txt.text = myFamilyBattleZoneScore
	self._myFamilyBossScore_txt.text = myFamilyHounding

	local startStamp, endStamp = GameUtil.string2time(self._seasonData.startTime), GameUtil.string2time(self._seasonData.endTime)

	self._timeGo_txt.text = "赛季时间：" .. GameUtil.getFormatTimeByStamp(startStamp, endStamp)
end

function GodStatuesWarSeasonRankTabFrameView:_updateTabData()
	self._tabDataList = {}

	if self._tabDataList then
		local data = {}

		data.viewName = ViewName.GodStatuesWarSeasonTotalRankTabChildView
		data.tabName = TabNames_SeasonTotalRank
		data.viewParams = {
			self._seasonId,
			FamilySeasonRankEnum.RankType_Total
		}

		table.insert(self._tabDataList, data)
	end

	if self._tabDataList then
		local data = {}

		data.viewName = ViewName.GodStatuesWarSeasonTotalRankTabChildView
		data.tabName = TabNames_AreaEnergyRank
		data.viewParams = {
			self._seasonId,
			FamilySeasonRankEnum.StepType_GodStatuesWarZone
		}

		table.insert(self._tabDataList, data)
	end

	if self._tabDataList then
		local data = {}

		data.viewName = ViewName.GodStatuesWarSeasonTotalRankTabChildView
		data.tabName = "全服家族战"
		data.viewParams = {
			self._seasonId,
			FamilySeasonRankEnum.StepType_GodStatuesWarSpace
		}

		table.insert(self._tabDataList, data)
	end

	if self._tabDataList then
		local data = {}

		data.viewName = ViewName.GodStatuesWarSeasonTotalRankTabChildView
		data.tabName = "家族围剿"
		data.viewParams = nil
		data.viewParams = {
			self._seasonId,
			FamilySeasonRankEnum.RankType_FamilyHoudingClg
		}

		table.insert(self._tabDataList, data)
	end

	self._curTabIdx = self._curTabIdx or 1
	self._curTabIdx = Mathf.Min(self._curTabIdx, #self._tabDataList)
end

function GodStatuesWarSeasonRankTabFrameView:_updateTabScrollerList()
	self._tabScrollList:reloadData(self._tabDataList)
end

function GodStatuesWarSeasonRankTabFrameView:_updateTabCell(view, cell, data, tag)
	local tabIdx = cell.index + 1
	local mainGo = cell.gameObject
	local txtName = goutil.findChildTextComponent(mainGo, "txtName")

	txtName.text = data.tabName

	GameUtil.setUIGroupIdx(mainGo, self._curTabIdx == tabIdx and 1 or 0)
	GameUtil.addClickHandler(mainGo, GameUtil.handler(self._onClickTab, self, data, tabIdx))
end

function GodStatuesWarSeasonRankTabFrameView:_clearTabCell(cell)
	local mainGo = cell.gameObject

	GameUtil.rmClickHandler(mainGo)
end

function GodStatuesWarSeasonRankTabFrameView:_onClickTab(data, idx)
	self._curTabIdx = idx

	self:_onUpdateUI()
end

function GodStatuesWarSeasonRankTabFrameView:_showTabAt()
	local data = self._tabDataList[self._curTabIdx]

	if data == nil then
		return
	end

	if self._oldTabIdx and self._oldTabIdx == self._curTabIdx then
		return
	end

	self:_onClearTabAt()

	self._oldTabIdx = self._curTabIdx

	if data.viewParams then
		self:showTabAt(self._contentCol, data.viewName, unpack(data.viewParams))
	else
		self:showTabAt(self._contentCol, data.viewName)
	end
end

function GodStatuesWarSeasonRankTabFrameView:_onClearTabAt()
	self:showTabAt(self._contentCol, "")

	self._oldTabIdx = nil
end

function GodStatuesWarSeasonRankTabFrameView:_onClickBtnPrize()
	UIStateManager.instance:push(ViewName.GodStatuesWarSeasonPrizeWinTabFrameView, self._seasonId)
end

function GodStatuesWarSeasonRankTabFrameView:_onClickBtnAreaRank()
	local result, tips = GodStatuesWarController.instance:getTryOpenAreaEnergyRankResultAndTips(self._seasonId)

	FloatWordMgr.instance:show(tips)

	if result ~= GameEnum.ResultCode.Success then
		return
	end

	UIStateManager.instance:push(ViewName.GodStatuesWarAreaEnergyRankView, self._seasonId)
end

function GodStatuesWarSeasonRankTabFrameView:_onClickBtnTips()
	self._seasonData = FamilySeasonRankConfig.instance:getNfsSeasonData(self._seasonId)

	TipsFacade.instance:openRulesView(self._seasonData.ruleKey)
end

function GodStatuesWarSeasonRankTabFrameView:_isAreaEnergyRankOpen()
	local stepInCur = GodStatuesWarController.instance:getCurStepOfGsw(self._seasonId)
	local stepIntervalInCur = GodStatuesWarController.instance:getStepInterval(self._seasonId, stepInCur)

	return stepIntervalInCur >= GswEnum.StepInterval_Bat
end

return GodStatuesWarSeasonRankTabFrameView
