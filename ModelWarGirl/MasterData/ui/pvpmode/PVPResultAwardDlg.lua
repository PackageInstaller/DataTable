-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PVPMode\\PVPResultAwardDlg.lua

local ResRoleImageData = require("ClientData/ResRoleImageData")
local ResClanBattleMisc = require("ClientData/ResClanBattleMisc")
local BattleAwardMixin = require("UI/Battle/BattleAwardMixin")
local strClassName = "PVPResultAwardDlg"
local PVPResultAwardDlg = Class(strClassName, UIControls.Window)

MixinClass(PVPResultAwardDlg, BattleAwardMixin, true)

function PVPResultAwardDlg:ctor()
	self:ctorMixin()
	self:initUI()
end

function PVPResultAwardDlg:initUI()
	self.btnConfirm = UIControls.Button(self, "BgPanel/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)

	self.imgRole = UIControls.Role(self, "BgPanel/GridHeroPortrait", 0, 0)
	self.panelNone = UIControls.Panel(self, "BgPanel/NonePanel")
	self.txtNone = UIControls.Label(self, "BgPanel/NonePanel/TextDes")
end

function PVPResultAwardDlg:bgmOn()
	local battleState = GameFsm.getCurState()

	if battleState and battleState.relicHero then
		local battleBGM = battleState.relicHero:getRelicBgmIdByType(Const.RELIC_BGM_TYPE_VICTORY)

		if battleBGM then
			CueManager.playUIBGM(battleBGM)
		end
	else
		PVPResultAwardDlg.super.bgmOn(self)
	end
end

function PVPResultAwardDlg:show(itemBonus, battleType, finish)
	self:initData()

	if battleType == BattleConst.BATTLE_TYPE_EQUIPTOWER then
		local type = finish.spec.equip_tower.type
		local layer = finish.spec.equip_tower.layer
		local awardType = finish.spec.equip_tower.award
		local ResEquipTower = require("ClientData/ResEquipTower")
		local info = ResEquipTower[type][layer]

		if awardType == 0 then
			self.panelNone:setVisible(true)
			self.txtNone:setText(ClientUtils.getClientNotice(336))
		elseif info.limit_hero_award and info.layer_type == Const.EQUIP_TOWER_LAYER_TYPE_WEEK then
			if awardType == 1 or awardType == 3 then
				local passAward = ClientUtils.getObjectByRandId(info.pass_award)

				self:setAwardData(passAward, 1)

				local map = {}

				for _, item in ipairs(passAward) do
					map[item.id] = item.num
				end

				for i = #itemBonus, 1, -1 do
					local item = itemBonus[i]

					if map[item.id] then
						if map[item.id] == item.num then
							table.remove(itemBonus, i)
						else
							item.num = item.num - map[item.id]
						end
					end
				end
			end

			self:setAwardData(itemBonus, 5)
		else
			self:setAwardData(itemBonus, 1)
		end
	elseif battleType == BattleConst.BATTLE_TYPE_CIRCLE then
		local datas = {}
		local score = finish.spec.clan_battle.score

		if score > 0 then
			table.insert(datas, BaseObject.GetObject(ResClanBattleMisc[1].score_id, score))
		end

		local proficient = finish.spec.clan_battle.proficiency

		if proficient > 0 then
			table.insert(datas, BaseObject.GetObject(ResClanBattleMisc[1].proficiency_id, proficient))
		end

		local feat = finish.spec.clan_battle.feat

		if feat > 0 then
			table.insert(datas, BaseObject.GetObject(ResClanBattleMisc[1].feat_id, feat))
		end

		self:setAwardData(datas)
	elseif battleType == BattleConst.BATTLE_TYPE_BOSSTOWER_EXPAND then
		self:setAwardData(itemBonus, 1)
	else
		self:setAwardData(itemBonus)
	end

	self.fromMaze = battleType == BattleConst.BATTLE_TYPE_MAZE

	self:playCustomBgm(battleType, "result_award")
end

function PVPResultAwardDlg:initData()
	local battleState = GameFsm.getState(Const.STATE_BATTLE)
	local mvp = battleState:getMVPActor()

	if mvp then
		local portId = mvp.hero:getShowPortId()

		self.imgRole:showRole(portId)
	end
end

function PVPResultAwardDlg:setAwardData(itemBonus, speType)
	local data = {
		path = "BgPanel/GridPanel",
		items = itemBonus,
		speType = speType
	}

	self:setAwardDataCommon(data)
end

function PVPResultAwardDlg:onBtnConfirmClick()
	self:setVisible(false)

	if CurAvatar.needResetMaze and self.fromMaze then
		CurAvatar:resetMazeTip(true)
	else
		if not GameFsm.isInState(Const.STATE_BATTLE) then
			return
		end

		self:checkExitBattle(true)
	end
end

return PVPResultAwardDlg
