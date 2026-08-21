-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Control\\Com\\DragPlane.lua

local UIUtils = require("Framework.UI.UIUtils")
local DragObject = require("UI/Control/Com/DragObject")
local ResSkillConfig = require("ClientData/ResSkillConfig")
local UserData = require("Helper/UserData")
local BattleConst = require("Common/FrameBattle/BattleConst")
local ResBattleTrap = require("ClientData/ResBattleTrap")
local BattleMiscConfig = require("Common/BattleMiscConfig")
local ResBattleWeather = require("ClientData/ResBattleWeather")
local GRID_RED = 1
local GRID_GREEN = 2
local DragPlane = {}
local self = DragPlane

function DragPlane.start(centerGo, playerEnterState, battleConfig)
	if battleConfig.matrix_type == 1 then
		self._plane = UIUtils.InitDragField(centerGo, "BattlePlane2.prefab")
		self.GridConfig = BattleMiscConfig.SPE_BOSS_POS_CONFIG
		BattleConst.BATTLE_MAX_POS = 12

		UIUtils.SetDragFieldBound(5, -4, 6.5, -7)
	else
		self.GridConfig = BattleMiscConfig.NORMAL_POS_CONFIG
		self._plane = UIUtils.InitDragField(centerGo, "BattlePlane.prefab")
		BattleConst.BATTLE_MAX_POS = 9

		UIUtils.SetDragFieldBound(4, -3, 6.5, -7)
	end

	self.fieldObjs = {}
	self._focusObj = nil
	self.ready = false
	self.inRunning = true

	for pos = 1, BattleConst.BATTLE_MAX_POS do
		self._plane:LockGrid(1, pos)
	end

	if playerEnterState and playerEnterState[1] then
		self.playerEnterState = playerEnterState[1]
	else
		self.playerEnterState = nil
	end

	self.showTips = true
	self.DISABLE_DELETE = nil
	self.MAX_PUT_COUNT = battleConfig.num_limit or BattleConst.FORMATION_DEFAULT_NUM
	self.heroPutFilter = GameFsm.getCurState().heroPutFilter or {}

	self.setTeamLimitCheck(GameFsm.getCurState().teamNumLimit)
	self:_checkBattleConfig(battleConfig)
end

function DragPlane.setTeamLimitCheck(teamLimitCheck)
	self.teamLimitCheck = teamLimitCheck

	if self.teamLimitCheck then
		self.limitNoTeamNumber = self.teamLimitCheck.noTeamNumber
	else
		self.limitNoTeamNumber = 0
	end
end

function DragPlane.onReady()
	self.ready = true

	for pos, obj in pairs(self.fieldObjs) do
		obj:onReady()
		obj:checkStartCue(self.playerEnterState)
	end

	for pos = 1, BattleConst.BATTLE_MAX_POS do
		if self.fieldObjs[pos] and self.fieldObjs[pos].monster then
			self._plane:LockGrid(1, pos)
		else
			self._plane:LockGrid(0, pos)
		end
	end

	self.checkBattleCondition()
end

function DragPlane.stop()
	if not self._plane then
		return
	end

	if not self.inRunning then
		return
	end

	self:clearTrap()

	self.inRunning = false

	for pos, obj in pairs(self.fieldObjs) do
		obj:destroy()
	end

	self.fieldObjs = {}

	if self.preSkillAreaInfo then
		self.clearSkillArea()
	end

	if self.skillAreaTimer then
		self.skillAreaTimer:Stop()
	end

	UIUtils.StopDragField()

	self.playerEnterState = nil
	self._plane = nil
end

function DragPlane.clearObject(onlyPlayer)
	for pos, obj in pairs(self.fieldObjs) do
		if not onlyPlayer or not (pos < 0) then
			self._plane:ShowGridSupportHint(obj.did, 0, {})
			obj:destroy()

			self.fieldObjs[pos] = nil
		end
	end

	if self.preSkillAreaInfo then
		self.clearSkillArea()
	end

	if self.skillAreaTimer then
		self.skillAreaTimer:Stop()
	end
end

function DragPlane.enterRecommendForms()
	if not DragPlane.inRunning then
		return
	end

	local selfHeros = {}

	for pos, obj in pairs(self.fieldObjs) do
		if obj.hero and pos > 0 then
			table.insert(selfHeros, obj.hero)
		end
	end

	DragPlane.clearObject(true)
	DragPlane.startObjEntering()

	for pos, hero in pairs(CurAvatar:getHeroRecommendFormation(selfHeros)) do
		DragPlane.addDragObj(true, hero, pos, BattleConst.CAMP_PLAYER)
	end

	DragPlane.updateDragPanel()
end

function DragPlane.addDragObj(isHero, target, pos, camp)
	if pos == nil or self.GridConfig.PosToCoord[pos] then
		local obj

		if isHero then
			obj = DragObject(self, {
				hero = target
			}, pos, camp)
			obj.mEventDragPut = self.onDragPut
			obj.mEventDragEnter = self.onDragEnter
			obj.mEventDragLeave = self.onDragLeave
			obj.mEventDragCatch = self.onDragCatch
		else
			obj = DragObject(self, {
				monster = target
			}, pos, camp)

			if pos > 0 then
				self._plane:LockGrid(1, pos)
			end
		end

		obj.mEventDragClick = self.onDragClick

		if self.ready then
			obj:onReady()
		end

		if pos then
			self.fieldObjs[pos] = obj

			self.showSupport(obj, pos, true)
		end

		return obj
	end
