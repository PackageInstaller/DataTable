-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityNmlSigninPage.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local ResRandClient = require("ClientData/ResRandClient")
local FlyIconUtils = require("UI/Common/FlyIconUtils")
local ResOpActivityAchieveMisc = require("ClientData/ResOpActivityAchieveMisc")
local ResOpActivityClientTemplate = require("ClientData/ResOpActivityClientTemplate")
local ResOpActivityTemplate = require("ClientData/ResOpActivityTemplate")
local ResClientNotice = require("ClientData/ResClientNotice")
local ItemAward = Class("ItemAward", UIControls.Panel)

function ItemAward:ctor()
	self.imgNothing = UIControls.Image(self, self.mPath .. "/ImgNothing")
	self.panelAward = UIControls.Panel(self, self.mPath .. "/BtnAwardDaily")
	self.imgIcon = UIControls.Image(self, self.mPath .. "/BtnAwardDaily/Icon")
	self.panelBadge = UIControls.Panel(self, self.mPath .. "/BtnAwardDaily/IconBadge")
	self.imgBadgeBG = UIControls.Image(self, self.mPath .. "/BtnAwardDaily/IconBadge/Bg")
	self.imgBadgeIcon = UIControls.Image(self, self.mPath .. "/BtnAwardDaily/IconBadge/Icon")
	self.imgIcon = UIControls.Image(self, self.mPath .. "/BtnAwardDaily/Icon")
	self.imgIcon = UIControls.Image(self, self.mPath .. "/BtnAwardDaily/Icon")
	self.imgIcon = UIControls.Image(self, self.mPath .. "/BtnAwardDaily/Icon")
	self.isNothing = false
end

function ItemAward:setNothing()
	self.imgNothing:setVisible(true)

	self.isNothing = true
end

function ItemAward:setData(id, num, gridId)
	if not self.grid then
		local item = BaseObject.GetObject(id, num)

		self.grid = UIControls.getGridAwardContainer(self, self.mPath)
		self.grid.mDisableWays = true

		self.grid:setContainerConfig(gridId)
		self.grid:setObj(item)

		self.grid.grid.isShowPreviewTips = true

		self.grid:setTextNumCtrlEnable()
		self.grid:setVisible(true)
	end

	if self.gridState then
		self:setNumColor(self.gridState)
	end
end

function ItemAward:clearGrid()
	if self.grid then
		self.grid:destroy()

		self.grid = nil
	end
end

function ItemAward:setNumColor(gridState)
	self.gridState = gridState

	if self.grid then
		self.grid:setNumColor(gridState)
	end
end

function ItemAward:setGrey(isGrey)
	if self.grid then
		self.grid:setIconGray(isGrey)
	end
end

local NmlDayCell = Class("NmlDayCell", UIControls.ScrollViewLoopCell)
local ANIM_INFO = {
	"NmlAwardDailyCellL",
	"HighAwardDailyCellL",
	"DisAwardDailyCellL"
}

function NmlDayCell:ctor()
	self.state = 0
	self.items = {}
	self.gridId = 1
	self.panel = UIControls.Panel(self, "")
	self.txtDay = UIControls.Label(self, "InfoPanel/DatePanel/TextDay")
	self.panelRecieve = UIControls.Panel(self, "InfoPanel/ReceivePanel")
	self.spacePanel = UIControls.Panel(self, "SpacePanel")
	self.btn = UIControls.Button(self, "InfoPanel/BtnReceive")

	self.btn:clearEventClick()
	self.btn:addEventClick(Slot(self.onClick, self))
end

function NmlDayCell:setData(data, svrData, state)
	local idx = data.param

	self.spacePanel:setVisible(idx % 2 == 0)

	self.data = data
	self.dateParem = data.param

	local tempId = ResOpActivityTemplate[data.detail_id].client_template

	tempId = tempId and tempId[1]

	local tempData = ResOpActivityClientTemplate[tempId]

	if tempData then
		self.gridId = tempData.grid_id or 1
	end

	self.state = state

	self.txtDay:setText(data.param)

	for i, item in ipairs(self.items) do
		self.items[i]:clearGrid()
	end

	self.items = {}

	self:_setUI(data)
end

