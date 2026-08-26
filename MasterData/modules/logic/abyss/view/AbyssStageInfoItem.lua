-- chunkname: @modules/logic/abyss/view/AbyssStageInfoItem.lua

module("modules.logic.abyss.view.AbyssStageInfoItem", package.seeall)

local AbyssStageInfoItem = class("AbyssStageInfoItem", ListScrollCellExtend)

function AbyssStageInfoItem:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._simagebg = gohelper.findChildSingleImage(self.viewGO, "#simage_bg")
	self._scrollreward = gohelper.findChildScrollRect(self.viewGO, "right/#scroll_reward")
	self._gorewardcontent = gohelper.findChild(self.viewGO, "right/#scroll_reward/viewport/#go_rewardcontent")
	self._txtcountday = gohelper.findChildText(self.viewGO, "title/timebg/#txt_countday")
	self._gostatlistitem = gohelper.findChild(self.viewGO, "starlayout/#go_statlistitem")
	self._gostaritem = gohelper.findChild(self.viewGO, "starlayout/#go_statlistitem/starbg/#go_staritem")
	self._gostar = gohelper.findChild(self.viewGO, "starlayout/#go_statlistitem/starbg/#go_staritem/#go_star")
	self._txtchapternum = gohelper.findChildText(self.viewGO, "starlayout/#go_statlistitem/starbg/#txt_chapternum")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AbyssStageInfoItem:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function AbyssStageInfoItem:removeEvents()
	self._btnclose:RemoveClickListener()
end

function AbyssStageInfoItem:_btncloseOnClick()
	return
end

function AbyssStageInfoItem:_editableInitView()
	return
end

function AbyssStageInfoItem:_editableAddEvents()
	return
end

function AbyssStageInfoItem:_editableRemoveEvents()
	return
end

function AbyssStageInfoItem:onUpdateMO(mo)
	return
end

function AbyssStageInfoItem:onSelect(isSelect)
	return
end

function AbyssStageInfoItem:onDestroyView()
	return
end

return AbyssStageInfoItem
