-- chunkname: @modules/logic/rouge/map/controller/RougePopController.lua

module("modules.logic.rouge.map.controller.RougePopController", package.seeall)

local RougePopController = class("RougePopController")

function RougePopController:_init()
	if self._inited then
		return
	end

	self._inited = true
	self.waitPopViewList = {}
	self.dataPool = {}
	self.showingViewName = nil

	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self.onCloseView, self)
end

function RougePopController:getViewData(viewName, param)
	local data = #self.dataPool > 1 and table.remove(self.dataPool) or {}

	data.type = RougeEnum.PopType.ViewName
	data.viewName = viewName
	data.param = param

	return data
end

function RougePopController:getViewDataByFunc(viewName, openFunc, openFuncObj, ...)
	local data = #self.dataPool > 1 and table.remove(self.dataPool) or {}

	data.type = RougeEnum.PopType.Func
	data.viewName = viewName
	data.openFunc = openFunc
	data.openFuncObj = openFuncObj
	data.funcParam = {
		...
	}

	return data
end

function RougePopController:recycleData(data)
	tabletool.clear(data)
	table.insert(self.dataPool, data)
end

function RougePopController:onCloseView(viewName)
	if self.showingViewName ~= viewName then
		return
	end

	self:recycleData(self.data)

	self.data = nil
	self.showingViewName = nil

	if self:hadPopView() then
		self:_popNextView()
	else
		RougeMapController.instance:dispatchEvent(RougeMapEvent.onPopViewDone)
	end
end

function RougePopController:popViewData()
	return table.remove(self.waitPopViewList, 1)
end

function RougePopController:hadPopView()
	return (self.showingViewName == nil or nil) and self.waitPopViewList and #self.waitPopViewList > 0
end

function RougePopController:addPopViewWithViewName(viewName, param)
	self:_init()

	local data = self:getViewData(viewName, param)

	logNormal("add pop view : " .. viewName)
	table.insert(self.waitPopViewList, data)
	self:_popNextView()
end

function RougePopController:addPopViewWithOpenFunc(viewName, openFunc, openFuncObj, ...)
	self:_init()

	local data = self:getViewDataByFunc(viewName, openFunc, openFuncObj, ...)

	logNormal("add pop view : " .. viewName)
	table.insert(self.waitPopViewList, data)
	self:_popNextView()
end

function RougePopController:_popNextView()
	local state = RougeMapModel.instance:getMapState()

	if state <= RougeMapEnum.MapState.LoadingMap then
		return
	end

	if self.showingViewName then
		return
	end

	self.data = self:popViewData()

	if not self.data then
		return
	end

	self.showingViewName = self.data.viewName

	if self.data.type == RougeEnum.PopType.ViewName then
		ViewMgr.instance:openView(self.data.viewName, self.data.param)
	else
		self.data.openFunc(self.data.openFuncObj, unpack(self.data.funcParam))
	end
end

function RougePopController:tryPopView()
	self:_popNextView()
end

function RougePopController:isPopping()
	return self.showingViewName ~= nil
end

function RougePopController:clearAllPopView()
	if self.waitPopViewList then
		for _ = 1, #self.waitPopViewList do
			self:recycleData(table.remove(self.waitPopViewList))
		end
	end
end

RougePopController.instance = RougePopController.New()

return RougePopController
