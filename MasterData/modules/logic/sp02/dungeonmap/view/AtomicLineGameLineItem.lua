-- chunkname: @modules/logic/sp02/dungeonmap/view/AtomicLineGameLineItem.lua

module("modules.logic.sp02.dungeonmap.view.AtomicLineGameLineItem", package.seeall)

local AtomicLineGameLineItem = class("AtomicLineGameLineItem", LuaCompBase)

function AtomicLineGameLineItem:ctor(param)
	return
end

function AtomicLineGameLineItem:init(go)
	self.go = go
	self.goLine1 = gohelper.findChild(self.go, "image_line/go_lineType1")
	self.goLine2 = gohelper.findChild(self.go, "image_line/go_lineType2")
	self.animLine1 = self.goLine1:GetComponent(gohelper.Type_Animator)
	self.animLine2 = self.goLine2:GetComponent(gohelper.Type_Animator)
end

function AtomicLineGameLineItem:addEventListeners()
	return
end

function AtomicLineGameLineItem:removeEventListeners()
	return
end

function AtomicLineGameLineItem:setLineTypeShow(curLineType)
	for type = 1, 2 do
		gohelper.setActive(self["goLine" .. type], type == curLineType)
	end
end

function AtomicLineGameLineItem:setLineItemAnim(showState, animName)
	local curAnimName = animName and animName or showState and "in" or "out"

	self.animLine1:Play(curAnimName, 0, 0)
	self.animLine1:Update(0)
	self.animLine2:Play(curAnimName, 0, 0)
	self.animLine2:Update(0)

	if curAnimName == "out" then
		TaskDispatcher.runDelay(self.hideLine, self, 0.167)
	end
end

function AtomicLineGameLineItem:hideLine()
	gohelper.setActive(self.go, false)
end

function AtomicLineGameLineItem:onDestroy()
	TaskDispatcher.cancelTask(self.hideLine, self)
end

return AtomicLineGameLineItem
