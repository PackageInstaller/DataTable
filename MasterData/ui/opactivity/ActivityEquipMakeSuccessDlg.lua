-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityEquipMakeSuccessDlg.lua

local Equip = require("Common/Object/Equip")
local EquipAssistAttrCell = require("UI/Equip/EquipAssistAttrCell")
local strClassName = "ActivityEquipMakeSuccessDlg"
local ActivityEquipMakeSuccessDlg = Class(strClassName, UIControls.Window)

function ActivityEquipMakeSuccessDlg:ctor()
	self:initUI()
end

function ActivityEquipMakeSuccessDlg:initUI()
	self.customPanel = UIControls.Panel(self, "BgPanel/CustomPanel")
	self.washPanel = UIControls.Panel(self, "BgPanel/WashPanel")
	self.textName = UIControls.Label(self, "BgPanel/CustomPanel/TextName")
	self.textTitle = UIControls.Label(self, "BgPanel/TextTitle")
	self.textName2 = UIControls.Label(self, "BgPanel/WashPanel/TextName")
	self.assistCells = {}

	for i = 1, 4 do
		local cell = EquipAssistAttrCell(self, "BgPanel/WashPanel/AttrPanel/Attr0" .. i)

		table.insert(self.assistCells, cell)
	end
end

function ActivityEquipMakeSuccessDlg:onShow(type, equipInfo)
	if equipInfo then
		self.equip = Equip(equipInfo)

		local path

		if type == Const.EQUIP_REFINE_TYPE.Make then
			path = "BgPanel/CustomPanel/GridPanel"

			self.customPanel:setVisible(true)
			self.washPanel:setVisible(false)
			self.textName:setText(self.equip.name)
			self.textTitle:setText(Lang.get(89853))
		elseif type == Const.EQUIP_REFINE_TYPE.Reform then
			path = "BgPanel/WashPanel/GridPanel"

			self.customPanel:setVisible(false)
			self.washPanel:setVisible(true)
			self.textTitle:setText(Lang.get(89835))
			self.textName2:setText(self.equip.name)

			for index, cell in ipairs(self.assistCells) do
				local info = self.equip.assistProps[index]

				if info then
					cell:setVisible(true)
					cell:setAttr(info[1], info[2])
				else
					cell:setVisible(false)
				end
			end
		end

		if not self.gridEquip then
			self.gridEquip = UIControls.EquipGridChild(self, path, "System/Common/Grid/GridEquipItem", 0, 0, true)
		end

		self.gridEquip.mEnableTips = true
		self.gridEquip.inBag = true

		self.gridEquip:setObj(self.equip)
	else
		self:setVisible(false)
	end
end

function ActivityEquipMakeSuccessDlg:onClose(...)
	self.gridEquip:flyToCommonFuncEntryPanel()

	local activityEquipRefineDlg = UIManager.tryGetUI("activityEquipRefineDlg")

	if activityEquipRefineDlg then
		activityEquipRefineDlg:_setData()
	else
		local actObj = CurAvatar:getActivityObjByType(Const.ACT_TYPE_EQUIP_REFINE)

		if actObj and actObj:isValid() then
			CurAvatar:jumpToShowActivity(actObj.actId)
		end
	end

	local closeDlgNames = {
		"activityEquipMakeDlg",
		"activityEquipReformDlg"
	}

	for i, dlgName in pairs(closeDlgNames) do
		local dlg = UIManager.tryGetUI(dlgName)

		if dlg then
			dlg:setVisible(false)
		end
	end

	ActivityEquipMakeSuccessDlg.super.onClose(self)
end

return ActivityEquipMakeSuccessDlg
