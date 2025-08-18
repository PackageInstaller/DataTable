-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\OtherBattle\\OnceTowerMonsterDlg.lua

local OnceTowerMonsterDlg = Class("OnceTowerMonsterDlg", UIControls.Window)

function OnceTowerMonsterDlg:ctor()
	self.monsterCells = {}
end

function OnceTowerMonsterDlg:onShow(monsterObjs)
	for index = #self.monsterCells, #monsterObjs - 1 do
		local newCell = UIControls.MonsterCardChild(self, "BgPanel/MonsterPanel", "System/Common/Grid/GridMonster")

		table.insert(self.monsterCells, newCell)
	end

	for index, cell in ipairs(self.monsterCells) do
		if monsterObjs[index] then
			cell:setVisible(true)
			cell:setObj(monsterObjs[index])
		else
			cell:setVisible(false)
		end
	end
end

return OnceTowerMonsterDlg
