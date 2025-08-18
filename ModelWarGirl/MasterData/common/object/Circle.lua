-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Common\\Object\\Circle.lua

local ResClanLevel = require("ClientData/ResClanLevel")
local ResClanBattleRune = require("ClientData/ResClanBattleRune")
local ResClanBattleMonster = require("ClientData/ResClanBattleMonster")
local ResClanBattleLayer = require("ClientData/ResClanBattleLayer")
local ResClanBattleMemberAchieve = require("ClientData/ResClanBattleMemberAchieve")
local ResClanBattleClanAchieve = require("ClientData/ResClanBattleClanAchieve")
local ResClanBattleScore = require("ClientData/ResClanBattleScore")
local CircleControlCenter = require("Logic/Circle/CircleControlCenter")
local ResBattleConfig = require("ClientData/ResBattleConfig")
local ResClanExploreTalent = require("ClientData/ResClanExploreTalent")
local ResClanBattleTalent = require("ClientData/ResClanBattleTalent")
local ResClanBattleTitle = require("ClientData/ResClanBattleTitle")
local ResClanBattleMisc = require("ClientData/ResClanBattleMisc")
local ResClanHeadFrame = require("ClientData/ResClanHeadFrame")
local ResClanHead = require("ClientData/ResClanHead")
local ResClanMisc = require("ClientData/ResClanMisc")
local CircleSkill = require("Common/Object/CircleSkill")
local strClassName = "Circle"
local Circle = Class(strClassName)

function Circle:ctor(circleData, simple)
	self:_initData(circleData, simple)
end

local function _sortLog(a, b)
	if a.tick ~= b.tick then
		return a.tick > b.tick
	else
		return a.base.uid > b.base.uid
	end
end

function Circle:_initData(circleData, simple)
	self.circleSvrData = circleData

	if simple then
		self.gid = circleData.clangid or 0
		self.name = circleData.clanname or ""
		self.level = circleData.level or 1
		self.weekExp = circleData.weekfeat or 0
		self.memberCount = circleData.member_cnt or 0
		self.headId = circleData.head or 1
		self.headFrameId = circleData.head_frame or 0
		self.haveFrameDic = {}
		self.haveFrameDic[self.headFrameId] = {}
		self.haveFrameDic[self.headFrameId].id = self.headFrameId
		self.haveFrameDic[self.headFrameId].endTime = circleData.head_frame_end_time
	else
		self.gid = circleData.base.clangid or 0
		self.name = circleData.base.clanname or ""
		self.level = circleData.base.level or 1
		self.memberCount = circleData.base.member_cnt or 0
		self.weekExp = circleData.base.weekfeat or 0
		self.headId = circleData.base.head or 1
		self.exp = circleData.feat or 0

		if circleData.title and circleData.title ~= "" then
			self.title = circleData.title
		else
			self.title = Lang.get(29930)
		end

		if circleData.notice and circleData.notice ~= "" then
			self.notice = circleData.notice
		else
			self.notice = Lang.get(29931)
		end

		self.fund = circleData.fund or 0
		self.createTick = circleData.create_time or 0
		self.isAutoPass = circleData.auto_accept or 0
		self.signNum = circleData.checkin_num or 0
		self.renameTick = circleData.rename_tick
		self.renoticeTick = circleData.renotice_tick
		self.reheadTick = circleData.rehead_tick
		self.shareTick = circleData.share_tick
		self.applyRoleDataDic = {}

		self:refreshApplyList(circleData.apply)

		self.memberDic = {}

		local members = utils.deepcopy(circleData.member)

		for _, member in ipairs(members) do
			if member.duty == Const.CIRCLE_DUTY_BOSS then
				self.leaderUid = member.base.uid
			end

			if member.base.uid == CurAvatar.uid then
				member.base = CurAvatar:getMyRoleSimpleComm()
			end

			self.memberDic[member.base.uid] = member
		end

		self.logs = utils.deepcopy(circleData.log)

		table.sort(self.logs, _sortLog)

		self.maxBattleLayer = circleData.max_layer or 0
		self.headFrameId = circleData.base.head_frame or 0
		self.reheadFrameTick = circleData.re_head_frame_tick
		self.haveFrameDic = {}

		for _, frameData in ipairs(circleData.head_frame) do
			self.haveFrameDic[frameData.id] = {}
			self.haveFrameDic[frameData.id].id = frameData.id
			self.haveFrameDic[frameData.id].endTime = frameData.expire
		end

		if Const.FORCE_OPEN_CIRCLE_BATTLE and circleData.battle_data then
			self:analyBattleData(circleData.battle_data)
			self:_ensureMemberOp()
		end

		self.invitePlayerDic = {}

		for _, inviteData in ipairs(circleData.invitee) do
			self.invitePlayerDic[inviteData.uid] = {}
			self.invitePlayerDic[inviteData.uid].uid = inviteData.uid
			self.invitePlayerDic[inviteData.uid].tick = inviteData.tick
		end

		self:initClanOpData(circleData.opact)
	end
end

function Circle:addInvitePlayer(uid, tick)
	self.invitePlayerDic[uid] = {}
	self.invitePlayerDic[uid].uid = uid
	self.invitePlayerDic[uid].tick = tick
end

function Circle:delInvitePlayer(uid)
	if self.invitePlayerDic[uid] then
		self.invitePlayerDic[uid] = nil
	end
end

function Circle:playerIsIvited(uid)
	return self.invitePlayerDic[uid] ~= nil
end

local function _sortInvitePlayerData(a, b)
	if a.tick ~= b.tick then
		return a.tick < b.tick
	else
		return a.uid < b.uid
	end
end

function Circle:getInvitePlayerList()
	local invitePlayerList = {}
	local validTime = ResClanMisc[1].invite_duetime * 3600

	for uid, invitePlayerData in pairs(self.invitePlayerDic) do
		if ClientUtils.getServerTime() < invitePlayerData.tick + validTime then
			table.insert(invitePlayerList, invitePlayerData)
		else
			self.invitePlayerDic[uid] = nil
		end
	end

	table.sort(invitePlayerList, _sortInvitePlayerData)

	return invitePlayerList
end

function Circle:isInviteListMax()
	local invitePlayerList = self:getInvitePlayerList()

	return #invitePlayerList >= Const.MAX_CIRCLE_INVITE_NUM
end

function Circle:getHeadFrameEndTimeTick()
	local endTime = 0

	if self.haveFrameDic[self.headFrameId] then
		endTime = self.haveFrameDic[self.headFrameId].endTime
	end

	return endTime
end

function Circle:analyBattleData(battleData)
	self.battleData = {}
	self.battleData.contribution = battleData.contribution
	self.battleData.layer = battleData.layer
	self.battleData.order = battleData.order

	if self.battleData.order == 0 then
		self.battleData.order = 1
	end

	self.battleData.gridData = utils.deepcopy(battleData.field.grid)
	self.battleData.monsterDic = {}

	for i, info in ipairs(battleData.field.monster_grid) do
		self:refreshMonsterInfo(info.pos + 1, info.monster, info.pvestart_uid, self.battleData.layer)
	end

	self:initMarkedGridData(battleData.field.marked_grid)

	self.battleSkillDic = {}

	if battleData.skill then
		for _, skillData in ipairs(battleData.skill) do
			local circleSkill = CircleSkill(skillData.id, skillData)

			self.battleSkillDic[skillData.id] = circleSkill
		end
	end

	self.runeDataList = {}

	local data = self:getGridData()

	if data then
		for i, info in ipairs(data) do
			if info.status == Const.CIRCLE_GRID_STATUS.OPEN and info.type == Const.CIRCLE_GRID_OPEN_TYPE.RUNE then
				self:addRuneData(info.param)
			end
		end
	end

	self:analyAchieveData(battleData)

	self.battleData.target = battleData.target

	self:refreshBattleTarget()

	self.battleData.layerTick = battleData.layer_tick or 0

	self:analyTalentData(battleData)

	local battleMemberData = self:getMyBattleMemberData()

	if battleMemberData and battleMemberData.infuseid then
		self.injectionPointIdDic = ClientUtils.getBitsDictFromByteString(battleMemberData.infuseid)
	end
end

function Circle:refreshBattleTarget()
	if self.battleData.target == 0 then
		self.battleData.target = Const.DEFAULT_TARGET_CIRCLE_ACHIEVE
	else
		local achieveData = self:getCircleAchieveDataIgnoreGot(self.battleData.target)

		if achieveData.isEnd == 1 and achieveData.status ~= Const.ACHIEVE_STATUS.IN_PROCESS then
			self.battleData.target = Const.DEFAULT_TARGET_CIRCLE_ACHIEVE
		end
	end
