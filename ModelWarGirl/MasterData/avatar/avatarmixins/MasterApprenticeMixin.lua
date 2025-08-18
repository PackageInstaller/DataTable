-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Avatar\\AvatarMixins\\MasterApprenticeMixin.lua

local ResMasterMisc = require("ClientData/ResMasterMisc")
local ResMasterLevel = require("ClientData/ResMasterLevel")
local ResClientNotice = require("ClientData/ResClientNotice")
local OtherPlayer = require("Common/Object/OtherPlayer")
local UserData = require("Helper.UserData")
local Hero = require("Common/Object/Hero")
local MasterApprenticeMixin = {}

function MasterApprenticeMixin:initMasterApprenticeMixin(baseData, syncData)
	local data = syncData.other.master_apprentice

	self.checkEnrollMaster = data.enroll_type == 1
	self.checkEnrollApprentice = data.enroll_type == 2
	self.totalMasterExp = data.master_exp or 0
	self.masterLv, self.masterExp = self:getMasterLevel(data.master_exp)
	self.masterApprenticeDelTick = data.del_tick or 0
	self.apprenticeUidList = {}
	self.apprenticeDic = {}
	self.masterApprenticeTaskDic = {}

	if data.master_task then
		if data.master_task.daily_task then
			self:updateMasterApprenticeTask(Const.MASTER_APPRENTICE_TASK_TYPE.MasterDaily, data.master_task.daily_task)
		end

		if data.master_task.cycle_task then
			self:updateMasterApprenticeTask(Const.MASTER_APPRENTICE_TASK_TYPE.MasterCycle, data.master_task.cycle_task)
		end
	end

	if data.apprentice_task then
		if data.apprentice_task.daily_task then
			self:updateMasterApprenticeTask(Const.MASTER_APPRENTICE_TASK_TYPE.ApprenticeDaily, data.apprentice_task.daily_task)
		end

		if data.apprentice_task.once_task then
			self:updateMasterApprenticeTask(Const.MASTER_APPRENTICE_TASK_TYPE.ApprenticeOnce, data.apprentice_task.once_task)
		end
	end

	self.masterLvAwardGotDic = {}

	if data.level_awarded then
		local list = ClientUtils.getBitsListFromByteString(data.level_awarded.bits)

		for _, pos in pairs(list) do
			self.masterLvAwardGotDic[pos] = true
		end
	end

	self.masterGuideHeroGidList = {}
	self.lastRequestMasterGuideTick = 0

	if data.guide_hero then
		for _, hero in ipairs(data.guide_hero.hero.hero) do
			table.insert(self.masterGuideHeroGidList, hero.gid)
		end

		self.lastRequestMasterGuideTick = data.guide_hero.last_request_tick
	end

	self.apprenticeGuideHeroDic = {}

	if data.all_guide_hero and data.all_guide_hero.apprentice_data then
		for _, guideData in ipairs(data.all_guide_hero.apprentice_data) do
			local t = {}

			for _, hero in ipairs(guideData.hero.hero) do
				table.insert(t, hero.gid)
			end

			self.apprenticeGuideHeroDic[guideData.apprentice_id] = t
		end
	end

	self.masterBattleGuideData = {}

	if data.formation then
		self.masterBattleGuideData.stage = data.formation.stage
		self.masterBattleGuideData.formation = data.formation.hero
	end

	self.apprenticeRequestBattleGuideDic = {}

	if data.battle_stage then
		for _, v in pairs(data.battle_stage) do
			self.apprenticeRequestBattleGuideDic[v.apprentice_id] = v.stage
		end
	end

	self.masterInviteUidList = {}
	self.masterInviteDic = {}
	self.apprenticeInviteUidList = {}
	self.apprenticeInviteDic = {}
end

function MasterApprenticeMixin:initCheckMasterApprenticeMixin()
	self:refreshInviteRed()
	self:refreshTaskRed()
	self:refreshMasterLvAwardRed()
	self:initMasterApprenticeDevelopGuideRed()
	self:initMasterApprenticeBattleGuideRed()
	self:initApprenticeGraduateRed()
end

function MasterApprenticeMixin:updateMasterApprenticeTask(taskType, taskList)
	local t = {}

	if taskList then
		for i = 1, #taskList do
			table.insert(t, taskList[i].data)
		end
	end

	self.masterApprenticeTaskDic[taskType] = t
end

function MasterApprenticeMixin:checkHaveMaster()
	return self.master ~= nil
end

