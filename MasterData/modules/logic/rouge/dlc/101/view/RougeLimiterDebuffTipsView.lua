-- chunkname: @modules/logic/rouge/dlc/101/view/RougeLimiterDebuffTipsView.lua

module("modules.logic.rouge.dlc.101.view.RougeLimiterDebuffTipsView", package.seeall)

local RougeLimiterDebuffTipsView = class("RougeLimiterDebuffTipsView", BaseView)

function RougeLimiterDebuffTipsView:onInitView()
	self._gobuffdec = gohelper.findChild(self.viewGO, "#go_buffdec")
	self._btncheck = gohelper.findChildButtonWithAudio(self.viewGO, "#go_buffdec/#btn_check")
	self._imagebufficon = gohelper.findChildImage(self.viewGO, "#go_buffdec/#image_bufficon")
	self._txtbufflevel = gohelper.findChildText(self.viewGO, "#go_buffdec/#txt_bufflevel")
	self._txtdec = gohelper.findChildText(self.viewGO, "#go_buffdec/#txt_dec")
	self._txtname = gohelper.findChildText(self.viewGO, "#go_buffdec/#txt_name")
	self._imagepoint = gohelper.findChildImage(self.viewGO, "#go_buffdec/#image_point")
	self._txtcost = gohelper.findChildText(self.viewGO, "#go_buffdec/#txt_cost")
	self._txtbuffdec = gohelper.findChildText(self.viewGO, "#go_buffdec/#txt_buffdec")
	self._btnequip = gohelper.findChildButtonWithAudio(self.viewGO, "#go_buffdec/btnContain/#btn_equip")
	self._btnunequip = gohelper.findChildButtonWithAudio(self.viewGO, "#go_buffdec/btnContain/#btn_unequip")
	self._btncostunlock = gohelper.findChildButtonWithAudio(self.viewGO, "#go_buffdec/btnContain/#btn_costunlock")
	self._txtnum = gohelper.findChildText(self.viewGO, "#go_buffdec/btnContain/#btn_costunlock/#txt_num")
	self._imageicon = gohelper.findChildImage(self.viewGO, "#go_buffdec/btnContain/#btn_costunlock/#txt_num/#image_icon")
	self._btnspeedup = gohelper.findChildButtonWithAudio(self.viewGO, "#go_buffdec/btnContain/#btn_speedup")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeLimiterDebuffTipsView:addEvents()
	self._btncheck:AddClickListener(self._btncheckOnClick, self)
end

function RougeLimiterDebuffTipsView:removeEvents()
	self._btncheck:RemoveClickListener()
end

function RougeLimiterDebuffTipsView:_btncheckOnClick()
	local limiterClientMo = RougeDLCModel101.instance:getLimiterClientMo()
	local limiterIds = limiterClientMo and limiterClientMo:getLimitIds()
	local buffIds = RougeDLCModel101.instance:getAllLimiterBuffIds()
	local totalRiskValue = RougeDLCModel101.instance:getTotalRiskValue()
	local params = {
		limiterIds = limiterIds,
		buffIds = buffIds,
		totalRiskValue = totalRiskValue
	}

	RougeDLCController101.instance:openRougeLimiterOverView(params)
end

function RougeLimiterDebuffTipsView:_editableInitView()
	self.addEventCb(self, RougeDLCController101.instance, RougeDLCEvent101.RefreshLimiterDebuffTips, self._onRefreshLimiterDebuffTips, self)

	self._animator = gohelper.onceAddComponent(self._gobuffdec, gohelper.Type_Animator)
end

function RougeLimiterDebuffTipsView:onUpdateParam()
	self:refreshDebuffTips()
end

function RougeLimiterDebuffTipsView:onOpen()
	self:refreshDebuffTips()
end

function RougeLimiterDebuffTipsView:refreshDebuffTips(limiterGroupId)
	self._preLimiterGroupId = self._curLimiterGroupId
	self._preLimiterGroupLv = self._curLimiterGroupLv

	local limiterGroupLv = RougeDLCModel101.instance:getCurLimiterGroupLv(limiterGroupId)

	if limiterGroupLv <= 0 then
		limiterGroupId = self:getNeedShowLimiterGroupId()
	end

	self._curLimiterGroupId = limiterGroupId or self:getNeedShowLimiterGroupId()

	if self._curLimiterGroupId then
		local needShowTips = self._curLimiterGroupId > 0

		gohelper.setActive(self._gobuffdec, needShowTips)

		if not needShowTips then
			self._preLimiterGroupId = nil
			self._curLimiterGroupId = nil

			return
		end

		self._curLimiterGroupLv = RougeDLCModel101.instance:getCurLimiterGroupLv(self._curLimiterGroupId)

		local limiterCo = RougeDLCConfig101.instance:getLimiterCoByGroupIdAndLv(self._curLimiterGroupId, self._curLimiterGroupLv)
		local limiterGroupCo = RougeDLCConfig101.instance:getLimiterGroupCo(self._curLimiterGroupId)

		self._txtname.text = limiterCo and limiterCo.title
		self._txtdec.text = limiterCo and limiterCo.desc
		self._txtcost.text = limiterCo and limiterCo.riskValue
		self._txtbufflevel.text = GameUtil.getRomanNums(self._curLimiterGroupLv)

		UISpriteSetMgr.instance:setRouge4Sprite(self._imagebufficon, limiterGroupCo.icon)
	end
end

function RougeLimiterDebuffTipsView:getNeedShowLimiterGroupId()
	local selectGroupIds = RougeDLCModel101.instance:getSelectLimiterGroupIds()

	if selectGroupIds then
		if not #selectGroupIds then
			local selectGroupCount = 0

			return selectGroupIds and selectGroupIds[selectGroupCount]
		end
	end
end

function RougeLimiterDebuffTipsView:_onRefreshLimiterDebuffTips(limiterGroupId)
	self:refreshDebuffTips(limiterGroupId)
	self:try2PlayRefreshAnim(limiterGroupId)
end

function RougeLimiterDebuffTipsView:try2PlayRefreshAnim(limiterGroupId)
	local isNeed = self:isNeedPlayRefreshAnim(limiterGroupId)

	if not isNeed then
		return
	end

	self._animator:Play("refresh", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.UI.RefreshLimiterTips)
end

function RougeLimiterDebuffTipsView:isNeedPlayRefreshAnim()
	if not self._curLimiterGroupId and not self._preLimiterGroupId then
		return false
	end

	if self._curLimiterGroupId == self._preLimiterGroupId and self._preLimiterGroupLv == self._curLimiterGroupLv then
		return false
	end

	return true
end

function RougeLimiterDebuffTipsView:onClose()
	return
end

function RougeLimiterDebuffTipsView:onDestroyView()
	return
end

return RougeLimiterDebuffTipsView
