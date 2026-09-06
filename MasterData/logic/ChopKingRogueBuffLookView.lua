-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/chopking/view/ChopKingRogueBuffLookView.lua

module("logic.extensions.chopking.view.ChopKingRogueBuffLookView", package.seeall)

local ChopKingRogueBuffLookView = class("ChopKingRogueBuffLookView", ViewComponent)

function ChopKingRogueBuffLookView:buildUI()
	ChopKingRogueBuffLookView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnRefresh = self:getBtn("btnRefresh")
	self._scrollView = self:getGo("tableview")
	self._cell = self:getGo("cell")
	self._scrollList = ScrollerList.create(self._scrollView, self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._emptyGo = self:getGo("empty")
end

function ChopKingRogueBuffLookView:bindEvents()
	ChopKingRogueBuffLookView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnRefresh:AddClickListener(self._onClickRefresh, self)
end

function ChopKingRogueBuffLookView:unbindEvents()
	ChopKingRogueBuffLookView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnRefresh:RemoveClickListener()
end

function ChopKingRogueBuffLookView:onEnter()
	ChopKingRogueBuffLookView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_ChopKingReShuffleDropBuffRes, self._PM_ChopKingReShuffleDropBuffRes, self)
	self.addGEvent(self, GlobalNotify.PM_ChopKingSelectDropBuffRes, self._refreshView, self)

	local params = self:getOpenParam()

	self._activityId = params[1]

	self:_refreshView()
end

function ChopKingRogueBuffLookView:onExit()
	ChopKingRogueBuffLookView.super.onExit(self)
	self._scrollList:dispose()
end

function ChopKingRogueBuffLookView:_onClickClose()
	self:close()
end

function ChopKingRogueBuffLookView:_onClickRefresh()
	local buffIdList = ChopKingModel.instance:getRogueBuffList(self._activityId)
	local count = #buffIdList

	if count > 0 then
		local activityCfg = ChopKingConfig.instance:getActivityCfg(self._activityId)
		local matType, id, matNum = MaterialMgr.getMatParams(activityCfg.resetDropBuffCost)
		local content = string.format("确定要花费%d%s洗牌么？", matNum, MaterialMgr.getMaterialsName(matType, id))

		TipsFacade.instance:openPopupCostMatViewNew(matType, id, matNum, content, function()
			ChopKingAgent.instance:sendPM_ChopKingReShuffleDropBuffReq(self._activityId)
		end)
	else
		FloatWordMgr.instance:show("无掉落buff")
	end
end

function ChopKingRogueBuffLookView:_updateCell(view, cell, data)
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local txtDesc = goutil.findChildTextComponent(cell, "tableview/viewport/content/txtDesc")
	local buffIcon = goutil.findChild(cell, "buffIcon")
	local buffId = data
	local cfg = ChopKingConfig.instance:getDropBuff(self._activityId, buffId)

	txtName.text = cfg.buffName
	txtDesc.text = cfg.buffDesc

	uGuiUtil.setSpriteToImage(buffIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getExpEventUrl(cfg.iconPath))
end

function ChopKingRogueBuffLookView:_clearCell(cell)
	local buffIcon = goutil.findChild(cell, "buffIcon")

	MaterialMgr.clearIcon(buffIcon)
end

function ChopKingRogueBuffLookView:_refreshView()
	local buffIdList = ChopKingModel.instance:getRogueBuffList(self._activityId)
	local count = #buffIdList

	self._scrollList:reloadData(buffIdList)
	GameUtil.SetActive(self._emptyGo, count == 0)
end

function ChopKingRogueBuffLookView:_PM_ChopKingReShuffleDropBuffRes()
	self:_refreshView()

	if ChopKingModel.instance:isNeedSelectBuff(self._activityId) == true then
		UIStateManager.instance:push(ViewName.ChopKingRogueSelectBuffView, self._activityId, true)
	end
end

return ChopKingRogueBuffLookView
