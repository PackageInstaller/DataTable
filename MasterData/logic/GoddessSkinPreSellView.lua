-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firstcharge/view/GoddessSkinPreSellView.lua

module("logic.extensions.firstcharge.view.GoddessSkinPreSellView", package.seeall)

local GoddessSkinPreSellView = class("GoddessSkinPreSellView", ViewComponent)

function GoddessSkinPreSellView:ctor()
	GoddessSkinPreSellView.super.ctor(self)

	self.goodsId = 9003
	self.cfg_shop = PayShopConfig.instance:getPayShopGoodsCfgById(self.goodsId)

	if self.cfg_shop == nil then
		printError("缺少 Z-支付秘宝商城（改）， id = " .. self.goodsId .. " 配置，请联系策划")
	end

	self.openTime = GameUtil.string2time(self.cfg_shop.onlineTime)
	self.endTime = GameUtil.string2time(self.cfg_shop.offlineTime)
	self.skinId = 1002701

	local cfg_model = CharacterConfig.instance:getModelCo(self.skinId)

	if cfg_model == nil then
		printError(string.format("缺少 精灵皮肤id = %s 配置", self.skinId))

		self.skinId = 0
	end
end

function GoddessSkinPreSellView:buildUI()
	GoddessSkinPreSellView.super.buildUI(self)

	self._bg = self:getGo("bg")
	self._btnBuy = self:getBtn("btnBuy")
	self._btnBuyText = self:getGo("btnBuy/Text"):GetComponent("Text")
	self._btnClose = self:getBtn("btnClose")
	self._txtTime = self:getGo("txtTime"):GetComponent("Text")
	self._time = self:getGo("txtTime/time")
	self._txtTime2 = self:getGo("txtTime2"):GetComponent("Text")
	self._btnSkill = self:getBtn("btnSkill")
	self._boxIcon = self:getGo("boxIcon")
	self._pet = nil
	self._cellModel = self:getGo("sv_item")
	self._scrollerGo = self:getGo("sv_info")
	self.rewardCellList = {}
	self.scrollList = ScrollerList.create(self._scrollerGo, self._cellModel, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
end

function GoddessSkinPreSellView:bindEvents()
	GoddessSkinPreSellView.super.bindEvents(self)
	self._btnBuy:AddClickListener(self._onClickBtnBuy, self)
	self._btnClose:AddClickListener(self._onClickBtnClose, self)
	self._btnSkill:AddClickListener(self._onClickBtnSkill, self)
end

function GoddessSkinPreSellView:unbindEvents()
	GoddessSkinPreSellView.super.unbindEvents(self)
	self._btnBuy:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnSkill:RemoveClickListener()
end

function GoddessSkinPreSellView:destroyUI()
	GoddessSkinPreSellView.super.destroyUI(self)
	MaterialMgr.resetAll(self._boxIcon.gameObject)

	for _, cell in pairs(self.rewardCellList) do
		MaterialMgr.resetAll(cell.item)
	end
end

function GoddessSkinPreSellView:onEnter()
	GoddessSkinPreSellView.super.onEnter(self)
	self:_setPanelUI()
	GlobalDispatcher:addListener(PayShopController.GetAllPayShopBuyTimesRes, self._onRefreshUI, self)
	GlobalDispatcher:addListener(PayShopController.NotifyPayShopItemBuySucRes, self._onRefreshUI, self)
	self:_onRefreshUI()
end

function GoddessSkinPreSellView:onExit()
	GoddessSkinPreSellView.super.onExit(self)
	GlobalDispatcher:removeListener(PayShopController.GetAllPayShopBuyTimesRes, self._onRefreshUI, self)
	GlobalDispatcher:removeListener(PayShopController.NotifyPayShopItemBuySucRes, self._onRefreshUI, self)
	removetimer(self._updateTimer, self)

	if self._pet ~= nil then
		self._pet = RoleObjectPool.instance:removeRole(self._pet)
	end
end

function GoddessSkinPreSellView:_setPanelUI()
	local contentArr = string.split(self.cfg_shop.content, "#")

	if contentArr[1] == nil then
		printError("error，没有找到显示图案的id")
	else
		MaterialMgr.setCellByCfg(contentArr[1], self._boxIcon.gameObject)
	end

	self:_setActivityTime()
end

function GoddessSkinPreSellView:_setActivityTime()
	local str1 = GameUtil.formatTimeStamp("%m月%d日", self.openTime)
	local str2 = GameUtil.formatTimeStamp("%m月%d日", self.endTime)

	self._txtTime2.text = str1 .. " ~ " .. str2

	local leftTime = self.endTime - ServerTime.nowServerLook()

	if leftTime <= 0 then
		self._txtTime.text = "活动已结束"

		return
	end

	local readyTime = self.openTime - ServerTime.nowServerLook()

	if readyTime >= 0 then
		self._txtTime.text = "活动未开启"

		return
	end

	if leftTime > 0 then
		settimer(1, self._updateTimer, self, true)
		self:_updateTimer()

		return
	end
end

function GoddessSkinPreSellView:_updateTimer()
	local leftTime = self.endTime - ServerTime.nowServerLook()

	if leftTime > 0 then
		self._txtTime.text = string.format("%d天%d时%d分%d秒", GameUtil.getTimeDDHHMMSS(leftTime))
	else
		self._txtTime.text = "活动已结束"

		removetimer(self._updateTimer, self)
	end
end

function GoddessSkinPreSellView:_onRefreshUI()
	self:_updateTaskScrollerList()
	self.scrollList:refresh()
	self:_updateBtnBuy()
end

function GoddessSkinPreSellView:_updateTaskScrollerList()
	local contentArr = string.split(self.cfg_shop.content, "#")
	local dataArr = {}

	for i = 2, #contentArr do
		local tab = {}

		tab.cfgStr = contentArr[i]
		tab.id = i

		table.insert(dataArr, tab)
	end

	self.scrollList:reloadData(dataArr)
end

function GoddessSkinPreSellView:_updateCell(view, cellModel, data, tag)
	local cell = self.rewardCellList[data.id]

	cell = cell or self:_setCell(cellModel)

	if cell.proxy == nil then
		cell.proxy = MaterialMgr.setCellByCfg(data.cfgStr, cell.item)

		GameUtil.setLocalScale(cell.proxy.view.transform, 1, 1, 1)
	end

	goutil.setActive(cell.mainGo, true)
	goutil.setActive(cell.item, true)

	self.rewardCellList[data.id] = cell
end

function GoddessSkinPreSellView:_setCell(cellModel)
	local cell = {}

	cell.mainGo = cellModel.gameObject
	cell.item = goutil.findChild(cell.mainGo, "item")
	cell.proxy = nil

	return cell
end

function GoddessSkinPreSellView:_clearCell()
	return
end

function GoddessSkinPreSellView:_updateBtnBuy()
	uGuiUtil.setGoGrayState(self._btnBuy.gameObject, true)

	local leftTime = self.endTime - ServerTime.nowServerLook()

	if leftTime <= 0 then
		self._btnBuyText.text = "已结束"

		return
	end

	local readyTime = self.openTime - ServerTime.nowServerLook()

	if readyTime >= 0 then
		self._btnBuyText.text = "未开启"

		return
	end

	local isCanBuy = PayShopModel.instance:getPayShopGoodsCanBuyById(self.goodsId)

	if not isCanBuy then
		self._btnBuyText.text = "已购得"

		return
	end

	uGuiUtil.setGoGrayState(self._btnBuy.gameObject, false)

	self._btnBuyText.text = string.format("%s元", PayConfig.instance:getPayMoneyYuan(self.cfg_shop.originalGoodsId))
end

function GoddessSkinPreSellView:_onClickBtnSkill()
	if checknumber(self.skinId) == 0 then
		printError("精灵皮肤id未正确，无法播放技能演示")

		return
	end

	local cfg = PetSkinConfig.instance:getPetSkinCfg(self.skinId)

	if cfg == nil then
		printError("精灵皮肤id在 j-精灵皮肤配置表 中找不到配置")
	else
		PetbookController.instance:previewBattle(cfg.raceId, self.skinId, false)
	end
end

function GoddessSkinPreSellView:_onClickBtnBuy()
	local leftTime = self.endTime - ServerTime.nowServerLook()

	if leftTime <= 0 then
		FloatWordMgr.instance:show("活动已结束，下次吧")

		return
	end

	local readyTime = self.openTime - ServerTime.nowServerLook()

	if readyTime >= 0 then
		FloatWordMgr.instance:show("活动未开启，再忍忍")

		return
	end

	local isCanBuy = PayShopModel.instance:getPayShopGoodsCanBuyById(self.goodsId)

	if isCanBuy == true then
		PayShopController.instance:buyShopItem(self.goodsId)
	else
		FloatWordMgr.instance:show("谢谢惠顾，但该商品您已购买啦")
	end
end

function GoddessSkinPreSellView:_onClickBtnClose()
	self:close()
end

return GoddessSkinPreSellView
