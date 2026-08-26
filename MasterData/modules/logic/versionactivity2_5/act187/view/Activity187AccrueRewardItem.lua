-- chunkname: @modules/logic/versionactivity2_5/act187/view/Activity187AccrueRewardItem.lua

module("modules.logic.versionactivity2_5.act187.view.Activity187AccrueRewardItem", package.seeall)

local Activity187AccrueRewardItem = class("Activity187AccrueRewardItem", LuaCompBase)

function Activity187AccrueRewardItem:init(go)
	self.go = go

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity187AccrueRewardItem:_editableInitView()
	self._btnItem = gohelper.findChildClick(self.go, "#go_item")
	self._imagebg = gohelper.findChildImage(self.go, "#go_item/#image_bg")
	self._simagereward = gohelper.findChildSingleImage(self.go, "#go_item/#simage_reward")
	self._imagecircle = gohelper.findChildImage(self.go, "#go_item/image_circle")
	self._txtrewardcount = gohelper.findChildText(self.go, "#go_item/#txt_rewardcount")
	self._deadline1 = gohelper.findChild(self.go, "#go_item/deadline1")
	self._gohasget = gohelper.findChild(self.go, "#go_status/#go_hasget")
	self._gocanget = gohelper.findChild(self.go, "#go_status/#go_canget")
	self._btnget = gohelper.findChildClickWithDefaultAudio(self.go, "#go_status/#go_canget/#btn_get")
	self._imagestatus = gohelper.findChildImage(self.go, "#image_point")
	self._txtpointvalue = gohelper.findChildText(self.go, "#txt_pointvalue")
	self._hasGetAnimator = self._gohasget:GetComponent(typeof(UnityEngine.Animator))
end

function Activity187AccrueRewardItem:addEventListeners()
	self._btnget:AddClickListener(self._btngetOnClick, self)
	self._btnItem:AddClickListener(self._btnitemOnClick, self)
end

function Activity187AccrueRewardItem:removeEventListeners()
	self._btnget:RemoveClickListener()
	self._btnItem:RemoveClickListener()
end

function Activity187AccrueRewardItem:_btngetOnClick()
	if not self.data then
		return
	end

	local finishPaintIndex = Activity187Model.instance:getFinishPaintingIndex()
	local accrueRewardIndex = Activity187Model.instance:getAccrueRewardIndex()
	local hasGet = accrueRewardIndex >= self.id
	local canGet = not hasGet and finishPaintIndex >= self.id

	if canGet and not hasGet then
		Activity187Controller.instance:getAccrueReward()
	end
end

function Activity187AccrueRewardItem:_btnitemOnClick()
	if not self.data then
		return
	end

	MaterialTipController.instance:showMaterialInfo(self.data.materilType, self.data.materilId)
end

function Activity187AccrueRewardItem:setData(data)
	self.data = data
	self.id = self.data and self.data.accrueId

	self:setItem()
	self:refreshStatus()
	gohelper.setActive(self.go, self.data)
end

function Activity187AccrueRewardItem:setItem()
	if not self.data then
		return
	end

	local itemCfg, iconPath = ItemModel.instance:getItemConfigAndIcon(self.data.materilType, self.data.materilId)

	UISpriteSetMgr.instance:setUiFBSprite(self._imagebg, "bg_pinjidi_" .. itemCfg.rare)
	self._simagereward:LoadImage(iconPath)
	UISpriteSetMgr.instance:setUiFBSprite(self._imagecircle, "bg_pinjidi_lanse_" .. itemCfg.rare)

	self._txtrewardcount.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("multiple_1"), self.data.quantity)
	self._txtpointvalue.text = formatLuaLang("times2", self.id)

	gohelper.setActive(self._deadline1, (self.data.materilType == MaterialEnum.MaterialType.PowerPotion or nil) and itemCfg.expireType ~= 0 and not string.nilorempty(itemCfg.expireTime))
end

function Activity187AccrueRewardItem:refreshStatus(isPlayAnim)
	if not self.data then
		return
	end

	local finishPaintIndex = Activity187Model.instance:getFinishPaintingIndex()
	local accrueRewardIndex = Activity187Model.instance:getAccrueRewardIndex()
	local hasGet = accrueRewardIndex >= self.id
	local canGet = not hasGet and finishPaintIndex >= self.id
	local txtColor = hasGet and "#CF7845" or "#968C89"

	SLFramework.UGUI.GuiHelper.SetColor(self._txtpointvalue, txtColor)
	UISpriteSetMgr.instance:setUiFBSprite(self._imagestatus, "bg_xingjidian" .. (hasGet and "" or "_dis"), true)

	if isPlayAnim and canGet then
		gohelper.setActive(self._gohasget, true)
		gohelper.setActive(self._gocanget, false)
		self._hasGetAnimator:Play("open")
	else
		gohelper.setActive(self._gohasget, hasGet)
		gohelper.setActive(self._gocanget, canGet)
	end
end

function Activity187AccrueRewardItem:onDestroy()
	self._simagereward:UnLoadImage()
end

return Activity187AccrueRewardItem
