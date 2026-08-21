-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityMultiRoundLotteryPage.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local AchievePanelInPage = require("UI/OpActivity/AchievePanelInPage")
local ActivityLotteryDrawPanel = require("UI/OpActivity/ActivityLotteryDrawPanel")
local CodeChild = Class("CodeChild", UIControls.Child)

function CodeChild:ctor()
	self.txtCode = UIControls.Label(self, "TxtNum")
end

function CodeChild:setCode(code)
	self.txtCode:setText(code.key)
end

local DailyTab = Class("DailyTab", UIControls.Child)

function DailyTab:ctor()
	self.btnSelf = UIControls.Button(self, "")

	self.btnSelf:addEventClick(self.onDailyTabClick)

	self.btnFinish = UIControls.Panel(self, "BtnFinish")
	self.btnTime = UIControls.Panel(self, "BtnTime")
	self.btnDraw = UIControls.Panel(self, "BtnDraw")
	self.selectImg = UIControls.Image(self, "SelectImg")
end

function DailyTab:setData(actId, index)
	self.actId = actId
	self.actObj = CurAvatar:getActivityObj(self.actId)

	if self.actObj then
		self.hasDraw = self.actObj.actData.hasDraw

		if self.actObj.curState == Const.OPACT_STATE_FREEZE then
			self.btnTime:setVisible(false)
			self.btnFinish:setVisible(true)
			self.btnDraw:setVisible(false)

			self.textRound = UIControls.Label(self, "BtnFinish/TextRound")
		elseif self.actObj.curState == Const.OPACT_STATE_PREOPEN then
			self.btnTime:setVisible(true)
			self.btnFinish:setVisible(false)
			self.btnDraw:setVisible(false)

			self.textRound = UIControls.Label(self, "BtnTime/TextRound")
			self.textTime = UIControls.Label(self, "BtnTime/TextTime")
			self.drawTime = self.actObj.actData.drawTime - ClientUtils.getServerTime()
			self.openTime = self.actObj.actData.openTime - ClientUtils.getServerTime()

			ClientTimerManager.AddSecondFormatTickUI(self.textTime, self.openTime, nil, Lang.get(45383), nil, nil, 1)
		else
			self.btnTime:setVisible(false)
			self.btnFinish:setVisible(false)
			self.btnDraw:setVisible(true)

			self.textRound = UIControls.Label(self, "BtnDraw/TextRound")
		end

		self.textRound:setText(string.format(Lang.get(30600), index))
	end
end

function DailyTab:onDailyTabClick()
	self.mParent.curActObj = self.actObj

	self.mParent:refreshLotteryPanel()
	self.btnSelf:setEnable(false)
	self.selectImg:setVisible(true)

	for i, tab in pairs(self.mParent.tabCells) do
		if tab.actId ~= self.actId then
			tab.btnSelf:setEnable(true)
			tab.selectImg:setVisible(false)
		end
	end
end

local ActivityRoundLotteryPanel = Class("ActivityRoundLotteryPanel", UIControls.Child)

function ActivityRoundLotteryPanel:ctor()
	self.prizeCell = {}
	self.itemGrids = {}
	self.codeCells = {}
	self.btnTime = UIControls.Button(self, "BtnTime", "TextTime")

	self.btnTime:addEventClick(self.onBtntimeClkick)

	self.prizeListPanel = UIControls.Panel(self, "PrizeListPanel")
	self.openPrizePanel = UIControls.Panel(self, "OpenPrizePanel")
	self.codePanel = UIControls.Panel(self, "CodePanel")
	self.btnCloseCode = UIControls.Button(self, "CodePanel/BtnClose")
	self.txtNothing = UIControls.Panel(self, "CodePanel/TxtNothing")

	self.btnCloseCode:addEventClick(self.onClickCloseCode)

	self.lockPanel = UIControls.Panel(self, "LockPanel")
	self.taskPanel = UIControls.Panel(self, "TaskPanel")
end

