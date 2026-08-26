-- chunkname: @modules/logic/dungeon/view/level/DungeonLevelTicketView.lua

module("modules.logic.dungeon.view.level.DungeonLevelTicketView", package.seeall)

local DungeonLevelTicketView = class("DungeonLevelTicketView", BaseChildView)

function DungeonLevelTicketView:onInitView()
	self._goticketinfo = gohelper.findChild(self.viewGO, "#go_ticketinfo")
	self._simageticket = gohelper.findChildSingleImage(self.viewGO, "#go_ticketinfo/#simage_ticket")
	self._txtticket = gohelper.findChildText(self.viewGO, "#go_ticketinfo/#txt_ticket")
	self._gonoticket = gohelper.findChild(self.viewGO, "#go_noticket")
	self._txtnoticket1 = gohelper.findChildText(self.viewGO, "#go_noticket/#txt_noticket1")
	self._txtnoticket2 = gohelper.findChildText(self.viewGO, "#go_noticket/#txt_noticket2")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DungeonLevelTicketView:addEvents()
	return
end

function DungeonLevelTicketView:removeEvents()
	return
end

function DungeonLevelTicketView:_editableInitView()
	self:onUpdateParam()
end

function DungeonLevelTicketView:onUpdateParam()
	local ticketId = self.viewParam

	self._goticketinfo:SetActive(ticketId ~= 0)
	self._gonoticket:SetActive(ticketId == 0)

	if ticketId ~= 0 then
		local icon = ItemConfig.instance:getItemIconById(ticketId)

		self._simageticket:LoadImage(ResUrl.getPropItemIcon(icon))

		self._txtticket.text = ItemModel.instance:getItemCount(ticketId)
	else
		self._txtnoticket1.gameObject:SetActive(self._click ~= nil)
		self._txtnoticket2.gameObject:SetActive(not self._click)
	end
end

function DungeonLevelTicketView:_onClick()
	DungeonController.instance:dispatchEvent(DungeonEvent.OnSelectTicket, self.viewParam)
end

function DungeonLevelTicketView:addClick()
	if self._click then
		return
	end

	self._canvasGroup = gohelper.onceAddComponent(self.viewGO, typeof(UnityEngine.CanvasGroup))
	self._canvasGroup.blocksRaycasts = true
	self._click = SLFramework.UGUI.UIClickListener.Get(self.viewGO)

	self._click:AddClickListener(self._onClick, self)
end

function DungeonLevelTicketView:onOpen()
	return
end

function DungeonLevelTicketView:onClose()
	if self._click then
		self._click:RemoveClickListener()
	end
end

function DungeonLevelTicketView:onDestroyView()
	self._simageticket:UnLoadImage()
end

return DungeonLevelTicketView