end

function DragPlane.resetTrap(battleConfig)
	DragPlane:clearTrap()
	self:_checkBattleConfig(battleConfig)
end

function DragPlane:_checkBattleConfig(battleConfig)
	self.battleConfig = battleConfig

	if self.battleConfig.condition_type == 2 and self.battleConfig.condition_args and tonumber(self.battleConfig.condition_args[1]) and self.battleConfig.condition_notice then
		self.checkConfigCondition = true
		self.checkConditionNum = 0
		self.needConditionNum = tonumber(self.battleConfig.condition_args[1])
	else
		self.checkConfigCondition = false
	end

	if battleConfig.traps then
		self.trapEffs = {}

		for index = 0, BattleConst.BATTLE_MAX_TRAP_INIT_NUM do
			local trapId = battleConfig.traps[index * 2 + 1]
			local trapPos = battleConfig.traps[index * 2 + 2]

			if trapId and trapPos then
				self:addTrap(trapId, trapPos)
			else
				break
			end
		end
	end

	if battleConfig.weather then
		local weatherData = ResBattleWeather[battleConfig.weather]

		if weatherData and weatherData.effect then
			local pos = self._plane:GetGridPos(0)

			self.weatherEff = EffectManager:getFreedomEffectAsync(weatherData.effect, pos, nil, true)
		end
	end
end

function DragPlane.checkBattleCondition()
	if self.checkConfigCondition then
		local num = utils.getDragPlaneMaxNum(self.fieldObjs, "career", Const.CAREER_TYPE.SUPPORT)

		if num ~= self.checkConditionNum and num >= self.needConditionNum then
			MsgManager.clientNotice(self.battleConfig.condition_notice)
		end

		self.checkConditionNum = num
	end
end

function DragPlane:addTrap(trapId, trapPos)
	local trapData = ResBattleTrap[trapId]

	if trapData and trapData.effect then
		local pos = self._plane:GetGridPos(trapPos)
		local effInsId = EffectManager:getFreedomEffectAsync("Effects/" .. trapData.effect, pos, nil, true)

		table.insert(self.trapEffs, effInsId)
	end
end

function DragPlane:clearTrap()
	if self.trapEffs then
		for _, info in ipairs(self.trapEffs) do
			EffectManager:releaseEffect(info)
		end

		self.trapEffs = nil
	end

	if self.weatherEff then
		EffectManager:releaseEffect(self.weatherEff)

		self.weatherEff = nil
	end
end

function DragPlane.onBattleStart()
	for pos, obj in pairs(self.fieldObjs) do
		obj:onBattleStart()
	end
end

function DragPlane.delDragObj(dragObj, tgtPos)
	for pos, obj in pairs(self.fieldObjs) do
		if obj == dragObj then
			self.fieldObjs[pos] = nil

			break
		end
	end

	self.onDragLeave(dragObj, tgtPos)
	dragObj:destroy()
end

function DragPlane.showSupport(targetObj, tgtPos, isShow)
	local tempPos = tgtPos

	if not isShow then
		tempPos = nil
	end

	for pos, obj in pairs(self.fieldObjs) do
		if pos > 0 and obj.hero and obj ~= targetObj then
			self.updateSupport(obj, pos, targetObj, tempPos)
		end
	end

	self.updateSupport(targetObj, tgtPos, targetObj, nil, isShow)
end

local BLOCK_DEFAULT = 1
local BLOCK_SAME_ID = 2
local BLOCK_ASSIST = 3
local BLOCK_OTHERTEAM = 4

function DragPlane.showBlock(dragingObj, hero)
	local assistPos = self.getAssistPos(dragingObj, hero)
	local samePos = self.getSamePos(dragingObj, hero)
	local blockPos = {}

	dragingObj.blockPos = {}

	if samePos then
		for pos = 1, BattleConst.BATTLE_MAX_POS do
			if pos ~= samePos then
				dragingObj.blockPos[pos] = BLOCK_SAME_ID

				table.insert(blockPos, pos)
			end
		end
	elseif assistPos then
		for pos = 1, BattleConst.BATTLE_MAX_POS do
			if pos ~= assistPos then
				dragingObj.blockPos[pos] = BLOCK_ASSIST

				table.insert(blockPos, pos)
			end
		end
	else
		blockPos = self.getBlockPos(dragingObj, hero)

		for i, pos in ipairs(blockPos) do
			dragingObj.blockPos[pos] = BLOCK_DEFAULT

			if pos == dragingObj.pos then
				dragingObj.pos = nil
			end
		end
	end

	local multiTeam = ClientUtils.getNowDragDlg()

	if multiTeam and multiTeam.isHeroIdInTeam and hero then
		self.multiTeamIndex = multiTeam:isHeroIdInTeam(dragingObj.hero.id)

		if self.multiTeamIndex then
			for pos = 1, BattleConst.BATTLE_MAX_POS do
				if not dragingObj.blockPos[pos] then
					dragingObj.blockPos[pos] = BLOCK_OTHERTEAM

					table.insert(blockPos, pos)
				end
			end
		end
	end

	self._plane:ShowGridLockHint(dragingObj.did, blockPos)