function ActivityRoundLotteryPanel:setData()
	self.actObj = self.mParent.curActObj
	self.mainActObj = self.mParent.actObj
	self.replaceableCellPath = self.mParent.replaceableCellPath

	if self.mParent.srcPath then
		self.cellPath = "System/Activity/" .. self.mParent.srcPath .. "/PrizeCodePersonal"
	else
		self.cellPath = "System/Activity/ActivityAnniversaryDraw/PrizeCodePersonal"
	end

	self.prizeCodeTab = {}
	self.hasDraw = self.actObj.actData.hasDraw

	local codeItems = self.actObj.actData.codeItems

	for i, codeData in ipairs(codeItems) do
		table.insert(self.prizeCodeTab, codeData)
	end

	self.awardInfo = self.actObj.actData.awardInfo
	self.winnerInfo = self.actObj.actData.winners

	self:refreshBtnTime()
	self:showPrizeListPanel()
	self:refreshAchievePanel()

	if self.hasDraw then
		if #self.prizeCodeTab > 0 and self.awardInfo.has_get and self.awardInfo.has_get ~= 1 then
			CurAvatar:activityRPC(Functor(RPC.opActLotteryGetRank, self.actObj.opId), self.actObj.opId)
		else
			self:showLotteryDrawPanel()
		end
	else
		self.openPrizePanel:setVisible(false)
		self.prizeListPanel:setVisible(true)
		self.codePanel:setVisible(false)
	end
end

function ActivityRoundLotteryPanel:refreshBtnTime()
	self.drawTime = self.actObj.actData.drawTime - ClientUtils.getServerTime()

	if self.drawTime <= 0 and self.actObj.curState ~= Const.OPACT_STATE_FREEZE then
		ClientTimerManager.RemoveSecondTickUI(self.btnTime)
		self.btnTime:setText(Lang.get(30619))
	elseif self.hasDraw == false then
		ClientTimerManager.AddSecondFormatTickUI(self.btnTime, self.drawTime, nil, Lang.get(48677), Slot(self.onTimeOver, self))
		self.btnTime:setVisible(self.actObj.curState ~= Const.OPACT_STATE_PREOPEN)
	else
		ClientTimerManager.RemoveSecondTickUI(self.btnTime)
		self.btnTime:setText(Lang.get(30617))
		self.btnTime:setVisible(false)
	end
end

function ActivityRoundLotteryPanel:onTimeOver()
	ClientTimerManager.RemoveSecondTickUI(self.btnTime)
	self.btnTime:setText(Lang.get(30619))
end

function ActivityRoundLotteryPanel:showPrizeListPanel()
	self.detailData = self.actObj.actData.clientData

	local preData
	local idx = 0

	for _, data in ipairs(self.detailData) do
		if data.limit_max then
			local nowNum = data.limit_max - data.limit_min + 1

			if preData and preData.rank_desc == data.rank_desc then
				preData.prizeNum = (preData.prizeNum or 0) + nowNum
			else
				data.prizeNum = nowNum
				preData = data
			end
		else
			preData = data
		end
	end

	preData = nil

	for _, data in ipairs(self.detailData) do
		if not preData or preData.rank_desc ~= data.rank_desc then
			preData = data
			idx = idx + 1

			local cell = UIControls.Panel(self, "PrizeListPanel/Prize" .. idx)
			local txtPrize = UIControls.Label(self, "PrizeListPanel/Prize" .. idx .. "/TxtPrize")
			local txtNum = UIControls.Label(self, "PrizeListPanel/Prize" .. idx .. "/TxtNum")

			txtPrize:setText(data.rank_desc)

			if data.prizeNum then
				txtNum:setText(string.format(Lang.get(30618), data.prizeNum))
				txtNum:setVisible(true)
			else
				txtNum:setVisible(false)
			end

			if data.award or data.show_award then
				self.itemGrids[idx] = self.itemGrids[idx] or {}

				for i = #self.itemGrids[idx], 1, -1 do
					self.itemGrids[idx][i]:destroy()

					self.itemGrids[idx][i] = nil
				end

				ClientUtils.CreateBonusGrid(self, self.itemGrids[idx], "PrizeListPanel/Prize" .. idx .. "/GridPanel", data.show_award or data.award, true, nil, true)
			end

			self.prizeCell[idx] = cell
		end
	end
end

function ActivityRoundLotteryPanel:refreshAchievePanel()
	local achieveActId = self.mParent.achieveActId

	if achieveActId then
		local achieveObj = CurAvatar:getActivityObj(achieveActId)

		if achieveObj then
			if self.achievePanel == nil then
				self.achievePanel = AchievePanelInPage(self, "TaskPanel")
			end

			self.achievePanel:initPanel(achieveActId, self.actObj.actId)
		end
	end

	if self.achievePanel then
		self.achievePanel:refreshData(self.hasDraw)
	end

	self.lockPanel:setVisible(self.actObj.curState == Const.OPACT_STATE_PREOPEN)
	self.taskPanel:setVisible(self.actObj.curState ~= Const.OPACT_STATE_PREOPEN and not self.hasDraw)
