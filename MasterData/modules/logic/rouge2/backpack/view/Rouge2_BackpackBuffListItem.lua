-- chunkname: @modules/logic/rouge2/backpack/view/Rouge2_BackpackBuffListItem.lua

module("modules.logic.rouge2.backpack.view.Rouge2_BackpackBuffListItem", package.seeall)

local Rouge2_BackpackBuffListItem = class("Rouge2_BackpackBuffListItem", LuaCompBase)
local ScrollMaxShowItemNum = 4
local DealyShowItemTime = 0.03

function Rouge2_BackpackBuffListItem:init(go)
	self.go = go
	self._goRoot = gohelper.findChild(self.go, "go_Root")
	self._goCheck = gohelper.findChild(self.go, "go_Check")
	self._canvasgroup = gohelper.onceAddComponent(self.go, gohelper.Type_CanvasGroup)
end

function Rouge2_BackpackBuffListItem:initParent(view, goScroll)
	if not self._comBuffItem then
		local goBuff = view:getResInst(Rouge2_Enum.ResPath.ComBuffItem, self._goRoot)

		self._comBuffItem = Rouge2_CommonBuffItem.Get(goBuff)

		self._comBuffItem:initDescModeFlag(Rouge2_Enum.ItemDescModeDataKey.BackpackBuff)
	end

	if not self._reddotComp then
		local goReddot = self._comBuffItem:getReddotGo()

		self._reddotComp = Rouge2_BackpackItemReddotComp.Get(goReddot, self._goCheck, goScroll)
	end
end

function Rouge2_BackpackBuffListItem:addEventListeners()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, Rouge2_Controller.instance, Rouge2_Event.OnScrollBuffBag, self._onScrollBuffBag, self)
end

function Rouge2_BackpackBuffListItem:removeEventListeners()
	return
end

function Rouge2_BackpackBuffListItem:onUpdateMO(index, buffMo)
	self._index = index
	self._buffMo = buffMo
	self._buffUid = buffMo and buffMo:getUid()
	self._buffId = buffMo and buffMo:getItemId()

	self._comBuffItem:onUpdateMO(Rouge2_Enum.ItemDataType.Server, self._buffUid)

	local reddotId = Rouge2_Enum.BagTabType2Reddot[Rouge2_Enum.BagTabType.Buff]

	self._reddotComp:intReddotInfo(reddotId, self._buffMo:getUid())
	self:showOpenAnim()
end

function Rouge2_BackpackBuffListItem:showOpenAnim()
	self._isNeedOpenAnim = self._index <= ScrollMaxShowItemNum

	gohelper.setActiveCanvasGroupNoAnchor(self._canvasgroup, false)
	TaskDispatcher.cancelTask(self.playOpenAnim, self)

	if self._isNeedOpenAnim then
		TaskDispatcher.runDelay(self.playOpenAnim, self, (self._index - 1) * DealyShowItemTime)
	else
		self:playOpenAnim()
	end
end

function Rouge2_BackpackBuffListItem:playOpenAnim()
	gohelper.setActiveCanvasGroupNoAnchor(self._canvasgroup, true)

	if self._isNeedOpenAnim then
		self._comBuffItem:playAnim("open")
	end
end

function Rouge2_BackpackBuffListItem:_onScrollBuffBag()
	self._reddotComp:refresh()
end

function Rouge2_BackpackBuffListItem:_onCloseView(viewName)
	if viewName ~= ViewName.Rouge2_BackpackTabView then
		return
	end

	self._comBuffItem:playAnim("close")
end

function Rouge2_BackpackBuffListItem:onDestroy()
	TaskDispatcher.cancelTask(self.playOpenAnim, self)
end

return Rouge2_BackpackBuffListItem
