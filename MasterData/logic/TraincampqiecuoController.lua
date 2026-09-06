-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/traincampqiecuo/controller/TraincampqiecuoController.lua

module("logic.extensions.traincampqiecuo.controller.TraincampqiecuoController", package.seeall)

local TraincampqiecuoController = class("TraincampqiecuoController", BaseController)
local json = require("cjson")

function TraincampqiecuoController:ctor()
	return
end

function TraincampqiecuoController:onInit()
	GlobalDispatcher:addListener(TrainCampQieCuoAgent.TC_FightSwitchInfoRes, self._onSwitchInfoRes, self)
	GlobalDispatcher:addListener(GlobalNotify.BattleEnd, self._OnBattleEnd, self)
	GlobalDispatcher:addListener(GlobalNotify.LanternTriggerInfo, self._onLanternTriggerInfo, self)
	self:onReset()
end

function TraincampqiecuoController:onReset()
	self._cd = nil
	self._initeTime = nil

	removetimer(self._initeCD, self)
	removetimer(self._initeTimer, self)

	self._initeList = {}
	self.msgMap = {}
	self.msgCdMap = {}
	self._pkBattle = false
	self._gameResultRes = false
end

function TraincampqiecuoController:_onSwitchInfoRes()
	if self._needPkRefresh and self._userInfo then
		self:sendInvitation(self._userInfo)

		self._needPkRefresh = nil
		self._userInfo = nil
	end
end

function TraincampqiecuoController:notifyJoinTeamRes(msg)
	local roomData = TraincampqiecuoModel.instance:getPkRoomData()

	if roomData and ViewMgr.instance:isOpen(ViewName.PkroomView) and (roomData.teamCode ~= msg.teamCode or roomData.teamId ~= msg.teamId) then
		UIStateManager.instance:popByName(ViewName.PkroomView)
	end

	TraincampqiecuoModel.instance:setPkRoomData(msg)

	if not self._gameResultRes then
		UIStateManager.instance:push(ViewName.PkroomView, true)
	end
end

function TraincampqiecuoController:notifyStartRes(msg)
	local opheadinfo = msg.opHeadInfo
	local myheadInfo = RoleModel.instance:getHeadInfo()

	TraincampqiecuoModel.instance:setHeadInfo(myheadInfo, opheadinfo)
	TraincampqiecuoController.instance:startSetDefense()
	UIStateManager.instance:popByName(ViewName.PkroomView)
	UIStateManager.instance:push(ViewName.PkFormationselectView)
end

function TraincampqiecuoController:sendInvitation(userInfo)
	self._needPkRefresh = false

	if not FuncOpenModel.instance:getFuncIsOpen(230) then
		FloatWordMgr.instance:show(FuncOpenModel:getFuncLockDescription(230))

		return
	end

	local switch, stranger = TraincampqiecuoModel.instance:getPkSwitch()

	if switch == nil then
		self._needPkRefresh = true
		self._userInfo = userInfo

		TrainCampQieCuoAgent.instance:sendPM_TC_FightSwitchInfoReq()

		return
	end

	if SceneMgr.instance.isGogingToEnterBattleScene then
		FloatWordMgr.instance:show("该状态不可进行此操作!")

		return
	end

	if not switch then
		TipsFacade.instance:openPopupWindow(lang("tip"), "你关闭了切磋挑战的申请,是否前往设置？", function()
			UIStateManager.instance:push(ViewName.SystemSetting, 4)
		end, nil, "前往")

		return
	end

	if EscortModel.instance:IsPickupEscort() then
		FloatWordMgr.instance:show("护送期间不可发起切磋邀请")

		return
	end

	local roomNameId = TraincampqiecuoConfig.instance:getRandomNameId()

	self:sendPM_TC_CreateTeamReq(roomNameId, true, false, userInfo.userId)
end

function TraincampqiecuoController:notifyBeInviteRes(msg)
	self:_addBeInvate(msg)
	GlobalDispatcher:dispatch(GlobalNotify.QiecuoBeInvite)
end

function TraincampqiecuoController:_removeBeInvateTimeout()
	local coolTime = TraincampqiecuoConfig.instance:getCommonValue("BEINVATE_STAND_TIME", true) * 1000
	local list = TraincampqiecuoModel.instance:getBeInvateList()
	local nowMs = ServerTime.nowMs()

	for k, v in pairs(list) do
		if nowMs >= checknumber(v.startTime) + coolTime then
			TraincampqiecuoModel.instance:removeBeInvate(v.opHeadInfo.userId)
		end
	end
end

