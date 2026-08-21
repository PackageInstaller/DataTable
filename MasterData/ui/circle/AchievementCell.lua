-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\AchievementCell.lua

local strClassName = "AchievementCell"
local AchievementCell = Class(strClassName, UIControls.ScrollViewLoopCell)

function AchievementCell:ctor()
	self:initUI()
end

function AchievementCell:initUI()
	self.txtDes = UIControls.Label(self, "TxtDes")
	self.sliderProgress = UIControls.Slider(self, "ProgressBar")
	self.txtProgress = UIControls.Label(self, "ProgressBar/Text")
	self.panelBlock = UIControls.Panel(self, "Block")
end

function AchievementCell:setAchievementData(achievementData)
	self.achievementData = achievementData

	self.txtDes:setText(utils.format(ClientUtils.getClientNotice(580), self.achievementData.resData.layer))

	if CurAvatar.myCircle.maxBattleLayer >= self.achievementData.resData.layer then
		self.status = Const.ACHIEVE_STATUS.AWARD_GOT
	else
		self.status = Const.ACHIEVE_STATUS.IN_PROCESS
	end

	self.sliderProgress:setValue(math.min(CurAvatar.myCircle.maxBattleLayer / self.achievementData.resData.layer, 1))

	local curLayer = math.min(CurAvatar.myCircle.maxBattleLayer, self.achievementData.resData.layer)

	self.txtProgress:setText(curLayer .. "/" .. self.achievementData.resData.layer)

	if not self.gridAwardContainer then
		self.gridAwardContainer = UIControls.getGridAwardContainer(self, "GridAward")
	end

	self.gridAwardContainer.mDisableWays = true

	local item = BaseObject.GetObject(self.achievementData.resData.item_id, 1)

	self.gridAwardContainer:setObj(item)

	if self.status == Const.ACHIEVE_STATUS.AWARD_GOT then
		self.gridAwardContainer:setState(false, true)
		self.panelBlock:setVisible(true)
	else
		self.gridAwardContainer:setState(false, false)
		self.panelBlock:setVisible(false)
	end

	self.gridAwardContainer:setVisible(true)
end

return AchievementCell
