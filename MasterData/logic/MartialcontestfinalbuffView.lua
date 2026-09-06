-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/martialcontest/view/MartialcontestfinalbuffView.lua

module("logic.extensions.martialcontest.view.MartialcontestfinalbuffView", package.seeall)

local MartialcontestfinalbuffView = class("MartialcontestfinalbuffView", ViewComponent)

function MartialcontestfinalbuffView:ctor()
	MartialcontestfinalbuffView.super.ctor(self)
end

function MartialcontestfinalbuffView:unbindEvents()
	MartialcontestfinalbuffView.super.unbindEvents(self)
	self._btnSure:RemoveClickListener()
end

function MartialcontestfinalbuffView:bindEvents()
	MartialcontestfinalbuffView.super.bindEvents(self)
	self._btnSure:AddClickListener(self._onClickbtnSure, self)
end

function MartialcontestfinalbuffView:buildUI()
	MartialcontestfinalbuffView.super.buildUI(self)

	self._btnSure = self:getBtn("btnSure")
	self._tableviewGo = self:getGo("tableview")
	self._tablecellGo = self:getGo("tablecell")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtDesc = self:getTxt("txtDesc")
end

function MartialcontestfinalbuffView:onExit()
	MartialcontestfinalbuffView.super.onExit(self)
	self._scrollerList:dispose()
end

function MartialcontestfinalbuffView:onEnter()
	MartialcontestfinalbuffView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.MCFinalsSetFormationRes, self._onMCFinalsSetFormationRes, self)

	local params = self:getOpenParam()

	self._activityId = params[1]
	self._stepId = params[2]

	local stepCfg = MartialContestConfig.instance:getStepCfg(self._activityId, self._stepId)

	self._maxBuffNum = stepCfg.finalsBuffNum
	self._buffMap = MartialContestController.instance:getFinalsFmtBuffMap(self._activityId)

	self:_updateUI()
end

function MartialcontestfinalbuffView:_onClickbtnSure()
	local buffIds = {}

	for k, v in pairs(self._buffMap) do
		if v then
			table.insert(buffIds, v)
		end
	end

	local realStepId = MartialContestController.instance:getStepIdByNowTime(self._activityId)

	if self._stepId ~= realStepId then
		FloatWordMgr.instance:show("阶段有变化，请重新进入此界面选择Buff")
		self:close()

		return
	end

	if #buffIds > 0 then
		MartialContestController.instance:sendPM_MCFinalsSetBuffReq(self._activityId, buffIds)
	end

	self:close()
end

function MartialcontestfinalbuffView:_updateUI()
	local cfgs = MartialContestConfig.instance:getFinalsBuffCfgs(self._activityId)

	if not cfgs then
		return
	end

	self._scrollerList:reloadData(cfgs)
	self:_updatePointLeft()
end

function MartialcontestfinalbuffView:_updateCell(view, cell, cfg, tag)
	local btn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btn")
	local gouGo = goutil.findChild(cell.gameObject, "gou")
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "View/Viewport/Content")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local buffIconGo = goutil.findChild(cell.gameObject, "buffIcon")

	txtDesc.text = cfg.desc
	txtName.text = cfg.name

	goutil.setActive(gouGo, self._buffMap[cfg.buffId])
	uGuiUtil.setSpriteToImage(buffIconGo, uGuiUtil.SpriteType.BigBg, GameUrl.getExpEventUrl(cfg.icon))
	btn:AddClickListener(function()
		local realStepId = MartialContestController.instance:getStepIdByNowTime(self._activityId)

		if self._stepId ~= realStepId then
			FloatWordMgr.instance:show("阶段有变化，请重新进入此界面选择Buff")

			return
		end

		if self._buffMap[cfg.buffId] then
			self._buffMap[cfg.buffId] = nil
		else
			if table.nums(self._buffMap) >= self._maxBuffNum then
				FloatWordMgr.instance:show("已达到最大祝福数量")

				return
			end

			self._buffMap[cfg.buffId] = cfg.buffId
		end

		self._scrollerList:refresh()
		self:_updatePointLeft()
	end)
end

function MartialcontestfinalbuffView:_clearCell(cell)
	return
end

function MartialcontestfinalbuffView:_updatePointLeft()
	local point = self._maxBuffNum - table.nums(self._buffMap)

	self._txtDesc.text = string.format("剩余可勾选%s个", point)
end

function MartialcontestfinalbuffView:_onMCFinalsSetFormationRes()
	MartialContestAgent.instance:sendPM_MCFinalsGetFormationReq(self._activityId)
end

return MartialcontestfinalbuffView
