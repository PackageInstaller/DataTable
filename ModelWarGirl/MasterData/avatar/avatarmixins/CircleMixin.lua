-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\CircleMixin.lua

local Circle = require("Common/Object/Circle")
local ResItem = require("ClientData/ResItem")
local ResClanPermission = require("ClientData/ResClanPermission")
local ResClanLevel = require("ClientData/ResClanLevel")
local ResRandClient = require("ClientData/ResRandClient")
local ResClanBattleSkill = require("ClientData/ResClanBattleSkill")
local ResColor = require("ClientData/ResColor")
local ResClanLog = require("ClientData/ResClanLog")
local ResClanBattleMonster = require("ClientData/ResClanBattleMonster")
local ResBattleConfig = require("ClientData/ResBattleConfig")
local CircleSkill = require("Common/Object/CircleSkill")
local ResClanBattleMemberAchieve = require("ClientData/ResClanBattleMemberAchieve")
local ResClanBattleClanAchieve = require("ClientData/ResClanBattleClanAchieve")
local ResClanExploreTalent = require("ClientData/ResClanExploreTalent")
local ResClanBattleTalent = require("ClientData/ResClanBattleTalent")
local ResClanHead = require("ClientData/ResClanHead")
local ResClanBattleMisc = require("ClientData/ResClanBattleMisc")
local ResClanGridType = require("ClientData/ResClanGridType")
local ResClanBattleRank = require("ClientData/ResClanBattleRank")
local ResClanHeadFrame = require("ClientData/ResClanHeadFrame")
local ResClanMisc = require("ClientData/ResClanMisc")
local Relic = require("Common/Object/Relic")
local CircleControlCenter = require("Logic/Circle/CircleControlCenter")
local OTHER_CIRCLE_DETAIL_CD = 603
local CIRCLE_DETAIL_CD = 63
local REFRESH_RECOMMEND_CD = 13
local CIRCLE_BATTLE_ACTION_CD = 305
local CIRCLE_BATTLE_SCORE_CD = 305
local CIRCLE_BATTLE_RANK_DATA_CD = 0
local CIRCLE_REAL_RANKING_CD = 300
local CIRCLE_BATTLE_GET_HONOR_CD = 300
local CIRCLE_BATTLE_GET_GUESS_RANK_CD = 10
local CircleMixin = {}

function CircleMixin:initCircleMixin(baseData, syncData)
	local serverCircleData = syncData.other.clan_data
	local serverCircleMiscData = syncData.other.clan_misc

	self:initCircleData(serverCircleData, serverCircleMiscData)

	self.isCircleBattleInit = true
end

function CircleMixin:postinitCircleMixin(baseData, syncData)
	return
end

function CircleMixin:initCircleData(serverData, miscData)
	self.circleRoleData = utils.deepcopy(serverData)
	self.circleMiscData = utils.deepcopy(miscData)
	self.applyedCircleDic = {}
	self.cachedCircleDetailDic = {}
	self.inviterDataDic = {}
	self.lastGetRecommendTick = -1
	self.recommendIndex = 0
	self.totalRecommendPage = 1
	self.clanBattleActionLogTick = 0
	self.clanBattleScoreLogTick = 0
	self.getCircleRealRankingTick = 0
	self.circleBattleGetRankTick = 0
	self.hintExploreTalentDic = {}
	self.hintBattleTalentDic = {}
	self.scoreLogList = {}
	self.actionLogList = {}
	self.hintCircleHeadDic = {}
	self.hintCircleHeadFrameDic = {}

	self:initCircleHeroRelicData()
	self:initCircleAchieveData()

	self.hintedCircleFrame = false
end

function CircleMixin:initCircleHeroRelicData()
	self.cicleBattleHeroRelicDic = {}
	self.cicleBattleRelicHeroDic = {}

	if self.circleRoleData.clan_hero and self.circleRoleData.clan_hero.data then
		for _, circleHeroData in ipairs(self.circleRoleData.clan_hero.data) do
			if circleHeroData.relic ~= 0 then
				self.cicleBattleHeroRelicDic[circleHeroData.resid] = circleHeroData.relic
				self.cicleBattleRelicHeroDic[circleHeroData.relic] = circleHeroData.resid
			end
		end
	end
end

function CircleMixin:getCircleRealRanking()
	if self.getCircleRealRankingTick + CIRCLE_REAL_RANKING_CD >= ClientUtils.getServerTime() then
		return self.cachedCircleRealRankingData
	else
		local actObj = self:getCircleBattleActivity()

		if actObj and actObj.actData and actObj.actData:getCirlceBattleSeason() and self.myCircle:getCurBattleLayer() and self.myCircle:getCurBattleLayer() > 1 then
			RPC.rankCacheGetRealRanking(Const.RANK_CACHE_TYPE_CIRCLE_LAYER, 1, actObj.opId, actObj.actData:getCirlceBattleSeason(), self.myCircle.gid)
		end
	end
end

function CircleMixin:getCachedCircleBattleLayerRankData()
	if self.circleBattleGetRankTick + CIRCLE_BATTLE_RANK_DATA_CD >= ClientUtils.getServerTime() then
		return self.cachedCircleBattleLayerRankData
	else
		RPC.rankCacheGetPage(Const.RANK_CACHE_TYPE_CIRCLE_LAYER, 1, 0, 2)
	end
end

function CircleMixin:getCircleBattleHeroDic()
	local circleBattleHeroDic = {}

	for gid, hero in pairs(self.heroDic) do
		local wearedRelic
		local wearedRelicId = self.cicleBattleHeroRelicDic[hero.id]

		if wearedRelicId and self.bagRelics[wearedRelicId] then
			wearedRelic = BaseObject.CopyObject(self.bagRelics[wearedRelicId])
		end

		local circleBattleHero = utils.getCircleBattleHero(hero, wearedRelic)

		if circleBattleHero then
			circleBattleHeroDic[circleBattleHero.gid] = circleBattleHero
		end
	end

	return circleBattleHeroDic
end

function CircleMixin:onClanBattleSetRelicResp(hero_id, relic_id)
	if relic_id ~= 0 then
		if self.cicleBattleHeroRelicDic[hero_id] then
			self.cicleBattleRelicHeroDic[self.cicleBattleHeroRelicDic[hero_id]] = nil
			self.cicleBattleHeroRelicDic[hero_id] = nil
		end

		self.cicleBattleHeroRelicDic[hero_id] = relic_id
		self.cicleBattleRelicHeroDic[relic_id] = hero_id
	elseif self.cicleBattleHeroRelicDic[hero_id] then
		self.cicleBattleRelicHeroDic[self.cicleBattleHeroRelicDic[hero_id]] = nil
		self.cicleBattleHeroRelicDic[hero_id] = nil

		MsgManager.notice(Lang.get(1838))
	end

	self:closeWearDlg()

	local circleBattleHeroInfoDlg = UIManager.getUI("circleBattleHeroInfoDlg", nil, false)
	local circleBattleHeroListDlg = UIManager.getUI("circleBattleHeroListDlg", nil, false)

	if circleBattleHeroListDlg then
		circleBattleHeroListDlg:refreshHeroList()

		if circleBattleHeroInfoDlg then
			circleBattleHeroInfoDlg:refreshUIForCircleBattle(circleBattleHeroListDlg.filterList)
		end
	end

	self:refreshCircleBattleMainShow()
end

function CircleMixin:getCanWearRelicsInCircleBattle(hero)
	local relics = {}

	for gid, relic in pairs(self.bagRelics) do
		if (not self.cicleBattleRelicHeroDic[relic.id] or self.cicleBattleRelicHeroDic[relic.id] == hero.id) and relic:isCanBeWear(hero) and relic.heroIdLimit then
			local circleBattleRelic = BaseObject.CopyObject(relic)

			table.insert(relics, circleBattleRelic)
		end
	end

	return relics
end

function CircleMixin:checkCanWearRelicCBHero()
	local canWearHeroDic = {}
	local circleBattleHeroDic = self:getCircleBattleHeroDic()

	for gid, hero in pairs(circleBattleHeroDic) do
		if hero and not hero:getRelic() then
			for gid, relic in pairs(self.bagRelics) do
				if not self.cicleBattleRelicHeroDic[relic.id] and relic:isCanBeWear(hero) and relic.heroIdLimit then
					canWearHeroDic[hero.gid] = true
				end
			end
		end
	end

	return canWearHeroDic
end

function CircleMixin:isHintCircleBattleHeroRelicWear()
	local actOj = self:getCircleBattleActivity()

	if actOj and actOj:inOpenState() then
		local circleBattleHeroDic = self:getCircleBattleHeroDic()

		for gid, hero in pairs(circleBattleHeroDic) do
			if hero and not hero:getRelic() then
				for gid, relic in pairs(self.bagRelics) do
					if not self.cicleBattleRelicHeroDic[relic.id] and relic:isCanBeWear(hero) and relic.heroIdLimit then
						return true
					end
				end
			end
		end
	else
		return false
	end
end

function CircleMixin:initCircleAchieveData()
	self.memberAchieveTypeDataDic = {}

	for _, achieveData in ipairs(ResClanBattleMemberAchieve) do
		if achieveData.action_type then
			if not self.memberAchieveTypeDataDic[achieveData.action_type] then
				self.memberAchieveTypeDataDic[achieveData.action_type] = {}
			end

			table.insert(self.memberAchieveTypeDataDic[achieveData.action_type], achieveData)
		end
	end

	self.circleAchieveTypeDataDic = {}

	for _, achieveData in ipairs(ResClanBattleClanAchieve) do
		if achieveData.action_type then
			if not self.circleAchieveTypeDataDic[achieveData.action_type] then
				self.circleAchieveTypeDataDic[achieveData.action_type] = {}
			end

			table.insert(self.circleAchieveTypeDataDic[achieveData.action_type], achieveData)
		end
	end
end

function CircleMixin:isInCircle()
	return self.circleRoleData.clangid ~= 0
end

function CircleMixin:getCircleName()
	if self.myCircle then
		return self.myCircle.name
	end
end

function CircleMixin:playerInMyCircle(uid)
	if self:isInCircle() and self.myCircle then
		return self.myCircle:getCircleMember(uid) ~= nil
	else
		return false
	end
end

function CircleMixin:isLeader()
	if self.myCircle and self:isInCircle() then
		return self:getMyDuty() == Const.CIRCLE_DUTY_BOSS
	end
end

function CircleMixin:isCircleApplyed(circleGid)
	return self.applyedCircleDic[circleGid] ~= nil and true or false
end

function CircleMixin:isApplyInCD()
	return false
end

function CircleMixin:isSigned()
	return self.circleMiscData.checkin_tick >= ClientUtils.getServerTimeTodayStart()
end

function CircleMixin:onClanBattleSettleNotify(settle, close_tick)
	local layerRank = settle.layer_rank + 1

	if layerRank > 0 and self.myCircle then
		for _, rankAwardData in ipairs(ResClanBattleRank) do
			if layerRank >= rankAwardData.index and layerRank <= rankAwardData.index_low_bound then
				local newHeadFrameId = rankAwardData.head_frame_id

				if ResClanHeadFrame[newHeadFrameId] then
					local endTime = close_tick + ResClanHeadFrame[newHeadFrameId].limit_days * Const.TIME_ONE_DAY

					self.myCircle:addHeadFrame(newHeadFrameId, endTime)

					if newHeadFrameId ~= self.myCircle.headFrameId then
						self.hintCircleHeadFrameDic[newHeadFrameId] = true

						self:hintCircleEditHead()
					end
				end
			end
		end
	end
end

function CircleMixin:onClanFuncShareResp(hint, base, content, share_tick)
	local ui = UIManager.tryGetUI("editCircleShareDlg")

	MsgManager.notice(Lang.get(45135))

	if self.myCircle then
		self.myCircle.shareTick = share_tick
	end

	if ui then
		ui:setVisible(false)
	end
end

function CircleMixin:onClanFuncShareRespError(ecode, hint, base, content, share_tick)
	local ui = UIManager.tryGetUI("editCircleShareDlg")

	if #hint > 0 then
		if ui then
			ui:markInputIllegal(hint)
		end

		return
	end
end

function CircleMixin:onClanFuncRefuseInviteNotify(clangid, uid)
	if self.myCircle and self.myCircle.gid == clangid then
		self.myCircle:delInvitePlayer(uid)
	end
end

function CircleMixin:onClanFuncInviteResp(uid, tick)
	if self.myCircle then
		self.myCircle:addInvitePlayer(uid, tick)
	end

	self.nextCircleInviteTick = tick + ResClanMisc[1].invite_duetime

	MsgManager.clientNotice(605)

	local ui = UIManager.getUI("roleInfoOtherDlg", nil, false)

	if ui then
		ui:refreshCircleInvite(true)
	end
end

function CircleMixin:onClanFuncRefuseInviteResp(clangid)
	if self.inviterDataDic[clangid] then
		self.inviterDataDic[clangid] = nil

		MsgManager.clientNotice(602)
		self:checkInvitedHint()

		local circleInviteInfoDlg = UIManager.getUI("circleInviteInfoDlg", nil, false)

		if circleInviteInfoDlg then
			circleInviteInfoDlg:setInviteMsgData(self:getInviterDataList())
		end
	end
