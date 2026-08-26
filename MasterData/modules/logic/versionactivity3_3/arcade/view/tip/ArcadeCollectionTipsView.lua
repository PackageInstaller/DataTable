-- chunkname: @modules/logic/versionactivity3_3/arcade/view/tip/ArcadeCollectionTipsView.lua

module("modules.logic.versionactivity3_3.arcade.view.tip.ArcadeCollectionTipsView", package.seeall)

local ArcadeCollectionTipsView = class("ArcadeCollectionTipsView", ArcadeTipsChildViewBase)

function ArcadeCollectionTipsView:init(go)
	self.viewGO = go
	self._gocontent = gohelper.findChild(self.viewGO, "collection/#scroll_collection/viewport/content")
	self._gocollectionitem = gohelper.findChild(self.viewGO, "collection/#scroll_collection/viewport/content/#go_collectionitem")
	self._txtdec = gohelper.findChildText(self._gocollectionitem, "txt_desc")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ArcadeCollectionTipsView:addEventListeners()
	return
end

function ArcadeCollectionTipsView:removeEventListeners()
	return
end

function ArcadeCollectionTipsView:_editableInitView()
	ArcadeCollectionTipsView.super._editableInitView(self)
	gohelper.setActive(self._gocollectionitem, false)

	self._animPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO.gameObject)
end

function ArcadeCollectionTipsView:onUpdateMO(mo, tipview)
	self._isInSide = mo.isInSide
	self._showNewCollection = false

	if self._isInSide then
		if not self._collectionList then
			self._showNewCollection = true
		end

		if mo then
			self._collectionList = mo.collectionList or {}
		end
	else
		if not self._collectionMo or mo.CollectionMo and self._collectionMo.id ~= mo.CollectionMo.id then
			self._showNewCollection = true
		end

		self._collectionMo = mo.CollectionMo
	end

	ArcadeCollectionTipsView.super.onUpdateMO(self, mo, tipview)
end

function ArcadeCollectionTipsView:isPlayOpenAnim()
	return self._showNewCollection or self._isChange
end

function ArcadeCollectionTipsView:refreshView()
	if self._collectionItemList then
		for _, item in ipairs(self._collectionItemList) do
			gohelper.setActive(item.go, false)
		end
	end

	for i, data in ipairs(self._isInSide and self._collectionList or {
		self._collectionMo
	}) do
		local name = ""
		local desc = ""
		local icon
		local count = 1

		if self._isInSide then
			name = ArcadeConfig.instance:getCollectionName(data)
			desc = ArcadeConfig.instance:getCollectionDesc(data)
			icon = ArcadeConfig.instance:getCollectionIcon(data)

			local type = ArcadeConfig.instance:getCollectionType(data)

			if type == ArcadeGameEnum.CollectionType.Jewelry then
				local characterMO = ArcadeGameModel.instance:getCharacterMO()
				local uidList = characterMO and characterMO:getCollectionUidList(data)

				if uidList then
					count = #uidList
				end
			end
		else
			name = data:getName()
			desc = data:getDesc()
			count = data:getCount()
			icon = data:getIcon()
		end

		local item = self:getCollectionItem(i)

		item.txtname.text = name
		item.txtdec.text = desc
		item.txtnum.text = "*" .. count

		if not string.nilorempty(icon) then
			item.simgicon:LoadImage(ResUrl.getEliminateIcon(icon))
		end

		gohelper.setActive(item.go, true)
	end
end

function ArcadeCollectionTipsView:getCollectionItem(index)
	self._collectionItemList = self._collectionItemList or {}

	local item = self._collectionItemList[index]

	if not item then
		item = self:getUserDataTb_()
		item.go = gohelper.clone(self._gocollectionitem, self._gocontent)
		item.txtname = gohelper.findChildText(item.go, "title/txt_name")
		item.txtnum = gohelper.findChildText(item.go, "title/txt_name/txt_num")
		item.txtdec = gohelper.findChildText(item.go, "txt_desc")
		item.simgicon = gohelper.findChildSingleImage(item.go, "title/simage_icon")
		self._collectionItemList[index] = item
	end

	return item
end

function ArcadeCollectionTipsView:setAnchor(mo, x, y)
	if not mo.isInSide then
		self._collectionMo = mo.CollectionMo

		local height = GameUtil.getPreferredHeight(self._txtdec, self._collectionMo:getDesc())

		if height > 130 then
			y = y + height - 130
		end
	end

	recthelper.setAnchor(self.viewGO.transform, x, y)
end

function ArcadeCollectionTipsView:onDestroy()
	if self._collectionItemList then
		for _, item in ipairs(self._collectionItemList) do
			item.simgicon:UnLoadImage()
		end
	end
end

return ArcadeCollectionTipsView
