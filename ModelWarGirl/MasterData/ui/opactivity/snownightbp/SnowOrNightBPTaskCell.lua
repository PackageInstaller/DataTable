-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\SnowNightBP\\SnowOrNightBPTaskCell.lua

local strClassName = "SnowOrNightBPTaskCell"
local SnowOrNightBPTaskCell = Class(strClassName, UIControls.Child)

function SnowOrNightBPTaskCell:ctor()
	self:initUI()
end

function SnowOrNightBPTaskCell:initUI()
	self.slider = UIControls.Slider(self, "Slider")
	self.imgState = UIControls.Panel(self, "ImgState")
	self.btnGet = UIControls.Button(self, "BtnGet")

	self.btnGet:addEventClick(self.onBtnGetClick)

	self.textExp = UIControls.Label(self, "TextExp")
	self.panelSelf = UIControls.Panel(self, "")
	self.textRule = UIControls.Label(self, "TextRule")
end

function SnowOrNightBPTaskCell:setAchieveData(achieveData)
	self.achieveData = achieveData
	self.isUnlock = self.mParent.isUnlock
	self.actData = self.mParent.actData

	local stateName = self.isUnlock and "SnowOrNightBPTaskCellNormal" or "SnowOrNightBPTaskCellDis"

	self.panelSelf:playStateAnimator(stateName)
	self.textRule:setText(self.achieveData.desc_name)

	local achieveState = self.actData:getAchieveState(self.achieveData.type, self.achieveData.index)

	self.btnGet:setVisible(achieveState == Const.ACT_ACHIEVE_STATE_NOT_ENOUGH and self.isUnlock)
	self.imgState:setVisible(achieveState == Const.ACT_ACHIEVE_STATE_GOT or achieveState == Const.ACT_ACHIEVE_STATE_ENOUGH)

	local progress = self.actData:getAchieveProgress(self.achieveData.type)

	if self.achieveData.type == Const.ACT_ACHIEVE_HERO_STAR then
		local showProgress = progress >= self.achieveData.param and 1 or 0

		self.slider:setValue(showProgress)
		self.textExp:setText(showProgress .. "/1")
	else
		self.slider:setValue(progress / self.achieveData.param)
		self.textExp:setText(progress .. "/" .. self.achieveData.param)
	end
end

function SnowOrNightBPTaskCell:onBtnGetClick()
	if self.actData then
		local miscData = self.actData:getAchieveMiscDataByType(self.achieveData.type)

		if miscData and miscData.jump_id then
			JumpGuideManager.jump(miscData.jump_id)
		end
	end
end

return SnowOrNightBPTaskCell