function NmlDayCell:_setUI(data)
	local awardData = ResRandClient[data.award]

	for i = 1, 3 do
		if not self.items[i] then
			self.items[i] = ItemAward(self, "InfoPanel/AwardDailyPanel" .. i)
		end

		self.items[i]:clearGrid()

		if not awardData.show_ids[i] then
			self.items[i]:setNothing()
		else
			self.items[i]:setData(awardData.show_ids[i], awardData.show_nums[i], self.gridId)
		end
	end

	self:_resetUI()
end

function NmlDayCell:_resetUI()
	local data = self.data
	local gridState = 1
	local isGray = false

	if self.state == 3 then
		gridState = 1

		self.panel:playStateAnimator(ANIM_INFO[1])
	elseif self.state == 2 then
		gridState = 2

		self.panel:playStateAnimator(ANIM_INFO[2])
	else
		gridState = 3
		isGray = true

		self.panel:playStateAnimator(ANIM_INFO[3])
	end

	if self.items then
		for _, item in ipairs(self.items) do
			item:setGrey(isGray)
			item:setNumColor(gridState)
		end
	end
end

function NmlDayCell:onClick()
	if self.mEventClick then
		self:mEventClick()
	end
end

local SignInDayCell = Class("SignInDayCell", UIControls.Child)

function SignInDayCell:ctor()
	self.txtDay = UIControls.Label(self, "TextDay")
	self.gridCells = {}
	self.btnGet = UIControls.Button(self, "BtnReceive")

	self.btnGet:clearEventClick()
	self.btnGet:addEventClick(self.onClick)

	self.panelGot = UIControls.Panel(self, "ImgDis")
	self.panelNext = UIControls.Panel(self, "TextHint")
end

function SignInDayCell:setData(data, svrData, state)
	self.data = data
	self.dateParem = data.param
	self.state = state

	self.txtDay:setText("0" .. data.param)
	ClientUtils.CreateActivityBonusGrid(self, self.gridCells, "GridAward", data.award)

	for _, grid in ipairs(self.gridCells) do
		grid:setState(state)
	end

	if state == Const.ACT_ACHIEVE_STATE_GOT then
		self.btnGet:setVisible(false)
		self.panelGot:setVisible(true)
		self.panelNext:setVisible(false)
	elseif state == Const.ACT_ACHIEVE_STATE_ENOUGH then
		self.btnGet:setVisible(true)
		self.panelGot:setVisible(false)
		self.panelNext:setVisible(false)
	else
		self.btnGet:setVisible(false)
		self.panelGot:setVisible(false)

		local actData = self.mParent.actObj.actData
		local isNext = false

		if self.dateParem == 1 then
			isNext = true
		else
			local preState = actData:getAchieveState(self.mParent.activityType, self.dateParem - 1)

			isNext = preState == Const.ACT_ACHIEVE_STATE_ENOUGH or preState == Const.ACT_ACHIEVE_STATE_GOT
		end

		self.panelNext:setVisible(isNext)
	end
end

function SignInDayCell:_resetUI()
	return
end

function SignInDayCell:onClick()
	if self.mEventClick then
		self:mEventClick()
	end
end

local SignCell = Class("SignCell", UIControls.ScrollViewLoopCell)
local anims = {
	"EncoreSignInCellNml",
	"EncoreSignInCellSel",
	"EncoreSignInCellDis"
}

function SignCell:ctor()
	self.panel = UIControls.Panel(self, "")
	self.txtDay = UIControls.Label(self, "TextDay")
	self.gridCells = {}
	self.btnGet = UIControls.Button(self, "BtnReceive")

	self.btnGet:clearEventClick()
	self.btnGet:addEventClick(self.onClick)

	self.panelGot = UIControls.Panel(self, "ImgDis")
	self.panelNext = UIControls.Panel(self, "TextHint")
end