end

function CircleMixin:onClanFuncInviteNotify(inviter, invitee)
	if invitee == self.uid then
		if not self.inviterDataDic then
			self.inviterDataDic = {}
		end

		local inviterData = {}

		inviterData.circle = Circle(inviter.base, true)
		inviterData.tick = inviter.tick
		self.inviterDataDic[inviterData.circle.gid] = inviterData

		self:addMsgToNoticeChild(inviterData)
		self:checkInvitedHint()
	elseif self.myCircle and self.myCircle.gid == inviter.base.clangid then
		self.myCircle:addInvitePlayer(invitee, inviter.tick)
	end
end

function CircleMixin:onClanFuncInviterListNotify(data)
	self.inviterDataDic = {}

	RentMsgManager.clearRentMsg(true)

	for _, inviter in ipairs(data.inviter) do
		local inviterData = {}

		inviterData.circle = Circle(inviter.base, true)
		inviterData.tick = inviter.tick
		self.inviterDataDic[inviterData.circle.gid] = inviterData

		self:addMsgToNoticeChild(inviterData)
		self:checkInvitedHint()
	end
end

local function _sortInviterData(a, b)
	if a.tick ~= b.tick then
		return a.tick < b.tick
	else
		return a.circle.gid < b.circle.gid
	end
end

function CircleMixin:getInviterDataList()
	local inviterDataList = {}

	if self.inviterDataDic then
		local validTime = ResClanMisc[1].invite_duetime * 3600

		for gid, invitePlayerData in pairs(self.inviterDataDic) do
			if ClientUtils.getServerTime() < invitePlayerData.tick + validTime then
				table.insert(inviterDataList, invitePlayerData)
			else
				self.inviterDataDic[gid] = nil
			end
		end

		table.sort(inviterDataList, _sortInviterData)
	end

	return inviterDataList
end

function CircleMixin:addMsgToNoticeChild(inviterData)
	RentMsgManager.addRentMsg(Const.RENT_NOTICE_TYPE.CircleInvite, inviterData, inviterData.circle)
end