function MasterApprenticeMixin:checkHaveApprentice()
	return self.apprenticeUidList ~= nil and #self.apprenticeUidList > 0
end

function MasterApprenticeMixin:checkHistoryHaveApprentice()
	return self:checkHaveApprentice() or self.totalMasterExp > 0
end

function MasterApprenticeMixin:isMyMaster(uid, isTip)
	local check = self.master ~= nil and self.master.uid == uid

	if isTip and not check then
		MsgManager.clientNotice(784)
	end

	return check
end

function MasterApprenticeMixin:isMyApprentice(uid, isTip)
	local check = self.apprenticeDic and self.apprenticeDic[uid] ~= nil

	if isTip and not check then
		MsgManager.clientNotice(783)
	end

	return check
end

function MasterApprenticeMixin:checkAddMasterCondition()
	if ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_MONUMENT) then
		return false
	end

	local conditionList = ResMasterMisc[1].add_master_condition

	if conditionList then
		for i = 1, #conditionList do
			if ConditionLimitManager.inLimitState(conditionList[i]) then
				return true
			end
		end
	end

	return false
end

function MasterApprenticeMixin:checkCanAddMaster()
	if not Const.Master_Apprentice_OPEN then
		return false
	end

	return not self:checkHaveMaster() and self:checkAddMasterCondition()
end

function MasterApprenticeMixin:checkCanAddApprentice()
	if not Const.Master_Apprentice_OPEN then
		return false
	end

	if ConditionLimitManager.inLimitState(Const.CONDITION_LIMIT_MONUMENT) then
		return false
	end

	local conditionList = ResMasterMisc[1].add_apprentice_condition

	if conditionList then
		for i = 1, #conditionList do
			if ConditionLimitManager.inLimitState(conditionList[i]) then
				return false
			end
		end
	end

	return true
end

function MasterApprenticeMixin:getCurMaxApprenticeNum()
	local maxApprenticeNum = ResMasterLevel[self.masterLv] and ResMasterLevel[self.masterLv].apprentice_num or 1

	return maxApprenticeNum
end

function MasterApprenticeMixin:checkRecordAddMasterApprentice(uid)
	return self.recordAddMasterApprenticeDic ~= nil and self.recordAddMasterApprenticeDic[uid]
end

function MasterApprenticeMixin:rpcAddMasterApprentice(target_type, uid)
	RPC.masterApprenticeAdd(target_type, uid)

	self.recordAddMasterApprenticeDic = self.recordAddMasterApprenticeDic or {}
	self.recordAddMasterApprenticeDic[uid] = true
end

function MasterApprenticeMixin:getMasterApprenticeCd()
	local curTime = ClientUtils.getServerTime()
	local cd = self.masterApprenticeDelTick + ResMasterMisc[1].delete_cd - curTime

	return cd
end

function MasterApprenticeMixin:checkCanAddMasterApprentice(targetType, isTip)
	if targetType == Const.MASTER_APPRENTICE_TYPE.Apprentice then
		if not self:checkCanAddApprentice() then
			return false
		end

		local maxApprenticeNum = self:getCurMaxApprenticeNum()
		local curApprenticeNum = self.apprenticeUidList and #self.apprenticeUidList or 0

		if maxApprenticeNum <= curApprenticeNum then
			if isTip then
				MsgManager.clientNotice(785)
			end

			return false
		end
	elseif not self:checkCanAddMaster() then
		return false
	end

	local cd = self:getMasterApprenticeCd()

	if cd > 0 then
		if isTip then
			local strTime = ClientUtils.getTimeStrBySecond(cd)

			if targetType == Const.MASTER_APPRENTICE_TYPE.Master then
				MsgManager.notice(string.format(ResClientNotice[780].notice, strTime))
			else
				MsgManager.notice(string.format(ResClientNotice[781].notice, strTime))
			end
		end

		return false
	end

	return true
end

function MasterApprenticeMixin:getMasterLevel(exp)
	exp = exp or 0

	local lv = 0
	local leftExp = exp

	for i = #ResMasterLevel, 1, -1 do
		local config = ResMasterLevel[i]

		if exp >= config.need_xp then
			lv = config.level
			leftExp = exp - config.need_xp

			break
		end
	end

	return lv, leftExp
end

function MasterApprenticeMixin:isMaxMasterLevel()
	return self.masterLv >= #ResMasterLevel
end