end

function DragPlane.getBlockPos(dragingObj, hero)
	local blockPos = {}

	if hero == nil then
		return blockPos
	end

	for pos = 1, BattleConst.BATTLE_MAX_POS do
		if self.fieldObjs[pos] and self.fieldObjs[pos].monster then
			table.insert(blockPos, pos)
		end
	end

	return blockPos
end

function DragPlane.getAssistPos(dragingObj, hero)
	return
end

function DragPlane.getSamePos(dragingObj, hero)
	if hero and dragingObj and not dragingObj.pos and dragingObj.hero then
		local heroId = dragingObj.hero.id

		for pos = 1, BattleConst.BATTLE_MAX_POS do
			if self.fieldObjs[pos] and self.fieldObjs[pos].hero and self.fieldObjs[pos].hero.id == heroId then
				return pos
			end
		end
	end
end

function DragPlane._getSupportPos(dragObj, pos)
	local passiveSkill, passiveLevel

	if dragObj.hero then
		if dragObj.hero:supportSkillEnable() then
			passiveSkill = dragObj.hero.skillPassive2.id
			passiveLevel = dragObj.hero.skillPassive2.level
		end
	elseif dragObj.monster and dragObj.monster.skillPassive2 and dragObj.monster.skillPassive2.level > 0 then
		passiveSkill = dragObj.monster.skillPassive2.id
		passiveLevel = dragObj.monster.skillPassive2.level
	end

	return utils.getHeroAssistPos(passiveSkill, passiveLevel, pos, self.GridConfig)
end

function DragPlane.updateSupport(obj, pos, dragingObj, dragingPos, isEnter)
	local objSuptPoses, maxNum = DragPlane._getSupportPos(obj, pos)

	if maxNum <= 0 then
		return
	end

	if obj == dragingObj then
		if isEnter then
			if maxNum == BattleConst.BATTLE_MAX_POS then
				dragingObj:showSupportAllCue(self._plane:GetGridPos(pos))
			else
				self._plane:ShowGridSupportHint(obj.did, pos, objSuptPoses)
			end
		elseif maxNum == BattleConst.BATTLE_MAX_POS then
			dragingObj:hideSupportAllCue()
		else
			self._plane:ShowGridSupportHint(obj.did, 0, {})
		end
	end
end

function DragPlane.getObjectCount(campFlag, exceptObj)
	local fieldCount = 0

	for pos, obj in pairs(self.fieldObjs) do
		if (campFlag ~= nil or not (pos > 0) or not obj.hero) and (campFlag ~= 1 or not (pos < 0)) and campFlag ~= 2 or obj == exceptObj or campFlag == nil and obj.hero and self.heroPutFilter[obj.hero.id] then
			-- block empty
		else
			fieldCount = fieldCount + 1
		end
	end

	return fieldCount
end

function DragPlane.getObjectEnableNum()
	return self.MAX_PUT_COUNT - DragPlane.getObjectCount()
end

function DragPlane.getNoTeamCount(teams)
	local fieldCount = 0

	for pos, obj in pairs(self.fieldObjs) do
		if pos > 0 and obj.hero then
			local isNoTeam = true

			for _, team in ipairs(teams) do
				if obj.hero.team == team then
					isNoTeam = false

					break
				end
			end

			if isNoTeam then
				fieldCount = fieldCount + 1
			end
		end
	end

	return fieldCount
end

function DragPlane.getObjectNoTeamNum()
	if self.teamLimitCheck then
		return self.getNoTeamCount(self.teamLimitCheck.limitTeam)
	else
		return 0
	end
end