function CircleMixin:checkInvitedHint()
	local invitedList = self:getInviterDataList()

	if self:isInCircle() then
		RedDotManager.setKeyState(UIConst.RD_HINT_CIRCLE_INVITED, false)
	else
		RedDotManager.setKeyState(UIConst.RD_HINT_CIRCLE_INVITED, #invitedList > 0)
	end
end

function CircleMixin:newDayCircle()
	if self.cachedCircleDetailDic[self.circleRoleData.clangid] then
		self.cachedCircleDetailDic[self.circleRoleData.clangid] = nil
	end

	self:checkCircleSignHint()

	if self.myCircle then
		self.myCircle:onNewDay()
	end
end

function CircleMixin:onClanCheckinResp(tick)
	self.circleMiscData.checkin_tick = tick

	if self.myCircle then
		self.myCircle.signNum = self.myCircle.signNum + 1
	end

	local curAwardId = ResClanLevel[self.myCircle.level].checkin_award
	local itemId = ResRandClient[curAwardId].show_ids[1]
	local itemNumCur = ResRandClient[curAwardId].show_nums[1]

	MsgManager.notice(utils.format(Lang.get(1822), ResItem[itemId].name, itemNumCur))

	local circleMainDlg = UIManager.getUI("circleMainDlg", nil, false)

	if circleMainDlg then
		circleMainDlg:flyCircleGold(itemNumCur)
	end

	self:checkCircleSignHint()
	self:refreshCircleDetailDlg(self.myCircle)
	self:_sendWhenSign()
end

function CircleMixin:onClanCheckinTickNotify(tick)
	self.circleMiscData.checkin_tick = tick

	self:checkCircleSignHint()
end

function CircleMixin:onClanSendMailResp(tick)
	self.circleRoleData.mailTick = tick

	if self.myCircle then
		local member = self.myCircle:getCircleMember(self.uid)

		if member then
			member.mail_tick = self.circleRoleData.mailTick
		end
	end

	MsgManager.clientNotice(197)
	UIManager.tryHideUI("circleEditMailDlg")
end

function CircleMixin:onClanSendMailRespError(ecode, tick, hint)
	local circleEditMailDlg = UIManager.tryGetUI("circleEditMailDlg")

	if circleEditMailDlg then
		circleEditMailDlg.btnLockFlag = false

		if hint and #hint > 0 and ecode == "kCSErrorYiDunDirtyCommon" then
			circleEditMailDlg:markInputIllegal(hint)
		end
	end
end

function CircleMixin:onClanAppointResp(uid, duty, clan)
	if self.myCircle then
		local member = self.myCircle:getCircleMember(uid)

		if member then
			if member.duty ~= Const.CIRCLE_DUTY_MEMBER and duty == Const.CIRCLE_DUTY_MEMBER then
				MsgManager.notice(Lang.get(1825))
			else
				MsgManager.clientNotice(198)
			end

			member.duty = duty
		end
	end

	UIManager.tryHideUI("circleAppointDlg")
	self:refreshCircleDetailDlg(self.myCircle)
end

function CircleMixin:onClanLeaveNotify(uid)
	local member = self.myCircle:getCircleMember(uid)

	if member and member.battle_data then
		self.myCircle:addCircleContribution(-member.battle_data.contribution)
	end

	self.myCircle:deleteMember(uid)
	self:refreshCircleDetailDlg(self.myCircle)

	local circleBattleCircleSkillDlg = UIManager.getUI("circleBattleCircleSkillDlg", nil, false)

	if circleBattleCircleSkillDlg then
		circleBattleCircleSkillDlg:initCircleSkillData()
	end
end

function CircleMixin:onClanJoinNotify(members)
	for _, member in ipairs(members) do
		self.myCircle:addMember(member)
	end

	self:refreshCircleDetailDlg(self.myCircle)
end

function CircleMixin:getManageMemberPermission(memberDuty)
	local canKick = self:getMyDutyPermission().kick and memberDuty < self.circleRoleData.duty
	local canFire = false

	if Const.DUTY_RELIEVE_DIC[memberDuty] then
		canFire = self:getMyDutyPermission()[Const.DUTY_RELIEVE_DIC[memberDuty]] ~= nil
	end

	local canAppoint = false

	for appoint, duty in pairs(Const.APPOINT_DUTY_DIC) do
		if self:getMyDutyPermission()[appoint] and memberDuty ~= duty and (canFire or memberDuty < duty) then
			canAppoint = true

			break
		end
	end

	return canKick, canFire, canAppoint
end

function CircleMixin:onClanDutyNotify(uid, duty)
	if uid == self.uid then
		if self.myCircle then
			if duty == Const.CIRCLE_DUTY_BOSS then
				self.myCircle:getCircleLeader().duty = Const.CIRCLE_DUTY_MEMBER
				self.myCircle.leaderUid = self.uid
			end

			if duty > self.circleRoleData.duty then
				RPC.clanGet()
			else
				local member = self.myCircle:getCircleMember(self.uid)

				if member then
					member.duty = duty
				end
			end

			self.circleRoleData.duty = duty

			self.myCircle:onMarkGridDutyNotify()
		end

		if self.circleRoleData.duty == Const.CIRCLE_DUTY_MEMBER then
			MsgManager.clientNotice(199)
		else
			MsgManager.notice(string.format(Lang.get(1823), Const.CIRCLE_DUTY_NAME_DIC[duty]))
		end
	elseif self.myCircle then
		local member = self.myCircle:getCircleMember(uid)

		if member then
			member.duty = duty
		end
	end

	self:refreshCircleDetailDlg(self.myCircle)
end

function CircleMixin:onClanKickResp(uid)
	if self.myCircle then
		self.myCircle:deleteMember(uid)
	end

	MsgManager.clientNotice(200)
	self:refreshCircleDetailDlg(self.myCircle)
end

function CircleMixin:onClanTransferResp(uid)
	self.circleRoleData.duty = Const.CIRCLE_DUTY_MEMBER

	if self.myCircle then
		local member = self.myCircle:getCircleMember(uid)

		if member then
			member.duty = Const.CIRCLE_DUTY_BOSS
		end

		local memberSelf = self.myCircle:getCircleMember(self.uid)

		if memberSelf then
			memberSelf.duty = Const.CIRCLE_DUTY_MEMBER
		end

		self.myCircle.leaderUid = uid
	end

	UIManager.tryHideUI("circleAppointDlg")
	MsgManager.clientNotice(201)
	self:refreshCircleDetailDlg(self.myCircle)
end

function CircleMixin:getMailTick()
	if self.circleRoleData then
		return self.circleRoleData.mailTick
	else
		return 0
	end
end

function CircleMixin:checkCircleSignHint()
	if self:isInCircle() then
		RedDotManager.setKeyState(UIConst.RD_HINT_CIRCLE_SIGN, not self:isSigned())
	else
		RedDotManager.setKeyState(UIConst.RD_HINT_CIRCLE_SIGN, false)
	end
end

function CircleMixin:isHintTalent()
	if self:isInCircle() then
		local elemCnt = utils.getTableElemCount(self.hintExploreTalentDic, true)

		elemCnt = elemCnt + utils.getTableElemCount(self.hintBattleTalentDic, true)

		return elemCnt > 0
	else
		return false
	end
end

function CircleMixin:clearHintTalent()
	self.hintExploreTalentDic = {}
	self.hintBattleTalentDic = {}
end

function CircleMixin:getDutyPermission(duty)
	return ResClanPermission[duty]
end

function CircleMixin:getMyDutyPermission()
	return ResClanPermission[self:getMyDuty()]
end

function CircleMixin:getMyDuty()
	return self.circleRoleData.duty
end

function CircleMixin:addApplyedCache(clangid)
	self.applyedCircleDic[clangid] = true
end

function CircleMixin:getMyCircleCommInfo()
	if self.myCircle then
		local commInfo = {}

		commInfo.level = self.myCircle.level
		commInfo.head = self.myCircle.headId
		commInfo.vip = self.myCircle.memberCount
		commInfo.vip_hide = self.myCircle.exp
		commInfo.name = self.myCircle.name
		commInfo.uid = tostring(self.myCircle.gid)
		commInfo.head_frame_id = self.myCircle.headFrameId
		commInfo.head_frame_end_time = self.myCircle:getHeadFrameEndTimeTick()

		return commInfo
	end
end

function CircleMixin:getCanUseCircleHeadDataList()
	local canUseCircleHeadDataList = {}

	if self.myCircle then
		for _, resData in ipairs(ResClanHead) do
			if not resData.layer or self.myCircle.maxBattleLayer >= resData.layer then
				local circleHeadData = {}

				circleHeadData.resData = resData

				table.insert(canUseCircleHeadDataList, circleHeadData)
			end
		end
	end

	return canUseCircleHeadDataList
end

function CircleMixin:getCircleHeadConditionDataList()
	local circleHeadConditionDataList = {}

	if self.myCircle then
		for _, resData in ipairs(ResClanHead) do
			if resData.layer then
				local circleHeadData = {}

				circleHeadData.resData = resData

				table.insert(circleHeadConditionDataList, circleHeadData)
			end
		end
	end

	return circleHeadConditionDataList
end

function CircleMixin:isEnterCircleInCD()
	return self.circleRoleData.next_tick ~= 0 and ClientUtils.getServerTime() < self.circleRoleData.next_tick
end

function CircleMixin:getAllCircleSkill(includeHave, includeNotHave)
	local circleSkillList = {}

	if self.myCircle then
		for id, _ in pairs(ResClanBattleSkill) do
			local circleSkill = self.myCircle:getCircleBattleSkill(id)

			if includeHave and circleSkill then
				circleSkill.sortValue = circleSkill.type

				if circleSkill.type == Const.CIRCLE_BATTLE_SKILL_TYPE_ACTIVE and circleSkill.leftTimes == 0 then
					circleSkill.sortValue = circleSkill.sortValue + 10
				end

				table.insert(circleSkillList, circleSkill)
			end

			if includeNotHave and not circleSkill then
				circleSkill = CircleSkill(id)
				circleSkill.sortValue = 1

				table.insert(circleSkillList, circleSkill)
			end
		end
	end

	return circleSkillList
end

function CircleMixin:getAllCircleTalent(includeExplore, includeBattle)
	local circleTalentDataList = {}

	if self.myCircle then
		if includeExplore then
			local curProficiency = self.myCircle:getCurExploreProficiency()

			for i, resData in ipairs(ResClanExploreTalent) do
				local talentData = {}

				talentData.curProficiency = curProficiency
				talentData.resData = resData
				talentData.lastProficiency = 0

				if i ~= 1 then
					talentData.lastProficiency = ResClanExploreTalent[i - 1].proficiency
				end

				talentData.type = Const.CIRCLE_TALENT_TYPE_SEARCH
				talentData.isActive = curProficiency >= resData.proficiency

				table.insert(circleTalentDataList, talentData)
			end
		end

		if includeBattle then
			local curProficiency = self.myCircle:getCurBattleProficiency()

			for i, resData in ipairs(ResClanBattleTalent) do
				local talentData = {}

				talentData.curProficiency = curProficiency
				talentData.resData = resData
				talentData.lastProficiency = 0

				if i ~= 1 then
					talentData.lastProficiency = ResClanBattleTalent[i - 1].proficiency
				end

				talentData.type = Const.CIRCLE_TALENT_TYPE_BATTLE
				talentData.isActive = curProficiency >= resData.proficiency

				table.insert(circleTalentDataList, talentData)
			end
		end
	end

	return circleTalentDataList
end

function CircleMixin:onClanBattleBuySkillResp(skillSvrData, contribution)
	if self.myCircle then
		MsgManager.clientNotice(553)

		if contribution then
			self.myCircle:refreshCircleContribution(contribution)
		end

		local circleSkill = CircleSkill(skillSvrData.id, skillSvrData)

		self.myCircle:addCircleBattleSkill(circleSkill)
		self:addSkillActionLog(self.uid, circleSkill.id, Const.CIRCLE_BATTLE_SKILL_OPLOG_TYPE.BUY)

		local circleBattleCircleSkillDlg = UIManager.getUI("circleBattleCircleSkillDlg", nil, false)

		if circleBattleCircleSkillDlg then
			circleBattleCircleSkillDlg:initCircleSkillData()
		end
	end
end

function CircleMixin:onClanBattleBuySkillNotify(uid, skillSvrData, contribution)
	if self.myCircle then
		self.myCircle:refreshCircleContribution(contribution)

		local circleSkill = CircleSkill(skillSvrData.id, skillSvrData)

		self:addSkillActionLog(uid, circleSkill.id, Const.CIRCLE_BATTLE_SKILL_OPLOG_TYPE.BUY)
		self.myCircle:addCircleBattleSkill(circleSkill)

		local circleBattleCircleSkillDlg = UIManager.getUI("circleBattleCircleSkillDlg", nil, false)

		if circleBattleCircleSkillDlg then
			circleBattleCircleSkillDlg:initCircleSkillData()
		end
	end
end

function CircleMixin:onCircleAchieveNotify(actionType, progress)
	if self.myCircle then
		self.myCircle:updateCircleAchieveData(actionType, progress)
	end
end

function CircleMixin:onMemberAchieveNotify(actionType, progress)
	if self.myCircle then
		self.myCircle:updateMemberAchieveData(actionType, progress)
	end
end

function CircleMixin:getPointStatusDesc(status)
	if status == Const.CIRCLE_POINT_STATUS.DIS then
		return ClientUtils.getClientNotice(562)
	elseif status == Const.CIRCLE_POINT_STATUS.NEXT then
		return ClientUtils.getClientNotice(563)
	elseif status == Const.CIRCLE_POINT_STATUS.GET then
		return ClientUtils.getClientNotice(564)
	elseif status == Const.CIRCLE_POINT_STATUS.GOT then
		return ClientUtils.getClientNotice(565)
	end
end

function CircleMixin:onClanBattleGetClanAchieveAwardResp(achieve_id)
	if self.myCircle then
		local actionType = ResClanBattleClanAchieve[achieve_id].action_type
		local achieveData = self.myCircle:getCircleAchieveData(actionType)

		self.myCircle.circleAchieveGetDic[achieve_id] = true

		self.myCircle:updateCircleAchieveData(actionType, achieveData.progress)
		self.myCircle:addCurScore(achieveData.resData.score)
		MsgManager.clientNotice(555)
		self:addScoreLog(Const.CIRCLE_BATTLE_SCORE_LOG_OPTYPE.CIRCLE_ACHIEVE, achieveData.resData.score, achieveData.resData.id)

		local circleBattlePointAwardDlg = UIManager.getUI("circleBattlePointAwardDlg", nil, false)

		if circleBattlePointAwardDlg then
			circleBattlePointAwardDlg:playAchieveGetAniShow(achieveData.resData.id)
			circleBattlePointAwardDlg:refreshPanel()
		end

		self:checkCircleBattleAchieveHint()
		self:refreshCircleBattleMainShow()
	end
end

function CircleMixin:onClanBattleGetMemberAchieveAwardResp(achieve_id)
	if self.myCircle then
		local actionType = ResClanBattleMemberAchieve[achieve_id].action_type
		local achieveData = self.myCircle:getMemberAchieveData(actionType)

		self.myCircle.memberAchieveGetDic[achieve_id] = true

		self.myCircle:updateMemberAchieveData(actionType, achieveData.progress)
		MsgManager.clientNotice(554)
		self.myCircle:addCurScore(achieveData.resData.score)
		self:addScoreLog(Const.CIRCLE_BATTLE_SCORE_LOG_OPTYPE.MEMBER_ACHIEVE, achieveData.resData.score, achieveData.resData.id)

		local circleBattlePointAwardDlg = UIManager.getUI("circleBattlePointAwardDlg", nil, false)

		if circleBattlePointAwardDlg then
			circleBattlePointAwardDlg:playAchieveGetAniShow(achieveData.resData.id)
			circleBattlePointAwardDlg:refreshPanel()
		end

		self:checkCircleBattleAchieveHint()
		self:refreshCircleBattleMainShow()
	end
end

function CircleMixin:onClanBattleGetClanAchieveAwardNotify(uid, achieve_id)
	if self.myCircle then
		local actionType = ResClanBattleClanAchieve[achieve_id].action_type
		local achieveData = self.myCircle:getCircleAchieveData(actionType)

		self.myCircle:addMemberScore(uid, achieveData.resData.score)
	end
end

function CircleMixin:onClanBattleGetMemberAchieveAwardNotify(uid, achieve_id)
	if self.myCircle then
		local actionType = ResClanBattleMemberAchieve[achieve_id].action_type
		local achieveData = self.myCircle:getMemberAchieveData(actionType)

		self.myCircle:addMemberScore(uid, achieveData.resData.score)
	end
end

function CircleMixin:tryGetScoreRecordDataList()
	if ClientUtils.getServerTime() >= self.clanBattleScoreLogTick + CIRCLE_BATTLE_SCORE_CD then
		self:tryCallCircleBattleRpc("clanBattleGetScoreLog")
	elseif self.myCircle then
		return self:getScoreLog()
	end
end

function CircleMixin:onClanBattleGetScoreLogResp(log)
	if self.myCircle then
		self.clanBattleScoreLogTick = ClientUtils.getServerTime()

		self:updateScoreLog(log)

		local circleBattlePointRecordDlg = UIManager.getUI("circleBattlePointRecordDlg", nil, false)

		if circleBattlePointRecordDlg then
			circleBattlePointRecordDlg:setRecordDataList(self:getScoreLog())
		end
	end
end

function CircleMixin:onClanBattleGetLogResp(log)
	if self.myCircle then
		self.clanBattleActionLogTick = ClientUtils.getServerTime()

		self:updateActionLog(log)

		local circleBattleActionRecordDlg = UIManager.getUI("circleBattleActionRecordDlg", nil, false)

		if circleBattleActionRecordDlg then
			circleBattleActionRecordDlg:setActionRecordDataList(self:getActionLog())
		end
	end
end

function CircleMixin:tryGetActionRecordDataList()
	if ClientUtils.getServerTime() >= self.clanBattleActionLogTick + CIRCLE_BATTLE_ACTION_CD then
		RPC.clanBattleGetLog(0)
	elseif self.myCircle then
		return self:getActionLog()
	end
end

function CircleMixin:onClanBattleScoreInfuseResp(infuse_bytes, infuse_id)
	if self.myCircle then
		MsgManager.clientNotice(561)

		self.myCircle.injectionPointIdDic = ClientUtils.getBitsDictFromByteString(infuse_bytes)

		local circleBattlePointAwardDlg = UIManager.getUI("circleBattlePointAwardDlg", nil, false)

		if circleBattlePointAwardDlg then
			circleBattlePointAwardDlg:refreshPanel(true)
			circleBattlePointAwardDlg:playInfuseAniShow(infuse_id)
		end

		self:checkCircleBattleAchieveHint()
	end
end

function CircleMixin:testClanBattleScoreInfuseResp(infuse_id)
	if self.myCircle then
		MsgManager.clientNotice(561)

		self.myCircle.injectionPointIdDic[infuse_id] = true

		local circleBattlePointAwardDlg = UIManager.getUI("circleBattlePointAwardDlg", nil, false)

		if circleBattlePointAwardDlg then
			circleBattlePointAwardDlg:refreshPanel(true)
			circleBattlePointAwardDlg:playInfuseAniShow(infuse_id)
		end

		self:checkCircleBattleAchieveHint()
	end
end

function CircleMixin:getActionLogStr(logType, param1, param2)
	local actionLogStr = ""

	if logType == Const.CIRCLE_ACTION_RECORD_TYPE.SEARCH then
		local name

		if param1 == Const.CIRCLE_GRID_OPEN_TYPE.MONSTER or param1 == Const.CIRCLE_GRID_OPEN_TYPE.BOSS then
			local info = ResClanBattleMonster[param2]

			if info then
				name = self:getMonsterNameByInfo(info)
			end
		else
			name = self:getGridNameByType(param1)
		end

		if name then
			local id

			id = (param1 == Const.CIRCLE_GRID_OPEN_TYPE.BOSS or param1 == Const.CIRCLE_GRID_OPEN_TYPE.BOX) and 528 or 527
			actionLogStr = utils.format(ClientUtils.getClientNotice(id), name)
		end
	elseif logType == Const.CIRCLE_ACTION_RECORD_TYPE.BATTLE then
		local info = ResClanBattleMonster[param2]

		if info then
			local name = self:getMonsterNameByInfo(info)

			if name then
				local id

				if info.type == Const.CIRCLE_BATTLE_BOSS then
					id = param1 == 0 and 532 or param1 == 1 and 531 or 567
					actionLogStr = ClientUtils.getClientNotice(id)
				else
					id = param1 == 0 and 530 or 529
					actionLogStr = utils.format(ClientUtils.getClientNotice(id), name)
				end
			end
		end
	elseif logType == Const.CIRCLE_ACTION_RECORD_TYPE.SKILL then
		local useOrBuy = param2
		local skillId = param1

		if useOrBuy == Const.CIRCLE_BATTLE_SKILL_OPLOG_TYPE.BUY then
			if ResClanBattleSkill[skillId] then
				actionLogStr = utils.format(ClientUtils.getClientNotice(583), ResClanBattleSkill[skillId].name)
			end
		elseif useOrBuy == Const.CIRCLE_BATTLE_SKILL_OPLOG_TYPE.USE and ResClanBattleSkill[skillId] then
			actionLogStr = utils.format(ClientUtils.getClientNotice(584), ResClanBattleSkill[skillId].name)
		end
	end

	return actionLogStr
end

function CircleMixin:getScoreLogStr(opType, param1, param2, param3, name)
	local scoreLogStr = opType .. "-" .. param1
	local playerName = utils.GetPlayerName(name)

	if opType == Const.CIRCLE_BATTLE_SCORE_LOG_OPTYPE.MEMBER_ACHIEVE then
		if ResClanBattleMemberAchieve[param1] then
			scoreLogStr = utils.format(ClientUtils.getClientNotice(578), ResClanBattleMemberAchieve[param1].name)
		end
	elseif opType == Const.CIRCLE_BATTLE_SCORE_LOG_OPTYPE.CIRCLE_ACHIEVE then
		if ResClanBattleClanAchieve[param1] then
			scoreLogStr = utils.format(ClientUtils.getClientNotice(579), ResClanBattleClanAchieve[param1].name)
		end
	elseif opType == Const.CIRCLE_BATTLE_SCORE_LOG_OPTYPE.OPEN_GRID then
		if param1 == Const.CIRCLE_GRID_OPEN_TYPE.BOSS then
			scoreLogStr = ClientUtils.getClientNotice(570)
		else
			local gridName = self:getGridNameByType(param1)

			if param2 == 1 then
				scoreLogStr = utils.format(ClientUtils.getClientNotice(569), gridName)
			else
				scoreLogStr = utils.format(ClientUtils.getClientNotice(568), gridName)
			end
		end
	elseif opType == Const.CIRCLE_BATTLE_SCORE_LOG_OPTYPE.BATTLE then
		local info = ResClanBattleMonster[param1]

		if info then
			local monsterName = self:getMonsterNameByInfo(info)

			if monsterName then
				if info.type ~= Const.CIRCLE_BATTLE_BOSS then
					if param2 == 0 then
						scoreLogStr = utils.format(ClientUtils.getClientNotice(574), monsterName)
					elseif param3 == 1 then
						scoreLogStr = utils.format(ClientUtils.getClientNotice(585), monsterName)
					else
						scoreLogStr = utils.format(ClientUtils.getClientNotice(573), monsterName)
					end
				elseif param2 == 0 then
					scoreLogStr = ClientUtils.getClientNotice(576)
				elseif param2 == 1 then
					if param3 == 1 then
						scoreLogStr = ClientUtils.getClientNotice(586)
					else
						scoreLogStr = ClientUtils.getClientNotice(575)
					end
				elseif param3 == 1 then
					scoreLogStr = ClientUtils.getClientNotice(587)
				else
					scoreLogStr = ClientUtils.getClientNotice(577)
				end
			end
		end
	elseif opType == Const.CIRCLE_BATTLE_SCORE_LOG_OPTYPE.FIND_BOX then
		if param1 == 0 then
			scoreLogStr = utils.format(ClientUtils.getClientNotice(572), self.name)
		else
			scoreLogStr = utils.format(ClientUtils.getClientNotice(572), playerName)
		end
	end

	return scoreLogStr
end

function CircleMixin:getMonsterNameByInfo(info)
	if info and info.type ~= Const.CIRCLE_BATTLE_BOSS then
		return self:getGridNameByType(Const.CIRCLE_GRID_OPEN_TYPE.MONSTER)
	else
		return self:getGridNameByType(Const.CIRCLE_GRID_OPEN_TYPE.BOSS)
	end
end

function CircleMixin:getGridNameByType(type)
	if type == Const.CIRCLE_GRID_OPEN_TYPE.NONE then
		type = 0
	end

	local info = ResClanGridType[type]

	if info then
		return info.name
	end

	return utils.format(Lang.get(40330), type)
end

function CircleMixin:onClanBattleUseSkillResp(skill, grid)
	self:_onCircleUseSkill(self.uid, skill, grid)
end

function CircleMixin:onClanBattleUseSkillNotify(uid, skill, grid)
	self:_onCircleUseSkill(uid, skill, grid)
end

function CircleMixin:onClanBattleGiveOrderResp(order, target, tick)
	if self.myCircle then
		MsgManager.clientNotice(552)
		self.myCircle:setOrder(order)
		self.myCircle:setTarget(target)
		self:refreshCircleBattleMainShow()
	end
end

function CircleMixin:onClanBattleGiveOrderNotify(uid, order, target)
	if self.myCircle then
		MsgManager.clientNotice(552)
		self.myCircle:setOrder(order)
		self.myCircle:setTarget(target)
		self:refreshCircleBattleMainShow()
	end
end

function CircleMixin:refreshCircleBattleMainShow()
	local circleBattleMainDlg = UIManager.getUI("circleBattleMainDlg", nil, false)

	if circleBattleMainDlg then
		circleBattleMainDlg:refreshCirleBattleInfo()
	end
end

local function _sortBattleLog(a, b)
	return a.tick > b.tick
end

function CircleMixin:updateScoreLog(log)
	self.scoreLogList = utils.deepcopy(log)
end

function CircleMixin:addScoreLog(optype, score, param1, param2, param3, uid)
	local name = ""

	if uid and self.myCircle then
		local member = self.myCircle:getCircleMember(uid)

		if member then
			name = member.base.name
		end
	end

	self:_addScoreLog(optype, score, param1, param2, param3, name)
end

function CircleMixin:_addScoreLog(optype, score, param1, param2, param3, name)
	local logInfo = {}

	logInfo.optype = optype or 0
	logInfo.score = score or 0
	logInfo.tick = ClientUtils.getServerTime()
	logInfo.param1 = param1 or 0
	logInfo.param2 = param2
	logInfo.param3 = param3
	logInfo.name = name or ""

	table.insert(self.scoreLogList, logInfo)
end

function CircleMixin:getScoreLog()
	if self.scoreLogList then
		table.sort(self.scoreLogList, _sortBattleLog)

		return self.scoreLogList
	end
end

function CircleMixin:getActionLog()
	if self.actionLogList then
		table.sort(self.actionLogList, _sortBattleLog)

		return self.actionLogList
	end
end

function CircleMixin:updateActionLog(log)
	self.actionLogList = utils.deepcopy(log)
end

function CircleMixin:_addActionLog(logInfo)
	table.insert(self.actionLogList, logInfo)
end

function CircleMixin:addSearchActionLog(uid, gridInfo)
	if not self.myCircle then
		return
	end

	local logType = Const.CIRCLE_ACTION_RECORD_TYPE.SEARCH
	local member = self.myCircle:getCircleMember(uid)
	local name = member ~= nil and member.base.name or ""
	local duty = member.duty
	local param1 = gridInfo.type
	local param2 = gridInfo.param
	local data = {
		type = logType,
		name = name,
		param1 = param1,
		param2 = param2,
		tick = ClientUtils.getServerTime(),
		duty = duty
	}

	self:_addActionLog(data)
end

function CircleMixin:addSkillActionLog(uid, skillId, useOrBuy)
	if not self.myCircle then
		return
	end

	local logType = Const.CIRCLE_ACTION_RECORD_TYPE.SKILL
	local member = self.myCircle:getCircleMember(uid)
	local duty = member.duty
	local name = member ~= nil and member.base.name or ""
	local param1 = skillId
	local param2 = useOrBuy
	local data = {
		type = logType,
		name = name,
		param1 = param1,
		param2 = param2,
		tick = ClientUtils.getServerTime(),
		duty = duty
	}

	self:_addActionLog(data)
end

function CircleMixin:addBattleActionLog(uid, gridInfo, result)
	if not self.myCircle then
		return
	end

	local logType = Const.CIRCLE_ACTION_RECORD_TYPE.BATTLE
	local member = self.myCircle:getCircleMember(uid)
	local duty = member.duty
	local name = member ~= nil and member.base.name or ""
	local param1 = 0

	param1 = gridInfo.type == Const.CIRCLE_GRID_OPEN_TYPE.BOSS and (result.killed == 1 and 2 or result.isLose and 0 or 1) or result.isLose and 0 or 1

	local param2 = gridInfo.param
	local data = {
		type = logType,
		name = name,
		param1 = param1,
		param2 = param2,
		tick = ClientUtils.getServerTime(),
		duty = duty
	}

	self:_addActionLog(data)
end

function CircleMixin:analyMemberAchieveData(actionType, progress, achieveGetDic)
	return self:_calCircleAchieveData(self.memberAchieveTypeDataDic, actionType, progress, achieveGetDic)
end

function CircleMixin:analyCircleAchieveData(actionType, progress, achieveGetDic)
	return self:_calCircleAchieveData(self.circleAchieveTypeDataDic, actionType, progress, achieveGetDic)
end

function CircleMixin:_calCircleAchieveData(achieveTypeDataDic, actionType, progress, achieveGetDic)
	local getedAchieveData
	local athieveList = achieveTypeDataDic[actionType]

	if athieveList and #athieveList > 0 then
		if progress < athieveList[1].action_param then
			getedAchieveData = {
				progress = progress,
				resData = athieveList[1],
				isEnd = #athieveList == 1 and 1 or 0,
				status = Const.ACHIEVE_STATUS.IN_PROCESS
			}
		else
			for idx, achieveData in ipairs(athieveList) do
				if progress >= achieveData.action_param then
					getedAchieveData = {
						progress = progress
					}

					if achieveGetDic ~= nil then
						if achieveGetDic[achieveData.id] then
							if athieveList[idx + 1] then
								getedAchieveData.resData = athieveList[idx + 1]
								getedAchieveData.isEnd = 0
								getedAchieveData.status = Const.ACHIEVE_STATUS.IN_PROCESS
							else
								getedAchieveData.resData = athieveList[idx]
								getedAchieveData.isEnd = 1
								getedAchieveData.status = Const.ACHIEVE_STATUS.AWARD_GOT
							end
						else
							getedAchieveData.resData = athieveList[idx]
							getedAchieveData.isEnd = idx == #athieveList and 1 or 0
							getedAchieveData.status = Const.ACHIEVE_STATUS.COMPLETE

							break
						end
					elseif achieveTypeDataDic[actionType][idx + 1] then
						getedAchieveData.resData = achieveTypeDataDic[actionType][idx + 1]
						getedAchieveData.isEnd = 0
						getedAchieveData.status = Const.ACHIEVE_STATUS.IN_PROCESS
					else
						getedAchieveData.resData = achieveTypeDataDic[actionType][idx]
						getedAchieveData.isEnd = 1
						getedAchieveData.status = Const.ACHIEVE_STATUS.AWARD_GOT
					end
				end
			end
		end
	end

	return getedAchieveData
end

function CircleMixin:calTotalConditionProgress(conditonDataList)
	local progress = 0

	if conditonDataList then
		for i, _ in ipairs(conditonDataList) do
			local conditonData = conditonDataList[i]

			if Const.CIRCLE_BATTLE_LAYER_TARGET_INFO[i] then
				local percent = Const.CIRCLE_BATTLE_LAYER_TARGET_INFO[i].percent

				progress = progress + math.floor(conditonData.curNum / conditonData.totalNum * percent)
			end
		end
	end

	return progress
end

function CircleMixin:onClanCreateResp(clan, next_tick)
	self.circleRoleData.next_tick = next_tick

	if not self:isEnterCircleInCD() then
		local cicle = Circle(clan)

		MsgManager.notice(Lang.get(1826))
		self:enterNewCircle(cicle)
	else
		MsgManager.clientNotice(202)
	end
end

function CircleMixin:onClanCreateRespError(ecode, clan, next_tick, hint)
	local createCircleDlg = UIManager.tryGetUI("createCircleDlg")

	if createCircleDlg then
		createCircleDlg.btnLockFlag = false

		if hint and #hint > 0 and (ecode == "kCSErrorClanNoticeInvalid" or ecode == "kCSErrorClanTitleInvalid" or ecode == "kCSErrorYiDunDirtyCommon") then
			createCircleDlg:markInputIllegal(hint)
		end
	end
end

function CircleMixin:onClanEnterNotify(clan)
	local circle = Circle(clan)

	MsgManager.notice(string.format(Lang.get(1824), circle.name))
	self:enterNewCircle(circle)

	local id = self:getCircleChatId()

	if id == nil then
		self.needSendCircleJoinMsg = true
	else
		self:_sendWhenJoin()
	end
end

function CircleMixin:enterNewCircle(circle)
	self:updateMyCircle(circle)
	UIManager.tryHideUI("createCircleDlg")
	UIManager.tryHideUI("showCircleDlg")
	UIManager.tryHideUI("circleInviteInfoDlg")

	self.inviterDataDic = {}

	RentMsgManager.clearRentMsg(true)

	local circleListDlg = UIManager.getUI("circleListDlg", nil, false)

	if circleListDlg then
		circleListDlg:setVisible(false)
		self:openMainCircleDlg()
	end

	self:checkInvitedHint()
end

function CircleMixin:openMainCircleDlg()
	local circleMainDlg = UIManager.getUI("circleMainDlg", true)
	local circle = self:tryGetCircleDetailInfo(self.circleRoleData.clangid)

	if circle then
		circleMainDlg:setCircle(circle)
	end
end

function CircleMixin:openShowCircle(clangid)
	local circle = self:tryGetCircleDetailInfo(clangid)

	if circle or clangid == self.circleRoleData.clangid then
		local showCircleDlg = UIManager.getUI("showCircleDlg", true)

		if circle then
			showCircleDlg:setCircle(circle)
		end
	end
end

function CircleMixin:tryGetCircleDetailInfo(circleGid, searchType)
	if self.cachedCircleDetailDic[circleGid] then
		local detailCD = circleGid == self.circleRoleData.clangid and CIRCLE_DETAIL_CD or OTHER_CIRCLE_DETAIL_CD

		if ClientUtils.getServerTime() > self.cachedCircleDetailDic[circleGid][1] + detailCD then
			if circleGid == self.circleRoleData.clangid then
				RPC.clanGet()

				if self.myCircle and self.myCircle.gid == circleGid then
					return self.myCircle
				end
			else
				RPC.clanSearch(circleGid, nil, searchType or Const.CIRCLE_SEARCH_DETAIL)
			end
		elseif self.myCircle then
			if self.myCircle.gid == circleGid then
				return self.myCircle
			else
				return self.cachedCircleDetailDic[circleGid][2]
			end
		else
			return self.cachedCircleDetailDic[circleGid][2]
		end
	elseif circleGid == self.circleRoleData.clangid then
		RPC.clanGet()

		if self.myCircle and self.myCircle.gid == circleGid then
			return self.myCircle
		end
	else
		RPC.clanSearch(circleGid, nil, searchType or Const.CIRCLE_SEARCH_DETAIL)
	end
end

function CircleMixin:tryGetCircleDetailInfoByName(circleName)
	for circleGid, circleInfo in pairs(self.cachedCircleDetailDic) do
		local circle = circleInfo[2]

		if circle.name == circleName then
			return circle
		end
	end

	RPC.clanSearch(nil, circleName, Const.CIRCLE_SEARCH_BYLIST)
end

function CircleMixin:addToCachedCircle(circle)
	self.cachedCircleDetailDic[circle.gid] = {
		ClientUtils.getServerTime(),
		circle
	}
end

function CircleMixin:onClanGetResp(clangid, next_tick, clan)
	self.circleRoleData.next_tick = next_tick
	self.circleRoleData.clangid = clangid

	if self.circleRoleData.clangid ~= 0 then
		local circle = Circle(clan)

		self:updateMyCircle(circle)
		self:addToCachedCircle(circle)
		self:refreshCircleDetailDlg(circle)

		local showCircleDlg = UIManager.getUI("showCircleDlg", nil, false)

		if showCircleDlg then
			showCircleDlg:setCircle(circle, showCircleDlg.isShowMode or nil)
		end
	end

	for mailId, mailData in pairs(self.mainMailBox.mailItems) do
		if mailData.mailType == Const.MAIL_TYPE_CIRCLE_USER_DEFINED and mailData.senderUid then
			if self:isInCircle() and self.myCircle then
				local member = self.myCircle:getCircleMember(mailData.senderUid)

				if not member then
					self.mainMailBox.mailItems[mailId] = nil
				end
			else
				self.mainMailBox.mailItems[mailId] = nil
			end
		end
	end

	self.mainMailBox:postProcess()
	self:refreshMailBox()
	self:checkMailUnreadHint()
	self:refreshCircleBattleMainShow()

	if self.isCircleBattleInit then
		local actObj = self:getCircleBattleActivity()

		if actObj then
			if actObj:inOpenState() and GameFsm.isInState(Const.STATE_MAIN_CIRCLE) then
				self:checkMyCircleBattleState()
			end

			if actObj.actData and actObj.actData:isDataReady() then
				self:checkCircleBattleState()
			else
				self.circleBattleNeedReconnectFlag = true
			end
		else
			self:checkCircleBattleState()
		end
	end

	self.isCircleBattleInit = nil
end

function CircleMixin:checkCircleBattleState(...)
	if GameFsm.isInState(Const.STATE_MAIN_CIRCLE) then
		CircleControlCenter.onReconnect()
	elseif GameFsm.isInState(Const.STATE_BATTLE) then
		local state = GameFsm.getState(Const.STATE_BATTLE)

		if state and state.battleType == BattleConst.BATTLE_TYPE_CIRCLE then
			self.needOutOfCircleBattle = true
		end
	end

	local circleBattleMainDlg = UIManager.getUI("circleBattleMainDlg", nil, false)

	if circleBattleMainDlg then
		circleBattleMainDlg:showDlg(true)
		circleBattleMainDlg:refreshTime()
		circleBattleMainDlg:refreshCirleBattleInfo()
	end

	self.circleBattleNeedReconnectFlag = nil
end

function CircleMixin:tryCloseNoticeChild(circleGid)
	RentMsgManager.closeAnyCircleMsgByOperation(circleGid)
end

function CircleMixin:onClanJoinResp(clangid, param)
	if param ~= Const.CIRCLE_JOIN_TYPE_INVITE then
		MsgManager.notice(Lang.get(1827))
	else
		MsgManager.clientNotice(603)
	end

	self:addApplyedCache(clangid)

	local circleListDlg = UIManager.getUI("circleListDlg", nil, false)

	if circleListDlg then
		circleListDlg:refreshCircleList(circleListDlg.circleList)
	end

	self:refreshRoleInfoUIs()
	UIManager.tryHideUI("showCircleDlg")
end

function CircleMixin:onClanJoinRespError(ecode, clangid)
	if ecode == "kCSErrorClanMemberIsFull" then
		self:addApplyedCache(clangid)

		local circleListDlg = UIManager.getUI("circleListDlg", nil, false)

		if circleListDlg then
			for idx, circle in ipairs(circleListDlg.circleList) do
				if circle.gid == clangid then
					circleListDlg.circleList[idx].memberCount = circleListDlg.circleList[idx]:getCircleMaxMemberCount()
				end
			end

			circleListDlg:refreshCircleList(circleListDlg.circleList)
		end

		UIManager.tryHideUI("showCircleDlg")
	end
end

function CircleMixin:updateMyCircle(circle)
	self.myCircle = circle
	self.circleRoleData.clangid = self.myCircle.gid

	local member = self.myCircle:getCircleMember(self.uid)

	if member then
		self.circleRoleData.duty = member.duty
		self.circleRoleData.mailTick = member.mail_tick
	end

	self:addToCachedCircle(self.myCircle)
	self:checkCircleSignHint()
	self:checkCircleBattleActionRedHint()
	self:checkCircleBattleAchieveHint()

	if not self.hintedCircleFrame then
		self.hintedCircleFrame = true

		for id, frameData in pairs(self.myCircle.haveFrameDic) do
			if frameData.id ~= self.myCircle.headFrameId and (frameData.endTime > 0 and frameData.endTime > ClientUtils.getServerTime() or frameData.endTime == 0) then
				self.hintCircleHeadFrameDic[frameData.id] = true
			end
		end

		self:hintCircleEditHead()
	end
end

function CircleMixin:refreshCircleDetailDlg(circle)
	local circleMainDlg = UIManager.getUI("circleMainDlg", nil, false)

	if circleMainDlg then
		if circle then
			circleMainDlg:setCircle(circle)
		elseif self:isInCircle() and self.myCircle then
			circleMainDlg:setCircle(self.myCircle)
		end
	end
end

function CircleMixin:onClanSearchResp(clan, param)
	local circleListDlg = UIManager.getUI("circleListDlg", nil, false)

	if param == Const.CIRCLE_SEARCH_BYLIST then
		if #clan > 0 then
			local circle = Circle(clan[1])

			self:addToCachedCircle(circle)

			if circleListDlg then
				circleListDlg:refreshSearchResult(circle)
			end

			self:refreshRoleInfoUIs(circle)
		elseif circleListDlg then
			circleListDlg:refreshSearchResult()
		end
	elseif param == Const.CIRCLE_SEARCH_DETAIL and #clan > 0 then
		local circle = Circle(clan[1])

		self:addToCachedCircle(circle)

		local showCircleDlg = UIManager.getUI("showCircleDlg", true)

		if showCircleDlg then
			showCircleDlg:setCircle(circle)
		end

		self:refreshRoleInfoUIs(circle)
	end
end

function CircleMixin:refreshRecommendIndex(count)
	self.totalRecommendPage = math.ceil(count / Const.CIRCLE_RECOMMEND_COUNT_PER_PAGE)

	if self.totalRecommendPage - self.recommendIndex > 1 then
		self.recommendIndex = self.recommendIndex + 1
	else
		self.recommendIndex = 0
	end
end

function CircleMixin:onClanRecommendResp(reclan, count)
	if self.lastGetRecommendTick < 0 then
		self.lastGetRecommendTick = 0
	else
		self.lastGetRecommendTick = ClientUtils.getServerTime()
	end

	self.cacheRecommendCircleList = {}

	for _, circleData in ipairs(reclan) do
		table.insert(self.cacheRecommendCircleList, Circle(circleData, true))
	end

	local circleListDlg = UIManager.getUI("circleListDlg", nil, false)

	if circleListDlg then
		circleListDlg:refreshCircleList(self.cacheRecommendCircleList)
	end

	self:refreshRecommendIndex(count)
end

function CircleMixin:refreshRecommendCircle()
	if self.totalRecommendPage == 1 then
		MsgManager.clientNotice(203)

		return
	end

	if ClientUtils.getServerTime() > self.lastGetRecommendTick + REFRESH_RECOMMEND_CD then
		RPC.clanRecommend(self.recommendIndex)
	else
		MsgManager.clientNotice(204)
	end
end

function CircleMixin:tryGetRecommendCircleList()
	if ClientUtils.getServerTime() > self.lastGetRecommendTick + REFRESH_RECOMMEND_CD then
		RPC.clanRecommend(self.recommendIndex)
	else
		return self.cacheRecommendCircleList
	end
end

function CircleMixin:getDutySpritePath(duty)
	return UIConst.CIRCLE_DUTY_SPRITE_PATH[duty]
end

function CircleMixin:getDutyName(duty)
	return Const.CIRCLE_DUTY_NAME_DIC[duty]
end

function CircleMixin:getDutyIcon(duty)
	return Const.CIRCLE_DUTY_ICON_DIC[duty]
end

function CircleMixin:getDutyNameColor(duty)
	if duty == Const.CIRCLE_DUTY_BOSS then
		return ResColor.QUALITYORANGE
	elseif duty == Const.CIRCLE_DUTY_ASSISTANT then
		return ResColor.GREYWHITE
	else
		return ResColor.GREYMAIN
	end
end

function CircleMixin:onClanRenameResp(tick, name)
	if self.myCircle then
		self.myCircle.name = name
		self.myCircle.renameTick = tick
	end

	MsgManager.clientNotice(205)
	UIManager.tryHideUI("circleEditNameDlg")
	self:simpleRefreshCircleMain()
end

function CircleMixin:onClanRenameRespError(ecode, tick, name, hint)
	local circleEditNameDlg = UIManager.tryGetUI("circleEditNameDlg")

	if circleEditNameDlg then
		circleEditNameDlg.btnLockFlag = false

		if hint and #hint > 0 and ecode == "kCSErrorYiDunDirtyCommon" then
			circleEditNameDlg:markInputIllegal(hint)
		end
	end
end

function CircleMixin:onClanRenoticeResp(title, notice, tick)
	if self.myCircle then
		self.myCircle.title = title
		self.myCircle.notice = notice
		self.myCircle.renoticeTick = tick
	end

	MsgManager.clientNotice(206)
	UIManager.tryHideUI("circleEditNoticeDlg")
	self:simpleRefreshCircleMain()
end

function CircleMixin:onClanRenoticeRespError(ecode, title, notice, tick, hint)
	local circleEditNoticeDlg = UIManager.tryGetUI("circleEditNoticeDlg")

	if circleEditNoticeDlg then
		circleEditNoticeDlg.btnLockFlag = false

		if hint and #hint > 0 and ecode == "kCSErrorYiDunDirtyCommon" then
			circleEditNoticeDlg:markInputIllegal(hint)
		end
	end
end

function CircleMixin:onClanLevelNotify(level)
	if self.myCircle then
		self.myCircle.level = level
	end

	MsgManager.clientNotice(207)
	self:refreshCircleDetailDlg(self.myCircle)
end

function CircleMixin:onClanReheadResp(tick, head)
	if self.myCircle then
		self.myCircle.headId = head
		self.myCircle.reheadTick = tick
	end

	MsgManager.clientNotice(208)
	UIManager.tryHideUI("circleEditHeadDlg")
	self:simpleRefreshCircleMain()

	local editCircleHeadDlg = UIManager.getUI("editCircleHeadDlg", nil, false)

	if editCircleHeadDlg then
		editCircleHeadDlg:refreshShow()
	end
end

function CircleMixin:onClanReHeadFrameResp(tick, head_frame)
	if self.myCircle then
		self.myCircle.headFrameId = head_frame
		self.myCircle.reheadFrameTick = tick
	end

	MsgManager.clientNotice(208)
	self:simpleRefreshCircleMain()

	local editCircleHeadDlg = UIManager.getUI("editCircleHeadDlg", nil, false)

	if editCircleHeadDlg then
		editCircleHeadDlg:refreshShow()
	end
end

function CircleMixin:simpleRefreshCircleMain()
	local circleMainDlg = UIManager.getUI("circleMainDlg", nil, false)

	if circleMainDlg then
		circleMainDlg:simpleRefreshCircle(self.myCircle)
	end
end

function CircleMixin:onClanAcceptApplyResp(applycnt, succcnt, apply)
	if applycnt == 1 then
		MsgManager.clientNotice(209)
		self.myCircle:refreshApplyList(apply)
		self:refreshCircleApplyList()
	else
		if applycnt == succcnt then
			MsgManager.clientNotice(210)
		elseif succcnt ~= 0 then
			MsgManager.clientNotice(211)
		else
			MsgManager.clientNotice(212)
		end

		self.myCircle:refreshApplyList(apply)
		self:refreshCircleApplyList()
	end
end

function CircleMixin:onClanAcceptApplyRespError(ecode, applycnt, succcnt, apply)
	if applycnt == 1 then
		if ecode == "kCSErrorClanNotInApplyList" then
			self.myCircle:refreshApplyList(apply)
			self:refreshCircleApplyList()
		end
	elseif ecode == "kCSErrorClanAllNotInApplyList" then
		self.myCircle:refreshApplyList(apply)
		self:refreshCircleApplyList()
	end
end

function CircleMixin:onClanRefuseApplyResp()
	return
end

function CircleMixin:refreshCircleApplyList()
	local circleMainDlg = UIManager.getUI("circleMainDlg", nil, false)

	if circleMainDlg then
		circleMainDlg.contentPanelList[Const.CIRCLE_APPLY_LIST_PANEL]:setCircle(self.myCircle)
	end
end

function CircleMixin:onClanSetAutoAcceptResp(switch)
	self.myCircle.isAutoPass = switch

	self:refreshCircleApplyList()
end

function CircleMixin:onClanExitResp(next_tick)
	self.circleRoleData.next_tick = next_tick

	MsgManager.clientNotice(213)
	self:exitAndClearMyCircle()
end

function CircleMixin:onClanDismissResp(next_tick)
	self.circleRoleData.next_tick = next_tick

	MsgManager.clientNotice(214)
	self:exitAndClearMyCircle()
end

function CircleMixin:onClanKickNotify(uid, next_tick)
	self.circleRoleData.next_tick = next_tick

	MsgManager.clientNotice(215)
	self:exitAndClearMyCircle()
end

function CircleMixin:exitAndClearMyCircle()
	self.applyedCircleDic = {}
	self.scoreLogList = {}
	self.actionLogList = {}
	self.hintExploreTalentDic = {}
	self.hintBattleTalentDic = {}

	if self.circleRoleData.clangid ~= 0 then
		self.cachedCircleDetailDic[self.circleRoleData.clangid] = nil
		self.myCircle = nil
		self.circleRoleData.clangid = 0
	end

	UIManager.tryHideUI("circleMainDlg")
	UIManager.tryHideUI("circleAppointDlg")
	UIManager.tryHideUI("circleEditNameDlg")
	UIManager.tryHideUI("circleEditNoticeDlg")
	UIManager.tryHideUI("circleEditMailDlg")
	UIManager.tryHideUI("circleEditHeadDlg")
	UIManager.tryHideUI("circleExitDlg")
	self:checkCircleSignHint()
	MsgManager.clearMsgByChannel(Const.CHANNEL_GUILD)
end

function CircleMixin:destroyCircleMixin()
	self.inviterDataDic = {}

	RentMsgManager.clearRentMsg(true)
end

function CircleMixin:_sendWhenSign(...)
	local randIdx = math.random(31, 36)
	local info = ResClanLog[randIdx]

	if info then
		MsgManager.sendBySystem(info.content, Const.CHANNEL_GUILD)
	end
end

function CircleMixin:_sendWhenJoin(...)
	local randIdx = math.random(1, 3)
	local info = ResClanLog[randIdx]

	if info then
		MsgManager.sendBySystem(info.content, Const.CHANNEL_GUILD)
	end
end

function CircleMixin:tryEnterCircleBattle(...)
	if not VersionUtils.hasAbilityCircleBattle() then
		if self:isActivityOpen(414) then
			UIManager.showConfirmWithId(1054, function(...)
				self:jumpToShowActivity(414)
			end)
		else
			MsgManager.clientNotice(597)
		end

		return
	end

	if not self:isInCircle() then
		MsgManager.notice(Lang.get(30050))

		return
	end

	local actObj = self:getActivityObjByType(Const.ACT_TYPE_CIRCLE_BATTLE)

	if actObj then
		local isValid, unlockDesc = actObj:isValid()

		if isValid then
			if GameFsm.isInState(Const.STATE_MAIN_CIRCLE) then
				CurAvatar:jumpToShowActivity(ResClanBattleMisc[1].act_tmplid)
			elseif (self.nextEnterCircleBattleTime or 0) > ClientUtils.getServerTime() then
				MsgManager.clientNotice(599)
			else
				local heros = self:getCircleBattleHeroList()

				if #heros > 0 then
					local hero = heros[1]
					local data = {
						resid = hero.id,
						skin = hero.skin,
						base = hero.base
					}

					self:tryCallCircleBattleRpc("clanBattleEnter", hero.gid, data)
				end
			end
		else
			MsgManager.notice(unlockDesc)
		end
	end
end

function CircleMixin:checkSendMyCircleRank(ranking)
	if ranking <= 0 then
		return
	end

	local actObj = self:getCircleBattleActivity()

	if actObj and actObj.actData then
		local result = actObj.actData:isTodayRecord("rankGet")

		if not result then
			local content = utils.format(ClientUtils.getClientNotice(582), ranking)

			self:receiveFakeGuildSystemMsg(content)
			actObj.actData:setTodayRecord("rankGet")
		end
	end
end

function CircleMixin:checkMyCircleRank(...)
	local actObj = self:getCircleBattleActivity()

	if actObj and actObj.actData then
		local result = actObj.actData:isTodayRecord("rankGet")

		if result then
			return
		end
	else
		return
	end

	local data = self:getCircleRealRanking()

	if data then
		self:checkSendMyCircleRank(data.rank)
	end
end

function CircleMixin:checkMyCircleBattleState(...)
	if self.myCircle then
		local member = self.myCircle:getCircleMember(self.uid)

		if member then
			local layer = self.myCircle:getCurBattleLayer()

			if member.battle_data.optype == Const.CIRCLE_PLAYER_STATE.FORMATION then
				self:tryCallCircleBattleRpc("clanBattleCancelMonster", layer, member.battle_data.oppos)
			elseif member.battle_data.optype == Const.CIRCLE_PLAYER_STATE.SEARCH then
				self:tryCallCircleBattleRpc("clanBattleCancelGrid", layer, member.battle_data.oppos)
			end
		end
	end
end

function CircleMixin:onClanBattleExitResp()
	if self.myCircle then
		local info = self.myCircle:getCircleMember(self.uid)

		if info then
			info.battle_data.inbattle = 0
		end
	end
end

function CircleMixin:onClanBattleEnterResp(clan)
	if not self.myCircle then
		return
	end

	local info = self.myCircle:getCircleMember(self.uid)

	if info then
		info.battle_data.inbattle = 1
	end

	self:updateMyCircle(Circle(clan))
	self:checkMyCircleBattleState()
	self:enterCircleBattleState()
	self:checkMyCircleRank()

	self.nextEnterCircleBattleTime = ClientUtils.getServerTime() + Const.CIRCLE_BATTLE_ENTER_CD
end

function CircleMixin:onClanBattleEnterRespError(error, clan)
	CurAvatar.checkFocusMarkGridLayer = nil
	CurAvatar.checkFocusMarkGridIndex = nil
end

function CircleMixin:enterCircleBattleState()
	local actId = ResClanBattleMisc[1].act_tmplid
	local actObj = self:getActivityObj(actId)

	if not actObj or not actObj.clientTemplateData then
		return
	end

	GameFsm.translateState(Const.STATE_MAIN_CIRCLE)
end

function CircleMixin:onClanBattleOccupyGridResp(layer, grid_pos, tick)
	self:_occupyGrid(self.uid, layer, grid_pos, tick)
end

function CircleMixin:onClanBattleCancelGridResp(layer, grid_pos, tick)
	self:_cancelOccupyGrid(self.uid, layer, grid_pos, tick)
end

function CircleMixin:onClanBattleOpenGridResp(layer, grid_pos, grid, tick, score, talent)
	self:_openGrid(self.uid, layer, grid_pos, grid, tick, score, talent)
end

function CircleMixin:onClanBattleOccupyGridNotify(uid, layer, grid_pos, tick)
	self:_occupyGrid(uid, layer, grid_pos, tick)
end

function CircleMixin:onClanBattleCancelGridNotify(uid, layer, grid_pos, tick)
	self:_cancelOccupyGrid(uid, layer, grid_pos, tick)
end

function CircleMixin:onClanBattleOpenGridNotify(uid, layer, grid_pos, grid, tick, score, talent)
	self:_openGrid(uid, layer, grid_pos, grid, tick, score, talent)
end

function CircleMixin:onClanBattleOccupyMonsterResp(layer, grid_pos, tick)
	self:_occupyMonster(self.uid, layer, grid_pos, tick)
end

function CircleMixin:onClanBattleCancelMonsterResp(layer, grid_pos, tick)
	self:_cancelMonster(self.uid, layer, grid_pos, tick)
end

function CircleMixin:onClanBattleOccupyMonsterNotify(uid, layer, grid_pos, tick)
	self:_occupyMonster(uid, layer, grid_pos, tick)
end

function CircleMixin:onClanBattleCancelMonsterNotify(uid, layer, grid_pos, tick)
	self:_cancelMonster(uid, layer, grid_pos, tick)
end

function CircleMixin:onClanBattlePVEStartNotify(uid, layer, grid_pos, tick)
	self:circleFightMonster(uid, layer, grid_pos, tick)
end

function CircleMixin:onClanBattlePVEFinishNotify(uid, finish)
	local isWin = self:isCircleBattleResultWin(finish)

	self:circleFightMonsterOver(uid, finish, isWin)
end

function CircleMixin:onClanBattleNextLayerResp(clan)
	self:_changeCircleBattleLayer(self.uid, clan)
end

function CircleMixin:onClanBattleEnterNotify(uid, model)
	if self.myCircle then
		local info = self.myCircle:getCircleMember(uid)

		if info then
			info.battle_data.inbattle = 1
			info.battle_data.model = model
		end

		CircleControlCenter.onPlayerEnter(uid)
	end
end

function CircleMixin:onClanBattleExitNotify(uid)
	if self.myCircle then
		local info = self.myCircle:getCircleMember(uid)

		if info then
			info.battle_data.inbattle = 0
		end

		CircleControlCenter.onPlayerExit(uid)
	end
end

function CircleMixin:onClanBattleNextLayerNotify(uid, clan)
	self:_changeCircleBattleLayer(uid, clan)
end

function CircleMixin:onClanBattleSetModelResp(model)
	self:_seCircleBattletModel(self.uid, model)
end

function CircleMixin:onClanBattleSetModelNotify(uid, model)
	self:_seCircleBattletModel(uid, model)
end

function CircleMixin:onClanBattlePVEQuitNotify(uid, finish)
	self:circleFightMonsterQuit(uid, finish)
end

function CircleMixin:_changeCircleBattleLayer(uid, clan)
	self:updateMyCircle(Circle(clan))
	CircleControlCenter.onChangeLayer(uid)

	for _, resData in ipairs(ResClanHead) do
		if resData.layer and self.myCircle.maxBattleLayer == resData.layer then
			self.hintCircleHeadDic[resData.id] = true

			break
		end
	end

	self:hintCircleEditHead()
	self.myCircle:setCurBattleLayerTick(ClientUtils.getServerTime())
end

function CircleMixin:hintCircleEditHead()
	if self:isInCircle() and self:getMyDutyPermission().rehead ~= nil then
		local elemCnt = utils.getTableElemCount(self.hintCircleHeadDic, true)

		elemCnt = elemCnt + utils.getTableElemCount(self.hintCircleHeadFrameDic, true)

		RedDotManager.setKeyState(UIConst.RD_HINT_CIRCLE_EDIT_HEAD, elemCnt > 0)
	else
		RedDotManager.setKeyState(UIConst.RD_HINT_CIRCLE_EDIT_HEAD, false)
	end
end

function CircleMixin:_seCircleBattletModel(uid, model)
	if self.myCircle then
		local info = self.myCircle:getCircleMember(uid)

		if info then
			info.battle_data.model = model
		end
	end

	if uid == self.uid then
		MsgManager.clientNotice(533)

		local ui = UIManager.tryGetUI("circleBattleChangeModelDlg")

		if ui then
			ui:setVisible(false)
		end

		if GameFsm.isInState(Const.STATE_MAIN_CIRCLE) then
			CircleControlCenter.refreshModel()
		end
	end
end

function CircleMixin:_occupyGrid(uid, layer, grid_pos, tick)
	if not self.myCircle then
		return
	end

	local info = self.myCircle:getCircleMember(uid)
	local preOpPos = -1

	if info then
		preOpPos = info.battle_data.oppos
		info.battle_data.oppos = grid_pos
		info.battle_data.optype = Const.CIRCLE_PLAYER_STATE.SEARCH
		info.battle_data.optick = tick
	end

	self:addCircleBattleTimer(Const.CIRCLE_TIMER_TYPE.OCCUPY, uid, tick, grid_pos, layer)
	CircleControlCenter.onOccupyGrid(uid, layer, grid_pos + 1, preOpPos)
end

function CircleMixin:_cancelOccupyGrid(uid, layer, grid_pos, tick)
	if not self.myCircle then
		return
	end

	local info = self.myCircle:getCircleMember(uid)

	if info then
		info.battle_data.cancel_tick = tick
		info.battle_data.optype = Const.CIRCLE_PLAYER_STATE.NONE
	end

	self:removeCircleBattleTimer(Const.CIRCLE_TIMER_TYPE.OCCUPY, uid)
	CircleControlCenter.onCancelGrid(uid, layer, grid_pos + 1)
end

function CircleMixin:_openGrid(uid, layer, grid_pos, grid, tick, score, talent)
	if not self.myCircle then
		return
	end

	local info = self.myCircle:getCircleMember(uid)

	if info then
		info.battle_data.oppos = grid_pos
		info.battle_data.optype = Const.CIRCLE_PLAYER_STATE.NONE
		info.battle_data.optick = tick
	end

	self:_checkCircleBattleOpenGrid(uid, layer)

	local newOpenNum = 0
	local refreshList = {}
	local repeatMap = {}

	for i, info in ipairs(grid.item) do
		self.myCircle.battleData.gridData[info.pos + 1] = info.grid

		if info.grid.status == Const.CIRCLE_GRID_STATUS.OPEN or info.grid.status == Const.CIRCLE_GRID_STATUS.SHOW then
			newOpenNum = newOpenNum + 1

			self:addSearchActionLog(uid, info.grid)
			self.myCircle:addHonorInfoDataValue(uid, "open_cnt", 1)
		end

		self:_checkCircleBattleRune(info.grid, uid)
		self:_checkCircleBattleMonster(info.grid, info.pos + 1, uid)
		self:_checkCircleBattleBox(info.grid, uid)

		if grid_pos == info.pos then
			self:_checkCircleBattleScore(info.grid, uid, true, nil, score, talent)
			self:_checkCircleBattleProficiency(info.grid, uid, true, layer)
		end

		if repeatMap[info.pos] then
			-- block empty
		else
			repeatMap[info.pos] = true
		end

		table.insert(refreshList, info.pos + 1)
	end

	self.myCircle:addCircleAchieveDataProgress(Const.CIRCLE_ACHIEVE_ACT_TYPE.OPEN_GRID, newOpenNum)
	self.myCircle:onOpenGridNotify()
	self:removeCircleBattleTimer(Const.CIRCLE_TIMER_TYPE.OCCUPY, uid)

	local isCrit = false

	for i, info in ipairs(talent) do
		local data = ResClanExploreTalent[info.id]

		if data and data.effect and data.effect[1].type == Const.CIRCLE_BATTLE_TALENT_EXPLORE_CRIT then
			isCrit = true
		end
	end

	local isExtraScore = false

	for i, info in ipairs(talent) do
		local data = ResClanExploreTalent[info.id]

		if data and data.effect and data.effect[1].type == Const.CIRCLE_BATTLE_TALENT_EXPLORE_EXRTA_SCORE then
			isExtraScore = true
		end
	end

	local extraData = {
		isCrit = isCrit,
		isExtraScore = isExtraScore
	}

	CircleControlCenter.onOpenGrid(uid, layer, grid_pos + 1, refreshList, extraData)
	self:refreshCircleBattleMainShow()
end

function CircleMixin:_checkCircleBattleScore(grid, uid, isOpen, result, score, talent)
	if not self.myCircle then
		return
	end

	local isTalentValid = 0

	if isOpen then
		if grid.status == Const.CIRCLE_GRID_STATUS.OPEN or grid.status == Const.CIRCLE_GRID_STATUS.SHOW then
			if talent and #talent > 0 then
				isTalentValid = 1
			end

			if self.uid == uid then
				self:addScoreLog(Const.CIRCLE_BATTLE_SCORE_LOG_OPTYPE.OPEN_GRID, score, grid.type, isTalentValid, nil, uid)
			end
		end
	else
		if talent then
			for i, info in ipairs(talent) do
				local data = ResClanBattleTalent[info.id]

				if data and data.effect and data.effect[1].type == Const.CIRCLE_BATTLE_TALENT_SCORE_ADD_BATTLE then
					isTalentValid = 1
				end
			end
		end

		local resultState = 0

		if grid.type == Const.CIRCLE_GRID_OPEN_TYPE.BOSS then
			if result.isLose == true then
				resultState = 0
			elseif result.killed == 0 then
				resultState = 1
			else
				resultState = 2
			end
		elseif grid.type == Const.CIRCLE_GRID_OPEN_TYPE.MONSTER then
			resultState = result.isLose == true and 0 or 1
		end

		if self.uid == uid then
			self:addScoreLog(Const.CIRCLE_BATTLE_SCORE_LOG_OPTYPE.BATTLE, score, grid.param, resultState, isTalentValid, uid)
		end
	end

	if score >= 0 then
		self.myCircle:addMemberScore(uid, score)

		if uid == self.uid then
			CircleControlCenter.putMsg(uid, Const.CIRCLE_BATTLE_MSG_TYPE.SCORE, score)
		end
	end
end

function CircleMixin:_checkCircleBattleProficiency(grid, uid, isOpen, isLose, layer)
	if not self.myCircle then
		return
	end

	local proficiency = -1

	if isOpen then
		if grid.status == Const.CIRCLE_GRID_STATUS.OPEN or grid.status == Const.CIRCLE_GRID_STATUS.SHOW then
			proficiency = self.myCircle:getOpenGridProficiency(layer)

			if uid == self.uid then
				self.myCircle:addExploreProficiency(proficiency)
			else
				self.myCircle:addMemberExploreProficiency(uid, proficiency)
			end
		end
	elseif grid.type == Const.CIRCLE_GRID_OPEN_TYPE.MONSTER or grid.type == Const.CIRCLE_GRID_OPEN_TYPE.BOSS then
		proficiency = self.myCircle:getFightMonsterProficiency(grid.param, isLose, layer)

		if uid == self.uid then
			self.myCircle:addBattleProficiency(proficiency)
		else
			self.myCircle:addMemberBattleProficiency(uid, proficiency)
		end
	end

	if proficiency >= 0 and uid == self.uid then
		if isOpen then
			CircleControlCenter.putMsg(uid, Const.CIRCLE_BATTLE_MSG_TYPE.PROFICIENCY_SEARCH, proficiency)
		else
			CircleControlCenter.putMsg(uid, Const.CIRCLE_BATTLE_MSG_TYPE.PROFICIENCY_BATTLE, proficiency)
		end
	end
end

function CircleMixin:_checkCircleBattleMonster(grid, clientGridPos, uid)
	if not self.myCircle then
		return
	end

	if grid.status == Const.CIRCLE_GRID_STATUS.SHOW and grid.type == Const.CIRCLE_GRID_OPEN_TYPE.BOSS then
		self.myCircle:addHonorInfoDataValue(uid, "find_boss", 1)
	end
end

function CircleMixin:_checkCircleBattleRune(grid, uid)
	if grid.status == Const.CIRCLE_GRID_STATUS.OPEN and grid.type == Const.CIRCLE_GRID_OPEN_TYPE.RUNE then
		self.myCircle:addRuneData(grid.param)
		self.myCircle:addHonorInfoDataValue(uid, "find_rune", 1)
	end
end

function CircleMixin:_checkCircleBattleOpenGrid(uid, layer)
	if self.myCircle then
		local point = self.myCircle:getOpenGridPointCost(layer)

		if uid == self.uid then
			CircleControlCenter.putMsg(uid, Const.CIRCLE_BATTLE_MSG_TYPE.MOVE_POINT, point)
			self.myCircle:addActionPoint(-point)
		else
			self.myCircle:addMemberActionPoint(uid, -point)
		end
	end
end

function CircleMixin:_checkCircleBattleBox(grid, uid)
	if not self.myCircle then
		return
	end

	if grid.status == Const.CIRCLE_GRID_STATUS.OPEN and grid.type == Const.CIRCLE_GRID_OPEN_TYPE.BOX then
		self.myCircle:addHonorInfoDataValue(uid, "find_box", 1)

		local score = self.myCircle:getBoxShareScore()

		self.myCircle:allMemberAddScore(score)

		local isOther = 0

		if uid ~= self.uid then
			isOther = 1
		end

		self:addScoreLog(Const.CIRCLE_BATTLE_SCORE_LOG_OPTYPE.FIND_BOX, score, isOther, nil, nil, uid)

		local contribution = self.myCircle:getBoxShareContribution()

		self.myCircle:addMemberContribution(uid, contribution)
	end
end

function CircleMixin:_checkCircleBattleBattleCount(grid, uid, layer)
	if self.myCircle then
		self.myCircle:addHonorInfoDataValue(uid, "pve_cnt", 1)

		local point = self.myCircle:getFightMonsterPointCost(grid.param, layer)

		if uid == self.uid then
			CircleControlCenter.putMsg(uid, Const.CIRCLE_BATTLE_MSG_TYPE.MOVE_POINT, point)
			self.myCircle:addActionPoint(-point)
		else
			self.myCircle:addMemberActionPoint(uid, -point)
		end
	end
end

function CircleMixin:_checkCircleBattleWinCount(grid, uid, result)
	if self.myCircle then
		if grid.type == Const.CIRCLE_GRID_OPEN_TYPE.BOSS then
			if not result.isLose and result.killed == 1 then
				self.myCircle:addCircleAchieveDataProgress(Const.CIRCLE_ACHIEVE_ACT_TYPE.KILL_MONSTER, 1)
				self.myCircle:addHonorInfoDataValue(uid, "pve_win_cnt", 1)
			end
		elseif not result.isLose then
			self.myCircle:addCircleAchieveDataProgress(Const.CIRCLE_ACHIEVE_ACT_TYPE.KILL_MONSTER, 1)
			self.myCircle:addHonorInfoDataValue(uid, "pve_win_cnt", 1)
		end
	end
end

function CircleMixin:_checkCircleBattleFightBoss(grid, uid)
	if self.myCircle and grid.type == Const.CIRCLE_GRID_OPEN_TYPE.BOSS then
		self.myCircle:addHonorInfoDataValue(uid, "boss_cnt", 1)
	end
end

function CircleMixin:_checkCircleBattleWinBoss(grid, uid, result)
	if self.myCircle and grid.type == Const.CIRCLE_GRID_OPEN_TYPE.BOSS and result.killed == 1 then
		self.myCircle:addHonorInfoDataValue(uid, "boss_win_cnt", 1)
	end
end

function CircleMixin:_occupyMonster(uid, layer, grid_pos, tick)
	if not self.myCircle then
		return
	end

	local info = self.myCircle:getCircleMember(uid)
	local preOpPos = -1

	if info then
		preOpPos = info.battle_data.oppos
		info.battle_data.oppos = grid_pos
		info.battle_data.optype = Const.CIRCLE_PLAYER_STATE.FORMATION
		info.battle_data.optick = tick
	end

	self.myCircle:refreshMonsterInfo(grid_pos + 1, nil, uid, layer)
	self:addCircleBattleTimer(Const.CIRCLE_TIMER_TYPE.FORMATION, uid, tick, grid_pos, layer)
	CircleControlCenter.onOccupyMonster(uid, layer, grid_pos + 1, preOpPos)
end

function CircleMixin:_cancelMonster(uid, layer, grid_pos, tick)
	if not self.myCircle then
		return
	end

	local info = self.myCircle:getCircleMember(uid)

	if info then
		info.battle_data.optype = Const.CIRCLE_PLAYER_STATE.NONE
		info.battle_data.optick = tick
		info.battle_data.cancel_tick = tick
	end

	self.myCircle:refreshMonsterInfo(grid_pos + 1, nil, nil, layer)
	self:removeCircleBattleTimer(Const.CIRCLE_TIMER_TYPE.FORMATION, uid)
	CircleControlCenter.onCancelOccupyMonster(uid, layer, grid_pos + 1)
end

function CircleMixin:circleFightMonster(uid, layer, grid_pos, tick)
	if not self.myCircle then
		return
	end

	local info = self.myCircle:getCircleMember(uid)

	if info then
		info.battle_data.oppos = grid_pos
		info.battle_data.optype = Const.CIRCLE_PLAYER_STATE.BATTLE
	end

	self.myCircle:refreshMonsterInfo(grid_pos + 1, nil, uid, layer)
	self:removeCircleBattleTimer(Const.CIRCLE_TIMER_TYPE.FORMATION, uid)
	self:addCircleBattleTimer(Const.CIRCLE_PLAYER_STATE.BATTLE, uid, tick, grid_pos, layer)
	CircleControlCenter.onFightMonster(uid, layer, grid_pos + 1)
end

function CircleMixin:circleFightMonsterOver(uid, finish, isWin)
	if not self.myCircle then
		return
	end

	local info = self.myCircle:getCircleMember(uid)

	if info then
		info.battle_data.optype = Const.CIRCLE_PLAYER_STATE.NONE
	end

	self:removeCircleBattleTimer(Const.CIRCLE_TIMER_TYPE.BATTLE, uid)

	local refreshList = {}
	local repeatMap = {}
	local gridInfo

	for i, info in ipairs(finish.grid.item) do
		if self.myCircle:getCurBattleLayer() == finish.layer then
			self.myCircle.battleData.gridData[info.pos + 1] = info.grid

			if repeatMap[info.pos] then
				-- block empty
			else
				repeatMap[info.pos] = true
			end

			table.insert(refreshList, info.pos + 1)
		end

		if info.pos == finish.grid_pos then
			gridInfo = info.grid
		end
	end

	if gridInfo then
		self:_checkCircleBattleFightBoss(gridInfo, uid)
		self:_checkCircleBattleBattleCount(gridInfo, uid, finish.layer)

		local result = {
			isLose = not isWin,
			killed = finish.killed
		}

		self:_checkCircleBattleWinCount(gridInfo, uid, result)
		self:_checkCircleBattleWinBoss(gridInfo, uid, result)
		self:addBattleActionLog(uid, gridInfo, result)
		self:_checkCircleBattleScore(gridInfo, uid, false, result, finish.score, finish.talent)
		self:_checkCircleBattleProficiency(gridInfo, uid, false, not isWin, finish.layer)

		if gridInfo.type == Const.CIRCLE_GRID_OPEN_TYPE.BOSS then
			local feat = finish.feat

			self.myCircle:addMemberBattleFeat(uid, feat)
		end
	end

	self:removeCircleBattleTimer(Const.CIRCLE_TIMER_TYPE.FORMATION, uid)
	self.myCircle:refreshMonsterInfo(finish.grid_pos + 1, finish.monster, nil, finish.layer)

	if finish.isboss == 1 then
		CircleControlCenter.onFightMonsterOver(uid, finish.layer, finish.grid_pos + 1, refreshList, finish.killed == 1)
	else
		CircleControlCenter.onFightMonsterOver(uid, finish.layer, finish.grid_pos + 1, refreshList)
	end

	self:refreshCircleBattleMainShow()
end

function CircleMixin:onClanBattleGetHonorResp(honor)
	if self.myCircle then
		self.cacheCircleHonorDataList = utils.deepcopy(honor.honor)

		local honorDataList = self.myCircle:analySvrHonorData(self.cacheCircleHonorDataList)
		local circleBattleHonorDlg = UIManager.getUI("circleBattleHonorDlg", true)

		circleBattleHonorDlg:setHonorInfoData(honorDataList)

		self.getCircleHonorDataTick = ClientUtils.getServerTime()
	end
end

function CircleMixin:tryGetClanBattleHonor()
	if self.myCircle then
		if self.cacheCircleHonorDataList and self.getCircleHonorDataTick + CIRCLE_BATTLE_GET_HONOR_CD >= ClientUtils.getServerTime() then
			return self.myCircle:analySvrHonorData(self.cacheCircleHonorDataList)
		else
			RPC.clanBattleGetHonor()
		end
	end
end

function CircleMixin:tryGetClanGuessRanking()
	if self.getCircleHonorDataTick and ClientUtils.getServerTime() < self.getCircleHonorDataTick + CIRCLE_BATTLE_GET_GUESS_RANK_CD then
		if self.clanGuessRankMember then
			self:onOpActGuessGetRankResp(self.clanGuessRankMember)
		end
	else
		RPC.opActGuessGetRank()

		self.getCircleHonorDataTick = ClientUtils.getServerTime()
	end
end

function CircleMixin:onOpActGuessGetRankResp(member)
	self.clanGuessRankMember = member

	local circleGuessRankingDlg = UIManager.getUI("circleGuessRankingDlg", true)

	circleGuessRankingDlg:setData(member)
end

function CircleMixin:circleFightMonsterQuit(uid, finish)
	if not self.myCircle then
		return
	end

	local info = self.myCircle:getCircleMember(uid)

	if info then
		info.battle_data.optype = Const.CIRCLE_PLAYER_STATE.NONE
		info.battle_data.cancel_tick = ClientUtils.getServerTime()
	end

	self:removeCircleBattleTimer(Const.CIRCLE_TIMER_TYPE.BATTLE, uid)

	local refreshList = {}

	for i, info in ipairs(finish.grid.item) do
		table.insert(refreshList, info.pos + 1)
	end

	self:removeCircleBattleTimer(Const.CIRCLE_TIMER_TYPE.FORMATION, uid)
	CircleControlCenter.onFightMonsterOver(uid, finish.layer, finish.grid_pos + 1, refreshList)
	self:refreshCircleBattleMainShow()
end

function CircleMixin:_onCircleUseSkill(uid, skill, grid)
	if not self.myCircle then
		return
	end

	self.myCircle:refreshCircleBattleSkill(skill)

	local circleBattleCircleSkillDlg = UIManager.getUI("circleBattleCircleSkillDlg", nil, false)

	if circleBattleCircleSkillDlg then
		circleBattleCircleSkillDlg:initCircleSkillData()
	end

	self:addSkillActionLog(uid, skill.id, Const.CIRCLE_BATTLE_SKILL_OPLOG_TYPE.USE)

	local refreshList = {}
	local repeatMap = {}

	for i, info in ipairs(grid.item) do
		self.myCircle.battleData.gridData[info.pos + 1] = info.grid

		if repeatMap[info.pos] then
			-- block empty
		else
			repeatMap[info.pos] = true
		end

		table.insert(refreshList, info.pos + 1)
	end

	CircleControlCenter.onUseSkill(uid, refreshList, skill)
end

function CircleMixin:addCircleBattleTimer(timerType, uid, timeStamp, grid_pos, layer)
	local typeInfo = Const.CIRCLE_TIMER_CONFIG[timerType]

	if not typeInfo then
		return
	end

	local leftTime = timeStamp + typeInfo.tick - ClientUtils.getServerTime()
	local key = typeInfo.name .. uid

	self:removeCircleBattleTimer(timerType, uid)

	if leftTime > 0 then
		local cb = self[typeInfo.cbName]
		local callBack

		if cb then
			callBack = Functor(cb, self, uid, grid_pos, layer)

			ClientTimerManager.startGlobalTimer(key, leftTime - 5, callBack)
		end
	end
end

function CircleMixin:removeCircleBattleTimer(timerType, uid)
	local typeInfo = Const.CIRCLE_TIMER_CONFIG[timerType]
	local key = typeInfo.name .. uid

	ClientTimerManager.stopGlobalTimer(key)
end

function CircleMixin:_occupyOverTimeCB(uid, grid_pos, layer)
	if not self.myCircle then
		return
	end

	local member = self.myCircle:getCircleMember(uid)

	if member then
		member.battle_data.optype = Const.CIRCLE_PLAYER_STATE.NONE
	end

	CircleControlCenter.onCancelGrid(uid, layer, grid_pos + 1)
end

function CircleMixin:_formationOverTimeCB(uid, grid_pos, layer)
	if not self.myCircle then
		return
	end

	local member = self.myCircle:getCircleMember(uid)

	if member then
		member.battle_data.optype = Const.CIRCLE_PLAYER_STATE.NONE
	end

	CircleControlCenter.onCancelOccupyMonster(uid, layer, grid_pos + 1)
end

function CircleMixin:_battleOverTimeCB(uid, grid_pos, layer)
	if not self.myCircle then
		return
	end

	local member = self.myCircle:getCircleMember(uid)

	if member then
		member.battle_data.optype = Const.CIRCLE_PLAYER_STATE.NONE
	end

	CircleControlCenter.onFightMonsterOver(uid, layer, grid_pos + 1)
end

function CircleMixin:checkCircleBattleActionRedHint(...)
	local result = false

	if self.myCircle then
		local actOj = self:getCircleBattleActivity()

		if actOj and actOj:inOpenState() then
			local action = self.myCircle:getActionPoint()

			result = action > 0
		end
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_CIRCLE_BATTLE_ACTION_POINT, result)
end

