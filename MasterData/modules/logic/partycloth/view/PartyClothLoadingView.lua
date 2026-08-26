-- chunkname: @modules/logic/partycloth/view/PartyClothLoadingView.lua

module("modules.logic.partycloth.view.PartyClothLoadingView", package.seeall)

local PartyClothLoadingView = class("PartyClothLoadingView", BaseView)

function PartyClothLoadingView:onInitView()
	if self._editableInitView then
		self:_editableInitView()
	end
end

function PartyClothLoadingView:addEvents()
	return
end

function PartyClothLoadingView:removeEvents()
	return
end

function PartyClothLoadingView:onClickModalMask()
	return
end

function PartyClothLoadingView:_editableInitView()
	return
end

function PartyClothLoadingView:onOpen()
	AudioMgr.instance:trigger(AudioEnum3_4.PartyCloth.chouka)
	TaskDispatcher.runDelay(self.closeThis, self, 3)
end

function PartyClothLoadingView:onClose()
	ViewMgr.instance:openView(ViewName.PartyClothRewardView, self.viewParam)
end

return PartyClothLoadingView
