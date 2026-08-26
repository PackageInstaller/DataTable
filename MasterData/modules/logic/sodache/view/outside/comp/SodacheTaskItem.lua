-- chunkname: @modules/logic/sodache/view/outside/comp/SodacheTaskItem.lua

module("modules.logic.sodache.view.outside.comp.SodacheTaskItem", package.seeall)

local SodacheTaskItem = class("SodacheTaskItem", LuaCompBase)

function SodacheTaskItem:ctor(index)
	self.index = index
end

function SodacheTaskItem:init(go)
	self.go = go
	self.anim = gohelper.findComponentAnim(go)
	self.goUnSelect = gohelper.findChild(go, "go_UnSelect")
	self.txtNameU = gohelper.findChildText(go, "go_UnSelect/txt_Name")
	self.goSelect = gohelper.findChild(go, "go_Select")
	self.txtNameS = gohelper.findChildText(go, "go_Select/txt_Name")
	self.goFinish = gohelper.findChild(go, "go_Finish")
	self.goNew = gohelper.findChild(go, "go_New")
	self.goReddot = gohelper.findChild(go, "go_Reddot")
	self.btnClick = gohelper.findChildButtonWithAudio(go, "btn_Click")
	self.goEffect = gohelper.findChild(go, "vx_select")
end

function SodacheTaskItem:addEventListeners()
	self.addClickCb(self, self.btnClick, self._btnTaskOnClick, self)
end

function SodacheTaskItem:_btnTaskOnClick()
	SodacheController.instance:dispatchEvent(SodacheEvent.OnClickTaskItem, self.index)
end

function SodacheTaskItem:setData(mo)
	self.data = mo
	self.config = mo.config
	self.txtNameU.text = mo.config.name
	self.txtNameS.text = mo.config.name

	gohelper.setActive(self.goFinish, mo.state == SodacheEnum.TaskState.Received)
	self:refreshTag()
end

function SodacheTaskItem:refreshTag()
	if self.data.state == SodacheEnum.TaskState.Finished then
		gohelper.setActive(self.goReddot, true)
		gohelper.setActive(self.goNew, false)
	else
		gohelper.setActive(self.goReddot, false)

		local key = PlayerPrefsKey.SodacheTaskItemNewTag .. self.data.id

		self.isNew = GameUtil.playerPrefsGetNumberByUserId(key, 0) == 0

		gohelper.setActive(self.goNew, self.isNew and self.data.state ~= SodacheEnum.TaskState.Received)
	end
end

function SodacheTaskItem:setSelect(isSelect)
	local name = isSelect and "select" or "unselect"

	self.anim:Play(name, 0, 0)
	gohelper.setActive(self.goUnSelect, not isSelect)
	gohelper.setActive(self.goSelect, isSelect)
	gohelper.setActive(self.goEffect, isSelect)
end

function SodacheTaskItem:setParent(parent)
	gohelper.setParent(self.go, parent)
end

function SodacheTaskItem:Hide()
	self.anim:Play("close", 0, 0)
end

return SodacheTaskItem
