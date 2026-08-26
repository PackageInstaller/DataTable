-- chunkname: @modules/logic/store/view/skindiscountcompensate/SkinSelfSelectView.lua

module("modules.logic.store.view.skindiscountcompensate.SkinSelfSelectView", package.seeall)

local SkinSelfSelectView = class("SkinSelfSelectView", SkinDiscountCompensateSelectView)

function SkinSelfSelectView:onOpen()
	self.type = self.viewParam.type or SkinDiscountCompensateEnum.SelectDisplayType.DisplayOnly
	self.itemId = self.viewParam.itemId

	SkinSelfSelectListModel.instance:initList(self.itemId)
	self:updateTitle()
	self:updateSelect()
end

function SkinSelfSelectView:updateTitle()
	local config = ItemConfig.instance:getItemCo(self.itemId)

	self._textName.text = config.name

	if config then
		if not config.effect then
			local effect = ""
			local param = GameUtil.splitString2(effect, true)

			if not param then
				logError("皮肤折扣,当前道具不存在皮肤配置 id: " .. tostring(self.itemId))

				return
			end

			local itemParam = param[2]

			if not itemParam then
				logError("皮肤折扣,当前道具不存在重复转换配置 id: " .. tostring(self.itemId))

				return
			end

			if itemParam then
				if not itemParam[3] then
					local num = 0
					local titleStr = luaLang("v3a7_act236_have_skin_tips")
					local spriteIndex = StoreEnum.CurrencyItemSprite[itemParam[2]]

					if not spriteIndex then
						logError("不存在对应的图文混排索引,请检查 id:" .. tostring(itemParam[2]))

						spriteIndex = StoreEnum.CurrencyItemSprite[StoreEnum.DefaultCurrencyItem]
					end

					self._textTitle.text = GameUtil.getSubPlaceholderLuaLangTwoParam(titleStr, tostring(spriteIndex), tostring(num))
				end
			end
		end
	end
end

function SkinSelfSelectView:onClickItem(skinId, selectIndex)
	if self.type ~= SkinDiscountCompensateEnum.SelectDisplayType.Select then
		return
	end

	if skinId == self.skinId then
		return
	end

	local isOwn = HeroModel.instance:checkHasSkin(skinId)

	if isOwn then
		return
	end

	SkinSelfSelectListModel.instance:selectCell(selectIndex, true)

	self.skinId = skinId

	self:updateSelect()
end

function SkinSelfSelectView:updateCompensate(skinId)
	return
end

return SkinSelfSelectView