function DragPlane.putObject(pos, dragObj)
	if dragObj == nil then
		return
	end

	local oriPos = pos

	if pos == 99 and self.DISABLE_DELETE then
		pos = dragObj.pos
	end

	if dragObj.blockPos[pos] then
		if dragObj.blockPos[pos] == BLOCK_ASSIST then
			MsgManager.clientNotice(115)
		elseif dragObj.blockPos[pos] == BLOCK_SAME_ID then
			MsgManager.clientNotice(116)
		elseif dragObj.blockPos[pos] == BLOCK_OTHERTEAM then
			MsgManager.notice(string.format(Lang.get(30255), self.multiTeamIndex))
		else
			MsgManager.clientNotice(151)
		end

		if dragObj.pos then
			dragObj:put2Pos(dragObj.pos)

			return
		else
			self.delDragObj(dragObj, pos)
		end
	elseif pos == 99 then
		self.delDragObj(dragObj, pos)
	else
		local curObj = self.fieldObjs[pos]
		local needVoice = false
		local count = self.getObjectCount(nil, dragObj)

		if curObj then
			if curObj ~= dragObj then
				local curHero = curObj.hero
				local dragHero = dragObj.hero

				if curHero and dragHero and count >= self.MAX_PUT_COUNT and self.heroPutFilter[curHero.id] and not self.heroPutFilter[dragHero.id] then
					self.onDragLeave(dragObj, pos)
					DragPlane.putObject(99, dragObj)
					MsgManager.notice(string.format(Lang.get(81434), self.MAX_PUT_COUNT))

					return
				end

				if dragObj.pos then
					self.fieldObjs[dragObj.pos] = nil

					curObj:put2Pos(dragObj.pos)

					dragObj.pos = nil
				else
					if self.teamLimitCheck then
						local noTeamCount = self.getNoTeamCount(self.teamLimitCheck.limitTeam)

						if noTeamCount >= self.limitNoTeamNumber and dragObj.hero then
							local isNoTeam = true

							for _, team in ipairs(self.teamLimitCheck.limitTeam) do
								if dragObj.hero.team == team then
									isNoTeam = false

									break
								end
							end

							if isNoTeam then
								local curNoTeam = true

								for _, team in ipairs(self.teamLimitCheck.limitTeam) do
									if curObj.hero.team == team then
										curNoTeam = false

										break
									end
								end

								if not curNoTeam then
									self.onDragLeave(dragObj, pos)
									DragPlane.putObject(99, dragObj)
									MsgManager.notice(self.teamLimitCheck.limit_desc)

									return
								end
							end
						end
					end

					self.delDragObj(curObj, curObj.pos)

					needVoice = true
				end
			elseif oriPos == 99 then
				dragObj:put2Pos(dragObj.pos)
			end
		else
			if not (count >= self.MAX_PUT_COUNT) or dragObj.hero and self.heroPutFilter[dragObj.hero.id] then
				-- block empty
			else
				self.onDragLeave(dragObj, pos)
				DragPlane.putObject(99, dragObj)

				if next(self.heroPutFilter) then
					MsgManager.notice(string.format(Lang.get(81434), self.MAX_PUT_COUNT))
				else
					MsgManager.notice(string.format(Lang.get(30256), self.MAX_PUT_COUNT))
				end

				return
			end

			if not dragObj.pos and self.teamLimitCheck then
				local noTeamCount = self.getNoTeamCount(self.teamLimitCheck.limitTeam)

				if noTeamCount >= self.limitNoTeamNumber and dragObj.hero then
					local isNoTeam = true

					for _, team in ipairs(self.teamLimitCheck.limitTeam) do
						if dragObj.hero.team == team then
							isNoTeam = false

							break
						end
					end

					if isNoTeam then
						self.onDragLeave(dragObj, pos)
						DragPlane.putObject(99, dragObj)
						MsgManager.notice(self.teamLimitCheck.limit_desc)

						return
					end
				end
			end

			if not dragObj.pos then
				needVoice = true
			end
		end

		local startPos = dragObj.pos

		if dragObj.pos then
			self.fieldObjs[dragObj.pos] = nil
		end

		self.fieldObjs[pos] = dragObj
		dragObj.pos = pos

		dragObj:checkStartCue(self.playerEnterState)
		self._plane:ShowGridPutHint(pos, true)
		dragObj:playAnimator("OnDrag")

		if needVoice then
			dragObj:playDragVoice()
		end

		BeginnerManager.noticeFormation(dragObj, startPos, pos)
	end

	DragPlane.updateDragPanel()

	if pos == 99 then
		self:clearSkillArea()
	elseif dragObj.pos then
		self.onPutDragObjectSucc(dragObj)
	end

	if self._focusObj then
		self._focusObj:setSelect(false)
	end

	self._focusObj = dragObj

	dragObj:setSelect(true)
end

function DragPlane.updateDragPanel()
	local ui = ClientUtils.getNowDragDlg()

	if ui then
		ui:updateHeroBag()
	end
end

function DragPlane.onPutDragObjectSucc(dragObj)
	self.showCampOvercome(dragObj)
	self.startShowSkillArea(dragObj, true)
	self.showSupportInfo(dragObj)
end

function DragPlane.showSupportInfo(dragObj)
	local beSupported = false
	local objSuptPoses, maxNum = DragPlane._getSupportPos(dragObj, dragObj.pos)

	for i, suptPos in ipairs(objSuptPoses) do
		local suptObj = self.fieldObjs[suptPos]

		if suptObj then
			suptObj:onSupportEffect()
		end
	end

	for pos, otherObj in pairs(self.fieldObjs) do
		if beSupported then
			break
		elseif otherObj ~= dragObj and otherObj.camp == dragObj.camp then
			local objSuptPoses, maxNum = DragPlane._getSupportPos(otherObj, pos)

			for _, suptPos in ipairs(objSuptPoses) do
				if suptPos == dragObj.pos then
					beSupported = true

					break
				end
			end
		end
	end

	if beSupported then
		dragObj:onSupportedEffect()
	end
end

function DragPlane.showCampOvercome(dragObj, isLoop)
	if dragObj == nil then
		for _, otherObj in pairs(self.fieldObjs) do
			otherObj:stopBattleOvercome()
		end

		return
	end

	local camp

	if dragObj.hero then
		camp = dragObj.hero.camp
	else
		camp = dragObj.monster.camp
	end

	camp = BattleConst.HERO_CAMP_OVERCOME[camp]

	if camp then
		for _, otherObj in pairs(self.fieldObjs) do
			local raceOK = otherObj.hero and otherObj.hero.camp == camp or otherObj.monster and otherObj.monster.camp == camp
			local campOK = dragObj.isPlayer and not otherObj.isPlayer or not dragObj.isPlayer and otherObj.isPlayer

			if campOK and raceOK then
				otherObj:playBattleOvercome(isLoop)
			else
				otherObj:stopBattleOvercome()
			end
		end
	end
