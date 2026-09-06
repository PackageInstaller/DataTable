-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/lottery/view/LotteryOperateView.lua

module("logic.extensions.lottery.view.LotteryOperateView", package.seeall)

local LotteryOperateView = class("LotteryOperateView", ViewComponent)

function LotteryOperateView:ctor()
	LotteryOperateView.super.ctor(self)

	self._shopItemList = nil
end

function LotteryOperateView:bindEvents()
	LotteryOperateView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
end

function LotteryOperateView:unbindEvents()
	LotteryOperateView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function LotteryOperateView:onExit()
	LotteryOperateView.super.onExit(self)
	GlobalDispatcher:removeListener(PayShopModel.ChangeMibaoShopBuyTimes, self._showViewAllItems, self)
	GlobalDispatcher:removeListener(PayAgent.NotifyPayResultRes, self._showViewAllItems, self)

	for _, info in pairs(self._shopItemList or {}) do
		if info and info.itemLua then
			info.itemLua:onExit()
		end
	end
end

function LotteryOperateView:destroyUI()
	LotteryOperateView.super.destroyUI(self)

	local bgBig = self._viewBgImaGo:GetComponent("ImageBigBG")

	if bgBig then
		bgBig:ClearImage()
	end

	self._shopItemList = nil
end

function LotteryOperateView:buildUI()
	LotteryOperateView.super.buildUI(self)

	self._viewBgImaGo = self:getGo("viewBgIma")
	self._closeBtn = self:getBtn("closeBtn")
	self._shopItemList = {}
	self._shopItemList[1] = {
		itemGo = self:getGo("itemGo_1")
	}
	self._shopItemList[2] = {
		itemGo = self:getGo("itemGo_2")
	}
	self._shopItemList[3] = {
		itemGo = self:getGo("itemGo_3")
	}
end

function LotteryOperateView:onEnter()
	LotteryOperateView.super.onEnter(self)

	self._operateCfg = self:getFirstParam()

	if self._operateCfg == nil or #self._operateCfg.itemIds == 0 then
		printError("sr---抽卡运营  LotteryOperateView:onEnter()    配置空的！！！")
		self:close()

		return
	end

	GlobalDispatcher:addListener(PayShopModel.ChangeMibaoShopBuyTimes, self._showViewAllItems, self)
	GlobalDispatcher:addListener(PayAgent.NotifyPayResultRes, self._showViewAllItems, self)

	local path = "ui/bigbg/zhaohuan/" .. self._operateCfg.viweBg

	uGuiUtil.setSpriteToImage(self._viewBgImaGo, uGuiUtil.SpriteType.BigBg, path)

	for _, info in pairs(self._shopItemList or {}) do
		if info and info.itemLua then
			info.itemLua:onExit()
		end
	end

	self:_showViewAllItems()
end

function LotteryOperateView:_showViewAllItems()
	for i = 1, #self._shopItemList do
		if self._shopItemList[i] and self._shopItemList[i].itemLua then
			self._shopItemList[i].itemLua:onExit()

			self._shopItemList[i].itemLua = nil
		end
	end

	local infoList = {}
	local goodsCfg
	local isShowOut = false
	local idsList = self._operateCfg.itemIds

	for i = 1, #idsList do
		if idsList[i] and self._shopItemList[i] then
			local times = PayShopModel.instance:getMibaoBuyTimesById(idsList[i])

			goodsCfg = PayShopConfig.instance:getPayShopGoodsCfgById(idsList[i])

			local isSellOut = goodsCfg.limitType ~= "none" and goodsCfg.limitTimes > 0 and checknumber(times) >= goodsCfg.limitTimes

			if isSellOut then
				isShowOut = true
			end

			local goodsData = {
				index = i,
				id = idsList[i],
				times = times,
				isSellOut = isSellOut
			}

			table.insert(infoList, {
				goodsData = goodsData
			})
		end
	end

	if isShowOut and #infoList > 1 then
		ArraySort.sortOn(infoList, {
			function(obj)
				if obj.isSellOut then
					return 1
				else
					return 0
				end
			end,
			"index"
		})
	end

	for i = 1, #infoList do
		self._shopItemList[i].itemLua = GameUtil.AddLuaOnce(self._shopItemList[i].itemGo, PayShopMibaoGoodsItem)

		self._shopItemList[i].itemLua:onEnter()
		self._shopItemList[i].itemLua:setData(self, nil, infoList[i])
	end
end

return LotteryOperateView
