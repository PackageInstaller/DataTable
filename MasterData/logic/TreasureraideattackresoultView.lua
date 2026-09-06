-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/treasureraider/view/TreasureraideattackresoultView.lua

module("logic.extensions.treasureraider.view.TreasureraideattackresoultView", package.seeall)

local TreasureraideattackresoultView = class("TreasureraideattackresoultView", ViewComponent)

function TreasureraideattackresoultView:ctor()
	TreasureraideattackresoultView.super.ctor(self)
end

function TreasureraideattackresoultView:unbindEvents()
	TreasureraideattackresoultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
	GameUtil.rmClickHandler(self._btnSure)
end

function TreasureraideattackresoultView:bindEvents()
	TreasureraideattackresoultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
	GameUtil.addClickHandler(self._btnSure, self.close, self)
end

function TreasureraideattackresoultView:buildUI()
	TreasureraideattackresoultView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._btnSure = self:getGo("btnSure")
	self._txtEmpty = self:getTxt("txtEmpty")

	local rewardTableView = self:getGo("reward/tableview")
	local rewardCell = self:getGo("reward/item")

	self._rewardList = ScrollerList.create(rewardTableView, rewardCell, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
end

function TreasureraideattackresoultView:onExit()
	TreasureraideattackresoultView.super.onExit(self)
	self._rewardList:dispose()
end

function TreasureraideattackresoultView:onEnter()
	TreasureraideattackresoultView.super.onEnter(self)

	local prize = self:getFirstParam()

	GameUtil.SetActive(self._txtEmpty, #prize <= 0)
	self._rewardList:reloadData(prize)
	self._rewardList:refresh()
end

function TreasureraideattackresoultView:_updateRewardCell(view, goCell, data)
	MaterialMgr.resetAll(goCell)

	local proxy = MaterialMgr.setCellByCfg(data, goCell.gameObject)

	if proxy then
		local _, _, num = MaterialMgr.getMatParams(data or "")

		proxy:setNumStr(StringUtil.numberToString(num or 0))
	end
end

function TreasureraideattackresoultView:_clearRewardCell(goCell)
	MaterialMgr.resetAll(goCell)
end

return TreasureraideattackresoultView
