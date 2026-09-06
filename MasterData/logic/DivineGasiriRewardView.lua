-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinegasiri/view/DivineGasiriRewardView.lua

module("logic.extensions.divinegasiri.view.DivineGasiriRewardView", package.seeall)

local DivineGasiriRewardView = class("DivineGasiriRewardView", ViewComponent)

function DivineGasiriRewardView:ctor()
	DivineGasiriRewardView.super.ctor(self)
end

function DivineGasiriRewardView:unbindEvents()
	DivineGasiriRewardView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function DivineGasiriRewardView:bindEvents()
	DivineGasiriRewardView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
end

function DivineGasiriRewardView:buildUI()
	DivineGasiriRewardView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")

	local cellGo = self:getGo("cell")
	local tableviewGo = self:getGo("tableview")

	self._tableview = ScrollerList.create(tableviewGo, cellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtStage = self:getTxt("tipsStage/txtStage")
end

function DivineGasiriRewardView:onExit()
	DivineGasiriRewardView.super.onExit(self)
	self._tableview:dispose()
end

function DivineGasiriRewardView:onEnter()
	DivineGasiriRewardView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	DivineGasiriModel.instance:setCurActMo(self._activityId)

	local stageCfgs = DivineGasiriConfig.instance:getStageCfgs(self._activityId)

	self._tableview:reloadData(stageCfgs)

	self._curPassStageId = DivineGasiriModel.instance:getCurPassStageId(self._activityId)
	self._txtStage.text = langPara("当前关卡：%d/%d", self._curPassStageId, #stageCfgs)
end

function DivineGasiriRewardView:_updateCell(view, cellGo, data)
	local cell = self:_clearCell(cellGo)

	cell.txtStage.text = langPara("第%s关", data.stageId)

	MaterialMgr.setCellListByCfg(data.prize, cell.prizeCom)
	goutil.setActive(cell.markGain, data.stageId <= self._curPassStageId)
end

function DivineGasiriRewardView:_clearCell(cellGo)
	local cell = {}

	cell.go = cellGo
	cell.txtStage = goutil.findChildTextComponent(cell.go, "txtStage")
	cell.prizeCom = goutil.findChild(cell.go, "prizeCom")
	cell.markGain = goutil.findChild(cell.go, "markGain")

	MaterialMgr.resetAll(cell.prizeCom)

	return cell
end

return DivineGasiriRewardView
