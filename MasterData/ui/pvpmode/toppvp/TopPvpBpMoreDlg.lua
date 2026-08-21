-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PVPMode\\TopPVP\\TopPvpBpMoreDlg.lua

local TopPvpBpHeroIconCell = require("UI/PVPMode/TopPVP/TopPvpBpHeroIconCell")
local TopPvpMoreInfoCell = Class("TopPvpMoreInfoCell", UIControls.Child)

function TopPvpMoreInfoCell:ctor()
	self:initUI()
end

local txtDesc = {
	Lang.get(76456),
	Lang.get(79942),
	Lang.get(79943)
}

function TopPvpMoreInfoCell:initUI()
	self.txtTitle = UIControls.Label(self, "TextTitle")
end

function TopPvpMoreInfoCell:setData(heros)
	self.heroCells = {}

	self.txtTitle:setText(txtDesc[self.index])

	for i = 1, #heros do
		local newCell = TopPvpBpHeroIconCell(self, "GridHero" .. i, "System/StarUp/GridHeroStarUp")

		newCell.txtHeroName = UIControls.Label(self, "GridHero" .. i .. "/TextHeroName")

		newCell:setVisible(true)

		local hero = BaseObject.GetObject(heros[i].hero_id)

		if hero then
			newCell.txtHeroName:setText(hero.fullName)
			newCell.txtHeroName:setVisible(true)
			newCell:setHero(hero)
		else
			newCell:setVisible(false)
		end

		table.insert(self.heroCells, newCell)
	end
end

local strClassName = "TopPvpBpMoreDlg"
local TopPvpBpMoreDlg = Class(strClassName, UIControls.Window)

function TopPvpBpMoreDlg:ctor()
	self:initUI()
end

function TopPvpBpMoreDlg:initUI(...)
	self.cells = {}

	for i = 1, 3 do
		local newCell = TopPvpMoreInfoCell(self, "BPMorePanel/ListMoreInfo", "System/TopPVP/TopPVPBPMoreInfoCell")

		newCell:setVisible(true)

		newCell.index = i

		table.insert(self.cells, newCell)
	end
end

function TopPvpBpMoreDlg:show(data)
	local afterData = {}

	for i = 1, 3 do
		afterData[i] = {}

		local onepool = data.bppool[i].bpnode

		for j = 1, #onepool do
			if onepool[j].state >= 201 and onepool[j].state <= 205 then
				table.insert(afterData[i], onepool[j])
			end
		end
	end

	for i = 1, 3 do
		self.cells[i]:setData(afterData[i])
	end
end

return TopPvpBpMoreDlg