function SignCell:setData(data, svrData, state)
	self.data = data
	self.dateParem = data.param
	self.state = state

	self.txtDay:setText(string.format(ResClientNotice[681].notice, data.param))
	ClientUtils.CreatePreviewBonusSumGrid(self, self.gridCells, "GridAward", {
		data.award
	}, nil, nil, true)

	for _, grid in ipairs(self.gridCells) do
		if state == 1 then
			grid:setState(nil, true)
		end
	end

	if state == Const.ACT_ACHIEVE_STATE_GOT then
		self.btnGet:setVisible(false)
		self.panelGot:setVisible(true)
		self.panelNext:setVisible(false)
		self.panel:playStateAnimator(anims[3])
	elseif state == Const.ACT_ACHIEVE_STATE_ENOUGH then
		self.btnGet:setVisible(true)
		self.panelGot:setVisible(false)
		self.panelNext:setVisible(false)
		self.panel:playStateAnimator(anims[2])
	else
		self.btnGet:setVisible(false)
		self.panelGot:setVisible(false)
		self.panel:playStateAnimator(anims[1])

		local actData = self.mParent.actObj.actData
		local isNext = false

		if self.dateParem == 1 then
			isNext = true
		else
			local preState = actData:getAchieveState(self.mParent.activityType, self.dateParem - 1)

			isNext = preState == Const.ACT_ACHIEVE_STATE_ENOUGH or preState == Const.ACT_ACHIEVE_STATE_GOT
		end

		self.panelNext:setVisible(isNext)
	end
end

function SignCell:_resetUI()
	return
end

function SignCell:onClick()
	if self.mEventClick then
		self:mEventClick()
	end
end

local calssNameStr = "ActivityNmlSigninPage"
local ActivityNmlSigninPage = Class(calssNameStr, UIControls.Child)

MixinClass(ActivityNmlSigninPage, ActivityPanelMixin)

function ActivityNmlSigninPage:initUI()
	self.btns = {}
	self.curSelectBtn = nil
	self.textTime = UIControls.Label(self, "BgTime/TextTime")

	if UIControls.checkControlFunc(self, "SignInAwardList") then
		self.scrollSign = UIControls.ScrollViewLoopH(self, "SignInAwardList", 0, self.onSignCellChanged)
	elseif UIControls.checkControlFunc(self, "ContentList") then
		self.scrollItems = UIControls.ScrollViewLoopV(self, "ContentList", 0, self._onCellChanged)
	else
		self.panelList = UIControls.Panel(self, "SignInAwardPanel")
	end

	if UIControls.checkControlFunc(self, "BgTextSignIn/TextSignIn") then
		self.txtSignIn = UIControls.Label(self, "BgTextSignIn/TextSignIn")
	end

	self.isVisible = false
end

function ActivityNmlSigninPage:_setData()
	self:_refreshData()
end

function ActivityNmlSigninPage:_refreshData()
	local detailData = {}
	local activityType

	for actType, dataTab in pairs(self.actObj.actData.clientData) do
		if not activityType then
			activityType = actType
			self.activityType = actType
		end

		for _, data in ipairs(dataTab) do
			table.insert(detailData, data)
		end
	end

	self.detailData = detailData
	self.svrData = self.actObj.actData.serverData and self.actObj.actData.serverData[self.activityType] or {
		progress = 0
	}
	self.totalDay = #self.detailData
	self.btnBuyHandler = nil

	self:setCellInfo()
end

function ActivityNmlSigninPage:setCellInfo()
	local actData = self.actObj.actData

	for idx, data in ipairs(self.detailData) do
		local btnState = actData:getAchieveState(self.activityType, idx)

		if btnState == 2 then
			if not self.canGetTargetIdx then
				self.canGetTargetIdx = idx
			end
		elseif btnState == 3 and not self.toFinishTargetIdx then
			self.toFinishTargetIdx = idx
		end
	end

	self.targetCellIdx = self.canGetTargetIdx and self.canGetTargetIdx or self.toFinishTargetIdx

	if self.targetCellIdx == nil or self.targetCellIdx > #self.detailData - 4 then
		self.targetCellIdx = #self.detailData - 4
	end

	if self.txtSignIn then
		local nowProgress = 0

		if actData.serverData and actData.serverData[self.activityType] then
			nowProgress = actData.serverData[self.activityType].progress
		end

		self.txtSignIn:setText(string.format(ResClientNotice[680].notice, nowProgress))
	end
end

