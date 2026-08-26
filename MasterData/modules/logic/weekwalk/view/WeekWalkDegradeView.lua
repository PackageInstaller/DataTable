-- chunkname: @modules/logic/weekwalk/view/WeekWalkDegradeView.lua

module("modules.logic.weekwalk.view.WeekWalkDegradeView", package.seeall)

local WeekWalkDegradeView = class("WeekWalkDegradeView", BaseView)

function WeekWalkDegradeView:onInitView()
	self._simagetipbg = gohelper.findChildSingleImage(self.viewGO, "#simage_tipbg")
	self._btnno = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_no")
	self._btnsure = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_sure")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function WeekWalkDegradeView:addEvents()
	self._btnno:AddClickListener(self._btnnoOnClick, self)
	self._btnsure:AddClickListener(self._btnsureOnClick, self)
end

function WeekWalkDegradeView:removeEvents()
	self._btnno:RemoveClickListener()
	self._btnsure:RemoveClickListener()
end

function WeekWalkDegradeView:_btnnoOnClick()
	self:closeThis()
end

function WeekWalkDegradeView:_btnsureOnClick()
	WeekwalkRpc.instance:sendSelectWeekwalkLevelRequest(self._level - 1)
	self:closeThis()
end

function WeekWalkDegradeView:_editableInitView()
	self._simagetipbg:LoadImage(ResUrl.getMessageIcon("bg_tanchuang"))
end

function WeekWalkDegradeView:onUpdateParam()
	return
end

function WeekWalkDegradeView:onOpen()
	self._level = WeekWalkModel.instance:getLevel()
end

function WeekWalkDegradeView:onClose()
	return
end

function WeekWalkDegradeView:onDestroyView()
	return
end

return WeekWalkDegradeView
