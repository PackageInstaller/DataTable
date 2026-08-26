-- chunkname: @modules/logic/versionactivity2_8/nuodika/view/NuoDiKaInfosView.lua

module("modules.logic.versionactivity2_8.nuodika.view.NuoDiKaInfosView", package.seeall)

local NuoDiKaInfosView = class("NuoDiKaInfosView", BaseView)

function NuoDiKaInfosView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._gocontent = gohelper.findChild(self.viewGO, "#go_content")
	self._goenemy = gohelper.findChild(self.viewGO, "#go_content/scroll_content/Viewport/go_content/#go_enemy")
	self._goenemyitem = gohelper.findChild(self.viewGO, "#go_content/scroll_content/Viewport/go_content/#go_enemy/#go_enemyitem")
	self._goterrain = gohelper.findChild(self.viewGO, "#go_content/scroll_content/Viewport/go_content/#go_terrain")
	self._goterrainitem = gohelper.findChild(self.viewGO, "#go_content/scroll_content/Viewport/go_content/#go_terrain/#go_terrainitem")
	self._goitem = gohelper.findChild(self.viewGO, "#go_content/scroll_content/Viewport/go_content/#go_item")
	self._goitemitem = gohelper.findChild(self.viewGO, "#go_content/scroll_content/Viewport/go_content/#go_item/#go_itemitem")
	self._btnclose1 = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close1")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function NuoDiKaInfosView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnclose1:AddClickListener(self._btnclose1OnClick, self)
end

function NuoDiKaInfosView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnclose1:RemoveClickListener()
end

function NuoDiKaInfosView:_btncloseOnClick()
	self:closeThis()
end

function NuoDiKaInfosView:_btnclose1OnClick()
	self:closeThis()
end

function NuoDiKaInfosView:onClickModalMask()
	self:closeThis()
end

function NuoDiKaInfosView:_editableInitView()
	self._enemyList = {}
	self._itemList = {}
end

function NuoDiKaInfosView:onOpen()
	self:refreshUI()
end

function NuoDiKaInfosView:refreshUI()
	self:refreshEnemys()
	self:refreshItems()
end

function NuoDiKaInfosView:refreshEnemys()
	for _, v in pairs(self._enemyList) do
		v:hide()
	end

	local enemyCos = NuoDiKaMapModel.instance:getMapEnemys()

	for _, co in ipairs(enemyCos) do
		if not self._enemyList[co.enemyId] then
			self._enemyList[co.enemyId] = NuoDiKaInfoItem.New()

			local go = gohelper.clone(self._goenemyitem, self._goenemy)

			self._enemyList[co.enemyId]:init(go, NuoDiKaEnum.EventType.Enemy)
		end

		self._enemyList[co.enemyId]:setItem(co)
	end
end

function NuoDiKaInfosView:refreshItems()
	for _, v in pairs(self._itemList) do
		v:hide()
	end

	local itemCos = NuoDiKaMapModel.instance:getMapItems()

	for _, co in ipairs(itemCos) do
		if not self._itemList[co.itemId] then
			self._itemList[co.itemId] = NuoDiKaInfoItem.New()

			local go = gohelper.clone(self._goitemitem, self._goitem)

			self._itemList[co.itemId]:init(go, NuoDiKaEnum.EventType.Item)
		end

		self._itemList[co.itemId]:setItem(co)
	end
end

function NuoDiKaInfosView:onClose()
	return
end

function NuoDiKaInfosView:onDestroyView()
	if self._enemyList then
		for _, v in pairs(self._enemyList) do
			v:destory()
		end

		self._enemyList = nil
	end

	if self._itemList then
		for _, v in pairs(self._itemList) do
			v:destory()
		end

		self._itemList = nil
	end
end

return NuoDiKaInfosView
