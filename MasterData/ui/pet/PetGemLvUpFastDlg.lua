-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Pet\\PetGemLvUpFastDlg.lua

local strClassName = "PetGemLvUpFastCell"
local PetGemLvUpFastCell = Class(strClassName, UIControls.ScrollViewLoopCell)

function PetGemLvUpFastCell:ctor()
	return
end

function PetGemLvUpFastCell:setData(gemGroup)
	self.gemGroup = gemGroup
	self.mainGem = self.gemGroup[1]
	self.subGem1 = self.gemGroup[2]
	self.subGem2 = self.gemGroup[3]

	if self.mainGemGrid == nil then
		self.mainGemGrid = UIControls.GridPetGemChild(self, "BeforePanel", "System/Pet/GridPetGem", 0, 0, true)
	end

	self.mainGemGrid:setObj(self.mainGem)
	self.mainGemGrid:setGridClickEnable(false)

	if self.previewGrid == nil then
		self.previewGrid = UIControls.GridPetGemChild(self, "AfterPanel", "System/Pet/GridPetGem", 0, 0, true)
	end

	if not self.mainGem:isMaxLevel() then
		local fakeGem = self.mainGem:getNextLevelGem()

		self.previewGrid:setObj(fakeGem)
		self.previewGrid:setGridClickEnable(false)
		self.previewGrid:setRandIcon()
	end

	if self.subGem1Grid == nil then
		self.subGem1Grid = UIControls.GridPetGemChild(self, "MaterialPanel1", "System/Pet/GridPetGem", 0, 0, true)
	end

	self.subGem1Grid:setObj(self.subGem1)
	self.subGem1Grid:setGridClickEnable(false)

	if self.subGem2Grid == nil then
		self.subGem2Grid = UIControls.GridPetGemChild(self, "MaterialPanel2", "System/Pet/GridPetGem", 0, 0, true)
	end

	self.subGem2Grid:setObj(self.subGem2)
	self.subGem2Grid:setGridClickEnable(false)
end

local strClassName = "PetGemLvUpFastDlg"
local PetGemLvUpFastDlg = Class(strClassName, UIControls.Window)

function PetGemLvUpFastDlg:ctor()
	self:initUI()
end

function PetGemLvUpFastDlg:initUI()
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnConfirm = UIControls.Button(self, "BgPanel/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)

	self.cellList = UIControls.ScrollViewLoopV(self, "BgPanel/CellList")

	self.cellList:addEventCellChanged(self.onGemGroupChanged)

	self.cells = {}
end

function PetGemLvUpFastDlg:setData()
	self.fastGemGroup = CurAvatar:getFastLvUpGemList()

	self.cellList:setTotalCount(#self.fastGemGroup)
end

function PetGemLvUpFastDlg:onGemGroupChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = PetGemLvUpFastCell(sender, "System/Pet/PetGemLvUpFastCell", newIdx)
	else
		self.cells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	if not self.fastGemGroup or #self.fastGemGroup == 0 then
		return
	end

	if self.fastGemGroup[newIdx] ~= nil then
		targetCell:setData(self.fastGemGroup[newIdx])
	end

	self.cells[newIdx] = targetCell
end

function PetGemLvUpFastDlg:onBtnConfirmClick()
	if #self.fastGemGroup > 0 then
		local data = {}

		for i, group in ipairs(self.fastGemGroup) do
			table.insert(data, {
				main_attr_lock = 0,
				main_gem_gid = group[1].gid,
				add_gem_gid = {
					group[2].gid,
					group[3].gid
				}
			})
		end

		local gemNum = CurAvatar:getPetGemCount()

		RPC.petGemLevelUp(data, gemNum)
	end
end

function PetGemLvUpFastDlg:onBtnCloseClick()
	self:setVisible(false)
end

return PetGemLvUpFastDlg
