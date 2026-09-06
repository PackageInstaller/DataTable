-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/run2023/view/Run2023ResultView.lua

module("logic.extensions.run2023.view.Run2023ResultView", package.seeall)

local Run2023ResultView = class("Run2023ResultView", ViewComponent)

function Run2023ResultView:ctor()
	Run2023ResultView.super.ctor(self)
end

function Run2023ResultView:unbindEvents()
	Run2023ResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function Run2023ResultView:bindEvents()
	Run2023ResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
end

function Run2023ResultView:buildUI()
	Run2023ResultView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._txtTime = self:getTxt("panel/txtTime")
	self._imgL_2 = self:getGo("panel/imgL_2")
	self._txtReward = self:getGo("panel/txtReward")
	self._tableview = self:getGo("panel/reward/rewardView")
	self._tablecell = self:getGo("panel/reward/rewardCell")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function Run2023ResultView:onExit()
	Run2023ResultView.super.onExit(self)
	self._scrollList:dispose()
end

function Run2023ResultView:onEnter()
	Run2023ResultView.super.onEnter(self)

	local params = self:getOpenParam()

	if params == nil then
		self:close()

		return
	end

	self._changesetId = checknumber(params[1])
	self._itemStrList = params[2] or {}
	self._gamingTime = checknumber(params[3])
	self._isDemo = params[4]

	local list = {}

	for _, itemStr in ipairs(self._itemStrList) do
		local data = {}

		data.itemStr = itemStr

		table.insert(list, data)
	end

	GameUtil.SetActive(self._imgL_2, not self._isDemo)
	GameUtil.SetActive(self._txtReward, not self._isDemo)

	if not self._isDemo then
		self._scrollList:reloadData(list)
	end

	self._txtTime.text = string.format("完成时间：<color=#EB4A46FF>%d</color>秒", self._gamingTime)
end

function Run2023ResultView:_updateCell(view, goCell, data, tag)
	local cell = self:_clearCell(goCell)

	MaterialMgr.setCellByCfg(data.itemStr, cell.go)
end

function Run2023ResultView:_clearCell(goCell)
	local cell = {}

	cell.go = goCell

	MaterialMgr.resetAll(cell.go)

	return cell
end

function Run2023ResultView:_onClickClose()
	self:close()

	if self._changesetId ~= 0 then
		MaterialController.instance:showChangeSetInTemp(self._changesetId)
	end
end

return Run2023ResultView
