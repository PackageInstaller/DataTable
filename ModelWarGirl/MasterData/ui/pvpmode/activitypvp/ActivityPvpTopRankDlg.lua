-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PVPMode\\ActivityPVP\\ActivityPvpTopRankDlg.lua

local strClassName = "ActivityPvpTopRankDlg"
local ActivityPvpTopRankDlg = Class(strClassName, UIControls.Window)

function ActivityPvpTopRankDlg:ctor(...)
	self:initUI()
end

function ActivityPvpTopRankDlg:initUI(...)
	self.rankCells = {}

	local path, cell

	for i = 1, 10 do
		cell = {}
		path = "Bg/ContentPanel/Rank" .. i
		cell.panel = UIControls.Panel(self, path)
		cell.txtName = UIControls.Label(self, path .. "/TextName")
		cell.txtPower = UIControls.Label(self, path .. "/TextPower")
		cell.txtTitle = UIControls.Label(self, path .. "/TextPowerTitle")
		cell.head = UIControls.PlayerHeadGridChild(self, path .. "/GridPlayer", "System/Common/Grid/GridPlayerCommon")

		table.insert(self.rankCells, cell)
	end
end

function ActivityPvpTopRankDlg:onOpen(...)
	ActivityPvpTopRankDlg.super.onOpen(self)

	local ui = UIManager.getUI("activityPvpMainDlg", nil, false)

	if ui then
		self:bindWindow(ui)
	end
end

function ActivityPvpTopRankDlg:show(data)
	local info

	for i, cell in ipairs(self.rankCells) do
		info = data[i]

		if info then
			local name = utils.GetPlayerName(info.data.comm.name)

			cell.txtName:setText(name)
			cell.txtPower:setText(info.data.power)
			cell.head:setCommInfo(info.data.comm, false, self)
			cell.txtPower:setVisible(true)
			cell.txtTitle:setVisible(true)
			cell.head:setVisible(true)
		else
			cell.txtPower:setVisible(false)
			cell.txtTitle:setVisible(false)
			cell.head:setVisible(false)
			cell.txtName:setText(Lang.get(906))
		end
	end
end

return ActivityPvpTopRankDlg
