-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/challenge/view/specialviews/QianNiaoWanView.lua

module("logic.extensions.challenge.view.specialviews.QianNiaoWanView", package.seeall)

local QianNiaoWanView = class("QianNiaoWanView", SpecialViewBase)

function QianNiaoWanView:getBigBgList()
	return {}
end

QianNiaoWanView._preBranch = nil
QianNiaoWanView._prePhase = nil

function QianNiaoWanView:onEnter(go, cfg, params)
	QianNiaoWanView.super.onEnter(self, go, cfg, params)

	if ChallengeModel.instance:canGetPrize() then
		local parent = self._jinhuaBtn.gameObject
		local eff = UIEffectManager.instance:playEffect(self.viewComponent, "fx_ui_fuli/fx_ui_fuli_lingqu.prefab", parent, 0, 0, true)

		eff:setParent(parent.transform)
		eff:setScale(1)
		eff:setLocalPos()

		self._eff = eff
	end
end

function QianNiaoWanView:onEvolveFinish()
	UIEffectManager.instance:stopEffect(self._eff)

	self._eff = nil
end

function QianNiaoWanView:onExit()
	QianNiaoWanView.super.onExit(self)
	MaterialMgr.resetAll(goutil.findChild(self._go, "PhaseRoot/P0/BranchBtn_0_0/Desc/ImgEgg"))
	MaterialMgr.resetAll(goutil.findChild(self._go, "PhaseRoot/P0/BranchBtn_2_0/Desc/ImgEgg"))
	UIEffectManager.instance:stopEffect(self._eff)

	self._eff = nil
end

function QianNiaoWanView:buildDiffView()
	QianNiaoWanView.super.buildDiffView(self)
	MaterialMgr.setCellByCfg("100:10154:1:1", goutil.findChild(self._go, "PhaseRoot/P0/BranchBtn_0_0/Desc/ImgEgg"))
	MaterialMgr.setCellByCfg("4:31:0", goutil.findChild(self._go, "PhaseRoot/P0/BranchBtn_2_0/Desc/ImgEgg"))
end

function QianNiaoWanView:_initData()
	QianNiaoWanView.super._initData(self)

	local evCfg = ChallengeConfig.instance:getChallengeKV(ChallengeModel.instance:getCurId(), 9)

	self._preId = evCfg.value.evolve[1].raceIdBefore
	self._nowId = evCfg.value.evolve[1].raceIdAfter
end

function QianNiaoWanView:_onClickMission(phase, branch)
	local state = ChallengeModel.instance:getBranchState(phase, branch)

	if state == GameEnum.ChallengeBranchState.UNLOCKED then
		QianNiaoWanView._prePhase = phase
		QianNiaoWanView._preBranch = branch

		if phase == 1 or phase == 2 then
			UIStateManager.instance:push(ViewName.qianniaozhenshenview)
		else
			UIStateManager.instance:push(ViewName.missionview, phase, branch)
		end
	elseif state == GameEnum.ChallengeBranchState.LOCKED then
		FloatWordMgr.instance:show("请先通过前面的关卡")
	elseif state == GameEnum.ChallengeBranchState.PASSED then
		FloatWordMgr.instance:show(lang("tip_passed"))
	end

	ChallengeModel.instance:setCurBranch(branch)
end

function QianNiaoWanView:teamFightEnd(params)
	local phase = ChallengeModel.instance:getCurPhase()
	local branch = ChallengeModel.instance:getCurBranch()

	UIJumper.instance:pushOneStack(ViewName.challengemgrview, true)

	if ChallengeViewBase._prePhase == 1 or ChallengeViewBase._prePhase == 2 then
		UIJumper.instance:pushOneStack(ViewName.qianniaozhenshenview, true)
	end
end

function QianNiaoWanView:registScoreView(isCatched)
	local phase = QianNiaoWanView._prePhase
	local branch = QianNiaoWanView._preBranch

	if QianNiaoWanView._prePhase ~= 1 and QianNiaoWanView._prePhase ~= 2 then
		BattleFacade.instance:registerResultHandler(function()
			local suc = isCatched

			if not suc then
				local title = ""
				local content = "本关需要成功捕捉飞鸟才可以通关喔"
				local btnTxt = "知道了"

				TipsFacade.instance:openTipWindowValidX(title, content, function()
					BattleFacade.instance:endBattle()
				end, btnTxt)
			else
				ViewMgr.instance:open(ViewName.BattleSettlementSuccess)
			end

			return true
		end, nil)

		return
	end

	local evCfg = ChallengeConfig.instance:getChallengeKV(ChallengeModel.instance:getCurId(), (phase - 1) * 3 + branch + 1)
	local msg = langPara("增加<color=#ff5068>%s次</color>”找真身“次数！", evCfg.value.playTimesAdd)
	local btnTxts = {}
	local funcs = {}

	funcs[1] = function(clgScoreView)
		clgScoreView:_onClickClose()
	end
	btnTxts[1] = lang("确定")

	BattleFacade.instance:registerResultHandler(function()
		local suc = BattleFacade.instance:getLastBattleResult() == GameEnum.BattleResult.Success

		if suc then
			UIStateManager.instance:open("clgscore", true, msg, funcs, btnTxts)
		end

		return suc
	end, nil)
end

return QianNiaoWanView