end

function Circle:addHeadFrame(id, endTime)
	self.haveFrameDic[id] = {}
	self.haveFrameDic[id].id = id
	self.haveFrameDic[id].endTime = endTime
end

function Circle:getCanUseHeadFrameList()
	local headFrameList = {}

	for id, svrData in pairs(self.haveFrameDic) do
		if ResClanHeadFrame[id] then
			local headFrameData = {}

			headFrameData.resData = ResClanHeadFrame[id]
			headFrameData.svrData = svrData

			table.insert(headFrameList, headFrameData)
		end
	end

	return headFrameList
end

function Circle:analyTalentData(battleData)
	self.exploreTalentDic = {}

	local battleMemberData = self:getMyBattleMemberData()

	if battleMemberData and battleMemberData.explore_talent then
		for _, talentData in ipairs(battleMemberData.explore_talent) do
			self.exploreTalentDic[talentData.id] = talentData
		end
	end

	self.activeExploreTalentDic = {}

	for i, resData in ipairs(ResClanExploreTalent) do
		if self:getCurExploreProficiency() >= resData.proficiency then
			self.activeExploreTalentDic[resData.id] = true
		end
	end

	self.battleTalentDic = {}

	local battleMemberData = self:getMyBattleMemberData()

	if battleMemberData and battleMemberData.battle_talent then
		for _, talentData in ipairs(battleMemberData.battle_talent) do
			self.battleTalentDic[talentData.id] = talentData
		end
	end

	self.activeBattleTalentDic = {}

	for i, resData in ipairs(ResClanBattleTalent) do
		if self:getCurBattleProficiency() >= resData.proficiency then
			self.activeBattleTalentDic[resData.id] = true
		end
	end
end

function Circle:analyAchieveData(battleData)
	local battleMemberData = self:getMyBattleMemberData()

	self.circleAchieveGetDic = {}

	if battleMemberData and battleMemberData.achieve and battleMemberData.achieve.clan_award_bit and battleMemberData.achieve.clan_award_bit.bits then
		self.circleAchieveGetDic = ClientUtils.getBitsDictFromByteString(battleMemberData.achieve.clan_award_bit.bits)
	end

	self.circleAchieveDataDic = {}

	if battleData.achieve and battleData.achieve.progress then
		for actionType, progressInfo in pairs(battleData.achieve.progress) do
			local achieveData = CurAvatar:analyCircleAchieveData(actionType, progressInfo.progress, self.circleAchieveGetDic)

			self.circleAchieveDataDic[actionType] = achieveData
		end
	end

	for id, achieveResData in pairs(ResClanBattleClanAchieve) do
		if achieveResData.action_type and not self.circleAchieveDataDic[achieveResData.action_type] then
			local progress = 0
			local achieveData = CurAvatar:analyCircleAchieveData(achieveResData.action_type, progress, self.circleAchieveGetDic)

			self.circleAchieveDataDic[achieveResData.action_type] = achieveData
		end
	end

	self.memberAchieveDataDic = {}
	self.memberAchieveGetDic = {}

	if battleMemberData and battleMemberData.achieve and battleMemberData.achieve.award_bit and battleMemberData.achieve.award_bit.bits then
		self.memberAchieveGetDic = ClientUtils.getBitsDictFromByteString(battleMemberData.achieve.award_bit.bits)
	end

	if CurAvatar and battleMemberData and battleMemberData.achieve and battleMemberData.achieve.progress then
		for actionType, progressInfo in pairs(battleMemberData.achieve.progress) do
			local achieveData = CurAvatar:analyMemberAchieveData(actionType, progressInfo.progress, self.memberAchieveGetDic)

			self.memberAchieveDataDic[actionType] = achieveData
		end
	end

	for id, achieveResData in pairs(ResClanBattleMemberAchieve) do
		if achieveResData.action_type and not self.memberAchieveDataDic[achieveResData.action_type] then
			local progress = 0
			local achieveData = CurAvatar:analyMemberAchieveData(achieveResData.action_type, progress, self.memberAchieveGetDic)

			self.memberAchieveDataDic[achieveResData.action_type] = achieveData
		end
	end
end

function Circle:_ensureMemberOp()
	for uid, member in pairs(self.memberDic or {}) do
		if member.battle_data then
			local info = Const.CIRCLE_TIMER_CONFIG[member.battle_data.optype]

			if not member.battle_data.oppos then
				member.battle_data.oppos = -1
			end

			if info and member.battle_data.optick + info.tick < ClientUtils.getServerTime() then
				member.battle_data.optype = Const.CIRCLE_TIMER_TYPE.NONE
			end

			if CurAvatar.circleRoleData.clangid == self.gid then
				CurAvatar:addCircleBattleTimer(member.battle_data.optype, member.base.uid, member.battle_data.optick, member.battle_data.oppos, self:getCurBattleLayer())
			end
		end
	end
end

function Circle:getCurBattleLayer()
	if self.battleData then
		return self.battleData.layer
	end
end

function Circle:getCurBattleLayerTick()
	if self.battleData then
		return self.battleData.layerTick
	end
end

function Circle:setCurBattleLayerTick(tick)
	if self.battleData then
		self.battleData.layerTick = tick
	end
end

function Circle:getCurBattleLayerConfig(...)
	local layer = self:getCurBattleLayer()

	if layer then
		return ResClanBattleLayer[layer]
	end
end

function Circle:getBattleLayerConfig(layer)
	if layer then
		return ResClanBattleLayer[layer]
	end
end

function Circle:getCircleBattleSkill(circieSkillId)
	return self.battleSkillDic[circieSkillId]
end

function Circle:addRuneData(id)
	self.runeDataList = self.runeDataList or {}

	if ResClanBattleRune[id] then
		local runeData = {}

		runeData.resData = ResClanBattleRune[id]

		table.insert(self.runeDataList, runeData)
	end
end

function Circle:getRuneDataList()
	return self.runeDataList
end

function Circle:getCombineRuneDataList()
	local combineRuneDataList = {}
	local combineRuneDataDic = {}

	for _, runeData in ipairs(self:getRuneDataList()) do
		if not combineRuneDataDic[runeData.resData.id] then
			combineRuneDataDic[runeData.resData.id] = {}
			combineRuneDataDic[runeData.resData.id].combineValue = 0
			combineRuneDataDic[runeData.resData.id].resData = runeData.resData
		end

		if runeData.resData.props and runeData.resData.props[1] then
			combineRuneDataDic[runeData.resData.id].combineValue = combineRuneDataDic[runeData.resData.id].combineValue + runeData.resData.props[1].value
		else
			combineRuneDataDic[runeData.resData.id].combineValue = combineRuneDataDic[runeData.resData.id].combineValue + runeData.resData.prop_value
		end
	end

	for _, combineRuneData in pairs(combineRuneDataDic) do
		table.insert(combineRuneDataList, combineRuneData)
	end

	return combineRuneDataList
end

function Circle:addCircleBattleSkill(circieSkill)
	self.battleSkillDic[circieSkill.id] = circieSkill
end

function Circle:refreshCircleBattleSkill(serverSkill)
	local skill = self.battleSkillDic[serverSkill.id]

	if skill then
		skill:refreshLeftTimes(serverSkill.left_times)
	end
end

function Circle:getBattleData()
	if self.battleData then
		return self.battleData
	end
end

function Circle:getLayerProConditionDataList()
	local curLayerConditionInfo = self:getCurLayerConditionInfo()
	local curBattleLayerConfig = self:getCurBattleLayerConfig()
	local conditonDataList = {}

	if curBattleLayerConfig and curLayerConditionInfo then
		local conditonData1 = {}

		conditonData1.curNum = curLayerConditionInfo.bossDead and 1 or 0
		conditonData1.totalNum = 1
		conditonData1.name = ClientUtils.getClientNotice(502)

		table.insert(conditonDataList, conditonData1)

		local conditonData2 = {}

		conditonData2.curNum = curLayerConditionInfo.boxNum
		conditonData2.totalNum = curBattleLayerConfig.box_num
		conditonData2.name = ClientUtils.getClientNotice(503)

		table.insert(conditonDataList, conditonData2)

		local conditonData3 = {}

		conditonData3.curNum = curLayerConditionInfo.connectEnd and 1 or 0
		conditonData3.totalNum = 1
		conditonData3.name = ClientUtils.getClientNotice(504)

		table.insert(conditonDataList, conditonData3)

		return conditonDataList
	end
end

function Circle:setOrder(order)
	if self.battleData then
		self.battleData.order = order
	end
end

function Circle:setTarget(target)
	if self.battleData then
		self.battleData.target = target

		self:refreshBattleTarget()
	end
