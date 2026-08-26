-- chunkname: @modules/logic/versionactivity3_6/yami/view/game/V3a6YaMiSelectHeroHandbookView.lua

module("modules.logic.versionactivity3_6.yami.view.game.V3a6YaMiSelectHeroHandbookView", package.seeall)

local V3a6YaMiSelectHeroHandbookView = class("V3a6YaMiSelectHeroHandbookView", BaseView)

function V3a6YaMiSelectHeroHandbookView:onInitView()
	self._gofundingitem = gohelper.findChild(self.viewGO, "root/#go_fundingitem")
	self._gopanel = gohelper.findChild(self.viewGO, "root/#go_panel")
	self._btncancel = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_cancel")
	self._btnok = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_ok")
	self._goLine = gohelper.findChild(self.viewGO, "root/scroll_employeelist/viewport/content/#go_Line/Image_Line")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a6YaMiSelectHeroHandbookView:addEvents()
	self._btncancel:AddClickListener(self._btncancelOnClick, self)
	self._btnok:AddClickListener(self._btnokOnClick, self)
	self.addEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onUnlockHero, self._onUnlockHero, self, LuaEventSystem.Low)
	self.addEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onEnterPerform, self.closeThis, self)
end

function V3a6YaMiSelectHeroHandbookView:removeEvents()
	self._btncancel:RemoveClickListener()
	self._btnok:RemoveClickListener()
	self.removeEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onUnlockHero, self._onUnlockHero, self)
	self.removeEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onEnterPerform, self.closeThis, self)
end

function V3a6YaMiSelectHeroHandbookView:_btncancelOnClick()
	self.viewContainer:correcteSelectHeros()
	V3a6YaMiHeroHandbookListModel.instance:onModelUpdate()
	self:closeThis()
end

function V3a6YaMiSelectHeroHandbookView:_btnokOnClick()
	self.viewContainer:onConfirmSelectHeros()
	V3a6YaMiController.instance:dispatchEvent(V3a6YaMiEvent.onConfirmSelectHeros)
	self:closeThis()
end

function V3a6YaMiSelectHeroHandbookView:_onUnlockHero()
	self:_refreshView()
end

function V3a6YaMiSelectHeroHandbookView:_editableInitView()
	self.addEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onSelectHeroHandbook, self._onSelectHeroHandbook, self)
end

function V3a6YaMiSelectHeroHandbookView:_onSelectHeroHandbook()
	self:_refreshView()
	V3a6YaMiHeroHandbookListModel.instance:onModelUpdate()
end

function V3a6YaMiSelectHeroHandbookView:_refreshView()
	return
end

function V3a6YaMiSelectHeroHandbookView:_isSelectHeros()
	local count = self.viewContainer:getSelectHeroCount()

	return count and count > 0
end

function V3a6YaMiSelectHeroHandbookView:onOpen()
	AudioMgr.instance:trigger(AudioEnum3_6.YaMi.play_ui_renmen_waiwei_tan)
	self.viewContainer:correcteSelectHeros()
	self:_refreshView()

	local moList = V3a6YaMiHeroHandbookListModel.instance:getList()

	if moList then
		if not #moList then
			local count = 0
			local line = (count - 1) / V3a6YaMiEnum.HeroHandbookRowCount

			self._lineItems = self:getUserDataTb_()

			if line > 0 then
				for i = 1, line do
					local item = self:_getLine(i)

					recthelper.setAnchorY(item.transform, V3a6YaMiEnum.HeroHandbookItemHight * (i - 2))
				end
			end
		end
	end
end

function V3a6YaMiSelectHeroHandbookView:_getLine(index)
	local item = self._lineItems[index]

	if not item then
		item = index == 1 and self._goLine or gohelper.cloneInPlace(self._goLine)
		self._lineItems[index] = item
	end

	return item
end

function V3a6YaMiSelectHeroHandbookView:onClose()
	self.viewContainer:correcteSelectHeros()
	V3a6YaMiHeroHandbookListModel.instance:onModelUpdate()
	V3a6YaMiHeroHandbookListModel.instance:setSelectIndex()
end

function V3a6YaMiSelectHeroHandbookView:onDestroyView()
	self.removeEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onSelectHeroHandbook, self._onSelectHeroHandbook, self)
end

return V3a6YaMiSelectHeroHandbookView
