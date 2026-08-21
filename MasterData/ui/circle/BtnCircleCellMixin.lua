-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\BtnCircleCellMixin.lua

local BtnCircleCellMixin = {}

function BtnCircleCellMixin:ctorMixin()
	self:initUI()
end

function BtnCircleCellMixin:initUI()
	self.btnSelf = UIControls.Button(self, "")

	self.btnSelf:addEventClick(self.onBtnSelfClick)

	self.imgBg = UIControls.Image(self, "Bg")
	self.txtName = UIControls.Label(self, "TextName")
	self.txtLv = UIControls.Label(self, "TextLV")
	self.txtNum = UIControls.Label(self, "TextNum")
	self.txtActiveNum = UIControls.Label(self, "BtnActive/Text")
	self.btnApply = UIControls.Button(self, "BtnApply", "Text")

	self.btnApply:addEventClick(self.onBtnApplyClick)

	self.btnOpenActiveTips = UIControls.Button(self, "BtnActive")

	self.btnOpenActiveTips:addEventClick(self.onBtnOpenActiveTipsClick)

	self.imgIconActive = UIControls.Image(self, "BtnActive/IconActive")
end

function BtnCircleCellMixin:onBtnOpenActiveTipsClick()
	self.mWindow:openTipsActivePanel(self.imgIconActive)
end

function BtnCircleCellMixin:setCircleCellData(circle, hideApplyButton)
	self.circle = circle
	self.isShowMode = hideApplyButton
	self.beApplyed = CurAvatar:isCircleApplyed(self.circle.gid)

	local txtBtnApply = self.beApplyed and Lang.get(30174) or Lang.get(774)

	self.btnApply:setText(txtBtnApply)
	self.btnApply:setVisible(not self.isShowMode)
	self.txtName:setText(self.circle.name)
	self.txtLv:setText(string.format(Lang.get(30173), self.circle.level))
	self.txtActiveNum:setText(self.circle.weekExp)

	local bgPath = UIConst.CIRCLE_HEAD_BG_PATH[self.circle.headId]

	if bgPath then
		self.imgBg:setImage(bgPath[1], bgPath[2])
	end

	self.txtNum:setText(self.circle.memberCount .. "/" .. self.circle:getCircleMaxMemberCount())

	self.gridCircle = UIControls.GridCircleCommonChild(self, "GridCircleCommon", "System/Common/Grid/GridCircleCommon", 0, 0, true)

	self.gridCircle:setSelectCallback(Slot(self.onGridCircleClick, self))
	self.gridCircle:setCircle(self.circle)
end

function BtnCircleCellMixin:onGridCircleClick()
	self:_openShowCircle()
end

function BtnCircleCellMixin:onBtnSelfClick()
	self:_openShowCircle()
end

function BtnCircleCellMixin:_openShowCircle()
	local circle = CurAvatar:tryGetCircleDetailInfo(self.circle.gid)

	if circle or self.circle.gid == CurAvatar.circleRoleData.clangid then
		local showCircleDlg = UIManager.getUI("showCircleDlg", true)

		if circle then
			showCircleDlg:setCircle(circle)
		end
	end
end

function BtnCircleCellMixin:onBtnApplyClick()
	if self.circle.memberCount == self.circle:getCircleMaxMemberCount() then
		MsgManager.clientNotice(233)

		return
	end

	if self.beApplyed then
		MsgManager.clientNotice(218)
	elseif CurAvatar:isEnterCircleInCD() then
		MsgManager.clientNotice(202)
	else
		RPC.clanJoin(self.circle.gid)
	end
end

return BtnCircleCellMixin
