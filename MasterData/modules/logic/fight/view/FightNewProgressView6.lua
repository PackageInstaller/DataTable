-- chunkname: @modules/logic/fight/view/FightNewProgressView6.lua

module("modules.logic.fight.view.FightNewProgressView6", package.seeall)

local FightNewProgressView6 = class("FightNewProgressView6", FightBaseView)

function FightNewProgressView6:onInitView()
	self.imgBgProgress = gohelper.findChildImage(self.viewGO, "container/imgPre")
	self.imgProgress = gohelper.findChildImage(self.viewGO, "container/imgHp")
	self.signRoot = gohelper.findChild(self.viewGO, "container/imgHp/imgSignHpContainer")
	self.signItem = gohelper.findChild(self.viewGO, "container/imgHp/imgSignHpContainer/1")
	self.animator = gohelper.findChildComponent(self.viewGO, "container", typeof(UnityEngine.Animator))
end

function FightNewProgressView6:addEvents()
	self:com_registMsg(FightMsgId.NewProgressValueChange, self.onNewProgressValueChange)
end

function FightNewProgressView6:onConstructor(data)
	self.data = data
	self.id = self.data.id
end

function FightNewProgressView6:onOpen()
	local config = OdysseyConfig.instance:getConstConfig(20)

	if config then
		local arr = string.splitToNumber(config.value, "#")

		table.sort(arr, FightNewProgressView6.sortSignList)

		self.signDataList = arr

		self:com_createObjList(self.onSignItemShow, arr, self.signRoot, self.signItem)
	end

	local rate = self.data.value / self.data.max

	self.imgProgress.fillAmount = rate
	self.imgBgProgress.fillAmount = rate
end

function FightNewProgressView6.sortSignList(item1, item2)
	return item1 < item2
end

function FightNewProgressView6:onNewProgressValueChange(id)
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
	bgFlow:registWork(FightWorkFunction, self.refreshSignList, self)
	FightMsgMgr.replyMsg(FightMsgId.NewProgressValueChange, flow)
	self.animator:Play("open", 0, 0)
end

function FightNewProgressView6:refreshSignList()
	if self.signDataList then
		self:com_createObjList(self.onSignItemShow, self.signDataList, self.signRoot, self.signItem)
	end
end

function FightNewProgressView6:onSignItemShow(obj, data, index)
	local finishedRoot = gohelper.findChild(obj, "finished")
	local unfinishRoot = gohelper.findChild(obj, "unfinish")
	local isFinish = data >= self.data.value

	gohelper.setActive(finishedRoot, not isFinish)
	gohelper.setActive(unfinishRoot, isFinish)
end

return FightNewProgressView6
