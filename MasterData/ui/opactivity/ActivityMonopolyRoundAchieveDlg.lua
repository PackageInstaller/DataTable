-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityMonopolyRoundAchieveDlg.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local ResOpActivityAchieveMisc = require("ClientData/ResOpActivityAchieveMisc")
local ResRandClient = require("ClientData/ResRandClient")
local BaseObject = require("Common/Object/BaseObject")
local MonopolyAchieveRoundCell = Class("MonopolyAchieveRoundCell", UIControls.Child)
local SOURCEIMG_PATH = "Atlas/ActivityAtlas/ActivityAtlas01"

function MonopolyAchieveRoundCell:ctor()
	self.nmlPanel = UIControls.Panel(self, "NmlPanel")
	self.disPanel = UIControls.Panel(self, "DisPanel")
	self.otherPanel = UIControls.Panel(self, "OtherPanel")
	self.curPanelPath = "NmlPanel"
	self.stateUIs = {}
end

function MonopolyAchieveRoundCell:setData(achieveData, state, isNextToGet, needIconPath, startParam)
	self.isNextToGet = isNextToGet
	self.data = achieveData
	self.startParam = startParam
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

function MonopolyAchieveRoundCell:_refrehState(needIconPath)
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

			grid:changeGetImg("Atlas/ActivityAtlas/ActivityAtlas01", "BgPaw")
		end

		self.stateUIs[uiState] = {
			txtNum,
			imgIcon,
			grids
		}
	end

	local uis = self.stateUIs[uiState]

	uis[2]:setImageGray(UI_INFO[uiState][2])
	uis[1]:setText(self.data.param - self.startParam)

	if needIconPath then
		uis[2]:setImage(needIconPath[1], needIconPath[2])
	end

	for _, grid in ipairs(uis[3]) do
		grid:setState(false, self.state == 1, true)
	end
end

local MonopolyAchieveBottomCell = Class("MonopolyAchieveBottomCell", UIControls.Child)

function MonopolyAchieveBottomCell:ctor()
	self.sliderPro = UIControls.Slider(self, "Slider")
	self.imgRound = UIControls.Image(self, "BgRound")
	self.textRound = UIControls.Label(self, "BgRound/Text")
	self.panelBonus = UIControls.Panel(self, "GridAwardNml")
	self.panelSuperBonus = UIControls.Panel(self, "GridAwardSp")
	self.grids = {}
	self.bgSlider = UIControls.Image(self, "Slider/Background")
	self.bgSliderFill = UIControls.Image(self, "Slider/FillArea/Fill")
end

function MonopolyAchieveBottomCell:setOrder(order)
	if order ~= 1 then
		self.bgSlider:setImage("Atlas/ActivityAtlas/ActivityMonopolyAtlas2/ActivityMonopolyAtlas21", "BgBar01")
		self.bgSliderFill:setImage("Atlas/ActivityAtlas/ActivityMonopolyAtlas2/ActivityMonopolyAtlas21", "BgBarFull01")
	end
end

function MonopolyAchieveBottomCell:setData(roundNum, progress, bonusId, superAward, lastRound)
	self.sliderPro:setValue(progress)

	if roundNum == lastRound then
		self.textRound:setText(Lang.get(30621))
	else
		self.textRound:setText(roundNum)
	end

	if superAward == 1 then
		ClientUtils.CreateBonusGrid(self, self.grids, "GridAwardSp", bonusId, true, 1, true, {
			isShowPreviewTips = true
		})
	else
		ClientUtils.CreateBonusGrid(self, self.grids, "GridAwardNml", bonusId, true, 1, true, {
			isShowPreviewTips = true
		})
	end

	for i, grid in ipairs(self.grids) do
		grid:setGet(progress >= 1)
	end

	if progress >= 1 then
		self.textRound:setFontColor(ResColor.GROUP01)
		self.imgRound:setImage("Atlas/ActivityAtlas/ActivityMonopolyAtlas2/ActivityMonopolyAtlas21", "BgNumberPass")
	else
		self.textRound:setFontColor(ResColor.GREYLIGHT)
		self.imgRound:setImage("Atlas/ActivityAtlas/ActivityMonopolyAtlas2/ActivityMonopolyAtlas21", "BgNumber")
	end
end

local strClassName = "ActivityMonopolyRoundAchieveDlg"
local ActivityMonopolyRoundAchieveDlg = Class(strClassName, UIControls.Window)

MixinClass(ActivityMonopolyRoundAchieveDlg, ActivityPanelMixin)

