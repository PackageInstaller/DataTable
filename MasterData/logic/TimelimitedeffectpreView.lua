-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/TimelimitedeffectpreView.lua

module("logic.extensions.timelimitedchallenge.view.TimelimitedeffectpreView", package.seeall)

local TimelimitedeffectpreView = class("TimelimitedeffectpreView", ViewComponent)

function TimelimitedeffectpreView:ctor()
	TimelimitedeffectpreView.super.ctor(self)
end

function TimelimitedeffectpreView:buildUI()
	TimelimitedeffectpreView.super.buildUI(self)

	self.btnClose = self:getGo("btnClose")
	self.btnTip = self:getGo("btnTip")
	self.tableview = self:getGo("tableview")
	self.cell = self:getGo("cell")
	self.scrollList = ScrollerList.create(self.tableview, self.cell, GameUtil.handler(self._upateCell, self), GameUtil.handler(self.clearCell, self))
	self._txtTip = self:getTxt("txtTip")
	self._uiChangeGroup = goutil.findChildComponent(self.mainGO, "bggroup_lv2/bg1", typeof(UIChangeGroup))
end

function TimelimitedeffectpreView:bindEvents()
	TimelimitedeffectpreView.super.bindEvents(self)
	GameUtil.addClickHandler(self.btnClose, self.close, self)
	GameUtil.addClickHandler(self.btnTip, self.onTipClick, self)
end

function TimelimitedeffectpreView:unbindEvents()
	TimelimitedeffectpreView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self.btnClose)
	GameUtil.rmClickHandler(self.btnTip)
end

function TimelimitedeffectpreView:destroyUI()
	TimelimitedeffectpreView.super.destroyUI(self)
end

function TimelimitedeffectpreView:onEnter()
	TimelimitedeffectpreView.super.onEnter(self)

	self._challengeId = math.max(1, checknumber(self:getFirstParam()))

	self._uiChangeGroup:SetState(self._challengeId - 1)

	local list = {}

	if self._challengeId == 2 then
		self._txtTip.text = lang("panduola_buff_tip")
		list = TimeLimitedConfig.instance:getAllBuffList()
	elseif self._challengeId == 3 or self._challengeId == 39 then
		self._txtTip.text = lang("longhuang_buff_tip")
		list = TimeLimitedConfig.instance:getLongHuangGameBuffCfgs()
	end

	self.scrollList:reloadData(list)
end

function TimelimitedeffectpreView:onEnterFinished()
	TimelimitedeffectpreView.super.onEnterFinished(self)
end

function TimelimitedeffectpreView:onExit()
	TimelimitedeffectpreView.super.onExit(self)
	self.scrollList:dispose()
end

function TimelimitedeffectpreView:onExitFinished()
	TimelimitedeffectpreView.super.onExitFinished(self)
end

function TimelimitedeffectpreView:onTipClick()
	return
end

function TimelimitedeffectpreView:clearCell(cell)
	return
end

function TimelimitedeffectpreView:_upateCell(view, cell, data, tag)
	local buffCell = PanduolaBuffCell.New(cell.gameObject)

	buffCell:updateWithPanduolaBuffCfg(data)
end

return TimelimitedeffectpreView
