-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\Valentine\\ActivityValentineHandBookDlg.lua

local SpecialTypeMaterialCell = Class("SpecialTypeMaterialCell", UIControls.Panel)

function SpecialTypeMaterialCell:ctor()
	self.textNum = UIControls.Label(self, self.mPath .. "/NumText")
	self.imgMaterial = UIControls.Image(self, self.mPath .. "/BgIconAccessories")
	self.textName = UIControls.Label(self, self.mPath .. "/NameText")
end

function SpecialTypeMaterialCell:initData(materialData)
	self.textName:setText(materialData.name)

	if materialData.icon_path then
		self.imgMaterial:setImage("Atlas/" .. materialData.icon_path, materialData.coin)
	end
end

function SpecialTypeMaterialCell:setNum(num)
	self.textNum:setText("x" .. num)
end

local MAX_TYPE_NUM = 4
local ActivityValentineHandBookCell = Class("ActivityValentineHandBookCell", UIControls.Child)

function ActivityValentineHandBookCell:ctor()
	self.materialCells = {}

	for index = 1, MAX_TYPE_NUM do
		local newCell = SpecialTypeMaterialCell(self, "SeasoningGroup/SeasoningBtn0" .. index)

		table.insert(self.materialCells, newCell)
	end

	self.gridAward = UIControls.getGridContainer(self, "GridAward")
	self.btnQuickMake = UIControls.Button(self, "BtnConfirm")

	self.btnQuickMake:addEventClick(self.onQuickMakeClick)

	self.imgNew = UIControls.Panel(self, "NewNode")
	self.panelLock = UIControls.Panel(self, "LockNode")

	local mInfos = self.mParent.miscData.material

	for index, cell in ipairs(self.materialCells) do
		if mInfos[index] then
			cell:setVisible(true)
			cell:initData(mInfos[index])
		else
			cell:setVisible(false)
		end
	end
end

function ActivityValentineHandBookCell:onQuickMakeClick()
	local activityValentineMakeDlg = UIManager.tryGetUI("activityValentineMakeDlg")

	if activityValentineMakeDlg and activityValentineMakeDlg:onQuickMake(self.formulaData.material) then
		self.mParent:setVisible(false)
	end
end

function ActivityValentineHandBookCell:showFormulaData()
	local awardId = self.formulaData.gift_id
	local clientItem = BaseObject.GetObject(awardId, 1)

	self.gridAward:setObj(clientItem)

	local nums = self.formulaData.material

	for index, cell in ipairs(self.materialCells) do
		if nums[index] then
			cell:setNum(nums[index].num)
		end
	end
end

function ActivityValentineHandBookCell:setData(formulaData, hasGet, hasShown)
	self.formulaData = formulaData

	if hasGet then
		self.gridAward:setVisible(true)
		self.btnQuickMake:setVisible(true)
		self.panelLock:setVisible(false)
		self:showFormulaData()

		if not hasShown then
			self.imgNew:setVisible(true)
		else
			self.imgNew:setVisible(false)
		end
	else
		self.gridAward:setVisible(false)
		self.panelLock:setVisible(true)
		self.btnQuickMake:setVisible(false)
		self.imgNew:setVisible(false)

		for index, cell in ipairs(self.materialCells) do
			cell:setNum("?")
		end
	end
end

local strClassName = "ActivityValentineHandBookDlg"
local ActivityValentineHandBookDlg = Class(strClassName, UIControls.Window)

function ActivityValentineHandBookDlg:ctor()
	self:initUI()
end

function ActivityValentineHandBookDlg:initUI()
	self.textNmlNotice = UIControls.Label(self, "")
	self.specialCells = {}
end

function ActivityValentineHandBookDlg:setData(actObj)
	self.actObj = actObj
	self.miscData = self.actObj.actData.miscData
	self.replaceableCellPath = self.actObj.clientTemplateData.src_replace or {}
	self.cellPath = "System/Activity/ActivityCookValentine/RecipeCell"

	if self.replaceableCellPath and self.replaceableCellPath[1] then
		self.cellPath = "System/Activity/" .. self.replaceableCellPath[1] .. "/RecipeCell"
	end

	self.nmlDropId = self.miscData.extra_gift_id

	local clientItem = BaseObject.GetObject(self.nmlDropId, 1)

	self.gridNormal = UIControls.getGridChild(clientItem, self, "OrdinaryRecipe/GridAward")

	self.gridNormal:setVisible(true)
	self.gridNormal:setObj(clientItem)
	self.textNmlNotice:setText(self.miscData.normal_notice or "")

	local clientActCachedData = CurAvatar:getClientActivityCachedData(self.actObj.opId)
	local handBookRecord = clientActCachedData.handBook or {}

	self.formulaData = self.actObj.actData.formulaData
	self.hasGetSpeGift = self.actObj.actData:getHasGetGift()

	for index = 1, #self.miscData.choclateItemList do
		local itId = self.miscData.choclateItemList[index]
		local itFormData = self.formulaData[itId]

		if itFormData and not itFormData.is_normal then
			local newCell = ActivityValentineHandBookCell(self, "SpecialRecipe/Content", self.cellPath, 0, 0, true)

			table.insert(self.specialCells, newCell)
			newCell:setData(self.formulaData[itId], self.hasGetSpeGift[itId], handBookRecord[itId])
		end
	end

	self.actObj.actData:saveHandBookNew()
end

return ActivityValentineHandBookDlg
