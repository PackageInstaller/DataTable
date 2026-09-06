-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/plotrecall/view/PlotrecallView.lua

module("logic.extensions.handbook.view.PlotrecallView", package.seeall)

local PlotrecallView = class("PlotrecallView", TableViewComponent)

function PlotrecallView:ctor()
	PlotrecallView.super.ctor(self)
end

function PlotrecallView:buildUI()
	PlotrecallView.super.buildUI(self)

	self._closeButton = self:getBtn("topleft/btnClose")
	self._txtLockNum = goutil.findChildTextComponent(self.mainGO, "txtLockNum")
end

function PlotrecallView:bindEvents()
	PlotrecallView.super.bindEvents(self)
	self._closeButton:AddClickListener(self.close, self)
end

function PlotrecallView:unbindEvents()
	PlotrecallView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
end

function PlotrecallView:destroyUI()
	PlotrecallView.super.destroyUI(self)
end

function PlotrecallView:onEnter()
	PlotrecallView.super.onEnter(self)
	self:_updateUI()
end

function PlotrecallView:onEnterFinished()
	PlotrecallView.super.onEnterFinished(self)
end

function PlotrecallView:onExit()
	PlotrecallView.super.onExit(self)
end

function PlotrecallView:onExitFinished()
	PlotrecallView.super.onExitFinished(self)
end

function PlotrecallView:_getPath()
	return {
		cellPath = "tablecell",
		viewPath = "tableview"
	}
end

function PlotrecallView:close()
	PlotrecallView.super.close(self)
end

function PlotrecallView:_updateUI()
	local cfg = PlotRecallConfig.instance:getAllCG()
	local unlockNum = 0
	local sum = #cfg

	for k, v in ipairs(cfg) do
		local unlock = FuncOpenModel.instance:getFuncIsOpen(v.funcId)

		v.unlock = unlock
		unlockNum = unlockNum + (unlock and 1 or 0)
	end

	self._txtLockNum.text = string.format("%d/%d", unlockNum, sum)
	self._curViewDatas = cfg

	self:reloadData()
end

function PlotrecallView:_updateCell(view, cell, data)
	local locked = goutil.findChild(cell, "locked")

	if data.unlock then
		local imgBg = goutil.findChild(cell, "imgBg")
		local txtTitle = goutil.findChildTextComponent(cell, "chapter/txtChapter")

		txtTitle.text = data.imgTitle

		uGuiUtil.setSpriteToImage(imgBg, uGuiUtil.SpriteType.BigBg, GameUrl.getPlotRecallUrl(data.coverSrc))
		goutil.setActive(locked, false)
	else
		goutil.setActive(locked, true)

		local txtTitle = goutil.findChildTextComponent(locked, "txtTitle")

		txtTitle.text = langPara("%s剧情后解锁", data.unlockCondition)
	end

	GameUtil.addClickHandler(cell, GameUtil.handler(self._clickItem, self, cell.index + 1, data.unlock))
end

function PlotrecallView:_clickItem(idx, unlock)
	if unlock then
		PlotRecallModel.instance:setSelectCGId(idx)
		UIStateManager.instance:push(ViewName.PlotrecallshowView)
	else
		FloatWordMgr.instance:show(lang("还没解锁该剧情插图"))
	end
end

return PlotrecallView
