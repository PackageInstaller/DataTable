-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/challenge/view/specialviews/XiongMaoView.lua

module("logic.extensions.challenge.view.specialviews.XiongMaoView", package.seeall)

local XiongMaoView = class("XiongMaoView", SpecialViewBase)

function XiongMaoView:getBigBgList()
	return {
		{
			goPath = "Name",
			imageUrl = "ui/views/challenge/xiongmao/xmtz-gongfuxiongma.png"
		},
		{
			goPath = "BtnDetail",
			imageUrl = "ui/views/challenge/xiongmao/xmtz_hulu.png"
		},
		{
			goPath = "PhaseRoot/P0/BranchBtn_1_0/JinHuaBtn",
			imageUrl = "ui/views/challenge/xiongmao/xmtz-bt-jinhuaanniu.png"
		},
		{
			goPath = "PhaseRoot/P0/BranchBtn_0_0/img2",
			imageUrl = "ui/views/challenge/xiongmao/xmtz-taijizhuang.png"
		},
		{
			goPath = "PhaseRoot/P0/BranchBtn_1_0/img2",
			imageUrl = "ui/views/challenge/xiongmao/xmtz-meihuazhuang.png"
		},
		{
			goPath = "PhaseRoot/P0/BranchBtn_2_0/img2",
			imageUrl = "ui/views/challenge/xiongmao/xmtz-baguazhuang.png"
		}
	}
end

XiongMaoView._preBranch = nil
XiongMaoView._prePhase = nil

function XiongMaoView:_initData()
	XiongMaoView.super._initData(self)

	local evCfg = ChallengeConfig.instance:getChallengeKV(ChallengeModel.instance:getCurId(), 9)

	self._preId = evCfg.value.evolve[1].raceIdBefore
	self._nowId = evCfg.value.evolve[1].raceIdAfter
end

function XiongMaoView:onEnter(go, cfg, params)
	XiongMaoView.super.onEnter(self, go, cfg, params)
	UIEffectManager.instance:stopEffect(self._eff)

	self._eff = nil

	if ChallengeModel.instance:canGetPrize() and not ChallengeModel.instance:isPrizeGot() then
		local parent = self._jinhuaBtn.gameObject
		local eff = UIEffectManager.instance:playEffect(self.viewComponent, "fx_ui_fuli/fx_ui_fuli_lingqu.prefab", parent, 0, 0, true)

		eff:setParent(parent.transform)
		eff:setScale(1)
		eff:setLocalPos()

		self._eff = eff
	end
end

function XiongMaoView:onEvolveFinish()
	UIEffectManager.instance:stopEffect(self._eff)

	self._eff = nil
end

function XiongMaoView:onExit()
	XiongMaoView.super.onExit(self)
	MaterialMgr.resetAll(goutil.findChild(self._go, "PhaseRoot/P0/BranchBtn_0_0/Icon"))
	MaterialMgr.resetAll(goutil.findChild(self._go, "PhaseRoot/P0/BranchBtn_1_0/Icon"))
	MaterialMgr.resetAll(goutil.findChild(self._go, "PhaseRoot/P0/BranchBtn_2_0/Icon"))
	UIEffectManager.instance:stopEffect(self._eff)

	self._eff = nil
end

function XiongMaoView:buildDiffView()
	XiongMaoView.super.buildDiffView(self)

	self._jinhuaBtn = Framework.ButtonAdapter.GetFrom(self._go, "PhaseRoot/P0/BranchBtn_1_0/JinHuaBtn")

	MaterialMgr.setCellByCfg("100:10158:1:1", goutil.findChild(self._go, "PhaseRoot/P0/BranchBtn_0_0/Icon"))
	MaterialMgr.setCellByCfg("100:10159:1:1", goutil.findChild(self._go, "PhaseRoot/P0/BranchBtn_1_0/Icon"))
	MaterialMgr.setCellByCfg("4:31:0", goutil.findChild(self._go, "PhaseRoot/P0/BranchBtn_2_0/Icon"))
end

function XiongMaoView:_onClickMission(phase, branch)
	local state = ChallengeModel.instance:getBranchState(phase, branch)

	if state == GameEnum.ChallengeBranchState.UNLOCKED then
		XiongMaoView._prePhase = phase
		XiongMaoView._preBranch = branch

		if phase == 1 or phase == 2 then
			UIStateManager.instance:push(ViewName.XiongMaoJumpView)
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

function XiongMaoView:teamFightEnd(params)
	local phase = ChallengeModel.instance:getCurPhase()
	local branch = ChallengeModel.instance:getCurBranch()

	UIJumper.instance:pushOneStack(ViewName.challengemgrview, true)

	if ChallengeViewBase._prePhase == 1 or ChallengeViewBase._prePhase == 2 then
		UIJumper.instance:pushOneStack(ViewName.XiongMaoJumpView, true)
	end
end

function XiongMaoView:registScoreView(isCatched)
	local phase = XiongMaoView._prePhase
	local branch = XiongMaoView._preBranch

	if XiongMaoView._prePhase ~= 1 and XiongMaoView._prePhase ~= 2 then
		BattleFacade.instance:registerResultHandler(function()
			local suc = isCatched

			if not suc then
				local title = ""
				local content = "本关需要成功捕捉熊猫小宝才可以通关喔"
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
	local msg = langPara("增加<color=#ff5068>%s次</color>”跳一跳“次数！", evCfg.value.playTimesAdd)
	local btnTxts = {}
	local funcs = {}

	funcs[1] = function(clgScoreView)
		clgScoreView:_onClickClose()
	end
	btnTxts[1] = lang("确定")

	BattleFacade.instance:registerResultHandler(function()
		local suc = BattleFacade.instance:getLastBattleResult() == GameEnum.BattleResult.Success

		if suc then
			ViewMgr.instance:open(ViewName.Clgscore, true, msg, funcs, btnTxts)
		end

		return suc
	end, nil)
end

return XiongMaoView