function MasterApprenticeMixin:guideApprentice(uid, stage)
	if CurAvatar:isMyApprentice(uid, true) then
		if self.recodeApprenticeAllHeroDataDic then
			local apprenticeAllHeroData = self.recodeApprenticeAllHeroDataDic[uid]
			local cur = ClientUtils.getServerTime()

			if apprenticeAllHeroData and cur - apprenticeAllHeroData.time < 60 then
				self:realGuideApprentice(uid, stage, apprenticeAllHeroData)

				return
			end
		end

		self.guideStage = stage

		RPC.masterGetApprenticeAllHero(uid)
	end
end

function MasterApprenticeMixin:realGuideApprentice(uid, stage, apprenticeAllHeroData)
	if stage then
		local s1, s2, s3

		s1 = stage % 100
		s2 = math.floor(stage / 100) % 100
		s3 = math.floor(stage / 10000)

		local guideLevelInfo = CurAvatar:getMainStageInfo(s3, s2, s1)
		local stageInfo = {}

		stageInfo.stageData = {
			guideLevelInfo.season,
			guideLevelInfo.chapter,
			guideLevelInfo.level,
			guideLevelInfo
		}
		stageInfo.formationForceEmpty = true
		stageInfo.guideUid = uid
		stageInfo.guideStage = stage
		stageInfo.defineHeros = apprenticeAllHeroData.heroDic

		CurAvatar:enterFormation(guideLevelInfo.pve_id, BattleConst.BATTLE_TYPE_STAGE, stageInfo)
	else
		local ui = UIManager.getUI("masterApprenticeGuideDlg", true)

		if ui then
			local guide_hero = self.apprenticeGuideHeroDic[uid]

			ui:setData(Const.MASTER_APPRENTICE_TYPE.Master, uid, apprenticeAllHeroData.heroDic, apprenticeAllHeroData.crystal_hero, guide_hero)
		end
	end
end

function MasterApprenticeMixin:checkShowApplyMasterBattleGuide(battleType)
	if battleType ~= BattleConst.BATTLE_TYPE_STAGE then
		return false
	end

	if not self:checkHaveMaster() then
		return false
	end

	local masterStageInfo = self.master.stageInfo
	local masterData = CurAvatar:getMainStageInfo(masterStageInfo[1], masterStageInfo[2], masterStageInfo[3])

	if not masterData then
		return false
	end

	local curData = CurAvatar:getNextMainStageInfo()

	return masterData.idx >= curData.idx
end

function MasterApprenticeMixin:checkCanApprenticeGraduate()
	if not self:checkHaveMaster() then
		return false
	end

	local check = true
	local miscConfig = ResMasterMisc[1]
	local conditionList = miscConfig.graduate_condition

	for _, conditionId in pairs(conditionList) do
		if ConditionLimitManager.inLimitState(conditionId) then
			check = false

			break
		end
	end

	return check
end

function MasterApprenticeMixin:getNewMasterOrApprentice(info)
	local data = OtherPlayer()

	data:initDataByMasterApprenticeData(info)

	return data
end

function MasterApprenticeMixin:onMasterApprenticeNotify(target_type, master, apprentice_list)
	if target_type == Const.MASTER_APPRENTICE_TYPE.Master then
		self.master = self:getNewMasterOrApprentice(master)
	elseif target_type == Const.MASTER_APPRENTICE_TYPE.Apprentice then
		self.apprenticeUidList = {}
		self.apprenticeDic = {}

		if apprentice_list then
			for i = 1, #apprentice_list do
				local data = self:getNewMasterOrApprentice(apprentice_list[i])
				local uid = data.uid

				table.insert(self.apprenticeUidList, uid)

				self.apprenticeDic[uid] = data
			end
		end
	end

	self:refreshAddOrDelMasterApprenticeRed()
end

function MasterApprenticeMixin:onMasterApprenticeAddNotify(target_type, info)
	local data = self:getNewMasterOrApprentice(info)

	if target_type == Const.MASTER_APPRENTICE_TYPE.Master then
		self.master = data
	elseif target_type == Const.MASTER_APPRENTICE_TYPE.Apprentice then
		local uid = data.uid

		self.apprenticeUidList = self.apprenticeUidList or {}
		self.apprenticeDic = self.apprenticeDic or {}

		if not self:isMyApprentice(uid) then
			table.insert(self.apprenticeUidList, uid)
		end

		self.apprenticeDic[uid] = data
	end

	local ui = UIManager.tryGetUI("masterApprenticeMainDlg")

	if ui then
		ui:onMasterApprenticeAddNotify(target_type)
	end

	local ui = UIManager.tryGetUI("chatDlg")

	if ui then
		ui:refreshMasterApprentice()
	end

	self:refreshAddOrDelMasterApprenticeRed()
