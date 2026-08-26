-- chunkname: @modules/logic/rouge2/map/controller/Rouge2_PopController.lua

module("modules.logic.rouge2.map.controller.Rouge2_PopController", package.seeall)

local Rouge2_PopController = class("Rouge2_PopController")

function Rouge2_PopController:_init()
	if self._inited then
		return
	end

	self._inited = true
	self.waitPopViewList = {}
	self.dataPool = {}
	self.showingViewName = nil

	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, self.onCloseView, self)
end

function Rouge2_PopController:getViewData(viewName, param)
	local data = #self.dataPool > 1 and table.remove(self.dataPool) or {}

	data.type = Rouge2_Enum.PopType.ViewName
	data.viewName = viewName
	data.param = param

	return data
end

function Rouge2_PopController:getViewDataByFunc(viewName, openFunc, openFuncObj, ...)
	local data = #self.dataPool > 1 and table.remove(self.dataPool) or {}

	data.type = Rouge2_Enum.PopType.Func
	data.viewName = viewName
	data.openFunc = openFunc
	data.openFuncObj = openFuncObj
	data.funcParam = {
		...
	}

	return data
end

function Rouge2_PopController:recycleData(data)
	tabletool.clear(data)
	table.insert(self.dataPool, data)
end

function Rouge2_PopController:onCloseView(viewName)
	if self.showingViewName ~= viewName then
		return
	end

	self:recycleData(self.data)

	self.data = nil
	self.showingViewName = nil

	if self:hadPopView() then
		self:_popNextView()
	else
		Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onPopViewDone)
	end
end

function Rouge2_PopController:popViewData()
	return table.remove(self.waitPopViewList, 1)
end

function Rouge2_PopController:hadPopView()
	return (self.showingViewName == nil or nil) and self.waitPopViewList and #self.waitPopViewList > 0
end

function Rouge2_PopController:addPopViewWithViewName(viewName, param)
	self:_init()

	local data = self:getViewData(viewName, param)

	logNormal("add pop view : " .. viewName)
	table.insert(self.waitPopViewList, data)
	self:_popNextView()
end

function Rouge2_PopController:addPopViewWithOpenFunc(viewName, openFunc, openFuncObj, ...)
	self:_init()

	local data = self:getViewDataByFunc(viewName, openFunc, openFuncObj, ...)

	logNormal("add pop view : " .. viewName)
	table.insert(self.waitPopViewList, data)
	self:_popNextView()
end

function Rouge2_PopController:_popNextView()
	local state = Rouge2_MapModel.instance:getMapState()

	if state <= Rouge2_MapEnum.MapState.LoadingMap then
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

	if self.data.type == Rouge2_Enum.PopType.ViewName then
		ViewMgr.instance:openView(self.data.viewName, self.data.param)
	else
		self.data.openFunc(self.data.openFuncObj, unpack(self.data.funcParam))
	end
end

function Rouge2_PopController:skip(viewName)
	self:onCloseView(viewName)
end

function Rouge2_PopController:tryPopView()
	self:_popNextView()
end

function Rouge2_PopController:isPopping()
	return self.showingViewName ~= nil
end

function Rouge2_PopController:isViewInQueue(viewName)
	if self.showingViewName == viewName then
		return true
	end

	if self.waitPopViewList then
		for _, viewData in ipairs(self.waitPopViewList) do
			if viewData.viewName == viewName then
				return true
			end
		end
	end
end

function Rouge2_PopController:clearAllPopView()
	if self.waitPopViewList then
		for _ = 1, #self.waitPopViewList do
			self:recycleData(table.remove(self.waitPopViewList))
		end
	end

	if not string.nilorempty(self.showingViewName) and not ViewMgr.instance:isOpen(self.showingViewName) then
		self.showingViewName = nil
	end
end

Rouge2_PopController.instance = Rouge2_PopController.New()

return Rouge2_PopController
