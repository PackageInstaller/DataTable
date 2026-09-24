-- chunkname: @modules/logic/matchgame/outside/character/MatchGameTalentView.lua

module("modules.logic.matchgame.outside.character.MatchGameTalentView", package.seeall)

local MatchGameTalentView = class("MatchGameTalentView", BaseView)
local PercentColor = "#897519"
local BracketColor = "#897519"
local DelayPlayUnlockEffect = 1.5
local UnlockEffectDuration = 0.46

function MatchGameTalentView:onInitView()
	self._scrollBranch = gohelper.findChildScrollRect(self.viewGO, "#scroll_Branch")
	self._goBranchItem = gohelper.findChild(self.viewGO, "#scroll_Branch/Viewport/Content/#go_BranchItem")
	self._scrollNode = gohelper.findChildScrollRect(self.viewGO, "#scroll_Node")
	self._goNodeItem = gohelper.findChild(self.viewGO, "#scroll_Node/Viewport/Content/#go_NodeItem")
	self._goNodeDetail = gohelper.findChild(self.viewGO, "#go_descArea")
	self._txtNodeName = gohelper.findChildText(self.viewGO, "#go_descArea/#txt_NodeName")
	self._txtNodeDesc = gohelper.findChildText(self.viewGO, "#go_descArea/#txt_NodeDesc")
	self._goNodeCost = gohelper.findChild(self.viewGO, "#go_descArea/#btn_Active/#go_NodeCost")
	self._btnActive = gohelper.findChildButtonWithAudio(self.viewGO, "#go_descArea/#btn_Active")
	self._btnReset = gohelper.findChildButtonWithAudio(self.viewGO, "#go_descArea/#btn_Reset")
	self._goLineItem = gohelper.findChild(self.viewGO, "#scroll_Node/Viewport/Content/#go_PathItem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MatchGameTalentView:addEvents()
	self._btnActive:AddClickListener(self._btnActiveOnClick, self)
	self._btnReset:AddClickListener(self._btnResetOnClick, self)
	self.addEventCb(self, MatchGameController.instance, MatchGameEvent.OnUpdateTalentInfo, self._onUpdateTalentInfo, self)
end

function MatchGameTalentView:removeEvents()
	self._btnActive:RemoveClickListener()
	self._btnReset:RemoveClickListener()
end

function MatchGameTalentView:_btnActiveOnClick()
	if not self._selectNodeId then
		return
	end

	local preNodeId = self._selectNodeCo.prevNodeId
	local hasPreNode = preNodeId and preNodeId ~= 0

	if hasPreNode then
		::label_4_0::

		local preNodeStatus = MatchGameModel.instance:getTalentNodeStatus(preNodeId)

		if hasPreNode and preNodeStatus ~= MatchGameEnum.TalentNodeStatus.Active then
			GameFacade.showToast(ToastEnum.MatchGamePreTalentNode)

			return
		end

		if not self._isItemEnough then
			GameFacade.showToast(ToastEnum.MatchGameItemNotEnough)

			return
		end

		self._lockUpdate = true
		self._rpcCallback = MatchGameRpc.instance:sendAct244ActiveTalentRequest(self._actId, self._selectNodeId, self._buildActiveTalentFlow, self)
	end
end

function MatchGameTalentView:_buildActiveTalentFlow(_, resultCode)
	self._lockUpdate = false

	if resultCode ~= 0 then
		return
	end

	GameUtil.setActiveUIBlock(self.viewName, true, false)

	self._flow = FlowSequence.New()

	self._flow:addWork(FunctionWork.New(self._playActiveTalentEffect, self))
	self._flow:addWork(WorkWaitSeconds.New(DelayPlayUnlockEffect))
	self._flow:addWork(FunctionWork.New(self._playUnlockTalentEffect, self))
	self._flow:addWork(WorkWaitSeconds.New(UnlockEffectDuration))
	self._flow:addWork(FunctionWork.New(self._onPlayActiveFlowDone, self))
	self._flow:start()
end

function MatchGameTalentView:_playActiveTalentEffect()
	local activeItem = self._nodeScroll:getItemByIndex(self._selectNodeIndex)

	if activeItem then
		activeItem:playActiveEffect()
		gohelper.setActive(self._btnActive.gameObject, false)
	end
end

function MatchGameTalentView:_playUnlockTalentEffect()
	local activeNodeIndex = self._selectNodeIndex
	local unlockNodeIndex = activeNodeIndex + 1
	local unlockItem = self._nodeScroll:getItemByIndex(unlockNodeIndex)

	if unlockItem then
		unlockItem:playUnlockEffect()
	end

	local unlockLine = self._lineItemList[activeNodeIndex]

	if unlockLine then
		unlockLine:playUnlockEffect()
	end
end

function MatchGameTalentView:_onPlayActiveFlowDone()
	GameUtil.setActiveUIBlock(self.viewName, false, true)
	self:refreshBranchTree()

	if self._selectNodeIndex + 1 <= #self._nodeScroll.datas then
		self._nodeScroll:setSelect(self._selectNodeIndex + 1)
	end
end

function MatchGameTalentView:_btnResetOnClick()
	if not self._selectNodeId or not self._canReset then
		GameFacade.showToast(ToastEnum.MatchGameResetTalent)

		return
	end

	if self._showTalentMo then
		local branchId = self._showTalentMo.branchId

		if not branchId then
			return
		end

		self._nodeScroll:setSelect(1)
		MatchGameRpc.instance:sendAct244ResetTalentRequest(self._actId, branchId)
	end
end

function MatchGameTalentView:_editableInitView()
	SkillHelper.addHyperLinkClick(self._txtNodeDesc)

	self._animator = gohelper.onceAddComponent(self.viewGO, gohelper.Type_Animator)
	self._lineItemList = self:getUserDataTb_()

	gohelper.setActive(self._goLineItem, false)
	self:initBranchData()

	self._selectBranchIndex, self._selectNodeIndex = self:findSelectBranchAndNodeIndex()
	self._actId = MatchGameModel.instance:getCurActId()
	self._costComp = MatchGameCostComp.Get(self._goNodeCost)
end

function MatchGameTalentView:onOpen()
	self._isFirstEnter = true

	self._animator:Play("open", 0, 0)
	self:refreshUI()
	MatchGameController.instance:dispatchEvent(MatchGameEvent.OnGuideOpenCharacterView, MatchGameEnum.CharacterTabType.Talent)
end

function MatchGameTalentView:refreshUI()
	self:refreshBranchList()
end

function MatchGameTalentView:initBranchData()
	self._allBranchList = {}
	self._branchType2NodeList = {}

	local branchList = lua_activity244_talent_branch.configList

	for _, branchCo in ipairs(branchList) do
		local branchId = branchCo.id
		local nodeList = MatchGameConfig.instance:getTalentNodeListByBranchType(branchId)
		local branchMo = {
			config = branchCo,
			branchId = branchId,
			nodeList = nodeList
		}

		table.insert(self._allBranchList, branchMo)

		self._branchType2NodeList[branchId] = nodeList
	end
end

function MatchGameTalentView:findSelectBranchAndNodeIndex()
	local selectBranchIndex = 1
	local selectNodeIndex = 1

	for i, branchMo in ipairs(self._allBranchList) do
		if branchMo.nodeList then
			for j, nodeCo in ipairs(branchMo.nodeList) do
				local status = MatchGameModel.instance:getTalentNodeStatus(nodeCo.nodeId)

				if status ~= MatchGameEnum.TalentNodeStatus.Active then
					return i, j
				end

				selectBranchIndex = i
				selectNodeIndex = j
			end
		end
	end

	return selectBranchIndex, selectNodeIndex
end

function MatchGameTalentView:findSelectNodeIndex(branchId)
	local nodeList = self._branchType2NodeList[branchId]
	local selectNodeIndex = 1

	if nodeList then
		for j, nodeCo in ipairs(nodeList) do
			local status = MatchGameModel.instance:getTalentNodeStatus(nodeCo.nodeId)

			if status == MatchGameEnum.TalentNodeStatus.Lock then
				break
			end

			selectNodeIndex = j
		end
	end

	return selectNodeIndex
end

function MatchGameTalentView:refreshBranchList()
	if not self._branchScroll then
		local listParam = SimpleListParam.New()

		listParam.cellClass = MatchGameTalentBranchListItem
		listParam.lineCount = 1
		listParam.cellWidth = 180
		listParam.cellHeight = 90
		listParam.cellSpaceH = 0
		listParam.cellSpaceV = 0
		listParam.scrollDir = ScrollEnum.ScrollDirV
		listParam.isClickAutoSelect = true

		local scrollParam = {
			listParam = listParam,
			viewContainer = self.viewContainer
		}

		self._branchScroll = MonoHelper.addNoUpdateLuaComOnceToGo(self._scrollBranch.gameObject, SimpleListComp, scrollParam)

		self._branchScroll:setRes(self._goBranchItem)
		self._branchScroll:onCreate()
		self._branchScroll:setOnSelectChange(self._onSelectBranchChange, self)
	end

	self._branchScroll:setData(self._allBranchList)
	self._branchScroll:setSelect(self._selectBranchIndex or 1)
end

function MatchGameTalentView:_onSelectBranchChange(selectItem, selectIndex, oldSelectIndex)
	if self._branchScroll then
		local dataList = self._branchScroll.datas
		local selectTalentMo = dataList and dataList[selectIndex]

		if not selectTalentMo then
			return
		end

		self._selectBranchIndex = selectIndex
		self._selectNodeIndex = nil
		self._showTalentMo = selectTalentMo or self._showTalentMo

		if not self._isFirstEnter then
			self._animator:Play("switch", 0, 0)
			UIBlockHelper.instance:startBlock(self.viewName, 0.16, self.viewName)
			TaskDispatcher.cancelTask(self.refreshBranchTree, self)
			TaskDispatcher.runDelay(self.refreshBranchTree, self, 0.16)
		else
			self:refreshBranchTree()
		end

		self._isFirstEnter = false
	end
end

function MatchGameTalentView:refreshBranchTree()
	self:refreshResetBtn()
	self:refreshNodeList()
end

function MatchGameTalentView:refreshResetBtn()
	self._canReset = false

	if self._showTalentMo and self._showTalentMo.nodeList then
		for _, nodeCo in ipairs(self._showTalentMo.nodeList) do
			local status = MatchGameModel.instance:getTalentNodeStatus(nodeCo.nodeId)

			if status == MatchGameEnum.TalentNodeStatus.Active then
				self._canReset = true

				break
			end
		end
	end

	ZProj.UGUIHelper.SetGrayscale(self._btnReset.gameObject, not self._canReset)
end

function MatchGameTalentView:refreshNodeList()
	if not self._nodeScroll then
		local listParam = SimpleListParam.New()

		listParam.cellClass = MatchGameTalentNodeListItem
		listParam.lineCount = 1
		listParam.scrollDir = ScrollEnum.ScrollDirV
		listParam.isClickAutoSelect = true

		local scrollParam = {
			listParam = listParam,
			viewContainer = self.viewContainer
		}

		self._nodeScroll = MonoHelper.addNoUpdateLuaComOnceToGo(self._scrollNode.gameObject, SimpleListComp, scrollParam)

		self._nodeScroll:setRes(self._goNodeItem)
		self._nodeScroll:onCreate()
		self._nodeScroll:setOnSelectChange(self._onSelectNodeChange, self)
	end

	local nodeList = self._showTalentMo.nodeList

	self._nodeScroll:setData(nodeList)

	if not self._selectNodeIndex then
		local selectNodeIndex = self:findSelectNodeIndex(self._showTalentMo.branchId)

		self._nodeScroll:setSelect(selectNodeIndex)
		self:setNodeScrollContent()
		self:refreshLineList()
	end
end

function MatchGameTalentView:setNodeScrollContent()
	local maxPosX = -10000
	local itemList = self._nodeScroll:getItems()

	for _, item in ipairs(itemList) do
		local posX = item:getPosition()

		if maxPosX < posX then
			maxPosX = posX
		end
	end

	recthelper.setWidth(self._nodeScroll.customMode_content.transform, maxPosX)
end

function MatchGameTalentView:refreshLineList()
	if self._showTalentMo then
		if not self._showTalentMo.nodeList then
			local nodeList = {}
			local index = 0

			for i = 2, #nodeList do
				index = index + 1

				local lineItem = self:_getOrCreateLineItem(index)
				local preNodeItem = self._nodeScroll:getItemByIndex(i - 1)
				local curNodeItem = self._nodeScroll:getItemByIndex(i)

				lineItem:onUpdateMO(preNodeItem, curNodeItem)
			end

			for i = index + 1, #self._lineItemList do
				gohelper.setActive(self._lineItemList[i].viewGO, false)
			end
		end
	end
end

function MatchGameTalentView:_getOrCreateLineItem(index)
	local lineItem = self._lineItemList[index]

	if not lineItem then
		local goLine = gohelper.cloneInPlace(self._goLineItem, "line_" .. index)

		lineItem = MonoHelper.addNoUpdateLuaComOnceToGo(goLine, MatchGameTalentNodeLineItem)
		self._lineItemList[index] = lineItem
	end

	return lineItem
end

function MatchGameTalentView:_onSelectNodeChange(nodeItem, selectIndex, oldSelectIndex)
	if self._nodeScroll then
		local dataList = self._nodeScroll.datas
		local selectNodeCo = dataList and dataList[selectIndex]

		self._selectNodeIndex = selectIndex

		self:refreshNodeDetail(selectNodeCo)
	end
end

function MatchGameTalentView:refreshNodeDetail(nodeCo)
	self._selectNodeCo = nodeCo
	self._selectNodeId = nodeCo and nodeCo.nodeId

	local showDetails = self._selectNodeCo ~= nil

	gohelper.setActive(self._goNodeDetail, showDetails)

	if not showDetails then
		return
	end

	self._isItemEnough = true
	self._selectNodeCost = MatchGameConfig.instance:getTalentNodeCost(self._selectNodeId)
	self._txtNodeName.text = self._selectNodeCo.name
	self._txtNodeDesc.text = SkillHelper.buildDesc(self._selectNodeCo.desc, PercentColor, BracketColor)

	local status = MatchGameModel.instance:getTalentNodeStatus(self._selectNodeId)

	gohelper.setActive(self._btnActive.gameObject, status ~= MatchGameEnum.TalentNodeStatus.Active)

	if status ~= MatchGameEnum.TalentNodeStatus.Active then
		local isCanActive = status > MatchGameEnum.TalentNodeStatus.Lock

		self._isItemEnough = MatchGameModel.instance:isItemEnough(self._selectNodeCost)
		isCanActive = isCanActive and self._isItemEnough

		ZProj.UGUIHelper.SetGrayscale(self._btnActive.gameObject, not isCanActive)
		self._costComp:onUpdateMO(self._selectNodeCost)
	end
end

function MatchGameTalentView:_onUpdateTalentInfo()
	if self._lockUpdate then
		return
	end

	self:refreshBranchTree()
end

function MatchGameTalentView:onClose()
	GameUtil.setActiveUIBlock(self.viewName, false, true)
	TaskDispatcher.cancelTask(self.refreshBranchTree, self)

	if self._rpcCallback then
		MatchGameRpc.instance:removeCallbackById(self._rpcCallback)

		self._rpcCallback = nil
	end

	if self._flow then
		self._flow:destroy()

		self._flow = nil
	end
end

function MatchGameTalentView:onDestroyView()
	return
end

return MatchGameTalentView
