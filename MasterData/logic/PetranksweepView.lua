-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/handbook/view/PetranksweepView.lua

module("logic.extensions.handbook.view.PetranksweepView", package.seeall)

local PetranksweepView = class("PetranksweepView", ViewComponent)

function PetranksweepView:ctor()
	PetranksweepView.super.ctor(self)

	self._scrollList = {}
end

function PetranksweepView:unbindEvents()
	PetranksweepView.super.unbindEvents(self)
	self._btnSure:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnClose2:RemoveClickListener()
end

function PetranksweepView:bindEvents()
	PetranksweepView.super.bindEvents(self)
	self._btnSure:AddClickListener(self._onClickbtnSure, self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
	self._btnClose2:AddClickListener(self._onClickbtnClose2, self)
end

function PetranksweepView:buildUI()
	PetranksweepView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("btnSure")
	self._tableviewGo = self:getGo("tableview")
	self._tablecellGo = self:getGo("tablecell")
	self._emptyGo = self:getGo("empty")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._scrollerList:regReloadFinish(GameUtil.handler(self._onReloadFinish, self))

	self._btnSure = self:getBtn("btnSure")
	self._btnClose = self:getBtn("btnClose")
	self._btnClose2 = self:getBtn("btnClose2")
	self._txtEmpty = self:getTxt("empty/txtEmpty")
end

function PetranksweepView:onExit()
	PetranksweepView.super.onExit(self)
	self._scrollerList:dispose()
	removetimer(self._tickAnim, self)
end

function PetranksweepView:onEnter()
	PetranksweepView.super.onEnter(self)
	self.addGEvent(self, PetManualAgent.GainRankPrizeRes, self._onGainRankPrizeRes, self)

	local tempItems = self:getFirstParam() or {}

	self._items = {}

	for i, v in ipairs(tempItems) do
		table.insert(self._items, v)
	end

	self._itemNum = #self._items
	self._sendGainIdx = 0
	self._currShowDatas = {}
	self._currShowDatasMap = {}

	self:_updateUI()
end

function PetranksweepView:_onClickbtnSure()
	if self._sendGainIdx >= self._itemNum then
		FloatWordMgr.instance:show("已领取所有奖励")

		return
	end

	goutil.setActive(self._btnSure.gameObject, false)

	self._tickCount = 0
	self._tickPoints = {
		[0] = "...",
		".",
		".."
	}

	settimer(0.5, self._tickAnim, self, true)
	self:_tickAnim()
	self:_onHandleSendNext()
end

function PetranksweepView:_tickAnim()
	self._tickCount = self._tickCount + 1
	self._txtEmpty.text = string.format("领取中%s", self._tickPoints[self._tickCount % 3])
end

function PetranksweepView:_onClickbtnClose()
	self:close()
end

function PetranksweepView:_onClickbtnClose2()
	self:close()
end

function PetranksweepView:_onGainRankPrizeRes(status, msg)
	if status == 0 then
		local items = MaterialController.instance:getTempItemsByChangeSetId(msg.changeSetId)

		if items and #items > 0 then
			local info = self._currShowDatasMap[self._currSendRaceId]

			if not info then
				info = {
					raceId = self._currSendRaceId,
					items = {}
				}

				table.insert(self._currShowDatas, info)

				self._currShowDatasMap[self._currSendRaceId] = info
			end

			table.insertto(info.items, items)
		end
	end

	self:_onHandleSendNext()

	if self._sendGainIdx >= self._itemNum then
		self:_showTotalReward()
	end
end

function PetranksweepView:_showTotalReward()
	self._scrollerList:reloadData(self._currShowDatas)
	goutil.setActive(self._emptyGo, #self._currShowDatas <= 0)

	if #self._currShowDatas <= 0 then
		self._txtEmpty.text = "未领取"
	end

	goutil.setActive(self._btnClose2.gameObject, true)
	removetimer(self._tickAnim, self)
end

function PetranksweepView:_onHandleSendNext()
	if self._sendGainIdx >= self._itemNum then
		FloatWordMgr.instance:show("领取结束")
		goutil.setActive(self._btnClose2.gameObject, true)
		GlobalDispatcher:dispatch(GlobalNotify.OneKeyPetRankClearRedDot)

		return
	end

	local item = self._items[1]

	table.remove(self._items, 1)

	self._sendGainIdx = self._sendGainIdx + 1
	self._currSendRaceId = item.raceId

	PowerCheckController.instance:sendGainRankPrizeReq(item.rankType, item.subType, item.raceId)
end

function PetranksweepView:_updateUI()
	self._scrollerList:reloadData(self._currShowDatas)
	goutil.setActive(self._emptyGo, #self._currShowDatas <= 0)
	goutil.setActive(self._btnSure.gameObject, true)
	goutil.setActive(self._btnClose2.gameObject, false)
end

function PetranksweepView:_updateCell(view, cell, data, tag)
	local goHead = goutil.findChild(cell.gameObject, "head")
	local goTablecell = goutil.findChild(cell.gameObject, "tablecell")
	local goTableview = goutil.findChild(cell.gameObject, "tableview")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local scroll = self:_getScroll(goTableview, goTablecell)

	MaterialMgr.setCell(MatType.Pet, data.raceId, goHead)

	txtName.text = MaterialMgr.getMaterialsName(MatType.Pet, data.raceId)

	scroll:reloadData(data.items)
	scroll:dragNotifyParent()
end

function PetranksweepView:_clearCell(cell)
	local goHead = goutil.findChild(cell.gameObject, "head")

	MaterialMgr.resetAll(goHead)
end

function PetranksweepView:_getScroll(goView, goCell)
	local scroll = self._scrollList[goView]

	if not scroll then
		scroll = ScrollerList.create(goView, goCell, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
		self._scrollList[goView] = scroll
	end

	return scroll
end

function PetranksweepView:_updateRewardCell(view, cell, itemMo, tag)
	local goCon = goutil.findChild(cell.gameObject, "con")
	local proxy = MaterialMgr.setCellByData(itemMo.materialType, itemMo, goCon)

	if proxy and itemMo.materialType == MatType.Pet then
		proxy.binder:setCallBack(function(petCell)
			CommonTipsMgr.instance:openMaterialTips(petCell, itemMo.materialType, itemMo.id)
		end)
	end
end

function PetranksweepView:_clearRewardCell(cell)
	local goCon = goutil.findChild(cell.gameObject, "con")

	MaterialMgr.resetAll(goCon)
end

function PetranksweepView:_onReloadFinish()
	return
end

return PetranksweepView
