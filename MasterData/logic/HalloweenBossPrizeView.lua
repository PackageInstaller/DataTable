-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/halloweenguest/view/HalloweenBossPrizeView.lua

module("logic.extensions.halloweenguest.view.HalloweenBossPrizeView", package.seeall)

local HalloweenBossPrizeView = class("HalloweenBossPrizeView", TableViewComponent)

function HalloweenBossPrizeView:ctor()
	HalloweenBossPrizeView.super.ctor(self)

	self._curViewDatas = nil
end

function HalloweenBossPrizeView:bindEvents()
	HalloweenBossPrizeView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.close, self)
end

function HalloweenBossPrizeView:unbindEvents()
	HalloweenBossPrizeView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function HalloweenBossPrizeView:onExit()
	HalloweenBossPrizeView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.HalloweenDamagePrize, self._updataDamagePrizeItems, self)

	self._curViewDatas = nil
end

function HalloweenBossPrizeView:destroyUI()
	HalloweenBossPrizeView.super.destroyUI(self)
end

function HalloweenBossPrizeView:buildUI()
	HalloweenBossPrizeView.super.buildUI(self)

	self._closeBtn = self:getBtn("closeBtn")
end

function HalloweenBossPrizeView:onEnter()
	HalloweenBossPrizeView.super.onEnter(self)

	self._planId = self:getFirstParam()

	if checknumber(self._planId) <= 0 then
		self._planId = 1
	end

	GlobalDispatcher:addListener(GlobalNotify.HalloweenDamagePrize, self._updataDamagePrizeItems, self)
	self:_updataDamagePrizeItems()
end

function HalloweenBossPrizeView:_updataDamagePrizeItems()
	local bossInfo = HalloweenGuestModel.instance:getHalloweenBossInfo()
	local allDamage = bossInfo and checknumber(bossInfo.totalDamage) or 0

	if bossInfo then
		if not bossInfo.gainedDamagePrizeIds then
			local receiveList = {}
			local allCfgs = HalloweenGuestConfig.instance:getBossDamagesCfg(self._planId)

			self._curViewDatas = {}

			local stage = 2

			for _, cfg in pairs(allCfgs or {}) do
				if cfg and not string.nilorempty(cfg.prize) then
					stage = allDamage >= cfg.damage and (self:_isCurrentPrizeReceive(cfg.id, receiveList) and 3 or 1) or 2

					table.insert(self._curViewDatas, {
						id = cfg.id,
						stage = stage,
						damage = cfg.damage,
						prize = cfg.prize
					})
				end
			end

			if #self._curViewDatas > 1 then
				table.sort(self._curViewDatas, function(a, b)
					if a.stage == b.stage then
						return a.damage < b.damage
					end

					return a.stage < b.stage
				end)
			end

			self._tableview:ReloadData()
		end
	end
end

function HalloweenBossPrizeView:_isCurrentPrizeReceive(id, list)
	id = checknumber(id)

	for _, value in pairs(list) do
		if value and checknumber(value) == id then
			return true
		end
	end

	return false
end

function HalloweenBossPrizeView:_getPath()
	return {
		cellPath = "prizeItem",
		viewPath = "prizeItemSR"
	}
end

function HalloweenBossPrizeView:_cellSize()
	return 902, 118
end

function HalloweenBossPrizeView:_updateCell(view, cell, data)
	local descTxt = goutil.findChildTextComponent(cell, "descTxt")
	local receivedGo = goutil.findChild(cell, "receivedGo")
	local clickBtnGo = goutil.findChild(cell, "clickBtn")
	local noFinishGo = goutil.findChild(cell, "noFinishGo")
	local goodsList = {
		goutil.findChild(cell, "goodsGo_1"),
		goutil.findChild(cell, "goodsGo_2"),
		goutil.findChild(cell, "goodsGo_3"),
		goutil.findChild(cell, "goodsGo_4"),
		goutil.findChild(cell, "goodsGo_5")
	}

	GameUtil.asBtn(clickBtnGo):RemoveClickListener()

	for i = 1, #goodsList do
		MaterialMgr.resetAll(goodsList[i])
	end

	descTxt.text = langPara("text_halloween_desc_2", data.damage)

	local matList = string.split(data.prize, "#")

	for i = 1, #matList do
		if not string.nilorempty(matList[i]) and goodsList[i] then
			MaterialMgr.setCellByCfg(matList[i], goodsList[i])
		end
	end

	if data.stage == 2 then
		clickBtnGo:SetActive(false)
		receivedGo:SetActive(false)
		noFinishGo:SetActive(true)
	else
		noFinishGo:SetActive(false)

		if data.stage == 3 then
			clickBtnGo:SetActive(false)
			receivedGo:SetActive(true)
		else
			receivedGo:SetActive(false)
			clickBtnGo:SetActive(true)
			GameUtil.asBtn(clickBtnGo):AddClickListener(function()
				HalloweenGuestController.instance:csGetHalloweenBossChallengeGainDamagePrizeReq(data.id)
			end, self)
		end
	end
end

function HalloweenBossPrizeView:_clearTableview(cell)
	local clickBtnGo = goutil.findChild(cell, "clickBtn")
	local goodsList = {
		goutil.findChild(cell, "goodsGo_1"),
		goutil.findChild(cell, "goodsGo_2"),
		goutil.findChild(cell, "goodsGo_3"),
		goutil.findChild(cell, "goodsGo_4"),
		goutil.findChild(cell, "goodsGo_5")
	}

	GameUtil.asBtn(clickBtnGo):RemoveClickListener()

	for i = 1, #goodsList do
		MaterialMgr.resetAll(goodsList[i])
	end
end

return HalloweenBossPrizeView
