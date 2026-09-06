-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinezhongfeiclg/view/DivineZhongFeiClgBuffView.lua

module("logic.extensions.divinezhongfeiclg.view.DivineZhongFeiClgBuffView", package.seeall)

local DivineZhongFeiClgBuffView = class("DivineZhongFeiClgBuffView", ViewComponent)

function DivineZhongFeiClgBuffView:ctor()
	DivineZhongFeiClgBuffView.super.ctor(self)
end

function DivineZhongFeiClgBuffView:unbindEvents()
	DivineZhongFeiClgBuffView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnClose)
end

function DivineZhongFeiClgBuffView:bindEvents()
	DivineZhongFeiClgBuffView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnClose, self.close, self)
end

function DivineZhongFeiClgBuffView:buildUI()
	DivineZhongFeiClgBuffView.super.buildUI(self)

	self._btnClose = self:getGo("btnClose")
	self._buffTableCell = self:getGo("scoreTableCell")
	self._buffTableView = self:getGo("scoreTableView")
	self._buffTableList = ScrollerList.create(self._buffTableView, self._buffTableCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function DivineZhongFeiClgBuffView:onExit()
	DivineZhongFeiClgBuffView.super.onExit(self)
end

function DivineZhongFeiClgBuffView:onEnter()
	DivineZhongFeiClgBuffView.super.onEnter(self)

	self._activityId = checknumber(self:getFirstParam())

	local buffCfgs = DivineZhongFeiClgConfig.instance:getExtBuffCfgs(self._activityId)
	local list = {}

	for i, v in pairs(buffCfgs) do
		table.insert(list, {
			cfg = v
		})
	end

	table.sort(list, function(a, b)
		return a.cfg.killNum < b.cfg.killNum
	end)

	for i, v in ipairs(list) do
		v.index = i
	end

	local curScore = DivineZhongFeiClgModel.instance:getExtStageTotalScore(self._activityId)

	self._activeBuffIndex = 0

	for i, v in ipairs(list) do
		if curScore >= v.cfg.killNum then
			self._activeBuffIndex = v.index
		end
	end

	self._buffTableList:reloadData(list)

	if self._activeBuffIndex - 1 >= 0 then
		self._buffTableList:MoveCellToCenter(self._activeBuffIndex - 1)
	else
		self._buffTableList:MoveCellToCenter(self._activeBuffIndex)
	end
end

function DivineZhongFeiClgBuffView:_updateCell(view, cell, data, tag)
	local go = cell.gameObject
	local txtScore = goutil.findChildTextComponent(go, "txtScore")
	local txtDesc = goutil.findChildTextComponent(go, "txtDesc")
	local bgChange = goutil.findChildComponent(go, "bg", ComponentType.UIImageColorChange)
	local useTag = goutil.findChild(go, "useTag")

	txtScore.text = data.cfg.killNum
	txtDesc.text = data.cfg.desc

	GameUtil.SetActive(useTag, self._activeBuffIndex == data.index)

	if data.index % 2 == 1 then
		bgChange:SetState(0)
	else
		bgChange:SetState(1)
	end
end

function DivineZhongFeiClgBuffView:_clearCell(cell)
	return
end

return DivineZhongFeiClgBuffView