function CircleMixin:checkCircleBattleAchieveHint()
	local result = false

	if self.myCircle then
		local actOj = self:getCircleBattleActivity()

		if actOj and (actOj.curState == Const.OPACT_STATE_OPEN or actOj.curState == Const.OPACT_STATE_FREEZE) and (self:checkCircleAchieveComplete() or self:checkMemberAchieveComplete() or self:checkCanScoreInfuse()) then
			result = true
		end
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_CIRCLE_BATTLE_POINT_ACHIEVE, result)
end

function CircleMixin:checkMemberAchieveComplete()
	if self.myCircle and self.myCircle.memberAchieveDataDic then
		for _, achieveData in pairs(self.myCircle.memberAchieveDataDic) do
			if achieveData.status == Const.ACHIEVE_STATUS.COMPLETE then
				return true
			end
		end
	end

	return false
end

function CircleMixin:checkCircleAchieveComplete()
	if self.myCircle and self.myCircle.circleAchieveDataDic then
		for _, achieveData in pairs(self.myCircle.circleAchieveDataDic) do
			if achieveData.status == Const.ACHIEVE_STATUS.COMPLETE then
				return true
			end
		end
	end

	return false
end

function CircleMixin:checkCanScoreInfuse()
	if self.myCircle then
		local pointAwardList = self.myCircle:getPointAwardDataList()

		for _, awardData in ipairs(pointAwardList) do
			if awardData.status == Const.CIRCLE_POINT_STATUS.GET then
				return true
			end
		end
	end

	return false
