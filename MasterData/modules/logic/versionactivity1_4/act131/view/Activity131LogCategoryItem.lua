-- chunkname: @modules/logic/versionactivity1_4/act131/view/Activity131LogCategoryItem.lua

module("modules.logic.versionactivity1_4.act131.view.Activity131LogCategoryItem", package.seeall)

local Activity131LogCategoryItem = class("Activity131LogCategoryItem", LuaCompBase)

function Activity131LogCategoryItem:init(go)
	self._btnCategory = gohelper.findChildButtonWithAudio(go, "btnclick")
	self.goSelected = gohelper.findChild(go, "beselected")
	self.goUnSelected = gohelper.findChild(go, "unselected")
	self.txtTitleS = gohelper.findChildTextMesh(go, "beselected/chapternamecn")
	self.txtTitleUS = gohelper.findChildTextMesh(go, "unselected/chapternamecn")
end

function Activity131LogCategoryItem:addEventListeners()
	self._btnCategory:AddClickListener(self._onItemClick, self)
	self.addEventCb(self, Activity131Controller.instance, Activity131Event.SelectCategory, self.onSelectCategory, self)
end

function Activity131LogCategoryItem:removeEventListeners()
	self._btnCategory:RemoveClickListener()
	self.removeEventCb(self, Activity131Controller.instance, Activity131Event.SelectCategory, self.onSelectCategory, self)
end

function Activity131LogCategoryItem:setInfo(logType)
	self.logType = logType

	local strs = string.split(logType, "_")
	local cfg = Activity131Config.instance:getActivity131DialogCo(tonumber(strs[1]), tonumber(strs[2]))

	self.txtTitleS.text = cfg.content
	self.txtTitleUS.text = cfg.content

	gohelper.setActive(self.goSelected, self:_isSelected())
	gohelper.setActive(self.goUnSelected, not self:_isSelected())
end

function Activity131LogCategoryItem:onDestroy()
	return
end

function Activity131LogCategoryItem:_isSelected()
	return self.logType == Activity131Model.instance:getSelectLogType()
end

function Activity131LogCategoryItem:_onItemClick()
	if self:_isSelected() then
		return
	end

	Activity131Model.instance:setSelectLogType(self.logType)
end

function Activity131LogCategoryItem:onSelectCategory()
	gohelper.setActive(self.goSelected, self:_isSelected())
	gohelper.setActive(self.goUnSelected, not self:_isSelected())
end

return Activity131LogCategoryItem
