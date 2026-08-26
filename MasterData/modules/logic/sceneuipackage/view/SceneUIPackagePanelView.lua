-- chunkname: @modules/logic/sceneuipackage/view/SceneUIPackagePanelView.lua

module("modules.logic.sceneuipackage.view.SceneUIPackagePanelView", package.seeall)

local SceneUIPackagePanelView = class("SceneUIPackagePanelView", SceneUIPackageBaseView)

function SceneUIPackagePanelView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_close")
	self._btncheck = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_check")
	self._txttime = gohelper.findChildText(self.viewGO, "root/timebg/#txt_time")
	self._imageicon1 = gohelper.findChildImage(self.viewGO, "root/reward1/#image_icon")
	self._imageicon2 = gohelper.findChildImage(self.viewGO, "root/reward2/#image_icon")
	self._imageicon3 = gohelper.findChildImage(self.viewGO, "root/reward3/#image_icon")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SceneUIPackagePanelView:addEvents()
	SceneUIPackagePanelView.super.addEvents(self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function SceneUIPackagePanelView:removeEvents()
	SceneUIPackagePanelView.super.removeEvents(self)
	self._btnclose:RemoveClickListener()
end

function SceneUIPackagePanelView:_btncloseOnClick()
	self:closeThis()
end

function SceneUIPackagePanelView:_editableInitView()
	SceneUIPackagePanelView.super._editableInitView(self)
end

return SceneUIPackagePanelView
