-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/monthcard/view/MonthcardrecordView.lua

module("logic.extensions.monthcard.view.MonthcardrecordView", package.seeall)

local MonthcardrecordView = class("MonthcardrecordView", TableViewComponent)

function MonthcardrecordView:ctor()
	MonthcardrecordView.super.ctor(self)
end

function MonthcardrecordView:_getPath()
	return {
		cellPath = "tablecell",
		viewPath = "tableview"
	}
end

function MonthcardrecordView:buildUI()
	MonthcardrecordView.super.buildUI(self)

	self.closeBtn = self:getBtn("top/closeBtn")
	self._tableview.gridWidth = 340
	self._tableview.gridHeight = 50
	self._tableview.adjustLastCellSize = 20
end

function MonthcardrecordView:bindEvents()
	MonthcardrecordView.super.bindEvents(self)
end

function MonthcardrecordView:unbindEvents()
	MonthcardrecordView.super.unbindEvents(self)
end

function MonthcardrecordView:destroyUI()
	MonthcardrecordView.super.destroyUI(self)
end

function MonthcardrecordView:onEnter()
	MonthcardrecordView.super.onEnter(self)
	self.closeBtn:AddClickListener(self.onClickClose, self)
	GlobalDispatcher:addListener(MonthCardModel.GetRecordSuccessed, self.refreshView, self)
	MonthCardController.instance:sendPM_DailyBonusRecordReq()
end

function MonthcardrecordView:onEnterFinished()
	MonthcardrecordView.super.onEnterFinished(self)
end

function MonthcardrecordView:onExit()
	MonthcardrecordView.super.onExit(self)
	self.closeBtn:RemoveClickListener()
	GlobalDispatcher:removeListener(MonthCardModel.GetRecordSuccessed, self.refreshView, self)
end

function MonthcardrecordView:onExitFinished()
	MonthcardrecordView.super.onExitFinished(self)
end

function MonthcardrecordView:_updateCell(view, cell, data)
	local nameText = goutil.findChildTextComponent(cell.gameObject, "nameText")
	local getText = goutil.findChildTextComponent(cell.gameObject, "getText")
	local timeText = goutil.findChildTextComponent(cell.gameObject, "timeText")
	local cfg = MonthCardConfig.instance:getCfgById(data.cardId)

	nameText.text = cfg.cardName

	local date = GameUtil.time2date(data.gainTime / 1000)

	timeText.text = string.format("%s-%s-%s %s:%s:%s", date.year, self:addZero(date.month), self:addZero(date.day), self:addZero(date.hour), self:addZero(date.min), self:addZero(date.sec))

	local arr = string.split(cfg.dailyGain, ":")
	local gcfg = MaterialFacade.instance:getMatCfg(arr[1], arr[2])

	getText.text = gcfg.name .. "*" .. arr[3]
end

function MonthcardrecordView:addZero(num)
	return (num < 10 or nil) and ("0" .. num or num)
end

function MonthcardrecordView:onClickClose()
	self:close()
end

function MonthcardrecordView:refreshView(list)
	self._curViewDatas = {}

	for i, v in ipairs(list) do
		table.insert(self._curViewDatas, v)
	end

	table.sort(self._curViewDatas, function(a, b)
		return a.gainTime > b.gainTime
	end)
	self:reloadData()
end

return MonthcardrecordView
