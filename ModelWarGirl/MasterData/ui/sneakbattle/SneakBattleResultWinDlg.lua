-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\SneakBattle\\SneakBattleResultWinDlg.lua

local ResBattleConfig = require("ClientData/ResBattleConfig")
local ResBattleTarget = require("ClientData/ResBattleTarget")
local BattleStepTowerVictoryDlg = require("UI/Battle/BattleStepTowerVictoryDlg")
local SneakBattleResultWinDlg = Class("SneakBattleResultWinDlg", BattleStepTowerVictoryDlg)

function SneakBattleResultWinDlg:ctor(...)
	self:_initUI()
end

function SneakBattleResultWinDlg:_initUI(...)
	return
end

function SneakBattleResultWinDlg:onShow(battleType, bonus, itemBonus)
	local battleState = GameFsm.getState(Const.STATE_BATTLE)

	self.battleType = battleState.battleType
	self.commonBonus = bonus.common
	self.itemBonus = itemBonus

	self:_startStageBattle(battleState:getBattleObjMgr())

	local battleConfig
	local actData = CurAvatar:getSneakBattleActivityData()

	self.panelCondition:setVisible(false)

	if actData then
		local sneakData = bonus and bonus.spec and bonus.spec.new_pve or {}

		if sneakData then
			local level = sneakData.level
			local stageIndex = sneakData.stage
			local stages = actData:getStageResDataByLevel(level)

			if stages and stageIndex and stages[stageIndex] then
				local pveID = stages[stageIndex].pve_id

				if pveID and ResBattleConfig[pveID] then
					battleConfig = ResBattleConfig[pveID]

					if battleConfig and battleConfig.target_id then
						local targetInfo = ResBattleTarget[battleConfig.target_id]

						if targetInfo then
							self.panelCondition:setVisible(true)

							for index, uis in ipairs(self.starUIs) do
								if index > 2 then
									uis[5]:setVisible(false)
								else
									uis[5]:setVisible(true)

									local can = false
									local targetIndex

									if index == 1 then
										targetIndex = 2
										can = sneakData.is_weak_pass == 1
									end

									if index == 2 then
										targetIndex = 1
										can = sneakData.is_strong_pass == 1
									end

									local desc = targetInfo.targets[targetIndex].desc or ""

									if can then
										uis[2]:setFontColor(ResColor.WHITE)
										uis[2]:setText(desc)
										uis[1]:setVisible(false)
										uis[3]:setVisible(true)
									else
										uis[2]:setFontColor(ResColor.GREYLIGHT)
										uis[2]:setText(desc)
										uis[1]:setVisible(true)
										uis[3]:setVisible(false)
									end
								end
							end
						end
					end
				end
			end

			local count = actData:getStageCount(level)

			if count and stageIndex and count == stageIndex then
				actData.finishOneLevel = true
			end

			if stageIndex and stageIndex == actData.curPassStage then
				actData.showNewStageAni = true
			end
		end
	end

	self.panelTips:setVisible(false)
end

function SneakBattleResultWinDlg:onBtnNext()
	UIManager.getUI("battleBonusDlg", true):onShow(self.commonBonus, self.itemBonus, self.battleType, self.finish)
	self:setVisible(false)
end

return SneakBattleResultWinDlg