function ActivityMonopolyRoundAchieveDlg:initUI()
	self.imgItem = UIControls.Image(self, "BgPanel/HavePanel/Icon")
	self.txtItemNum = UIControls.Label(self, "BgPanel/HavePanel/TextNum")
	self.needItemId = nil

	local miscData = ResOpActivityAchieveMisc[self.actObj.actId] or {}

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

	self.textCurRound = UIControls.Label(self, "BgPanel/RoundAwardPanel/TextRoundNum")
	self.panelBottom = UIControls.Panel(self, "BgPanel/RoundAwardPanel/AwardList/Content")
end

function ActivityMonopolyRoundAchieveDlg:_setData()
	local svrData

	for _, sData in pairs(self.actObj.actData.serverData) do
		svrData = sData
	end

	local clientData = {}

	for achieveType, cData in pairs(self.actObj.actData.clientData) do
		clientData = cData

		break
	end

	local pro = svrData and svrData.progress or 0
	local roundProStart = 0
	local finishRound = 0
	local startIndex = 1
	local endIndex = 0
	local showPage = 1
	local roundStart = 1

	for round, roundInfo in ipairs(self.actObj.actData.clientFakeRound) do
		local eIndex = roundInfo.detail_index
		local indexData = clientData[eIndex]

		if indexData and indexData.param and pro >= indexData.param and round ~= #self.actObj.actData.clientFakeRound then
			finishRound = round
			roundProStart = indexData.param
			startIndex = eIndex + 1

			if showPage ~= roundInfo.belong_page then
				showPage = roundInfo.belong_page
				roundStart = round
			end
		else
			if showPage ~= roundInfo.belong_page then
				showPage = roundInfo.belong_page
				roundStart = round
			end

			endIndex = eIndex

			break
		end
	end

	local curRound = finishRound + 1

	self.textCurRound:setText(curRound)

	local nowPro = pro - roundProStart

	self.txtItemNum:setText(nowPro)

	self.cells = {}
	self.achieveData = {}

	for index = startIndex, endIndex do
		table.insert(self.achieveData, clientData[index])
	end

	for index = 1, #self.achieveData do
		local newCell = MonopolyAchieveRoundCell(self, "BgPanel/AchiPanel", "System/Activity/ActivityMonopoly2/ActivityMonopolyAchiCell")

		table.insert(self.cells, newCell)
		newCell:setVisible(true)
	end

	local passedIndex = 0
	local preGot = true

	for index, cell in ipairs(self.cells) do
		local achieveData = self.achieveData[index]

		if achieveData then
			local state = self.actObj.actData:getAchieveState(achieveData.type, achieveData.index)

			if state == Const.ACT_ACHIEVE_STATE_GOT then
				passedIndex = passedIndex + 1
				preGot = true

				cell:setData(achieveData, state, false, self.needIconPath, roundProStart)
			elseif state == Const.ACT_ACHIEVE_STATE_ENOUGH then
				-- block empty
			elseif state == Const.ACT_ACHIEVE_STATE_NOT_ENOUGH then
				if preGot or achieveData.index == 1 then
					cell:setData(achieveData, state, true, self.needIconPath, roundProStart)
				else
					cell:setData(achieveData, state, false, self.needIconPath, roundProStart)
				end

				preGot = false
			end
		end
	end

	if #self.achieveData >= 1 then
		local passedProgress = passedIndex / #self.achieveData

		self.bottomCells = {}

		for nowRound = 1, #self.actObj.actData.clientFakeRound do
			local roundData = self.actObj.actData.clientFakeRound[nowRound] or {}
			local newCell = MonopolyAchieveBottomCell(self, "BgPanel/RoundAwardPanel/AwardList/Content", "System/Activity/ActivityMonopoly2/ActivityMonopolyRoundAwardCell")

			if nowRound < curRound then
				newCell:setData(nowRound, 1, roundData.bonus_id, roundData.super_award_flag, #self.actObj.actData.clientFakeRound)
			elseif curRound < nowRound then
				newCell:setData(nowRound, 0, roundData.bonus_id, roundData.super_award_flag, #self.actObj.actData.clientFakeRound)
			else
				newCell:setData(nowRound, passedProgress, roundData.bonus_id, roundData.super_award_flag, #self.actObj.actData.clientFakeRound)
			end

			newCell:setOrder(nowRound)
			newCell:setVisible(true)
			table.insert(self.bottomCells, newCell)
		end

		if curRound and curRound > 1 then
			curRound = curRound - 1.5

			self.panelBottom:setPosition(-curRound * 190, 0)
		end
	end
end

function ActivityMonopolyRoundAchieveDlg:refreshRealPanel()
	return
end

return ActivityMonopolyRoundAchieveDlg