function TraincampqiecuoController:getActiveBeInvateList()
	local finalList = {}
	local list = TraincampqiecuoModel.instance:getBeInvateList()

	if table.nums(list) <= 0 then
		return finalList
	end

	local coolTime = TraincampqiecuoConfig.instance:getCommonValue("BEINVATE_STAND_TIME", true)
	local now = ServerTime.now()

	for k, v in pairs(list) do
		if now < math.floor(checknumber(v.startTime) / 1000) + coolTime then
			table.insert(finalList, v)
		end
	end

	table.sort(finalList, function(a, b)
		return checknumber(a.startTime) > checknumber(b.startTime)
	end)

	return finalList
end

function TraincampqiecuoController:sendPM_TC_SetSwitchReq(all, stranger)
	self._tempAll = all
	self._tempStranger = stranger

	TrainCampQieCuoAgent.instance:sendPM_TC_SetSwitchReq(all, stranger)
end

function TraincampqiecuoController:SetSwitchRes()
	TraincampqiecuoModel.instance:setPkSwitch(self._tempAll, self._tempStranger)
end

function TraincampqiecuoController:getDefenseReadyTime()
	return TraincampqiecuoConfig.instance:getCommonValue("DEFENSE_READY_TIME", true)
end

function TraincampqiecuoController:getAttackReadyTime()
	return TraincampqiecuoConfig.instance:getCommonValue("ATTACK_READY_TIME", true)
end

function TraincampqiecuoController:startSetDefense()
	self._targetDefenseTime = ServerTime.now() + self:getDefenseReadyTime()
end

function TraincampqiecuoController:getSetDefenseTargetTime()
	return self._targetDefenseTime
end

function TraincampqiecuoController:notifyChangeToAttackRes(msg)
	TraincampqiecuoModel.instance:setDefenseForm(msg.opFormationView.curForm, msg.opFormationView.petSimpleView)
	GlobalDispatcher:dispatch(GlobalNotify.ChangeToAttack)
end

function TraincampqiecuoController:_addBeInvate(msg)
	local cd = TraincampqiecuoConfig.instance:getCommonValue("BEINVATE_STAND_TIME", true)

	if msg and msg.opHeadInfo then
		self:_tryUnregPopupMsg(msg.opHeadInfo.userId)

		self.msgMap[msg.opHeadInfo.userId] = MainUIPopupMsgController.instance:regPopMsg({
			invateFromTrainQiecuo = true,
			bTimeOutReject = true,
			showInitCD = cd,
			acceptFunc = self._tryAcceptInvite,
			rejectFunc = self._tryRejectInvite,
			thisArg = self,
			desc = langPara("切磋邀请：%s", TraincampqiecuoConfig.instance:getRoomName(msg.teamNameId)),
			headInfo = msg.opHeadInfo,
			teamId = msg.teamId,
			teamCode = msg.teamCode
		})
		self.msgCdMap[msg.opHeadInfo.userId] = ServerTime.now()
	end
end

function TraincampqiecuoController:_tryUnregPopupMsg(userId)
	local key = self.msgMap[userId]

	MainUIPopupMsgController.instance:removePopMsg(key)

	self.msgMap[userId] = nil
	self.msgCdMap[userId] = nil
end

function TraincampqiecuoController:_tryAcceptInvite(data)
	local params = data.info

	TrainCampQieCuoAgent.instance:sendPM_TC_JoinTeamReq(params.teamId, params.teamCode)
end

function TraincampqiecuoController:_tryRejectInvite(data)
	local params = data.info

	TrainCampQieCuoAgent.instance:sendPM_TC_RefuseInviteReq(params.teamId, params.headInfo.userId)
end

function TraincampqiecuoController:notifyGameResultRes(msg)
	self._gameResultRes = false

	TraincampqiecuoModel.instance:clearReadyPlayerIds()
	TraincampqiecuoModel.instance:clearBack2ReformUserIds()

	local myForm, opForm = {}, {}

	if msg.state == 1 then
		local form_my = RankRaceResultModel.instance:getRemainPetHpsFromResult(msg.attackResult)
		local form_op = RankRaceResultModel.instance:getRemainPetHpsFromResult(msg.defenseResult)

		for i = 1, 9 do
			myForm[i] = form_my[GameEnum.BattleTeam.Left][i] or {
				raceId = 0
			}
			opForm[i] = form_op[GameEnum.BattleTeam.Left][i] or {
				raceId = 0
			}
		end

		TraincampqiecuoModel.instance:setPkResult(msg.state, msg.attackResult, msg.defenseResult, msg.myPetLeftCount, msg.opPetLeftCount, myForm, opForm, msg.recordId)
	else
		myForm = {}

		for i = 1, 9 do
			myForm[i] = {
				raceId = 0,
				isDead = msg.state == 2
			}
		end

		opForm = {}

		for i = 1, 9 do
			opForm[i] = {
				raceId = 0,
				isDead = msg.state == 3
			}
		end

		TraincampqiecuoModel.instance:setPkResult(msg.state, nil, nil, 0, 0, myForm, opForm)
	end

	if msg.state == 1 then
		self._pkBattle = true
		self._gameResultRes = true

		local str = msg.attackResult:SerializeToString()
		local msgClone = BattleExtension_pb.PM_BattleResult()

		msgClone:ParseFromString(str)
		BattleFacade.instance:startPk()
		BattleFacade.instance:startFightingByBtlResult(msgClone)
	else
		UIStateManager.instance:push(ViewName.PkmainView)
		UIStateManager.instance:push(ViewName.PkBattlereSultView)
	end
