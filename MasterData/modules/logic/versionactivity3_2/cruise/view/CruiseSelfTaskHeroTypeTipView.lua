-- chunkname: @modules/logic/versionactivity3_2/cruise/view/CruiseSelfTaskHeroTypeTipView.lua

module("modules.logic.versionactivity3_2.cruise.view.CruiseSelfTaskHeroTypeTipView", package.seeall)

local CruiseSelfTaskHeroTypeTipView = class("CruiseSelfTaskHeroTypeTipView", BaseView)

function CruiseSelfTaskHeroTypeTipView:onInitView()
	self._txtTitle = gohelper.findChildText(self.viewGO, "#txt_Title")
	self._txtTitle2 = gohelper.findChildText(self.viewGO, "#txt_Title2")
	self._gotypeItem = gohelper.findChild(self.viewGO, "scroll_types/Viewport/content/#go_typeItem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CruiseSelfTaskHeroTypeTipView:addEvents()
	return
end

function CruiseSelfTaskHeroTypeTipView:removeEvents()
	return
end

function CruiseSelfTaskHeroTypeTipView:_btnCloseOnClick()
	self:closeThis()
end

function CruiseSelfTaskHeroTypeTipView:_addSelfEvents()
	self._bgClick:AddClickListener(self._btnCloseOnClick, self)
end

function CruiseSelfTaskHeroTypeTipView:_removeSelfEvents()
	self._bgClick:RemoveClickListener()
end

function CruiseSelfTaskHeroTypeTipView:_editableInitView()
	local bg = gohelper.findChild(self.viewGO, "bg")

	self._bgClick = gohelper.getClickWithAudio(bg)
	self._heroTypeItems = {}

	gohelper.setActive(self._gotypeItem, false)
	self:_addSelfEvents()
end

function CruiseSelfTaskHeroTypeTipView:onUpdateParam()
	return
end

function CruiseSelfTaskHeroTypeTipView:onOpen()
	NavigateMgr.instance:addEscape(self.viewName, self._btnCloseOnClick, self)
	self:_refreshUI()
	self:_refreshHeroTypes()
end

function CruiseSelfTaskHeroTypeTipView:_refreshUI()
	return
end

function CruiseSelfTaskHeroTypeTipView:_refreshHeroTypes()
	local typeCos = Activity216Config.instance:getHeroRangeCos()

	for i = 1, #typeCos do
		if not self._heroTypeItems[i] then
			local go = gohelper.cloneInPlace(self._gotypeItem)

			self._heroTypeItems[i] = CruiseSelfTaskHeroTypeItem.New()

			self._heroTypeItems[i]:init(go)
		end

		self._heroTypeItems[i]:refresh(typeCos[i])
	end
end

function CruiseSelfTaskHeroTypeTipView:onClose()
	return
end

function CruiseSelfTaskHeroTypeTipView:onDestroyView()
	if self._heroTypeItems then
		for _, typeItem in pairs(self._heroTypeItems) do
			typeItem:destroy()
		end

		self._heroTypeItems = nil
	end

	self:_removeSelfEvents()
end

return CruiseSelfTaskHeroTypeTipView