end

function MasterApprenticeMixin:onMasterApprenticeDelResp(target_type, uid, del_tick)
	self.masterApprenticeDelTick = del_tick or 0

	if target_type == Const.MASTER_APPRENTICE_TYPE.Master then
		self.master = nil
	elseif target_type == Const.MASTER_APPRENTICE_TYPE.Apprentice and self.apprenticeDic[uid] then
		local idx = utils.getIndexByValue(self.apprenticeUidList, uid)

		table.remove(self.apprenticeUidList, idx)

		self.apprenticeDic[uid] = nil
	end

	local ui = UIManager.tryGetUI("roleInfoOtherDlg")

	if ui then
		ui:refreshMasterApprentice()
	end

	local ui = UIManager.tryGetUI("masterApprenticeMainDlg")

	if ui then
		ui:onMasterApprenticeDelNotify(target_type)
	end

	local ui = UIManager.tryGetUI("chatDlg")

	if ui then
		ui:refreshMasterApprentice()
	end

	self:refreshAddOrDelMasterApprenticeRed()
end

function MasterApprenticeMixin:onMasterApprenticeDelNotify(target_type, uid)
	if target_type == Const.MASTER_APPRENTICE_TYPE.Master then
		self.master = nil
	elseif target_type == Const.MASTER_APPRENTICE_TYPE.Apprentice and self.apprenticeDic[uid] then
		local idx = utils.getIndexByValue(self.apprenticeUidList, uid)

		table.remove(self.apprenticeUidList, idx)

		self.apprenticeDic[uid] = nil
	end

	local ui = UIManager.tryGetUI("roleInfoOtherDlg")

	if ui then
		ui:refreshMasterApprentice()
	end

	local ui = UIManager.tryGetUI("masterApprenticeMainDlg")

	if ui then
		ui:onMasterApprenticeDelNotify(target_type)
	end

	local ui = UIManager.tryGetUI("chatDlg")

	if ui then
		ui:refreshMasterApprentice()
	end

	self:refreshAddOrDelMasterApprenticeRed()
end

function MasterApprenticeMixin:onMasterApprenticeGraduationResp()
	self.master = nil

	local ui = UIManager.tryGetUI("apprenticeGraduateDlg")

	if ui then
		ui:setVisible(false)
	end

	local ui = UIManager.tryGetUI("masterApprenticeMainDlg")

	if ui then
		ui:onMasterApprenticeGraduationResp()
	end

	local ui = UIManager.tryGetUI("chatDlg")

	if ui then
		ui:refreshMasterApprentice()
	end

	self:refreshAddOrDelMasterApprenticeRed()
end

function MasterApprenticeMixin:onMasterApprenticeAddResp()
	return
end

function MasterApprenticeMixin:onMasterApprenticeInviteNotify(master_invite_list, apprentice_invite_list)
	self.masterInviteUidList = {}
	self.masterInviteDic = {}

	if master_invite_list then
		for i = 1, #master_invite_list do
			local data = self:getNewMasterOrApprentice(master_invite_list[i])
			local uid = data.uid

			if not self.masterInviteDic[uid] then
				table.insert(self.masterInviteUidList, uid)
			end

			self.masterInviteDic[uid] = data
		end
	end

	self.apprenticeInviteUidList = {}
	self.apprenticeInviteDic = {}

	if apprentice_invite_list then
		for i = 1, #apprentice_invite_list do
			local data = self:getNewMasterOrApprentice(apprentice_invite_list[i])
			local uid = data.uid

			if not self.apprenticeInviteDic[uid] then
				table.insert(self.apprenticeInviteUidList, uid)
			end

			self.apprenticeInviteDic[uid] = data
		end
	end

	self:refreshInviteRed()
end

function MasterApprenticeMixin:onMasterApprenticeInviteAddNotify(master_invite, apprentice_invite)
	if master_invite then
		local data = self:getNewMasterOrApprentice(master_invite)
		local uid = data.uid

		if not self.masterInviteDic[uid] then
			table.insert(self.masterInviteUidList, uid)
		end

		self.masterInviteDic[uid] = data
	end

	if apprentice_invite then
		local data = self:getNewMasterOrApprentice(apprentice_invite)
		local uid = data.uid

		if not self.apprenticeInviteDic[uid] then
			table.insert(self.apprenticeInviteUidList, uid)
		end

		self.apprenticeInviteDic[uid] = data
	end

	self:refreshInviteRed()
