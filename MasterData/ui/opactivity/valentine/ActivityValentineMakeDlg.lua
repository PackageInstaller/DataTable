-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\Valentine\\ActivityValentineMakeDlg.lua

local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local ActivityValentineTypeSelectCell = Class("ActivityValentineTypeSelectCell", UIControls.Panel)

function ActivityValentineTypeSelectCell:ctor()
	self.btnSelect = UIControls.Button(self, self.mPath .. "/Btn")

	self.btnSelect:addEventClick(self.onSelectClick)

	self.imgMaterial = UIControls.Image(self, self.mPath .. "/BgIconAccessories")
	self.textNum = UIControls.Label(self, self.mPath .. "/NumText")
	self.textName = UIControls.Label(self, self.mPath .. "/NameText")
	self.btnClear = UIControls.Button(self, self.mPath .. "/BtnReturn")

	self.btnClear:addEventClick(self.onClearClick)
	self:setCount(0)
end

function ActivityValentineTypeSelectCell:initData(materialData)
	self.textName:setText(materialData.name)

	if materialData.icon_path then
		self.imgMaterial:setImage("Atlas/" .. materialData.icon_path, materialData.coin)
	end
end

function ActivityValentineTypeSelectCell:onSelectClick()
	self.mParent:onAddClick(self)
end

function ActivityValentineTypeSelectCell:setCount(count)
	self.nowCount = count

	self.textNum:setText(count)
	self.btnClear:setVisible(self.nowCount > 0)
end

function ActivityValentineTypeSelectCell:onClearClick(sender)
	self.mParent:onClearCell(self)
end

local MAX_TYPE_NUM = 4
local strClassName = "ActivityValentineMakeDlg"
local ActivityValentineMakeDlg = Class(strClassName, UIControls.Window)

MixinClass(ActivityValentineMakeDlg, ActivityPanelMixin)

function ActivityValentineMakeDlg:initUI()
	self.btnClose = UIControls.Button(self, "MacktMainPanel/CloseBtn")

	self.btnClose:addEventClick(self.onBtnClose)

	self.btnMake = UIControls.Button(self, "MacktMainPanel/BtnConfirm")

	self.btnMake:addEventClick(self.onMakeClick)

	self.newMake = UIControls.Panel(self, "MacktMainPanel/BtnConfirm/IconNew")
	self.textMake = UIControls.Label(self, "MacktMainPanel/BtnConfirm/ExpendNode")
	self.btnHandBook = UIControls.Button(self, "MacktMainPanel/BtnRecipe")

	self.btnHandBook:addEventClick(self.onHandBookClick)

	self.imgNewHandBook = UIControls.Panel(self, "MacktMainPanel/BtnRecipe/IconNew")
	self.typeCells = {}

	for index = 1, MAX_TYPE_NUM do
		local newCell = ActivityValentineTypeSelectCell(self, "MacktMainPanel/SeasoningGroup/SeasoningBtn0" .. index)

		table.insert(self.typeCells, newCell)
	end

	self.miscData = self.actObj.actData.miscData or {}
	self.makeCostId = self.miscData.make_cost_id
	self.makeCostNum = self.miscData.make_cost_num
	self.material = self.miscData.material

	for index, cell in ipairs(self.typeCells) do
		if self.material[index] then
			cell:setVisible(true)
			cell:initData(self.material[index])
		else
			cell:setVisible(false)
		end
	end

	self.totalMaxNum = self.miscData.material_total_limit
	self.singleMaxNum = self.miscData.material_single_limit
	self.cellPath = "System/Activity/ActivityCookValentine/MaclkLodingPanel"

	if self.replaceableCellPath and self.replaceableCellPath[1] then
		self.cellPath = "System/Activity/" .. self.replaceableCellPath[1] .. "/MaclkLodingPanel"
	end

	self.panelMakeAnim = UIControls.Child(self, "LoadingPanel", self.cellPath)

	self.panelMakeAnim:setVisible(false)

	self.curNum = 0
end

