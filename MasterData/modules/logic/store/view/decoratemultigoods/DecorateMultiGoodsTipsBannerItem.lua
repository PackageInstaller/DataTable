-- chunkname: @modules/logic/store/view/decoratemultigoods/DecorateMultiGoodsTipsBannerItem.lua

module("modules.logic.store.view.decoratemultigoods.DecorateMultiGoodsTipsBannerItem", package.seeall)

local DecorateMultiGoodsTipsBannerItem = class("DecorateMultiGoodsTipsBannerItem", LuaCompBase)

function DecorateMultiGoodsTipsBannerItem.Get(go)
	return MonoHelper.addNoUpdateLuaComOnceToGo(go, DecorateMultiGoodsTipsBannerItem)
end

function DecorateMultiGoodsTipsBannerItem:init(go)
	self.go = go
	self._tran = self.go.transform
	self._simagePic = gohelper.findChildSingleImage(self.go, "simage_Pic")
	self._txtDesc = gohelper.findChildText(self.go, "txt_Desc")
	self._txtName = gohelper.findChildText(self.go, "txt_Desc/txt_Name")
	self._btnInfo = gohelper.findChildButtonWithAudio(self.go, "txt_Desc/txt_Name/btn_Info")
	self._bannerWidth = recthelper.getWidth(self._tran)
end

function DecorateMultiGoodsTipsBannerItem:addEventListeners()
	self._btnInfo:AddClickListener(self._btnInfoOnClick, self)
end

function DecorateMultiGoodsTipsBannerItem:removeEventListeners()
	self._btnInfo:RemoveClickListener()
end

function DecorateMultiGoodsTipsBannerItem:_btnInfoOnClick()
	if not self._decorateCo then
		return
	end

	if self._subType == ItemEnum.SubType.MainSceneSkin then
		ViewMgr.instance:openView(ViewName.MainSceneSwitchInfoView, {
			isPreview = true,
			noInfoEffect = true,
			sceneSkinId = self._sceneSkinId
		})
	elseif self._subType == ItemEnum.SubType.MainUISkin then
		MainUISwitchController.instance:openMainUISwitchInfoView(self._uiSkinId, true, true, true, true, true)
	elseif self._subType == ItemEnum.SubType.SceneUIPackage then
		MainUISwitchController.instance:openMainUISwitchInfoViewGiftSet(self._uiSkinId, self._sceneSkinId, true, true, true)
	end
end

function DecorateMultiGoodsTipsBannerItem:onUpdateMO(goodsId, index, posIndex)
	self.go.name = index

	self:setVisible(true)

	self._goodsId = goodsId
	self._index = index
	self._posIndex = posIndex
	self._decorateCo = DecorateStoreConfig.instance:getDecorateConfig(self._goodsId)
	self._goodsCo = StoreConfig.instance:getGoodsConfig(self._goodsId)
	self._offTag = self._decorateCo and self._decorateCo.offTag
	self._subType = self._decorateCo and self._decorateCo.subType

	self:initExtraParam()
	self:refreshUI()
end

function DecorateMultiGoodsTipsBannerItem:initExtraParam()
	local productsList = GameUtil.splitString2(self._goodsCo.product, true, "|", "#")

	if productsList[1] then
		local firstItemId = productsList[1][2]

		if productsList[2] then
			local secondItemId = productsList[2][2]

			if self._subType == ItemEnum.SubType.SceneUIPackage then
				local sceneConfig = MainSceneSwitchConfig.instance:getConfigByItemId(firstItemId)

				self._sceneSkinId = sceneConfig and sceneConfig.id

				local uiConfig = MainUISwitchConfig.instance:getUISwitchCoByItemId(secondItemId)

				self._uiSkinId = uiConfig and uiConfig.id
			elseif self._subType == ItemEnum.SubType.MainSceneSkin then
				local sceneConfig = MainSceneSwitchConfig.instance:getConfigByItemId(firstItemId)

				self._sceneSkinId = sceneConfig.id
			elseif self._subType == ItemEnum.SubType.MainUISkin then
				local uiConfig = MainUISwitchConfig.instance:getUISwitchCoByItemId(firstItemId)

				self._uiSkinId = uiConfig.id
			end
		end
	end
end

function DecorateMultiGoodsTipsBannerItem:refreshUI()
	self._txtName.text = self._goodsCo and self._goodsCo.name
	self._txtDesc.text = self._decorateCo and self._decorateCo.desc

	self._simagePic:LoadImage(ResUrl.getMainSceneSwitchLangIcon(self._decorateCo.buylmg))

	local curX = (self._posIndex - 2) * self._bannerWidth

	recthelper.setAnchorX(self._tran, curX)
end

function DecorateMultiGoodsTipsBannerItem:tween(isNext, callback, callbackObj)
	local curAnchorX = recthelper.getAnchorX(self._tran)

	if isNext then
		if not (curAnchorX - self._bannerWidth) then
			local targetAnchorX = curAnchorX + self._bannerWidth

			self._tweenId = ZProj.TweenHelper.DOAnchorPosX(self._tran, targetAnchorX, DecorateMultiGoodsTipsViewBanner.SwitchBannerDuration, callback, callbackObj)
		end
	end
end

function DecorateMultiGoodsTipsBannerItem:setVisible(isVisible)
	if self._isVisible == isVisible then
		return
	end

	self._isVisible = isVisible

	gohelper.setActive(self.go, self._isVisible)
end

function DecorateMultiGoodsTipsBannerItem:isVisible()
	return self._isVisible
end

function DecorateMultiGoodsTipsBannerItem:onDestory()
	if self._tweenId then
		TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	self._simagePic:UnLoadImage()
end

return DecorateMultiGoodsTipsBannerItem
