-- chunkname: @modules/logic/versionactivity1_4/act130/view/Activity130CollectItem.lua

module("modules.logic.versionactivity1_4.act130.view.Activity130CollectItem", package.seeall)

local Activity130CollectItem = class("Activity130CollectItem", LuaCompBase)

function Activity130CollectItem:init(go)
	self._go = go
	self._imageitembg = gohelper.findChildImage(self._go, "image_ItemBG")
	self._imageicon = gohelper.findChildImage(self._go, "#image_Icon")
	self._txtIndex = gohelper.findChildText(self._go, "#txt_Num")
	self._txtDesc = gohelper.findChildText(self._go, "#txt_Item")
	self._txtTitle = gohelper.findChildText(self._go, "#txt_Type")

	self:addEventListeners()
end

function Activity130CollectItem:setItem(co, index)
	self._config = co
	self._index = index

	gohelper.setActive(self._go, true)
	self:_refreshItem()
end

function Activity130CollectItem:_refreshItem()
	self._txtIndex.text = string.format("%02d", self._index)

	local episodeId = Activity130Model.instance:getCurEpisodeId()
	local type = Activity130Model.instance:getCollects(episodeId)[self._index]
	local unlock = Activity130Model.instance:isCollectUnlock(episodeId, type)

	if not unlock then
		self._txtDesc.text = "?????"

		UISpriteSetMgr.instance:setV1a4Role37Sprite(self._imageicon, "v1a4_role37_collectitemiconempty")

		return
	end

	self._txtDesc.text = self._config.operDesc
	self._txtTitle.text = self._config.name

	UISpriteSetMgr.instance:setV1a4Role37Sprite(self._imageicon, self._config.shapegetImg)
end

function Activity130CollectItem:hideItem()
	gohelper.setActive(self._go, false)
end

function Activity130CollectItem:addEventListeners()
	return
end

function Activity130CollectItem:removeEventListeners()
	return
end

function Activity130CollectItem:_btnclickOnClick()
	return
end

function Activity130CollectItem:onUpdateMO(mo)
	return
end

function Activity130CollectItem:onSelect()
	return
end

function Activity130CollectItem:onDestroyView()
	self:removeEventListeners()
end

return Activity130CollectItem
