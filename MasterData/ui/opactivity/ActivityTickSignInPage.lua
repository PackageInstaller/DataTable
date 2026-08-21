-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityTickSignInPage.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local resRandClient = require("ClientData/ResRandClient")
local ResOpActivityTemplate = require("ClientData/ResOpActivityTemplate")
local ResOpActivityClientTemplate = require("ClientData/ResOpActivityClientTemplate")
local ResActivityPlayNodeConfig = require("ClientData/ResActivityPlayNodeConfig")
local SigninDayCell = Class("SigninDayCell", UIControls.Panel)
local STATE_UI_INFO = {
	{
		"BgGiftDis",
		false,
		false,
		false,
		true
	},
	{
		"BgGiftSel",
		false,
		true,
		false,
		true
	},
	{
		"BgGiftNml",
		true,
		false,
		true,
		false
	}
}

function SigninDayCell:ctor()
	self.imgBubble = UIControls.Image(self, self.mPath .. "/AwardPanel/BgBubble")
	self.txtNameNml = UIControls.Label(self, self.mPath .. "/AwardPanel/TextHolidayNml")
	self.txtNameHigh = UIControls.Label(self, self.mPath .. "/AwardPanel/TextHolidayHigh")
	self.imgBiuldNml = UIControls.Image(self, self.mPath .. "/BgBuildNml")
	self.imgBiuldHign = UIControls.Image(self, self.mPath .. "/BgBuildHigh")
	self.btnConfirm = UIControls.Button(self, self.mPath .. "/AwardPanel/GridPanel")

	self.btnConfirm:addEventClick(self.onClick)

	self.btnLimitPanel = UIControls.Panel(self, self.mPath .. "/AwardPanel/GridPanel/PanelReward")
	self.highPanel = UIControls.Panel(self, self.mPath .. "/AwardPanel/HighPanel")
	self.disPanel = UIControls.Panel(self, self.mPath .. "/AwardPanel/DisPanel")
	self.btnReplayAvg = UIControls.Button(self, self.mPath .. "/AwardPanel/DisPanel/BtnRepeat")

	self.btnReplayAvg:addEventClick(self.playAvg)

	self.imgHero = UIControls.Panel(self, self.mPath .. "/ImgHero")
	self.panelCell = UIControls.Panel(self, self.mPath .. "")
	self.resPath = "Atlas/ActivityAtlas/"
	self.resName = "ActivityFestivalSignInAtlas1"

	if self.mParent.replaceableCellPath and self.mParent.replaceableCellPath[1] then
		self.resName = self.mParent.replaceableCellPath[1]
	end
end

function SigninDayCell:setData(data, svrData, state)
	self.data = data

	if not self.items then
		self.items = {}

		local gridId = self.mParent.gridId or nil
		local gridConfig = {}

		gridConfig.checkNeedConvertObject = true

		ClientUtils.CreateBonusGrid(self, self.items, self.mPath .. "/AwardPanel/GridPanel/CavelReward", data.award, true, nil, true, nil, gridId, gridConfig)
		self.txtNameNml:setText(data.desc_name)
		self.txtNameHigh:setText(data.desc_name)
	end

	local uiInfo = STATE_UI_INFO[state]

	if uiInfo then
		self.imgBubble:setImage(self.resPath .. self.resName, uiInfo[1])
		self.txtNameNml:setVisible(uiInfo[2])
		self.txtNameHigh:setVisible(uiInfo[3])
		self.imgBiuldNml:setVisible(uiInfo[4])
		self.imgBiuldHign:setVisible(uiInfo[5])
	end

	self.imgHero:setVisible(false)
	self.btnLimitPanel:setVisible(state == Const.ACT_ACHIEVE_STATE_ENOUGH)
	self.highPanel:setVisible(state == Const.ACT_ACHIEVE_STATE_ENOUGH)
	self.disPanel:setVisible(state == Const.ACT_ACHIEVE_STATE_GOT)

	local playNodeId = self.data.play_node_id
	local secId

	if playNodeId and ResActivityPlayNodeConfig[playNodeId] then
		secId = ResActivityPlayNodeConfig[playNodeId].avg_id
	else
		secId = self.data.avgIds and self.data.avgIds[1]
	end

	if secId then
		self.btnReplayAvg:setVisible(state == Const.ACT_ACHIEVE_STATE_GOT)
	else
		self.btnReplayAvg:setVisible(false)
	end

	for index, grid in ipairs(self.items) do
		if grid.lazyEffChild then
			grid.lazyEffChild:setVisible(state ~= Const.ACT_ACHIEVE_STATE_GOT)
		end

		grid:setGet(state == Const.ACT_ACHIEVE_STATE_GOT)
	end
