-- chunkname: @modules/logic/character/view/CharacterTalentStatView.lua

module("modules.logic.character.view.CharacterTalentStatView", package.seeall)

local CharacterTalentStatView = class("CharacterTalentStatView", BaseView)

function CharacterTalentStatView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._goitem = gohelper.findChild(self.viewGO, "Scroll View/Viewport/Content/#go_item")
	self._gonormal = gohelper.findChild(self.viewGO, "Scroll View/Viewport/Content/#go_item/slot/#go_normal")
	self._imageicon = gohelper.findChildImage(self.viewGO, "Scroll View/Viewport/Content/#go_item/slot/#image_icon")
	self._imageglow = gohelper.findChildImage(self.viewGO, "Scroll View/Viewport/Content/#go_item/slot/#image_glow")
	self._txtname = gohelper.findChildText(self.viewGO, "Scroll View/Viewport/Content/#go_item/#txt_name")
	self._gopercent = gohelper.findChild(self.viewGO, "Scroll View/Viewport/Content/#go_item/#go_percent")
	self._txtpercent = gohelper.findChildText(self.viewGO, "Scroll View/Viewport/Content/#go_item/#txt_percent")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterTalentStatView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function CharacterTalentStatView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function CharacterTalentStatView:_btncloseOnClick()
	self:closeThis()
end

function CharacterTalentStatView:_editableInitView()
	return
end

function CharacterTalentStatView:onUpdateParam()
	return
end

function CharacterTalentStatView:onOpen()
	gohelper.setActive(self._goitem, false)

	self.heroId = self.viewParam.heroId

	self:showStylePercentList()
end

function CharacterTalentStatView:onClose()
	return
end

function CharacterTalentStatView:onDestroyView()
	return
end

function CharacterTalentStatView:showStylePercentList()
	local infos = TalentStyleModel.instance:getStyleCoList(self.heroId)

	if not infos then
		return
	end

	self._itemList = self._itemList or self:getUserDataTb_()

	local statInfos = {}

	for i, mo in ipairs(infos) do
		table.insert(statInfos, mo)
	end

	table.sort(statInfos, TalentStyleModel.sortUnlockPercent)

	for i, info in ipairs(statInfos) do
		local item = self:getItem(i)

		item:onRefreshMo(info)
	end

	for i = 1, #self._itemList do
		local item = self._itemList[i]

		gohelper.setActive(item.viewGO, i <= #infos)
	end
end

function CharacterTalentStatView:getItem(index)
	local item = self._itemList[index]

	if not item then
		local go = gohelper.cloneInPlace(self._goitem, "item_" .. index)

		item = MonoHelper.addNoUpdateLuaComOnceToGo(go, CharacterTalentStatItem)
		self._itemList[index] = item
	end

	return item
end

return CharacterTalentStatView
