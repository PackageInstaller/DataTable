-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newhandcard/view/NewhandcardrecordView.lua

module("logic.extensions.newhandcard.view.NewhandcardrecordView", package.seeall)

local NewhandcardrecordView = class("NewhandcardrecordView", TableViewComponent)

function NewhandcardrecordView:ctor()
	NewhandcardrecordView.super.ctor(self)
end

function NewhandcardrecordView:_getPath()
	return {
		cellPath = "tablecell",
		viewPath = "tableview"
	}
end

function NewhandcardrecordView:buildUI()
	NewhandcardrecordView.super.buildUI(self)

	self._toptitleText = goutil.findChildTextComponent(self.mainGO, "top/text")
	self._toptitleText.text = "新手卡每日奖励记录"
	self._titleText = goutil.findChildTextComponent(self.mainGO, "title/text")
	self._titleText.text = "新手卡类型"
	self._closeBtn = self:getBtn("top/closeBtn")
	self._tableview.gridWidth = 340
	self._tableview.gridHeight = 50
	self._tableview.adjustLastCellSize = 20
end

function NewhandcardrecordView:bindEvents()
	NewhandcardrecordView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
end

function NewhandcardrecordView:unbindEvents()
	NewhandcardrecordView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function NewhandcardrecordView:destroyUI()
	NewhandcardrecordView.super.destroyUI(self)
end

function NewhandcardrecordView:onEnter()
	NewhandcardrecordView.super.onEnter(self)
	GlobalDispatcher:addListener(NewHandCardAgent.NewHandCardInfoRes, self._updateView, self)
	self:_updateView()
end

function NewhandcardrecordView:onEnterFinished()
	NewhandcardrecordView.super.onEnterFinished(self)
end

function NewhandcardrecordView:onExit()
	NewhandcardrecordView.super.onExit(self)
	GlobalDispatcher:removeListener(NewHandCardAgent.NewHandCardInfoRes, self._updateView, self)
end

function NewhandcardrecordView:onExitFinished()
	NewhandcardrecordView.super.onExitFinished(self)
end

function NewhandcardrecordView:_updateCell(view, cell, gainTime)
	local nameText = goutil.findChildTextComponent(cell.gameObject, "nameText")
	local getText = goutil.findChildTextComponent(cell.gameObject, "getText")
	local timeText = goutil.findChildTextComponent(cell.gameObject, "timeText")

	nameText.text = self._cfg.name

	local date = GameUtil.time2date(gainTime / 1000)

	timeText.text = string.format("%s-%s-%s %s:%s:%s", date.year, self:addZero(date.month), self:addZero(date.day), self:addZero(date.hour), self:addZero(date.min), self:addZero(date.sec))

	local arr = string.split(self._cfg.dailyGain, ":")
	local gcfg = MaterialFacade.instance:getMatCfg(arr[1], arr[2])

	getText.text = gcfg.name .. "*" .. arr[3]
end

function NewhandcardrecordView:addZero(num)
	return (num < 10 or nil) and ("0" .. num or num)
end

function NewhandcardrecordView:_updateView()
	self._cfg = NewHandCardConfig.instance:getCfgById(1)

	local list = NewHandCardModel.instance:getGainTimes()

	self._curViewDatas = {}

	for i, v in ipairs(list) do
		table.insert(self._curViewDatas, checknumber(v))
	end

	table.sort(self._curViewDatas, function(a, b)
		return b < a
	end)
	self:reloadData()
end

return NewhandcardrecordView
