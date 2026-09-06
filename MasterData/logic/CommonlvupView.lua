-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/view/CommonlvupView.lua

module("logic.extensions.common.view.CommonlvupView", package.seeall)

local CommonlvupView = class("CommonlvupView", ViewComponent)

function CommonlvupView:ctor()
	CommonlvupView.super.ctor(self)
end

function CommonlvupView:buildUI()
	CommonlvupView.super.buildUI(self)

	self._itemCon = self:getGo("itemCon")
	self._itemCell = self:getGo("itemCon/cell")
	self._itemGroup = ItemGroup.New(self._itemCon, self._itemCell, nil, nil, true)
end

function CommonlvupView:bindEvents()
	CommonlvupView.super.bindEvents(self)
end

function CommonlvupView:unbindEvents()
	CommonlvupView.super.unbindEvents(self)
end

function CommonlvupView:destroyUI()
	CommonlvupView.super.destroyUI(self)
end

function CommonlvupView:onEnter()
	CommonlvupView.super.onEnter(self)

	self._dataList = self:getFirstParam()
	self._space = 50

	self:_updateView()

	local params = self:getOpenParam()

	self.onExitCallBack = nil

	if params then
		self.onExitCallBack = params[2]
	end
end

function CommonlvupView:onEnterFinished()
	CommonlvupView.super.onEnterFinished(self)
end

function CommonlvupView:onExit()
	CommonlvupView.super.onExit(self)
	GameUtil.callBack(self.onExitCallBack)

	self.onExitCallBack = nil
end

function CommonlvupView:onExitFinished()
	CommonlvupView.super.onExitFinished(self)
end

function CommonlvupView:_updateView()
	if self._dataList then
		self._len = #self._dataList or 0
	end

	self._is2 = self._len % 2 == 0
	self._centerIndex = math.ceil(self._len / 2)

	if self._is2 then
		self._offset = self._space / 2 or 0
	end

	self._firstY = self._space * (self._centerIndex - 1) + self._offset

	self._itemGroup:updateWithMoArray(self._dataList, function(item, data)
		local nameText = goutil.findChildTextComponent(item.mainGO, "nameText")
		local preText = goutil.findChildTextComponent(item.mainGO, "preText")
		local lastText = goutil.findChildTextComponent(item.mainGO, "lastText")

		nameText.text = data.name
		preText.text = data.preValue
		lastText.text = data.lastValue

		local y = self:_getPosY(item.index)

		GameUtil.setAnchoredPos(item.mainGO, 0, y)
	end)
end

function CommonlvupView:_getPosY(index)
	return self._firstY - (index - 1) * self._space
end

return CommonlvupView