end

function CircleMixin:checkExitCircleBattleFormation(layer, serverPos)
	if self.myCircle then
		local gridInfo = self.myCircle:getGridInfo(serverPos + 1, layer)

		if gridInfo then
			local member = self.myCircle:getCircleMember(self.uid)

			if gridInfo.type ~= Const.CIRCLE_GRID_OPEN_TYPE.BOSS then
				if member and member.battle_data.optype == Const.CIRCLE_PLAYER_STATE.FORMATION then
					self:tryCallCircleBattleRpc("clanBattleCancelMonster", layer, serverPos)
				end
			elseif member and member.battle_data.optype == Const.CIRCLE_PLAYER_STATE.FORMATION then
				self:tryCallCircleBattleRpc("clanBattleCancelMonster", layer, serverPos)
			end
		else
			self:_cancelMonster(self.uid, layer, serverPos, ClientUtils.getServerTime())
		end
	end
end

function CircleMixin:isCircleBattleStartValid(layer, serverPos)
	local actObj = self:getCircleBattleActivity()

	if actObj then
		if not actObj:inOpenState() then
			return false, ClientUtils.getClientNotice(596)
		end
	else
		return false, ClientUtils.getClientNotice(596)
	end

	if self.myCircle then
		if self.myCircle:getCurBattleLayer() == layer then
			local gridInfo = self.myCircle:getGridInfo(serverPos + 1, layer)

			if not gridInfo then
				return false, ""
			elseif gridInfo.type == Const.CIRCLE_GRID_OPEN_TYPE.BOSS then
				if self.myCircle:isBossDead(layer) then
					return false, ClientUtils.getClientNotice(538)
				else
					return true
				end
			else
				local member = self.myCircle:getCircleMember(self.uid)

				if member and member.battle_data.optype == Const.CIRCLE_PLAYER_STATE.FORMATION and member.battle_data.oppos == serverPos then
					return true
				end
			end
		else
			return false, ClientUtils.getClientNotice(539)
		end
	end

	return false, ClientUtils.getClientNotice(537)
