-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitrank/view/TimelimitrankprizeView.lua

module("logic.extensions.timelimitrank.view.TimelimitrankprizeView", package.seeall)

local TimelimitrankprizeView = class("TimelimitrankprizeView", ViewComponent)

function TimelimitrankprizeView:ctor()
	TimelimitrankprizeView.super.ctor(self)
end

function TimelimitrankprizeView:buildUI()
	TimelimitrankprizeView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._tableGo = self:getGo("tableview")
	self._itemGo = self:getGo("tablecell")
	self._tableview = ScrollerList.create(self._tableGo, self._itemGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtMyProgress = goutil.findChildTextComponent(self.mainGO, "txtMyProgress")
end

function TimelimitrankprizeView:bindEvents()
	TimelimitrankprizeView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
end

function TimelimitrankprizeView:unbindEvents()
	TimelimitrankprizeView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function TimelimitrankprizeView:destroyUI()
	TimelimitrankprizeView.super.destroyUI(self)
end

function TimelimitrankprizeView:onEnter()
	TimelimitrankprizeView.super.onEnter(self)

	self.rankTypeData = TimelimitrankConfig.instance:getDefineById(self:getFirstParam())

	local dataList = TimelimitrankModel.instance:getProgressPrizeById(self.rankTypeData.progressPrizeId)
	local info = TimelimitrankModel.instance:getProgressInfo(self.rankTypeData.id)

	if info == nil then
		FloatWordMgr.instance:show("无用户进度信息，请确认网络或操作是否异常")
		self._tableview:reloadData({})

		return
	end

	self._progress = info.progress
	self._txtMyProgress.text = string.format("我的%s:%d", self.rankTypeData.progressName, info.progress)

	for i = 1, #dataList do
		dataList[i].progressPrize = info.progressPrize[i]
		dataList[i].progressInfoIndex = i
		dataList[i].state = self._progress >= dataList[i].progress and (dataList[i].progressPrize and 3 or 1) or 2
	end

	dataList = ArraySort.sortOn(dataList, {
		"state",
		"progress"
	})

	self._tableview:reloadData(dataList)
end

function TimelimitrankprizeView:onEnterFinished()
	TimelimitrankprizeView.super.onEnterFinished(self)
end

function TimelimitrankprizeView:onExit()
	TimelimitrankprizeView.super.onExit(self)
	self._tableview:dispose()
	TimeLimitRankAgent.instance:getDispatcher():removeAllListener(TimeLimitRankAgent.PM_TimeLimitRankGainProgressPrizeRes)
end

function TimelimitrankprizeView:onExitFinished()
	TimelimitrankprizeView.super.onExitFinished(self)
end

function TimelimitrankprizeView:_updateCell(view, cell, data)
	local btnReceive = goutil.findChild(cell, "state/btnReceive")
	local txtNotFinish = goutil.findChild(cell, "state/txtNotFinish")
	local txtReceived = goutil.findChild(cell, "state/txtReceived")

	GameUtil.rmClickHandler(btnReceive)

	if data then
		goutil.findChildTextComponent(cell, "imgDes/name").text = self.rankTypeData.progressName
		goutil.findChildTextComponent(cell, "imgDes/value").text = data.progress

		if data.progress <= self._progress then
			goutil.setActive(txtNotFinish.gameObject, false)

			if data.progressPrize then
				goutil.setActive(txtReceived.gameObject, true)
				goutil.setActive(btnReceive.gameObject, false)
			else
				goutil.setActive(txtReceived.gameObject, false)
				goutil.setActive(btnReceive.gameObject, true)
				GameUtil.addClickHandler(btnReceive, GameUtil.handler(self._onGainPrize, self, cell))
			end
		else
			goutil.setActive(txtReceived.gameObject, false)
			goutil.setActive(btnReceive.gameObject, false)
			goutil.setActive(txtNotFinish.gameObject, true)
		end

		self:_updateCellPirzes(cell, data.prize)
	else
		self:_updateCellPirzes(cell)
	end
end

function TimelimitrankprizeView:_clearCell(cell)
	self:_updateCellPirzes(cell)

	local btnReceive = goutil.findChild(cell, "state/btnReceive")

	GameUtil.rmClickHandler(btnReceive)
end

function TimelimitrankprizeView:_updateCellPirzes(cell, prizeStr)
	local str = prizeStr or ""
	local t = string.split(str, "#")
	local items = {}

	for i = 1, 4 do
		items[i] = goutil.findChild(cell, "items/" .. i)

		MaterialMgr.resetAll(items[i])

		if t then
			goutil.setActive(items[i], i <= #t)

			if i <= #t then
				MaterialMgr.setCellByCfg(t[i], items[i])
			end
		else
			goutil.setActive(items[i], false)
		end
	end
end

function TimelimitrankprizeView:_onGainPrize(cell)
	local dataList = self._tableview:getData()

	TimeLimitRankAgent.instance:sendPM_TimeLimitRankGainProgressPrizeReq(self.rankTypeData.id, dataList[cell.data].progressInfoIndex - 1, function()
		dataList[cell.data].progressPrize = true

		TimelimitrankModel.instance:setProgressPrizeInfo(self.rankTypeData.id, dataList[cell.data].progressInfoIndex, true)
		goutil.setActive(goutil.findChild(cell, "state/txtReceived").gameObject, true)
		goutil.setActive(goutil.findChild(cell, "state/btnReceive").gameObject, false)
		GlobalDispatcher:dispatch(TimelimitrankController.UPDATE_REDPOINT)
	end)
end

return TimelimitrankprizeView