end

function TraincampqiecuoController:sendPM_TC_PveReq(singlePetZdl, myForm, opForm, teamNameId)
	self._pkBattle = true
	self._startPve = true
	self._pveSinglePetZdl = singlePetZdl

	TrainCampQieCuoAgent.instance:sendPM_TC_PveReq(singlePetZdl, myForm, opForm, teamNameId)
end

function TraincampqiecuoController:_OnBattleEnd()
	self._gameResultRes = false

	if self._pkBattle then
		self._pkBattle = false

		UIJumper.instance:pushOneStack(ViewName.PkmainView)

		if not self._startPve then
			if not self.formShareBattleResult then
				UIJumper.instance:pushOneStack(ViewName.PkroomView)
			end

			UIJumper.instance:pushOneStack(ViewName.PkBattlereSultView)
		else
			self._startPve = false

			UIJumper.instance:pushOneStack(ViewName.TrainCampQieCuoPVEMissionView, false, self._pveSinglePetZdl)
		end
	end

	self.formShareBattleResult = false
end

function TraincampqiecuoController:getShareBattleResultRes(msg)
	local myForm, opForm = {}, {}

	for i, v in ipairs(msg.info.myPetInfo) do
		myForm[v.posId + 1] = {
			raceId = v.faceId,
			isDead = v.isDie
		}
	end

	for index, value in ipairs(msg.info.opPetInfo) do
		opForm[value.posId + 1] = {
			raceId = value.faceId,
			isDead = value.isDie
		}
	end

	for i = 1, 9 do
		if myForm[i] == nil then
			myForm[i] = {
				raceId = 0
			}
		end

		if opForm[i] == nil then
			opForm[i] = {
				raceId = 0
			}
		end
	end

	self.formShareBattleResult = true

	local myHeadInfo = TraincampqiecuoModel.instance:getTempLeftHeadInfo()

	TraincampqiecuoModel.instance:setHeadInfo(myHeadInfo, msg.info.opHeadInfo)
	TraincampqiecuoModel.instance:setTempLeftHeadInfo(nil)
	TraincampqiecuoController.instance:sendPM_TC_GetBattleVideoReq(msg.info.myAttackBattleId, msg.info.opAttackBattleId, myForm, opForm, msg.info.myAlivePetSize, msg.info.opAlivePetSize)
end

function TraincampqiecuoController:sendPM_TC_GetBattleVideoReq(myAttackBattleId, opAttackBattleId, myForm, opForm, myAlivePetSize, opAlivePetSize)
	self._videoMyAlivePetSize = myAlivePetSize
	self._videoOpAlivePetSize = opAlivePetSize
	self._videoMyForm = myForm
	self._videoOpForm = opForm

	TrainCampQieCuoAgent.instance:sendPM_TC_GetBattleVideoReq(myAttackBattleId, opAttackBattleId)
end

function TraincampqiecuoController:getBattleVideoRes(msg)
	if self.formShareBattleResult then
		TraincampqiecuoModel.instance:setPkResult(1, msg.myAttackBattleResult, msg.opAttackBattleResult, self._videoMyAlivePetSize, self._videoOpAlivePetSize, self._videoMyForm, self._videoOpForm)
		UIStateManager.instance:push(ViewName.PkBattlereSultView, true)
	end
end

function TraincampqiecuoController:enterPVE(perPetPower)
	TraincampqiecuoModel.instance:setPVEOpTeamType(GameEnum.TrainQiecuoTeamOpType.My)
	UIStateManager.instance:push(ViewName.TrainCampQieCuoPVEMissionView, perPetPower)
end

function TraincampqiecuoController:sendPM_TC_CreateTeamReq(teamNameId, onlyInvite, fullPublicStrengthens, invitedPlayerId)
	TraincampqiecuoModel.instance:setInvatingId(invitedPlayerId)
	TrainCampQieCuoAgent.instance:sendPM_TC_CreateTeamReq(teamNameId, onlyInvite, fullPublicStrengthens, invitedPlayerId)
end

