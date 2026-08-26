-- chunkname: @modules/logic/versionactivity3_6/yami/view/handbook/V3a6YaMiHeroHandbookView.lua

module("modules.logic.versionactivity3_6.yami.view.handbook.V3a6YaMiHeroHandbookView", package.seeall)

local V3a6YaMiHeroHandbookView = class("V3a6YaMiHeroHandbookView", BaseView)

function V3a6YaMiHeroHandbookView:onInitView()
	self._gofullbg = gohelper.findChild(self.viewGO, "root/fullbg")
	self._gofundingitem = gohelper.findChild(self.viewGO, "root/#go_fundingitem")
	self._goLine = gohelper.findChild(self.viewGO, "root/scroll_employeelist/viewport/content/#go_Line/Image_Line")
	self._gopanel = gohelper.findChild(self.viewGO, "root/#go_panel")
	self._gotopleft = gohelper.findChild(self.viewGO, "root/#go_topleft")
	self._btnmask = gohelper.getClick(self._gofullbg)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a6YaMiHeroHandbookView:addEvents()
	self._btnmask:AddClickListener(self.closeThis, self)
	self.addEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onUnlockHero, self._onUnlockHero, self)
end

function V3a6YaMiHeroHandbookView:removeEvents()
	self._btnmask:RemoveClickListener()
	self.removeEventCb(self, V3a6YaMiController.instance, V3a6YaMiEvent.onUnlockHero, self._onUnlockHero, self)
end

function V3a6YaMiHeroHandbookView:_editableInitView()
	return
end

function V3a6YaMiHeroHandbookView:onUpdateParam()
	return
end

function V3a6YaMiHeroHandbookView:onOpen()
	AudioMgr.instance:trigger(AudioEnum3_6.YaMi.play_ui_renmen_waiwei_tan)
	V3a6YaMiHeroHandbookListModel.instance:setHandbookList(1)

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

function V3a6YaMiHeroHandbookView:_onUnlockHero()
	V3a6YaMiHeroHandbookListModel.instance:onModelUpdate()
end

function V3a6YaMiHeroHandbookView:_getLine(index)
	local item = self._lineItems[index]

	if not item then
		item = index == 1 and self._goLine or gohelper.cloneInPlace(self._goLine)
		self._lineItems[index] = item
	end

	return item
end

function V3a6YaMiHeroHandbookView:onClose()
	return
end

function V3a6YaMiHeroHandbookView:onDestroyView()
	return
end

return V3a6YaMiHeroHandbookView