end

function Circle:getGridData(...)
	if self.battleData then
		return self.battleData.gridData
	end
end

function Circle:getGridInfo(index, layer)
	if layer and layer ~= self:getCurBattleLayer() then
		return
	end

	local data = self:getGridData()

	if data then
		return data[index]
	end
end

function Circle:isDebuffWork(...)
	local data = self:getGridData()

	if data then
		local openNum = 0
		local totalNum = 0

		for i, info in ipairs(data) do
			if info.type == nil or info.type == 0 or info.type >= Const.CIRCLE_GRID_OPEN_TYPE.NONE then
				totalNum = totalNum + 1

				if info.status == Const.CIRCLE_GRID_STATUS.SHOW or info.status == Const.CIRCLE_GRID_STATUS.OPEN then
					openNum = openNum + 1
				end
			end
		end

		if totalNum ~= 0 then
			return math.floor(openNum * 10000 / totalNum) >= ResClanBattleMisc[1].all_show_need_grid
		end
	else
		return false
	end

	return false
end

function Circle:isBossDead(layer)
	if layer and layer < self:getCurBattleLayer() then
		return true
	end

	local data = self:getGridData()

	if data then
		for i, info in ipairs(data) do
			if info.type == Const.CIRCLE_GRID_OPEN_TYPE.BOSS and info.status == Const.CIRCLE_GRID_STATUS.OPEN then
				return true
			end
		end
	end
end

function Circle:isNeedUseSkill(...)
	local data = self:getGridData()
	local config = self:getCurBattleLayerConfig()

	if data and config then
		local foundBossNum, foundBoxNum, foundRuneNum = 0, 0, 0

		for i, info in ipairs(data) do
			if info.type == Const.CIRCLE_GRID_OPEN_TYPE.BOSS then
				foundBossNum = foundBossNum + 1
			elseif info.type == Const.CIRCLE_GRID_OPEN_TYPE.RUNE then
				foundRuneNum = foundRuneNum + 1
			elseif info.type == Const.CIRCLE_GRID_OPEN_TYPE.BOX then
				foundBoxNum = foundBoxNum + 1
			end
		end

		return foundBossNum == 1, foundRuneNum == config.rune_num, foundBoxNum == config.box_num
	end
end

function Circle:isAllBoxFound(layer)
	if layer and layer < self:getCurBattleLayer() then
		return true
	end

	local config = self:getCurBattleLayerConfig()

	if config then
		local data = self:getGridData()
		local num = 0

		if data then
			for i, info in ipairs(data) do
				if info.type == Const.CIRCLE_GRID_OPEN_TYPE.BOX and info.status == Const.CIRCLE_GRID_STATUS.OPEN then
					num = num + 1
				end
			end
		end

		return num == config.box_num
	end
end

function Circle:getCurLayerConditionInfo(...)
	local isBossDead = false
	local foundBoxNum = 0
	local data = self:getGridData()

	if data then
		for i, info in ipairs(data) do
			if info.type == Const.CIRCLE_GRID_OPEN_TYPE.BOSS and info.status == Const.CIRCLE_GRID_STATUS.OPEN then
				isBossDead = true
			end

			if info.type == Const.CIRCLE_GRID_OPEN_TYPE.BOX and info.status == Const.CIRCLE_GRID_STATUS.OPEN then
				foundBoxNum = foundBoxNum + 1
			end
		end
	end

	local isConnectEnd = CircleControlCenter.isAllConnect()
	local config = self:getCurBattleLayerConfig()
	local n = 0

	if config then
		n = config.box_num
	end

	return {
		bossDead = isBossDead,
		boxNum = foundBoxNum,
		totalBoxNum = n,
		connectEnd = isConnectEnd
	}
end

function Circle:getSearchProgress(...)
	local data = self:getGridData()
	local totalGridNum = 0
	local openedGridNum = 0

	if data then
		for i, info in ipairs(data) do
			if Const.CIRCLE_GRID_TYPE.SPACE[info.type] or Const.CIRCLE_GRID_TYPE.STATUE[info.type] or Const.CIRCLE_GRID_TYPE.START[info.type] or Const.CIRCLE_GRID_TYPE.END[info.type] then
				-- block empty
			else
				totalGridNum = totalGridNum + 1

				if info.status == Const.CIRCLE_GRID_STATUS.OPEN or info.status == Const.CIRCLE_GRID_STATUS.SHOW then
					openedGridNum = openedGridNum + 1
				end
			end
		end
	end

	return openedGridNum, totalGridNum
end

function Circle:refreshMonsterInfo(clientPos, monsterInfo, uid, layer)
	if layer and layer ~= self:getCurBattleLayer() then
		return
	end

	if self.battleData and self.battleData.monsterDic then
		local info = self.battleData.monsterDic[clientPos]

		if info then
			if monsterInfo then
				info.monsterInfo = monsterInfo
			end

			info.uid = uid
		else
			self.battleData.monsterDic[clientPos] = {
				pos = clientPos,
				monsterInfo = monsterInfo,
				uid = uid
			}
		end
	end
end

function Circle:getMonsterInfo(clientPos, layer)
	if layer and layer ~= self:getCurBattleLayer() then
		return
	end

	if self.battleData and self.battleData.monsterDic and self.battleData.monsterDic[clientPos] then
		return self.battleData.monsterDic[clientPos].monsterInfo
	end
end

function Circle:getMonsterCurUid(clientPos, layer)
	if layer and layer ~= self:getCurBattleLayer() then
		return CurAvatar.uid
	end

	if self.battleData and self.battleData.monsterDic and self.battleData.monsterDic[clientPos] then
		return self.battleData.monsterDic[clientPos].uid
	end
end

function Circle:getMonsterHpProgress(clientPos)
	local info = self:getMonsterInfo(clientPos)
	local gridInfo = self:getGridInfo(clientPos)
	local total, curHp = 0, 0

	if gridInfo.type == Const.CIRCLE_GRID_OPEN_TYPE.BOSS then
		if info and info.boss_hp then
			curHp = info.boss_hp

			return curHp, 10000
		end

		return 10000, 10000
	elseif info and #info.monster > 0 then
		for _, item in ipairs(info.monster or {}) do
			total = total + 10000
			curHp = curHp + item.hp
		end

		return curHp, total
	else
		local monsterId = gridInfo.param
		local config = ResClanBattleMonster[monsterId]

		if config then
			local battleConfig = ResBattleConfig[config.pveid or 1] or {}

			for pos, monsterId in ipairs(battleConfig.monsters or {}) do
				total = total + 10000
			end
		end

		if total > 0 then
			return total, total
		end
	end

	return 1, 1
end

function Circle:getPosOccupyUid(layer, serverPos)
	if layer ~= self:getCurBattleLayer() then
		return
	end

	for uid, member in pairs(self.memberDic) do
		if member.battle_data.oppos == serverPos and member.battle_data.optype ~= Const.CIRCLE_PLAYER_STATE.NONE then
			return member.base.uid
		end
	end
end

function Circle:refreshCircleContribution(contribution)
	self.battleData.contribution = contribution
end

function Circle:addCircleContribution(addValue)
	if self.battleData then
		self.battleData.contribution = (self.battleData.contribution or 0) + addValue
	end
end

function Circle:getCircleContribution()
	return self.battleData.contribution or 0
end

function Circle:getOpenGridPointCost(layer)
	local data

	if layer then
		data = self:getBattleLayerConfig(layer)
	else
		data = self:getCurBattleLayerConfig()
	end

	if data then
		return data.open[1].action_point
	end
end

function Circle:getFightMonsterPointCost(monsterId, layer)
	local data

	if layer then
		data = self:getBattleLayerConfig(layer)
	else
		data = self:getCurBattleLayerConfig()
	end

	if data then
		local name = self:getMonsterTypeName(monsterId)

		return data[name][1].action_point
	end
end

local MONSTER_NAME = {
	"small_monster",
	"big_monster",
	"boss"
}

function Circle:getMonsterTypeName(monsterId)
	local monsterInfo = ResClanBattleMonster[monsterId]

	if monsterInfo then
		return MONSTER_NAME[monsterInfo.type]
	end
end

function Circle:getOpenGridProficiency(layer)
	local data

	if layer then
		data = self:getBattleLayerConfig(layer)
	else
		data = self:getCurBattleLayerConfig()
	end

	if data then
		return data.open[1].proficiency
	end
end

function Circle:getFightMonsterProficiency(monsterId, isLose, layer)
	local data

	if layer then
		data = self:getBattleLayerConfig(layer)
	else
		data = self:getCurBattleLayerConfig()
	end

	if data then
		local name = self:getMonsterTypeName(monsterId)
		local preFix = "win_"

		if isLose then
			preFix = "lose_"
		end

		return data[name][1][preFix .. "proficiency"]
	end