end

local TARGET_EFF = "Effects/Scene/Battlefield/efx_ui_Tips_01.prefab"
local TARGET_EFF_RED = "Effects/Scene/Battlefield/efx_ui_Tips_03.prefab"
local TARGET_EFF_GREEN = "Effects/Scene/Battlefield/efx_ui_Tips_05.prefab"
local GRID_EFF_RED = "Effects/Scene/Battlefield/efx_ui_Tips_02.prefab"
local GRID_EFF_GREEN = "Effects/Scene/Battlefield/efx_ui_Tips_04.prefab"

function DragPlane.startShowSkillArea(dragObj, needRecovery, pos)
	if pos == nil then
		pos = dragObj.pos
	end

	if self.preSkillAreaInfo then
		self.clearSkillArea(true)
	end

	local skillType = dragObj.hero and dragObj.hero.resData.attack_range or dragObj.monster.resData.attack_range
	local ca, skillTarget, grids = self.getSkillTargets(dragObj, pos)

	if ca then
		self.closeTargEff()

		self.preSkillAreaInfo = {
			ca
		}
		self.curTarget = ca

		ca:setTargetEff(skillType)
	else
		return
	end

	if needRecovery then
		if not self.skillAreaTimer then
			self.skillAreaTimer = Timer.New(self.clearSkillArea, 2, 1)
		end

		self.skillAreaTimer:Restart()
	elseif self.skillAreaTimer then
		self.skillAreaTimer:Stop()
	end

	if skillTarget then
		local tPos = skillTarget[1]
		local gridState = skillTarget[2]

		if gridState == GRID_RED then
			self.preSkillAreaInfo[3] = self._plane:AddGridEff(tPos, TARGET_EFF_RED)
		elseif gridState == GRID_GREEN then
			self.preSkillAreaInfo[3] = self._plane:AddGridEff(tPos, TARGET_EFF_GREEN)
		else
			self.preSkillAreaInfo[3] = self._plane:AddGridEff(tPos, TARGET_EFF)
		end
	end

	local gridsEff = {}

	for gridPos, gridState in pairs(grids) do
		if gridState == GRID_RED then
			gridsEff[gridPos] = self._plane:AddGridEff(gridPos, GRID_EFF_RED)
		else
			gridsEff[gridPos] = self._plane:AddGridEff(gridPos, GRID_EFF_GREEN)
		end
	end

	self.preSkillAreaInfo[4] = gridsEff
end

function DragPlane.closeTargEff()
	if self.curTarget then
		self.curTarget:closeTargetEff()
	end
end

function DragPlane.showSkillAreaDesc(skillInfo)
	local ui = UIManager.getUI("battleDragHeroDlg", nil, false)

	ui = ui or UIManager.getUI("mazeDragHeroDlg", nil, false)
	ui = ui or UIManager.getUI("newMazeDragHeroDlg", nil, false)

	if ui then
		ui:startShowSkillDesc(skillInfo)
	end
end

function DragPlane.clearSkillArea(changeNext)
	if self.preSkillAreaInfo then
		local ca = self.preSkillAreaInfo[1]
		local targetEff = self.preSkillAreaInfo[3]

		if targetEff then
			targetEff:TurnOffAndDespawn()
		end

		local gridEffs = self.preSkillAreaInfo[4]

		if gridEffs then
			for pos, cont in pairs(gridEffs) do
				cont:TurnOffAndDespawn()
			end
		end

		local ui = UIManager.getUI("battleDragHeroDlg", nil, false)

		ui = ui or UIManager.getUI("mazeDragHeroDlg", nil, false)

		if ui and not changeNext then
			ui:stopShowSkillDesc()
		end

		self.preSkillAreaInfo = nil
	end
end

function DragPlane.onDragClick(sender, tgtPos)
	if sender.isMisteryMan then
		MsgManager.clientNotice(329)

		return
	end

	if self._focusObj then
		self._focusObj:setSelect(false)
	end

	self.showCampOvercome(sender)

	if self.showTips then
		local tips = UIManager.getUI("battleDragHeroTips")

		tips:show(sender)
		tips:correctPos(tgtPos < 0)

		local ui = UIManager.getUI("battleDragHeroDlg", nil, false)

		ui = ui or UIManager.getUI("mazeDragHeroDlg", nil, false)

		if ui then
			ui:onListToggle()
		end
	else
		self.startShowSkillArea(sender, true)
	end

	self._focusObj = sender

	sender:setSelect(true)
end

function DragPlane.onDragCatch(sender, tgtPos)
	self.showBlock(sender, sender.hero)
	self.showSupport(sender, tgtPos, false)
	self.showCampOvercome(sender, true)
end

function DragPlane.onDragPut(sender, tgtPos)
	self.showCampOvercome(nil)
	self.putObject(tgtPos, sender)
	self.showBlock(sender)
	self:checkBattleCondition()
end