end

function MasterApprenticeMixin:onMasterApprenticeInviteDelNotify(master_invite_uid, apprentice_invite_uid)
	if master_invite_uid and self.masterInviteDic[master_invite_uid] then
		local idx = utils.getIndexByValue(self.masterInviteUidList, master_invite_uid)

		table.remove(self.masterInviteUidList, idx)

		self.masterInviteDic[master_invite_uid] = nil
	end

	if apprentice_invite_uid and self.apprenticeInviteDic[apprentice_invite_uid] then
		local idx = utils.getIndexByValue(self.apprenticeInviteUidList, apprentice_invite_uid)

		table.remove(self.apprenticeInviteUidList, idx)

		self.apprenticeInviteDic[apprentice_invite_uid] = nil
	end

	self:refreshInviteRed()
end

function MasterApprenticeMixin:onMasterApprenticeInviteOpResp(targetType, opType, uid, fails)
	if fails and #fails > 0 then
		for _, fail in pairs(fails) do
			if fail.reason == "kCSErrorTargeMasterIsFull" then
				MsgManager.clientNotice(791)
			elseif fail.reason == "kCSErrorTargeApprenticeIsFull" then
				MsgManager.clientNotice(792)
			end
		end

		return
	end

	local checkAdd = false

	if targetType == Const.MASTER_APPRENTICE_TYPE.Master then
		local data = self.masterInviteDic[uid]

		if opType == Const.MASTER_APPRENTICE_OP_TYPE.Accept then
			if data then
				if not self:isMyMaster(uid) then
					self.master = data
				end

				checkAdd = true

				local idx = utils.getIndexByValue(self.masterInviteUidList, uid)

				table.remove(self.masterInviteUidList, idx)

				self.masterInviteDic[uid] = nil

				MsgManager.clientNotice(789)
			end
		elseif uid == 0 then
			self.masterInviteUidList = {}
			self.masterInviteDic = {}
		elseif data then
			local idx = utils.getIndexByValue(self.masterInviteUidList, uid)

			table.remove(self.masterInviteUidList, idx)

			self.masterInviteDic[uid] = nil
		end
	else
		local data = self.apprenticeInviteDic[uid]

		if opType == Const.MASTER_APPRENTICE_OP_TYPE.Accept then
			if data then
				if not self:isMyApprentice(uid) then
					self.apprenticeUidList = self.apprenticeUidList or {}
					self.apprenticeDic = self.apprenticeDic or {}

					table.insert(self.apprenticeUidList, uid)

					self.apprenticeDic[uid] = data
				end

				checkAdd = true

				local idx = utils.getIndexByValue(self.apprenticeInviteUidList, uid)

				table.remove(self.apprenticeInviteUidList, idx)

				self.apprenticeInviteDic[uid] = nil

				MsgManager.clientNotice(790)
			end
		elseif uid == 0 then
			self.apprenticeInviteUidList = {}
			self.apprenticeInviteDic = {}
		elseif data then
			local idx = utils.getIndexByValue(self.apprenticeInviteUidList, uid)

			table.remove(self.apprenticeInviteUidList, idx)

			self.apprenticeInviteDic[uid] = nil
		end
	end

	local ui = UIManager.tryGetUI("masterApprenticeInviteDlg")

	if ui then
		if checkAdd and targetType == Const.MASTER_APPRENTICE_TYPE.Master then
			ui:setVisible(false)
		else
			ui:onMasterApprenticeInviteOpResp(targetType)
		end
	end

	local ui = UIManager.tryGetUI("chatDlg")

	if ui then
		ui:refreshMasterApprentice()
	end

	if checkAdd then
		local ui = UIManager.tryGetUI("masterApprenticeMainDlg")

		if ui then
			ui:onMasterApprenticeInviteOpResp(targetType)
		end

		self:refreshAddOrDelMasterApprenticeRed()
	else
		self:refreshInviteRed()
	end
end

function MasterApprenticeMixin:onMasterApprenticeEnrollResp(target_type)
	if target_type == Const.MASTER_APPRENTICE_TYPE.Master then
		self.checkEnrollMaster = true
	elseif target_type == Const.MASTER_APPRENTICE_TYPE.Apprentice then
		self.checkEnrollApprentice = true
	end

	local ui = UIManager.tryGetUI("masterApprenticeMainDlg")

	if ui then
		ui:onMasterApprenticeEnrollResp(target_type)
	end
