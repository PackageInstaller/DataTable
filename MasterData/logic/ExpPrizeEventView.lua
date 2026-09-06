-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/expedition/view/ExpPrizeEventView.lua

module("logic.extensions.expedition.view.ExpPrizeEventView", package.seeall)

local ExpPrizeEventView = class("ExpPrizeEventView", ViewComponent)

function ExpPrizeEventView:buildUI()
	ExpPrizeEventView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._btnGet = self:getBtn("btnGet")
	self._itemNode = self:getGo("ItemNode"):GetComponent("UILayoutSingleLine")
end

function ExpPrizeEventView:destroyUI()
	ExpPrizeEventView.super.destroyUI(self)
end

function ExpPrizeEventView:onExitFinished()
	ExpPrizeEventView.super.onExitFinished(self)
end

function ExpPrizeEventView:onEnterFinished()
	ExpPrizeEventView.super.onEnterFinished(self)
end

function ExpPrizeEventView:unbindEvents()
	ExpPrizeEventView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnGet:RemoveClickListener()
end

function ExpPrizeEventView:bindEvents()
	ExpPrizeEventView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnGet:AddClickListener(self._onClickGet, self)
end

function ExpPrizeEventView:onExit()
	GlobalDispatcher:removeListener(GlobalNotify.OnSweepSelEventBack, self._onSweepSelEventBack, self)
	ExpPrizeEventView.super.onExit(self)

	self._gridData = nil
	self._selectDatas = nil
	self._currDataIndex = nil

	local nodeCnt = self._itemNode.transform.childCount

	for i = 1, nodeCnt do
		local go = self._itemNode.transform:GetChild(i - 1).gameObject

		MaterialMgr.resetAll(go)
	end
end

function ExpPrizeEventView:onEnter()
	ExpPrizeEventView.super.onEnter(self)

	self._selectDatas = self._viewPresentor._openParam[1]
	self._canOpen = self._viewPresentor._openParam[2]
	self._isSweep = self._viewPresentor._openParam[3] or false

	self._btnGet.gameObject:SetActive(self._canOpen or false)
	self._closeButton.gameObject:SetActive(not self._isSweep)
	self:_updateByIndex(1)
	GlobalDispatcher:addListener(GlobalNotify.OnSweepSelEventBack, self._onSweepSelEventBack, self)
end

function ExpPrizeEventView:_updateByIndex(index)
	self._currDataIndex = index
	self._gridData = self._selectDatas[index]

	self:_updateAwards()
end

function ExpPrizeEventView:_updateAwards()
	local prizeCo = ExpeditionConfig.instance:getPrizCfg(self._gridData.eventInfo.em)
	local awards = string.split(prizeCo.prize, "#")
	local childCount = self._itemNode.transform.childCount
	local itemNum = #awards

	while childCount < itemNum do
		local go = goutil.create("prize" .. childCount + 1)

		go.transform:SetParent(self._itemNode.transform)
		Framework.TransformUtil.SetLocalPos(go.transform, childCount * 110, 0, 0)
		Framework.TransformUtil.SetLocalScale(go.transform, 1, 1, 1)

		childCount = childCount + 1
	end

	for i = 1, itemNum do
		local data = awards[i]
		local go = self._itemNode.transform:GetChild(i - 1).gameObject

		go:SetActive(true)
		MaterialMgr.resetAll(go)
		MaterialMgr.setCellByCfg(data, go)
	end

	for i = itemNum + 1, childCount do
		local go = self._itemNode.transform:GetChild(i - 1).gameObject

		go:SetActive(false)
	end

	self._itemNode:Layout()
end

function ExpPrizeEventView:_onClickClose()
	self:close()
end

function ExpPrizeEventView:_onClickGet()
	local gridData = self._gridData
	local evtParams = ExpeditionExtension_pb.PM_ExpeditionEventParam()

	evtParams.selectedId = gridData.eventInfo.em

	if not self._isSweep then
		self:close()
		ExpeditionAgent.instance:sendPM_ExpeditionDoGridEventReq(gridData.eventIndex, evtParams)

		return
	end

	ExpeditionAgent.instance:sendPM_ExpeditionDoSweepEventReq(gridData.eventIndex, evtParams)
end

function ExpPrizeEventView:_onSweepSelEventBack(newGridData)
	local currDataIndex = self._currDataIndex + 1

	if currDataIndex <= #self._selectDatas then
		self:_updateByIndex(currDataIndex)
	else
		self:close()
		ExpeditionController.instance:checkSweepEvents()
	end
end

return ExpPrizeEventView
