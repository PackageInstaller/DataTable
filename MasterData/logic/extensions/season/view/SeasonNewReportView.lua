-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonNewReportView.lua

module("logic.extensions.season.view.SeasonNewReportView", package.seeall)

local M = class("SeasonNewReportView", ViewComponent)
local SeasonNewReportCell = class("SeasonNewReportCell")

function SeasonNewReportCell:ctor(compContainer)
	self._mainGO = compContainer.gameObject

	self:_buildUI()
end

function SeasonNewReportCell:OnDestroy()
	return
end

function SeasonNewReportCell:_buildUI()
	self._txtTitle = goutil.findChildTextComponent(self._mainGO, "txtTile")
	self._txtNum1 = goutil.findChildTextComponent(self._mainGO, "txtContent")
	self._txtQuantifier1 = goutil.findChildTextComponent(self._mainGO, "txtContent/txtContent2")
	self._txtNum2 = goutil.findChildTextComponent(self._mainGO, "txtContent/txtContent2/txtContent3")
	self._txtQuantifier2 = goutil.findChildTextComponent(self._mainGO, "txtContent/txtContent2/txtContent3/txtContent4")

	goutil.setActive(self._txtNum2.gameObject, false)
end

function SeasonNewReportCell:setData(mo)
	self._txtTitle.text = mo:getDesc()
	self._txtNum1.text = mo:getTodayNum()
	self._txtQuantifier1.text = mo:getQuantifier()
end

function M:ctor()
	return
end

function M:buildUI()
	self._btnClose = self:getBtn("common_full_tips_bg_1933710455")
	self._txtActive = self:getTextByPath("txtActive")
	self._goScrollContent = self:getGoByPath("scrollView/ViewPort/content")
	self._goReportItem = goutil.findChild(self._goScrollContent, "secret_time_judge_report_item")
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickBtnClose, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
end

function M:onEnter()
	self._arrayReportItem = {}

	self:refreshView()
end

function M:onExit()
	self:_clearReportItem()
end

function M:refreshView()
	self._txtActive.text = SeasonModel.instance:getTodayScore()

	local reportList = SeasonModel.instance:getReportTasks()
	local len = #reportList

	for idx, mo in ipairs(reportList) do
		local item = self:_getReportItem(idx)
		local shower = Astral.LuaComponentContainer.Get(item, SeasonNewReportCell)

		shower:setData(mo)
	end

	if len < #self._arrayReportItem then
		for i = len + 1, #self._arrayReportItem do
			local item = self._arrayReportItem[i]

			goutil.setActive(item, false)
		end
	end
end

function M:_getReportItem(idx)
	local item = self._arrayReportItem[idx]

	if not item then
		item = goutil.clone(self._goReportItem)

		goutil.addChildToParent(item, self._goScrollContent)
		Astral.LuaComponentContainer.Add(item, SeasonNewReportCell)

		self._arrayReportItem[idx] = item
	end

	goutil.setActive(item, true)

	return item
end

function M:_clearReportItem()
	for _, item in pairs(self._arrayReportItem) do
		goutil.destroy(item)
	end

	self._arrayReportItem = nil
end

function M:_onClickBtnClose()
	self:close()
end

return M
