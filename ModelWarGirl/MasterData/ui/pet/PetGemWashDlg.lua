-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Pet\\PetGemWashDlg.lua

local ResColor = require("ClientData/ResColor")
local PetGemInfoPart = require("UI/Pet/PetGemInfoPart")
local EventConst = require("EventConst")
local PetGemWashDlg = Class("PetGemWashDlg", UIControls.Window)

function PetGemWashDlg:ctor()
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onClickBtnClose)

	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)

	self.btnConfirm = UIControls.Button(self, "BgPanel/BtnLvUpFast")

	self.btnConfirm:addEventClick(self.onClickBtnConfirm, 0.5)

	self.btnCostItem = UIControls.Button(self, "BgPanel/Expend")

	self.btnCostItem:addEventClick(self.onClickBtnCostItem)

	self.costPanel = UIControls.Panel(self, "BgPanel/Expend")
	self.imgCostIcon = UIControls.Image(self, "BgPanel/Expend/ItemImg")
	self.txtCostNum = UIControls.Label(self, "BgPanel/Expend/TextNum")
	self.gemInfoPart = PetGemInfoPart(self, "BgPanel/GemInfoPanel/AttrPanel")
	self.noSelectPanel = UIControls.Panel(self, "BgPanel/GemInfoPanel/NothingNode")
	self.addPanel = UIControls.Panel(self, "BgPanel/GemItemPanel/AddNode")
	self.gemCell = UIControls.GridPetGemChild(self, "BgPanel/GemItemPanel/ItemNode", "System/Pet/GridPetGem")
	self.loopV = UIControls.ScrollViewLoopV(self, "BgPanel/BgItemList/PetGemListWearPanel", 0, self.onCellChange)
	self.emptyRaycast = UIControls.Panel(self, "EmptyRaycast")
	self.slotOnClickGemCell = Slot(self.onClickGemCell, self)
	self.gemCell.mEventClick = self.slotOnClickGemCell
	self.slotOnClickCell = Slot(self.onClickCell, self)
	self.curSelectData = nil
	self.curSelectCell = nil
	self.changeType = Const.PET_GEM_RERAND_ATTR_TYPE_SUB
	self.slotOnUIClose = Slot(self.onUIClose, self)
end

function PetGemWashDlg:onOpen()
	PetGemWashDlg.super.onOpen(self)
	EventCenter.addEventListener(EventConst.UI_CLOSE, self.slotOnUIClose)
	self:refreshGemList()
	self:refreshLoopV()
	self:refreshSelectRes()
	self.emptyRaycast:setVisible(false)
end

function PetGemWashDlg:onClose()
	PetGemWashDlg.super.onClose(self)
	EventCenter.removeEventListener(EventConst.UI_CLOSE, self.slotOnUIClose)
end

function PetGemWashDlg:setData(gemData, checkDuelPetGemCache)
	self.curSelectData = gemData

	self:refreshLoopV()
	self:refreshSelectRes()

	if not checkDuelPetGemCache then
		self:duelPetGemChangeCache()
	end
end

function PetGemWashDlg:refreshGemList()
	local list = CurAvatar:getAllPetGemList()

	self.dataList = {}

	for _, data in pairs(list) do
		if CurAvatar:checkPetGemCanWash(data) then
			table.insert(self.dataList, data)
		end
	end

	table.sort(self.dataList, function(a, b)
		if a.level ~= b.level then
			return a.level > b.level
		elseif a.inWearing and not b.inWearing then
			return true
		elseif not a.inWearing and b.inWearing then
			return false
		else
			return a:getMainAttr().attr_id > b:getMainAttr().attr_id
		end
	end)
end

