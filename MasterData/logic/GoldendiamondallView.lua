-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goldendiamondcard/view/GoldendiamondallView.lua

module("logic.extensions.goldendiamondcard.view.GoldendiamondallView", package.seeall)

local GoldendiamondallView = class("GoldendiamondallView", ViewComponent)

function GoldendiamondallView:buildUI()
	GoldendiamondallView.super.buildUI(self)

	self.tip = self:getGo("tip")
	self.tip2 = self:getGo("tip2")
	self.allReward = self:getGo("allReward")
	self.dayReward = self:getGo("dayReward")
	self.empty = self:getGo("empty")
	self._items = {}

	for i = 1, 3 do
		local item = {}

		item.total = goutil.findChild(self.allReward, "item" .. i)
		item.dayily = goutil.findChild(self.dayReward, "item" .. i)
		self._items[i] = item
	end

	self.btnReceive = self:getBtn("btnReceive")
	self.btnClose = self:getBtn("btnClose")
	self.tipsNull = goutil.findChildTextComponent(self.empty, "tipsNull")
end

function GoldendiamondallView:bindEvents()
	GoldendiamondallView.super.bindEvents(self)
	self.btnClose:AddClickListener(self.close, self)
	self.btnReceive:AddClickListener(self._onClickBtnReceive, self)
end

function GoldendiamondallView:unbindEvents()
	GoldendiamondallView.super.unbindEvents(self)
	self.btnClose:RemoveClickListener()
	self.btnReceive:RemoveClickListener()
end

function GoldendiamondallView:onEnter()
	GoldendiamondallView.super.onEnter(self)

	for i = 1, 3 do
		MaterialMgr.resetAll(self._items[i].total)
		MaterialMgr.resetAll(self._items[i].dayily)
	end

	if GoldenDiamondCardModel.instance.isUser then
		local prizeNum = GoldenDiamondCardModel.instance.prizeNum

		if prizeNum == 0 then
			goutil.setActive(self.tip, false)
			goutil.setActive(self.tip2, false)
			goutil.setActive(self.allReward, false)
			goutil.setActive(self.dayReward, false)
			goutil.setActive(self.empty, true)
			goutil.setActive(self.btnReceive.gameObject, false)

			self.tipsNull.text = lang("当前没有存储资源")
		else
			goutil.setActive(self.tip, true)
			goutil.setActive(self.tip2, true)
			goutil.setActive(self.allReward, true)
			goutil.setActive(self.dayReward, true)
			goutil.setActive(self.empty, false)
			goutil.setActive(self.btnReceive.gameObject, true)

			local prizes = GoldenDiamondCardConfig.instance:getCommonValue("DAILY_PRIZE")
			local prizeStrs = MaterialMgr.changeItemStrArr(prizes)

			for i = 1, 3 do
				local matStr = prizeStrs[i]
				local item = self._items[i]

				if prizeNum > 1 then
					local matType, matId, matNum = MaterialMgr.getMatParams(matStr)
					local proxy = MaterialMgr.setCellByCfg(matStr, item.total)

					proxy.binder:setNum((prizeNum - 1) * matNum)
				end

				MaterialMgr.setCellByCfg(matStr, item.dayily)
			end
		end
	else
		goutil.setActive(self.tip, false)
		goutil.setActive(self.tip2, false)
		goutil.setActive(self.allReward, false)
		goutil.setActive(self.dayReward, false)
		goutil.setActive(self.empty, true)
		goutil.setActive(self.btnReceive.gameObject, false)

		self.tipsNull.text = lang("你还不是金钻特权用户哦")
	end
end

function GoldendiamondallView:onExit()
	GoldendiamondallView.super.onExit(self)

	for i = 1, 3 do
		MaterialMgr.resetAll(self._items[i].total)
		MaterialMgr.resetAll(self._items[i].dayily)
	end
end

function GoldendiamondallView:_onClickBtnReceive()
	self:close()
	GoldenDiamondCardAgent.instance:sendPM_GoldenDiamondCardGainDailyPrizeReq()
end

return GoldendiamondallView
