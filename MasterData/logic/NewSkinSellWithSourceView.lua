-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firstcharge/view/newskinwithsource/NewSkinSellWithSourceView.lua

module("logic.extensions.firstcharge.view.newskinwithsource.NewSkinSellWithSourceView", package.seeall)

local NewSkinSellWithSourceView = class("NewSkinSellWithSourceView", NewSkinSellView)

function NewSkinSellWithSourceView:buildUI()
	NewSkinSellWithSourceView.super.buildUI(self)

	self._btnSource = self:getBtn("btnSource")
	self._btnPet = self:getBtn("btnPet")

	GameUtil.SetActive(self._btnPet, false)
end

function NewSkinSellWithSourceView:bindEvents()
	NewSkinSellWithSourceView.super.bindEvents(self)

	if self._btnSource then
		GameUtil.addClickHandler(self._btnSource, self._onClickBtnSource, self)
	end

	if self._btnPet then
		GameUtil.addClickHandler(self._btnPet, self._onClickBtnPet, self)
	end
end

function NewSkinSellWithSourceView:unbindEvents()
	NewSkinSellWithSourceView.super.unbindEvents(self)

	if self._btnSource then
		GameUtil.rmClickHandler(self._btnSource)
	end

	if self._btnPet then
		GameUtil.rmClickHandler(self._btnPet)
	end
end

function NewSkinSellWithSourceView:_onClickBtnSource()
	local fakeId = MatType.PET_SKIN .. ":" .. 1014702
	local strArr = string.split(fakeId, ":")
	local data = {
		type = checknumber(strArr[1]),
		id = checknumber(strArr[2])
	}

	MaterialMgr.openGetSourceByData(data)
end

function NewSkinSellWithSourceView:_onClickBtnPet()
	local skinId = self.skinId

	UIStateManager.instance:push(ViewName.PetskinView, PetskinView.TYPE_SHOP, skinId)
end

function NewSkinSellWithSourceView:_getCurGoodsId()
	return 8008
end

return NewSkinSellWithSourceView