end

function CircleMixin:isCircleBattleFinishValid(layer, serverPos)
	if self.myCircle then
		local uid = self.myCircle:getMonsterCurUid(serverPos + 1, layer)

		return uid == self.uid
	end
end

function CircleMixin:getCircleBattleFomationLeftTime(optick)
	local optype = Const.CIRCLE_PLAYER_STATE.FORMATION
	local info = Const.CIRCLE_TIMER_CONFIG[optype]

	if info then
		return optick + info.tick - ClientUtils.getServerTime()
	else
		return -1
	end
end

function CircleMixin:getTotalMarkGridTimes()
	local times = 0

	if self.myCircle and self:isInCircle() then
		local duty = self:getMyDuty()

		if duty == Const.CIRCLE_DUTY_BOSS or duty == Const.CIRCLE_DUTY_ASSISTANT or duty == Const.CIRCLE_DUTY_MANAGER then
			times = 1
		end
	end

	return times
end

function CircleMixin:sendMarkGridReq(mark, unmark)
	RPC.clanBattleOpGridMark(CircleControlCenter.showLayer, mark, unmark)
end

function CircleMixin:onClanBattleMarkedGridListNotify(layer, marked_grid)
	if self.myCircle then
		self.myCircle:onMarkedGridListNotify(layer, marked_grid)
	end
