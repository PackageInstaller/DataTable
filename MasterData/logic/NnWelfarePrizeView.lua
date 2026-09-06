-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/niannianwelfare/view/NnWelfarePrizeView.lua

module("logic.extensions.niannianwelfare.view.NnWelfarePrizeView", package.seeall)

local NnWelfarePrizeView = class("NnWelfarePrizeView", ViewComponent)

function NnWelfarePrizeView:unbindEvents()
	NnWelfarePrizeView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function NnWelfarePrizeView:bindEvents()
	NnWelfarePrizeView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
end

function NnWelfarePrizeView:buildUI()
	NnWelfarePrizeView.super.buildUI(self)

	self._closeBtn = self:getBtn("btnClose")
	self._cell = self:getGo("tablecell")
	self._view = ScrollerList.create(self:getGo("tableview"), self._cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function NnWelfarePrizeView:onExit()
	NnWelfarePrizeView.super.onExit(self)
	self._view:dispose()
	GlobalDispatcher:removeListener(NianNianWelfareController.PM_NianNianBenefitsAchievementPrizeRes, self._handlePM_NianNianBenefitsAchievementPrizeRes, self)
end

function NnWelfarePrizeView:onEnter()
	NnWelfarePrizeView.super.onEnter(self)

	local openParam = self:getOpenParam()

	self._actId = openParam[1]
	self._achievementPlan = openParam[2]

	GlobalDispatcher:addListener(NianNianWelfareController.PM_NianNianBenefitsAchievementPrizeRes, self._handlePM_NianNianBenefitsAchievementPrizeRes, self)

	self._data = clone(NianNianWelfareConfig.instance:getAchievementByPlanId(self._achievementPlan))

	self:_updateData()

	self._cellProxy = {}

	self._view:reloadData(self._data)
end

function NnWelfarePrizeView:_updateData()
	local stoveInfo = NianNianWelfareModel.instance:getPartInfo()

	for i, v in ipairs(self._data) do
		v.state = NianNianWelfareModel.instance:isGainAchievementPrizeById(v.achievementId) and 3 or v.totalGrade <= stoveInfo.lv and 1 or 2
	end

	table.sort(self._data, function(a, b)
		return a.state < b.state
	end)

	self._data = ArraySort.sortOn(self._data, {
		"state",
		"achievementId"
	})
end

function NnWelfarePrizeView:_handlePM_NianNianBenefitsAchievementPrizeRes()
	self:_updateData()
	self._view:refresh(self._data)
end

function NnWelfarePrizeView:_updateCell(view, cell, data)
	goutil.setActive(goutil.findChild(cell.gameObject, "notFinish"), data.state == 2)
	goutil.setActive(goutil.findChild(cell.gameObject, "received"), data.state == 3)

	local receiveBtn = Framework.ButtonAdapter.GetFrom(cell.gameObject, "btnReceive")

	goutil.setActive(receiveBtn.gameObject, data.state == 1)
	receiveBtn:AddClickListener(function()
		NianNianWelfareController.instance:sendPM_NianNianBenefitsAchievementPrizeReq(self._actId, data.achievementId)
	end)

	goutil.findChildTextComponent(cell.gameObject, "txtDesc").text = string.format(lang("nian_welfare_achievement_task_desc"), data.totalGrade)

	if self._cellProxy[cell] == nil then
		self._cellProxy[cell] = MaterialMgr.setCellByCfg(data.achievementPrize, goutil.findChild(cell.gameObject, "item"))
	else
		local matType, id, num = MaterialMgr.getMatParams(data.achievementPrize)

		self._cellProxy[cell]:initCfg(matType, id)
		self._cellProxy[cell].binder:setNum(num)
	end
end

function NnWelfarePrizeView:_clearCell(cell)
	MaterialMgr.resetAll(goutil.findChild(cell.gameObject, "item"))
end

return NnWelfarePrizeView
