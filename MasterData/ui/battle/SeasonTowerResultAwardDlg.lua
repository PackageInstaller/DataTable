-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Battle\\SeasonTowerResultAwardDlg.lua

local ResOpActTowerStage = require("ClientData/ResOpActTowerStage")
local PVPResultAwardDlg = require("UI/PVPMode/PVPResultAwardDlg")
local strClassName = "SeasonTowerResultAwardDlg"
local SeasonTowerResultAwardDlg = Class(strClassName, PVPResultAwardDlg)

function SeasonTowerResultAwardDlg:ctor(...)
	return
end

function SeasonTowerResultAwardDlg:initUI(...)
	SeasonTowerResultAwardDlg.super.initUI(self)

	self.panelSpecial = UIControls.Panel(self, "BgPanel/OldAwardPanel/GridSpecialPanel")
	self.panelOldAward = UIControls.Panel(self, "BgPanel/OldAwardPanel")
	self.panelNewAward = UIControls.Panel(self, "BgPanel/NewAwardPanel")
	self.panelBossScore = UIControls.Panel(self, "BgPanel/NewAwardPanel/HistoryCodePanel")
	self.imgScore = UIControls.Image(self, "BgPanel/OldAwardPanel/GridSpecialPanel/Icon1")
	self.imgDrop = UIControls.Image(self, "BgPanel/OldAwardPanel/GridSpecialPanel/Icon2")
	self.txtScore = UIControls.Label(self, "BgPanel/OldAwardPanel/GridSpecialPanel/Icon1/Text")
	self.txtDrop = UIControls.Label(self, "BgPanel/OldAwardPanel/GridSpecialPanel/Icon2/Text")
	self.txtScoreNew = UIControls.Label(self, "BgPanel/NewAwardPanel/CodePanel/TxtNum")
	self.txtScoreNewHighest = UIControls.Label(self, "BgPanel/NewAwardPanel/HistoryCodePanel/TxtNum")
end

function SeasonTowerResultAwardDlg:show(itemBonus, battleType, finish)
	SeasonTowerResultAwardDlg.super.show(self, itemBonus, battleType, finish)

	local data = finish.spec.opact_tower
	local towerData = ResOpActTowerStage[data.detail_id] or {}

	towerData = towerData[data.tower_id]

	local layerData

	if towerData then
		layerData = towerData[data.layer]
	end

	if not self:isNewActivity() then
		self.panelOldAward:setVisible(true)
		self.panelNewAward:setVisible(false)

		if layerData then
			if layerData.score then
				self.txtScore:setText("+" .. layerData.score)
			else
				self.imgScore:setVisible(false)
			end

			local preLayer = math.min(#towerData, math.max(1, data.layer - 1))
			local preLayerData = towerData[preLayer]
			local addDrop = (layerData.hour_drop_count or 0) - (preLayerData.hour_drop_count or 0)

			if addDrop > 0 then
				self.txtDrop:setText(string.format(Lang.get(30153), addDrop))
			else
				self.imgDrop:setVisible(false)
			end

			self:showShareBtn(layerData.mulity_pvp ~= 1)
		end

		self.panelSpecial:setVisible(self.imgDrop:getVisible() or self.imgScore:getVisible())
	else
		self.panelOldAward:setVisible(false)
		self.panelNewAward:setVisible(true)

		local actObj = CurAvatar:getSeasonTowerAct()

		if self:isBossBattle() then
			self.panelBossScore:setVisible(true)

			if actObj and actObj.actData then
				self.txtScoreNewHighest:setText(actObj.actData:getBossMaxHp(data.tower_id, data.layer))
			end
		else
			self.panelBossScore:setVisible(false)

			if layerData then
				self:showShareBtn(layerData.mulity_pvp ~= 1)
			end
		end

		local score = data.add_score

		self.txtScoreNew:setText(score)
	end
end

function SeasonTowerResultAwardDlg:setAwardData(itemBonus, speType)
	local data = {
		path = "BgPanel/OldAwardPanel/GridPanel",
		items = itemBonus,
		speType = speType
	}

	self:setAwardDataCommon(data)
end

function SeasonTowerResultAwardDlg:isNewActivity(...)
	local actObj = CurAvatar:getSeasonTowerAct()

	if actObj and actObj.actData then
		return not actObj.actData:hasLimitTower()
	end
end

function SeasonTowerResultAwardDlg:isBossBattle(...)
	if GameFsm.isInState(Const.STATE_BATTLE) then
		local state = GameFsm.getCurState()

		if state and state.speData and state.speData.seasonTowerData then
			return state.speData.seasonTowerData.bossConfig ~= nil
		end
	end
end

return SeasonTowerResultAwardDlg
