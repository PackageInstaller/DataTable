-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/powerland/view/PowerLandPrizeView.lua

module("logic.extensions.powerland.view.PowerLandPrizeView", package.seeall)

local PowerLandPrizeView = class("PowerLandPrizeView", ViewComponent)

function PowerLandPrizeView:ctor()
	PowerLandPrizeView.super.ctor(self)
end

function PowerLandPrizeView:buildUI()
	PowerLandPrizeView.super.buildUI(self)

	self._btnClose = goutil.findChild(self.mainGO, "btnClose")
	self._txtTitle = goutil.findChildTextComponent(self.mainGO, "txtTitle")
	self._prizeScrollerview = goutil.findChild(self.mainGO, "prizeCol/prizeScrollerview")
	self._prizeScrollercell = goutil.findChild(self.mainGO, "prizeCol/prizeScrollercell")
	self._itemScrollercell = goutil.findChild(self.mainGO, "prizeCol/itemScrollercell")
	self._prizeScrollList = ScrollerList.create(self._prizeScrollerview, self._prizeScrollercell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))
	self._itemScrollListDic = {}
end

function PowerLandPrizeView:bindEvents()
	PowerLandPrizeView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function PowerLandPrizeView:unbindEvents()
	PowerLandPrizeView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function PowerLandPrizeView:onEnter()
	PowerLandPrizeView.super.onEnter(self)

	self._prizeDataList = self:getFirstParam()

	if self._prizeDataList == nil then
		printError("传入参数为空,界面关闭")
		self:close()

		return
	end

	self:_onUpdateUI()
end

function PowerLandPrizeView:onExit()
	PowerLandPrizeView.super.onExit(self)
	self._prizeScrollList:dispose()
end

function PowerLandPrizeView:_onUpdateUI()
	self:_updatePrizeScrollerList()
	self:_onUpdatePlaneUI()
end

function PowerLandPrizeView:_onUpdatePlaneUI()
	return
end

function PowerLandPrizeView:_updatePrizeScrollerList()
	self._prizeScrollList:reloadData(self._prizeDataList)
end

function PowerLandPrizeView:_updatePrizeCell(view, cell, data, tag)
	local mainGo = cell.gameObject
	local txtTitle = goutil.findChildTextComponent(mainGo, "txtTitle")
	local itemScrollerview = goutil.findChild(mainGo, "itemScrollerview")

	txtTitle.text = data.txtTitle

	local prizeStrArr = string.split(data.prizeStrList, "#")

	if not self._itemScrollListDic[mainGo] then
		local itemScrollList = ScrollerList.create(itemScrollerview, self._itemScrollercell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

		self._itemScrollListDic[mainGo]:reloadData(prizeStrArr)
		self._itemScrollListDic[mainGo]:dragNotifyParent()
	end
end

function PowerLandPrizeView:_clearPrizeCell(cell)
	local mainGo = cell.gameObject
	local itemScrollList = self._itemScrollListDic[mainGo]

	if itemScrollList then
		itemScrollList:dispose()

		self._itemScrollListDic[mainGo] = nil
	end
end

function PowerLandPrizeView:_updateItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.setCellByCfg(prizeStr, item, urlOrGo, luaCls, isOne)
end

function PowerLandPrizeView:_clearItemCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")

	MaterialMgr.resetAll(item)
end

return PowerLandPrizeView