end

function Circle:getFightMonsterFeat(monsterId, isLose)
	local data = self:getCurBattleLayerConfig()

	if data then
		local name = self:getMonsterTypeName(monsterId)
		local preFix = "win_"

		if isLose then
			preFix = "lose_"
		end

		return data[name][1][preFix .. "feat"]
	end
end

function Circle:getOpenGridScore(...)
	local data = self:getCurBattleLayerConfig()

	if data then
		return data.open[1].score
	end
end

function Circle:getFightMonsterScore(monsterId, isLose)
	local data = self:getCurBattleLayerConfig()

	if data then
		local name = self:getMonsterTypeName(monsterId)
		local preFix = "win_"

		if isLose then
			preFix = "lose_"
		end

		return data[name][1][preFix .. "score"]
	end
end

function Circle:getBoxShareScore(...)
	local data = self:getCurBattleLayerConfig()

	if data then
		return data.box[1].score
	end

	return -1
end

function Circle:getBoxShareContribution(...)
	local data = self:getCurBattleLayerConfig()

	if data then
		return data.box[1].contribution
	end

	return -1
end

function Circle:onNewDay(...)
	local battleData = self:getMyBattleMemberData()

	if battleData then
		local config = ResClanBattleMisc[1].action_point[1]

		battleData.action_point = math.min(config.times_limit, config.day_times + battleData.action_point)
	end

	CurAvatar:checkCircleBattleActionRedHint()
end

function Circle:isModelSet(...)
	local data = self:getMyBattleMemberData()

	if data and data.model and data.model.resid ~= 0 then
		return true
	end

	return false
end

function Circle:getCircleTitle(uid)
	local actObj = CurAvatar:getCircleBattleActivity()

	if not actObj or actObj:inCloseState() or actObj:inNoneState() then
		return
	end

	local battleProficiency = self:getBattleProficiency(uid)
	local exploreProficiency = self:getExploreProficiency(uid)
	local titleId

	if battleProficiency <= exploreProficiency then
		for i, info in ipairs(ResClanExploreTalent) do
			if exploreProficiency >= info.proficiency and info.unlock_title then
				titleId = info.unlock_title
			end
		end
	else
		for i, info in ipairs(ResClanBattleTalent) do
			if battleProficiency >= info.proficiency and info.unlock_title then
				titleId = info.unlock_title
			end
		end
	end

	if titleId then
		return ResClanBattleTitle[titleId]
	end
end

function Circle:getMaxScoreBuff(...)
	local value = -1
	local battleProficiency = self:getBattleProficiency(CurAvatar.uid)

	for i, info in ipairs(ResClanBattleTalent) do
		if battleProficiency >= info.proficiency and info.effect and info.effect[1].type == Const.CIRCLE_BATTLE_TALENT_SCORE_UP_BATTLE then
			value = info.effect[1].param1
		end
	end

	return value
end

function Circle:getMyCircleBattleModelData(...)
	local battleData = self:getMyBattleMemberData()

	if battleData then
		return battleData.model
	end
end

function Circle:getAssistantCounts()
	local count = 0

	for _, member in pairs(self.memberDic) do
		if member.duty == Const.CIRCLE_DUTY_ASSISTANT then
			count = count + 1
		end
	end

	return count
end

function Circle:getManagerCounts()
	local count = 0

	for _, member in pairs(self.memberDic) do
		if member.duty == Const.CIRCLE_DUTY_MANAGER then
			count = count + 1
		end
	end

	return count
end

function Circle:getApplyRoleList()
	local roleApplyList = {}

	for _, roleData in pairs(self.applyRoleDataDic) do
		table.insert(roleApplyList, roleData)
	end

	return roleApplyList
end

function Circle:deleteApplyList(uidList)
	for _, uid in ipairs(uidList) do
		self.applyRoleDataDic[uid] = nil
	end
end

function Circle:refreshApplyList(applyList)
	self.applyRoleDataDic = {}

	if applyList.apply then
		for _, applyData in ipairs(applyList.apply) do
			local roleData = utils.deepcopy(applyData.info)

			self.applyRoleDataDic[roleData.uid] = roleData
		end
	end
end

local function _sortRank(a, b)
	if a.data.score ~= b.data.score then
		return a.data.score > b.data.score
	elseif a.data.tick ~= b.data.tick then
		return a.data.tick < b.data.tick
	else
		return a.data.comm.uid > b.data.comm.uid
	end
end

function Circle:getBossRankData()
	local rankData = {}
	local rankDataList = {}
	local selfData = {}

	for _, member in pairs(self.memberDic) do
		if member.boss_record > 0 then
			local _rankData = {}
			local rankCommonData = {}

			rankCommonData.score = member.boss_record
			rankCommonData.comm = member.base
			rankCommonData.tick = member.record_tick
			_rankData.data = rankCommonData

			if rankCommonData.comm.uid == CurAvatar.uid then
				selfData = _rankData
			end

			table.insert(rankDataList, _rankData)
		end
	end

	table.sort(rankDataList, _sortRank)

	for i, rankData in ipairs(rankDataList) do
		rankData.rank = i
		rankData.rankType = Const.RANK_TYPE_BOSSTOWER3

		if rankData.data.comm.uid == CurAvatar.uid then
			selfData.rank = i
		end
	end

	if not selfData.data then
		selfData.data = {}

		local rankCommonData = {}

		rankCommonData.score = 0
		rankCommonData.comm = self:getCircleMember(CurAvatar.uid).base
		rankCommonData.tick = 0
		selfData.data = rankCommonData
		selfData.rank = -1
		selfData.rankType = Const.RANK_TYPE_BOSSTOWER3
	end

	rankData.dataList = rankDataList
	rankData.selfData = selfData

	return rankData
end

function Circle:deleteApply(uid)
	self.applyRoleDataDic[uid] = nil
end

function Circle:getCircleMember(playerUid)
	if self.memberDic[playerUid] then
		if playerUid == CurAvatar.uid then
			self.memberDic[playerUid].base = CurAvatar:getMyRoleSimpleComm()
		end

		return self.memberDic[playerUid]
	end
end

function Circle:getExploreProficiencySvrData(id)
	return self.exploreTalentDic[id]
end

function Circle:getBattleProficiencySvrData(id)
	return self.battleTalentDic[id]
end

function Circle:addExploreProficiency(addValue)
	self:addMemberExploreProficiency(CurAvatar.uid, addValue)

	if addValue > 0 then
		self:updateMemberAchieveData(Const.MEMBER_ACHIEVE_ACT_TYPE.GET_EXPLORE_PROFICIENCY, self:getCurExploreProficiency())

		local newProgress = math.max(self:getCurExploreProficiency(), self:getCurBattleProficiency())

		self:updateMemberAchieveData(Const.MEMBER_ACHIEVE_ACT_TYPE.GET_ANY_PROFICIENCY, newProgress)
	end

	for i, resData in ipairs(ResClanExploreTalent) do
		if self:getCurExploreProficiency() >= resData.proficiency and not self.activeExploreTalentDic[resData.id] then
			self.activeExploreTalentDic[resData.id] = true
			CurAvatar.hintExploreTalentDic[resData.id] = true

			CurAvatar:refreshCircleBattleMainShow()
		end
	end
end

local EXPLORE_PROFICIENCY_CNT_LIST = {
	{
		actionType = Const.CIRCLE_ACHIEVE_ACT_TYPE.EXPLORE_PROFICIENCY_X_CNT
	},
	{
		actionType = Const.CIRCLE_ACHIEVE_ACT_TYPE.EXPLORE_PROFICIENCY_Y_CNT
	},
	{
		actionType = Const.CIRCLE_ACHIEVE_ACT_TYPE.EXPLORE_PROFICIENCY_Z_CNT
	}
}

function Circle:addMemberExploreProficiency(uid, addValue)
	local member = self:getCircleMember(uid)

	if member and member.battle_data then
		for i, actionInfo in ipairs(EXPLORE_PROFICIENCY_CNT_LIST) do
			local achieveData = self:getCircleAchieveData(actionInfo.actionType)
			local alreadyEnough = member.battle_data.explore_proficiency >= achieveData.resData.condition_param

			EXPLORE_PROFICIENCY_CNT_LIST[i].achieveData = achieveData
			EXPLORE_PROFICIENCY_CNT_LIST[i].alreadyEnough = alreadyEnough
		end

		member.battle_data.explore_proficiency = member.battle_data.explore_proficiency + addValue

		if addValue > 0 then
			for i, actionInfo in ipairs(EXPLORE_PROFICIENCY_CNT_LIST) do
				local achieveData = EXPLORE_PROFICIENCY_CNT_LIST[i].achieveData
				local alreadyEnough = EXPLORE_PROFICIENCY_CNT_LIST[i].alreadyEnough

				if not alreadyEnough and member.battle_data.explore_proficiency >= achieveData.resData.condition_param then
					self:addCircleAchieveDataProgress(actionInfo.actionType, 1)
				end
			end
		end
	end
