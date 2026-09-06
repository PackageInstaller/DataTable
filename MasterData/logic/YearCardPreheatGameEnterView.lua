-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/yearcardpreheat/view/YearCardPreheatGameEnterView.lua

module("logic.extensions.yearcardpreheat.view.YearCardPreheatGameEnterView", package.seeall)

local YearCardPreheatGameEnterView = class("YearCardPreheatGameEnterView", ViewComponent)

function YearCardPreheatGameEnterView:buildUI()
	YearCardPreheatGameEnterView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")

	local goEnterList = self:getGo("enterList")

	self._enterList = {}

	for i = 1, 3 do
		local enterCell = {}
		local enterPath = "enterCell" .. i

		enterCell.go = goutil.findChild(goEnterList, enterPath)
		enterCell.btn = GameUtil.asBtn(enterCell.go)
		enterCell.matCellList = {}
		enterCell.goCellList = goutil.findChild(enterCell.go, "cellList")

		for k = 1, 3 do
			enterCell.matCellList[k] = goutil.findChild(enterCell.goCellList, "cell" .. k)
		end

		enterCell.cfg = nil
		self._enterList[i] = enterCell
	end
end

function YearCardPreheatGameEnterView:unbindEvents()
	YearCardPreheatGameEnterView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()

	for i = 1, 3 do
		self._enterList[i].btn:RemoveClickListener()
	end
end

function YearCardPreheatGameEnterView:bindEvents()
	YearCardPreheatGameEnterView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)

	for i = 1, 3 do
		self._enterList[i].btn:AddClickListener(function()
			self:onClickJumpTo(i)
		end, self)
	end
end

function YearCardPreheatGameEnterView:onEnter()
	YearCardPreheatGameEnterView.super.onEnter(self)

	for i = 1, 3 do
		local cell = self._enterList[i]

		cell.cfg = YearCardPreheatConfig.instance:getGameCfgByStageId(i)

		local prizeStrs = string.split(cell.cfg.prize or "", "#")

		for k = 1, 3 do
			if prizeStrs[k] then
				MaterialMgr.setCellByCfg(prizeStrs[k], cell.matCellList[k])
				goutil.setActive(cell.matCellList[k], true)
			else
				goutil.setActive(cell.matCellList[k], false)
			end
		end
	end
end

function YearCardPreheatGameEnterView:onExit()
	YearCardPreheatGameEnterView.super.onExit(self)

	for i = 1, 3 do
		for i = 1, 3 do
			MaterialMgr.resetAll(self._enterList[i].matCellList[i])
		end
	end
end

function YearCardPreheatGameEnterView:onClickJumpTo(id)
	UIStateManager.instance:push(ViewName.YearCardPreheatGameView, self._enterList[id].cfg)
end

return YearCardPreheatGameEnterView
