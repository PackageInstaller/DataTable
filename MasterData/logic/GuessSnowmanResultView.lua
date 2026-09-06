-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guesssnowman/view/GuessSnowmanResultView.lua

module("logic.extensions.guessbox.view.GuessSnowmanResultView", package.seeall)

local GuessSnowmanResultView = class("GuessSnowmanResultView", ViewComponent)

function GuessSnowmanResultView:ctor()
	GuessSnowmanResultView.super.ctor(self)
end

function GuessSnowmanResultView:buildUI()
	GuessSnowmanResultView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._txtCount = goutil.findChildTextComponent(self.mainGO, "selectCount/txtCount")
	self._rewardView = goutil.findChild(self.mainGO, "rewardCol/rewardView")
	self._rewardCell = goutil.findChild(self.mainGO, "rewardCol/rewardCell")
	self._doubleTag = goutil.findChild(self.mainGO, "tag")
	self._rewardScrollList = ScrollerList.create(self._rewardView, self._rewardCell, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
end

function GuessSnowmanResultView:bindEvents()
	GuessSnowmanResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
end

function GuessSnowmanResultView:unbindEvents()
	GuessSnowmanResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function GuessSnowmanResultView:destroyUI()
	GuessSnowmanResultView.super.destroyUI(self)
end

function GuessSnowmanResultView:onEnter()
	GuessSnowmanResultView.super.onEnter(self)

	local params = self:getOpenParam()

	self._changesetId = checknumber(params[1])
	self._itemStrList = params[2] or {}
	self._isDouble = params[3] or false

	GameUtil.SetActive(self._doubleTag, self._isDouble)
	self:_onSetUI()
end

function GuessSnowmanResultView:onExit()
	GuessSnowmanResultView.super.onExit(self)
	self._rewardScrollList:dispose()
end

function GuessSnowmanResultView:_onSetUI()
	local correctGuestNum = GuessBoxModel.instance:getGameScore()

	if self._txtCount then
		self._txtCount.text = correctGuestNum
	end

	self:_onUpdateRewardScrollerList()
end

function GuessSnowmanResultView:_onUpdateRewardScrollerList()
	local list = {}

	for _, itemStr in ipairs(self._itemStrList) do
		local data = {}

		data.itemStr = itemStr

		table.insert(list, data)
	end

	self._rewardScrollList:reloadData(list)
end

function GuessSnowmanResultView:_updateRewardCell(view, cell, data, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(data.itemStr, mainGo)
end

function GuessSnowmanResultView:_clearRewardCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

function GuessSnowmanResultView:_onClickClose()
	self:close()
	UIStateManager.instance:popByName(ViewName.GuessSnowmanGameView)
	UIStateManager.instance:popByName(ViewName.GuessSnowmanSelectView)
	MaterialController.instance:showChangeSetInTemp(self._changesetId)
end

return GuessSnowmanResultView