end

function CircleMixin:onClanBattleBoxMarkAwardNotify(layer, grid)
	if not self.myCircle or self.myCircle:getCurBattleLayer() ~= layer then
		return
	end

	local refreshList = {}

	for _, info in ipairs(grid.item) do
		self.myCircle.battleData.gridData[info.pos + 1] = info.grid

		table.insert(refreshList, info.pos + 1)
	end

	CircleControlCenter.onBoxMarkAward(refreshList)
end

function CircleMixin:enterClanBattle(layer, focusIndex, jumpCallBack)
	if not self:isInCircle() then
		MsgManager.notice(Lang.get(30050))

		return
	end

	local actObj = CurAvatar:getActivityObj(Const.CIRCLE_BATTLE_ACTIVITY_ID)

	if actObj then
		local isOpen = actObj:isValidExceptCondition()
		local isConLimit, desc = actObj:isInConditionLimit()

		if isOpen then
			if isConLimit then
				MsgManager.notice(desc)
			elseif GameFsm.isInState(Const.STATE_MAIN_CIRCLE) then
				if self.myCircle:checkCanFocusMarkGrid(layer, focusIndex, true) then
					CircleControlCenter.focusOnIndex(focusIndex, Const.CIRCLE_BATTLE_ZOOM_DURATION)
				end
			else
				local heros = CurAvatar:getCircleBattleHeroList()

				if #heros > 0 then
					local hero = heros[1]
					local data = {
						resid = hero.id,
						skin = hero.skin,
						base = hero.base
					}

					self.checkFocusMarkGridLayer = layer
					self.checkFocusMarkGridIndex = focusIndex

					CurAvatar:tryCallCircleBattleRpc("clanBattleEnter", hero.gid, data)

					if jumpCallBack then
						jumpCallBack()
					end
				end
			end
		elseif isConLimit then
			local tips = ClientUtils.getClientNotice(410)

			tips = tips .. desc

			MsgManager.notice(tips)
		else
			MsgManager.clientNotice(409)
		end
	else
		MsgManager.clientNotice(345)
	end
