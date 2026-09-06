-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dragonpool/view/DragonpoolrewardView.lua

module("logic.extensions.dragonpool.view.DragonpoolrewardView", package.seeall)

local DragonpoolrewardView = class("DragonpoolrewardView", ViewComponent)

function DragonpoolrewardView:ctor()
	DragonpoolrewardView.super.ctor(self)
end

function DragonpoolrewardView:unbindEvents()
	DragonpoolrewardView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function DragonpoolrewardView:bindEvents()
	DragonpoolrewardView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function DragonpoolrewardView:buildUI()
	DragonpoolrewardView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._tablecellGo = self:getGo("tablecell")
	self._tableviewGo = self:getGo("tableview")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtDesc = self:getTxt("txtDesc")
end

function DragonpoolrewardView:onExit()
	DragonpoolrewardView.super.onExit(self)
	self._scrollerList:dispose()
end

function DragonpoolrewardView:onEnter()
	DragonpoolrewardView.super.onEnter(self)
	self.addGEvent(self, DragonPoolAgent.DragonPoolGainPrizeRes, self._updateUI, self)
	self.addGEvent(self, DragonPoolAgent.DragonPoolGetInfoRes, self._updateUI, self)

	self._activityId = DragonpoolModel.instance:getActivityId()

	if self._activityId <= 0 then
		self:close()

		return
	end

	self:_updateUI()
end

function DragonpoolrewardView:_onClickbtnClose()
	self:close()
end

function DragonpoolrewardView:_updateUI()
	local info = DragonpoolModel.instance:getInfo()

	if not info then
		return
	end

	self._progress = DragonpoolModel.instance:getEggProgress()

	local cfgs = DragonpoolConfig.instance:getPrizeCfgs(self._activityId)
	local gainList = {}
	local isCanGainList = {}
	local normalList = {}

	for i, v in ipairs(cfgs) do
		local isGain = DragonpoolModel.instance:isGainPrize(v.prizeId)
		local isCanGain = not isGain and self._progress >= v.progress

		if isGain then
			table.insert(gainList, v)
		elseif isCanGain then
			table.insert(isCanGainList, v)
		else
			table.insert(normalList, v)
		end
	end

	table.insertto(isCanGainList, normalList)
	table.insertto(isCanGainList, gainList)
	self._scrollerList:reloadData(isCanGainList)

	self._txtDesc.text = string.format("我的孵蛋成功次数：%s", self._progress)
end

function DragonpoolrewardView:_updateCell(view, cell, cfg, tag)
	local btnGain = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnSure")
	local goItemcon = goutil.findChild(cell.gameObject, "reward")
	local goReceive = goutil.findChild(cell.gameObject, "receive")
	local goNotCanGain = goutil.findChild(cell.gameObject, "noPass")
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "txtDesc")
	local layout = goItemcon:GetComponent(ComponentType.UILayoutSingleLine)
	local isGain = DragonpoolModel.instance:isGainPrize(cfg.prizeId)
	local isCanGain = not isGain and self._progress >= cfg.progress

	goutil.setActive(btnGain.gameObject, isCanGain)
	goutil.setActive(goNotCanGain, not isGain and not isCanGain)
	goutil.setActive(goReceive, isGain)

	txtDesc.text = string.format("成功孵蛋%s次", cfg.progress)

	MaterialMgr.resetAll(goItemcon)
	MaterialMgr.setCellListByCfg(cfg.prize, goItemcon)
	layout:Layout()
	btnGain:AddClickListener(function()
		DragonPoolAgent.instance:sendPM_DragonPoolGainPrizeReq(self._activityId, cfg.prizeId)
	end)
end

function DragonpoolrewardView:_clearCell(cell)
	local goItemcon = goutil.findChild(cell.gameObject, "itemcon")

	MaterialMgr.resetAll(goItemcon)
end

return DragonpoolrewardView