end

function Circle:addBattleProficiency(addValue)
	self:addMemberBattleProficiency(CurAvatar.uid, addValue)

	if addValue > 0 then
		self:updateMemberAchieveData(Const.MEMBER_ACHIEVE_ACT_TYPE.GET_BATTLE_PROFICIENCY, self:getCurBattleProficiency())

		local newProgress = math.max(self:getCurExploreProficiency(), self:getCurBattleProficiency())

		self:updateMemberAchieveData(Const.MEMBER_ACHIEVE_ACT_TYPE.GET_ANY_PROFICIENCY, newProgress)
	end

	for i, resData in ipairs(ResClanBattleTalent) do
		if self:getCurBattleProficiency() >= resData.proficiency and not self.activeBattleTalentDic[resData.id] then
			self.activeBattleTalentDic[resData.id] = true
			CurAvatar.hintBattleTalentDic[resData.id] = true

			CurAvatar:refreshCircleBattleMainShow()
		end
	end
end

local BATTLE_PROFICIENCY_CNT_LIST = {
	{
		actionType = Const.CIRCLE_ACHIEVE_ACT_TYPE.BATTLE_PROFICIENCY_X_CNT
	},
	{
		actionType = Const.CIRCLE_ACHIEVE_ACT_TYPE.BATTLE_PROFICIENCY_Y_CNT
	},
	{
		actionType = Const.CIRCLE_ACHIEVE_ACT_TYPE.BATTLE_PROFICIENCY_Z_CNT
	}
}

function Circle:addMemberBattleProficiency(uid, addValue)
	local member = self:getCircleMember(uid)

	if member and member.battle_data then
		for i, actionInfo in ipairs(BATTLE_PROFICIENCY_CNT_LIST) do
			local achieveData = self:getCircleAchieveData(actionInfo.actionType)
			local alreadyEnough = member.battle_data.battle_proficiency >= achieveData.resData.condition_param

			BATTLE_PROFICIENCY_CNT_LIST[i].achieveData = achieveData
			BATTLE_PROFICIENCY_CNT_LIST[i].alreadyEnough = alreadyEnough
		end

		member.battle_data.battle_proficiency = member.battle_data.battle_proficiency + addValue

		if addValue > 0 then
			for i, actionInfo in ipairs(BATTLE_PROFICIENCY_CNT_LIST) do
				local achieveData = BATTLE_PROFICIENCY_CNT_LIST[i].achieveData
				local alreadyEnough = BATTLE_PROFICIENCY_CNT_LIST[i].alreadyEnough

				if not alreadyEnough and member.battle_data.battle_proficiency >= achieveData.resData.condition_param then
					self:addCircleAchieveDataProgress(actionInfo.actionType, 1)
				end
			end
		end
	end
end

function Circle:getCurExploreProficiency()
	local proficiency = 0
	local memberBattleData = self:getMyBattleMemberData()

	if memberBattleData then
		proficiency = memberBattleData.explore_proficiency or 0
	end

	return proficiency
end

function Circle:getExploreProficiency(uid)
	local proficiency = 0
	local member = self:getCircleMember(uid)

	if member and member.battle_data then
		proficiency = member.battle_data.explore_proficiency or 0
	end

	return proficiency
end

function Circle:getCurBattleProficiency()
	local proficiency = 0
	local memberBattleData = self:getMyBattleMemberData()

	if memberBattleData then
		proficiency = memberBattleData.battle_proficiency or 0
	end

	return proficiency
end

function Circle:getBattleProficiency(uid)
	local proficiency = 0
	local member = self:getCircleMember(uid)

	if member and member.battle_data then
		proficiency = member.battle_data.battle_proficiency or 0
	end

	return proficiency
end

local function _sortHonorInfo(a, b)
	if a.battle_data.contribution ~= b.battle_data.contribution then
		return a.battle_data.contribution > b.battle_data.contribution
	elseif a.duty ~= b.duty then
		return a.duty > b.duty
	elseif a.base.uid ~= b.base.uid and (a.base.uid == CurAvatar.uid or b.base.uid == CurAvatar.uid) then
		return a.base.uid == CurAvatar.uid
	elseif a.online ~= b.online then
		return a.online > b.online
	elseif a.logout_time ~= b.logout_time then
		return a.logout_time > b.logout_time
	elseif a.weekfeat ~= b.weekfeat then
		return a.weekfeat > b.weekfeat
	else
		return a.base.uid > b.base.uid
	end
end

function Circle:getHonorInfoDataList()
	local honorInfoDataList = {}

	for _, member in pairs(self.memberDic) do
		if member.base.uid == CurAvatar.uid then
			member.base = CurAvatar:getMyRoleSimpleComm()
		end

		if not member.battle_data then
			member.battle_data = {}
		end

		table.insert(honorInfoDataList, member)
	end

	table.sort(honorInfoDataList, _sortHonorInfo)

	return honorInfoDataList
end

function Circle:analySvrHonorData(svrHonorList)
	local honorInfoDataList = {}
	local honorInfoDataDic = {}

	for _, svrHonorData in ipairs(svrHonorList) do
		local honorMemberData = {}

		if self.memberDic[svrHonorData.member.base.uid] then
			honorMemberData = self.memberDic[svrHonorData.member.base.uid]
		else
			honorMemberData = svrHonorData.member
			honorMemberData.duty = Const.CIRCLE_DUTY_MEMBER
		end

		if not honorMemberData.battle_data then
			honorMemberData.battle_data = {}
		end

		honorInfoDataDic[svrHonorData.member.base.uid] = honorMemberData

		table.insert(honorInfoDataList, honorMemberData)
	end

	for _, member in pairs(self.memberDic) do
		if not honorInfoDataDic[member.base.uid] then
			if not member.battle_data then
				member.battle_data = {}
			end

			table.insert(honorInfoDataList, member)
		end
	end

	table.sort(honorInfoDataList, _sortHonorInfo)

	return honorInfoDataList
end

function Circle:addHonorInfoDataValue(memberUid, honorField, addValue)
	local memberData = self.memberDic[memberUid]

	if memberData and memberData.battle_data and memberData.battle_data.honor then
		memberData.battle_data.honor[honorField] = (memberData.battle_data.honor[honorField] or 0) + addValue
	end
end

function Circle:getRankBattleFeatData()
	local rankData = {}
	local rankDataList = {}
	local selfData = {}

	for _, member in pairs(self.memberDic) do
		if member.battle_data and member.battle_data.battle_feat > 0 then
			local _rankData = {}
			local rankCommonData = {}

			rankCommonData.score = member.battle_data.battle_feat
			rankCommonData.comm = member.base
			rankCommonData.tick = member.battle_data.battle_feat_tick
			_rankData.data = rankCommonData

			if rankCommonData.comm.uid == CurAvatar.uid then
				selfData = _rankData
			end

			table.insert(rankDataList, _rankData)
		end
	end

	table.sort(rankDataList, _sortRank)

	for i, rankData in ipairs(rankDataList) do
		rankData.rank = i
		rankData.rankType = Const.RANK_TYPE_CIRCLE_BATTLE_FEAT

		if rankData.data.comm.uid == CurAvatar.uid then
			selfData.rank = i
		end
	end

	if not selfData.data then
		selfData.data = {}

		local rankCommonData = {}

		rankCommonData.score = 0
		rankCommonData.comm = self:getCircleMember(CurAvatar.uid).base
		rankCommonData.tick = 0
		selfData.data = rankCommonData
		selfData.rank = -1
		selfData.rankType = Const.RANK_TYPE_CIRCLE_BATTLE_FEAT
	end

	rankData.dataList = rankDataList
	rankData.selfData = selfData

	return rankData
end

function Circle:getPlayerFeatRank()
	local rankBattleFeat = self:getRankBattleFeatData()

	return rankBattleFeat.selfData.rank
end

function Circle:getCurScore()
	local memberBattleData = self:getMyBattleMemberData()

	if memberBattleData then
		return memberBattleData.score or 0
	end
end

function Circle:addCurScore(addValue)
	self:addMemberScore(CurAvatar.uid, addValue)
end

