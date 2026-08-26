-- chunkname: @modules/logic/dungeon/view/rolestory/RoleStoryActivityBgView.lua

module("modules.logic.dungeon.view.rolestory.RoleStoryActivityBgView", package.seeall)

local RoleStoryActivityBgView = class("RoleStoryActivityBgView", BaseView)

function RoleStoryActivityBgView:onInitView()
	self.bgNode = gohelper.findChild(self.viewGO, "fullbg")
	self.bg1 = gohelper.findChild(self.bgNode, "#simage_fullbg1")
	self.bg2 = gohelper.findChild(self.bgNode, "#simage_fullbg2")
	self._showActView = true

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoleStoryActivityBgView:addEvents()
	self.addEventCb(self, RoleStoryController.instance, RoleStoryEvent.ChangeMainViewShow, self._onChangeMainViewShow, self)
end

function RoleStoryActivityBgView:removeEvents()
	self.removeEventCb(self, RoleStoryController.instance, RoleStoryEvent.ChangeMainViewShow, self._onChangeMainViewShow, self)
end

function RoleStoryActivityBgView:_editableInitView()
	return
end

function RoleStoryActivityBgView:onOpen()
	if self.viewParam and self.viewParam[1] == 1 then
		self._showActView = false
	end
end

function RoleStoryActivityBgView:_onChangeMainViewShow(showAct)
	if self._showActView == showAct then
		return
	end

	self._showActView = showAct
end

function RoleStoryActivityBgView:refreshBg()
	gohelper.setActive(self.bg1, self._showActView)
	gohelper.setActive(self.bg2, not self._showActView)
end

function RoleStoryActivityBgView:onClose()
	return
end

function RoleStoryActivityBgView:onDestroyView()
	return
end

return RoleStoryActivityBgView
