-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\BtnCircleCell.lua

local strClassName = "BtnCircleCell"
local BtnCircleCell = Class(strClassName, UIControls.ScrollViewLoopCell)

function BtnCircleCell:ctor()
	self:initUI()
end

function BtnCircleCell:initUI()
	self.txtName = UIControls.Label(self, "TextName")
	self.txtLv = UIControls.Label(self, "TextLv")
	self.txtNum = UIControls.Label(self, "TextNum")
	self.btnApply = UIControls.Button(self, "BtnCircleCell/BtnApply", "Text")

	self.btnApply:addEventClick(self.onBtnApplyClick)
end

function BtnCircleCell:setCircleCellData(circle)
	self.circle = circle
	self.beApplyed = CurAvatar:isCircleApplyed(self.circle.gid)

	local txtBtnApply = self.beApplyed == true and Lang.get(30174) or Lang.get(774)

	self.btnApply:setText(txtBtnApply)
	self.txtName:setText(self.circle.name)
	self.txtLv:setText(string.format(Lang.get(30173), self.circle.level))
	self.txtNum:setText(self.circle.memberCount .. "/" .. self.circle:getCircleMaxMemberCount())

	self.gridCircle = UIControls.GridCircleCommonChild(self, "GridCircleCommon", "System/Common/Grid/GridCircleCommon", 0, 0, true)

	self.gridCircle:setCircle(self.circle)
end

function BtnCircleCell:onBtnApplyClick()
	if self.beApplyed then
		MsgManager.clientNotice(218)
	else
		local showCircleDlg = UIManager.getUI("showCircleDlg", true)
		local circle = CurAvatar:tryGetCircleDetailInfo(self.circle.gid)

		if circle then
			showCircleDlg:setCircle(circle)
		end
	end
end

return BtnCircleCell
