-- chunkname: @modules/logic/bgmswitch/view/BGMSwitchMusicFilterView.lua

module("modules.logic.bgmswitch.view.BGMSwitchMusicFilterView", package.seeall)

local BGMSwitchMusicFilterView = class("BGMSwitchMusicFilterView", BaseView)

function BGMSwitchMusicFilterView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._goobtain = gohelper.findChild(self.viewGO, "container/layoutgroup/#go_obtain")
	self._scrollAmount = gohelper.findChildScrollRect(self.viewGO, "container/layoutgroup/#go_obtain/#scroll_Amount")
	self._gotypeitem = gohelper.findChild(self.viewGO, "container/layoutgroup/#go_obtain/#scroll_Amount/Viewport/Container/#go_typeitem")
	self._btnreset = gohelper.findChildButtonWithAudio(self.viewGO, "container/#btn_reset")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "container/#btn_confirm")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function BGMSwitchMusicFilterView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnreset:AddClickListener(self._btnresetOnClick, self)
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
end

function BGMSwitchMusicFilterView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnreset:RemoveClickListener()
	self._btnconfirm:RemoveClickListener()
end

function BGMSwitchMusicFilterView:_btncloseOnClick()
	self:closeThis()
end

function BGMSwitchMusicFilterView:_btnresetOnClick()
	BGMSwitchModel.instance:clearFilterTypes()
	BGMSwitchController.instance:dispatchEvent(BGMSwitchEvent.FilterClassSelect)
	self:_refreshView()
end

function BGMSwitchMusicFilterView:_btnconfirmOnClick()
	self:closeThis()
end

function BGMSwitchMusicFilterView:_editableInitView()
	self._items = {}
end

function BGMSwitchMusicFilterView:onUpdateParam()
	return
end

function BGMSwitchMusicFilterView:onOpen()
	self:_addSelfEvents()
	self:_refreshView()
end

function BGMSwitchMusicFilterView:_addSelfEvents()
	return
end

function BGMSwitchMusicFilterView:_refreshView()
	self:_refreshContent()
	self:_refreshItems()
end

function BGMSwitchMusicFilterView:_refreshContent()
	return
end

function BGMSwitchMusicFilterView:_refreshItems()
	local types = {}
	local bgms = {}
	local selectType = BGMSwitchModel.instance:getBGMSelectType()

	if selectType == BGMSwitchEnum.SelectType.All then
		bgms = BGMSwitchModel.instance:getUnfilteredAllBgmsSorted()
	elseif selectType == BGMSwitchEnum.SelectType.Loved then
		bgms = BGMSwitchModel.instance:getUnfilteredFavoriteBgmsSorted()
	end

	for _, v in pairs(bgms) do
		local bgmCo = BGMSwitchConfig.instance:getBGMSwitchCO(v)

		types[bgmCo.audioType] = true
	end

	for type, _ in pairs(types) do
		if not self._items[type] then
			local item = BGMSwitchMusicFilterItem.New()
			local go = gohelper.cloneInPlace(self._gotypeitem, type)

			item:init(go)

			self._items[type] = item
		end

		local co = BGMSwitchConfig.instance:getBGMTypeCO(type)

		self._items[type]:setItem(co)
	end
end

function BGMSwitchMusicFilterView:onClose()
	self:_removeSelfEvents()
end

function BGMSwitchMusicFilterView:_removeSelfEvents()
	return
end

function BGMSwitchMusicFilterView:onDestroyView()
	if self._items then
		for _, v in pairs(self._items) do
			v:destroy()
		end
	end
end

return BGMSwitchMusicFilterView
