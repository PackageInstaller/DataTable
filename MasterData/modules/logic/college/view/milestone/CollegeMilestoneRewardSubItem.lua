-- chunkname: @modules/logic/college/view/milestone/CollegeMilestoneRewardSubItem.lua

module("modules.logic.college.view.milestone.CollegeMilestoneRewardSubItem", package.seeall)

local CollegeMilestoneRewardSubItem = class("CollegeMilestoneRewardSubItem", ListScrollCellExtend)

function CollegeMilestoneRewardSubItem:onInitView()
	self._goIcon = gohelper.findChild(self.viewGO, "go_icon")
	self._goCanGet = gohelper.findChild(self.viewGO, "go_canget")
	self._goHasGet = gohelper.findChild(self.viewGO, "go_receive")
	self._imageRare = gohelper.findChildImage(self.viewGO, "#image_qualitybg")
	self._txtCount = gohelper.findChildText(self.viewGO, "#txt_count")
	self._itemIcon = IconMgr.instance:getCommonPropItemIcon(self._goIcon)
end

function CollegeMilestoneRewardSubItem:addEvents()
	return
end

function CollegeMilestoneRewardSubItem:removeEvents()
	return
end

function CollegeMilestoneRewardSubItem:onUpdateMO(materilType, materilId, quantity, canGet, hasGet)
	self._itemIcon:setMOValue(materilType, materilId, quantity)
	self._itemIcon:setCountFontSize(46)
	self._itemIcon:isShowCount(false)
	self._itemIcon:isShowQuality(false)
	self._itemIcon:setInterceptClick(self._iconClickCallback, self)

	self._canGet = canGet
	self._hasGet = hasGet

	gohelper.setActive(self._goCanGet, canGet)
	gohelper.setActive(self._goHasGet, hasGet)

	local config = ItemModel.instance:getItemConfigAndIcon(materilType, materilId, true)

	UISpriteSetMgr.instance:setOptionalGiftSprite(self._imageRare, string.format("bg_pinjidi_%s", config.rare))

	self._txtCount.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("multi_num"), GameUtil.numberDisplay(quantity))
end

function CollegeMilestoneRewardSubItem:_iconClickCallback()
	if self._canGet then
		CollegeRpc.instance:sendCollegeMilestoneClaim()
	end

	return self._canGet
end

function CollegeMilestoneRewardSubItem:onDestroyView()
	return
end

return CollegeMilestoneRewardSubItem
