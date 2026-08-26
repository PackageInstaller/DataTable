-- chunkname: @modules/logic/survival/view/shelter/SummaryAct/SurvivalSummaryActView.lua

module("modules.logic.survival.view.shelter.SummaryAct.SurvivalSummaryActView", package.seeall)

local SurvivalSummaryActView = class("SurvivalSummaryActView", BaseView)

function SurvivalSummaryActView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")
	self._goplayerbubble = gohelper.findChild(self.viewGO, "Bubble/#go_player_Bubble")
	self._txtBubble = gohelper.findChildText(self.viewGO, "Bubble/#go_player_Bubble/root/#txt_Bubble")
	self.SurvivalSummaryNpcHUD = gohelper.findChild(self.viewGO, "Bubble/npc/#go_SurvivalSummaryNpcHUD")

	gohelper.setActive(self.SurvivalSummaryNpcHUD, false)

	self.reputationList = gohelper.findChild(self.viewGO, "reputationList")
	self.reputationItem = gohelper.findChild(self.reputationList, "Viewport/Content/reputationItem")

	gohelper.setActive(self.reputationItem, false)
	self:createReputationListComp()
end

function SurvivalSummaryActView:addEvents()
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onViewClose, self)
end

function SurvivalSummaryActView:removeEvents()
	self._btnClose:RemoveClickListener()
end

function SurvivalSummaryActView:_btnCloseOnClick()
	return
end

function SurvivalSummaryActView:_onViewClose(viewName)
	if viewName == ViewName.SurvivalGetRewardView then
		self:startClose()
	end
end

function SurvivalSummaryActView:startClose()
	TaskDispatcher.runDelay(function()
		if self.survivalSummaryActNpcWork then
			self.survivalSummaryActNpcWork:playCloseAnim()
		end

		TaskDispatcher.runDelay(self.closeThis, self, 0.2)
	end, self, 1)
end

function SurvivalSummaryActView:onOpen()
	self.isClickClose = nil

	local scene = SurvivalMapHelper.instance:getScene()

	self.npcDataList = scene.actProgress.npcDataList

	local name = ""

	for i, data in ipairs(self.npcDataList) do
		name = string.format("%s,%s", name, data.config.name)
	end

	self._txtBubble.text = GameUtil.getSubPlaceholderLuaLang(luaLang("SurvivalSummaryActView_1"), {
		#self.npcDataList,
		name
	})
	self.popupFlow = SurvivalDecreeVoteFlowSequence.New()

	self.popupFlow:registerDoneListener(self.onDone, self)
	self:buildPlayerWork()
	self:buildNpcWork()
	self.popupFlow:addWork(TimerWork.New(1))

	local npcDropTips = SurvivalMapModel.instance.resultData.npcDropTips

	if npcDropTips then
		self.popupFlow:addWork(FunctionWork.New(self.showRewardView, self))
	else
		self.popupFlow:addWork(FunctionWork.New(function()
			self:startClose()
		end, self))
	end

	self.popupFlow:start()
	SurvivalController.instance:dispatchEvent(SurvivalEvent.GuideSurvivalSummaryActStart)
end

function SurvivalSummaryActView:onClose()
	TaskDispatcher.cancelTask(self.closeThis, self)
end

function SurvivalSummaryActView:onDestroyView()
	if self.popupFlow then
		self.popupFlow:destroy()

		self.popupFlow = nil
	end

	SurvivalController.instance:exitMap()
end

function SurvivalSummaryActView:showRewardView()
	local npcDropTips = SurvivalMapModel.instance.resultData.npcDropTips

	if npcDropTips then
		local items = {}

		for k, v in ipairs(npcDropTips) do
			local itemMo = SurvivalBagItemMo.New()

			itemMo:init({
				id = v.itemId,
				count = v.count
			})
			table.insert(items, itemMo)
		end

		ViewMgr.instance:openView(ViewName.SurvivalGetRewardView, {
			items = items
		})
	end
end

function SurvivalSummaryActView:buildPlayerWork()
	local param = {
		goBubble = self._goplayerbubble
	}

	self.popupFlow:addWork(SurvivalSummaryActBuildPlayerWork.New(param))
end

function SurvivalSummaryActView:buildNpcWork()
	local param = {
		SurvivalSummaryNpcHUD = self.SurvivalSummaryNpcHUD
	}

	self.survivalSummaryActNpcWork = SurvivalSummaryActNpcWork.New(param)

	self.popupFlow:addWork(self.survivalSummaryActNpcWork)
end

function SurvivalSummaryActView:buildDelay(time)
	local param = {
		time = time
	}

	self.popupFlow:addWork(SurvivalDecreeVoteShowWork.New(param))
end

function SurvivalSummaryActView:onDone()
	SurvivalController.instance:dispatchEvent(SurvivalEvent.GuideSurvivalSummaryActAnimFinish)
end

function SurvivalSummaryActView:createReputationListComp()
	local scrollParam = SimpleListParam.New()

	scrollParam.cellClass = SurvivalSummaryActReputationItem
	scrollParam.lineCount = 1

	local res = self.reputationItem

	self.listComp = GameFacade.createSimpleListComp(self.reputationList.gameObject, scrollParam, res, self.viewContainer)
end

return SurvivalSummaryActView
