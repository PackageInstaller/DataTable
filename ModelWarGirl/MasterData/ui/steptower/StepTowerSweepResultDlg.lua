-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\StepTower\\StepTowerSweepResultDlg.lua

local CleanResultDlg = require("UI/Common/CleanResultDlg")
local ResStepCost = require("ClientData/ResStepCost")
local strClassName = "StepTowerSweepResultDlg"
local StepTowerSweepResultDlg = Class(strClassName, CleanResultDlg)

function StepTowerSweepResultDlg:onShow(notifyType, attrs, items, heros, equip, artifact, showTitle)
	StepTowerSweepResultDlg.super.onShow(self, notifyType, attrs, items, heros, equip, artifact, showTitle)

	local stepTowerDlg = UIManager.getUI("stepTowerDlg", nil, false)

	if stepTowerDlg and stepTowerDlg.srcGrid and stepTowerDlg.srcGrid.hero then
		local selectLayer = 0
		local selectLevel = 0

		if stepTowerDlg.selectLayerBtn and stepTowerDlg.selectLayerBtn.selectLevelBtn then
			selectLayer = stepTowerDlg.selectLayerBtn.selectLevelBtn.resData.layer
			selectLevel = stepTowerDlg.selectLayerBtn.selectLevelBtn.resData.level
		end

		if stepTowerDlg.jumpLayerIdx == selectLayer and stepTowerDlg.jumpLevelIdx == selectLevel then
			local hero = stepTowerDlg.srcGrid.hero
			local totalNeed = 0

			for i, v in ipairs(ResStepCost[hero.resData.step_up_id][hero.step + 1].materials) do
				if v.id == stepTowerDlg.srcGrid.object.id then
					totalNeed = v.num
				end
			end

			local getNeed = false
			local getCount = 0

			for _, it in ipairs(items) do
				if it.id == stepTowerDlg.srcGrid.object.id then
					getNeed = true
					getCount = it.num
				end
			end

			local haveCount = CurAvatar:getItemNumById(stepTowerDlg.srcGrid.object.id)
			local needCount = math.max(totalNeed - haveCount, 0)

			self:setNeedMaterial(stepTowerDlg.srcGrid.object.id, getCount, needCount)
		end
	end

	CurAvatar:refreshHeroDetail()
end

return StepTowerSweepResultDlg
