-- chunkname: @modules/logic/explore/view/ExploreGetItemView.lua

module("modules.logic.explore.view.ExploreGetItemView", package.seeall)

local ExploreGetItemView = class("ExploreGetItemView", BaseView)

function ExploreGetItemView:onInitView()
	self._simagepropicon = gohelper.findChildSingleImage(self.viewGO, "#simage_propicon")
	self._txtpropname = gohelper.findChildText(self.viewGO, "#txt_propname")
	self._txtdesc = gohelper.findChildTextMesh(self.viewGO, "#txt_desc")
	self._txtdesc2 = gohelper.findChildTextMesh(self.viewGO, "Scroll View/Viewport/Content/#txt_usedesc")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ExploreGetItemView:addEvents()
	return
end

function ExploreGetItemView:removeEvents()
	return
end

function ExploreGetItemView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.Va3Aact120.play_ui_molu_jlbn_level_unlock)

	self._config = ExploreConfig.instance:getItemCo(self.viewParam.id)

	self._simagepropicon:LoadImage(ResUrl.getPropItemIcon(self._config.icon))

	self._txtpropname.text = self._config.name
	self._txtdesc.text = self._config.desc
	self._txtdesc2.text = self._config.desc2
end

function ExploreGetItemView:onClose()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_feedback_close)
	ExploreController.instance:dispatchEvent(ExploreEvent.ShowBagBtn)
end

function ExploreGetItemView:onDestroyView()
	self._simagepropicon:UnLoadImage()
end

return ExploreGetItemView
