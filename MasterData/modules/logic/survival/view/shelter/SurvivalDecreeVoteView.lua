-- chunkname: @modules/logic/survival/view/shelter/SurvivalDecreeVoteView.lua

module("modules.logic.survival.view.shelter.SurvivalDecreeVoteView", package.seeall)

local SurvivalDecreeVoteView = class("SurvivalDecreeVoteView", BaseView)

function SurvivalDecreeVoteView:onInitView()
	self.goItem = gohelper.findChild(self.viewGO, "Left/#go_survivaldecreeitem")
	self.goBubbleRoot = gohelper.findChild(self.viewGO, "Bubble")
	self.goBubble = gohelper.findChild(self.goBubbleRoot, "goBubble")
	self.txtBubble = gohelper.findChildTextMesh(self.goBubbleRoot, "goBubble/#txt_Bubble")
	self.goAgreeItem = gohelper.findChild(self.goBubbleRoot, "goAgree")
	self.goDisAgreeItem = gohelper.findChild(self.goBubbleRoot, "goDisagree")

	gohelper.setActive(self.goBubble, false)
	gohelper.setActive(self.goAgreeItem, false)
	gohelper.setActive(self.goDisAgreeItem, false)

	self.goVoteFinish = gohelper.findChild(self.viewGO, "#go_VoteFinished")
	self.txtVotePercent = gohelper.findChildTextMesh(self.viewGO, "#go_VoteFinished/Rate/#txt_Percent")
	self.txtVotePercentGlow = gohelper.findChildTextMesh(self.viewGO, "#go_VoteFinished/Rate/#txt_Percent_glow")
	self.goVoteState = gohelper.findChild(self.viewGO, "#go_VoteState")
	self.goTipsItem = gohelper.findChild(self.viewGO, "#go_VoteState/#scroll_Tips/Viewport/Content/#go_Item")

	gohelper.setActive(self.goTipsItem, false)

	self.btnClose = gohelper.findChildClick(self.viewGO, "btnClose")
	self.goTxtClose = gohelper.findChild(self.viewGO, "btnClose/txt_Close")
end

function SurvivalDecreeVoteView:addEvents()
	self.addClickCb(self, self.btnClose, self.onClickClose, self)
end

function SurvivalDecreeVoteView:removeEvents()
	self:removeClickCb(self.btnClose)
end

function SurvivalDecreeVoteView:onClickClose()
	if not self.popupFlow or self.popupFlow:isFlowDone() then
		self:closeThis()

		return
	end

	self.popupFlow:tryJumpNextWork()
end

function SurvivalDecreeVoteView:onOpen()
	self.decreeInfo = self.viewParam.decreeInfo
	self.weekInfo = SurvivalShelterModel.instance:getWeekInfo()

	self:startVote()
end

function SurvivalDecreeVoteView:startVote()
	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnDecreeVoteStart)
	self:initWork()
	self:buildPlayerWork()
	self:buildNpcWork()
	self:buildCameraWork()
	self:buildDelay(0.5)
	self:buildDecreeItemWork()
	self:buildBubbleWork()
	self:buildToastWork()
	self:buildVotePercentWork()
	self.popupFlow:start()
end

function SurvivalDecreeVoteView:initWork()
	TaskDispatcher.cancelTask(self.playNextToast, self)
	gohelper.setActive(self.goTxtClose, false)
	gohelper.setActive(self.goBubbleRoot, false)
	gohelper.setActive(self.goBubble, false)
	gohelper.setActive(self.goVoteFinish, false)
	gohelper.setActive(self.goVoteState, false)
	self:clearFlow()
	self:clearBubble()
	self:buildData()

	self.popupFlow = SurvivalDecreeVoteFlowSequence.New()

	self.popupFlow:registerDoneListener(self.onVoteDone, self)
end

function SurvivalDecreeVoteView:clearFlow()
	if self.popupFlow then
		self.popupFlow:destroy()

		self.popupFlow = nil
	end
end

