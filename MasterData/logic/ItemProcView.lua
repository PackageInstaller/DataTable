-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/itembag/view/ItemProcView.lua

module("logic.extensions.material.view.ItemProcView", package.seeall)

local ItemProcView = class("ItemProcView", ViewComponent)
local json = require("cjson")

ItemProcView.TYPE_SOLD = 1
ItemProcView.TYPE_USED = 2

function ItemProcView:ctor()
	ItemProcView.super.ctor(self)
end

function ItemProcView:bindEvents()
	self._closeBtn:AddClickListener(self._onClickClose, self)
	self._useBtn:AddClickListener(self._onClickUse, self)
	self._quickUseBtn:AddClickListener(self._onClickQuickUse, self)
	self._sellBtn:AddClickListener(self._onClickSell, self)
	self._m10Btn:AddClickListener(self._onClickM10, self)
	self._minusBtn:AddClickListener(self._onClickMinus, self)
	self._addBtn:AddClickListener(self._onClickAdd, self)
	self._a10Btn:AddClickListener(self._onClickA10, self)
	self._procNumText:AddOnValueChanged(self._onValueChanged, self)
end

function ItemProcView:unbindEvents()
	self._closeBtn:RemoveClickListener()
	self._useBtn:RemoveClickListener()
	self._quickUseBtn:RemoveClickListener()
	self._sellBtn:RemoveClickListener()
	self._m10Btn:RemoveClickListener()
	self._minusBtn:RemoveClickListener()
	self._addBtn:RemoveClickListener()
	self._a10Btn:RemoveClickListener()
	self._procNumText:RemoveOnValueChanged()
end

function ItemProcView:buildUI()
	self._closeBtn = self:getBtn("BG/Close")
	self.txtTitle = self:getTxt("BG/txtTitle")
	self.txtUse = self:getTxt("Tip/BtnUse/Txt")
	self._quickUseBtn = self:getBtn("Tip/BtnQuickUse")
	self._useBtn = self:getBtn("Tip/BtnUse")
	self._sellBtn = self:getBtn("Tip/BtnSell")
	self._m10Btn = self:getBtn("Tip/Marks/BtnM10")
	self._minusBtn = self:getBtn("Tip/Marks/BtnMs")
	self._addBtn = self:getBtn("Tip/Marks/BtnAdd")
	self._a10Btn = self:getBtn("Tip/Marks/BtnA10")
	self._nameTxt = self:getTxt("Tip/TxtName")
	self._haveTxt = self:getTxt("Tip/TxtHave")
	self._priceTxt = self:getTxt("Tip/TxtPrice")
	self._getTxt = self:getTxt("Tip/TxtGet")
	self.icon = self:getGo("Tip/IconBg")
	self._procNumText = self:getInput("Tip/IptItem")
	self._txtUseMap = self:getTxt("Tip/TxtUseMap")
end

function ItemProcView:destroyUI()
	return
end

function ItemProcView:onEnter()
	local showType = self._viewPresentor._openParam[1]

	self._isQuickUse = self._viewPresentor._openParam[4]

	self._sellBtn.gameObject:SetActive(showType == ItemProcView.TYPE_SOLD)
	self._getTxt.gameObject:SetActive(showType == ItemProcView.TYPE_SOLD)
	self._priceTxt.gameObject:SetActive(showType == ItemProcView.TYPE_SOLD)
	self._useBtn.gameObject:SetActive(showType == ItemProcView.TYPE_USED and not self._isQuickUse)
	self._quickUseBtn.gameObject:SetActive(showType == ItemProcView.TYPE_USED and self._isQuickUse)
	self._txtUseMap.gameObject:SetActive(false)

	self._itemData = self._viewPresentor._openParam[2]
	self._price = 0

	self:initTip()

	self.txtTitle.text = lang("道具使用")
	self.txtUse.text = lang("使用")

	local cfg = self._viewPresentor._openParam[3]

	if cfg then
		if not string.nilorempty(cfg.title) then
			self.txtTitle.text = cfg.title
		end

		if not string.nilorempty(cfg.useDesc) then
			self.txtUse.text = cfg.useDesc
		end

		self._txtUseMap.gameObject:SetActive(cfg.materialUseType == MatUseType.TREASURE)

		self._txtUseMap.text = self._isQuickUse and lang("注意：快速使用将直接获得寻宝奖励") or lang("注意：批量使用后将连续挖宝")
	end
end

function ItemProcView:initTip()
	local cfg = MaterialMgr.getMatCfg(self._itemData.type, self._itemData.id)
	local proxy = MaterialMgr.setCellByCfg(self._itemData.type .. ":" .. self._itemData.id .. ":0", self.icon)

	if proxy then
		proxy:setAutoTips(false)
	end

	self._haveTxt.text = langPara("item_have", self._itemData.num)

	local sellNum = math.min(99999, self._itemData.num)

	if self._isQuickUse then
		sellNum = math.min(100, self._itemData.num)
	end

	self.sellMaxNum = sellNum

	self._procNumText:SetText(sellNum)

	if cfg then
		self._nameTxt.text = cfg.name
		self._price = cfg.price
		self._priceTxt.text = langPara("item_sell", cfg.price)
		self._getTxt.text = langPara("item_sell_get", tostring(checknumber(self._procNumText:GetText()) * self._price))
	end
