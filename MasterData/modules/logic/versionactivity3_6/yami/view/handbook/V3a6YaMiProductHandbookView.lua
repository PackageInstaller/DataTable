-- chunkname: @modules/logic/versionactivity3_6/yami/view/handbook/V3a6YaMiProductHandbookView.lua

module("modules.logic.versionactivity3_6.yami.view.handbook.V3a6YaMiProductHandbookView", package.seeall)

local V3a6YaMiProductHandbookView = class("V3a6YaMiProductHandbookView", BaseView)

function V3a6YaMiProductHandbookView:onInitView()
	self._gofullbg = gohelper.findChild(self.viewGO, "root/fullbg")
	self._gofundingitem = gohelper.findChild(self.viewGO, "root/#go_fundingitem")
	self._gopanel = gohelper.findChild(self.viewGO, "root/#go_panel")
	self._gotopleft = gohelper.findChild(self.viewGO, "root/#go_topleft")
	self._btnmask = gohelper.getClick(self._gofullbg)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a6YaMiProductHandbookView:addEvents()
	self._btnmask:AddClickListener(self.closeThis, self)
end

function V3a6YaMiProductHandbookView:removeEvents()
	self._btnmask:RemoveClickListener()
end

function V3a6YaMiProductHandbookView:_editableInitView()
	return
end

function V3a6YaMiProductHandbookView:onUpdateParam()
	return
end

function V3a6YaMiProductHandbookView:onOpen()
	AudioMgr.instance:trigger(AudioEnum3_6.YaMi.play_ui_renmen_waiwei_tan)
	V3a6YaMiProductHandbookListModel.instance:setHandbookList()
end

function V3a6YaMiProductHandbookView:onClose()
	return
end

function V3a6YaMiProductHandbookView:onDestroyView()
	return
end

return V3a6YaMiProductHandbookView
