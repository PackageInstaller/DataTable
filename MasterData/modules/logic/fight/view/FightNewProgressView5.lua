-- chunkname: @modules/logic/fight/view/FightNewProgressView5.lua

module("modules.logic.fight.view.FightNewProgressView5", package.seeall)

local FightNewProgressView5 = class("FightNewProgressView5", FightBaseView)

function FightNewProgressView5:onInitView()
	self.imgBgProgress = gohelper.findChildImage(self.viewGO, "container/imgPre")
	self.imgProgress = gohelper.findChildImage(self.viewGO, "container/imgHp")
	self.animator = gohelper.findChildComponent(self.viewGO, "container", typeof(UnityEngine.Animator))
end

function FightNewProgressView5:addEvents()
	self:com_registMsg(FightMsgId.NewProgressValueChange, self.onNewProgressValueChange)
	self:com_registFightEvent(FightEvent.StageChanged, self.onStageChanged)

	self.tweenComp = self:addComponent(FightTweenComponent)
end

function FightNewProgressView5:onConstructor(data)
	self.data = data
	self.id = self.data.id
end

function FightNewProgressView5:onStageChanged(stage)
	self.tweenComp:KillTweenByObj(self.imgProgress)

	self.imgProgress.fillAmount = self.data.value / self.data.max

	if stage == FightStageMgr.StageType.Operate then
		self.imgProgress.fillAmount = (self.data.value - self.preDecrease) / self.data.max
	elseif stage == FightStageMgr.StageType.Play then
		-- block empty
	end
end

function FightNewProgressView5:onOpen()
	local config = OdysseyConfig.instance:getConstConfig(22)

	self.preDecrease = tonumber(config.value) or 0

	local rate = self.data.value / self.data.max

	self.imgProgress.fillAmount = rate
	self.imgBgProgress.fillAmount = rate
end

function FightNewProgressView5:onNewProgressValueChange(id)
	if id ~= self.id then
		return
	end

	local rate = self.data.value / self.data.max
	local flow = self:com_registFlowParallel()
	local duration = 0.2

	flow:registWork(FightTweenWork, {
		type = "DOFillAmount",
		img = self.imgProgress,
		to = rate,
		t = duration
	})

	local bgFlow = flow:registWork(FightWorkFlowSequence)

	bgFlow:registWork(FightWorkDelayTimer, 0.2)
	bgFlow:registWork(FightTweenWork, {
		type = "DOFillAmount",
		img = self.imgBgProgress,
		to = rate,
		t = duration
	})
	FightMsgMgr.replyMsg(FightMsgId.NewProgressValueChange, flow)
	self.animator:Play("open", 0, 0)
end

return FightNewProgressView5
