-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Pet\\PetGemLvUpDlg.lua

local UserData = require("Helper/UserData")
local PetGemInfoPart = require("UI/Pet/PetGemInfoPart")
local ResPetGem = require("ClientData/ResPetGem")
local ResColor = require("ClientData/ResColor")
local GemRandomInfoPanel = require("UI/Pet/GemRandomInfoPanel")
local strClassName = "PetGemLvUpDlg"
local PetGemLvUpDlg = Class(strClassName, UIControls.Window)

function PetGemLvUpDlg:ctor()
	self:initUI()
end

function PetGemLvUpDlg:initUI()
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)

	self.aniSelf = UIControls.UIAni(self, "")

	self.aniSelf:addEventFinish(self.aniFinishCallBack)

	self.petGemListScroll = UIControls.ScrollViewLoopV(self, "MainInfoPanel/BgItemList/PetGemListWearPanel")

	self.petGemListScroll:addEventCellChanged(self.onGemListChanged)

	self.noContent = UIControls.Panel(self, "MainInfoPanel/BgItemList/PetGemListWearPanel/NoContent")
	self.btnConfirm = UIControls.Button(self, "MainInfoPanel/LvUpNode/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)

	self.btnReset = UIControls.Button(self, "MainInfoPanel/LvUpNode/BtnReset")

	self.btnReset:addEventClick(self.onBtnResetClick)

	self.btnToggle = UIControls.Toggle(self, "MainInfoPanel/LvUpNode/BeforePanel/BtnToggle")

	self.btnToggle:addEventValueChanged(self.onToggleChange)

	self.btnMainInfo = UIControls.Button(self, "MainInfoPanel/LvUpNode/BeforePanel/BtnInfo")

	self.btnMainInfo:addEventClick(self.onBtnMainInfoClick)

	self.btnSub1Info = UIControls.Button(self, "MainInfoPanel/LvUpNode/MaterialPanel1/BtnInfo")

	self.btnSub1Info:addEventClick(self.onBtnSub1InfoClick)

	self.btnSub2Info = UIControls.Button(self, "MainInfoPanel/LvUpNode/MaterialPanel2/BtnInfo")

	self.btnSub2Info:addEventClick(self.onBtnSub2InfoClick)

	self.imgConsume = UIControls.Image(self, "MainInfoPanel/LvUpNode/BtnConfirm/ImgConsume")
	self.textCostNum = UIControls.Label(self, "MainInfoPanel/LvUpNode/BtnConfirm/ImgConsume/TextNum")
	self.gemInfoPart = PetGemInfoPart(self, "MainInfoPanel/LvUpNode/AttrPanel")
	self.attrPanel = UIControls.Panel(self, "MainInfoPanel/LvUpNode/AttrPanel")
	self.btnLvUpFast = UIControls.Button(self, "MainInfoPanel/BgItemList/BtnLvUpFast")

	self.btnLvUpFast:addEventClick(self.onBtnLvUpFastClick)

	self.btnLvUpFast02 = UIControls.Button(self, "MainInfoPanel/BgItemList/BtnLvUpFast02")

	self.btnLvUpFast02:addEventClick(self.onBtnLvUpFast02Click)

	self.btnInfo = UIControls.Button(self, "MainInfoPanel/BtnInfo")

	self.btnInfo:addEventClick(self.onBtnInfoClick)

	self.randomPanel = UIControls.Panel(self, "MainInfoPanel/Random")
	self.uIClickThrough = UIControls.Button(self, "MainInfoPanel/Random/UIClickThrough")

	self.uIClickThrough:addEventClick(self.onUIClickThroughClick)

	self.gemRandomInfo = GemRandomInfoPanel(self, "MainInfoPanel/Random/RandomInfoPanel")
	self.cells = {}
end

function PetGemLvUpDlg:setData(gem)
	self.mainGem = gem

	self:refreshGemListPanel()
	self:refreshLvUpInfoPanel()
end

function PetGemLvUpDlg:refreshGemListPanel()
	self.gemList = CurAvatar:getAllCanLvUpPetGemList()

	table.sort(self.gemList, function(a, b)
		if a.level ~= b.level then
			return a.level > b.level
		else
			return a.id > b.id
		end
	end)
	self.noContent:setVisible(#self.gemList == 0)
	self.petGemListScroll:setTotalCount(#self.gemList)

	self.fastGemGroup = CurAvatar:getFastLvUpGemList()

	self.btnLvUpFast:setVisible(#self.fastGemGroup > 1)
	self.btnLvUpFast02:setVisible(CurAvatar:checkShowLvUpAdvanceBtn())
end

function PetGemLvUpDlg:refreshLvUpInfoPanel()
	if self.mainGem and not self.mainGem:isMaxLevel() then
		if self.mainGemGrid == nil then
			self.mainGemGrid = UIControls.GridPetGemChild(self, "MainInfoPanel/LvUpNode/BeforePanel", "System/Pet/GridPetGem", 0, 0, true)
		end

		self.mainGemGrid:setObj(self.mainGem)

		self.mainGemGrid.mEventClick = Slot(self.cancelItemClick, self)

		self.btnMainInfo:setVisible(true)

		if self.previewGrid == nil then
			self.previewGrid = UIControls.GridPetGemChild(self, "MainInfoPanel/LvUpNode/AfterPanel", "System/Pet/GridPetGem", 0, 0, true)
		end

		local fakeGem = self.mainGem:getNextLevelGem()

		self.previewGrid:setObj(fakeGem)
		self.previewGrid:setGridClickEnable(false)
		self.btnToggle:setVisible(ResPetGem[self.mainGem.id].lock_cost_item_id ~= nil)
		self.btnInfo:setVisible(true)
		self.gemRandomInfo:setData(fakeGem)
	else
		self.mainGem = nil

		if self.mainGemGrid then
			self.mainGemGrid:destroy()

			self.mainGemGrid = nil
		end

		if self.previewGrid then
			self.previewGrid:destroy()

			self.previewGrid = nil
		end

		self.btnMainInfo:setVisible(false)
		self.btnInfo:setVisible(false)
	end

	if self.selectSubGem1 then
		if self.selectSubGem1Grid == nil then
			self.selectSubGem1Grid = UIControls.GridPetGemChild(self, "MainInfoPanel/LvUpNode/MaterialPanel1", "System/Pet/GridPetGem", 0, 0, true)
		end

		self.selectSubGem1Grid:setObj(self.selectSubGem1)

		self.selectSubGem1Grid.mEventClick = Slot(self.cancelItemClick, self)

		self.btnSub1Info:setVisible(true)
	else
		if self.selectSubGem1Grid then
			self.selectSubGem1Grid:destroy()

			self.selectSubGem1Grid = nil
		end

		self.btnSub1Info:setVisible(false)
	end

	if self.selectSubGem2 then
		if self.selectSubGem2Grid == nil then
			self.selectSubGem2Grid = UIControls.GridPetGemChild(self, "MainInfoPanel/LvUpNode/MaterialPanel2", "System/Pet/GridPetGem", 0, 0, true)
		end

		self.selectSubGem2Grid:setObj(self.selectSubGem2)

		self.selectSubGem2Grid.mEventClick = Slot(self.cancelItemClick, self)

		self.btnSub2Info:setVisible(true)
	else
		if self.selectSubGem2Grid then
			self.selectSubGem2Grid:destroy()

			self.selectSubGem2Grid = nil
		end

		self.btnSub2Info:setVisible(false)
	end

	self:refreshCostInfo()
	self.btnConfirm:setEnable(self.mainGem ~= nil and self.selectSubGem1 ~= nil and self.selectSubGem2 ~= nil)
end

function PetGemLvUpDlg:refreshCostInfo()
	local isLockMainAttr = UserData.loadCommonData(CurAvatar.uid .. "GemLvUpLockMainAttr")

	if self.mainGem and ResPetGem[self.mainGem.id].lock_cost_item_id == nil then
		isLockMainAttr = "0"
	end

	if isLockMainAttr and isLockMainAttr == "1" then
		self.btnToggle:setOn(true)

		self.toggleIsOn = true

		if self.mainGem then
			if ResPetGem[self.mainGem.id].lock_cost_item_id then
				local costId = ResPetGem[self.mainGem.id].lock_cost_item_id
				local costNum = ResPetGem[self.mainGem.id].lock_cost_item_num
				local haveNum = CurAvatar:getItemNumById(costId)
				local itemIcon = BaseObject.getItemIconPath(costId)

				if itemIcon then
					self.imgConsume:setImage(itemIcon[1], itemIcon[2])
					self.imgConsume:setVisible(true)
					self.textCostNum:setText(costNum)
					self.textCostNum:setFontColor(costNum <= haveNum and ResColor.WHITE or ResColor.RED)
				end
			end

			local config = {
				showRandSub = true,
				showLvUpMain = true
			}

			self.gemInfoPart:setData(self.mainGem, config)
			self.attrPanel:setVisible(true)

			if self.previewGrid then
				self.previewGrid:setGemIcon()
			end
		else
			self.imgConsume:setVisible(false)
			self.attrPanel:setVisible(false)
		end
	else
		self.btnToggle:setOn(false)

		self.toggleIsOn = false
		isLockMainAttr = "0"

		self.imgConsume:setVisible(false)
		UserData.saveCommonData(CurAvatar.uid .. "GemLvUpLockMainAttr", isLockMainAttr)

		if self.mainGem then
			local config = {
				showRandSub = true,
				showRandMain = true
			}

			self.gemInfoPart:setData(self.mainGem, config)
			self.attrPanel:setVisible(true)

			if self.previewGrid then
				self.previewGrid:setRandIcon()
			end
		else
			self.attrPanel:setVisible(false)
		end
	end
end

function PetGemLvUpDlg:onGemListChanged(sender, targetCell, newIdx)
	targetCell = targetCell or UIControls.GridPetGemLoop(sender, "System/Pet/GridPetGem", newIdx)

	if not self.gemList or #self.gemList == 0 then
		return
	end

	if self.gemList[newIdx] ~= nil then
		targetCell:setObj(self.gemList[newIdx])
		targetCell.imgSelect:setVisible(self.mainGem and self.mainGem.gid == self.gemList[newIdx].gid or self.selectSubGem1 and self.selectSubGem1.gid == self.gemList[newIdx].gid or self.selectSubGem2 and self.selectSubGem2.gid == self.gemList[newIdx].gid)

		targetCell.mEventClick = Slot(self.selectItemClick, self)

		if self.mainGem and self.mainGem.level ~= self.gemList[newIdx].level or self.selectSubGem1 and self.selectSubGem1.level ~= self.gemList[newIdx].level or self.selectSubGem2 and self.selectSubGem2.level ~= self.gemList[newIdx].level then
			targetCell:setGridClickEnable(false)

			if targetCell.imgLock then
				targetCell.imgLock:setVisible(true)
			end
		else
			targetCell:setGridClickEnable(true)

			if targetCell.imgLock then
				targetCell.imgLock:setVisible(false)
			end
		end
	end

	self.cells[newIdx] = targetCell
end

function PetGemLvUpDlg:cancelItemClick(cell)
	if self.mainGem and self.mainGem.gid == cell.object.gid then
		self.mainGem = nil
	elseif self.selectSubGem1 and self.selectSubGem1.gid == cell.object.gid then
		self.selectSubGem1 = nil
	elseif self.selectSubGem2 and self.selectSubGem2.gid == cell.object.gid then
		self.selectSubGem2 = nil
	end

	self:refreshLvUpInfoPanel()
	self.petGemListScroll:setTotalCount(#self.gemList)
end

function PetGemLvUpDlg:selectItemClick(cell)
	if cell.object:isMaxLevel() then
		MsgManager.notice(Lang.get(78297))

		return
	end

	if cell.imgSelect:getVisible() then
		self:cancelItemClick(cell)
	elseif cell.object.inWearing ~= nil and self.mainGem ~= nil then
		local msgContent = Lang.get(78298)

		UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(5), msgContent, Functor(self.confirmOffGem, self, cell.object))
	else
		self:realAddGem(cell.object)
	end
end

function PetGemLvUpDlg:confirmOffGem(gem)
	RPC.petGemInset(Const.PET_GEM_TYPE_OFF, gem.inWearing, 0, gem.gid)
	self:realAddGem(gem)
end

function PetGemLvUpDlg:realAddGem(gem)
	if self.mainGem == nil then
		self.mainGem = gem
	elseif self.selectSubGem1 == nil then
		self.selectSubGem1 = gem
	elseif self.selectSubGem2 == nil then
		self.selectSubGem2 = gem
	end

	self:refreshLvUpInfoPanel()
	self.petGemListScroll:setTotalCount(#self.gemList)
end

function PetGemLvUpDlg:autoAddGem()
	for i, gem in pairs(self.gemList) do
		if not self.mainGem or not self.selectSubGem1 or not self.selectSubGem2 then
			if self.mainGem then
				if self.mainGem.level == gem.level and gem:checkGemCanLevelUp() then
					if gem.inWearing ~= nil then
						RPC.petGemInset(Const.PET_GEM_TYPE_OFF, gem.inWearing, 0, gem.gid)
					end

					self:realAddGem(gem)
				end
			elseif gem:checkGemCanLevelUp() then
				self:realAddGem(gem)
			end
		else
			break
		end
	end
end

function PetGemLvUpDlg:refreshUI()
	if self.mainGem and CurAvatar.petGemDic[self.mainGem.gid] then
		self.mainGem = CurAvatar.petGemDic[self.mainGem.gid]
	else
		self.mainGem = nil
	end

	if self.selectSubGem1 and CurAvatar.petGemDic[self.selectSubGem1.gid] then
		self.selectSubGem1 = CurAvatar.petGemDic[self.selectSubGem1.gid]
	else
		self.selectSubGem1 = nil
	end

	if self.selectSubGem2 and CurAvatar.petGemDic[self.selectSubGem2.gid] then
		self.selectSubGem2 = CurAvatar.petGemDic[self.selectSubGem2.gid]
	else
		self.selectSubGem2 = nil
	end

	self:refreshLvUpInfoPanel()
	self:refreshGemListPanel()
end

function PetGemLvUpDlg:onBtnConfirmClick()
	if self.mainGem and self.selectSubGem1 and self.selectSubGem2 then
		local isLock = self.toggleIsOn and 1 or 0

		if self.toggleIsOn and ResPetGem[self.mainGem.id].lock_cost_item_id then
			local costId = ResPetGem[self.mainGem.id].lock_cost_item_id
			local costNum = ResPetGem[self.mainGem.id].lock_cost_item_num
			local haveNum = CurAvatar:getItemNumById(costId)

			if haveNum < costNum then
				local obj = BaseObject.GetObject(costId)

				MsgManager.notice(string.format(Lang.get(101577), obj.name))

				return
			end
		end

		if not self.toggleIsOn and self.mainGem.level >= 4 then
			local msgContent = Lang.get(78299)

			UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(5), msgContent, Slot(self._realConfirmLvUp, self), nil, -1)
		else
			self:_realConfirmLvUp()
		end
	end
end

function PetGemLvUpDlg:_realConfirmLvUp()
	local isLock = self.toggleIsOn and 1 or 0
	local data = {
		{
			main_gem_gid = self.mainGem.gid,
			main_attr_lock = isLock,
			add_gem_gid = {
				self.selectSubGem1.gid,
				self.selectSubGem2.gid
			}
		}
	}
	local gemNum = CurAvatar:getPetGemCount()

	RPC.petGemLevelUp(data, gemNum)
	self.btnConfirm:setEnable(false)
end

function PetGemLvUpDlg:onBtnResetClick()
	self.aniSelf:startAni("ShowPetGemReset", true)
end

function PetGemLvUpDlg:playLvUpAni(addGid)
	self.addGid = addGid

	self.aniSelf:startAni("ShowPetGemConfirm", true)
end

function PetGemLvUpDlg:aniFinishCallBack(aniCom, aniName)
	if aniName == "ShowPetGemConfirm" then
		local petGemLvUpShowDlg = UIManager.getUI("petGemLvUpShowDlg", true)

		petGemLvUpShowDlg:setData(self.addGid)

		self.addGid = nil

		self:refreshUI()
	elseif aniName == "ShowPetGemReset" then
		self.mainGem = nil
		self.selectSubGem1 = nil
		self.selectSubGem2 = nil

		self:refreshLvUpInfoPanel()
		self.petGemListScroll:setTotalCount(#self.gemList)
	end
end

function PetGemLvUpDlg:onToggleChange(sender, isOn)
	local isLockMainAttr = isOn == true and "1" or "0"

	self.toggleIsOn = isOn

	UserData.saveCommonData(CurAvatar.uid .. "GemLvUpLockMainAttr", isLockMainAttr)
	self:refreshCostInfo()
end

function PetGemLvUpDlg:onBtnMainInfoClick()
	if self.mainGem and self.mainGemGrid then
		local mTipsConfig = CurAvatar.commonGemTipsFuncItem
		local petGemTips = UIManager.getUI("petGemTips")

		petGemTips:show(self.mainGemGrid, mTipsConfig)
		petGemTips:setAllBtnVisible(false)
	end
end

function PetGemLvUpDlg:onBtnSub1InfoClick()
	if self.selectSubGem1 and self.selectSubGem1Grid then
		local mTipsConfig = CurAvatar.commonGemTipsFuncItem
		local petGemTips = UIManager.getUI("petGemTips")

		petGemTips:show(self.selectSubGem1Grid, mTipsConfig)
		petGemTips:setAllBtnVisible(false)
	end
end

function PetGemLvUpDlg:onBtnSub2InfoClick()
	if self.selectSubGem2 and self.selectSubGem2Grid then
		local mTipsConfig = CurAvatar.commonGemTipsFuncItem
		local petGemTips = UIManager.getUI("petGemTips")

		petGemTips:show(self.selectSubGem2Grid, mTipsConfig)
		petGemTips:setAllBtnVisible(false)
	end
end

function PetGemLvUpDlg:onBtnLvUpFastClick()
	local petGemLvUpFastDlg = UIManager.getUI("petGemLvUpFastDlg", true)

	petGemLvUpFastDlg:setData()
end

function PetGemLvUpDlg:onBtnLvUpFast02Click()
	local petGemLvUpAdDlg = UIManager.getUI("petGemLvUpAdDlg", true)

	petGemLvUpAdDlg:setData()
end

function PetGemLvUpDlg:onBtnInfoClick()
	self.randomPanel:setVisible(true)
end

function PetGemLvUpDlg:onUIClickThroughClick()
	self.randomPanel:setVisible(false)
end

function PetGemLvUpDlg:onBtnTipsClick()
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_PET_GEM_LV_UP)
end

function PetGemLvUpDlg:onBtnCloseClick()
	self:setVisible(false)
end

return PetGemLvUpDlg
