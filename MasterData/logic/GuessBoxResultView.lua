-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guessbox/view/GuessBoxResultView.lua

module("logic.extensions.guessbox.view.GuessBoxResultView", package.seeall)

local GuessBoxResultView = class("GuessBoxResultView", ViewComponent)

function GuessBoxResultView:ctor()
	GuessBoxResultView.super.ctor(self)
end

function GuessBoxResultView:buildUI()
	GuessBoxResultView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._txtCount = goutil.findChildTextComponent(self.mainGO, "selectCount/txtCount")
	self._rewardView = goutil.findChild(self.mainGO, "rewardCol/rewardView")
	self._rewardCell = goutil.findChild(self.mainGO, "rewardCol/rewardCell")
	self._rewardScrollList = ScrollerList.create(self._rewardView, self._rewardCell, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
end

function GuessBoxResultView:bindEvents()
	GuessBoxResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
end

function GuessBoxResultView:unbindEvents()
	GuessBoxResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function GuessBoxResultView:destroyUI()
	GuessBoxResultView.super.destroyUI(self)
end

function GuessBoxResultView:onEnter()
	GuessBoxResultView.super.onEnter(self)

	local params = self:getOpenParam()

	if params == nil then
		self:close()

		return
	end

	self._changesetId = checknumber(params[1])
	self._itemStrList = params[2] or {}

	self:_onSetUI()
end

function GuessBoxResultView:onExit()
	GuessBoxResultView.super.onExit(self)
	self._rewardScrollList:dispose()
end

function GuessBoxResultView:_onSetUI()
	local correctGuestNum = GuessBoxController.instance:getCorrectGuestNum()

	if self._txtCount then
		self._txtCount.text = correctGuestNum
	end

	self:_onUpdateRewardScrollerList()
end

function GuessBoxResultView:_onUpdateRewardScrollerList()
	local list = {}

	for _, itemStr in ipairs(self._itemStrList) do
		local data = {}

		data.itemStr = itemStr

		table.insert(list, data)
	end

	self._rewardScrollList:reloadData(list)
end

function GuessBoxResultView:_updateRewardCell(view, cell, data, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(data.itemStr, mainGo)
end

function GuessBoxResultView:_clearRewardCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

function GuessBoxResultView:_onClickClose()
	self:close()
	MaterialController.instance:showChangeSetInTemp(self._changesetId)
end

return GuessBoxResultView