function Circle:allMemberAddScore(addValue)
	for _, member in pairs(self.memberDic) do
		self:addMemberScore(member.base.uid, addValue)
	end
end

function Circle:addBattleFeat(addValue)
	local memberBattleData = self:getMyBattleMemberData()

	if memberBattleData then
		memberBattleData.battle_feat = memberBattleData.battle_feat + addValue
		memberBattleData.battle_feat_tick = ClientUtils.getServerTime()
	end
end

function Circle:addMemberBattleFeat(uid, addValue)
	local member = self:getCircleMember(uid)

	if member and member.battle_data then
		member.battle_data.battle_feat = member.battle_data.battle_feat + addValue
		member.battle_data.battle_feat_tick = ClientUtils.getServerTime()
	end
end

function Circle:addMyContribution(addValue)
	local memberBattleData = self:getMyBattleMemberData()

	if memberBattleData then
		memberBattleData.contribution = memberBattleData.contribution + addValue
	end
end

function Circle:addMemberContribution(uid, addValue)
	local member = self:getCircleMember(uid)

	if member and member.battle_data then
		member.battle_data.contribution = member.battle_data.contribution + addValue

		self:addCircleContribution(addValue)
	end
end

function Circle:addMemberScore(uid, addValue)
	local member = self:getCircleMember(uid)

	if member and member.battle_data then
		member.battle_data.score = member.battle_data.score + addValue
	end

	self:addMemberContribution(uid, addValue * 1)

	if CurAvatar.uid == uid then
		CurAvatar:checkCircleBattleAchieveHint()
	end
end

function Circle:getActionPoint()
	local memberBattleData = self:getMyBattleMemberData()

	if memberBattleData then
		return memberBattleData.action_point or 0
	end
end

function Circle:addActionPoint(addValue)
	self:addMemberActionPoint(CurAvatar.uid, addValue)

	if addValue < 0 then
		self:addMemberAchieveDataProgress(Const.MEMBER_ACHIEVE_ACT_TYPE.COST_ACTION_POINT, math.abs(addValue))
	end

	CurAvatar:checkCircleBattleActionRedHint()
end

function Circle:addMemberActionPoint(uid, addValue)
	local member = self:getCircleMember(uid)

	if member and member.battle_data then
		member.battle_data.action_point = member.battle_data.action_point + addValue

		if addValue < 0 then
			self:addHonorInfoDataValue(uid, "action_point", math.abs(addValue))
			self:addCircleAchieveDataProgress(Const.CIRCLE_ACHIEVE_ACT_TYPE.COST_ACTION_POINT, math.abs(addValue))
		end
	end
end

function Circle:getCurScoreGearData()
	local gearData = {}

	gearData.score = self:getCurScore()

	if gearData.score < ResClanBattleScore[1].score then
		gearData.resData = ResClanBattleScore[1]
		gearData.isEnd = #ResClanBattleScore == 1 and 1 or 0
	else
		for idx, scoreData in ipairs(ResClanBattleScore) do
			if gearData.score >= scoreData.score then
				if ResClanBattleScore[idx + 1] then
					gearData.resData = ResClanBattleScore[idx + 1]
					gearData.isEnd = 0
				else
					gearData.resData = ResClanBattleScore[idx]
					gearData.isEnd = 1
				end
			end
		end
	end

	return gearData
end

function Circle:getPileAwardValue()
	local pileAwardDiamond = 0
	local pileAwardAdvCircleCoin = 0
	local curScore = self:getCurScore()

	for _, resData in ipairs(ResClanBattleScore) do
		if self.injectionPointIdDic[resData.id] then
			if resData.award[1] then
				pileAwardDiamond = pileAwardDiamond + resData.award[1].num
			end

			if resData.award[2] then
				pileAwardAdvCircleCoin = pileAwardAdvCircleCoin + resData.award[2].num
			end
		end
	end

	return pileAwardDiamond, pileAwardAdvCircleCoin
end

function Circle:getPointAwardDataList()
	local pointAwardDataList = {}
	local gearData = self:getCurScoreGearData()

	for idx, resData in ipairs(ResClanBattleScore) do
		local pointAwardData = {}

		pointAwardData.resData = resData
		pointAwardData.curPointScore = self:getCurScore()

		if gearData.isEnd == 0 and gearData.resData.id == resData.id then
			pointAwardData.status = Const.CIRCLE_POINT_STATUS.NEXT
		elseif resData.score <= pointAwardData.curPointScore then
			if self.injectionPointIdDic[resData.id] then
				pointAwardData.status = Const.CIRCLE_POINT_STATUS.GOT
			else
				pointAwardData.status = Const.CIRCLE_POINT_STATUS.GET
			end
		else
			pointAwardData.status = Const.CIRCLE_POINT_STATUS.DIS
		end

		table.insert(pointAwardDataList, pointAwardData)
	end

	return pointAwardDataList
end

function Circle:getMyBattleMemberData()
	local member = self:getCircleMember(CurAvatar.uid)

	if member and member.battle_data then
		return member.battle_data
	end
end

local function _sortAchieveData(achieveA, achieveB)
	if achieveA.status ~= achieveB.status then
		if achieveA.status == Const.ACHIEVE_STATUS.COMPLETE or achieveB.status == Const.ACHIEVE_STATUS.COMPLETE then
			return achieveA.status == Const.ACHIEVE_STATUS.COMPLETE
		elseif achieveA.status == Const.ACHIEVE_STATUS.AWARD_GOT or achieveB.status == Const.ACHIEVE_STATUS.AWARD_GOT then
			return achieveA.status ~= Const.ACHIEVE_STATUS.AWARD_GOT
		end
	else
		return achieveA.resData.id < achieveB.resData.id
	end
end

function Circle:getBattleCircleAchieveList()
	local circleAchieveDataList = {}

	for _, achieveData in pairs(self.circleAchieveDataDic) do
		table.insert(circleAchieveDataList, achieveData)
	end

	table.sort(circleAchieveDataList, _sortAchieveData)

	return circleAchieveDataList
end

local function _sortTargetAchieveData(achieveA, achieveB)
	if achieveA.isTarget ~= achieveB.isTarget then
		return achieveA.isTarget > achieveB.isTarget
	elseif achieveA.status ~= achieveB.status then
		if achieveA.status == Const.ACHIEVE_STATUS.COMPLETE or achieveB.status == Const.ACHIEVE_STATUS.COMPLETE then
			return achieveA.status == Const.ACHIEVE_STATUS.COMPLETE
		elseif achieveA.status == Const.ACHIEVE_STATUS.AWARD_GOT or achieveB.status == Const.ACHIEVE_STATUS.AWARD_GOT then
			return achieveA.status ~= Const.ACHIEVE_STATUS.AWARD_GOT
		end
	else
		return achieveA.resData.id < achieveB.resData.id
	end
end

function Circle:getTargetAchieveDataList()
	local circleAchieveDataList = {}

	for _, achieveData in pairs(self.circleAchieveDataDic) do
		local targetAchieveData = self:getCircleAchieveDataIgnoreGot(achieveData.resData.action_type)

		targetAchieveData.isTarget = targetAchieveData.resData.action_type == self.battleData.target and 1 or 0

		table.insert(circleAchieveDataList, targetAchieveData)
	end

	table.sort(circleAchieveDataList, _sortTargetAchieveData)

	return circleAchieveDataList
end

function Circle:getCircleAchieveData(actionType)
	return self.circleAchieveDataDic[actionType]
end

function Circle:getCircleAchieveDataIgnoreGot(actionType)
	local achieveData = self:getCircleAchieveData(actionType)

	achieveData = CurAvatar:analyCircleAchieveData(achieveData.resData.action_type, achieveData.progress)

	return achieveData
end

function Circle:updateCircleAchieveData(actionType, progress)
	local oldAchieveId = self:getCircleAchieveDataIgnoreGot(actionType).resData.id
	local achieveData = CurAvatar:analyCircleAchieveData(actionType, progress, self.circleAchieveGetDic)

	self.circleAchieveDataDic[actionType] = achieveData

	local newAchieveData = self:getCircleAchieveDataIgnoreGot(actionType)
	local newAchieveId = newAchieveData.resData.id

	if oldAchieveId ~= newAchieveId or newAchieveData.isEnd == 1 and newAchieveData.status ~= Const.ACHIEVE_STATUS.IN_PROCESS then
		self:refreshBattleTarget()
		CurAvatar:refreshCircleBattleMainShow()
	end

	CurAvatar:checkCircleBattleAchieveHint()

	return self.circleAchieveDataDic[actionType]
end

