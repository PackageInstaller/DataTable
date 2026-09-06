-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/springredpack/view/SpringRedPackMineView.lua

module("logic.extensions.springredpack.view.SpringRedPackMineView", package.seeall)

local SpringRedPackMineView = class("SpringRedPackMineView", TableViewComponent)

function SpringRedPackMineView:_getPath()
	return {
		cellPath = "view/tablecell",
		viewPath = "view/tableview"
	}
end

function SpringRedPackMineView:buildUI()
	SpringRedPackMineView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._headIcon = self:getGo("myHead")
	self._noRecord = self:getGo("txtNoRecord")
end

function SpringRedPackMineView:bindEvents()
	SpringRedPackMineView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function SpringRedPackMineView:unbindEvents()
	SpringRedPackMineView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function SpringRedPackMineView:onEnter()
	SpringRedPackMineView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.GetRedPackLogsRes, self._onGetRedPackLogsRes, self)
	self:_setHeadIcon()

	local activityId = SpringRedPackModel.instance:getCurActivityId()

	SpringRedPackAgent.instance:sendPM_GetRedPackLogsReq(activityId)
end

function SpringRedPackMineView:onExit()
	SpringRedPackMineView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.GetRedPackLogsRes, self._onGetRedPackLogsRes, self)
	self:_removeHeadIcon()
end

function SpringRedPackMineView:_onClickClose()
	self:close()
end

function SpringRedPackMineView:_onGetRedPackLogsRes()
	self:_initLogsList()
end

function SpringRedPackMineView:_setHeadIcon()
	HeadItemController.instance:setMyHeadCell(self._headIcon)
end

function SpringRedPackMineView:_removeHeadIcon()
	MaterialMgr.resetAll(self._headIcon)
end

function SpringRedPackMineView:_updateCell(view, cell, data)
	local imgBest = goutil.findChild(cell, "txtDesc/imgBest")
	local txtDesc = goutil.findChildTextComponent(cell, "txtDesc")
	local txtDate = goutil.findChildTextComponent(cell, "txtDate")
	local prizeId = data.redPackPrizeId
	local timestamp = data.gainTime / 1000
	local cfg = SpringRedPackConfig.instance:getPrizeCfg(prizeId)

	if cfg then
		local matType, id, matNum = MaterialMgr.getMatParams(cfg.prize)
		local name = MaterialMgr.getMaterialsName(matType, id)

		txtDesc.text = string.format("%s*%s", name, matNum)

		goutil.setActive(imgBest, cfg.bigPrize)
	else
		goutil.setActive(imgBest, false)
	end

	txtDate.text = GameUtil.formatTimeStamp("%Y.%m.%d", timestamp)
end

function SpringRedPackMineView:_initLogsList()
	local list = SpringRedPackModel.instance:getLogsList()

	self:updateListData(list)

	local isEmpty = #list == 0

	goutil.setActive(self._noRecord, isEmpty)
end

return SpringRedPackMineView