function ActivityValentineMakeDlg:onMakeClick()
	if self.curNum <= 0 then
		MsgManager.clientNotice(self.miscData.no_material_notice)

		return
	end

	local material_num = {}

	for index, cell in ipairs(self.typeCells) do
		table.insert(material_num, cell.nowCount or 0)
	end

	self.panelMakeAnim:setVisible(true)
	self.panelMakeAnim:playAni("ShowMack", Slot(self.onMakeAnimOver, self), true)

	self.cachedResult = nil
	self.making = true
	self.material_num = material_num
	self.preGetState = self.actObj.actData.hasGetItem

	RPC.opActChatGameMakeChocolete(self.actObj.opId, material_num)
end

function ActivityValentineMakeDlg:onMakeAnimOver()
	self.panelMakeAnim:setVisible(false)

	self.making = false

	if self.cachedResult then
		UIManager.getUI("activityValentineMakeResultDlg", true):setData(self.actObj, self.cachedResult, self.preGetState)
	end
end

function ActivityValentineMakeDlg:onOpActChatGameMakeChocoleteResp(opId, gift_id, materials)
	self.cachedResult = {
		materials,
		gift_id
	}

	if not self.making then
		self:onMakeAnimOver()
	end
end

function ActivityValentineMakeDlg:onAddClick(sender)
	if sender.nowCount >= self.singleMaxNum or self.curNum >= self.totalMaxNum then
		MsgManager.clientNotice(self.miscData.max_material_notice)

		return
	end

	self.curNum = self.curNum + 1

	sender:setCount(sender.nowCount + 1)
end

function ActivityValentineMakeDlg:onHandBookClick(sender)
	local activityValentineHandBookDlg = UIManager.getUI("activityValentineHandBookDlg", true)

	activityValentineHandBookDlg:setData(self.actObj)
	activityValentineHandBookDlg:bindWindow(self)
end

function ActivityValentineMakeDlg:_setData()
	self:refreshData()
end

function ActivityValentineMakeDlg:onClearCell(cell)
	self.curNum = self.curNum - cell.nowCount

	cell:setCount(0)
end

function ActivityValentineMakeDlg:refreshData()
	local actData = self.actObj.actData

	if actData:checkHandBookNew() then
		self.imgNewHandBook:setVisible(true)
	else
		self.imgNewHandBook:setVisible(false)
	end

	self.hasNum = CurAvatar:getItemNumById(self.makeCostId)

	self.textMake:setText(self.hasNum .. "/" .. self.makeCostNum)

	if self.hasNum < self.makeCostNum then
		self.textMake:setFontColor(ResColor.RED)
		self.btnMake:setEnable(false)
		self.newMake:setVisible(false)
	else
		self.textMake:setFontColor(ResColor.WHITE)
		self.btnMake:setEnable(true)
		self.newMake:setVisible(true)
	end
end

function ActivityValentineMakeDlg:updateActivityData()
	self:refreshData()
end

function ActivityValentineMakeDlg:onSaveHandBook()
	if self.actObj.actData:checkHandBookNew() then
		self.imgNewHandBook:setVisible(true)
	else
		self.imgNewHandBook:setVisible(false)
	end
end

function ActivityValentineMakeDlg:onBtnClose()
	self:setVisible(false)
end

function ActivityValentineMakeDlg:onQuickMake(material)
	if self.hasNum < self.makeCostNum then
		MsgManager.clientNotice(self.miscData.quick_make_notice)

		return false
	else
		self.curNum = 0

		for index, cell in ipairs(self.typeCells) do
			if material[index] then
				local num = material[index].num

				cell:setCount(num)

				self.curNum = self.curNum + num
			end
		end

		self:onMakeClick()

		return true
	end
end

function ActivityValentineMakeDlg:setByGift(itemId)
	local formData = self.actObj.actData.formulaData

	if formData and formData[itemId] then
		local material = formData[itemId].material

		self.curNum = 0

		for index, cell in ipairs(self.typeCells) do
			if material[index] then
				local num = material[index].num

				cell:setCount(num)

				self.curNum = self.curNum + num
			end
		end
	end
end

return ActivityValentineMakeDlg
