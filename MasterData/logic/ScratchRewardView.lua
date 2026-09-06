-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scratch/view/ScratchRewardView.lua

module("logic.extensions.scratch.view.ScratchRewardView", package.seeall)

local ScratchRewardView = class("ScratchRewardView", TableViewComponent)

function ScratchRewardView:ctor()
	ScratchRewardView.super.ctor(self)
end

function ScratchRewardView:buildUI()
	ScratchRewardView.super.buildUI(self)

	self._closeButton = self:getBtn("btnClose")
	self._btnSure = self:getBtn("main/btnSure")
	self._bigItemGo = self:getGo("main/bigReward/item")
end

function ScratchRewardView:bindEvents()
	ScratchRewardView.super.bindEvents(self)
	self._closeButton:AddClickListener(self._onClickClose, self)
	self._btnSure:AddClickListener(self._onClickSure, self)
end

function ScratchRewardView:unbindEvents()
	ScratchRewardView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
	self._btnSure:RemoveClickListener()
end

function ScratchRewardView:onEnter()
	ScratchRewardView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.ScratchUpdateReward, self._refreshRewardList, self)

	local activityId = self:getFirstParam()
	local param = self._viewPresentor:getOpenParam()

	self._isSwitchSelect = false

	if param then
		self._isSwitchSelect = param[2]
	end

	ScratchModel.instance:initRewardSelect()

	local list = ScratchModel.instance:getBigPrizeList()

	self:updateListData(list)

	if self._isSwitchSelect then
		local cfg = ScratchConfig.instance:getScratchActivityCfgById(activityId)

		if cfg then
			local bigPrizeId = ScratchModel.instance:getBigPrizeId()
			local cfgPrize = ScratchConfig.instance:getScratchPrizeCfg(cfg.bigPlanId, bigPrizeId, true)

			if cfgPrize then
				self:_setBigPrizeItem(cfgPrize.prize)
			end
		end
	end
end

function ScratchRewardView:onExit()
	ScratchRewardView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.ScratchUpdateReward, self._refreshRewardList, self)
	self:_clearBigItem()
end

function ScratchRewardView:_onClickClose()
	self:close()
end

function ScratchRewardView:_onClickSure()
	local isEnd = ScratchModel.instance:isSelectFinish()

	if not isEnd then
		FloatWordMgr.instance:show("请先选择奖励")

		return
	end

	local prizeId = ScratchModel.instance:getPrizeId()

	if self._isSwitchSelect then
		ScratchController.instance:sendPM_ScratchSwitchPrizeReq(prizeId)
	else
		ScratchController.instance:sendPM_ScratchSelectBigPrizeReq(prizeId)
	end

	self:_onClickClose()
end

function ScratchRewardView:_getPath()
	return {
		cellPath = "main/cell",
		viewPath = "main/tableview"
	}
end

function ScratchRewardView:_cellSize()
	return 100, 130
end

function ScratchRewardView:_updateCell(view, cell, data)
	local itemGo = goutil.findChild(cell, "item")
	local txtDesc = goutil.findChildTextComponent(cell, "desc/txtDesc")
	local selectedGo = goutil.findChild(cell, "selected")
	local lockGo = goutil.findChild(cell, "lock")
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")
	local isLock = data.curRound < data.cfg.round
	local isSelect = ScratchModel.instance:getPrizeId() == data.cfg.id
	local prizeId = data.cfg.id
	local isHaveCount = not data.isLimit or data.times < data.cfg.totalTimes
	local prizeStr = data.cfg.prize

	btn:RemoveClickListener()
	btn:AddClickListener(function()
		if isLock then
			FloatWordMgr.instance:show(string.format("此奖励在第%d轮开启哦", data.cfg.round))
		elseif data.isBigPrize then
			FloatWordMgr.instance:show(string.format("当前奖励已是大奖哦"))
		elseif not isSelect and isHaveCount then
			local oldSelectId = ScratchModel.instance:getPrizeId()

			ScratchModel.instance:setPrizeId(prizeId)
			goutil.setActive(selectedGo, true)
			GlobalDispatcher:dispatch(GlobalNotify.ScratchUpdateReward, oldSelectId, prizeStr)
		elseif not isHaveCount then
			FloatWordMgr.instance:show("大奖次数已经用完啦")
		end
	end)
	goutil.setActive(btn.gameObject, not isLock)
	goutil.setActive(lockGo, isLock)
	goutil.setActive(selectedGo, not isLock and isSelect)
	MaterialMgr.resetAll(itemGo)

	local proxy = MaterialMgr.setCellByCfg(data.cfg.prize, itemGo)

	if data.isBigPrize then
		proxy.binder:setGray(true)
	end

	local desc = ""

	if isLock then
		desc = string.format("第%d轮", data.cfg.round)
	elseif not data.isLimit then
		desc = "不限次"
	else
		local leftCount = data.cfg.totalTimes - data.times

		if leftCount > 0 then
			if not ColorConst.White then
				local colorStr = ColorConst.Red

				desc = string.format("<color=#%s>%d</color>/%d", colorStr, leftCount, data.cfg.totalTimes)
			end
		end
	end

	txtDesc.text = desc
end

function ScratchRewardView:_clearTableview(cell)
	local itemGo = goutil.findChild(cell, "item")
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")

	MaterialMgr.resetAll(itemGo)
	btn:RemoveClickListener()
end

function ScratchRewardView:_refreshRewardList(oldSelectId, prizeStr)
	for i, v in ipairs(self._curViewDatas) do
		if v.cfg.id == oldSelectId then
			self._tableview:UpdateCellAtIndex(i - 1)

			break
		end
	end

	self:_setBigPrizeItem(prizeStr)
end

function ScratchRewardView:_setBigPrizeItem(prizeStr)
	MaterialMgr.resetAll(self._bigItemGo)

	local proxy = MaterialMgr.setCellByCfg(prizeStr, self._bigItemGo)

	proxy.binder:setBgActive(false)
end

function ScratchRewardView:_clearBigItem()
	MaterialMgr.resetAll(self._bigItemGo)
end

return ScratchRewardView
