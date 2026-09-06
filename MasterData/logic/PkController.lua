-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pk/controller/PkController.lua

module("logic.extensions.pk.controller.PkController", package.seeall)

local PkController = class("PkController", BaseController)

function PkController:ctor()
	return
end

function PkController:onInit()
	QieCuoAgent.instance:addHandler(QieCuoAgent.PM_NotifyFightRefusedRes, self._fightRefused, self)
	QieCuoAgent.instance:addHandler(QieCuoAgent.PM_NotifyFightStartRes, self._fightStart, self)
	QieCuoAgent.instance:addHandler(QieCuoAgent.PM_NotifyChangeToAttackRes, self._changeToAttack, self)
	QieCuoAgent.instance:addHandler(QieCuoAgent.PM_NotifyGameResultRes, self._gameResult, self)
	QieCuoAgent.instance:addHandler(QieCuoAgent.PM_NotifyReceiveFightAskRes, self._receiveFightAsk, self)
	QieCuoAgent.instance:addHandler(QieCuoAgent.PM_NotifyCancelFightRes, self._cancelFight, self)
	GlobalDispatcher:addListener(GlobalNotify.BattleEnd, self._OnBattleEnd, self)

	self._initeList = {}
end

function PkController:onReset()
	self._cd = nil
	self._initeTime = nil

	removetimer(self._initeCD, self)
	removetimer(self._initeTimer, self)

	self._initeList = {}
	self._pkBattle = nil
	self._reason = nil
end

function PkController:sendInvitation(userInfo)
	if not FuncOpenModel.instance:getFuncIsOpen(230) then
		FloatWordMgr.instance:show(FuncOpenModel:getFuncLockDescription(230))

		return
	end

	local switch, stranger = PkModel.instance:getPkSwitch()

	if switch == nil then
		QieCuoAgent.instance:sendPM_FightSwitchInfoReq(function(msg)
			PkModel.instance:setPkSwitch(msg.all, msg.stranger)
			self:sendInvitation(userInfo)
		end)

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

	local friendMo = FriendModel.instance:getFriendMo(userInfo.userId)

	if friendMo and not friendMo:getIsOnline() then
		FloatWordMgr.instance:show("切磋-对手不在线")

		return
	end

	for i, v in ipairs(self._initeList) do
		if userInfo.userId == v.userId then
			FloatWordMgr.instance:show("已有对方的切磋邀请")

			return
		end
	end

	if self._cd == nil then
		self._cd = 15

		settimer(1, self._initeCD, self, true)

		local myHeadInfo = {
			userName = RoleModel.instance:getUserName(),
			headIconId = RoleModel.instance:getHeadIconId(),
			headFrameId = RoleModel.instance:getHeadFrameId(),
			vipLv = RoleModel.instance:getVipLvl()
		}

		PkModel.instance:setHeadInfo(myHeadInfo, userInfo)
		QieCuoAgent.instance:sendPM_AskFightReq(userInfo.userId, function()
			UIStateManager.instance:push(ViewName.PkInviteView, userInfo.userName)
		end)
	else
		FloatWordMgr.instance:show(string.format("切磋处于CD中,请%d秒后再试", self._cd))
	end
end

function PkController:_initeCD()
	self._cd = self._cd - 1

	if self._cd < 0 then
		self._cd = nil

		removetimer(self._initeCD, self)
	end
end

function PkController:_fightRefused(msg)
	if msg.reason == 1 then
		self._reason = "对方拒绝了你的切磋邀请"
	elseif msg.reason == 2 then
		self._reason = "对方正在护送中"
	elseif msg.reason == 3 then
		self._reason = "对方还未开启切磋功能"
	end

	GlobalDispatcher:dispatch(GlobalNotify.FightRefused)
end

function PkController:setRefusedReason(reason)
	self._reason = reason
end

function PkController:getRefusedReason()
	return self._reason
end

function PkController:_fightStart()
	GlobalDispatcher:dispatch(GlobalNotify.FightStart)
