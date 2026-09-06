-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/activitydaylirecharge/view/WeektotalchargeshopView.lua

module("logic.extensions.activitydaylirecharge.view.WeektotalchargeshopView", package.seeall)

local WeektotalchargeshopView = class("WeektotalchargeshopView", TableViewComponent)

function WeektotalchargeshopView:ctor()
	WeektotalchargeshopView.super.ctor(self)
end

function WeektotalchargeshopView:buildUI()
	WeektotalchargeshopView.super.buildUI(self)

	self._txtLeftTime = goutil.findChildTextComponent(self.mainGO, "txtLeftTime")
end

function WeektotalchargeshopView:bindEvents()
	WeektotalchargeshopView.super.bindEvents(self)
end

function WeektotalchargeshopView:unbindEvents()
	WeektotalchargeshopView.super.unbindEvents(self)
end

function WeektotalchargeshopView:destroyUI()
	WeektotalchargeshopView.super.destroyUI(self)
end

function WeektotalchargeshopView:onEnter()
	WeektotalchargeshopView.super.onEnter(self)
	self:_updateView()
end

function WeektotalchargeshopView:onEnterFinished()
	WeektotalchargeshopView.super.onEnterFinished(self)
end

function WeektotalchargeshopView:onExit()
	WeektotalchargeshopView.super.onExit(self)
end

function WeektotalchargeshopView:onExitFinished()
	WeektotalchargeshopView.super.onExitFinished(self)
end

function WeektotalchargeshopView:_getPath()
	return {
		cellPath = "tablecell",
		viewPath = "tableview"
	}
end

function WeektotalchargeshopView:_cellSize(view, index)
	return 100, 100
end

function WeektotalchargeshopView:_updateCell(view, cell, data)
	return
end

function WeektotalchargeshopView:_clearTableview(cell)
	return
end

function WeektotalchargeshopView:_updateView()
	self._txtLeftTime.text = "本期活动 xxxxxx"
	self._curViewDatas = {
		1,
		2,
		34,
		5,
		6,
		7,
		8
	}

	self:reloadData()
end

return WeektotalchargeshopView