function SurvivalDecreeVoteView:buildData()
	self.toastDataList = {}

	local shelterMapId = self.weekInfo.shelterMapId

	self.mapCo = lua_survival_shelter.configDict[shelterMapId]
	self.unitComp = SurvivalMapHelper.instance:getScene().unit

	local tagDict = {}
	local decreeList = self.decreeInfo:getCurPolicyGroup():getPolicyList()
	local lastDecree = decreeList[#decreeList]
	local config = SurvivalConfig.instance:getDecreeCo(lastDecree.id)

	for i, v in ipairs(decreeList) do
		local curConfig = SurvivalConfig.instance:getDecreeCo(v.id)
		local tags = string.splitToNumber(curConfig and curConfig.tags, "#")

		if tags then
			for _, tag in ipairs(tags) do
				tagDict[tag] = 1
			end
		end
	end

	local needVoteNum = lastDecree.needVoteNum
	local currVoteNum = math.min(lastDecree.currVoteNum, lastDecree.needVoteNum)

	self.votePercent = needVoteNum == 0 and 1 or currVoteNum / needVoteNum
	self.npcDataList = {
		{},
		{}
	}

	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local dict = weekInfo.npcDict

	for k, v in pairs(dict) do
		local data = {}

		data.id = v.id
		data.resource = v.co.resource
		data.config = v.co
		data.isAgree = self:checkTagIsAgree(tagDict, v.co.tag)

		if data.isAgree then
			table.insert(self.npcDataList[1], data)
		else
			table.insert(self.npcDataList[2], data)
		end
	end
end

function SurvivalDecreeVoteView:checkTagIsAgree(tagDict, tag)
	local npcTags = string.splitToNumber(tag, "#")

	if npcTags then
		for i, v in ipairs(npcTags) do
			if tagDict[v] then
				return true
			end
		end
	end

	return false
end

function SurvivalDecreeVoteView:buildDelay(time)
	local param = {
		time = time
	}

	self.popupFlow:addWork(SurvivalDecreeVoteShowWork.New(param))
end

function SurvivalDecreeVoteView:buildDecreeItemWork()
	if not self.decreeItem then
		local go = self.viewContainer:getResInst(self.viewContainer:getSetting().otherRes.itemRes, self.goItem, "item")

		self.decreeItemGO = go
		self.decreeItem = MonoHelper.addNoUpdateLuaComOnceToGo(go, SurvivalDecreeVoteItem)
	end

	self.decreeItem:onUpdateMO(self.decreeInfo)
	gohelper.setActive(self.decreeItemGO, false)

	local param = {
		time = 0.333,
		go = self.decreeItemGO,
		audioId = AudioEnum2_8.Survival.play_ui_fuleyuan_binansuo_decide
	}

	self.popupFlow:addWork(SurvivalDecreeVoteShowWork.New(param))
end

function SurvivalDecreeVoteView:buildCameraWork()
	local playerMo = SurvivalShelterModel.instance:getPlayerMo()
	local playerPos = playerMo.pos
	local param = {
		playerPos = playerPos
	}

	self.popupFlow:addWork(SurvivalDecreeVoteBuildCameraWork.New(param))
	self:buildDelay(0.5)
end

function SurvivalDecreeVoteView:buildNpcWork()
	local param = {
		npcDataList = self.npcDataList,
		votePercent = self.votePercent,
		goAgreeItem = self.goAgreeItem,
		goDisAgreeItem = self.goDisAgreeItem,
		mapCo = self.mapCo,
		unitComp = self.unitComp,
		bubbleList = self.bubbleList,
		toastList = self.toastDataList
	}

	self.popupFlow:addWork(SurvivalDecreeVoteBuildNpcWork.New(param))
end

function SurvivalDecreeVoteView:buildPlayerWork()
	local param = {
		mapCo = self.mapCo,
		goBubble = self.goBubble
	}

	self.popupFlow:addWork(SurvivalDecreeVoteBuildPlayerWork.New(param))
end

function SurvivalDecreeVoteView:buildBubbleWork()
	local param1 = {
		time = 1.2,
		callback = self.showPlayerBubble,
		callbackObj = self
	}

	self.popupFlow:addWork(SurvivalDecreeVoteShowWork.New(param1))

	local param2 = {
		bubbleList = self.bubbleList,
		startCallback = self.showNpcBubble,
		startCallbackObj = self
	}

	self.popupFlow:addWork(SurvivalDecreeVoteNpcBubbleWork.New(param2))
end

function SurvivalDecreeVoteView:showPlayerBubble()
	gohelper.setAsLastSibling(self.goBubble)
	gohelper.setActive(self.goBubbleRoot, true)
	gohelper.setActive(self.goBubble, true)
end

function SurvivalDecreeVoteView:showNpcBubble()
	gohelper.setActive(self.goBubbleRoot, true)
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_binansuo_discuss)
end

function SurvivalDecreeVoteView:buildToastWork()
	local param = {
		goVoteState = self.goVoteState,
		toastDataList = self.toastDataList,
		goTipsItem = self.goTipsItem
	}

	self.popupFlow:addWork(SurvivalDecreeVotePlayToastWork.New(param))
end

function SurvivalDecreeVoteView:buildVotePercentWork()
	local param = {
		goVoteFinish = self.goVoteFinish,
		txtVotePercent = self.txtVotePercent,
		txtVotePercentGlow = self.txtVotePercentGlow,
		votePercent = self.votePercent
	}
	local work = SurvivalDecreeVotePlayPercentWork.New(param)

	self.popupFlow:addWork(work)
end

function SurvivalDecreeVoteView:onPercentDone()
	if self.decreeItem then
		self.decreeItem:refreshHas(false)
	end
end

function SurvivalDecreeVoteView:onVoteDone()
	self:onPercentDone()
	gohelper.setActive(self.goTxtClose, true)
end

function SurvivalDecreeVoteView:clearBubble()
	if self.bubbleList then
		for i, v in ipairs(self.bubbleList) do
			v:dispose()
		end
	end

	self.bubbleList = {}
end

function SurvivalDecreeVoteView:onClose()
	self:clearFlow()
	self:clearBubble()
	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnDecreeVoteEnd)
	ViewMgr.instance:openView(ViewName.SurvivalDecreeView)
end

function SurvivalDecreeVoteView:onDestroyView()
	SurvivalController.instance:dispatchEvent(SurvivalEvent.ChangeCameraScale)
end

return SurvivalDecreeVoteView