function DragPlane.onDragEnter(sender, tgtPos)
	if self._focusObj then
		self._focusObj:setSelect(false)
	end

	self._focusObj = sender

	sender:setSelect(true)

	if sender.blockPos[tgtPos] then
		return
	end

	self.showSupport(sender, tgtPos, true)
	self._plane:ShowGridPutHint(tgtPos, false)

	if tgtPos and tgtPos <= BattleConst.BATTLE_MAX_POS and tgtPos >= -BattleConst.BATTLE_MAX_POS then
		self.startShowSkillArea(sender, false, tgtPos)
	end
end

function DragPlane.onDragLeave(sender, tgtPos)
	self.showSupport(sender, tgtPos, false)
	self._plane:ShowGridPutHint(99, false)
	self.closeTargEff()

	self.curTarget = nil
end

local CAMP_ATTACK = 0
local CAMP_HEAL = 1

local function AddCoordToContainer(coord, container, value)
	local key = self.GridConfig.CoordToPos[coord]

	if key then
		container[key] = value
	end
end

local function getForward(pos, defaultGridState, outGrids)
	local coord = self.GridConfig.PosToCoord[pos]

	if pos > 0 then
		AddCoordToContainer(coord + 1, outGrids, defaultGridState)
	else
		AddCoordToContainer(coord - 1, outGrids, defaultGridState)
	end
end

local function getForwardTwo(pos, defaultGridState, outGrids)
	local coord = self.GridConfig.PosToCoord[pos]

	if pos > 0 then
		AddCoordToContainer(coord + 1, outGrids, defaultGridState)
		AddCoordToContainer(coord + 2, outGrids, defaultGridState)
	else
		AddCoordToContainer(coord - 1, outGrids, defaultGridState)
		AddCoordToContainer(coord - 2, outGrids, defaultGridState)
	end
end

local function getForwardSector(pos, defaultGridState, outGrids)
	local coord = self.GridConfig.PosToCoord[pos]

	if pos > 0 then
		AddCoordToContainer(coord + 1, outGrids, defaultGridState)
	else
		AddCoordToContainer(coord - 1, outGrids, defaultGridState)
	end

	local nowLine = math.floor(coord / BattleMiscConfig.ONE_LINE_MAX)
	local index = coord % BattleMiscConfig.ONE_LINE_MAX
	local isLonger = false

	if self.GridConfig.LineNumConfig[nowLine + 1] and self.GridConfig.LineNumConfig[nowLine + 1] < self.GridConfig.LineNumConfig[nowLine] then
		isLonger = true
	elseif self.GridConfig.LineNumConfig[nowLine - 1] and self.GridConfig.LineNumConfig[nowLine - 1] < self.GridConfig.LineNumConfig[nowLine] then
		isLonger = true
	end

	if isLonger and pos > 0 then
		AddCoordToContainer(nowLine * BattleMiscConfig.ONE_LINE_MAX + BattleMiscConfig.ONE_LINE_MAX + index, outGrids, defaultGridState)
		AddCoordToContainer(nowLine * BattleMiscConfig.ONE_LINE_MAX - BattleMiscConfig.ONE_LINE_MAX + index, outGrids, defaultGridState)
	elseif isLonger and pos < 0 then
		AddCoordToContainer(nowLine * BattleMiscConfig.ONE_LINE_MAX + BattleMiscConfig.ONE_LINE_MAX - 1 + index, outGrids, defaultGridState)
		AddCoordToContainer(nowLine * BattleMiscConfig.ONE_LINE_MAX - BattleMiscConfig.ONE_LINE_MAX - 1 + index, outGrids, defaultGridState)
	elseif pos > 0 then
		AddCoordToContainer(nowLine * BattleMiscConfig.ONE_LINE_MAX + BattleMiscConfig.ONE_LINE_MAX + 1 + index, outGrids, defaultGridState)
		AddCoordToContainer(nowLine * BattleMiscConfig.ONE_LINE_MAX - BattleMiscConfig.ONE_LINE_MAX + 1 + index, outGrids, defaultGridState)
	else
		AddCoordToContainer(nowLine * BattleMiscConfig.ONE_LINE_MAX + BattleMiscConfig.ONE_LINE_MAX + index, outGrids, defaultGridState)
		AddCoordToContainer(nowLine * BattleMiscConfig.ONE_LINE_MAX - BattleMiscConfig.ONE_LINE_MAX + index, outGrids, defaultGridState)
	end
end

local function getNearBy(pos, defaultGridState, outGrids)
	for _, nebPos in ipairs(self.GridConfig.NebConfig[pos]) do
		outGrids[nebPos] = defaultGridState
	end
end

local function getNearByTwo(pos, defaultGridState, outGrids)
	local nebs = self.GridConfig.NebConfig[pos]

	for _, nebPos in ipairs(self.GridConfig.NebConfig[pos]) do
		outGrids[nebPos] = defaultGridState

		for _, nebNebPos in ipairs(self.GridConfig.NebConfig[nebPos]) do
			outGrids[nebNebPos] = defaultGridState
		end
	end
end

local function getLine(pos, defaultGridState, outGrids)
	local coord = self.GridConfig.PosToCoord[pos]
	local nowLine = math.floor(coord / BattleMiscConfig.ONE_LINE_MAX)

	for _, tPos in ipairs(self.GridConfig.LineConfig[nowLine]) do
		outGrids[tPos] = defaultGridState
	end
end