function TraincampqiecuoController:_onLanternTriggerInfo(msg)
	if msg and #msg > 0 then
		for _, v in ipairs(msg) do
			if v.channelType ~= GameEnum.ChatChannel.Private then
				return
			end

			if not string.find(v.content, "tpId") or not string.find(v.content, "teamId") or not string.find(v.content, "teamCode") then
				return
			end

			local t = GameUtil.jsonToTable(v.content)

			if type(t) ~= "table" then
				return
			end

			local tpId = checknumber(t.tpId)

			if checknumber(v.senderId) <= 0 or v.senderId == RoleModel.instance:getUserId() or tpId ~= 63 then
				return
			end

			local mo = FriendModel.instance:getFriendMo(v.senderId)

			if not mo then
				return
			end

			local obj = {
				opHeadInfo = mo.headInfo,
				teamNameId = checknumber(t.params.teamNameId),
				teamId = t.params.teamId,
				teamCode = t.params.teamCode
			}

			self:_addBeInvate(obj)

			break
		end
	end
end

function TraincampqiecuoController:notifyTeamChange(msg)
	self:_onOtherPlayerLeaveTeam(msg.playerIds)
	TraincampqiecuoModel.instance:teamChangeData(msg)

	if #msg.playerIds == 1 and msg.playerIds[1] == RoleModel.instance:getUserId() then
		-- block empty
	end
end

function TraincampqiecuoController:_onOtherPlayerLeaveTeam(playerIds)
	if #playerIds ~= 1 then
		return
	end

	local list = TraincampqiecuoModel.instance:getBack2Reform()

	if not list then
		return
	end

	TraincampqiecuoModel.instance:clearBack2ReformUserIds()

	local myUserId = RoleModel.instance:getUserId()

	for i, id in ipairs(list) do
		if id ~= myUserId then
			FloatWordMgr.instance:show("玩家已退出房间")

			break
		end
	end
end

function TraincampqiecuoController:tryJoinRoom(teamId, teamCode)
	local data = TraincampqiecuoModel.instance:getPkRoomData()

	if data and data.teamCode == teamCode and data.teamId == teamId and ViewMgr.instance:isOpen(ViewName.PkroomView) then
		FloatWordMgr.instance:show("已在房间内")

		return
	end

	local isMyRoom = TraincampqiecuoModel.instance:isMyRoom()

	if not isMyRoom then
		TrainCampQieCuoAgent.instance:sendPM_TC_JoinTeamReq(teamId, teamCode)

		return
	end

	local ids = TraincampqiecuoModel.instance:getPkRoomPlayerIds()
	local ispass = false

	if #ids <= 1 then
		ispass = true
	else
		local isReady = TraincampqiecuoModel.instance:isReady(ids[2])

		if isReady then
			FloatWordMgr.instance:show("玩家已准备 不可进行此操作")
		else
			ispass = true
		end
	end

	if ispass then
		TrainCampQieCuoAgent.instance:sendPM_TC_JoinTeamReq(teamId, teamCode)
	end
end

function TraincampqiecuoController:onTrySetSummonPetBySendMsg(fmtMo, summonMasterId, summonedPetId)
	self:_onTrySetSummonPet(summonMasterId, summonedPetId)
	self:_trySetSummonPetByMasterId(fmtMo, summonMasterId, summonedPetId)
end

function TraincampqiecuoController:_onTrySetSummonPet(summonMasterId, summonedPetId)
	local summonerPetMo = TraincampqiecuoModel.instance:getPetMo(summonMasterId)
	local summonPetMo = TraincampqiecuoModel.instance:getPetMo(summonedPetId)

	if summonerPetMo then
		local lastSummonPetMo = TraincampqiecuoModel.instance:getPetMo(summonerPetMo.summonedPetId)

		if lastSummonPetMo then
			lastSummonPetMo.summonMasterId = -1
		end

		summonerPetMo.summonedPetId = summonedPetId
	end

	if summonPetMo then
		summonPetMo.summonMasterId = summonMasterId
	end
end

function TraincampqiecuoController:_trySetSummonPetByMasterId(fmtMo, _curSummonerId, summonedPetId)
	MissionModel.instance:setForceResetOneKey(true)
	fmtMo:trySetSummonPetByMasterId(_curSummonerId, summonedPetId, MissionModel.instance:getMaxPetNum())

	if not fmtMo:checkAllBorrowPet(_curSummonerId, summonedPetId) then
		-- block empty
	else
		self:_showBorrowPetFailedTips()
	end

	GlobalDispatcher:dispatch(GlobalNotify.FormationPosChanged)
	GlobalDispatcher:dispatch(GlobalNotify.FormationChangeFinish)
end

function TraincampqiecuoController:_showSetSummonPetTips()
	TipsFacade.instance:openCommonTips(lang("切换召唤师成功，尝试上阵对应的契约精灵"))
end

function TraincampqiecuoController:_showBorrowPetFailedTips()
	FloatWordMgr.instance:show(lang("只能同时上阵一只助战精灵哦！"))
end

TraincampqiecuoController.instance = TraincampqiecuoController.New()

return TraincampqiecuoController
