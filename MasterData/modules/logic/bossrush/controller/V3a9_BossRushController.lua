-- chunkname: @modules/logic/bossrush/controller/V3a9_BossRushController.lua

module("modules.logic.bossrush.controller.V3a9_BossRushController", package.seeall)

local V3a9_BossRushController = class("V3a9_BossRushController", BaseController)

function V3a9_BossRushController:onInit()
	self:reInit()
end

function V3a9_BossRushController:reInit()
	return
end

function V3a9_BossRushController:addConstEvents()
	CharacterDestinyController.instance:registerCallback(CharacterDestinyEvent.OnUseStoneReply, self._onRefreshDestiny, self)
end

function V3a9_BossRushController:openV3a9MainView(viewParam, isJustOpen)
	if isJustOpen then
		ViewMgr.instance:openView(ViewName.V3a9_BossRush_MainSwitchModeView, viewParam)

		return
	end

	if not V3a9_BossRushModel.instance:isActOnLine() then
		GameFacade.showToast(ToastEnum.ActivityNotInOpenTime)

		return
	end

	if viewParam then
		local stage = viewParam.stage
		local actId = viewParam.actId

		if stage then
			local stageMo = V3a9_BossRushModel.instance:getStageMo(actId, stage)

			if not stageMo or not stageMo:isOpen() then
				GameFacade.showToast(ToastEnum.V1a4_BossRushBossLockTip)

				return
			end
		end
	end

	local enterMode = viewParam and viewParam.enterMode

	if not enterMode then
		local actId = V3a9_BossRushModel.instance:getActModeActId()

		if actId and ActivityHelper.isOpen(actId) then
			local key = string.format("%s_%s", V3a9BossRushEnum.PlayerPrefKey.FirstOpenAct, actId)
			local value = GameUtil.playerPrefsGetNumberByUserId(key, 0)

			if value == 0 then
				enterMode = V3a9BossRushEnum.Mode.Act

				GameUtil.playerPrefsSetNumberByUserId(key, 1)
			end
		end
	end

	BossRushRpc.instance:sendGet128InfosRequest(function()
		enterMode = enterMode or V3a9_BossRushModel.instance:getMode()

		ViewMgr.instance:openTabView(ViewName.V3a9_BossRush_MainSwitchModeView, viewParam, nil, nil, enterMode)
	end)
end

function V3a9_BossRushController:openV3a9LevelDetailView(actId, viewParam, isOpenMain)
	local stage = viewParam.stage

	if actId ~= V3a9_BossRushModel.instance:getActModeActId() then
		V3a9_BossRushModel.instance:setEnterActStage(actId, stage)
		BossRushController.instance:openV3a2LevelDetailView(viewParam, isOpenMain)

		return
	end

	local stageMo = V3a9_BossRushModel.instance:getStageMo(actId, stage)

	if not stageMo or not stageMo:isOpen() then
		GameFacade.showToast(ToastEnum.V1a4_BossRushBossLockTip)

		return
	end

	if isOpenMain then
		self:openV3a9MainView(nil, true)
	end

	V3a9_BossRushModel.instance:setEnterActStage(actId, stage)
	ViewMgr.instance:openView(ViewName.V3a9_BossRush_LevelDetailView, stageMo)
end

function V3a9_BossRushController:openHeroGroupEditView(actId, stage, id, heroUId)
	local heroGroupMO = V3a9_BossRushModel.instance:getCurGroupMO()
	local param = {}

	param.singleGroupMOId = id
	param.originalHeroUid = heroUId
	param.equips = id < 5 and heroGroupMO:getPosEquips(id - 1).equipUid
	param.stage = stage
	param.actId = actId

	ViewMgr.instance:openView(ViewName.V3a9_BossRush_HeroGroupEditView, param)
end

function V3a9_BossRushController:saveCurGroupData(heroGroupMO, callback, callbackObj)
	local groupIndex = V3a9_BossRushModel.instance:getSelectGroupIndex()

	heroGroupMO = heroGroupMO or V3a9_BossRushModel.instance:getCurGroupMO()

	local heroList = heroGroupMO:getMainList()
	local req = HeroGroupModule_pb.SetHeroGroupSnapshotRequest()
	local assistMo = V3a9_BossRushModel.instance:getEditorAssistMo()

	if assistMo then
		for i, uid in ipairs(heroList) do
			if uid ~= "0" and uid == assistMo.heroUid and i < 5 then
				req.fightGroup.assistUserId = assistMo.userId
				req.fightGroup.assistHeroUid = assistMo.heroUid

				break
			end
		end
	end

	local equips = heroGroupMO:getAllHeroEquips()

	FightParam.initFightGroup(req.fightGroup, heroGroupMO.clothId, heroList, heroGroupMO:getSubList(), equips, heroGroupMO:getAllHeroActivity104Equips(), heroGroupMO:getAssistBossId())
	HeroGroupRpc.instance:sendSetHeroGroupSnapshotRequest(ModuleEnum.HeroGroupSnapshotType.BossRushActMode, groupIndex, req, callback, callbackObj)
end

function V3a9_BossRushController:_onRefreshDestiny(heroId)
	local actId = BossRushConfig.instance:getActivityId(V3a9BossRushEnum.Mode.Act)

	if not actId or not ActivityHelper.isOpen(actId) then
		return
	end

	local groupMos = V3a9_BossRushExpandBondModel.instance:getExpandBondGroupsList()

	for _, mo in ipairs(groupMos) do
		mo:refreshHero(heroId)
	end

	V3a9_BossRushExpandBondModel.instance:refreshHeroExpandBondGroupsList(heroId)
end

function V3a9_BossRushController:openV3a9BonusView(actId)
	MileStoneRpc.instance:sendGetMilestoneInfoRequest({
		V3a9BossRushEnum.MileStoneId
	}, function()
		ViewMgr.instance:openView(ViewName.V3a9_BossRush_BonusView, {
			actId = actId
		})
	end, self)
end

function V3a9_BossRushController:openV3a9AssistView()
	ViewMgr.instance:openView(ViewName.V3a9_BossRush_AssistView)
end

function V3a9_BossRushController:onResetTeam(actId, stage, callback, callbackObj)
	local function _yesCallback()
		Activity128Rpc.instance:sendResetAct128TeamRequest(actId, stage, callback, callbackObj)
	end

	GameFacade.showOptionMessageBox(MessageBoxIdDefine.V3a9BossRushActModeResetStage, MsgBoxEnum.BoxType.Yes_No, MsgBoxEnum.optionType.Daily, _yesCallback, nil, nil, self)
end

function V3a9_BossRushController:closeExpandBondsTipView()
	if ViewMgr.instance:isOpen(ViewName.V3a9_BossRush_ExpandBondsTipView) then
		ViewMgr.instance:closeView(ViewName.V3a9_BossRush_ExpandBondsTipView)

		return true
	end
end

V3a9_BossRushController.instance = V3a9_BossRushController.New()

return V3a9_BossRushController
