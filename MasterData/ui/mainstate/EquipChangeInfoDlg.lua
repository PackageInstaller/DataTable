-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\EquipChangeInfoDlg.lua

local EquipChangeListCell = require("UI/MainState/EquipChangeListCell")
local ConfirmPrivilegePanel = require("UI/Common/ConfirmPrivilegePanel")
local strClassName = "EquipChangeInfoDlg"
local EquipChangeInfoDlg = Class(strClassName, UIControls.Window)

function EquipChangeInfoDlg:ctor()
	self:initUI()
end

function EquipChangeInfoDlg:initUI()
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnConfirm = UIControls.Button(self, "BgPanel/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)

	self.btnThink = UIControls.Button(self, "BgPanel/BtnThink")

	self.btnThink:addEventClick(self.onBtnThinkClick)

	self.imgCostItem = UIControls.Image(self, "BgPanel/ExpendPanel/Icon")
	self.txtCostNum = UIControls.Label(self, "BgPanel/ExpendPanel/TxtNum")
	self.panelPrivilege = ConfirmPrivilegePanel(self, "BgPanel/PrivilegePanel")
	self.cells = {}
	self.scrollEquipChange = UIControls.ScrollViewLoopV(self, "BgPanel/EquipChangeList")

	self.scrollEquipChange:addEventCellChanged(self.onEquipChangeChanged)
end

function EquipChangeInfoDlg:onEquipChangeChanged(sender, targetCell, newIdx)
	targetCell = targetCell or EquipChangeListCell(sender, "System/Bag/EquipChangeListCell", newIdx)

	if not self.equipChangeInfoList or #self.equipChangeInfoList == 0 then
		return
	end

	if self.equipChangeInfoList[newIdx] ~= nil then
		targetCell:setEquipChangeInfo(self.equipChangeInfoList[newIdx], newIdx)
	end

	self.cells[newIdx] = targetCell
end

function EquipChangeInfoDlg:setEquipChangeInfoList(equipChangeInfoList, planData)
	self.equipChangeInfoList = equipChangeInfoList
	self.planData = planData

	self.scrollEquipChange:setTotalCount(#self.equipChangeInfoList)

	local offNeedInfo = self.equipChangeInfoList[1].equip:getOffMaterialNeed()
	local costId = offNeedInfo[1]
	local itemIcon = BaseObject.getItemIconPath(costId)

	if itemIcon then
		self.imgCostItem:setImage(itemIcon[1], itemIcon[2])
	end

	self.costNum = 0

	for _, equipChangeInfo in ipairs(self.equipChangeInfoList) do
		self.costNum = self.costNum + equipChangeInfo.equip:getOffMaterialNeed()[2]
	end

	self.txtCostNum:setText(ClientUtils.getNumShortStr(self.costNum))

	local color = ClientUtils.getMoney(costId) >= self.costNum and ResColor.WHITE or ResColor.RED

	self.txtCostNum:setFontColor(color)

	if RegionUtils.isCN() then
		local isLocked = ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_RECYCLESHOP)

		if not isLocked and not CurAvatar:privilegeIsValid(Const.EQUIP_OFF_PRIVILEGE_ID) then
			self.panelPrivilege:setVisible(true)
			self.panelPrivilege:setPrivilegeInfo(Const.EQUIP_OFF_PRIVILEGE_ID, CurAvatar.slotJumpToRecycleShop)
		else
			self.panelPrivilege:setVisible(false)
		end
	else
		self.panelPrivilege:setVisible(false)
	end
end

function EquipChangeInfoDlg:onBtnCloseClick()
	self:setVisible(false)
end

function EquipChangeInfoDlg:onBtnConfirmClick()
	if ClientUtils.getMoney(Const.MONEY_ID_GOLD) < self.costNum then
		local moneyInfo = UIConst.MONEY_ID2INFO[Const.MONEY_ID_GOLD]

		MsgManager.clientNotice(moneyInfo[4])

		return
	end

	if self.planData then
		RPC.equipSchemeApply(self.planData.id, CurAvatar.equipPlanVersion)
	end

	self:setVisible(false)
end

function EquipChangeInfoDlg:onBtnThinkClick()
	self:setVisible(false)
end

return EquipChangeInfoDlg
