-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newhandwelfare/view/NewHandWelfareOnlineDetailView.lua

module("logic.extensions.newhandwelfare.view.NewHandWelfareOnlineDetailView", package.seeall)

local NewHandWelfareOnlineDetailView = class("NewHandWelfareOnlineDetailView", ViewComponent)

function NewHandWelfareOnlineDetailView:buildUI()
	NewHandWelfareOnlineDetailView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")

	local prizeScrView = goutil.findChild(self.mainGO, "prizeCol/scrView")
	local prizeScrCell = goutil.findChild(self.mainGO, "prizeCol/scrCell")

	self._prizeScrollerList = ScrollerList.create(prizeScrView, prizeScrCell, GameUtil.handler(self._updatePrizeCell, self), GameUtil.handler(self._clearPrizeCell, self))
end

function NewHandWelfareOnlineDetailView:bindEvents()
	NewHandWelfareOnlineDetailView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function NewHandWelfareOnlineDetailView:unbindEvents()
	NewHandWelfareOnlineDetailView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function NewHandWelfareOnlineDetailView:onEnter()
	NewHandWelfareOnlineDetailView.super.onEnter(self)

	local params = self:getOpenParam() or {}

	self._periodId = checknumber(params[1])

	if self._periodId <= 0 then
		self:close()

		return
	end

	self.addGEvent(self, NewhandwelfareController.NewHandWelfareGetInfoRes, self._onUpdateUI, self)
	self:_onUpdateUI()
end

function NewHandWelfareOnlineDetailView:onExit()
	NewHandWelfareOnlineDetailView.super.onExit(self)
	self._prizeScrollerList:dispose()
end

function NewHandWelfareOnlineDetailView:_onUpdateUI()
	local cfgs = NewhandwelfareConfig.instance:getOnlineRewardCfgs(self._periodId) or {}
	local list = {}

	for days, cfg in pairs(cfgs) do
		local info = {}

		info.days = days
		info.cfg = cfg

		table.insert(list, info)
	end

	table.sort(list, function(a, b)
		return a.days < b.days
	end)
	self._prizeScrollerList:reloadData(list)
end

function NewHandWelfareOnlineDetailView:_updatePrizeCell(view, cell, info, tag)
	local days = info.days
	local cfg = info.cfg
	local mainGo = cell.gameObject
	local index = cell.data
	local bg = goutil.findChild(mainGo, "bg")
	local txtDay = goutil.findChildTextComponent(mainGo, "txtDay")
	local itemScrView = goutil.findChild(mainGo, "itemScrView")
	local itemScrCell = goutil.findChild(mainGo, "itemScrCell")

	txtDay.text = string.format("第%s天", days)

	GameUtil.SetActive(bg, index % 2 == 1)

	if itemScrView and itemScrCell then
		self._itemScrollerListDic = self._itemScrollerListDic or {}

		local prizeStrArr = {}

		for i, v in ipairs(cfg) do
			table.insert(prizeStrArr, v.prize)
		end

		if not self._itemScrollerListDic[mainGo] then
			local itemScrollList = ScrollerList.create(itemScrView, itemScrCell, GameUtil.handler(self._updateItemCell, self), GameUtil.handler(self._clearItemCell, self))

			self._itemScrollerListDic[mainGo] = self._itemScrollerListDic[mainGo]

			self._itemScrollerListDic[mainGo]:reloadData(prizeStrArr)
			self._itemScrollerListDic[mainGo]:dragNotifyParent()
		end
	end
end

function NewHandWelfareOnlineDetailView:_clearPrizeCell(cell)
	local mainGo = cell.gameObject

	if self._itemScrollerListDic then
		if self._itemScrollerListDic then
			self._itemScrollerListDic:dispose()

			self._itemScrollerListDic[mainGo] = nil
		end
	end
end

function NewHandWelfareOnlineDetailView:_updateItemCell(view, cell, prizeStr, tag)
	local mainGo = cell.gameObject

	MaterialMgr.setCellByCfg(prizeStr, mainGo)
end

function NewHandWelfareOnlineDetailView:_clearItemCell(cell)
	local mainGo = cell.gameObject

	MaterialMgr.resetAll(mainGo)
end

return NewHandWelfareOnlineDetailView
