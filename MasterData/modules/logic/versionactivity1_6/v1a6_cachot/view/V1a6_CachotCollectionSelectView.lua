-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotCollectionSelectView.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotCollectionSelectView", package.seeall)

local V1a6_CachotCollectionSelectView = class("V1a6_CachotCollectionSelectView", BaseView)

function V1a6_CachotCollectionSelectView:onInitView()
	self._simagelevelbg = gohelper.findChildSingleImage(self.viewGO, "#simage_levelbg")
	self._simagetitle = gohelper.findChildSingleImage(self.viewGO, "#simage_title")
	self._gocollectionitem = gohelper.findChild(self.viewGO, "scroll_view/Viewport/Content/#go_collectionitem")
	self._btnconfirm = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_confirm")
	self._godisableconfirm = gohelper.findChild(self.viewGO, "#go_disableconfirm")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a6_CachotCollectionSelectView:addEvents()
	self._btnconfirm:AddClickListener(self._btnconfirmOnClick, self)
end

function V1a6_CachotCollectionSelectView:removeEvents()
	self._btnconfirm:RemoveClickListener()
end

function V1a6_CachotCollectionSelectView:_editableInitView()
	self._animatorPlayer = SLFramework.AnimatorPlayer.Get(self.viewGO)
end

function V1a6_CachotCollectionSelectView:onUpdateParam()
	return
end

function V1a6_CachotCollectionSelectView:_btnconfirmOnClick()
	UIBlockMgr.instance:startBlock("V1a6_CachotCollectionSelectView_Get")

	if self._collectionItemTab then
		if self._collectionItemTab then
			if self.viewParam then
				if self.viewParam then
					local selectCallbackObj = self.viewParam.selectCallbackObj

					if self.viewParam and self._selectIndex then
						self.viewParam.selectCallback(selectCallbackObj, self._selectIndex)
					else
						logError(string.format("selectCallBack or selectIndex is nil, selectIndex = %s", self._selectIndex))
					end
				end
			end
		else
			logError("cannot find collectionItem, index = " .. tostring(self._selectIndex))
		end

		if self._animatorPlayer and self._playCollectionCloseAnimCallBack then
			self._animatorPlayer:Play("close", self._playCollectionCloseAnimCallBack, self)
			self:_closeOtherUnselectCollections()
		else
			self:closeThis()
		end
	end
end

function V1a6_CachotCollectionSelectView:onOpen()
	if self.viewParam then
		self:refreshGetCollectionList(self.viewParam)
		self:refreshConfirmBtnState()
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_shuori_story_click)
	end
end

function V1a6_CachotCollectionSelectView:refreshGetCollectionList(collectionIdList)
	local useMap = {}

	if collectionIdList then
		for index, v in ipairs(collectionIdList) do
			local collectionItem = self:_getOrCreateCollectionItem(index)

			useMap[collectionItem] = true

			local collectionCfg = V1a6_CachotCollectionConfig.instance:getCollectionConfig(v)

			if collectionCfg then
				collectionItem.simageIcon:LoadImage(ResUrl.getV1a6CachotIcon("collection/" .. collectionCfg.icon))

				if collectionCfg then
					collectionItem.txtName.text = collectionCfg.name or ""
				end

				V1a6_CachotCollectionHelper.refreshSkillDesc(collectionCfg, collectionItem.goskillcontainer, collectionItem.goskillItem)
				V1a6_CachotCollectionHelper.createCollectionHoles(collectionCfg, collectionItem.goEnchantList, collectionItem.goHole)
			end
		end
	end

	self:_recycleUnUseCollectionItem(useMap)
end

