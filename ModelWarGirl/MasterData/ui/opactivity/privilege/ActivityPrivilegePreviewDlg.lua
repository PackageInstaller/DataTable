-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\Privilege\\ActivityPrivilegePreviewDlg.lua

local CommonPrivilegeCell = require("UI/OpActivity/Privilege/CommonPrivilegeCell")
local DebuffPrivilegeCell = require("UI/OpActivity/Privilege/DebuffPrivilegeCell")
local ProgressPrivilegeCell = require("UI/OpActivity/Privilege/ProgressPrivilegeCell")
local CELL_CLASS_DIC = {
	[Const.ACT_PRIVILEGE_TYPE_CELL_CLASS_COMMON] = CommonPrivilegeCell,
	[Const.ACT_PRIVILEGE_TYPE_CELL_CLASS_PROGRESS] = ProgressPrivilegeCell,
	[Const.ACT_PRIVILEGE_TYPE_CELL_CLASS_DEBUFF] = DebuffPrivilegeCell
}
local strClassName = "ActivityPrivilegePreviewDlg"
local ActivityPrivilegePreviewDlg = Class(strClassName, UIControls.Window)

function ActivityPrivilegePreviewDlg:ctor()
	self:initUI()
end

function ActivityPrivilegePreviewDlg:initUI()
	self.cells = {}

	self:onRefreshPrivilegeShow()
end

function ActivityPrivilegePreviewDlg:onRefreshPrivilegeShow()
	if self.cells and #self.cells > 0 then
		for idx, cell in ipairs(self.cells) do
			self.cells[idx]:destroy()

			self.cells[idx] = nil
		end
	end

	local privilegeInfoList = CurAvatar:getAllPrivilegeInfoList()

	for idx, privilegeInfo in ipairs(privilegeInfoList) do
		local CellClass = CELL_CLASS_DIC[privilegeInfo.resData.cell_class]

		self.cells[idx] = CellClass(self, "Bg/PrivilegeList/Viewport/Content", privilegeInfo.resData.prefab_path, 0, 0, true)

		self.cells[idx]:setPrivilegeInfo(privilegeInfo)
	end
end

return ActivityPrivilegePreviewDlg
