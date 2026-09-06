-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firstcharge/view/PetSkinSellConfigView.lua

module("logic.extensions.firstcharge.view.PetSkinSellConfigView", package.seeall)

local PetSkinSellConfigView = class("PetSkinSellConfigView", TableViewComponent)

function PetSkinSellConfigView:ctor()
	PetSkinSellConfigView.super.ctor(self)
end

function PetSkinSellConfigView:buildUI()
	PetSkinSellConfigView.super.buildUI(self)

	self._bg = self:getGo("bg")
	self._btnBuy = self:getBtn("btnBuy")
	self._btnBuyText = self:getGo("btnBuy/Text"):GetComponent("Text")
	self._btnClose = self:getBtn("btnClose")
	self._txtTime = self:getGo("txtTime"):GetComponent("Text")
	self._time = self:getGo("txtTime/time")
	self._txtTime2 = self:getGo("txtTime2"):GetComponent("Text")
	self._btnSkill = self:getBtn("btnSkill")
	self._boxIcon = self:getGo("boxIcon")
end

function PetSkinSellConfigView:bindEvents()
	PetSkinSellConfigView.super.bindEvents(self)
	self._btnBuy:AddClickListener(self._onClickBtnBuy, self)
	self._btnClose:AddClickListener(self._onClickBtnClose, self)
	self._btnSkill:AddClickListener(self._onClickBtnSkill, self)
end

function PetSkinSellConfigView:unbindEvents()
	PetSkinSellConfigView.super.unbindEvents(self)
	self._btnBuy:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnSkill:RemoveClickListener()
end

function PetSkinSellConfigView:destroyUI()
	PetSkinSellConfigView.super.destroyUI(self)
end

function PetSkinSellConfigView:onEnter()
	PetSkinSellConfigView.super.onEnter(self)
	GlobalDispatcher:addListener(LongYanXiXiSkinAgent.PM_LongYanXiXiSkinGainRes, self._udpateBtnBuyText, self)

	self._curViewDatas = {}

	self:_updateBaseInfo()
	self._tableview:ReloadData()
	MaterialMgr.setCellByCfg("17:1032001:-1:1", self._boxIcon.gameObject)
end

function PetSkinSellConfigView:onEnterFinished()
	PetSkinSellConfigView.super.onEnterFinished(self)
	self:_updateLihui()
end

function PetSkinSellConfigView:onExit()
	PetSkinSellConfigView.super.onExit(self)
	GlobalDispatcher:removeListener(LongYanXiXiSkinAgent.PM_LongYanXiXiSkinGainRes, self._udpateBtnBuyText, self)

	self._curViewDatas = nil

	removetimer(self._updateTime, self)
	self:_clearLihui()
	MaterialMgr.resetAll(self._boxIcon.gameObject)
end

function PetSkinSellConfigView:onExitFinished()
	PetSkinSellConfigView.super.onExitFinished(self)
end

function PetSkinSellConfigView:_updateBaseInfo()
	local cfg = FuncOpenConfig.instance:getFunctionOpenById(307)

	if cfg and cfg.openTime then
		local times = string.split(cfg.openTime, "#")
		local _startTime = GameUtil.parseToTimeTable(times[1])

		self._endTimeStr = times[2]

		local _endTime = GameUtil.parseToTimeTable(times[2])

		self._txtTime2.text = _startTime.month .. "月" .. _startTime.day .. "日 ~ " .. _endTime.month .. "月" .. _endTime.day .. "日"
	end

	self._activityId = 6

	local _activyCfg = ActivityPopupConfig.instance:getLyXxCfg(self._activityId)

	self._raceId = _activyCfg.skinId
	self._skinId = _activyCfg.skinId

	self:_udpateBtnBuyText()

	self._curViewDatas = MaterialMgr.changeItemStrArr(_activyCfg.extraPrize)

	self:_initLeftTimeCount()
end

function PetSkinSellConfigView:_getLeftTime()
	local _now = ServerTime.now()

	if not self._endTimeStr then
		local _sellTime = "2021-08-19 05:00:00"
		local _timeStamp = GameUtil.string2time(_sellTime)

		return _timeStamp - _now
	end
end

function PetSkinSellConfigView:_initLeftTimeCount()
	self._leftTime = self:_getLeftTime()

	removetimer(self._updateTime, self)

	if self._leftTime > 0 then
		self:_updateTime()
		settimer(1, self._updateTime, self)
	else
		self._txtTime.text = "时间已过"
	end
end

