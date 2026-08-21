-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityLotteryPage.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local ResRandClient = require("ClientData/ResRandClient")
local AchievePanelInPage = require("UI/OpActivity/AchievePanelInPage")
local ActivityLotteryDrawPanel = require("UI/OpActivity/ActivityLotteryDrawPanel")
local ActivityLotteryGetCodeDlg = require("UI/OpActivity/ActivityLotteryGetCodeDlg")
local CodeCell = Class("CodeCell", UIControls.Child)

function CodeCell:ctor()
	self.txtCode = UIControls.Label(self, "TxtNum")
end

function CodeCell:setCode(code)
	self.txtCode:setText(code.key)
end

local ActivityLotteryPage = Class("ActivityLottery", UIControls.Child)

MixinClass(ActivityLotteryPage, ActivityPanelMixin)

function ActivityLotteryPage:ctor()
	self.prizeCell = {}
	self.codeCells = {}
	self.slot4CloseDrawPanel = Slot(self.onDrawPanelClose, self)
end

function ActivityLotteryPage:initUI()
	self.btnTime = UIControls.Button(self, "BtnTime", "TextTime")

	self.btnTime:addEventClick(self.onBtntimeClkick)

	self.prizeListPanel = UIControls.Panel(self, "PrizeListPanel")
	self.openPrizePanel = UIControls.Panel(self, "OpenPrizePanel")
	self.codePanel = UIControls.Panel(self, "CodePanel")
	self.btnCloseCode = UIControls.Button(self, "CodePanel/BtnClose")
	self.txtNothing = UIControls.Panel(self, "CodePanel/TxtNothing")

	self.btnCloseCode:addEventClick(self.onClickCloseCode)
end

function ActivityLotteryPage:_setData()
	self.detailData = self.actObj.actData.clientData

	if self.replaceableCellPath and self.replaceableCellPath[1] then
		self.cellPath = "System/Activity/" .. self.replaceableCellPath[1] .. "/PrizeCodePersonal"
	else
		self.cellPath = "System/Activity/ActivityDoubleEleven/PrizeCodePersonal"
	end
end

function ActivityLotteryPage:_refreshData()
	self.prizeCodeTab = {}
	self.hasDraw = self.actObj.actData.hasDraw

	local codeItems = self.actObj.actData.codeItems

	for i, codeData in ipairs(codeItems) do
		table.insert(self.prizeCodeTab, codeData)
	end

	self.awardInfo = self.actObj.actData.awardInfo
	self.winnerInfo = self.actObj.actData.winners
end

function ActivityLotteryPage:_onShow(isOnPageShow)
	self:_refreshData()

	if isOnPageShow then
		self:refreshBtnTime()
		self:showPrizeListPanel()
		self:refreshAchievePanel()

		if self.hasDraw then
			if #self.prizeCodeTab > 0 and self.awardInfo.has_get and self.awardInfo.has_get ~= 1 then
				CurAvatar:activityRPC(Functor(RPC.opActLotteryGetRank, self.actObj.opId), self.actObj.opId)
			else
				self:showLotteryDrawPanel()
			end
		end
	end
end

function ActivityLotteryPage:refreshBtnTime()
	self.drawTime = self.actObj.actData.drawTime - ClientUtils.getServerTime()

	if self.drawTime <= 0 and self.actObj.curState ~= Const.OPACT_STATE_FREEZE then
		ClientTimerManager.RemoveSecondTickUI(self.btnTime)
		self.btnTime:setText(Lang.get(30619))
	elseif self.hasDraw == false then
		ClientTimerManager.AddSecondFormatTickUI(self.btnTime, self.drawTime, nil, Lang.get(48677), Slot(self.onTimeOver, self))
	else
		ClientTimerManager.RemoveSecondTickUI(self.btnTime)
		self.btnTime:setText(Lang.get(30617))
	end
end

function ActivityLotteryPage:onTimeOver()
	ClientTimerManager.RemoveSecondTickUI(self.btnTime)
	self.btnTime:setText(Lang.get(30619))
end

function ActivityLotteryPage:showPrizeListPanel()
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

			if not self.prizeCell[idx] and (data.award or data.show_award) then
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

				ClientUtils.CreateBonusGrid(self, {}, "PrizeListPanel/Prize" .. idx .. "/GridPanel", data.show_award or data.award, true, nil, true)

				self.prizeCell[idx] = cell
			end
		end
	end
end

function ActivityLotteryPage:refreshAchievePanel()
	if not self.achievePanel then
		local achieveActId = tonumber(self.clientTemplateData.template_args and self.clientTemplateData.template_args[1] or 0)

		if achieveActId then
			local achieveObj = CurAvatar:getActivityObj(achieveActId)

			if achieveObj then
				self.achievePanel = AchievePanelInPage(self, "TaskPanel")

				self.achievePanel:initPanel(achieveActId, self.actObj.actId)
			end
		end
	end

	if self.achievePanel then
		self.achievePanel:refreshData(self.hasDraw)
	end
end

function ActivityLotteryPage:showCodePanel()
	if #self.prizeCodeTab > 0 then
		self.txtNothing:setVisible(false)

		for i, code in ipairs(self.prizeCodeTab) do
			if not self.codeCells[i] then
				self.codeCells[i] = CodeCell(self, "CodePanel/PrizeListPanel", self.cellPath)

				self.codeCells[i]:setCode(code)
			end

			self.codeCells[i]:setVisible(true)
		end
	else
		self.txtNothing:setVisible(true)
	end

	self.codePanel:setVisible(true)
end

function ActivityLotteryPage:showLotteryDrawPanel()
	if not self.lotteryDrawPanel then
		self.lotteryDrawPanel = ActivityLotteryDrawPanel(self, "OpenPrizePanel")
	end

	self.lotteryDrawPanel:setData(self.actObj, self.slot4CloseDrawPanel)
	self.openPrizePanel:setVisible(true)
	self.prizeListPanel:setVisible(false)
	self.codePanel:setVisible(false)
end

function ActivityLotteryPage:onBtntimeClkick()
	if self.hasDraw then
		self:showLotteryDrawPanel()
	else
		self:showCodePanel()
	end
end

function ActivityLotteryPage:onClickCloseCode()
	self.codePanel:setVisible(false)
end

function ActivityLotteryPage:onDrawPanelClose()
	self.openPrizePanel:setVisible(false)
	self.prizeListPanel:setVisible(true)
end

function ActivityLotteryPage:onActivityDataRefresh(actObj)
	self:_onShow(true)
end

function ActivityLotteryPage:_onLeavePage()
	self.codePanel:setVisible(false)
end

return ActivityLotteryPage
