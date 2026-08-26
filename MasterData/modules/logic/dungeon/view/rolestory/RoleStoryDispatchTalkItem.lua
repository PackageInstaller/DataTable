-- chunkname: @modules/logic/dungeon/view/rolestory/RoleStoryDispatchTalkItem.lua

module("modules.logic.dungeon.view.rolestory.RoleStoryDispatchTalkItem", package.seeall)

local RoleStoryDispatchTalkItem = class("RoleStoryDispatchTalkItem", ListScrollCellExtend)

function RoleStoryDispatchTalkItem:onInitView()
	self.scrollconent = self.viewGO.transform.parent
	self.itemList = {}

	for i = 1, 2 do
		local item = self:getUserDataTb_()

		self.itemList[i] = item
		item.txtInfo = gohelper.findChildTextMesh(self.viewGO, string.format("info%s", i))
		item.txtRole = gohelper.findChildTextMesh(self.viewGO, string.format("info%s/#txt_role", i))
		item.canvasGroup = item.txtInfo.gameObject:GetComponent(typeof(UnityEngine.CanvasGroup))
	end

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoleStoryDispatchTalkItem:addEvents()
	return
end

function RoleStoryDispatchTalkItem:removeEvents()
	return
end

function RoleStoryDispatchTalkItem:refreshItem()
	self:killTween()

	if not self.data then
		self:clear()
		gohelper.setActive(self.viewGO, false)

		return
	end

	gohelper.setActive(self.viewGO, true)

	local type = self.data.type

	self.curItem = self.itemList[type]

	for i, v in ipairs(self.itemList) do
		gohelper.setActive(v.txtInfo, type == i)
	end

	if type == RoleStoryEnum.TalkType.Special then
		SLFramework.UGUI.GuiHelper.SetColor(self.curItem.txtRole, string.format("#%s", self.data.color))
		SLFramework.UGUI.GuiHelper.SetColor(self.curItem.txtInfo, string.format("#%s", self.data.color))
	end

	self.curItem.canvasGroup.alpha = 1

	self:setText(self.data)
end

function RoleStoryDispatchTalkItem:onUpdateMO(data, index)
	self.data = data
	self.index = index

	self:refreshItem()
end

function RoleStoryDispatchTalkItem:startTween(callback, callbackObj)
	self.callback = callback
	self.callbackObj = callbackObj

	if not self.data then
		self:finishTween()

		return
	end

	self.tween = self.tween or RoleStoryDispatchTalkItemTween.New()
	self.curItem.txtInfo.text = self.data.content
	self.curItem.txtRole.text = ""

	self.tween:playTween(self.curItem.txtInfo, self.data.content, self.finishTween, self, self.scrollconent)
end

function RoleStoryDispatchTalkItem:finishTween()
	self:setText(self.data)

	local callback = self.callback
	local callbackObj = self.callbackObj

	self.callback = nil
	self.callbackObj = nil

	if callback then
		self.callback(callbackObj)
	end
end

function RoleStoryDispatchTalkItem:clearText()
	self:setText()

	if self.curItem then
		self.curItem.canvasGroup.alpha = 0
	end
end

function RoleStoryDispatchTalkItem:setText(data)
	if not self.curItem then
		return
	end

	if data then
		self.curItem.txtInfo.text = data.content or ""
	end

	if data then
		self.curItem.txtRole.text = data.speaker or ""
	end
end

function RoleStoryDispatchTalkItem:killTween()
	if self.tween then
		self.tween:killTween()
	end
end

function RoleStoryDispatchTalkItem:_editableInitView()
	return
end

function RoleStoryDispatchTalkItem:clear()
	return
end

function RoleStoryDispatchTalkItem:onDestroyView()
	if self.tween then
		self.tween:destroy()
	end

	self:clear()
end

return RoleStoryDispatchTalkItem
