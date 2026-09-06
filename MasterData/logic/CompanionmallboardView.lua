-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/companionmall/view/CompanionmallboardView.lua

module("logic.extensions.companionmall.view.CompanionmallboardView", package.seeall)

local CompanionmallboardView = class("CompanionmallboardView", ViewComponent)

function CompanionmallboardView:ctor()
	CompanionmallboardView.super.ctor(self)
end

function CompanionmallboardView:unbindEvents()
	CompanionmallboardView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnGet)
	GameUtil.rmClickHandler(self._btnHelp)
end

function CompanionmallboardView:bindEvents()
	CompanionmallboardView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnGet, self._onClickGo, self)
	GameUtil.addClickHandler(self._btnHelp, self._onClickHelp, self)
end

function CompanionmallboardView:buildUI()
	CompanionmallboardView.super.buildUI(self)

	self._btnGet = self:getGo("btnGet")
	self._btnHelp = self:getGo("btnHelp")
	self._txtCount = self:getTxt("txtCount")
	self._txtDesc = self:getTxt("txtDesc")
	self._txtGet = self:getTxt("btnGet/txt")
	self._getChangeGroup = self._btnGet:GetComponent(ComponentType.UIChangeGroup)
	self._imgShow = self:getGo("imgShow")
	self._txtTitle = self:getTxt("txtTitle")
	self._tablecell = self:getGo("tableview/tablecell")
	self._tableview = self:getGo("tableview")
	self._scrollList = ScrollerList.create(self._tableview, self._tablecell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))

	self._scrollList:setCenterMode(true)

	self._eff = self:getGo("eff")
end

function CompanionmallboardView:onExit()
	CompanionmallboardView.super.onExit(self)
	uGuiUtil.clearImage(self._imgShow)
	self._scrollList:dispose()
	self:_stopEff()
end

function CompanionmallboardView:onEnter()
	CompanionmallboardView.super.onEnter(self)

	local params = self:getOpenParam() or {}
	local activityId = checknumber(params[1])

	self._activityId = activityId == 0 and CompanionMallController.instance:getDefaultActId() or activityId
	self._companionId = checknumber(params[2])

	local itemCfg = CompanionMallConfig.instance:getItemCfgById(self._activityId, self._companionId) or {}
	local list = string.split(itemCfg.content or "", "#")

	self._scrollList:reloadData(list)

	self._limitTimes = itemCfg.limitTimes
	self._itemCfg = itemCfg

	self.addGEvent(self, GlobalNotify.COMPANION_MALL_GET_INFO, self._refreshUI, self)
	self.addGEvent(self, GlobalNotify.COMPANION_MALL_GAIN_OK, self._onGainOk, self)
	CompanionMallController.instance:sendGetInfo(self._activityId)
	self:_onSetUI()
	self:_refreshUI()
end

function CompanionmallboardView:_onGainOk()
	TipsFacade.instance:openCommonTips("成功领取周边")
	self:_refreshUI()
	UIStateManager.instance:push(ViewName.CompanionMallAddressBookPopView, self._activityId, self._companionId)
end

function CompanionmallboardView:_onSetUI()
	self._txtTitle.text = self._itemCfg.name

	local path = string.format("ui/bigbg/views/huodong/zhoubianshangcheng/%s.png", self._itemCfg.path)

	uGuiUtil.setSpriteToImage(self._imgShow, uGuiUtil.SpriteType.BigBg, path)
end

function CompanionmallboardView:_refreshUI()
	local info = CompanionMallModel.instance:getInfo(self._activityId) or {}

	if not info.companionInfo then
		local companionInfoList = {}

		self._curGlobalGainCount = 0
		self._hasGainCompanion = false
		self._hasSubmitAddress = false
		self._hasFinishAll = false

		for i, v in ipairs(companionInfoList) do
			if v.companionId == self._companionId then
				self._hasGainCompanion = v.hasGainCompanion
				self._hasSubmitAddress = v.hasSubmitAddress
				self._curGlobalGainCount = v.curGlobalGainCount
				self._hasFinishAll = checkbool(v.hasBuyCompanion)

				break
			end
		end

		self._txtCount.text = langPara("剩余：%s/%s", math.max(0, self._limitTimes - self._curGlobalGainCount), self._limitTimes)
		self._txtDesc.text = lang("周边详情请查阅[购物须知]")
		self._txtGet.text = "购买"

		local payCfg = PayConfig.instance:getPayGoodsCfg(self._itemCfg.goodsId)

		if payCfg then
			local cost = payCfg.payMoney / 100

			self._txtGet.text = "￥" .. cost

			self._getChangeGroup:SetState(0)
		end

		if self._hasGainCompanion or self._hasFinishAll then
			self._txtGet.text = self._hasSubmitAddress and "修改地址" or "填写地址"

			self._getChangeGroup:SetState(1)
			self:_stopEff()
		end

		if not self._hasGainCompanion and self._hasFinishAll then
			self._txtGet.text = "领取周边"

			self:_playEff()
		end
	end
end

function CompanionmallboardView:_updateCell(view, cell, data, tag)
	MaterialMgr.setCellByCfg(data, cell)
end

function CompanionmallboardView:_clearCell(cell)
	MaterialMgr.resetAll(cell)
end

function CompanionmallboardView:_onClickHelp()
	local key = self._itemCfg.ruleKey

	TipsFacade.instance:openRulesView(key)
end

function CompanionmallboardView:_onClickGo()
	if self._hasFinishAll then
		if not self._hasGainCompanion then
			CompanionMallController.instance:sendGainCompanion(self._activityId, self._companionId)
		else
			UIStateManager.instance:push(ViewName.CompanionMallAddressBookPopView, self._activityId, self._companionId)
		end
	else
		local goodsId = self._itemCfg.goodsId
		local subGoodsType = GameEnum.PaySubGoodsType.COMPANION_MALL
		local subGoodsId = self._activityId
		local para = {}

		para.cpnId = self._companionId

		local extParams = GameUtil.jsonToString(para)

		PayController.instance:pay(goodsId, subGoodsType, subGoodsId, extParams)
	end
end

local effPath = "20211217/anniu/fx_ui_anniu.prefab"

function CompanionmallboardView:_playEff()
	if self._effect then
		UIEffectManager.instance:stopEffect(self._effect)

		self._effect = nil
	end

	self._effect = UIEffectManager.instance:playEffect(self, effPath, self._eff.transform, 0, 0, true, false, nil, function(target, eff)
		eff:setClipping(self.mainGO.transform)
	end)

	self._effect:setParent(self._eff.transform)
	self._effect:setLocalPos(0, 0, 0)
	self._effect:setScale(1)
end

function CompanionmallboardView:_stopEff()
	if self._effect then
		UIEffectManager.instance:stopEffect(self._effect)

		self._effect = nil
	end
end

return CompanionmallboardView
