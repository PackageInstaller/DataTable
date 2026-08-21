-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\NewMaze\\NewMazeHallowPreviewDlg.lua

local NewMazeShopHallowCard = require("UI/NewMaze/NewMazeShopHallowCard")
local ResNewMazeRelic = require("ClientData/ResNewMazeRelic")
local strClassName = "NewMazeHallowPreviewDlg"
local NewMazeHallowPreviewDlg = Class(strClassName, UIControls.Window)

function NewMazeHallowPreviewDlg:ctor()
	self.emptyPanel = UIControls.Panel(self, "BgPanel/EmptyPanel")
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.cells = {}
end

function NewMazeHallowPreviewDlg:setData()
	self.actObj = CurAvatar:getNewMazeActivity()

	if self.actObj then
		self.newMazeData = self.actObj.actData
	else
		MsgManager.notice(Lang.get(32785))

		return
	end

	self.hallowData = {}
	self.upHeroId = self.newMazeData.heroId

	for i, relic in pairs(self.newMazeData.bagRelics or {}) do
		local data = ResNewMazeRelic[relic.id]

		if data.hero_exclusive_id == self.upHeroId then
			data.sort = 1
		else
			data.sort = 2
		end

		table.insert(self.hallowData, data)
	end

	table.sort(self.hallowData, function(a, b)
		if a.sort == b.sort then
			return a.rarity > b.rarity
		else
			return a.sort < b.sort
		end
	end)

	for i, hallow in ipairs(self.hallowData) do
		local hallowCell = self.cells[i]

		if hallowCell == nil then
			hallowCell = NewMazeShopHallowCard(self, "BgPanel/GridPanel/Content", "System/Common/Grid/GridRogueHallowCard", 0, 0, true)
		end

		hallowCell:setData(hallow.id, self.upHeroId)

		self.cells[i] = hallowCell
	end

	self.emptyPanel:setVisible(#self.hallowData == 0)
end

function NewMazeHallowPreviewDlg:onBtnCloseClick()
	self:setVisible(false)
end

return NewMazeHallowPreviewDlg
