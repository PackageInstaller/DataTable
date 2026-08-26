-- chunkname: @modules/logic/versionactivity3_3/arcade/view/develop/ArcadeTalentView.lua

module("modules.logic.versionactivity3_3.arcade.view.develop.ArcadeTalentView", package.seeall)

local ArcadeTalentView = class("ArcadeTalentView", BaseView)

function ArcadeTalentView:onInitView()
	self._scrolltalent = gohelper.findChildScrollRect(self.viewGO, "root/#scroll_talent")
	self._goitem = gohelper.findChild(self.viewGO, "root/#go_item")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ArcadeTalentView:addEvents()
	return
end

function ArcadeTalentView:removeEvents()
	return
end

function ArcadeTalentView:_editableInitView()
	return
end

function ArcadeTalentView:onUpdateParam()
	return
end

function ArcadeTalentView:onOpen()
	ArcadeTalentListModel.instance:setMoList()
end

function ArcadeTalentView:onTabSwitchOpen()
	ArcadeTalentListModel.instance:onModelUpdate()
end

function ArcadeTalentView:onClose()
	return
end

function ArcadeTalentView:onDestroyView()
	return
end

return ArcadeTalentView
