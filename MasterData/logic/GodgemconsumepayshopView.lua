-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/godgemconsume/view/GodgemconsumepayshopView.lua

module("logic.extensions.godgemconsume.view.GodgemconsumepayshopView", package.seeall)

local GodgemconsumepayshopView = class("GodgemconsumepayshopView", ViewComponent)

function GodgemconsumepayshopView:ctor()
	GodgemconsumepayshopView.super.ctor(self)
end

function GodgemconsumepayshopView:unbindEvents()
	GodgemconsumepayshopView.super.unbindEvents(self)
	self._btnBuy:RemoveClickListener()
	self._btnYuanqi:RemoveClickListener()
	self._btnLeixiao:RemoveClickListener()
	self._btnSkill:RemoveClickListener()
	self._btnInfo:RemoveClickListener()
end

function GodgemconsumepayshopView:bindEvents()
	GodgemconsumepayshopView.super.bindEvents(self)
	self._btnBuy:AddClickListener(self._onClickbtnBuy, self)
	self._btnYuanqi:AddClickListener(self._onClickbtnYuanqi, self)
	self._btnLeixiao:AddClickListener(self._onClickbtnLeixiao, self)
	self._btnSkill:AddClickListener(self._onClickbtnSkill, self)
	self._btnInfo:AddClickListener(self._onClickbtnInfo, self)
end

function GodgemconsumepayshopView:buildUI()
	GodgemconsumepayshopView.super.buildUI(self)

	self._pointRare = self:getGo("petInfo/rare")
	self._txtPetNameInInfo = self:getTxt("petInfo/txtName")
	self._btnSkill = self:getBtn("petInfo/btnSkill")
	self._btnInfo = self:getBtn("petInfo/btnInfo")
	self._con = self:getGo("con")
	self._txtOpenTime = self:getTxt("time/txtLeftTime")
	self._btnBuy = self:getBtn("btnBuy")
	self._btnYuanqi = self:getBtn("btnYuanqi")
	self._tablecellGo = self:getGo("tablecell")
	self._tableviewGo = self:getGo("tableview")
	self._txtDesc = self:getTxt("btnBuy/txtDesc")
	self._txtLimit = self:getTxt("btnBuy/txtLimit")
	self._txtCost = self:getTxt("btnBuy/txtCost")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._btnLeixiao = self:getBtn("btnLeixiao")
	self._receiveGo = self:getGo("btnBuy/receive")
end

function GodgemconsumepayshopView:onExit()
	GodgemconsumepayshopView.super.onExit(self)
	self._scrollerList:dispose()

	if self._role then
		self._role = RoleObjectPool.instance:removeRole(self._role)
		self._role = nil
	end

	MaterialMgr.resetAll(self._pointRare)
end

function GodgemconsumepayshopView:onEnter()
	GodgemconsumepayshopView.super.onEnter(self)
	self.addGEvent(self, PayAgent.NotifyPayResultRes, self._updateUI, self)

	self._activityId = checknumber(self:getFirstParam())

	if self._activityId <= 0 then
		self:close()

		return
	end

	self._actCfg = GodgemconsumeConfig.instance:getPayShopCfg(self._activityId)
	self._payshopItemCfg = PayShopConfig.instance:getPayShopGoodsCfgById(self._actCfg.payShopItemId)

	self:_updateUI()
end

function GodgemconsumepayshopView:_onClickbtnBuy()
	local times = PayShopModel.instance:getMibaoBuyTimesById(self._actCfg.payShopItemId)

	if times >= self._payshopItemCfg.limitTimes then
		FloatWordMgr.instance:show("已达限购次数")

		return
	end

	PayShopController.instance:buyShopItem(self._actCfg.payShopItemId, 1, 0, 0)
end

function GodgemconsumepayshopView:_onClickbtnYuanqi()
	GotoMgr.gotoByString(self._actCfg.jumpTo2)
end

function GodgemconsumepayshopView:_onClickbtnLeixiao()
	if ViewMgr.instance:isOpen(ViewName.PreferentialView) then
		UIStateManager.instance:popByName(ViewName.PreferentialView)
	end

	GotoMgr.gotoByString(self._actCfg.jumpTo1)
end

function GodgemconsumepayshopView:_updateUI()
	local dateStart = GameUtil.string2date(self._payshopItemCfg.onlineTime)
	local dateEnd = GameUtil.string2date(self._payshopItemCfg.offlineTime)

	self._txtOpenTime.text = langPara("活动时间：{0}.{1} {2}:00 - {3}.{4} {5}:00", dateStart.month, dateStart.day, dateStart.hour, dateEnd.month, dateEnd.day, dateEnd.hour)

	local skinId = self._actCfg.skinId

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, skinId, self._con, nil, nil, true, nil, nil)

	if skinId > 0 then
		MaterialMgr.setCell(MatType.Rare, skinId, self._pointRare)
	end

	self._txtPetNameInInfo.text = PetSkinConfig.instance:getPetSkinName(skinId)

	GameUtil.SetActive(self._btnLeixiao, not string.nilorempty(self._actCfg.jumpTo1))
	GameUtil.SetActive(self._btnYuanqi, not string.nilorempty(self._actCfg.jumpTo2))

	local list = string.split(self._payshopItemCfg.content, "#")

	self._scrollerList:reloadData(list)

	self._txtDesc.text = langPara("可增加{0}累消神钻进度", self._actCfg.progress)
	self._txtLimit.text = langPara("限购{0}次", self._payshopItemCfg.limitTimes)
	self._txtCost.text = langPara("{0}元", PayConfig.instance:getPayMoneyYuan(self._payshopItemCfg.originalGoodsId))

	local buyTime = PayShopModel.instance:getMibaoBuyTimesById(self._actCfg.payShopItemId)

	GameUtil.SetGray(self._btnBuy.gameObject, buyTime >= self._payshopItemCfg.limitTimes)
	GameUtil.SetActive(self._receiveGo, buyTime >= self._payshopItemCfg.limitTimes)
end

function GodgemconsumepayshopView:_updateCell(view, cell, data, tag)
	MaterialMgr.setCellByCfg(data, cell.gameObject)
end

function GodgemconsumepayshopView:_clearCell(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function GodgemconsumepayshopView:_onClickbtnSkill()
	PetCvController.instance:turnOffCurCv()
	PetbookController.instance:previewBattle(self:_getRaceId(), self._actCfg.skinId)
end

function GodgemconsumepayshopView:_onClickbtnInfo()
	PetbookController.instance:openPetinfoView(self:_getRaceId(), self._actCfg.skinId)
end

function GodgemconsumepayshopView:_getRaceId()
	local cfg = PetSkinConfig.instance:getPetSkinCfg(self._actCfg.skinId)

	return cfg.raceId
end

return GodgemconsumepayshopView