function PetSkinSellConfigView:_updateTime()
	local day, hour, min, sec = GameUtil.getTimeDDHHMMSS(self._leftTime)

	if checknumber(day) > 0 then
		if self._txtTime then
			self._txtTime.text = string.format("%02d天%02d时%02d分", day, hour, min)
		end
	elseif self._txtTime then
		self._txtTime.text = string.format("%02d时%02d分", hour, min)
	end

	self._leftTime = self._leftTime - 1

	if self._leftTime <= 0 then
		removetimer(self._updateTime, self)
	end
end

function PetSkinSellConfigView:_updateLihui()
	local x = 0
	local y = -368
	local scale = 1

	self._pet = RoleObjectPool.instance:addRoleToParent(self._pet, self._raceId, self._bg, scale, function(go)
		return
	end, true, x, y)
end

function PetSkinSellConfigView:_clearLihui()
	if self._pet then
		self._pet = RoleObjectPool.instance:removeRole(self._pet)
	end
end

function PetSkinSellConfigView:_udpateBtnBuyText()
	if self:_hasBuySkin() then
		uGuiUtil.setImageGrayState(self._btnBuy, true)

		self._btnBuyText.text = "已购买"
	else
		uGuiUtil.setImageGrayState(self._btnBuy, false)

		local _activyCfg = ActivityPopupConfig.instance:getLyXxCfg(self._activityId)
		local _normalPrice = checknumber(string.sub(_activyCfg.normalPrice, 5))
		local _discountPrice = checknumber(string.sub(_activyCfg.discountPrice, 5))

		printInfo("test normalPrice", _activyCfg.normalPrice, _normalPrice, self._activityId)

		if not string.nilorempty(_activyCfg.discountCost) then
			local itemInfo = string.split(_activyCfg.discountCost, ":")
			local _discountGoodsId = itemInfo[2]
			local _hasBuy = MaterialMgr.getModel(MatType.Item, _discountGoodsId)

			if _hasBuy then
				self._btnBuyText.text = _discountPrice .. "元" or _normalPrice .. "元"
			end
		else
			self._btnBuyText.text = _normalPrice .. "元"
		end
	end
end

function PetSkinSellConfigView:_hasBuySkin()
	local cfg = ActivityPopupConfig.instance:getLyXxCfg(self._activityId)

	if PetskinController.instance:checkHasForeverSkinBySkinId(cfg.skinId) then
		return true
	end

	return false
end

function PetSkinSellConfigView:_onClickBtnBuy()
	local cfg = ActivityPopupConfig.instance:getLyXxCfg(self._activityId)
	local skinName = PetSkinConfig.instance:getPetSkinName(cfg.skinId)
	local itemStr = cfg.discountCost

	if not PetskinController.instance:checkHasForeverSkinBySkinId(cfg.skinId) then
		local subGoodsType = GameEnum.PaySubGoodsType.LONG_YAN_XI_XI_SKIN
		local subGoodsId = self._activityId

		if not string.nilorempty(itemStr) then
			if MaterialMgr.getMatEnough(itemStr) then
				PayController.instance:pay(cfg.discountPrice, subGoodsType, subGoodsId)
			else
				PayController.instance:pay(cfg.normalPrice, subGoodsType, subGoodsId)
			end
		else
			PayController.instance:pay(cfg.normalPrice, subGoodsType, subGoodsId)
		end
	else
		TipsFacade.instance:openCommonTips(langPara("已经拥有%s,不需要购买", skinName))
	end
end

function PetSkinSellConfigView:_onClickBtnClose()
	self:close()
end

function PetSkinSellConfigView:_getPath()
	return {
		cellPath = "sv_item",
		viewPath = "sv_info"
	}
end

function PetSkinSellConfigView:_cellSize()
	return 135, 120
end

function PetSkinSellConfigView:_updateCell(view, cell, data)
	local _item = goutil.findChild(cell.gameObject, "item")

	_item.gameObject:SetActive(true)
	MaterialMgr.resetAll(_item)

	local proxy = MaterialMgr.setCellByCfg(data, _item)

	Framework.TransformUtil.SetLocalScale(proxy.view.transform, 1, 1, 1)
end

function PetSkinSellConfigView:_onClickBtnSkill()
	if self._skinId then
		local cfg = PetSkinConfig.instance:getPetSkinCfg(self._skinId)

		if cfg then
			local raceId = cfg.raceId

			PetbookController.instance:previewBattle(raceId, self._skinId)
		end
	end
end

return PetSkinSellConfigView