function PetGemWashDlg:refreshLoopV()
	self.curSelectCell = nil

	self.loopV:setTotalCount(#self.dataList)
end

function PetGemWashDlg:onCellChange(sender, cell, idx)
	if not cell then
		cell = UIControls.GridPetGemLoop(sender, "System/Pet/GridPetGem", idx)
		cell.mEventClick = self.slotOnClickCell
	end

	if idx > 0 and idx <= #self.dataList then
		local data = self.dataList[idx]

		cell:setObj(data)

		local checkSelect = data ~= nil and data == self.curSelectData

		cell:setSelect(checkSelect)

		if checkSelect then
			self.curSelectCell = cell
		end
	end
end

function PetGemWashDlg:onClickCell(cell)
	local data = cell.gem

	if data == nil then
		return
	end

	if self.curSelectData and self.curSelectData.gid == data.gid then
		cell:setSelect(false)

		self.curSelectData = nil
		self.curSelectCell = nil
	else
		if self.curSelectData and self.curSelectCell and self.curSelectCell.gem and self.curSelectCell.gem.gid == self.curSelectData.gid then
			self.curSelectCell:setSelect(false)
		end

		cell:setSelect(true)

		self.curSelectData = data
		self.curSelectCell = cell
	end

	self:refreshSelectRes()
end

function PetGemWashDlg:onClickGemCell()
	if self.curSelectData then
		if self.curSelectCell and self.curSelectCell.gem and self.curSelectCell.gem.gid == self.curSelectData.gid then
			self.curSelectCell:setSelect(false)
		end

		self.curSelectData = nil
		self.curSelectCell = nil

		self:refreshSelectRes()
	end
end

function PetGemWashDlg:refreshSelectRes()
	local checkData = self.curSelectData ~= nil

	self.gemCell:setVisible(checkData)
	self.addPanel:setVisible(not checkData)
	self.gemInfoPart:setVisible(checkData)
	self.noSelectPanel:setVisible(not checkData)
	self.costPanel:setVisible(checkData)

	self.checkCostEnough = false
	self.costItem = nil

	if checkData then
		self.gemCell:setObj(self.curSelectData)

		local config = self.curSelectData.resData

		if config then
			local costItemId = config.gem_cleanup_item
			local costItemNum = config.cleanup_cost_item_num

			self.costItem = BaseObject.GetObject(costItemId)

			local iconPath = self.costItem:getIconPath()

			if iconPath and #iconPath == 2 then
				self.imgCostIcon:setImage(iconPath[1], iconPath[2])
			end

			local curItemNum = CurAvatar:getItemNumById(costItemId)

			self.checkCostEnough = costItemNum <= curItemNum

			self.txtCostNum:setFontColor(self.checkCostEnough and ResColor.WHITE or ResColor.RED)
			self.txtCostNum:setText(costItemNum .. "/" .. curItemNum)
		end

		self.gemInfoPart:setData(self.curSelectData)
	end
end

function PetGemWashDlg:duelPetGemChangeCache()
	if CurAvatar.petGemSubAttrCache then
		local gid = CurAvatar.petGemSubAttrCache.gid
		local gem = CurAvatar.petGemDic[gid]

		if gem then
			local function cb()
				local attrList = CurAvatar.petGemSubAttrCache.attr
				local attrs = {}

				for i = 1, #attrList do
					local attr = attrList[i]

					table.insert(attrs, attr.attr_id)
				end

				local resUi = UIManager.getUI("petGemChangeShowDlg", true)

				if resUi then
					resUi:setData(gid, Const.PET_GEM_RERAND_ATTR_TYPE_SUB, attrs)
				end
			end

			UIManager.showConfirmWithId(1091, cb)
		end
	end
end

function PetGemWashDlg:onClickBtnConfirm()
	if not self.curSelectData then
		MsgManager.clientNotice(720)

		return
	end

	if not self.checkCostEnough then
		MsgManager.clientNotice(719)

		return
	end

	RPC.petGemRerandAttribute(self.changeType, self.curSelectData.gid)
end

function PetGemWashDlg:onClickBtnClose()
	self:setVisible(false)
end

function PetGemWashDlg:onClickBtnCostItem()
	if self.costItem then
		UIManager.getUI("itemTips"):showObj(self, self.costItem)
	end
end

function PetGemWashDlg:onBtnTipsClick()
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_PET_PET_GEM_WASH)
end

function PetGemWashDlg:onPetGemRerandAttributeResp(gid, attrs)
	self.emptyRaycast:setVisible(true)

	local function cb()
		self.emptyRaycast:setVisible(false)

		local ui = UIManager.getUI("petGemChangeShowDlg", true)

		if ui then
			ui:setData(gid, self.changeType, attrs)
		end
	end

	self:playAni("ShowGemChange01", cb)
end

function PetGemWashDlg:onUIClose(uiName)
	if self.curSelectData and uiName == "petGemChangeShowDlg" then
		self:playAni("ShowGemChange02")
		self:refreshSelectRes()

		if self.curSelectCell and self.curSelectCell.gem and self.curSelectCell.gem.gid == self.curSelectData.gid then
			self.curSelectCell:setObj(self.curSelectData)
		end
	end
end

return PetGemWashDlg
