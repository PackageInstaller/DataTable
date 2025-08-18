-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\NewYear\\ActivityNewYearBonusDlg.lua

local strClassName = "ActivityNewYearBonusDlg"
local ActivityNewYearBonusDlg = Class(strClassName, UIControls.Window)

function ActivityNewYearBonusDlg:ctor()
	self:initUI()
end

function ActivityNewYearBonusDlg:initUI()
	self.textAddExp = UIControls.Label(self, "BgPanel/ExpriencePanel/TxtNum")
	self.sliderExp = UIControls.Slider(self, "BgPanel/CookLevelPanel/LevelProgress")
	self.textExp = UIControls.Label(self, "BgPanel/CookLevelPanel/LevelProgress/TxtNum")
	self.textLevel = UIControls.Label(self, "BgPanel/CookLevelPanel/LevelPanel/TxtNum")
	self.bonusGrid = {}
end

function ActivityNewYearBonusDlg:onShow(actData, foodId, preLevel, preExp)
	if self.coPlay then
		coroutine.stop(self.coPlay)

		self.coPlay = nil
	end

	self.actData = actData
	self.preLevel = preLevel
	self.preExp = preExp

	local foodData = actData.foodData

	foodData = foodData[foodId]

	self.textAddExp:setText("+" .. (foodData.add_exp or 0))
	ClientUtils.CreateBonusGrid(self, self.bonusGrid, "BgPanel/PrivilegeInfoPanel/Content", foodData.reward_id, nil, nil, true)

	local levelData = actData.levelData

	self.textLevel:setText(preLevel)

	if preLevel == #levelData then
		self.textExp:setText(Lang.get(467))
		self.sliderExp:setValue(1)
	else
		local nowExp = levelData[preLevel + 1].need_exp - levelData[preLevel].need_exp

		self.textExp:setText(preExp .. "/" .. nowExp)
		self.sliderExp:setValue(preExp / nowExp)
	end
end

function ActivityNewYearBonusDlg:onReceiveHalfPart(nowLevel, targetExp)
	if self.coPlay then
		coroutine.stop(self.coPlay)

		self.coPlay = nil
	end

	if not self:isInShow() then
		return
	end

	local levelData = self.actData.levelData

	if self.preLevel == #levelData then
		return
	end

	if self.preLevel == nowLevel then
		local nowExp = levelData[nowLevel + 1].need_exp - levelData[nowLevel].need_exp

		self.textExp:setText(targetExp .. "/" .. nowExp)
		self.sliderExp:setValue(targetExp / nowExp, 1)
	else
		self.sliderExp:setValue(1, 0.5)

		if nowLevel == #levelData then
			self.coPlay = coroutine.start(self.setTargetSlider, self, nowLevel, targetExp, 0)
		else
			self.coPlay = coroutine.start(self.setTargetSlider, self, nowLevel, targetExp, levelData[nowLevel + 1].need_exp - levelData[nowLevel].need_exp)
		end
	end
end

function ActivityNewYearBonusDlg:setTargetSlider(nowLevel, targetExp, maxExp)
	coroutine.wait(0.5)

	if not self:isInShow() then
		return
	end

	self:playAni("ShowActEveLevelUp", nil, true)
	self.textLevel:setText(nowLevel)

	if maxExp == 0 then
		self.textExp:setText(Lang.get(467))
		self.sliderExp:setValue(1)
	else
		self.textExp:setText(targetExp .. "/" .. maxExp)
		self.sliderExp:setValue(0)
		self.sliderExp:setValue(targetExp / maxExp, 0.5)
	end

	self.coPlay = nil
end

function ActivityNewYearBonusDlg:destroy()
	if self.coPlay then
		coroutine.stop(self.coPlay)

		self.coPlay = nil
	end

	for _, grid in ipairs(self.bonusGrid) do
		grid:flyToCommonFuncEntryPanel()
	end

	ActivityNewYearBonusDlg.super.destroy(self)
	self.actData:checkLevelChanged()
end

return ActivityNewYearBonusDlg