end

function MasterApprenticeMixin:onMasterApprenticeRecommendResp(target_type, recommend_list)
	self.recommendMasterApprenticeList = {}

	for i = 1, #recommend_list do
		local data = self:getNewMasterOrApprentice(recommend_list[i])

		table.insert(self.recommendMasterApprenticeList, data)
	end

	local ui = UIManager.tryGetUI("masterApprenticeMainDlg")

	if ui then
		ui:onMasterApprenticeRecommendResp(target_type)
	end
end

function MasterApprenticeMixin:onMasterApprenticeTaskRefreshNotify(taskType, taskList)
	local t = {}

	if taskList then
		for i = 1, #taskList do
			table.insert(t, taskList[i])
		end
	end

	self.masterApprenticeTaskDic[taskType] = t

	self:refreshTaskRed()
end

function MasterApprenticeMixin:onMasterApprenticeTaskUpdateNotify(taskType, _task)
	local taskList = self.masterApprenticeTaskDic[taskType]

	if not taskList then
		taskList = {}
		self.masterApprenticeTaskDic[taskType] = taskList
	end

	local checkFind = false

	for i, task in ipairs(taskList) do
		if task.task_id == _task.task_id then
			taskList[i] = _task
			checkFind = true

			break
		end
	end

	if not checkFind then
		table.insert(taskList, _task)
	end

	self:refreshTaskRed()
end

function MasterApprenticeMixin:onMasterApprenticeGetTaskAwardResp(taskType, taskIdList)
	local taskList = self.masterApprenticeTaskDic[taskType]

	if not taskList or not taskIdList then
		return
	end

	for _, task in pairs(taskList) do
		local idx = utils.getIndexByValue(taskIdList, task.task_id)

		if idx > 0 then
			task.status = Const.TASK_STATUS.AWARD_GOT
		end
	end

	local ui = UIManager.tryGetUI("masterApprenticeMainDlg")

	if ui then
		ui:onMasterApprenticeGetTaskAwardResp(taskType)
	end

	self:refreshTaskRed()
end

function MasterApprenticeMixin:onMasterExperienceNotify(exp)
	self.totalMasterExp = exp or 0
	self.masterLv, self.masterExp = self:getMasterLevel(exp)

	local ui = UIManager.tryGetUI("masterApprenticeMainDlg")

	if ui then
		ui:onMasterExperienceNotify()
	end

	self:refreshMasterLvAwardRed()
end

function MasterApprenticeMixin:onMasterGetLevelAwardResp(lv)
	self.masterLvAwardGotDic[lv] = true

	local ui = UIManager.tryGetUI("masterAwardDlg")

	if ui then
		ui:onMasterGetLevelAwardResp()
	end

	self:refreshMasterLvAwardRed()
end

function MasterApprenticeMixin:onMasterGetApprenticeAllHeroResp(gid, role_hero, crystal_hero)
	local heroDic = {}

	if role_hero and role_hero.hero then
		for _, svrData in ipairs(role_hero.hero) do
			local hero = Hero(svrData)

			heroDic[hero.gid] = hero
		end
	end

	self.recodeApprenticeAllHeroDataDic = self.recodeApprenticeAllHeroDataDic or {}

	local apprenticeAllHeroData = {
		heroDic = heroDic,
		crystal_hero = crystal_hero,
		time = ClientUtils.getServerTime()
	}

	self.recodeApprenticeAllHeroDataDic[gid] = apprenticeAllHeroData

	self:realGuideApprentice(gid, self.guideStage, apprenticeAllHeroData)

	self.guideStage = nil
end

function MasterApprenticeMixin:onMasterRecieveDevelopGuideNotify(apprentice_uid)
	self:saveApprenticeRequestDevelopGuideRed(apprentice_uid)
end

function MasterApprenticeMixin:onMasterSetDevelopGuideResp(gid, uidList)
	self.apprenticeGuideHeroDic[gid] = uidList

	MsgManager.clientNotice(787)
end

function MasterApprenticeMixin:onApprenticeRequestDevelopGuideResp()
	self.lastRequestMasterGuideTick = ClientUtils.getServerTime()

	local ui = UIManager.getUI("masterApprenticeGuideDlg", true)

	if ui then
		ui:onApprenticeRequestDevelopGuideResp()
	end

	MsgManager.clientNotice(786)
end

function MasterApprenticeMixin:onApprenticeRecieveDevelopGuideNotify(heroGidList)
	self.masterGuideHeroGidList = heroGidList

	self:saveMasterDevelopGuideRed()