function Circle:addCircleAchieveDataProgress(actionType, addProgress)
	local achieveData = self:getCircleAchieveData(actionType)

	if achieveData then
		local newProgress = achieveData.progress + addProgress

		self:updateCircleAchieveData(actionType, newProgress)
	end
end

function Circle:getBattleMemberAchieveList()
	local circleAchieveDataList = {}

	for _, achieveData in pairs(self.memberAchieveDataDic) do
		table.insert(circleAchieveDataList, achieveData)
	end

	table.sort(circleAchieveDataList, _sortAchieveData)

	return circleAchieveDataList
end

function Circle:getMemberAchieveData(actionType)
	return self.memberAchieveDataDic[actionType]
end

function Circle:updateMemberAchieveData(actionType, progress)
	local achieveData = CurAvatar:analyMemberAchieveData(actionType, progress, self.memberAchieveGetDic)

	self.memberAchieveDataDic[actionType] = achieveData

	CurAvatar:checkCircleBattleAchieveHint()

	return self.memberAchieveDataDic[actionType]
end

function Circle:addMemberAchieveDataProgress(actionType, addProgress)
	local achieveData = self:getMemberAchieveData(actionType)

	if achieveData then
		local newProgress = achieveData.progress + addProgress

		self:updateMemberAchieveData(actionType, newProgress)
	end
end

local function _sortMember(a, b)
	if a.duty ~= b.duty then
		return a.duty > b.duty
	elseif a.base.uid ~= b.base.uid and (a.base.uid == CurAvatar.uid or b.base.uid == CurAvatar.uid) then
		return a.base.uid == CurAvatar.uid
	elseif a.online ~= b.online then
		return a.online > b.online
	elseif a.logout_time ~= b.logout_time then
		return a.logout_time > b.logout_time
	elseif a.weekfeat ~= b.weekfeat then
		return a.weekfeat > b.weekfeat
	else
		return a.base.uid > b.base.uid
	end
end

function Circle:getCircleMembersList()
	local memberList = {}

	for _, member in pairs(self.memberDic) do
		if member.base.uid == CurAvatar.uid then
			member.base = CurAvatar:getMyRoleSimpleComm()
		end

		table.insert(memberList, member)
	end

	table.sort(memberList, _sortMember)

	return memberList
end

local function _sortForModelShow(a, b)
	if a.online ~= b.online then
		return a.online > b.online
	elseif a.logout_time ~= b.logout_time then
		return a.logout_time > b.logout_time
	elseif a.battle_data and b.battle_data and a.battle_data.optick ~= b.battle_data.optick then
		return (a.battle_data.optick or 0) > (b.battle_data.optick or 0)
	end
end

function Circle:getMemberListForModel(...)
	local memberList = {}

	for _, member in pairs(self.memberDic) do
		if member.base.uid == CurAvatar.uid then
			member.base = CurAvatar:getMyRoleSimpleComm()
		end

		table.insert(memberList, member)
	end

	table.sort(memberList, _sortForModelShow)

	return memberList
end

function Circle:deleteMember(uid)
	if self.memberDic[uid] then
		self.memberCount = self.memberCount - 1

		if self.memberDic[uid].checkin_tick >= ClientUtils.getServerTimeTodayStart() then
			self.signNum = self.signNum - 1
		end
	end

	self.memberDic[uid] = nil
end

function Circle:addMember(memberData)
	self.memberDic[memberData.base.uid] = memberData
	self.memberCount = self.memberCount + 1
end

function Circle:getCircleLogList()
	for _, logData in ipairs(self.logs) do
		if logData.base.uid == CurAvatar.uid then
			logData.base = CurAvatar:getMyRoleSimpleComm()
		else
			local member = self:getCircleMember(logData.base.uid)

			if member then
				logData.base = member.base
			end
		end
	end

	return self.logs
end

function Circle:isLeader(playerUid)
	return playerUid == self.leaderUid
end

function Circle:isManager(playerUid)
	for _, uid in ipairs(self.managerUids) do
		if playerUid == uid then
			return true
		end
	end

	return false
end

function Circle:isAssistant(playerUid)
	for _, uid in ipairs(self.assistantUids) do
		if playerUid == uid then
			return true
		end
	end

	return false
end

function Circle:getCircleLeader()
	if self.memberDic[self.leaderUid] then
		if self.leaderUid == CurAvatar.uid then
			self.memberDic[self.leaderUid].base = CurAvatar:getMyRoleSimpleComm()
		end

		return self.memberDic[self.leaderUid]
	end
end

function Circle:getNextLvExp()
	if ResClanLevel[self.level] and ResClanLevel[self.level].need_xp then
		return ResClanLevel[self.level].need_xp
	else
		return 0
	end
end

function Circle:getCurLvExp()
	if ResClanLevel[self.level - 1] and ResClanLevel[self.level - 1].need_xp then
		return ResClanLevel[self.level - 1].need_xp
	else
		return 0
	end
end

function Circle:getFundUpLimit()
	if ResClanLevel[self.level] then
		return ResClanLevel[self.level].fund_limit
	else
		return 0
	end
end

function Circle:getCircleHeadPath()
	if ResClanHead[self.headId] then
		return {
			ResClanHead[self.headId].icon_path,
			ResClanHead[self.headId].icon_name
		}
	end
end

function Circle:getCircleHeadFramePath()
	if ResClanHeadFrame[self.headFrameId] then
		return {
			ResClanHeadFrame[self.headFrameId].icon_path,
			ResClanHead[self.headId].icon_name
		}
	end
end

function Circle:getBannerPath()
	if ResClanHead[self.headId] then
		return ResClanHead[self.headId].banner_path
	end
end

function Circle:getCircleMaxMemberCount()
	if ResClanLevel[self.level] then
		return ResClanLevel[self.level].member_num
	else
		return 0
	end
end

function Circle:isMemberMax()
	return self.memberCount >= self:getCircleMaxMemberCount()
end

function Circle:initClanOpData(clanOpActivity)
	self.actData = {}

	for _, infoData in ipairs(clanOpActivity.item) do
		self:_initClanOpData(infoData)
	end
end

function Circle:_initClanOpData(infoData)
	local oneActData = {}
	local actId = infoData.act_id
	local specData = infoData.specdata

	if infoData.act_type == Const.ACT_TYPE_CLAN_CLEAR then
		oneActData.layerData = {}

		for bossId, bossData in ipairs(specData.boss.item) do
			local events = {}

			for _, eInfo in ipairs(bossData.event) do
				if eInfo.event_id and eInfo.event_id > 0 then
					table.insert(events, eInfo.event_id)
				end
			end

			oneActData.layerData[bossId] = {
				bossData.layer,
				bossData.cur_score,
				events,
				bossData.round
			}
		end
	elseif infoData.act_type == Const.ACT_TYPE_GUESS then
		oneActData.guessDataList = specData.guess.item or {}
	end

	self.actData[actId] = oneActData
end

function Circle:getClanClearLayerData(actOpId, bossId)
	if not actOpId then
		return 1, 0
	end

	local oneActData = self.actData[actOpId] or {}
	local layerData = oneActData.layerData or {}

	layerData = layerData[bossId] or {}

	return math.max(1, layerData[1] or 1), layerData[2] or 0, layerData[4] or 0
end

function Circle:getClanYesterdayEvents(actOpId, bossId)
	if not actOpId then
		return
	end

	local oneActData = self.actData[actOpId] or {}
	local layerData = oneActData.layerData or {}

	layerData = layerData[bossId] or {}

	return layerData[3]
end

function Circle:getClanClearTodayScore(opId, bossId)
	local score = 0

	for _, member in pairs(self.memberDic) do
		if member.opact then
			for _, actData in ipairs(member.opact.item or {}) do
				if actData.act_id == opId and actData.specdata.boss.item[bossId] then
					score = score + actData.specdata.boss.item[bossId].day_score
				end
			end
		end
	end

	return score
end

function Circle:getClanClearMemberScore(member, opId, bossId, isToday)
	if member == nil then
		member = self:getCircleMember(CurAvatar.uid)
	end

	if member and member.opact and member.opact.item then
		for _, actData in ipairs(member.opact.item) do
			if actData.act_id == opId and actData.specdata.boss.item[bossId] then
				if isToday then
					return actData.specdata.boss.item[bossId].day_score
				else
					return actData.specdata.boss.item[bossId].score
				end
			end
		end
	end

	return 0
end

function Circle:timerCalcClanClearMember(opId)
	for _, member in pairs(self.memberDic) do
		if member.opact then
			for _, actData in ipairs(member.opact.item or {}) do
				if actData.act_id == opId then
					for bossId, itData in ipairs(actData.specdata.boss.item) do
						if itData.day_score > 0 then
							itData.score = itData.day_score
							itData.day_score = 0
						end
					end
				end
			end
		end
	end
