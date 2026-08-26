-- chunkname: @modules/logic/rouge/dlc/101/view/RougeLimiterLockedTipsView.lua

module("modules.logic.rouge.dlc.101.view.RougeLimiterLockedTipsView", package.seeall)

local RougeLimiterLockedTipsView = class("RougeLimiterLockedTipsView", BaseView)

function RougeLimiterLockedTipsView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._scrolltips = gohelper.findChildScrollRect(self.viewGO, "#scroll_tips")
	self._imagebufficon = gohelper.findChildImage(self.viewGO, "#scroll_tips/Viewport/Content/top/#image_bufficon")
	self._txtbufflevel = gohelper.findChildText(self.viewGO, "#scroll_tips/Viewport/Content/top/#txt_bufflevel")
	self._txtbuffname = gohelper.findChildText(self.viewGO, "#scroll_tips/Viewport/Content/top/#txt_buffname")
	self._godesccontainer = gohelper.findChild(self.viewGO, "#scroll_tips/Viewport/Content/#go_desccontainer")
	self._txtdecitem = gohelper.findChildText(self.viewGO, "#scroll_tips/Viewport/Content/#go_desccontainer/#txt_decitem")
	self._txttips = gohelper.findChildText(self.viewGO, "#scroll_tips/Viewport/Content/#txt_tips")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeLimiterLockedTipsView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function RougeLimiterLockedTipsView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function RougeLimiterLockedTipsView:_btncloseOnClick()
	self:closeThis()
end

function RougeLimiterLockedTipsView:_editableInitView()
	return
end

function RougeLimiterLockedTipsView:onUpdateParam()
	return
end

function RougeLimiterLockedTipsView:onOpen()
	self:refreshUnlockedTips()
	AudioMgr.instance:trigger(AudioEnum.UI.OpenRougeLimiterLockedTips)
end

function RougeLimiterLockedTipsView:refreshUnlockedTips()
	self._limiterGroupId = self.viewParam and self.viewParam.limiterGroupId

	local limiterGroupCo = RougeDLCConfig101.instance:getLimiterGroupCo(self._limiterGroupId)
	local limiterGroupMaxLv = RougeDLCConfig101.instance:getLimiterGroupMaxLevel(self._limiterGroupId)
	local maxLvLimiterCo = RougeDLCConfig101.instance:getLimiterCoByGroupIdAndLv(self._limiterGroupId, limiterGroupMaxLv)

	self._txtbufflevel.text = GameUtil.getRomanNums(limiterGroupMaxLv)
	self._txtbuffname.text = limiterGroupCo and limiterGroupCo.title
	self._txttips.text = limiterGroupCo and limiterGroupCo.desc

	UISpriteSetMgr.instance:setRouge4Sprite(self._imagebufficon, limiterGroupCo.icon)
	self:_refreshLimiterGroupDesc()
end

function RougeLimiterLockedTipsView:_refreshLimiterGroupDesc()
	local limiterCos = RougeDLCConfig101.instance:getAllLimiterCosInGroup(self._limiterGroupId)

	gohelper.CreateObjList(self, self._refreshGroupDesc, limiterCos, self._godesccontainer, self._txtdecitem.gameObject)
end

function RougeLimiterLockedTipsView:_refreshGroupDesc(obj, limiterCo, index)
	local txtdesc = gohelper.onceAddComponent(obj, gohelper.Type_TextMesh)

	txtdesc.text = limiterCo and limiterCo.desc
end

function RougeLimiterLockedTipsView:onClose()
	return
end

function RougeLimiterLockedTipsView:onDestroyView()
	return
end

return RougeLimiterLockedTipsView
