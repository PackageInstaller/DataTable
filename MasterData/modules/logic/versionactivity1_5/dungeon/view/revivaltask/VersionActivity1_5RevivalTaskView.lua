-- chunkname: @modules/logic/versionactivity1_5/dungeon/view/revivaltask/VersionActivity1_5RevivalTaskView.lua

module("modules.logic.versionactivity1_5.dungeon.view.revivaltask.VersionActivity1_5RevivalTaskView", package.seeall)

local VersionActivity1_5RevivalTaskView = class("VersionActivity1_5RevivalTaskView", BaseView)

function VersionActivity1_5RevivalTaskView:onInitView()
	self._goheroTabList = gohelper.findChild(self.viewGO, "#go_heroTabList")
	self._goTabItem = gohelper.findChild(self.viewGO, "#go_heroTabList/#go_TabItem")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_5RevivalTaskView:addEvents()
	self._btnclose:AddClickListener(self.closeThis, self)
end

function VersionActivity1_5RevivalTaskView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function VersionActivity1_5RevivalTaskView:_editableInitView()
	gohelper.setActive(self._goTabItem, false)

	self.heroTabItemList = {}
end

function VersionActivity1_5RevivalTaskView:onUpdateParam()
	return
end

function VersionActivity1_5RevivalTaskView:onOpen()
	local select = false

	for _, heroTaskMo in ipairs(VersionActivity1_5RevivalTaskModel.instance:getTaskMoList()) do
		local heroItem = VersionActivity1_5HeroTabItem.createItem(gohelper.cloneInPlace(self._goTabItem), heroTaskMo)

		table.insert(self.heroTabItemList, heroItem)

		if not select and heroTaskMo:isUnlock() then
			select = true

			VersionActivity1_5RevivalTaskModel.instance:setSelectHeroTaskId(heroTaskMo.id)
		end
	end
end

function VersionActivity1_5RevivalTaskView:onClose()
	VersionActivity1_5RevivalTaskModel.instance:clearSelectTaskId()
end

function VersionActivity1_5RevivalTaskView:onDestroyView()
	for _, heroTabItem in ipairs(self.heroTabItemList) do
		heroTabItem:destroy()
	end

	self.heroTabItemList = nil
end

return VersionActivity1_5RevivalTaskView
