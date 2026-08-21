-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\BtnWearingPlan.lua

local strClassName = "BtnWearingPlan"
local BtnWearingPlan = Class(strClassName, UIControls.ScrollViewLoopCell)

function BtnWearingPlan:ctor()
	self:initUI()
end

function BtnWearingPlan:initUI()
	self.txtEdit = UIControls.Panel(self, "TxtEdit")
	self.panelName = UIControls.Panel(self, "TxtName")
	self.txtName = UIControls.Label(self, "TxtName/Txt")
	self.imgLast = UIControls.Panel(self, "TxtName/ImgLast")
	self.iconNew = UIControls.Image(self, "TxtEdit/IconNew")
	self.btnSelf = UIControls.Button(self, "")

	self.btnSelf:addEventClick(self.onBtnSelfClick)
end

function BtnWearingPlan:setSelectCallback(selectCallback)
	self.selectCallback = selectCallback
end

function BtnWearingPlan:onBtnSelfClick()
	if self.plan and self.selectCallback then
		self.selectCallback(self)
	end
end

function BtnWearingPlan:setPlan(plan)
	self.plan = plan

	self.txtEdit:setVisible(self.plan.id == Const.EQUIP_PLAN_EDIT_ID)
	self.panelName:setVisible(self.plan.id ~= Const.EQUIP_PLAN_EDIT_ID)
	self.txtName:setText(self.plan.name)
	self.imgLast:setVisible(CurAvatar.lastUsePlanID == self.plan.id)

	local canWear = CurAvatar:checkHeroCanWearBetterEquip() or RedDotManager.getKeyState(UIConst.RD_HINT_BATTLE_PET_WEAR)

	self.iconNew:setVisible(canWear)
end

return BtnWearingPlan
