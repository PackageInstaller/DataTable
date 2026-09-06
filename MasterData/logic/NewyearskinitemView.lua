-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bonus/view/newyear/NewyearskinitemView.lua

module("logic.extensions.bonus.view.christmasandnewyear.NewyearskinitemView", package.seeall)

local NewyearskinitemView = class("NewyearskinitemView", SummarySubTabView)

function NewyearskinitemView:ctor()
	NewyearskinitemView.super.ctor(self)
end

function NewyearskinitemView:buildUI()
	NewyearskinitemView.super.buildUI(self)

	self.TableView = self:getGo("tableview")
	self.Cell = self:getGo("cell")
	self.tableview = ScrollerList.create(self.TableView, self.Cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function NewyearskinitemView:onExit()
	self.tableview:dispose()
	NewyearskinitemView.super.onExit(self)
end

function NewyearskinitemView:onEnter()
	NewyearskinitemView.super.onEnter(self)
	self.tableview:reloadData(self._cfgs)
end

function NewyearskinitemView:_updateCell(view, cell, data)
	local goBtn = goutil.findChild(cell, "btnGo")
	local txtName = goutil.findChildTextComponent(cell, "txtName")
	local icon = goutil.findChild(cell, "item")

	if data then
		txtName.text = data.params

		MaterialMgr.updateItemByStr(icon, data.background)
		GameUtil.addClickHandler(goBtn, GameUtil.handler(self._onJump, self, data))
		GameUtil.addClickHandler(icon, function()
			CommonTipsMgr.instance:openTipsByConfStr(icon, data.background)
		end)
	end
end

function NewyearskinitemView:_clearCell(cell)
	local goBtn = goutil.findChild(cell, "btnGo")

	GameUtil.rmClickHandler(goBtn)

	local icon = goutil.findChild(cell, "item")

	MaterialMgr.resetAll(icon)
	GameUtil.rmClickHandler(icon)
end

function NewyearskinitemView:buildBtnJump()
	return
end

return NewyearskinitemView
