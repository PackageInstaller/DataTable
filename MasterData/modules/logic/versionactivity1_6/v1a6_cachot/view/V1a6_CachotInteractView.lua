-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotInteractView.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotInteractView", package.seeall)

local V1a6_CachotInteractView = class("V1a6_CachotInteractView", BaseView)

function V1a6_CachotInteractView:onInitView()
	self._btnFullScreen = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_fullscreen")
	self._goChoiceItemParent = gohelper.findChild(self.viewGO, "choices/#go_choicelist")
	self._goChoiceItem = gohelper.findChild(self.viewGO, "choices/#go_choicelist/#go_choiceitem")
end

function V1a6_CachotInteractView:addEvents()
	self._btnFullScreen:AddClickListener(self._clickFull, self)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.ShowHideChoice, self.showHideChoice, self)
end

function V1a6_CachotInteractView:removeEvents()
	self._btnFullScreen:RemoveClickListener()
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.ShowHideChoice, self.showHideChoice, self)
end

function V1a6_CachotInteractView:_clickFull()
	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.SelectChoice, -1)
end

function V1a6_CachotInteractView:onOpen()
	gohelper.setActive(self._goChoiceItemParent, false)
end

function V1a6_CachotInteractView:showHideChoice(data)
	if data then
		gohelper.setActive(self._goChoiceItemParent, true)
		gohelper.CreateObjList(self, self._createItem, data, self._goChoiceItemParent, self._goChoiceItem, V1a6_CachotInteractChoiceItem)
	else
		gohelper.setActive(self._goChoiceItemParent, false)
	end
end

function V1a6_CachotInteractView:_createItem(obj, data, index)
	obj:updateMo(data, index)
end

function V1a6_CachotInteractView:onClose()
	return
end

return V1a6_CachotInteractView
