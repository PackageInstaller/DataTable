-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sendflower/view/FlowerrecordsView.lua

module("logic.extensions.sendflower.view.FlowerrecordsView", package.seeall)

local FlowerrecordsView = class("FlowerrecordsView", ViewComponent)

function FlowerrecordsView:ctor()
	FlowerrecordsView.super.ctor(self)
end

function FlowerrecordsView:buildUI()
	FlowerrecordsView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnFinishEff = self:getBtn("btnFinishEff")
	self._txtCountTake = self:getTxt("countTake/txt")
	self._txtCountTakeText = self:getTxt("countTake")
	self._txtTitle = self:getTxt("BG/txt_Title")
	self._txtEmpty = self:getGo("txtEmpty")
	self._goCell = self:getGo("cell")
	self._goTableView = self:getGo("tableView")
	self._tableview = ScrollerList.create(self._goTableView, self._goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function FlowerrecordsView:bindEvents()
	FlowerrecordsView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnFinishEff:AddClickListener(self._onFinishPlay, self)
end

function FlowerrecordsView:unbindEvents()
	FlowerrecordsView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnFinishEff:RemoveClickListener()
end

function FlowerrecordsView:destroyUI()
	FlowerrecordsView.super.destroyUI(self)
end

function FlowerrecordsView:onEnter()
	FlowerrecordsView.super.onEnter(self)

	self._recordType = checknumber(self:getFirstParam())

	self:_onFinishPlay()
	RedPointController.instance:setRedPointInfo(RedPointModel.ID_GET_FLOWER, false)
	SendFlowerAgent.instance:sendPM_GetHistoryInfoReq(RoleModel.instance:getUserId())
	SendFlowerAgent.instance:sendPM_GetFlowerRecordReq(self._recordType)
	GlobalDispatcher:addListener(SendFlowerController.HandleGetRecord, self._updateView, self)
end

function FlowerrecordsView:onEnterFinished()
	FlowerrecordsView.super.onEnterFinished(self)
end

function FlowerrecordsView:onExit()
	FlowerrecordsView.super.onExit(self)
	self._tableview:dispose()
	self:_onFinishPlay()
	GlobalDispatcher:removeListener(SendFlowerController.HandleGetRecord, self._updateView, self)
end

function FlowerrecordsView:onExitFinished()
	FlowerrecordsView.super.onExitFinished(self)
end

function FlowerrecordsView:_updateView()
	if self._recordType == SendFlowerModel.flowerRecordType.RECEIVE then
		self._txtCountTakeText.text = "历史收花数："
		self._txtTitle.text = "收花记录"
		self._txtCountTake.text = checkint(SendFlowerModel.instance:getShowTakeCount())
	else
		self._txtCountTakeText.text = "历史送花数："
		self._txtTitle.text = "送花记录"
		self._txtCountTake.text = checkint(SendFlowerModel.instance:getShowSendCount())
	end

	goutil.setActive(self._txtEmpty, #SendFlowerModel.instance:getRecordInfos() <= 0)
	self._tableview:reloadData(SendFlowerModel.instance:getRecordInfos())
end

function FlowerrecordsView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell

	GameUtil.rmClickHandler(cell.go)

	cell.txtName = goutil.findChildTextComponent(cell.go, "txtName")
	cell.txtLV = goutil.findChildTextComponent(cell.go, "txtLv")
	cell.txtCount = goutil.findChildTextComponent(cell.go, "txtCount")
	cell.txtTime = goutil.findChildTextComponent(cell.go, "txtTime")
	cell.head = goutil.findChild(cell.go, "head")
	cell.flower = goutil.findChild(cell.go, "flower")

	MaterialMgr.resetAll(cell.flower)

	return cell
end

function FlowerrecordsView:_updateCell(view, goCell, data)
	local cell = self:_clearCell(goCell)

	HeadItemController.instance:setHeadCellByInfo(cell.head, data.headInfo)

	cell.txtLV.text = string.format("LV:<color=#0083e7>%s</color>", data.headInfo.playerLv)
	cell.txtName.text = data.headInfo.userName

	local cfg = SendFlowerConfig.instance:getFlowerCfg(data.flowerId)

	cell.txtCount.text = "x" .. data.sendCount

	local matStr = cfg.content

	if not GameUtil.isEmptyString(matStr) then
		local proxy = MaterialMgr.setCellByCfg(matStr, cell.flower)

		proxy.binder:setNum(0)
	end

	cell.txtTime.text = self:_getShowTimeTxt(data.sendTime)

	GameUtil.addClickHandler(cell.go, GameUtil.handler(self._onClickBtn, self, cfg.effPath))
end

function FlowerrecordsView:_getShowTimeTxt(timestamp)
	local curDate = GameUtil.time2date(ServerTime.now())
	local recordDate = GameUtil.time2date(timestamp / 1000)

	if curDate.yday == recordDate.yday then
		return string.format("%02d:%02d", recordDate.hour, recordDate.min)
	else
		return string.format("%s天前", curDate.yday - recordDate.yday)
	end
end

function FlowerrecordsView:_onClickBtn(eff)
	goutil.setActive(self._btnFinishEff.gameObject, true)

	if self._eff then
		UIEffectManager.instance:stopEffect(self._eff)

		self._eff = nil
	end

	local effPath = eff .. ".prefab"

	self._eff = UIEffectManager.instance:playEffect(self, effPath, nil, 0, 0, true, false, nil, function(target, eff)
		eff:setParent(self._btnFinishEff.transform)
		eff:setLocalPos(0, 0, 0)
		eff:setScale(1)

		eff.hideEffWhileNotOnTop = true
	end)

	removetimer(self._onFinishPlay, self)
	settimer(5, self._onFinishPlay, self, false)
end

function FlowerrecordsView:_onFinishPlay()
	removetimer(self._onFinishPlay, self)
	goutil.setActive(self._btnFinishEff.gameObject, false)

	if self._eff then
		UIEffectManager.instance:stopEffect(self._eff)

		self._eff = nil
	end
end

return FlowerrecordsView