end

function Circle:onClanOpActClanDataNotify(data)
	if not self.actData then
		self.actData = {}
	end

	for _, infoData in ipairs(data) do
		self:_initClanOpData(infoData)
	end
end

function Circle:onClanOpActMemberDataNotify(data)
	for _, serverInfo in ipairs(data) do
		local uid = serverInfo.uid

		if self.memberDic[uid] then
			local member = self.memberDic[uid]
			local actId = serverInfo.data.act_id
			local replaceSame = false

			if not member.opact then
				member.opact = {}
			end

			for index, actData in ipairs(member.opact.item or {}) do
				if actData.act_id == actId then
					member.opact.item[index] = serverInfo.data
					replaceSame = true

					break
				end
			end

			if not replaceSame then
				if not member.opact.item then
					member.opact.item = {}
				end

				table.insert(member.opact.item, utils.deepcopy(serverInfo.data))
			end
		end
	end
end

function Circle:initMarkedGridData(markDataList)
	self.battleData.otherMarkList = {}
	self.battleData.myMarkData = nil

	if markDataList and #markDataList > 0 then
		for _, markData in pairs(markDataList) do
			if markData.uid == CurAvatar.uid then
				self.battleData.myMarkData = markData
			else
				table.insert(self.battleData.otherMarkList, markData)
			end
		end
	end
end

function Circle:onMarkedGridListNotify(layer, markDataList)
	local curLayer = self:getCurBattleLayer()

	if curLayer ~= layer then
		return
	end

	self:initMarkedGridData(markDataList)

	if self.battleData.tmpMyMarkData and markDataList and #markDataList > 0 then
		for _, data in pairs(markDataList) do
			if data.pos == self.battleData.tmpMyMarkData.pos then
				if data.uid ~= self.battleData.tmpMyMarkData.uid then
					self.battleData.tmpMyMarkData = nil
				end

				break
			end
		end
	end

	CircleControlCenter.onMarkGridDataChange()
end

function Circle:onMarkGridDutyNotify()
	self.battleData.totalMarkTimes = CurAvatar:getTotalMarkGridTimes()

	if self.battleData.totalMarkTimes == 0 then
		self.battleData.tmpMyMarkData = nil
	end

	CircleControlCenter.onMarkGridDataChange()
end

function Circle:onOpenGridNotify()
	if not self.battleData or not self.battleData.gridData then
		return
	end

	local length = #self.battleData.otherMarkList

	for i = length, 1, -1 do
		local data = self.battleData.otherMarkList[i]

		if data.pos >= 0 and not self:checkCanOpenGridPartCondition(data.pos + 1) then
			table.remove(self.battleData.otherMarkList, i)
		end
	end

	if self.battleData.myMarkData and self.battleData.myMarkData.pos >= 0 and not self:checkCanOpenGridPartCondition(self.battleData.myMarkData.pos + 1) then
		self.battleData.myMarkData = nil
	end

	if self.battleData.tmpMyMarkData and self.battleData.tmpMyMarkData.pos >= 0 and not self:checkCanOpenGridPartCondition(self.battleData.tmpMyMarkData.pos + 1) then
		self.battleData.tmpMyMarkData = nil
	end

	CircleControlCenter.onMarkGridDataChange()
end

function Circle:checkGridMarked(index)
	local otherList = self.battleData.otherMarkList

	if otherList then
		for _, markData in pairs(otherList) do
			if markData and markData.pos == index - 1 then
				return true, false
			end
		end
	end

	local myData = self:getMyMarkGridData()

	if myData and myData.pos == index - 1 then
		return true, true
	end

	return false
end

function Circle:checkCanOpenGridPartCondition(index)
	local grid = self.battleData and self.battleData.gridData and self.battleData.gridData[index]

	if not grid then
		return false
	end

	local gridType = CircleControlCenter.getGridType(grid.type)

	return grid.status ~= Const.CIRCLE_GRID_STATUS.SHOW and grid.status ~= Const.CIRCLE_GRID_STATUS.OPEN and Const.CIRCLE_GRID_TYPE.NORMAL[gridType]
end

function Circle:checkCanMarkGrid(index)
	local markTip = Lang.get(74315)

	if self:checkCanOpenGridPartCondition(index) then
		markTip = Lang.get(74316)

		return not self:checkGridMarked(index), markTip
	end

	return false, markTip
end

function Circle:onOpenMarkGridPanel()
	self.battleData.totalMarkTimes = CurAvatar:getTotalMarkGridTimes()
	self.battleData.tmpMyMarkData = self.battleData.myMarkData and self.battleData.myMarkData.pos >= 0 and utils.deepcopy(self.battleData.myMarkData)
end

function Circle:onCloseMarkGridPanel()
	self.battleData.totalMarkTimes = nil
	self.battleData.tmpMyMarkData = nil
end

function Circle:onClickMarkGrid(index)
	if index <= 0 then
		return
	end

	if self.battleData.tmpMyMarkData and self.battleData.tmpMyMarkData.pos + 1 == index then
		self.battleData.tmpMyMarkData = nil

		CircleControlCenter.onUnMarkGrid(index)

		return
	end

	if not self.battleData.totalMarkTimes or self.battleData.totalMarkTimes <= 0 or self.battleData.tmpMyMarkData then
		MsgManager.notice(Lang.get(74317))

		return
	end

	local now = ClientUtils.getServerTime()

	if self.battleData.lastMarkGridTime and now < self.battleData.lastMarkGridTime + 1 then
		MsgManager.clientNotice(167)

		return
	end

	self.battleData.lastMarkGridTime = now
	self.battleData.tmpMyMarkData = {
		uid = CurAvatar.uid,
		pos = index - 1,
		op_tick = ClientUtils.getServerTime()
	}

	CircleControlCenter.onMarkGrid(index, true)
end

function Circle:checkCanFocusMarkGrid(layer, index, isTip)
	local check = self:getCurBattleLayer() == layer and self:checkGridMarked(index)

	if not check and isTip then
		MsgManager.notice(Lang.get(73701))
	end

	return check
end

function Circle:getMyMarkGridIndex()
	local myData = self:getMyMarkGridData()

	if myData and myData.pos and myData.pos >= 0 then
		return myData.pos + 1
	end

	return 0
end

function Circle:getLeftMarkGridTimes()
	local total = CurAvatar:getTotalMarkGridTimes()

	if total <= 0 then
		return 0
	end

	local use = 0
	local myData = self:getMyMarkGridData()

	if myData and myData.pos >= 0 then
		use = 1
	end

	return total - use
end

function Circle:getMarkGridCd()
	local res = 0
	local cd = ResClanMisc[1].mark_grid_cd or 0
	local last = 0

	if self.battleData.myMarkData then
		last = self.battleData.myMarkData.op_tick or 0
	end

	res = math.max(last + cd * 3600 - ClientUtils.getServerTime(), 0)

	return res
end

function Circle:getMyMarkGridData()
	local myData

	if self.battleData then
		myData = self.battleData.myMarkData

		if CircleControlCenter.checkOpenMarkGridPanel then
			myData = self.battleData.tmpMyMarkData
		end
	end

	return myData
end

function Circle:getMarkGridResult()
	local res = {
		mark = 0,
		unmark = 0
	}

	if not self.battleData.myMarkData or not self.battleData.tmpMyMarkData or self.battleData.myMarkData.pos ~= self.battleData.tmpMyMarkData.pos then
		if self.battleData.myMarkData then
			res.unmark = self.battleData.myMarkData.pos + 1
		end

		if self.battleData.tmpMyMarkData then
			res.mark = self.battleData.tmpMyMarkData.pos + 1
		end
	end

	return res
end

function Circle:onMarkMemberResp(uid, tick, checkMark)
	local member = self.memberDic and self.memberDic[uid]

	if member and member.battle_data then
		member.battle_data.marked_flag = checkMark and 1 or 0
		member.battle_data.marked_tick = tick
	end
end

function Circle:getMarkMemberNum()
	local num = 0

	if self.memberDic then
		for _, member in pairs(self.memberDic) do
			if member and member.battle_data and member.duty ~= Const.CIRCLE_DUTY_BOSS and member.battle_data.marked_flag and member.battle_data.marked_flag > 0 then
				num = num + 1
			end
		end
	end

	return num
end

function Circle:checkMarkMemberFull(checkTip)
	local cur = self:getMarkMemberNum()
	local total = ResClanMisc[1].mark_max_num
	local checkFull = total <= cur

	if checkFull and checkTip then
		MsgManager.notice(Lang.get(74318))
	end

	return checkFull
end

return Circle