local function getTargetTwo(outCATarget, defaultGridState, outGrids)
	local tLen = 2

	if outCATarget.monster and outCATarget.monster.resData.big_monster == 1 then
		tLen = 3
	end

	local coord = self.GridConfig.PosToCoord[outCATarget.pos]

	if outCATarget.pos < 0 and tLen == 2 then
		AddCoordToContainer(coord, outGrids, defaultGridState)
		AddCoordToContainer(coord + 1, outGrids, defaultGridState)
	elseif outCATarget.pos < 0 and tLen == 3 then
		AddCoordToContainer(coord, outGrids, defaultGridState)
		AddCoordToContainer(coord + 1, outGrids, defaultGridState)
		AddCoordToContainer(coord + 2, outGrids, defaultGridState)
	else
		AddCoordToContainer(coord, outGrids, defaultGridState)
		AddCoordToContainer(coord - 1, outGrids, defaultGridState)
	end
end

function DragPlane.getSkillTargets(dragObj, pos)
	local outCATarget, outSkillTarget
	local outGrids = {}
	local outCATarget = self:_searchLineEnemy(pos)
	local cardId
	local cardLevel = 1

	if dragObj.hero and dragObj.hero.skillLast then
		cardId = dragObj.hero.skillLast.id
		cardLevel = dragObj.hero.skillLast.level
	elseif dragObj.monster and dragObj.monster.skillLast then
		cardId = dragObj.monster.skillLast.id
		cardLevel = dragObj.monster.skillLast.level
	end

	local configData = ResSkillConfig[cardId] or {}

	configData = configData[cardLevel]

	self.showSkillAreaDesc(configData)

	configData = configData or {}

	local skillCamp = configData.skill_camp or CAMP_ATTACK
	local skillTarget = configData.skill_target

	if not skillTarget then
		return outCATarget, outSkillTarget, outGrids
	end

	if not outCATarget then
		return outCATarget, outSkillTarget, outGrids
	end

	local defaultGridState = GRID_RED

	if skillCamp == CAMP_HEAL then
		defaultGridState = GRID_GREEN
	end

	if skillTarget == 1 then
		outSkillTarget = {
			pos
		}

		getForward(pos, defaultGridState, outGrids)
	elseif skillTarget == 2 then
		outSkillTarget = {
			pos
		}

		getForwardTwo(pos, defaultGridState, outGrids)
	elseif skillTarget == 3 then
		outSkillTarget = {
			pos
		}

		getForwardSector(pos, defaultGridState, outGrids)
	elseif skillTarget == 4 then
		outSkillTarget = {
			pos
		}

		getNearBy(pos, defaultGridState, outGrids)
	elseif skillTarget == 5 then
		outSkillTarget = {
			pos,
			defaultGridState
		}

		getLine(pos, defaultGridState, outGrids)

		outGrids[pos] = nil
	elseif skillTarget == 6 then
		outSkillTarget = {
			outCATarget.pos,
			defaultGridState
		}
	elseif skillTarget == 7 then
		outSkillTarget = {
			outCATarget.pos,
			defaultGridState
		}

		getLine(outCATarget.pos, defaultGridState, outGrids)

		outGrids[outCATarget.pos] = nil
	elseif skillTarget == 8 then
		local farestTarget = self:_searchLineEnemy(pos, true)

		if farestTarget then
			outGrids[farestTarget.pos] = defaultGridState
		end
	elseif skillTarget == 9 then
		outSkillTarget = {
			outCATarget.pos,
			defaultGridState
		}

		if outSkillTarget then
			getNearBy(outCATarget.pos, defaultGridState, outGrids)

			outGrids[outCATarget.pos] = nil
		end
	elseif skillTarget == 10 then
		outSkillTarget = {
			outCATarget.pos,
			GRID_RED
		}

		getNearBy(outCATarget.pos, GRID_GREEN, outGrids)
	elseif skillTarget == 11 then
		local needHero = true

		if pos > 0 and skillCamp == CAMP_ATTACK then
			needHero = false
		elseif pos < 0 and skillCamp == CAMP_HEAL then
			needHero = false
		end

		for aPos = 1, BattleConst.BATTLE_MAX_POS do
			if needHero then
				outGrids[aPos] = defaultGridState
			else
				outGrids[-aPos] = defaultGridState
			end
		end
	elseif skillTarget == 12 then
		local farestTarget = self:_searchLineEnemy(-pos, false, true)

		if farestTarget then
			outGrids[farestTarget.pos] = defaultGridState
		end
	elseif skillTarget == 13 then
		for linePos = 1, #self.GridConfig.LineConfig do
			local farestTarget = self:_searchLineEnemyByLine(-pos, false, true, linePos)

			if farestTarget then
				outGrids[farestTarget.pos] = defaultGridState
			end
		end
	elseif skillTarget == 14 then
		for linePos = 1, #self.GridConfig.LineConfig do
			local farestTarget = self:_searchLineEnemyByLine(-pos, true, true, linePos)

			if farestTarget then
				outGrids[farestTarget.pos] = defaultGridState
			end
		end
	elseif skillTarget == 15 then
		for linePos = 1, #self.GridConfig.LineConfig do
			local farestTarget = self:_searchLineEnemyByLine(pos, false, true, linePos)

			if farestTarget then
				outGrids[farestTarget.pos] = defaultGridState
			end
		end
	elseif skillTarget == 16 then
		for linePos = 1, #self.GridConfig.LineConfig do
			local farestTarget = self:_searchLineEnemyByLine(pos, true, true, linePos)

			if farestTarget then
				outGrids[farestTarget.pos] = defaultGridState
			end
		end
	elseif skillTarget == 17 then
		outSkillTarget = {
			pos,
			defaultGridState
		}

		if outSkillTarget then
			getNearByTwo(pos, defaultGridState, outGrids)

			outGrids[pos] = nil
		end
	elseif skillTarget == 18 then
		outSkillTarget = {
			outCATarget.pos
		}

		getTargetTwo(outCATarget, defaultGridState, outGrids)
	end

	return outCATarget, outSkillTarget, outGrids
