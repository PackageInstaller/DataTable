-- chunkname: @modules/logic/gm/view/GMFightEntityView.lua

module("modules.logic.gm.view.GMFightEntityView", package.seeall)

local GMFightEntityView = class("GMFightEntityView", BaseView)

GMFightEntityView.Evt_OnGetEntityDetailInfos = GameUtil.getEventId()
GMFightEntityView.Evt_SelectHero = GameUtil.getEventId()

function GMFightEntityView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "btnClose")
end

function GMFightEntityView:addEvents()
	self._btnClose:AddClickListener(self.closeThis, self)
end

function GMFightEntityView:removeEvents()
	self._btnClose:RemoveClickListener()
end

function GMFightEntityView:onOpen()
	GMFightEntityModel.instance:onOpen()

	local firstEntityMO = GMFightEntityModel.instance:getList()[1]

	if firstEntityMO then
		self.viewContainer.entityListView:setSelect(firstEntityMO)
	end
end

function GMFightEntityView:onClose()
	ViewMgr.instance:openView(ViewName.GMToolView)
end

return GMFightEntityView
