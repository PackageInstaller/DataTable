-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\NewMaze\\NewMazeHaloPreviewDlg.lua

local ResNewMazeHalo = require("ClientData/ResNewMazeHalo")
local ResNewMazeDisplay = require("ClientData/ResNewMazeDisplay")
local NewMazeGridCard = require("UI/NewMaze/NewMazeGridCard")
local NewMazeLosderMixin = require("UI/NewMaze/NewMazeLosderMixin")
local strClassName = "NewMazeHaloPreviewDlg"
local NewMazeHaloPreviewDlg = Class(strClassName, UIControls.Window)

MixinClass(NewMazeHaloPreviewDlg, NewMazeLosderMixin)

function NewMazeHaloPreviewDlg:ctor()
	self:ctorMixin()

	self.emptyPanel = UIControls.Panel(self, "MainInfoPanel/EmptyPanel")
	self.btnClose = UIControls.Button(self, "MainInfoPanel/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.textDes = UIControls.Label(self, "MainInfoPanel/TextDes")
	self.cells = {}
end

function NewMazeHaloPreviewDlg:setData(notSort)
	self.actObj = CurAvatar:getNewMazeActivity()

	if self.actObj then
		self.newMazeData = self.actObj.actData
	else
		MsgManager.notice(Lang.get(32785))

		return
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_NEW_MAZE_HALO_PREVIEW, false)

	local maxUserHaloNum = self.newMazeData:getCurMaxHaloNumByShopLevel()

	self.textDes:setText(string.format(ResNewMazeDisplay[13060015].desc, maxUserHaloNum))

	self.halos = self.newMazeData.bagHalos
	self.usedHalo = self.newMazeData.usedHalo

	if not notSort then
		table.sort(self.halos, function(a, b)
			local isUseA = utils.tableIsContainsElement(self.usedHalo, a.id)
			local isUseB = utils.tableIsContainsElement(self.usedHalo, b.id)

			if isUseA ~= isUseB then
				return isUseA == true
			end
		end)
	end

	for i, halo in ipairs(self.halos) do
		local haloCell = self.cells[i]

		if haloCell == nil then
			haloCell = NewMazeGridCard(self, "MainInfoPanel/GridPanel/Content", "System/Rogue/BtnGridRogueCard", 0, 0, true)
		end

		local itemData = {
			id = halo.id,
			type = Const.NEW_MAZE_SHOP_ITEM_TYPE.Halo
		}

		haloCell:setData(itemData, Const.NEW_MAZE_HALO_PREVIEW_CARD)

		self.cells[i] = haloCell
	end

	self.emptyPanel:setVisible(#self.halos == 0)

	local lastAllFetters = self.allFetters or {}

	self:refreshFettersUI()

	if notSort then
		self:checkPlayLosderEfx(lastAllFetters)
	end
end

function NewMazeHaloPreviewDlg:refreshUI()
	self.usedHalo = self.newMazeData.usedHalo

	self:refreshFettersUIByUsed()
end

function NewMazeHaloPreviewDlg:refreshFettersUIByUsed()
	local allFetters = self.newMazeData:getAllFetters()

	for _, fettersData in pairs(allFetters or {}) do
		fettersData.halo = {}
	end

	for _, halo in pairs(self.halos or {}) do
		local fetterType = ResNewMazeHalo[halo.id].label

		if utils.tableIsContainsElement(self.usedHalo, halo.id) then
			for _, fettersData in pairs(allFetters or {}) do
				if fettersData.type == fetterType then
					table.insert(fettersData.halo, halo.id)
				end
			end
		end
	end

	self:refreshFettersUI(allFetters)
end

function NewMazeHaloPreviewDlg:onBtnCloseClick()
	self:setVisible(false)
end

return NewMazeHaloPreviewDlg
