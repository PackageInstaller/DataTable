-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityMonopolyAwardChooseDlg.lua

local ResOpActivityMonopolyAwardLib = require("ClientData/ResOpActivityMonopolyAwardLib")
local ResOpActivityMonopolyAwardLibMisc = require("ClientData/ResOpActivityMonopolyAwardLibMisc")
local ResRandClient = require("ClientData/ResRandClient")
local ChooseAwardGrid = Class("ChooseAwardGrid", UIControls.Child)

function ChooseAwardGrid:ctor()
	self.imgNum = UIControls.Image(self, "BgText")
	self.txtNum = UIControls.Label(self, "BgText/TextNum")
	self.imgSelect = UIControls.Image(self, "ImgCheck")

	self.imgNum:setVisible(true)

	self.grids = {}
end

function ChooseAwardGrid:setData(libData, gotCount)
	self.libData = libData

	self.txtNum:setText(libData.max_count - gotCount .. "/" .. libData.max_count)
	ClientUtils.CreateBonusGrid(self, self.grids, "GridPanel", self.libData.award_id, true, 1, true)

	for index, grid in ipairs(self.grids) do
		if gotCount >= libData.max_count then
			grid:setTipsEnable(true)
			grid:setIconGray(true)
			self.txtNum:setFontColor(ResColor.RED)
		else
			grid.grid.mEventClick = Slot(self.onClick, self)

			self.txtNum:setFontColor(ResColor.WHITE)
			grid:setTipsEnable(false)
			grid:setIconGray(false)
		end
	end

	self:setSelect(false)
end

function ChooseAwardGrid:setSelect(isSel)
	self.imgSelect:setVisible(isSel)
end

function ChooseAwardGrid:onClick()
	self.mParent:chooseFinalAward(self)
end

local strClassName = "ActivityMonopolyAwardChooseDlg"
local ActivityMonopolyAwardChooseDlg = Class(strClassName, UIControls.Window)

function ActivityMonopolyAwardChooseDlg:ctor()
	self:initUI()
end

function ActivityMonopolyAwardChooseDlg:initUI()
	self.cells = {}
	self.btnCancel = UIControls.Button(self, "MainInfoPanel/BtnClose")
	self.btnConfirm = UIControls.Button(self, "MainInfoPanel/BtnConfirm")

	self.btnCancel:addEventClick(self.onClickCancel)
	self.btnConfirm:addEventClick(self.onClickConfirm)

	self.textRule = UIControls.Label(self, "MainInfoPanel/TextRule")
	self.finalGrids = {}
	self.imgAward = UIControls.Image(self, "MainInfoPanel/FinalAwardPanel")
end

function ActivityMonopolyAwardChooseDlg:onShow(actObj, showLibId, monoMainDlg)
	local speAtlas = "Atlas/ActivityAtlas/ActivityMonopolyAtlas05"

	if monoMainDlg.replaceableCellPath and monoMainDlg.replaceableCellPath[3] then
		speAtlas = "Atlas/ActivityAtlas/" .. monoMainDlg.replaceableCellPath[3] .. "ActivityMonopolyAtlas05"
	end

	self.curChoose = nil
	self.actObj = actObj
	self.showLibId = showLibId
	self.awardChooseData = actObj.actData.chooseAwardInfo[showLibId] or {}
	self.nowChoose = self.awardChooseData[1]
	self.countInfo = self.awardChooseData[2] or {}

	local miscData = ResOpActivityMonopolyAwardLibMisc[self.showLibId]

	self.textRule:setText(miscData.rule_desc or "")
	self.imgAward:setImage(speAtlas, "BgAward" .. miscData.icon_str)

	self.libData = {}

	local invalidInfo = {}
	local curCell

	for index, info in ipairs(ResOpActivityMonopolyAwardLib[showLibId]) do
		if (self.countInfo[index] or 0) >= info.max_count then
			table.insert(invalidInfo, info)
		else
			table.insert(self.libData, info)
		end
	end

	for _, iInfo in ipairs(invalidInfo) do
		table.insert(self.libData, iInfo)
	end

	for index = #self.cells, #self.libData - 1 do
		local newCell = ChooseAwardGrid(self, "MainInfoPanel/AwardChooseList/Content", "System/Activity/ActivityMonopoly3/GridChooseAward")

		table.insert(self.cells, newCell)
	end

	for index, cell in ipairs(self.cells) do
		local libData = self.libData[index]

		if libData then
			cell:setVisible(true)
			cell:setData(libData, self.countInfo[libData.index] or 0)

			if libData.index == self.nowChoose then
				curCell = cell
			end
		else
			cell:setVisible(false)
		end
	end

	if curCell then
		self:chooseFinalAward(curCell)
	end
end

function ActivityMonopolyAwardChooseDlg:setCurAward(chooseAwardGrid)
	if chooseAwardGrid then
		ClientUtils.CreateBonusGrid(self, self.finalGrids, "MainInfoPanel/FinalAwardPanel", chooseAwardGrid.libData.award_id, true, 1, true)
	else
		for _, grid in ipairs(self.finalGrids) do
			grid:setVisible(false)
		end
	end
end

function ActivityMonopolyAwardChooseDlg:chooseFinalAward(award)
	if self.curChoose then
		self.curChoose:setSelect(false)
	end

	self.curChoose = award

	self.curChoose:setSelect(true)

	self.finalChoose = award.libData.index

	self:setCurAward(self.curChoose)
end

function ActivityMonopolyAwardChooseDlg:onClickConfirm()
	if self.finalChoose == nil then
		MsgManager.notice(Lang.get(30603))
	elseif self.nowChoose ~= self.finalChoose then
		CurAvatar:activityRPC(Functor(RPC.opActMonopolySetLibAward, self.actObj.opId, self.showLibId, self.finalChoose), self.actObj.opId)
		self:setVisible(false)
	else
		self:setVisible(false)
	end
end

function ActivityMonopolyAwardChooseDlg:onClickCancel()
	self:setVisible(false)
end

return ActivityMonopolyAwardChooseDlg
