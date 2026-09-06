-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firstcharge/view/GoddessSkinSellView.lua

module("logic.extensions.firstcharge.view.GoddessSkinSellView", package.seeall)

local GoddessSkinSellView = class("GoddessSkinSellView", ViewComponent)

function GoddessSkinSellView:ctor()
	GoddessSkinSellView.super.ctor(self)

	self.activityId = 5
	self.funcId = 307
	self.cfg_skin = ActivityPopupConfig.instance:getLyXxCfg(self.activityId)
	self.cfg_func = FuncOpenConfig.instance:getFunctionOpenById(self.funcId)

	if self.cfg_skin == nil then
		printError(string.format("缺少 Y运营-龙炎茜茜皮肤, id = %s 的配置", self.activityId))
	end

	if self.cfg_func == nil then
		printError(string.format("缺少 G功能开启配置表， id = %s 的配置", self.funcId))
	end

	self.skinId = checknumber(self.cfg_skin.skinId)

	local cfg_model = CharacterConfig.instance:getModelCo(self.skinId)

	if cfg_model == nil then
		printError(string.format("缺少 精灵皮肤id = %s 配置", self.skinId))

		self.skinId = 0
	end

	local openTimeArr = string.split(self.cfg_func.openTime, "#")

	self.openTime = GameUtil.string2time(openTimeArr[1])
	self.endTime = GameUtil.string2time(openTimeArr[2])
end

function GoddessSkinSellView:buildUI()
	GoddessSkinSellView.super.buildUI(self)

	self._bg = self:getGo("bg")
	self._rawImg = self:getGo("bg/img")
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

function GoddessSkinSellView:bindEvents()
	GoddessSkinSellView.super.bindEvents(self)
	self._btnBuy:AddClickListener(self._onClickBtnBuy, self)
	self._btnClose:AddClickListener(self._onClickBtnClose, self)
	self._btnSkill:AddClickListener(self._onClickBtnSkill, self)
end

function GoddessSkinSellView:unbindEvents()
	GoddessSkinSellView.super.unbindEvents(self)
	self._btnBuy:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnSkill:RemoveClickListener()
end

function GoddessSkinSellView:destroyUI()
	GoddessSkinSellView.super.destroyUI(self)
	MaterialMgr.resetAll(self._boxIcon.gameObject)

	for _, cell in pairs(self.rewardCellList) do
		MaterialMgr.resetAll(cell.item)
	end
end

function GoddessSkinSellView:onEnter()
	GoddessSkinSellView.super.onEnter(self)
	self:_setPanelUI()
	GlobalDispatcher:addListener(PayShopController.GetAllPayShopBuyTimesRes, self._onRefreshUI, self)
	GlobalDispatcher:addListener(PayShopController.NotifyPayShopItemBuySucRes, self._onRefreshUI, self)
	self:_onRefreshUI()
end

function GoddessSkinSellView:onExit()
	GoddessSkinSellView.super.onExit(self)
	GlobalDispatcher:removeListener(PayShopController.GetAllPayShopBuyTimesRes, self._onRefreshUI, self)
	GlobalDispatcher:removeListener(PayShopController.NotifyPayShopItemBuySucRes, self._onRefreshUI, self)
	removetimer(self._updateTimer, self)

	if self._pet ~= nil then
		self._pet:clear()
	end
end

function GoddessSkinSellView:_setPanelUI()
	if self.skinId == 0 then
		printError("精灵皮肤id未正确，无法设置图框图案")
	else
		local cfgStr = "17:" .. self.skinId .. ":-1:1"

		MaterialMgr.setCellByCfg(cfgStr, self._boxIcon.gameObject)
	end

	if self.skinId == 0 then
		printError("精灵皮肤id未正确，无法展现精灵动图")
	elseif self._rawImg and self.cfg_skin.isHideSkin == false then
		self._pet = PetPhotoShow.Get(self._rawImg)

		self._pet:showPetEffect(self.skinId, true, 4.1)
	end

	self:_setActivityTime()
end

function GoddessSkinSellView:_setActivityTime()
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

function GoddessSkinSellView:_updateTimer()
	local leftTime = self.endTime - ServerTime.nowServerLook()

	if leftTime > 0 then
		self._txtTime.text = string.format("%d天%d时%d分%d秒", GameUtil.getTimeDDHHMMSS(leftTime))
	else
		self._txtTime.text = "活动已结束"

		removetimer(self._updateTimer, self)
	end
end

function GoddessSkinSellView:_onRefreshUI()
	self:_updateTaskScrollerList()
	self.scrollList:refresh()
	self:_updateBtnBuy()
end

function GoddessSkinSellView:_updateTaskScrollerList()
	local prizeList = string.split(self.cfg_skin.extraPrize, "#")
	local data = {}

	for i, v in ipairs(prizeList) do
		local tab = {}

		tab.id = i
		tab.cfgStr = v

		table.insert(data, tab)
	end

	self.scrollList:reloadData(data)
end

function GoddessSkinSellView:_updateCell(view, cellModel, data, tag)
	local cell = self.rewardCellList[data.id]

	cell = cell or self:_setCell(cellModel)

	if cell.proxy == nil then
		if data.cfgStr == "" or data.cfgStr == nil then
			printError("cfgStr not existent!")
		else
			cell.proxy = MaterialMgr.setCellByCfg(data.cfgStr, cell.item)

			GameUtil.setLocalScale(cell.proxy.view.transform, 1, 1, 1)
		end
	end

	goutil.setActive(cell.mainGo, true)
	goutil.setActive(cell.item, true)

	self.rewardCellList[data.id] = cell
end

function GoddessSkinSellView:_setCell(cellModel)
	local cell = {}

	cell.mainGo = cellModel.gameObject
	cell.item = goutil.findChild(cell.mainGo, "item")
	cell.proxy = nil

	return cell
end

function GoddessSkinSellView:_clearCell()
	return
end

function GoddessSkinSellView:_updateBtnBuy()
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

	local isHasBuy = PetskinController.instance:checkHasForeverSkinBySkinId(self.skinId)

	if isHasBuy then
		self._btnBuyText.text = "已购得"

		return
	end

	uGuiUtil.setGoGrayState(self._btnBuy.gameObject, false)

	local strArr = string.split(self.cfg_skin.discountCost, ":")

	self._btnBuyText.text = (MaterialMgr.getModel(strArr[1], strArr[2]) and PayConfig.instance:getPayMoneyYuan(self.cfg_skin.discountPrice) or PayConfig.instance:getPayMoneyYuan(self.cfg_skin.normalPrice)) .. "元"
end

function GoddessSkinSellView:_onClickBtnSkill()
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

function GoddessSkinSellView:_onClickBtnBuy()
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

	local isHasOwned = PetskinController.instance:checkHasForeverSkinBySkinId(self.skinId)

	if isHasOwned == true then
		FloatWordMgr.instance:show("谢谢惠顾，但该商品您已购买啦")

		return
	end

	local price = ""
	local strArr = string.split(self.cfg_skin.discountCost, ":")

	price = MaterialMgr.getModel(strArr[1], strArr[2]) and self.cfg_skin.discountPrice or self.cfg_skin.normalPrice

	local subGoodsType = GameEnum.PaySubGoodsType.LONG_YAN_XI_XI_SKIN
	local subGoodsId = self.activityId

	PayController.instance:pay(price, subGoodsType, subGoodsId)
end

function GoddessSkinSellView:_onClickBtnClose()
	self:close()
end

return GoddessSkinSellView
