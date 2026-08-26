-- chunkname: @modules/logic/act189/view/ShortenActStyleItem_impl.lua

module("modules.logic.act189.view.ShortenActStyleItem_impl", package.seeall)

local ti = table.insert
local ShortenActStyleItem_impl = class("ShortenActStyleItem_impl", RougeSimpleItemBase)

function ShortenActStyleItem_impl:ctor(...)
	self:__onInit()
	ShortenActStyleItem_impl.super.ctor(self, ...)
end

function ShortenActStyleItem_impl:_getStyleCO()
	local p = self:_assetGetParent()

	return p:getStyleCO()
end

function ShortenActStyleItem_impl:_getBonusList()
	local p = self:_assetGetParent()

	return p:getBonusList()
end

function ShortenActStyleItem_impl:_isClaimable()
	local p = self:_assetGetParent()

	return p:isClaimable()
end

function ShortenActStyleItem_impl:_editableInitView()
	ShortenActStyleItem_impl.super._editableInitView(self)

	local _1Go = gohelper.findChild(self.viewGO, "1")

	self._simagerewardicon1Go = gohelper.findChild(_1Go, "#simage_rewardicon1")
	self._simagerewardicon2Go = gohelper.findChild(_1Go, "#simage_rewardicon2")
	self._goisget1 = gohelper.findChild(_1Go, "#go_isget1")
	self._goisget2 = gohelper.findChild(_1Go, "#go_isget2")
	self._gocanget1 = gohelper.findChild(_1Go, "#go_canget1")
	self._gocanget2 = gohelper.findChild(_1Go, "#go_canget2")
	self._txtnumbg1 = gohelper.findChildImage(_1Go, "numbg1")
	self._txtnumbg2 = gohelper.findChildImage(_1Go, "numbg2")
	self._txtnum1 = gohelper.findChildText(_1Go, "numbg1/#txt_num1")
	self._txtnum2 = gohelper.findChildText(_1Go, "numbg2/#txt_num2")
	self._gotimebg1 = gohelper.findChild(_1Go, "#go_timebg1")
	self._gotimebg2 = gohelper.findChild(_1Go, "#go_timebg2")
	self._gotimebgImg1 = self._gotimebg1:GetComponent(gohelper.Type_Image)
	self._gotimebgImg2 = self._gotimebg2:GetComponent(gohelper.Type_Image)
	self._commonPropItemIconList = {}

	local commonPropItemIcon1 = IconMgr.instance:getCommonPropItemIcon(self._simagerewardicon1Go)
	local commonPropItemIcon2 = IconMgr.instance:getCommonPropItemIcon(self._simagerewardicon2Go)

	ti(self._commonPropItemIconList, commonPropItemIcon1)
	ti(self._commonPropItemIconList, commonPropItemIcon2)

	self._txtList = self:getUserDataTb_()

	ti(self._txtList, self._txtnum1)
	ti(self._txtList, self._txtnum2)

	self._txtBgList = self:getUserDataTb_()

	ti(self._txtBgList, self._txtnumbg1)
	ti(self._txtBgList, self._txtnumbg2)

	self._goisgetList = self:getUserDataTb_()

	ti(self._goisgetList, self._goisget1)
	ti(self._goisgetList, self._goisget2)

	self._gocangetList = self:getUserDataTb_()

	ti(self._gocangetList, self._gocanget1)
	ti(self._gocangetList, self._gocanget2)

	self._gotimebgList = self:getUserDataTb_()

	ti(self._gotimebgList, self._gotimebg1)
	ti(self._gotimebgList, self._gotimebg2)

	self._gotimebgImgList = self:getUserDataTb_()

	ti(self._gotimebgImgList, self._gotimebgImg1)
	ti(self._gotimebgImgList, self._gotimebgImg2)
end

local kClaimedHexColor = "#A5A5A5A0"

function ShortenActStyleItem_impl:setData(mo)
	ShortenActStyleItem_impl.super.setData(self, mo)

	local bonusList = self:_getBonusList()
	local isClaimable = self:_isClaimable()
	local isClaimed = not isClaimable

	if isClaimed then
		if not kClaimedHexColor then
			local hexColor = "#FFFFFF"

			for i, list in ipairs(bonusList) do
				local itemIcon = self._commonPropItemIconList[i]
				local itemCountTxt = self._txtList[i]
				local itemCountTxtBg = self._txtBgList[i]
				local goisget = self._goisgetList[i]
				local gocanget = self._gocangetList[i]
				local gotimebg = self._gotimebgList[i]
				local gotimebgImg = self._gotimebgImgList[i]
				local itemType = list[1]
				local itemId = list[2]
				local itemCount = list[3]

				itemIcon:setMOValue(itemType, itemId, itemCount)
				itemIcon:isShowQuality(false)
				itemIcon:isShowEquipAndItemCount(false)
				itemIcon:setItemColor((isClaimed or nil) and (kClaimedHexColor or nil))
				itemIcon:customOnClickCallback(self["_onClickItem" .. i], self)
				itemIcon:setCanShowDeadLine(false)

				itemCountTxt.text = itemCount and luaLang("multiple") .. itemCount or ""

				gohelper.setActive(goisget, isClaimed)
				gohelper.setActive(gocanget, isClaimable)
				gohelper.setActive(gotimebg, itemIcon:isExpiredItem())
				SLFramework.UGUI.GuiHelper.SetColor(itemCountTxt, hexColor)
				SLFramework.UGUI.GuiHelper.SetColor(itemCountTxtBg, hexColor)
				SLFramework.UGUI.GuiHelper.SetColor(gotimebgImg, hexColor)
			end
		end
	end
end

function ShortenActStyleItem_impl:_onClickItem(itemType, itemId)
	local p = self:parent()

	if not p:onItemClick() then
		return
	end

	MaterialTipController.instance:showMaterialInfo(itemType, itemId)
end

function ShortenActStyleItem_impl:_onClickItem2()
	local paramList = self:_getBonusList()[2]
	local itemType = paramList[1]
	local itemId = paramList[2]

	self:_onClickItem(itemType, itemId)
end

function ShortenActStyleItem_impl:_onClickItem1()
	local paramList = self:_getBonusList()[1]
	local itemType = paramList[1]
	local itemId = paramList[2]

	self:_onClickItem(itemType, itemId)
end

function ShortenActStyleItem_impl:onDestroyView()
	GameUtil.onDestroyViewMemberList(self, "_commonPropItemIconList")
	ShortenActStyleItem_impl.super.onDestroyView(self)
	self:__onDispose()
end

return ShortenActStyleItem_impl
