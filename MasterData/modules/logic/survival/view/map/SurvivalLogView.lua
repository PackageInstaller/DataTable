-- chunkname: @modules/logic/survival/view/map/SurvivalLogView.lua

module("modules.logic.survival.view.map.SurvivalLogView", package.seeall)

local SurvivalLogView = class("SurvivalLogView", BaseView)

function SurvivalLogView:onInitView()
	self._item = gohelper.findChild(self.viewGO, "root/#go_info/scroll_log/Viewport/Content/#txt_logitem")
	self._btncose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
end

function SurvivalLogView:addEvents()
	self._btncose:AddClickListener(self.closeThis, self)
end

function SurvivalLogView:removeEvents()
	self._btncose:RemoveClickListener()
end

function SurvivalLogView:onOpen()
	gohelper.CreateObjList(self, self._createLogItem, self.viewParam, nil, self._item)
end

function SurvivalLogView:_createLogItem(obj, data, index)
	local txt = gohelper.findChildTextMesh(obj, "")

	txt.text = data:getLogStr()
end

function SurvivalLogView:onClickModalMask()
	self:closeThis()
end

return SurvivalLogView