end

function DragPlane._searchOneLineEnemy(pos, isFar, nowLine)
	local nowLineConfig = self.GridConfig.LineConfig[nowLine]

	if nowLineConfig then
		local nowLineAllNum = #nowLineConfig
		local nowLineHalfNum = math.floor(nowLineAllNum / 2)

		if pos > 0 and isFar then
			for index = nowLineAllNum, nowLineHalfNum, -1 do
				local mPos = nowLineConfig[index]

				if self.fieldObjs[mPos] and mPos < 0 then
					return self.fieldObjs[mPos]
				end
			end
		elseif pos > 0 then
			for index = nowLineHalfNum, nowLineAllNum do
				local mPos = nowLineConfig[index]

				if self.fieldObjs[mPos] and mPos < 0 then
					return self.fieldObjs[mPos]
				end
			end
		elseif isFar then
			for index = 1, nowLineHalfNum do
				local mPos = nowLineConfig[index]

				if self.fieldObjs[mPos] and mPos > 0 then
					return self.fieldObjs[mPos]
				end
			end
		else
			for index = nowLineHalfNum, 1, -1 do
				local mPos = nowLineConfig[index]

				if self.fieldObjs[mPos] and mPos > 0 then
					return self.fieldObjs[mPos]
				end
			end
		end
	end
end

function DragPlane:_searchLineEnemy(pos, isFar, onlySelfLine)
	local coord = self.GridConfig.PosToCoord[pos]
	local nowLine = math.floor(coord / BattleMiscConfig.ONE_LINE_MAX)
	local lineResult = self._searchOneLineEnemy(pos, isFar, nowLine)

	if lineResult then
		return lineResult
	end

	if not onlySelfLine then
		for index = 1, #self.GridConfig.LineConfig do
			local upResult = self._searchOneLineEnemy(pos, isFar, nowLine + index)

			if upResult then
				return upResult
			end

			local downResult = self._searchOneLineEnemy(pos, isFar, nowLine - index)

			if downResult then
				return downResult
			end
		end
	end
end

function DragPlane:_searchLineEnemyByLine(posFlag, isFar, onlySelfLine, nowLine)
	local lineResult = self._searchOneLineEnemy(posFlag, isFar, nowLine)

	if lineResult then
		return lineResult
	end

	if not onlySelfLine then
		for index = 1, #self.GridConfig.LineConfig do
			local upResult = self._searchOneLineEnemy(posFlag, isFar, nowLine + index)

			if upResult then
				return upResult
			end

			local downResult = self._searchOneLineEnemy(posFlag, isFar, nowLine - index)

			if downResult then
				return downResult
			end
		end
	end
end

local ENTER_INTERVAL = 0.1
local MAX_ENTER_NUMBER = 10

function DragPlane.startObjEntering()
	self.inObjectEntering = true

	if not self.enterTimer then
		self.enterTimer = Timer.New(self.timerCheckObjEnter, ENTER_INTERVAL, -1)
	end

	self.enterTimer:Restart()

	self.canEnterNumber = 0
end

function DragPlane.timerCheckObjEnter()
	self.canEnterNumber = self.canEnterNumber + 2

	if self.canEnterNumber > MAX_ENTER_NUMBER then
		self.inObjectEntering = false

		self.enterTimer:Stop()
	end

	self.onCheckObjEnter()
end

function DragPlane.onCheckObjEnter()
	local canEnterPlayer = {}
	local canEnterMonster = {}
	local nowEnterNumPlayer = 0
	local nowEnterNumMonster = 0

	for pos, obj in pairs(self.fieldObjs) do
		if obj.modelLoaded then
			if obj:isModelInShow() then
				if pos > 0 then
					nowEnterNumPlayer = nowEnterNumPlayer + 1
				else
					nowEnterNumMonster = nowEnterNumMonster + 1
				end
			elseif pos > 0 then
				table.insert(canEnterPlayer, obj)
			elseif pos < 0 then
				table.insert(canEnterMonster, obj)
			end
		end
	end

	for index, obj in ipairs(canEnterPlayer) do
		if nowEnterNumPlayer + index - 1 < self.canEnterNumber then
			obj:onEnterGame()
		else
			break
		end
	end

	for index, obj in ipairs(canEnterMonster) do
		if nowEnterNumMonster + index - 1 < self.canEnterNumber then
			obj:onEnterGame()
		else
			break
		end
	end
end

return DragPlane
