-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\BtnCircleBattleGoal.lua

local strClassName = "BtnCircleBattleGoal"
local BtnCircleBattleGoal = Class(strClassName, UIControls.ScrollViewLoopCell)

function BtnCircleBattleGoal:ctor()
	self:initUI()
end

function BtnCircleBattleGoal:initUI()
	self.btnSelf = UIControls.Button(self, "")

	self.btnSelf:addEventClick(self.onBtnSelfClick)

	self.imgSel = UIControls.Image(self, "ImgSel")
	self.txtGoal = UIControls.Label(self, "TextGoal")
	self.sliderGoal = UIControls.Slider(self, "Slider")
	self.txtSlider = UIControls.Label(self, "Slider/Text")
	self.imgSelf = UIControls.Image(self, "")
end

function BtnCircleBattleGoal:setGoalData(goalData)
	self.goalData = goalData
	self.isSelected = self.mWindow.selectedAchieve == self.goalData.resData.action_type

	self.imgSel:setVisible(self.isSelected)
	self.btnSelf:setEnable(not self.isSelected)
	self.txtGoal:setText(self.goalData.resData.desc)

	local showProgress = math.min(self.goalData.progress, self.goalData.resData.action_param)

	self.sliderGoal:setValue(showProgress / self.goalData.resData.action_param)
	self.txtSlider:setText(showProgress .. "/" .. self.goalData.resData.action_param)

	if self.goalData.progress >= self.goalData.resData.action_param then
		self.imgSelf:setImage("Atlas/CircleBattleAtlas/CircleBattleAtlas2", "BgTargetDis")
	elseif self.isSelected then
		self.imgSelf:setImage("Atlas/CircleBattleAtlas/CircleBattleAtlas2", "BgTargetSel")
	else
		self.imgSelf:setImage("Atlas/CircleBattleAtlas/CircleBattleAtlas2", "BgTargetNml")
	end
end

function BtnCircleBattleGoal:setSelectCallback(selectCallback)
	self.selectCallback = selectCallback
end

function BtnCircleBattleGoal:onBtnSelfClick()
	if self.goalData.progress >= self.goalData.resData.action_param then
		MsgManager.clientNotice(556)

		return
	end

	if self.goalData and self.selectCallback then
		self.selectCallback(self)
	end
end

return BtnCircleBattleGoal
