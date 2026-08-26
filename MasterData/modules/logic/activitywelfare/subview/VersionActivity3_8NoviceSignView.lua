-- chunkname: @modules/logic/activitywelfare/subview/VersionActivity3_8NoviceSignView.lua

module("modules.logic.activitywelfare.subview.VersionActivity3_8NoviceSignView", package.seeall)

local VersionActivity3_8NoviceSignView = class("VersionActivity3_8NoviceSignView", BaseView)

function VersionActivity3_8NoviceSignView:onInitView()
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._goactivitysigntitle = gohelper.findChild(self.viewGO, "activityname/#go_activitysigntitle")
	self._txtdesc = gohelper.findChildText(self.viewGO, "activitydesc/tips/#txt_desc")
	self._gostarlist = gohelper.findChild(self.viewGO, "activitydesc/tips/#go_starlist")
	self._gostaricon = gohelper.findChild(self.viewGO, "activitydesc/tips/#go_starlist/#go_staricon")
	self._txtreward = gohelper.findChildText(self.viewGO, "activitydesc/tips/#txt_reward")
	self._gosignitem = gohelper.findChild(self.viewGO, "go_daylist/scroll_item/itemcontent/#go_signitem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity3_8NoviceSignView:addEvents()
	return
end

function VersionActivity3_8NoviceSignView:removeEvents()
	return
end

function VersionActivity3_8NoviceSignView:_editableInitView()
	self:_addSelfEvents()
	self:_initItem()
	Activity101Rpc.instance:sendGet101InfosRequest(self._actId)
end

function VersionActivity3_8NoviceSignView:_initItem()
	self._actId = ActivityEnum.Activity.NoviceSign
	self._signItems = self:getUserDataTb_()

	gohelper.setActive(self._gosignitem, false)
end

function VersionActivity3_8NoviceSignView:_addSelfEvents()
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshNorSignActivity, self._refresh, self)
end

function VersionActivity3_8NoviceSignView:_removeSelfEvents()
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshNorSignActivity, self._refresh, self)
end

function VersionActivity3_8NoviceSignView:onOpen()
	local parentGO = self.viewParam.parent

	gohelper.addChild(parentGO, self.viewGO)
end

function VersionActivity3_8NoviceSignView:_refresh()
	self:_refreshItems()
	self:_refreshContent()
end

function VersionActivity3_8NoviceSignView:_refreshItems()
	local act101Cos = ActivityConfig.instance:getNorSignActivityCos(self._actId)

	for i = 1, #act101Cos do
		if not self._signItems[i] then
			local go = gohelper.cloneInPlace(self._gosignitem)

			gohelper.setActive(go, true)

			self._signItems[i] = VersionActivity3_8NoviceSignItem.New()

			self._signItems[i]:init(go, i)
		end

		self._signItems[i]:refresh(act101Cos[i])
	end
end

function VersionActivity3_8NoviceSignView:_refreshContent()
	return
end

function VersionActivity3_8NoviceSignView:onClose()
	return
end

function VersionActivity3_8NoviceSignView:onDestroyView()
	self:_removeSelfEvents()

	if self._signItems then
		for i = 1, #self._signItems do
			self._signItems[i]:destroy()
		end
	end
end

return VersionActivity3_8NoviceSignView
