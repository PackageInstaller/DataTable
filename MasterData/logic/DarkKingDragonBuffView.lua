-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinedarkkingdragonclg/view/DarkKingDragonBuffView.lua

module("logic.extensions.divinedarkkingdragonclg.view.DarkKingDragonBuffView", package.seeall)

local DarkKingDragonBuffView = class("DarkKingDragonBuffView", ViewComponent)

function DarkKingDragonBuffView:ctor()
	DarkKingDragonBuffView.super.ctor(self)
end

function DarkKingDragonBuffView:unbindEvents()
	DarkKingDragonBuffView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function DarkKingDragonBuffView:bindEvents()
	DarkKingDragonBuffView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function DarkKingDragonBuffView:buildUI()
	DarkKingDragonBuffView.super.buildUI(self)

	self._btnClose = self:getGo("container/btnClose")

	local goTab = self:getGo("container/desc/tableview")
	local goCell = self:getGo("container/desc/tableview/tablecell")

	self._tableView = ScrollerList.create(goTab, goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function DarkKingDragonBuffView:onExit()
	DarkKingDragonBuffView.super.onExit(self)
	self._tableView:dispose()
end

function DarkKingDragonBuffView:onEnter()
	DarkKingDragonBuffView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.PM_DivineDarkKingDragonClgInfoRes, self._updateUIByInfo, self)

	self._activityId = 526001

	local params = self:getOpenParam()

	if params then
		self._activityId = checknumber(params[1])
	end

	self:_updateUIByCfg()
	self:_updateUIByInfo()
	DivineDarkKingDragonClgController.instance:getInfo(self._activityId)
end

function DarkKingDragonBuffView:_updateUIByCfg()
	local buffCfgs = DivineDarkKingDragonClgConfig.instance:getBuffCfgList(self._activityId) or {}

	self._datalist = {}

	for i, cfg in ipairs(buffCfgs) do
		local data = {}

		data.sortId = i
		data.cfg = cfg

		table.insert(self._datalist, data)
	end
end

function DarkKingDragonBuffView:_updateUIByInfo()
	self._curBuffNum = DivineDarkKingDragonClgModel.instance:getCurBuffNum(self._activityId)
	self._curActSortId = 0

	for i, data in ipairs(self._datalist) do
		if self._curBuffNum >= data.cfg.num then
			self._curActSortId = i
		end
	end

	self._tableView:reloadData(self._datalist)
end

function DarkKingDragonBuffView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local bg = goutil.findChild(go, "bg")
	local markAct = goutil.findChild(go, "markAct")
	local txtDesc = goutil.findChildTextComponent(go, "txtDesc")
	local txtNum = goutil.findChildTextComponent(go, "txtNum")

	goutil.setActive(bg, data.sortId % 2 == 0)
	goutil.setActive(markAct, data.sortId == self._curActSortId)

	local cfg = data.cfg

	txtNum.text = self:_getNum(data.sortId)
	txtDesc.text = data.sortId == self._curActSortId and string.format("<color=#%s>%s</color>", "34FF72FF", cfg.desc or "") or cfg.desc or ""
end

function DarkKingDragonBuffView:_clearCell(cell)
	return
end

function DarkKingDragonBuffView:_getNum(sortId)
	local curData = self._datalist[sortId]
	local afterData = self._datalist[sortId + 1]

	if curData then
		local curNum = curData.cfg.num

		if not afterData then
			return string.format("%d次以上", curNum)
		else
			local afterNum = afterData.cfg.num

			if afterNum - 1 == curNum then
				return curNum
			else
				return string.format("%d-%d", curNum, afterNum - 1)
			end
		end
	end

	return ""
end

return DarkKingDragonBuffView
