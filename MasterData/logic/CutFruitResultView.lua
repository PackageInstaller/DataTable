-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godlongyan/view/cutfruit/CutFruitResultView.lua

module("logic.extensions.godlongyan.view.cutfruit.CutFruitResultView", package.seeall)

local CutFruitResultView = class("CutFruitResultView", ViewComponent)

function CutFruitResultView:ctor()
	CutFruitResultView.super.ctor(self)
end

function CutFruitResultView:buildUI()
	CutFruitResultView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._txtCount = goutil.findChildTextComponent(self.mainGO, "selectCount/txtCount")
	self._rewardView = goutil.findChild(self.mainGO, "rewardCol/rewardView")
	self._rewardCell = goutil.findChild(self.mainGO, "rewardCol/rewardCell")
	self._rewardScrollList = ScrollerList.create(self._rewardView, self._rewardCell, GameUtil.handler(self._updateRewardCell, self), GameUtil.handler(self._clearRewardCell, self))
end

function CutFruitResultView:bindEvents()
	CutFruitResultView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self._onClickClose, self)
end

function CutFruitResultView:unbindEvents()
	CutFruitResultView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function CutFruitResultView:destroyUI()
	CutFruitResultView.super.destroyUI(self)
end

function CutFruitResultView:onEnter()
	CutFruitResultView.super.onEnter(self)

	local params = self:getOpenParam()

	if params == nil then
		self:close()

		return
	end

	self._changesetId = checknumber(params[1])
	self._itemStrList = params[2] or {}

	self:_onSetUI()
end

function CutFruitResultView:onExit()
	CutFruitResultView.super.onExit(self)
	self._rewardScrollList:dispose()
end

function CutFruitResultView:_onSetUI()
	if self._txtCount then
		self._txtCount.text = GodLongYanModel.instance:getGameScore() .. "个"
	end

	self:_onUpdateRewardScrollerList()
end

function CutFruitResultView:_onUpdateRewardScrollerList()
	local list = {}

	for _, itemStr in ipairs(self._itemStrList) do
		local data = {}

		data.itemStr = itemStr

		table.insert(list, data)
	end

	self._rewardScrollList:reloadData(list)
end

function CutFruitResultView:_updateRewardCell(view, cell, data, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(data.itemStr, mainGo)
end

function CutFruitResultView:_clearRewardCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

function CutFruitResultView:_onClickClose()
	self:close()
	MaterialController.instance:showChangeSetInTemp(self._changesetId)
end

return CutFruitResultView