end

function ActivityRoundLotteryPanel:showCodePanel()
	self.prizeCodeTab = {}

	local codeItems = self.actObj.actData.codeItems

	for i, codeData in ipairs(codeItems) do
		table.insert(self.prizeCodeTab, codeData)
	end

	if #self.prizeCodeTab > 0 then
		self.txtNothing:setVisible(false)

		for i, code in ipairs(self.prizeCodeTab) do
			if not self.codeCells[i] then
				self.codeCells[i] = CodeChild(self, "CodePanel/PrizeListPanel/Content", self.cellPath)

				self.codeCells[i]:setCode(code)
			end

			self.codeCells[i]:setVisible(true)
		end
	else
		self.txtNothing:setVisible(true)
	end

	self.codePanel:setVisible(true)
end

function ActivityRoundLotteryPanel:showLotteryDrawPanel()
	if not self.lotteryDrawPanel then
		self.lotteryDrawPanel = ActivityLotteryDrawPanel(self, "OpenPrizePanel")
	end

	self.lotteryDrawPanel:setData(self.actObj, nil, self.mainActObj)
	self.openPrizePanel:setVisible(true)
	self.prizeListPanel:setVisible(false)
	self.codePanel:setVisible(false)
end

function ActivityRoundLotteryPanel:onBtntimeClkick()
	if self.hasDraw then
		self:showLotteryDrawPanel()
	else
		self:showCodePanel()
	end
end

function ActivityRoundLotteryPanel:onClickCloseCode()
	self.codePanel:setVisible(false)
end

local ActivityMultiRoundLotteryPage = Class("ActivityMultiRoundLotteryPage", UIControls.Child)

MixinClass(ActivityMultiRoundLotteryPage, ActivityPanelMixin)

function ActivityMultiRoundLotteryPage:ctor()
	self.tabCells = {}
end

function ActivityMultiRoundLotteryPage:initUI()
	if self.replaceableCellPath and self.replaceableCellPath[1] then
		self.srcPath = self.replaceableCellPath[1]
	else
		self.srcPath = "ActivityAnniversaryDraw"
	end

	if self.roundLotteryPanel == nil then
		self.roundLotteryPanel = ActivityRoundLotteryPanel(self, "MainInfoPanel", "System/Activity/" .. self.srcPath .. "/ActivityAnniversaryDailyPanel", 0, 0, true)
	end
end

function ActivityMultiRoundLotteryPage:_setData()
	self.roundActIds = {
		self.actObj.actId
	}
	self.curActObj = self.actObj
	self.achieveActId = tonumber(self.actObj.clientTemplateData.template_args and self.actObj.clientTemplateData.template_args[1] or 0)

	CurAvatar:addActivityRelated(self.achieveActId, "activityMainDlg", self.actObj.actId)

	for i, actId in ipairs(self.actObj.templateData.relate_act) do
		local actObj = CurAvatar:getActivityObj(actId)

		if actObj and actObj.curState == Const.OPACT_STATE_OPEN then
			self.curActObj = actObj
		end

		table.insert(self.roundActIds, actId)
	end

	for i, actId in ipairs(self.roundActIds) do
		local tabCell = self.tabCells[i]

		if tabCell == nil then
			tabCell = DailyTab(self, "TabPanel/Content", "System/Activity/" .. self.srcPath .. "/DailyTab", 0, 0, true)
		end

		tabCell:setData(actId, i)
		tabCell.btnSelf:setEnable(self.curActObj.actId ~= actId)
		tabCell.selectImg:setVisible(self.curActObj.actId == actId)

		self.tabCells[i] = tabCell
	end

	self:refreshLotteryPanel()
end

function ActivityMultiRoundLotteryPage:refreshLotteryPanel()
	self.roundLotteryPanel:setData()
end

function ActivityMultiRoundLotteryPage:onActivityDataRefresh(actObj)
	self:refreshLotteryPanel()
end

function ActivityMultiRoundLotteryPage:_onLeavePage()
	self.roundLotteryPanel.codePanel:setVisible(false)
end

return ActivityMultiRoundLotteryPage