end

function SigninDayCell:setImgHero()
	self.imgHero:setVisible(true)
end

function SigninDayCell:onClick()
	local playNodeId = self.data.play_node_id
	local secId

	if playNodeId and ResActivityPlayNodeConfig[playNodeId] then
		secId = ResActivityPlayNodeConfig[playNodeId].avg_id
	else
		secId = self.data.avgIds and self.data.avgIds[1]
	end

	if secId then
		UIManager.playAVG(secId, nil, Slot(self.getAwards, self))
	else
		self:getAwards()
	end
end

function SigninDayCell:playAvg()
	local playNodeId = self.data.play_node_id
	local secId

	if playNodeId and ResActivityPlayNodeConfig[playNodeId] then
		secId = ResActivityPlayNodeConfig[playNodeId].avg_id
	else
		secId = self.data.avgIds and self.data.avgIds[1]
	end

	if secId then
		UIManager.playAVG(secId)
	end
end

function SigninDayCell:getAwards()
	if self.mEventClick then
		self:mEventClick()
	end
end

local strClassName = "ActivityTickSignInPage"
local ActivityTickSignInPage = Class(strClassName, UIControls.Child)

MixinClass(ActivityTickSignInPage, ActivityPanelMixin)

local ACHIEVE_TYPE_TICK = 27

function ActivityTickSignInPage:initUI()
	local dayCount = 0
	local actData = self.actObj.actData

	for i, typeData in pairs(actData.clientData) do
		dayCount = dayCount + #typeData
	end

	self.dayCount = dayCount
	self.dayCells = {}
	self.textTime = UIControls.Label(self, "BgTime/TextTime")

	for i = 1, dayCount do
		local cell = SigninDayCell(self, "GridItemPanel/GridItemHolidayPanel" .. i)

		if cell then
			cell.mEventClick = Slot(self.onCellClick, self)
			self.dayCells[i] = cell
		end
	end

	local tempData = actData.clientTemplateData

	if tempData then
		self.gridId = tempData.grid_id
	end
end

function ActivityTickSignInPage:_onShow(isOnPageShow)
	if isOnPageShow then
		self:refreshCells()
	end
end

function ActivityTickSignInPage:_setData()
	if not self.clientData then
		self.clientData = {}

		for i, typeData in pairs(self.actObj.actData.clientData) do
			for j, cDdata in ipairs(typeData) do
				table.insert(self.clientData, cDdata)
			end
		end
	end

	table.sort(self.clientData, function(a, b)
		return a.index < b.index
	end)
end

function ActivityTickSignInPage:refreshCells()
	local hasShowFlag = false
	local actData = self.actObj.actData

	for i, cell in ipairs(self.dayCells) do
		local clientData = self.clientData[i]

		if clientData then
			local svrData = actData.serverData[clientData.type]
			local state = actData:getAchieveState(clientData.type, clientData.index)

			cell:setData(clientData, svrData, state)
			cell:setVisible(true)

			if not hasShowFlag then
				if state == Const.ACT_ACHIEVE_STATE_NOT_ENOUGH then
					local preCell = self.dayCells[i - 1]

					if preCell then
						preCell:setImgHero()
					end

					hasShowFlag = true
				elseif i == #self.dayCells then
					cell:setImgHero()
				end
			end
		else
			cell:setVisible(false)
		end
	end
end

function ActivityTickSignInPage:onCellClick(sender)
	CurAvatar:activityRPC(Functor(RPC.opActGetAward, self.actObj.opId, sender.data.index, sender.data.type), self.actObj.opId)
end

function ActivityTickSignInPage:onActivityDataRefresh(actObj)
	self:refreshCells()
end

function ActivityTickSignInPage:_onClosePanel()
	return
end

return ActivityTickSignInPage
