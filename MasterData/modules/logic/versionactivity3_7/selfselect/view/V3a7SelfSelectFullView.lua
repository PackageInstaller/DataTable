-- chunkname: @modules/logic/versionactivity3_7/selfselect/view/V3a7SelfSelectFullView.lua

module("modules.logic.versionactivity3_7.selfselect.view.V3a7SelfSelectFullView", package.seeall)

local V3a7SelfSelectFullView = class("V3a7SelfSelectFullView", BaseView)

function V3a7SelfSelectFullView:onInitView()
	self._simageFullBG = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_FullBG")
	self._simageTitle = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_Title")
	self._simagerole = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_role")
	self._simagedec1 = gohelper.findChildSingleImage(self.viewGO, "Root/#simage_dec1")
	self._txtLimitTime = gohelper.findChildText(self.viewGO, "Root/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	self._txtnum1 = gohelper.findChildText(self.viewGO, "Root/reward/#txt_num")
	self._btnreward = gohelper.findChildButtonWithAudio(self.viewGO, "Root/reward/#btn_reward")
	self._btnreward1 = gohelper.findChildButtonWithAudio(self.viewGO, "Root/reward/#btn_reward1")
	self._btnstone = gohelper.findChildButtonWithAudio(self.viewGO, "Root/stone/#btn_stone")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "Root/stone/go_reward/#simage_icon")
	self._txtnum = gohelper.findChildText(self.viewGO, "Root/stone/go_reward/txtbg/#txt_num")
	self._goclaim = gohelper.findChild(self.viewGO, "Root/stone/go_reward/#go_claim")
	self._btnclaim = gohelper.findChildButtonWithAudio(self.viewGO, "Root/stone/go_reward/#go_claim/#btn_claim")
	self._gohasget = gohelper.findChild(self.viewGO, "Root/stone/go_reward/#go_hasget")
	self._btnbuy = gohelper.findChildButtonWithAudio(self.viewGO, "Root/Btn/#btn_buy")
	self._gohasbuy = gohelper.findChild(self.viewGO, "Root/Btn/#go_hasbuy")
	self._btnsignreward = gohelper.getClick(self._simageicon.gameObject)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a7SelfSelectFullView:addEvents()
	self._btnreward:AddClickListener(self._btnrewardOnClick, self)
	self._btnreward1:AddClickListener(self._btnreward1OnClick, self)
	self._btnstone:AddClickListener(self._btnstoneOnClick, self)
	self._btnclaim:AddClickListener(self._btnclaimOnClick, self)
	self._btnbuy:AddClickListener(self._btnbuyOnClick, self)
	self._btnsignreward:AddClickListener(self._btnsignrewardOnClick, self)
	self.addEventCb(self, PayController.instance, PayEvent.PayInfoChanged, self._onPayInfoChanged, self)
end

function V3a7SelfSelectFullView:removeEvents()
	self._btnreward:RemoveClickListener()
	self._btnreward1:RemoveClickListener()
	self._btnstone:RemoveClickListener()
	self._btnclaim:RemoveClickListener()
	self._btnbuy:RemoveClickListener()
	self._btnsignreward:RemoveClickListener()
	self.removeEventCb(self, PayController.instance, PayEvent.PayInfoChanged, self._onPayInfoChanged, self)
end

function V3a7SelfSelectFullView:_btnsignrewardOnClick()
	if not self._signRewardItem then
		return
	end

	MaterialTipController.instance:showMaterialInfo(self._signRewardItem[1], self._signRewardItem[2])
end

function V3a7SelfSelectFullView:_btnclaimOnClick()
	Activity101Rpc.instance:sendGet101BonusRequest(self.actId, self._index, self._refreshGet, self)
end

function V3a7SelfSelectFullView:_btnrewardOnClick()
	if self._items then
		if not self._items then
			return
		end

		MaterialTipController.instance:showMaterialInfo(self._items[1], self._items[2])
	end
end

function V3a7SelfSelectFullView:_btnreward1OnClick()
	if self._items then
		if not self._items then
			return
		end

		MaterialTipController.instance:showMaterialInfo(self._items[1], self._items[2])
	end
end

function V3a7SelfSelectFullView:_btnstoneOnClick()
	if self._items then
		ViewMgr.instance:openView(ViewName.V3a7SelfSelectPickView, self._items)
	end
end

function V3a7SelfSelectFullView:_btnbuyOnClick()
	if not self._goodsId then
		return
	end

	PayController.instance:startPay(self._goodsId)
end

function V3a7SelfSelectFullView:_editableInitView()
	return
end

function V3a7SelfSelectFullView:onUpdateParam()
	return
end

function V3a7SelfSelectFullView:onOpen()
	local parentGO = self.viewParam.parent

	gohelper.addChild(parentGO, self.viewGO)

	self.actId = self.viewParam.actId
	self._index = 1

	local actCo = ActivityConfig.instance:getActivityCo(self.actId)

	if not actCo or string.nilorempty(actCo.patFaceParam) then
		logError("未配置该活动对应的商品id:actId = " .. self.actId)

		return
	end

	self._goodsId = tonumber(actCo.patFaceParam)
	self._goodsMo = StoreModel.instance:getGoodsMO(self._goodsId)
	self._goodsCo = StoreConfig.instance:getChargeGoodsConfig(self._goodsId)
	self._items = self._goodsCo and GameUtil.splitString2(self._goodsCo.item, true)
	self._txtnum1.text = self._items and self._items[2] and luaLang("multiple") .. self._items[2][3]

	TaskDispatcher.cancelTask(self._refreshTime, self)
	self:_refreshTime()
	TaskDispatcher.runRepeat(self._refreshTime, self, TimeUtil.OneMinuteSecond)
	self:_refreshView()
end

function V3a7SelfSelectFullView:_refreshTime()
	if not self._txtLimitTime then
		return
	end

	self._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(self.actId)
end

function V3a7SelfSelectFullView:_refreshView()
	local co = ActivityType101Config.instance:getDayCO(self.actId, self._index)

	if co and not string.nilorempty(co.bonus) then
		self._signRewardItem = string.splitToNumber(co.bonus, "#")

		local _, icon = ItemModel.instance:getItemConfigAndIcon(self._signRewardItem[1], self._signRewardItem[2])

		self._simageicon:LoadImage(icon)

		self._txtnum.text = luaLang("multiple") .. self._signRewardItem[3]
	end

	self:_refreshGet()
	self:_refreshPay()
end

function V3a7SelfSelectFullView:_refreshGet()
	local couldGet = self:_isCanGet()

	gohelper.setActive(self._goclaim, couldGet)
	gohelper.setActive(self._gohasget, not couldGet)
end

function V3a7SelfSelectFullView:_refreshPay()
	if self._goodsMo then
		local isSoldOut = self._goodsMo:isSoldOut()

		gohelper.setActive(self._gohasbuy, self._goodsMo)
		gohelper.setActive(self._btnbuy.gameObject, not self._goodsMo)
	end
end

function V3a7SelfSelectFullView:_isCanGet()
	local couldGet = ActivityType101Model.instance:isType101RewardCouldGet(self.actId, self._index)

	if not couldGet then
		return false
	end

	return true
end

function V3a7SelfSelectFullView:_onPayInfoChanged()
	self:_refreshPay()
end

function V3a7SelfSelectFullView:onClose()
	return
end

function V3a7SelfSelectFullView:onDestroyView()
	TaskDispatcher.cancelTask(self._refreshTime, self)
	self._simageicon:UnLoadImage()
end

return V3a7SelfSelectFullView