function ActivityNmlSigninPage:_onCellChanged(sender, targetCell, newIdx)
	local actData = self.actObj.actData

	if targetCell == nil then
		local cellPath = "Activity/ActivityDaily/ActivityAwardDailyCell"

		if self.replaceableCellPath and self.replaceableCellPath[1] then
			cellPath = self.replaceableCellPath[1]
		end

		targetCell = NmlDayCell(sender, "System/" .. cellPath, newIdx, 0, 0)
	else
		self.btns[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	local btnState = actData:getAchieveState(self.activityType, newIdx)

	self.btns[newIdx] = targetCell

	self.btns[newIdx]:setData(self.detailData[newIdx], self.svrData, btnState)

	self.btns[newIdx].mEventClick = Slot(self.onCellClick, self)

	self.btns[newIdx]:setVisible(true)
end

function ActivityNmlSigninPage:onSignCellChanged(sender, targetCell, newIdx)
	local actData = self.actObj.actData

	if targetCell == nil then
		local cellPath = "Activity/ActivityEncore/EncoreSignInCell01"

		if self.replaceableCellPath and self.replaceableCellPath[1] then
			cellPath = self.replaceableCellPath[1]
		end

		targetCell = SignCell(sender, "System/" .. cellPath, newIdx, 0, 0)
	else
		self.btns[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	local btnState = actData:getAchieveState(self.activityType, newIdx)

	self.btns[newIdx] = targetCell

	self.btns[newIdx]:setData(self.detailData[newIdx], self.svrData, btnState)

	self.btns[newIdx].mEventClick = Slot(self.onCellClick, self)

	self.btns[newIdx]:setVisible(true)
end

function ActivityNmlSigninPage:_onShow(isOnPageShow)
	CurAvatar:sendRechargeAnalyticsData(Const.OSS_TYPE_SHOW_UI, Const.OSS_OPEN_UI_TYPE_ACT, self.clientTemplateData.template_id)

	if isOnPageShow then
		if self.isVisible == false then
			if self.panelList then
				local cellPath = "System/Activity/"

				if self.replaceableCellPath and self.replaceableCellPath[1] then
					cellPath = self.replaceableCellPath[1]
				end

				for idx, data in ipairs(self.detailData) do
					local btnState = self.actObj.actData:getAchieveState(self.activityType, idx)

					if not self.btns[idx] then
						if data.high_award == 1 then
							self.btns[idx] = SignInDayCell(self, "SignInAwardPanel", cellPath .. "AwardSpecialItem")
						else
							self.btns[idx] = SignInDayCell(self, "SignInAwardPanel", cellPath .. "AwardCommonItem")
						end
					end

					self.btns[idx]:setVisible(true)

					self.btns[idx].mEventClick = Slot(self.onCellClick, self)

					self.btns[idx]:setData(data, self.svrData, btnState)
				end
			elseif self.scrollItems then
				self.scrollItems:setTotalCount(#self.detailData, self.targetCellIdx)

				self.isVisible = true
			elseif self.scrollSign then
				self.targetCellIdx = self.canGetTargetIdx and self.canGetTargetIdx or self.toFinishTargetIdx

				if self.targetCellIdx == nil or self.targetCellIdx > #self.detailData - 2 then
					self.targetCellIdx = #self.detailData - 2
				end

				self.scrollSign:setTotalCount(#self.detailData, self.targetCellIdx)

				self.isVisible = true
			end
		end

		for _, btn in pairs(self.btns) do
			btn:_resetUI()
		end
	end
end

function ActivityNmlSigninPage:onCellClick(sender)
	if sender.state ~= 2 then
		-- block empty
	else
		CurAvatar:activityRPC(Functor(RPC.opActGetAward, self.actObj.opId, sender.data.param, self.activityType), self.actObj.opId)

		self.btnBuyHandler = sender
	end
end

function ActivityNmlSigninPage:onActivityDataRefresh(actObj)
	self.actObj = actObj

	for _, btn in pairs(self.btns) do
		if self.btnBuyHandler and btn.dateParem == self.btnBuyHandler.dateParem then
			local btnState = self.actObj.actData:getAchieveState(self.activityType, btn.dateParem)

			btn:setData(self.detailData[btn.dateParem], self.svrData, btnState)
			btn:_resetUI()
		end
	end

	self.btnBuyHandler = nil
end

function ActivityNmlSigninPage:_onClosePanel()
	for _, btn in pairs(self.btns) do
		btn:onClose()
	end
end

return ActivityNmlSigninPage
