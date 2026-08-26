-- chunkname: @modules/logic/versionactivity3_7/travelgo/view/item/TravelGoFloatItem.lua

module("modules.logic.versionactivity3_7.travelgo.view.item.TravelGoFloatItem", package.seeall)

local TravelGoFloatItem = class("TravelGoFloatItem", LuaCompBase)

function TravelGoFloatItem:init(viewGO)
	self.viewGO = viewGO
	self.textAdd = gohelper.findChildText(viewGO, "root/txt_+")
	self.textReduce = gohelper.findChildText(viewGO, "root/txt_-_1")
	self.textReduceCrit = gohelper.findChildText(viewGO, "root/txt_-_2")
end

function TravelGoFloatItem:setData(param, returnFloatItemFunc, context)
	self.number = param.number
	self.isNumberSubtract = param.isNumberSubtract
	self.returnFloatItemFunc = returnFloatItemFunc
	self.context = context

	gohelper.setActive(self.viewGO, true)

	if self.isNumberSubtract then
		gohelper.setActive(self.textAdd, false)
		gohelper.setActive(self.textReduce, not param.isCrit)
		gohelper.setActive(self.textReduceCrit, param.isCrit)

		self.textReduce.text = "-" .. self.number
		self.textReduceCrit.text = "-" .. self.number
	else
		gohelper.setActive(self.textAdd, true)
		gohelper.setActive(self.textReduce, false)
		gohelper.setActive(self.textReduceCrit, false)

		self.textAdd.text = "+" .. self.number
	end

	TaskDispatcher.cancelTask(self.onEnd, self)
	TaskDispatcher.runRepeat(self.onEnd, self, 0.5)
end

function TravelGoFloatItem:onEnd()
	TaskDispatcher.cancelTask(self.onEnd, self)
	gohelper.setActive(self.viewGO, false)

	if self.returnFloatItemFunc then
		self.returnFloatItemFunc(self.context, self)
	end
end

function TravelGoFloatItem:onDestroy()
	TaskDispatcher.cancelTask(self.onEnd, self)
end

return TravelGoFloatItem
