-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityShopAchieveDlg.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local ResOpActivityAchieveMisc = require("ClientData/ResOpActivityAchieveMisc")
local ResRandClient = require("ClientData/ResRandClient")
local BaseObject = require("Common/Object/BaseObject")
local ActivityShopAchieveCell = Class("ActivityShopAchieveCell", UIControls.Child)
local SOURCEIMG_PATH = "Atlas/ActivityAtlas/ActivityAtlas01"

function ActivityShopAchieveCell:ctor()
	self.nmlPanel = UIControls.Panel(self, "NmlPanel")
	self.disPanel = UIControls.Panel(self, "DisPanel")
	self.otherPanel = UIControls.Panel(self, "OtherPanel")
	self.curPanelPath = "NmlPanel"
	self.stateUIs = {}
end

function ActivityShopAchieveCell:setData(achieveData, state, isNextToGet, needIconPath)
	self.isNextToGet = isNextToGet
	self.data = achieveData
	self.state = state

	self:_refrehState(needIconPath)
end

local UI_INFO = {
	{
		"NmlPanel",
		false
	},
	{
		"OtherPanel",
		true
	},
	{
		"DisPanel",
		false
	}
}

function ActivityShopAchieveCell:_refrehState(needIconPath)
	local uiState = 0

	uiState = self.isNextToGet == true and 1 or self.state == 3 and 2 or 3

	self.nmlPanel:setVisible(uiState == 1)
	self.otherPanel:setVisible(uiState == 2)
	self.disPanel:setVisible(uiState == 3)

	if not self.stateUIs[uiState] then
		local curPanelPath = UI_INFO[uiState][1]
		local txtNum = UIControls.Label(self, curPanelPath .. "/TextNum")
		local imgIcon = UIControls.Image(self, curPanelPath .. "/Icon")
		local grids = {}

		ClientUtils.CreateBonusGrid(self, grids, curPanelPath .. "/AwardPanel", self.data.award, true, nil, true)

		for _, grid in ipairs(grids) do
			grid.isShowPreviewTips = true

			grid:changeGetImg("Atlas/ActivityAtlas/ActivityTokenStoreAtlas", "IconComplete")
		end

		self.stateUIs[uiState] = {
			txtNum,
			imgIcon,
			grids
		}
	end

	local uis = self.stateUIs[uiState]

	uis[2]:setImageGray(UI_INFO[uiState][2])
	uis[1]:setText(self.data.param)

	if needIconPath then
		uis[2]:setImage(needIconPath[1], needIconPath[2])
	end

	for _, grid in ipairs(uis[3]) do
		grid:setState(false, self.state == 1, true)
	end
end

local strClassName = "ActivityShopAchieveDlg"
local ActivityShopAchieveDlg = Class(strClassName, UIControls.Window)

MixinClass(ActivityShopAchieveDlg, ActivityPanelMixin)

function ActivityShopAchieveDlg:initUI()
	self.textRule = UIControls.Label(self, "BgPanel/TxtRule")
	self.imgItem = UIControls.Image(self, "BgPanel/HavePanel/Icon")
	self.btnItem = UIControls.Button(self, "BgPanel/HavePanel/Icon")

	self.btnItem:addEventClick(self.onItemBtnClick)

	self.txtItemNum = UIControls.Label(self, "BgPanel/HavePanel/TextNum")
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onBtnClose)

	self.panelScroll = UIControls.Panel(self, "BgPanel/AchiLoopPanel/AchiPanel")
	self.cells = {}
	self.achieveData = {}

	local actId = self.actObj.actId
	local detailData = self.actObj.actData.clientData or {}

	for achieveType, aInfo in pairs(detailData) do
		for index, aData in ipairs(aInfo) do
			table.insert(self.achieveData, aData)
		end
	end

	for index = 1, #self.achieveData do
		local newCell = ActivityShopAchieveCell(self, "BgPanel/AchiLoopPanel/AchiPanel", "System/Activity/ActivityTokenStoreAchiCell")

		table.insert(self.cells, newCell)
		newCell:setVisible(true)
	end

	self.needItemId = nil

	local miscData = ResOpActivityAchieveMisc[actId] or {}

	for achieveType, mInfo in pairs(miscData) do
		if mInfo.item_id then
			self.needItemId = mInfo.item_id
			self.needIconPath = BaseObject.getItemIconPath(self.needItemId)

			if self.needIconPath then
				self.imgItem:setImage(self.needIconPath[1], self.needIconPath[2])
			end

			break
		end
	end
end

function ActivityShopAchieveDlg:_setData()
	local svrData

	for _, sData in pairs(self.actObj.actData.serverData) do
		svrData = sData
	end

	self.txtItemNum:setText(svrData and svrData.progress or 0)

	local nextIndex
	local preGot = true

	for index, cell in ipairs(self.cells) do
		local achieveData = self.achieveData[index]

		if achieveData then
			local state = self.actObj.actData:getAchieveState(achieveData.type, achieveData.index)

			if state == Const.ACT_ACHIEVE_STATE_GOT then
				preGot = true

				cell:setData(achieveData, state, false, self.needIconPath)
			elseif state == Const.ACT_ACHIEVE_STATE_ENOUGH then
				-- block empty
			elseif state == Const.ACT_ACHIEVE_STATE_NOT_ENOUGH then
				nextIndex = nextIndex or index

				if preGot or achieveData.index == 1 then
					cell:setData(achieveData, state, true, self.needIconPath)
				else
					cell:setData(achieveData, state, false, self.needIconPath)
				end

				preGot = false
			end
		end
	end

	if nextIndex then
		nextIndex = math.floor((nextIndex + 1) / 2) - 1

		local maxIndex = math.floor((#self.cells + 1) / 2)

		nextIndex = math.min(maxIndex - 3, math.max(0, nextIndex))
		nextIndex = nextIndex - 1

		local coordY = 104 * nextIndex + 6 * nextIndex

		self.panelScroll:setPosition(437.5, coordY)
	end
end

function ActivityShopAchieveDlg:refreshRealPanel()
	return
end

function ActivityShopAchieveDlg:onBtnClose()
	self:setVisible(false)
end

function ActivityShopAchieveDlg:onItemBtnClick()
	if self.needItemId then
		local fakeItem = BaseObject.GetObject(self.needItemId)

		UIManager.getUI("itemTips"):showObj(self.mWindow, fakeItem, {
			CloseSrcWindow = 1,
			AutoOpenGuide = 1
		})
	end
end

return ActivityShopAchieveDlg