end

function PkController:_changeToAttack(msg)
	PkModel.instance:setDefenseForm(msg.opFormationView.curForm, msg.opFormationView.petSimpleView)
	GlobalDispatcher:dispatch(GlobalNotify.ChangeToAttack)
end

function PkController:_gameResult(msg)
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

		PkModel.instance:setPkResult(msg.state, msg.attackResult, msg.defenseResult, msg.myPetLeftCount, msg.opPetLeftCount, myForm, opForm, msg.recordId)
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

		PkModel.instance:setPkResult(msg.state, nil, nil, 0, 0, myForm, opForm)
	end

	if msg.state == 1 then
		self._pkBattle = true

		local str = msg.attackResult:SerializeToString()
		local msgClone = BattleExtension_pb.PM_BattleResult()

		msgClone:ParseFromString(str)
		BattleFacade.instance:startFightingByBtlResult(msgClone)
		BattleFacade.instance:startPk()
	else
		UIStateManager.instance:push(ViewName.PkBattlereSultView)
	end
end

function PkController:_cancelFight(msg)
	for i, v in ipairs(self._initeList) do
		if v.userId == userId then
			table.remove(self._initeList, i)
		end
	end

	self:_initeRed()
	GlobalDispatcher:dispatch(GlobalNotify.CancelFight, msg.userId)
end

function PkController:_OnBattleEnd()
	if self._pkBattle then
		self._pkBattle = false

		UIJumper.instance:pushOneStack(ViewName.PkBattlereSultView)
	end
end

function PkController:_receiveFightAsk(msg)
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_PK, true)
	table.insert(self._initeList, {
		userId = msg.request.opHeadInfo.userId,
		startTime = tonumber(msg.request.startTime) / 1000
	})
	self:_initeRed()
	GlobalDispatcher:dispatch(GlobalNotify.ReceiveFightAsk)
end

function PkController:_initeRed()
	local _initeMaxTime = tonumber(PkConfig.instance:getCommonByKey("MATCH_TIME"))
	local _maxTime = 0

	if self._initeList then
		for i = #self._initeList, 1, -1 do
			if self._initeList[i].startTime > ServerTime.now() + _initeMaxTime then
				table.remove(self._initeList, i)
			elseif _initeMaxTime > ServerTime.now() - self._initeList[i].startTime then
				_maxTime = math.max(ServerTime.now() + _initeMaxTime - self._initeList[i].startTime, _maxTime)
			end
		end
	end

	if _maxTime > 0 then
		removetimer(self._initeTimer, self)

		self._initeTime = _maxTime

		RedPointController.instance:setRedPointInfo(RedPointModel.ID_PK, not GameUtil.getUserDayData(PkModel.IniteNotify) and FuncOpenModel.instance:getFuncIsOpen(230))
		settimer(1, self._initeTimer, self, true)
	else
		self:clearInvite()
	end
end

function PkController:clearInvite()
	self._initeList = {}

	RedPointController.instance:setRedPointInfo(RedPointModel.ID_PK, false)
	removetimer(self._initeTimer, self)
end

function PkController:_initeTimer()
	self._initeTime = self._initeTime - 1

	if self._initeTime <= 0 then
		self._initeTime = nil
		self._initeList = {}

		self:_initeRed()
	end
end

function PkController:startDefenseTimer()
	self._defenseTime = tonumber(PkConfig.instance:getCommonByKey("DEFENSE_READY_TIME"))

	settimer(1, self._defenseTimer, self, true)
end

function PkController:stopDefenseTimer()
	self._defenseTime = -1

	removetimer(self._defenseTimer, self)
end

function PkController:getDefenseTime()
	return self._defenseTime
end

function PkController:_defenseTimer()
	self._defenseTime = self._defenseTime - 1

	if self._defenseTime < 0 then
		removetimer(self._defenseTime, self)
	end
end

PkController.instance = PkController.New()

return PkController