end

function ItemProcView:onEnterFinished()
	return
end

function ItemProcView:onExit()
	self._itemData = nil

	MaterialMgr.resetAll(self.icon)
end

function ItemProcView:onExitFinished()
	return
end

function ItemProcView:_changeNumText(delta)
	local num = checknumber(self._procNumText:GetText()) + delta

	num = Mathf.Clamp(num, 1, self.sellMaxNum)

	self._procNumText:SetText(tostring(num))

	self._getTxt.text = langPara("item_sell_get", tostring(num * self._price))
end

function ItemProcView:_onValueChanged(strNum)
	local num = checknumber(strNum)

	num = Mathf.Clamp(num, 1, self.sellMaxNum)

	self._procNumText:SetText(tostring(num))

	self._getTxt.text = langPara("item_sell_get", tostring(num * self._price))
end

function ItemProcView:_onClickClose()
	self:close()
end

function ItemProcView:sendUseMsg()
	local num = checknumber(self._procNumText:GetText())
	local cfg = self._viewPresentor._openParam[3]

	if cfg.materialUseType == MatUseType.GOLDEN_DIAMOND_CARD then
		FloatWordMgr.instance:show(langPara("金钻特权有效期天数+%s天", checkint(cfg.content) * num))
	end

	MaterialFacade.instance:useItem(self._itemData.type, self._itemData.id, num, nil, GameUtil.handler(self._onClickClose, self))
end

function ItemProcView:_onClickUse()
	local cfg = self._viewPresentor._openParam[3]

	if cfg.materialUseType == MatUseType.TREASURE then
		local num = checknumber(self._procNumText:GetText())
		local isUseSuc = TreasureNewController.instance:useTreasureMap(self._itemData, num)

		if not isUseSuc then
			self:close()
		end

		return
	end

	local content = cfg.content

	if content then
		local temList = {}
		local temp = string.split(content, "#")

		for i, v in ipairs(temp) do
			local arr = string.split(v, ":")
			local matType = checknumber(arr[1])
			local id = checknumber(arr[2])
			local day = checknumber(arr[3])

			if matType == MatType.PET_SKIN and day > 0 then
				local skinCfg = PetSkinConfig.instance:getPetSkinCfg(id)
				local skinGroup = checknumber(skinCfg.skinGroup)
				local list = PetSkinConfig.instance:getPetSkinListBySkinGroup(skinGroup)
				local hasPet = false

				for i, v in ipairs(list) do
					hasPet = hasPet or BagPetsController.instance:getPetNumByRaceId(v.raceId) > 0
				end

				if not hasPet then
					table.insert(temList, skinCfg)
				end
			end
		end

		if #temList > 0 then
			local skinNameList = {}

			for i, v in ipairs(temList) do
				table.insert(skinNameList, v.skinName)
			end

			TipsFacade.instance:openTipWindowNoX(lang("tip"), langPara("使用此道具会获得皮肤【%s】,您还未获得可穿戴该皮肤的精灵，是否确定使用体验卡兑换该皮肤体验权？", table.concat(skinNameList, ", ")), function()
				self:realUseMaterial(cfg)
			end)
			self:close()

			return
		end
	end

	self:realUseMaterial(cfg)
end

function ItemProcView:_onClickQuickUse()
	local cfg = self._viewPresentor._openParam[3]

	if cfg.materialUseType == MatUseType.TREASURE then
		local num = checknumber(self._procNumText:GetText())

		TreasureNewController.instance:quickUseMap(self._itemData.id, num)
		self:close()
	end
end

function ItemProcView:realUseMaterial(cfg)
	if cfg and cfg.materialValuable == 1 then
		GameUtil.SetActive(self.mainGO, false)
		UIStateManager.instance:open(ViewName.GiftbagopenView, GameUtil.handler(self.sendUseMsg, self))
	else
		self:sendUseMsg()
	end
end

function ItemProcView:_onClickSell()
	local num = checknumber(self._procNumText:GetText())

	MaterialFacade.instance:sellItem(self._itemData.type, self._itemData.id, num, GameUtil.handler(self._onClickClose, self))
end

function ItemProcView:_onClickM10()
	self:_changeNumText(-10)
end

function ItemProcView:_onClickMinus()
	self:_changeNumText(-1)
end

function ItemProcView:_onClickAdd()
	self:_changeNumText(1)
end

function ItemProcView:_onClickA10()
	self:_changeNumText(10)
end

return ItemProcView