function V1a6_CachotCollectionSelectView:_getOrCreateCollectionItem(index)
	self._collectionItemTab = self._collectionItemTab or {}

	local collectionItem = self._collectionItemTab[index]

	if not collectionItem then
		collectionItem = self:getUserDataTb_()
		collectionItem.viewGO = gohelper.cloneInPlace(self._gocollectionitem, "collectionItem_" .. index)
		collectionItem.animator = gohelper.onceAddComponent(collectionItem.viewGO, gohelper.Type_Animator)
		collectionItem.imageBg = gohelper.findChildImage(collectionItem.viewGO, "#simage_bg")
		collectionItem.normalBg = gohelper.findChildImage(collectionItem.viewGO, "normal")

		UISpriteSetMgr.instance:setV1a6CachotSprite(collectionItem.imageBg, "v1a6_cachot_reward_bg1")

		collectionItem.simageIcon = gohelper.findChildSingleImage(collectionItem.viewGO, "#simage_collection")
		collectionItem.txtName = gohelper.findChildText(collectionItem.viewGO, "#txt_name")
		collectionItem.goSelect = gohelper.findChild(collectionItem.viewGO, "#go_select")
		collectionItem.btnSelect = gohelper.getClickWithDefaultAudio(collectionItem.viewGO)

		collectionItem.btnSelect:AddClickListener(self._onSelectCollection, self, index)

		collectionItem.goskillcontainer = gohelper.findChild(collectionItem.viewGO, "scroll_desc/Viewport/#go_skillcontainer")
		collectionItem.goskillItem = gohelper.findChild(collectionItem.viewGO, "scroll_desc/Viewport/#go_skillcontainer/#go_skillitem")
		collectionItem.goEnchantList = gohelper.findChild(collectionItem.viewGO, "#go_enchantlist")
		collectionItem.goHole = gohelper.findChild(collectionItem.viewGO, "#go_enchantlist/#go_hole")

		gohelper.setActive(collectionItem.viewGO, true)

		self._collectionItemTab[index] = collectionItem
	end

	return collectionItem
end

function V1a6_CachotCollectionSelectView:_onSelectCollection(index)
	self._selectIndex = index

	self:checkCollectionSelected(index)
	self:refreshConfirmBtnState()
end

function V1a6_CachotCollectionSelectView:checkCollectionSelected(selectIndex)
	if self._collectionItemTab then
		for index, collectionItem in ipairs(self._collectionItemTab) do
			gohelper.setActive(collectionItem.goSelect, selectIndex == index)
			gohelper.setActive(collectionItem.normalBg, selectIndex ~= index)
		end
	end
end

function V1a6_CachotCollectionSelectView:refreshConfirmBtnState()
	if self._selectIndex then
		local hasSelectCollection = self._selectIndex ~= 0

		gohelper.setActive(self._godisableconfirm, not hasSelectCollection)
		gohelper.setActive(self._btnconfirm.gameObject, hasSelectCollection)
	end
end

function V1a6_CachotCollectionSelectView:_releaseCallBackParam()
	if self.viewParam then
		self.viewParam.selectCallback = nil
		self.viewParam.selectCallbackObj = nil
	end
end

function V1a6_CachotCollectionSelectView:_recycleUnUseCollectionItem(useMap)
	if useMap and self._collectionItemTab then
		for _, v in pairs(self._collectionItemTab) do
			if not useMap[v] then
				gohelper.setActive(v.viewGO, false)
			end
		end
	end
end

function V1a6_CachotCollectionSelectView:_disposeAllCollectionItems()
	if self._collectionItemTab then
		for _, v in pairs(self._collectionItemTab) do
			if v.btnSelect then
				v.btnSelect:RemoveClickListener()
			end
		end
	end
end

function V1a6_CachotCollectionSelectView:_closeOtherUnselectCollections()
	if self._collectionItemTab then
		for index, collectionItem in ipairs(self._collectionItemTab) do
			if index ~= self._selectIndex then
				collectionItem.animator:Play("collectionitem_close")
			end
		end
	end
end

function V1a6_CachotCollectionSelectView:_playCollectionCloseAnimCallBack()
	self:closeThis()
	UIBlockMgr.instance:endBlock("V1a6_CachotCollectionSelectView_Get")
end

function V1a6_CachotCollectionSelectView:onClose()
	UIBlockMgr.instance:endBlock("V1a6_CachotCollectionSelectView_Get")
end

function V1a6_CachotCollectionSelectView:onDestroyView()
	self:_disposeAllCollectionItems()
	self:_releaseCallBackParam()
end

return V1a6_CachotCollectionSelectView