end

function MasterApprenticeMixin:onMasterRecieveBattleGuideNotify(apprentice_uid, stage)
	self.apprenticeRequestBattleGuideDic[apprentice_uid] = stage

	self:refreshMasterApprenticeBattleGuideRed()
end

function MasterApprenticeMixin:onMasterSetBattleGuideResp(apprentice_uid)
	self.apprenticeRequestBattleGuideDic[apprentice_uid] = nil

	self:refreshMasterApprenticeBattleGuideRed()
end

function MasterApprenticeMixin:onApprenticeRequestBattleGuideResp()
	MsgManager.clientNotice(793)
end

function MasterApprenticeMixin:onApprenticeRecieveBattleGuideNotify(stage, formation)
	self.masterBattleGuideData = {}
	self.masterBattleGuideData.stage = stage
	self.masterBattleGuideData.formation = formation

	self:saveMasterBattleGuideRed()
end

function MasterApprenticeMixin:refreshAddOrDelMasterApprenticeRed()
	self:refreshInviteRed()
	self:refreshTaskRed()
	self:refreshMasterLvAwardRed()
	self:refreshMasterApprenticeDevelopGuideRed()
	self:refreshMasterApprenticeBattleGuideRed()
	self:refreshApprenticeGraduteRed()
	MsgManager.refreshRed()
end

function MasterApprenticeMixin:refreshInviteRed()
	local check = false

	if self:checkCanAddMasterApprentice(Const.MASTER_APPRENTICE_TYPE.Master) then
		check = #self.masterInviteUidList > 0
	elseif self:checkCanAddMasterApprentice(Const.MASTER_APPRENTICE_TYPE.Apprentice) then
		check = #self.apprenticeInviteUidList > 0
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_MASTER_APPRENTICE_INVITE, check)
end

function MasterApprenticeMixin:refreshTaskRed()
	local check = false
	local taskTypeList

	if self:checkHistoryHaveApprentice() then
		taskTypeList = {
			Const.MASTER_APPRENTICE_TASK_TYPE.MasterDaily,
			Const.MASTER_APPRENTICE_TASK_TYPE.MasterCycle
		}
	elseif self:checkHaveMaster() then
		taskTypeList = {
			Const.MASTER_APPRENTICE_TASK_TYPE.ApprenticeDaily,
			Const.MASTER_APPRENTICE_TASK_TYPE.ApprenticeOnce
		}
	end

	if taskTypeList then
		for _, taskType in pairs(taskTypeList) do
			local taskList = CurAvatar.masterApprenticeTaskDic[taskType] or {}

			for _, task in ipairs(taskList) do
				if task.status == Const.TASK_STATUS.COMPLETE then
					check = true

					break
				end
			end

			if check then
				break
			end
		end
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_MASTER_APPRENTICE_TASK, check)
end

function MasterApprenticeMixin:refreshMasterLvAwardRed()
	local check = false

	if self:checkHistoryHaveApprentice() then
		local lv = CurAvatar.masterLv

		for i = 1, lv do
			if not CurAvatar.masterLvAwardGotDic[i] then
				check = true

				break
			end
		end
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_MASTER_LV_AWARD, check)
end

function MasterApprenticeMixin:initApprenticeGraduateRed()
	local key = CurAvatar.uid .. "apprentice_graduate"

	self.checkIgnoreGraduateRed = UserData.loadCommonDataInt(key) > 0

	self:refreshApprenticeGraduteRed()
end

function MasterApprenticeMixin:clearApprenticeGraduateRed()
	if not self.checkIgnoreGraduateRed then
		self.checkIgnoreGraduateRed = true

		local key = CurAvatar.uid .. "apprentice_graduate"

		UserData.saveCommonDataInt(key, 1)
		self:refreshApprenticeGraduteRed()
	end
end

function MasterApprenticeMixin:refreshApprenticeGraduteRed()
	local check = not self.checkIgnoreGraduateRed and self:checkCanApprenticeGraduate()

	RedDotManager.setKeyState(UIConst.RD_HINT_APPRENTICE_GRADUATE, check)
end

function MasterApprenticeMixin:initMasterApprenticeDevelopGuideRed()
	local key = CurAvatar.uid .. "master_develop_guide"

	self.checkMasterDevelopGuide = UserData.loadCommonDataInt(key) > 0

	local key2 = CurAvatar.uid .. "apprentice_apply_develop_guide"

	self.apprenticeRequestDevelopGuideList = UserData.loadCommonDataList(key2)

	self:refreshMasterApprenticeDevelopGuideRed()
