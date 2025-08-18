-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Pet\\PetGemLvUpAdDlg.lua

local ResPetGem = require("ClientData/ResPetGem")
local ResColor = require("ClientData/ResColor")
local PetGemFilterPanel = require("UI/Pet/PetGemFilterPanel")
local PetGemInfoPart = require("UI/Pet/PetGemInfoPart")
local strClassName = "BtnGemLvSelect"
local BtnGemLvSelect = Class(strClassName, UIControls.Child)

function BtnGemLvSelect:ctor()
	self.txtLv = UIControls.Label(self, "TxtLv")
	self.txtNumber = UIControls.Label(self, "TxtNumber")
	self.btnGemLvSelect = UIControls.Button(self, "")

	self.btnGemLvSelect:addEventClick(self.onBtnGemLvSelectClick)
end

function BtnGemLvSelect:setData(level)
	self.level = level
	self.gemLevelList = CurAvatar:getLvUpGemListByLevel(level)

	if Const.REVIEW_VERSION then
		self.txtLv:setText(string.format(Lang.get(80803), level))
	else
		self.txtLv:setText(string.format("Lv%d", level))
	end

	self.txtNumber:setText(string.format("(%d)", #self.gemLevelList))
end

function BtnGemLvSelect:onBtnGemLvSelectClick()
	self.mParent:selectGemLevel(self.level)
end

local strClassName = "PetGemLvUpAdCell"
local PetGemLvUpAdCell = Class(strClassName, UIControls.ScrollViewLoopCell)

function PetGemLvUpAdCell:ctor()
	self.missingPanel = UIControls.Panel(self, "AfterPanel/TextMissing")
	self.btnToggle = UIControls.Toggle(self, "BeforePanel/BtnToggle")

	self.btnToggle:addEventValueChanged(self.onClickToggle)
end

function PetGemLvUpAdCell:setData(gem, gemFood1, gemFood2, isLock)
	self.mainGem = gem
	self.subGem1 = gemFood1
	self.subGem2 = gemFood2
	self.lock = isLock == 1 and true or false

	if self.mainGemGrid == nil then
		self.mainGemGrid = UIControls.GridPetGemChild(self, "BeforePanel", "System/Pet/GridPetGem", 0, 0, true)
	end

	self.mainGemGrid:setObj(self.mainGem)

	self.mainGemGrid.mEventClick = Slot(self.onGemClick, self, self.mainGemGrid)

	self.mainGemGrid:setVisibleDelBtn(true)

	self.mainGemGrid.mEventDelClick = Slot(self.onMainGemDelClick, self)

	if self.subGem1 then
		if self.subGem1Grid == nil then
			self.subGem1Grid = UIControls.GridPetGemChild(self, "MaterialPanel1", "System/Pet/GridPetGem", 0, 0, true)
		end

		self.subGem1Grid:setObj(self.subGem1)

		self.subGem1Grid.mEventClick = Slot(self.onGemClick, self, self.subGem1Grid)
	elseif self.subGem1Grid then
		self.subGem1Grid:destroy()

		self.subGem1Grid = nil
	end

	if self.subGem2 then
		if self.subGem2Grid == nil then
			self.subGem2Grid = UIControls.GridPetGemChild(self, "MaterialPanel2", "System/Pet/GridPetGem", 0, 0, true)
		end

		self.subGem2Grid:setObj(self.subGem2)

		self.subGem2Grid.mEventClick = Slot(self.onGemClick, self, self.subGem2Grid)
	elseif self.subGem2Grid then
		self.subGem2Grid:destroy()

		self.subGem2Grid = nil
	end

	if self.subGem1 and self.subGem2 then
		self.missingPanel:setVisible(false)

		if self.previewGrid == nil then
			self.previewGrid = UIControls.GridPetGemChild(self, "AfterPanel", "System/Pet/GridPetGem", 0, 0, true)
		end

		if not self.mainGem:isMaxLevel() then
			self.fakeGem = self.mainGem:getNextLevelGem()

			self.previewGrid:setObj(self.fakeGem)

			self.previewGrid.mEventClick = Slot(self.onPreGemClick, self)

			if self.lock then
				self.previewGrid:setGemIcon()
			else
				self.previewGrid:setRandIcon()
			end
		end
	else
		self.missingPanel:setVisible(true)

		if self.previewGrid then
			self.previewGrid:destroy()

			self.previewGrid = nil
		end
	end

	self.isInit = true

	self.btnToggle:setOn(self.lock)

	self.isInit = false
end

function PetGemLvUpAdCell:onGemClick(gemGrid)
	local mTipsConfig = CurAvatar.commonGemTipsFuncItem
	local petGemTips = UIManager.getUI("petGemTips")

	petGemTips:show(gemGrid, mTipsConfig)
	petGemTips:setAllBtnVisible(false)
end

function PetGemLvUpAdCell:onPreGemClick()
	self.mParent:showPreGemInfo(self.mainGem, self.lock)
end

function PetGemLvUpAdCell:onMainGemDelClick()
	self.mParent:delAdGemCell(self.mainGem)
end

function PetGemLvUpAdCell:onClickToggle(sender, isOn)
	local isLock = isOn == true and 1 or 0

	self.lock = isOn

	for i, data in pairs(self.mParent.rpcData or {}) do
		if data.main_gem_gid == self.mainGem.gid then
			data.main_attr_lock = isLock

			break
		end
	end

	self.mParent.adGemDic[self.mainGem.gid].attrLock = isLock

	if isOn then
		if self.previewGrid then
			self.previewGrid:setGemIcon()

			if not self.isInit then
				self.mParent.costNum = self.mParent.costNum + ResPetGem[self.mainGem.id].lock_cost_item_num
			end
		end
	elseif self.previewGrid then
		self.previewGrid:setRandIcon()

		if not self.isInit then
			self.mParent.costNum = self.mParent.costNum - ResPetGem[self.mainGem.id].lock_cost_item_num
		end
	end

	self.mParent:refreshCostInfo()
end

local strClassName = "PetGemLvUpAdDlg"
local PetGemLvUpAdDlg = Class(strClassName, UIControls.Window)
local MAX_FILTER_LEVEL = 9

function PetGemLvUpAdDlg:ctor()
	self:initUI()
end

function PetGemLvUpAdDlg:initUI()
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnCloseFilter = UIControls.Button(self, "BgPanel/GemFilterPanel/BtnClose")

	self.btnCloseFilter:addEventClick(self.onBtnCloseFilterClick)

	self.btnClear = UIControls.Button(self, "BgPanel/BtnClear")

	self.btnClear:addEventClick(self.onBtnClearClick)

	self.btnChange = UIControls.Button(self, "BgPanel/GemLvSelect/BtnChange")

	self.btnChange:addEventClick(self.onBtnChangeClick)

	self.listPanel = UIControls.Panel(self, "BgPanel/GemLvSelect/ListPanel")
	self.txtLevelNum = UIControls.Label(self, "BgPanel/GemLvSelect/BtnChange/TxtNum")
	self.gemFilterPanel = PetGemFilterPanel(self, "BgPanel/GemFilterPanel")
	self.petGemListScroll = UIControls.ScrollViewLoopV(self, "BgPanel/ItemListScroll")

	self.petGemListScroll:addEventCellChanged(self.onGemListChanged)

	self.imgNone = UIControls.Image(self, "BgPanel/ItemListScroll/ImgNone")
	self.cells = {}
	self.levelCells = {}
	self.adCellScroll = UIControls.ScrollViewLoopV(self, "BgPanel/LvUpAdCellList")

	self.adCellScroll:addEventCellChanged(self.onAdCellListChanged)

	self.cellNone = UIControls.Panel(self, "BgPanel/LvUpAdCellList/ImgNone")
	self.adGemCells = {}
	self.btnFast01 = UIControls.Button(self, "BgPanel/BtnFast01")

	self.btnFast01:addEventClick(self.onBtnFast01Click)

	self.btnFast02 = UIControls.Button(self, "BgPanel/BtnFast02")

	self.btnFast02:addEventClick(self.onBtnFast02Click)

	self.gemInfoPanel = UIControls.Panel(self, "BgPanel/GemInfoPanel")
	self.uIClickThrough = UIControls.Button(self, "BgPanel/UIClickThrough")

	self.uIClickThrough:addEventClick(self.onUIClickThroughClick)

	self.gemInfoPart = PetGemInfoPart(self, "BgPanel/GemInfoPanel/AttrPanel")
	self.imgConsume = UIControls.Image(self, "BgPanel/BtnConfirm/ImgConsume")
	self.textCostNum = UIControls.Label(self, "BgPanel/BtnConfirm/ImgConsume/TextNum")
	self.btnConfirm = UIControls.Button(self, "BgPanel/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)
end

function PetGemLvUpAdDlg:setData()
	self.curLevel = Const.PET_GEM_FAST_LV_UP_MAX

	if Const.REVIEW_VERSION then
		self.txtLevelNum:setText(string.format(Lang.get(80803), self.curLevel))
	else
		self.txtLevelNum:setText(string.format("Lv%d", self.curLevel))
	end

	self.adGemList = {}
	self.adGemDic = {}
	self.gemList = CurAvatar:getLvUpGemListByLevel(self.curLevel)

	self:refreshLevelList()
	self:refreshGemAdCell()
	self:refreshGemListPanel()
end

function PetGemLvUpAdDlg:refreshLevelList()
	for i = Const.PET_GEM_FAST_LV_UP_MAX, MAX_FILTER_LEVEL do
		local cell = self.levelCells[i]

		if cell == nil then
			cell = BtnGemLvSelect(self, "BgPanel/GemLvSelect/ListPanel", "System/Pet/BtnGemLvSelect", 0, 0, true)
		end

		cell:setData(i)

		self.levelCells[i] = cell
	end
end

function PetGemLvUpAdDlg:onAdCellListChanged(sender, targetCell, newIdx)
	targetCell = targetCell or PetGemLvUpAdCell(sender, "System/Pet/PetGemLvUpAdCell", newIdx)

	if not self.adGemList or #self.adGemList == 0 then
		return
	end

	if self.adGemList[newIdx] ~= nil then
		local gemFood = self.adGemDic[self.adGemList[newIdx].gid].foodList or {}
		local isLock = self.adGemDic[self.adGemList[newIdx].gid].attrLock or 0

		targetCell:setData(self.adGemList[newIdx], gemFood[1], gemFood[2], isLock)
	end

	self.adGemCells[newIdx] = targetCell
end

function PetGemLvUpAdDlg:refreshGemAdCell()
	self.cellNone:setVisible(#self.adGemList == 0)
	self.btnClear:setVisible(#self.adGemList > 0)

	self.gemFoodDic = {}
	self.rpcData = {}
	self.costId, self.costNum = Const.MONEY_ID_DIAMOND, 0

	if #self.adGemList > 0 then
		for i, gem in ipairs(self.adGemList) do
			local gemFood1, gemFood2 = self:getGemFood(gem)
			local isLock = self.adGemDic[gem.gid].attrLock or 0

			if gemFood1 and gemFood2 then
				table.insert(self.rpcData, {
					main_gem_gid = gem.gid,
					main_attr_lock = isLock,
					add_gem_gid = {
						gemFood1.gid,
						gemFood2.gid
					}
				})

				if isLock == 1 then
					self.costId = ResPetGem[gem.id].lock_cost_item_id
					self.costNum = ResPetGem[gem.id].lock_cost_item_num + self.costNum
				end
			end
		end
	end

	self.adCellScroll:setTotalCount(#self.adGemList)
	self:refreshCostInfo()
end

function PetGemLvUpAdDlg:refreshCostInfo()
	local haveNum = CurAvatar:getItemNumById(self.costId)
	local itemIcon = BaseObject.getItemIconPath(self.costId)

	if self.costNum == 0 then
		self.imgConsume:setVisible(false)
		self.textCostNum:setVisible(false)
	elseif itemIcon then
		self.imgConsume:setImage(itemIcon[1], itemIcon[2])
		self.imgConsume:setVisible(true)
		self.textCostNum:setText(self.costNum)
		self.textCostNum:setFontColor(haveNum >= self.costNum and ResColor.WHITE or ResColor.RED)
		self.textCostNum:setVisible(true)
	end
end

function PetGemLvUpAdDlg:delAdGemCell(gem)
	for i, tmpGem in ipairs(self.adGemList) do
		if gem.gid == tmpGem.gid then
			table.remove(self.adGemList, i)

			self.adGemDic[gem.gid] = nil

			break
		end
	end

	self:refreshGemAdCell()
	self:refreshGemListPanel()
end

function PetGemLvUpAdDlg:getGemFood(mainGem)
	local gemFoodList = self.adGemDic[mainGem.gid].foodList or {}
	local gemFood1, gemFood2

	if gemFoodList[1] and not self.adGemDic[gemFoodList[1].gid] and not self.gemFoodDic[gemFoodList[1].gid] then
		gemFood1 = gemFoodList[1]
		self.gemFoodDic[gemFood1.gid] = gemFood1
	end

	if gemFoodList[2] and not self.adGemDic[gemFoodList[2].gid] and not self.gemFoodDic[gemFoodList[2].gid] then
		gemFood2 = gemFoodList[2]
		self.gemFoodDic[gemFood2.gid] = gemFood2
	end

	for i, gem in ipairs(self.gemList) do
		if gemFood1 == nil or gemFood2 == nil then
			if not self.adGemDic[gem.gid] and not self.gemFoodDic[gem.gid] then
				if gemFood1 == nil then
					gemFood1 = gem
					self.gemFoodDic[gemFood1.gid] = gemFood1
				elseif gemFood2 == nil then
					gemFood2 = gem
					self.gemFoodDic[gemFood2.gid] = gemFood2
				end
			end
		else
			break
		end
	end

	self.adGemDic[mainGem.gid].foodList = {
		gemFood1,
		gemFood2
	}

	return gemFood1, gemFood2
end

function PetGemLvUpAdDlg:getAllCanFilterGemList()
	local canFilterList = {}

	for i, gem in ipairs(self.gemList) do
		if not self.adGemDic[gem.gid] then
			table.insert(canFilterList, gem)
		end
	end

	return canFilterList
end

function PetGemLvUpAdDlg:finishFilter(filterList)
	self.gemFilterPanel:setVisible(false)

	for i, gem in ipairs(filterList) do
		if self.adGemDic[gem.gid] == nil then
			table.insert(self.adGemList, gem)

			self.adGemDic[gem.gid] = utils.deepcopy(gem)
		end
	end

	self:refreshGemAdCell()
	self:refreshGemListPanel()
end

function PetGemLvUpAdDlg:refreshGemListPanel()
	self.canFilterGemList = self:getAllCanFilterGemList()

	table.sort(self.canFilterGemList, function(a, b)
		local isFoodA = self.gemFoodDic[a.gid] == nil
		local isFoodB = self.gemFoodDic[b.gid] == nil

		if isFoodA ~= isFoodB then
			return isFoodA == true
		end
	end)
	self.imgNone:setVisible(#self.canFilterGemList == 0)
	self.petGemListScroll:setTotalCount(#self.canFilterGemList)
end

function PetGemLvUpAdDlg:onGemListChanged(sender, targetCell, newIdx)
	targetCell = targetCell or UIControls.GridPetGemLoop(sender, "System/Pet/GridPetGem", newIdx)

	if not self.canFilterGemList or #self.canFilterGemList == 0 then
		return
	end

	if self.canFilterGemList[newIdx] ~= nil then
		targetCell:setObj(self.canFilterGemList[newIdx])
		targetCell.imgSelect:setVisible(self.gemFoodDic[self.canFilterGemList[newIdx].gid] ~= nil)
		targetCell:setVisibleDelBtn(false)
	end

	self.cells[newIdx] = targetCell
end

function PetGemLvUpAdDlg:selectGemLevel(level)
	self.listPanel:setVisible(false)

	self.curLevel = level

	if Const.REVIEW_VERSION then
		self.txtLevelNum:setText(string.format(Lang.get(80803), self.curLevel))
	else
		self.txtLevelNum:setText(string.format("Lv%d", self.curLevel))
	end

	self.gemList = CurAvatar:getLvUpGemListByLevel(self.curLevel)

	self:onBtnClearClick()
end

function PetGemLvUpAdDlg:showPreGemInfo(mainGem, lock)
	local config = {
		showRandSub = true,
		showLvUpMain = true
	}

	if not lock then
		config = {
			showRandSub = true,
			showRandMain = true
		}
	end

	self.gemInfoPart:setData(mainGem, config)
	self.gemInfoPanel:setVisible(true)
	self.uIClickThrough:setVisible(true)
end

function PetGemLvUpAdDlg:refreshUI()
	for _, v in pairs(self.rpcData or {}) do
		for i, gem in pairs(self.adGemList) do
			if v.main_gem_gid == gem.gid then
				table.remove(self.adGemList, i)

				self.adGemDic[gem.gid] = nil

				break
			end
		end
	end

	self.gemList = CurAvatar:getLvUpGemListByLevel(self.curLevel)

	self:refreshLevelList()
	self:refreshGemAdCell()
	self:refreshGemListPanel()
end

function PetGemLvUpAdDlg:onBtnConfirmClick()
	local haveNum = CurAvatar:getItemNumById(self.costId)

	if haveNum < self.costNum then
		local obj = BaseObject.GetObject(self.costId)

		MsgManager.notice(string.format(Lang.get(101577), obj.name))

		return
	end

	if #self.rpcData == 0 then
		MsgManager.notice(Lang.get(101437))

		return
	end

	local gemNum = CurAvatar:getPetGemCount()

	RPC.petGemLevelUp(self.rpcData, gemNum)
end

function PetGemLvUpAdDlg:onBtnClearClick()
	self.gemFoodDic = {}
	self.adGemDic = {}
	self.adGemList = {}

	self:refreshGemAdCell()
	self:refreshGemListPanel()
end

function PetGemLvUpAdDlg:onBtnFast01Click()
	local canAdGemList = {}

	for i, gem in ipairs(self.gemList) do
		if not self.adGemDic[gem.gid] and not self.gemFoodDic[gem.gid] then
			table.insert(canAdGemList, gem)
		end
	end

	local canAdNum = math.floor(#canAdGemList / 3)

	if canAdNum > 0 then
		for i = 1, canAdNum do
			table.insert(self.adGemList, canAdGemList[i])

			self.adGemDic[canAdGemList[i].gid] = utils.deepcopy(canAdGemList[i])
		end
	end

	self:refreshGemAdCell()
	self:refreshGemListPanel()
end

function PetGemLvUpAdDlg:onBtnFast02Click()
	self.gemFilterPanel:setData(self.curLevel)
	self.gemFilterPanel:setVisible(true)
end

function PetGemLvUpAdDlg:onBtnChangeClick()
	self.listPanel:setVisible(true)
	self.uIClickThrough:setVisible(true)
end

function PetGemLvUpAdDlg:onUIClickThroughClick()
	self.gemInfoPanel:setVisible(false)
	self.uIClickThrough:setVisible(false)
	self.listPanel:setVisible(false)
end

function PetGemLvUpAdDlg:onBtnCloseFilterClick()
	self.gemFilterPanel:setVisible(false)
end

function PetGemLvUpAdDlg:onBtnCloseClick()
	self:setVisible(false)
end

return PetGemLvUpAdDlg