end

function CircleMixin:checkCircleActivityOpen()
	local actOj = CurAvatar:getActivityObj(Const.CIRCLE_BATTLE_ACTIVITY_ID)

	if actOj and (actOj:inOpenState() or actOj:inFreeze()) then
		local min = ResClanMisc[1].mark_min_layer or 0
		local old = self.myCircle.maxBattleLayer

		return min <= old
	else
		return false
	end
end

function CircleMixin:checkCanMarkMember()
	return self:isLeader()
end

function CircleMixin:sendMarkMemberReq(uid)
	RPC.clanBattleMarkMember(uid)
end

function CircleMixin:sendUnmarkMemberReq(uid)
	RPC.clanBattleUnmarkMember(uid)
end

function CircleMixin:onClanBattleMarkMemberResp(uid, tick)
	if self.myCircle then
		self.myCircle:onMarkMemberResp(uid, tick, true)

		local circleBattleHonorDlg = UIManager.getUI("circleBattleHonorDlg", true)

		if circleBattleHonorDlg then
			circleBattleHonorDlg:onMarkDataChange(uid)
		end
	end
end

function CircleMixin:onClanBattleUnmarkMemberResp(uid, tick)
	if self.myCircle then
		self.myCircle:onMarkMemberResp(uid, tick, false)

		local circleBattleHonorDlg = UIManager.getUI("circleBattleHonorDlg", true)

		if circleBattleHonorDlg then
			circleBattleHonorDlg:onMarkDataChange(uid)
		end
	end
end

return CircleMixin