end

function MasterApprenticeMixin:saveMasterDevelopGuideRed()
	if not self.checkMasterDevelopGuide then
		self.checkMasterDevelopGuide = true

		local key = CurAvatar.uid .. "master_develop_guide"

		UserData.saveCommonDataInt(key, 1)
		self:refreshMasterApprenticeDevelopGuideRed()
	end
end

function MasterApprenticeMixin:clearMasterDevelopGuideRed()
	if self.checkMasterDevelopGuide then
		self.checkMasterDevelopGuide = false

		local key = CurAvatar.uid .. "master_develop_guide"

		UserData.clearCommonData(key)
		self:refreshMasterApprenticeDevelopGuideRed()
	end
end

function MasterApprenticeMixin:saveApprenticeRequestDevelopGuideRed(apprenticeUid)
	local idx = utils.getIndexByValue(self.apprenticeRequestDevelopGuideList, apprenticeUid)

	if idx <= 0 then
		table.insert(self.apprenticeRequestDevelopGuideList, apprenticeUid)

		local key = CurAvatar.uid .. "apprentice_apply_develop_guide"

		UserData.saveCommonDataIntList(key, self.apprenticeRequestDevelopGuideList)
		self:refreshMasterApprenticeDevelopGuideRed()
	end
end

function MasterApprenticeMixin:clearApprenticeRequestDevelopGuideRed(apprenticeUid)
	local idx = utils.getIndexByValue(self.apprenticeRequestDevelopGuideList, apprenticeUid)

	if idx > 0 then
		table.remove(self.apprenticeRequestDevelopGuideList, idx)

		local key = CurAvatar.uid .. "apprentice_apply_develop_guide"

		UserData.saveCommonDataIntList(key, self.apprenticeRequestDevelopGuideList)
		self:refreshMasterApprenticeDevelopGuideRed()
	end
end

function MasterApprenticeMixin:refreshMasterApprenticeDevelopGuideRed()
	local check = false

	if self:checkHaveApprentice() then
		for _, uid in pairs(self.apprenticeRequestDevelopGuideList) do
			if self:isMyApprentice(uid) then
				check = true

				break
			end
		end
	elseif self:checkHaveMaster() then
		check = self.checkMasterDevelopGuide
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_APPRENTICE_DEVELOP_GUIDE, check)
end

function MasterApprenticeMixin:initMasterApprenticeBattleGuideRed()
	local key = CurAvatar.uid .. "master_battle_guide"

	self.checkMasterBattleGuide = UserData.loadCommonDataInt(key) > 0

	self:refreshMasterApprenticeBattleGuideRed()
end

function MasterApprenticeMixin:saveMasterBattleGuideRed()
	if not self.checkMasterBattleGuide then
		local key = CurAvatar.uid .. "master_battle_guide"

		self.checkMasterBattleGuide = true

		UserData.saveCommonDataInt(key, 1)
		self:refreshMasterApprenticeBattleGuideRed()
	end
end

function MasterApprenticeMixin:clearMasterBattleGuideRed()
	if self.checkMasterBattleGuide then
		self.checkMasterBattleGuide = false

		local key = CurAvatar.uid .. "master_battle_guide"

		UserData.clearCommonData(key)
		self:refreshMasterApprenticeBattleGuideRed()
	end
end

function MasterApprenticeMixin:refreshMasterApprenticeBattleGuideRed()
	local check = false

	if self:checkHaveApprentice() then
		for uid, stage in pairs(self.apprenticeRequestBattleGuideDic) do
			if self:isMyApprentice(uid) then
				local otherPlayer = self.apprenticeDic[uid]
				local curStage = otherPlayer.stageInfo[1] * 10000 + otherPlayer.stageInfo[2] * 100 + otherPlayer.stageInfo[3]

				if curStage < stage then
					check = true

					break
				end
			end
		end
	elseif self:checkHaveMaster() and self.checkMasterBattleGuide then
		local levelInfo = CurAvatar:getNextMainStageInfo()
		local stage = levelInfo.season * 10000 + levelInfo.chapter * 100 + levelInfo.level

		check = CurAvatar.masterBattleGuideData.stage == stage
	end

	RedDotManager.setKeyState(UIConst.RD_HINT_APPRENTICE_BATTLE_GUIDE, check)
end

return MasterApprenticeMixin
