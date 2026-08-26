-- chunkname: @modules/logic/survival/view/shelter/SurvivalDecreeSelectView.lua

module("modules.logic.survival.view.shelter.SurvivalDecreeSelectView", package.seeall)

local SurvivalDecreeSelectView = class("SurvivalDecreeSelectView", BaseView)

function SurvivalDecreeSelectView:onInitView()
	self.goItem = gohelper.findChild(self.viewGO, "#go_Select/#scroll/Viewport/LayoutGroup/#go_Item")
	self.goLayout = gohelper.findChild(self.viewGO, "#go_Select/#scroll/Viewport/LayoutGroup")
	self.sizeFitter = self.goLayout:GetComponent(gohelper.Type_ContentSizeFitter)
	self.layout = self.goLayout:GetComponent(gohelper.Type_VerticalLayoutGroup)

	gohelper.setActive(self.goItem, false)

	self.itemList = {}
end

function SurvivalDecreeSelectView:addEvents()
	return
end

function SurvivalDecreeSelectView:removeEvents()
	return
end

function SurvivalDecreeSelectView:onOpen()
	self:refreshParam()
	self:refreshView()
	self:playOpenAnim()
end

function SurvivalDecreeSelectView:onUpdateParam()
	self:refreshParam()
	self:refreshView()
end

function SurvivalDecreeSelectView:refreshParam()
	self.decreesProp = self.viewParam.panel.decreesProp
end

function SurvivalDecreeSelectView:refreshView()
	for i = 1, #self.decreesProp.decreesId do
		local item = self:getItem(i)

		item:updateItem(i, self.decreesProp.decreesId[i])
	end
end

function SurvivalDecreeSelectView:getItem(index)
	local item = self.itemList[index]

	if not item then
		local go = gohelper.cloneInPlace(self.goItem, tostring(index))

		item = MonoHelper.addNoUpdateLuaComOnceToGo(go, SurvivalDecreeSelectItem)
		self.itemList[index] = item
	end

	return item
end

function SurvivalDecreeSelectView:playOpenAnim()
	for i, v in ipairs(self.itemList) do
		gohelper.setActive(v.viewGO, false)
	end

	self._animIndex = 0

	TaskDispatcher.runRepeat(self._playItemOpenAnim, self, 0.06, #self.itemList)
end

function SurvivalDecreeSelectView:_playItemOpenAnim()
	self._animIndex = self._animIndex + 1

	local item = self.itemList[self._animIndex]

	if item then
		gohelper.setActive(item.viewGO, true)
	end

	if self._animIndex >= #self.itemList then
		TaskDispatcher.cancelTask(self._playItemOpenAnim, self)
	end
end

function SurvivalDecreeSelectView:onClose()
	return
end

return SurvivalDecreeSelectView
