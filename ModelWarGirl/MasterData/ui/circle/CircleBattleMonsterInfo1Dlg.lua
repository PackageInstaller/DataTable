-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Circle\\CircleBattleMonsterInfo1Dlg.lua

local ResClanBattleMonster = require("ClientData/ResClanBattleMonster")
local CircleControlCenter = require("Logic/Circle/CircleControlCenter")
local ResClanBattleMisc = require("ClientData/ResClanBattleMisc")
local ResBattleConfig = require("ClientData/ResBattleConfig")
local ResColor = require("ClientData/ResColor")
local Monster = require("Common/Object/Monster")
local strClassName = "CircleBattleMonsterInfo1Dlg"
local CircleBattleMonsterInfo1Dlg = Class(strClassName, UIControls.Window)

function CircleBattleMonsterInfo1Dlg:ctor(...)
	self:initUI()
end

function CircleBattleMonsterInfo1Dlg:initUI(...)
	self.slider = UIControls.Slider(self, "BgPanel/Slider")
	self.btnMore = UIControls.Button(self, "BgPanel/MonsterList/BtnMoreMonster")

	self.btnMore:addEventClick(self.onBtnMoreClick)

	self.btnCancel = UIControls.Button(self, "BgPanel/BtnDeny")

	self.btnCancel:addEventClick(self.onBtnCancelClick)

	self.btnConfirm = UIControls.Button(self, "BgPanel/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)

	self.imgIcon = UIControls.Image(self, "BgPanel/BtnConfirm/CostPanel/Icon")
	self.txtNum = UIControls.Label(self, "BgPanel/BtnConfirm/CostPanel/TextNum")
	self.txtSliderNum = UIControls.Label(self, "BgPanel/Slider/TextNum")
	self.imgRole = UIControls.Role(self, "BgPanel/GridHeroPortrait", 0, 0)
	self.monsterCells = {}
end

function CircleBattleMonsterInfo1Dlg:setData(monsterId, gridPos)
	self.gridPos = gridPos
	self.monsterId = monsterId

	self:initMonsters(monsterId)
	self:initAward()
	self:initUIShow()
	self:refreshUI()
end

function CircleBattleMonsterInfo1Dlg:initUIShow(...)
	self.imgIcon:setImage("Atlas/CommonAtlas/IconAtlas/ItemBagAtlas/20", "312")

	if CurAvatar.myCircle then
		local cur, total = CurAvatar.myCircle:getMonsterHpProgress(self.gridPos)
		local value = 1 - (total - cur) / total

		value = math.min(1, math.max(0, value))

		self.slider:setValue(value)
		self:setSliderTxt(value)
	end
end

function CircleBattleMonsterInfo1Dlg:setSliderTxt(value)
	self.txtSliderNum:setText(string.format("%d%%", value * 100))
end

function CircleBattleMonsterInfo1Dlg:refreshUI(...)
	local myActionPoint = CurAvatar.myCircle:getActionPoint()
	local monsterCost = CurAvatar.myCircle:getFightMonsterPointCost(self.monsterId)

	self.txtNum:setText(monsterCost .. "/" .. myActionPoint)

	self.pointOk = monsterCost <= myActionPoint

	if not self.pointOk then
		self.txtNum:setFontColor(ResColor.RED)
	else
		self.txtNum:setFontColor(ResColor.WHITE)
	end
end

function CircleBattleMonsterInfo1Dlg:initAward(...)
	if CurAvatar.myCircle then
		local datas = {}
		local score = CurAvatar.myCircle:getFightMonsterScore(self.monsterId, false)

		if score then
			table.insert(datas, BaseObject.GetObject(ResClanBattleMisc[1].score_id, score))
		end

		local proficient = CurAvatar.myCircle:getFightMonsterProficiency(self.monsterId, false)

		if proficient then
			table.insert(datas, BaseObject.GetObject(ResClanBattleMisc[1].proficiency_id, proficient))
		end

		local feat = CurAvatar.myCircle:getFightMonsterFeat(self.monsterId, false)

		if feat then
			table.insert(datas, BaseObject.GetObject(ResClanBattleMisc[1].feat_id, feat))
		end

		local scoreUp = CurAvatar.myCircle:getMaxScoreBuff()

		for i, item in ipairs(datas) do
			local cell = UIControls.getGridAwardContainer(self, "BgPanel/AwardList")

			cell:setVisible(true)
			cell:setObj(item)

			if scoreUp > 0 and cell.object.id == ResClanBattleMisc[1].score_id then
				cell:setNumSpe(true, "+" .. scoreUp * 0.01)
			else
				cell:setNumSpe(false)
			end
		end
	end
end

function CircleBattleMonsterInfo1Dlg:initMonsters(monsterId)
	if monsterId == nil then
		return
	end

	local config = ResClanBattleMonster[monsterId]

	if config then
		self.imgRole:showRole(config.port_id)

		if self.txtDes then
			self.txtDes:setText(config.desc or "")
		end

		self.monsterType = config.type
		self.monsterObjs = {}
		self.pveId = config.pveid

		local battleConfig = ResBattleConfig[self.pveId or 1] or {}

		self.battleConfig = battleConfig

		local monsters = battleConfig.monsters or {}

		for pos, monsterId in ipairs(monsters) do
			if monsterId and monsterId ~= 0 then
				local newMonster = Monster(monsterId, battleConfig.monster_level or 220)

				table.insert(self.monsterObjs, newMonster)
			end
		end

		local needCount = 0

		if #self.monsterObjs <= 4 then
			needCount = #self.monsterObjs

			self.btnMore:setVisible(false)
		else
			self.btnMore:setVisible(true)

			needCount = 3
		end

		self:_initMonsters(needCount, self.monsterCells, "BgPanel/MonsterList")
	end
end

function CircleBattleMonsterInfo1Dlg:_initMonsters(needCount, pool, path)
	local preCount = 1

	for idx, cell in ipairs(pool) do
		preCount = preCount + 1

		if idx <= needCount then
			cell:setVisible(true)
			cell.setObj(self.monsterObjs[idx])
		else
			cell:setVisible(false)
		end
	end

	for i = preCount, needCount do
		local newCell = UIControls.MonsterCardChild(self, path, "System/Common/Grid/GridMonster")

		table.insert(pool, newCell)
		newCell:setVisible(true)
		newCell:setObj(self.monsterObjs[i])
	end
end

function CircleBattleMonsterInfo1Dlg:preCheck(...)
	if not self.pointOk then
		MsgManager.clientNotice(523)

		return false
	end

	if CircleControlCenter.isLayerChange() then
		MsgManager.clientNotice(598)

		return false
	end

	if CurAvatar.myCircle then
		local cur, total = CurAvatar.myCircle:getMonsterHpProgress(self.gridPos)

		if cur == 0 then
			MsgManager.clientNotice(542)

			return false
		else
			local layer = CurAvatar.myCircle:getCurBattleLayer()
			local info = CurAvatar.myCircle:getCircleMember(CurAvatar.uid)

			if info then
				local uid = CircleControlCenter.isGridOccupyUid(layer, self.gridPos)

				if uid == nil or uid == CurAvatar.uid then
					-- block empty
				else
					MsgManager.clientNotice(543)

					return false
				end
			end
		end
	end

	return true
end

function CircleBattleMonsterInfo1Dlg:onBtnConfirmClick(...)
	if not self:preCheck() then
		return
	end

	self:setVisible(false)

	if CurAvatar.myCircle then
		local cur, total = CurAvatar.myCircle:getMonsterHpProgress(self.gridPos)

		if cur == 0 then
			-- block empty
		else
			local layer = CurAvatar.myCircle:getCurBattleLayer()
			local info = CurAvatar.myCircle:getCircleMember(CurAvatar.uid)

			if info then
				local uid = CircleControlCenter.isGridOccupyUid(layer, self.gridPos)

				if info.battle_data.optype == Const.CIRCLE_PLAYER_STATE.NONE then
					if uid == nil then
						local checkPath = CircleControlCenter.getMyServerCheckPath(self.gridPos)

						if checkPath then
							CurAvatar:tryCallCircleBattleRpc("clanBattleOccupyMonster", layer, self.gridPos - 1, checkPath)
						end
					end
				elseif info.battle_data.optype == Const.CIRCLE_PLAYER_STATE.BATTLE then
					if uid == CurAvatar.uid then
						local checkPath = CircleControlCenter.getMyServerCheckPath(self.gridPos)

						if checkPath then
							CurAvatar:tryCallCircleBattleRpc("clanBattleOccupyMonster", layer, self.gridPos - 1, checkPath)
						end
					end
				elseif info.battle_data.optype == Const.CIRCLE_PLAYER_STATE.FORMATION and info.battle_data.oppos == self.gridPos - 1 then
					CircleControlCenter.checkMove(CurAvatar.uid, self.gridPos)
				end
			end
		end
	end
end

function CircleBattleMonsterInfo1Dlg:onBtnCancelClick(...)
	self:setVisible(false)
end

function CircleBattleMonsterInfo1Dlg:onBtnMoreClick(...)
	UIManager.getUI("onceTowerMonsterDlg", true):onShow(self.monsterObjs or {})
end

return CircleBattleMonsterInfo1Dlg
