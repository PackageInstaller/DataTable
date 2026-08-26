-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotCollectionView.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotCollectionView", package.seeall)

local V1a6_CachotCollectionView = class("V1a6_CachotCollectionView", BaseView)

function V1a6_CachotCollectionView:onInitView()
	self._simagelevelbg = gohelper.findChildSingleImage(self.viewGO, "#simage_levelbg")
	self._simagetitle = gohelper.findChildSingleImage(self.viewGO, "left/#simage_title")
	self._simagetitleicon = gohelper.findChildSingleImage(self.viewGO, "left/#simage_titleicon")
	self._scrollview = gohelper.findChildScrollRect(self.viewGO, "left/#scroll_view")
	self._gocollectionitem = gohelper.findChild(self.viewGO, "left/#scroll_view/Viewport/Content/#go_collectionitem")
	self._gocollectionsort = gohelper.findChild(self.viewGO, "left/#go_collectionsort")
	self._btnall = gohelper.findChildButtonWithAudio(self.viewGO, "left/#go_collectionsort/#btn_all")
	self._btnhasget = gohelper.findChildButtonWithAudio(self.viewGO, "left/#go_collectionsort/#btn_hasget")
	self._btnunget = gohelper.findChildButtonWithAudio(self.viewGO, "left/#go_collectionsort/#btn_unget")
	self._simagecollection = gohelper.findChildSingleImage(self.viewGO, "right/#go_collectioninfo/#simage_collection")
	self._golock = gohelper.findChild(self.viewGO, "right/#go_collectioninfo/#go_lock")
	self._gounget = gohelper.findChild(self.viewGO, "right/#go_collectioninfo/#go_unget")
	self._gohasget = gohelper.findChild(self.viewGO, "right/#go_collectioninfo/#go_hasget")
	self._gogrid1 = gohelper.findChild(self.viewGO, "right/#go_collectioninfo/#go_hasget/layout/#go_grid1")
	self._simageget1 = gohelper.findChildSingleImage(self.viewGO, "right/#go_collectioninfo/#go_hasget/layout/#go_grid1/#simage_get1")
	self._simageicon1 = gohelper.findChildSingleImage(self.viewGO, "right/#go_collectioninfo/#go_hasget/layout/#go_grid1/#simage_get1/#simage_icon1")
	self._gogrid2 = gohelper.findChild(self.viewGO, "right/#go_collectioninfo/#go_hasget/layout/#go_grid2")
	self._simageget2 = gohelper.findChildSingleImage(self.viewGO, "right/#go_collectioninfo/#go_hasget/layout/#go_grid2/#simage_get2")
	self._simageicon2 = gohelper.findChildSingleImage(self.viewGO, "right/#go_collectioninfo/#go_hasget/layout/#go_grid2/#simage_get2/#simage_icon2")
	self._gounique = gohelper.findChild(self.viewGO, "right/#go_collectioninfo/#go_hasget/#go_unique")
	self._txtuniquetips = gohelper.findChildText(self.viewGO, "right/#go_collectioninfo/#go_hasget/#go_unique/#txt_uniquetips")
	self._txtdesc = gohelper.findChildText(self.viewGO, "right/#go_collectioninfo/#go_hasget/#scroll_effectcontainer/Viewport/Content/descontainer/#txt_desc")
	self._txtname = gohelper.findChildText(self.viewGO, "right/#go_collectioninfo/#txt_name")
	self._scrolleffectcontainer = gohelper.findChildScrollRect(self.viewGO, "right/#go_collectioninfo/#go_hasget/#scroll_effectcontainer")
	self._goskillcontainer = gohelper.findChild(self.viewGO, "right/#go_collectioninfo/#go_hasget/#scroll_effectcontainer/Viewport/Content/#go_skillcontainer")
	self._godescitem = gohelper.findChild(self.viewGO, "right/#go_collectioninfo/#go_hasget/#scroll_effectcontainer/Viewport/Content/#go_skillcontainer/#go_descitem")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._txtunlocktask = gohelper.findChildText(self.viewGO, "right/#go_collectioninfo/#go_lock/#txt_unlocktask")
	self._gocollectioninfo = gohelper.findChild(self.viewGO, "right/#go_collectioninfo")
	self._goscrollempty = gohelper.findChild(self.viewGO, "left/#go_scrollempty")
	self._gocollectionempty = gohelper.findChild(self.viewGO, "right/#go_collectionempty")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a6_CachotCollectionView:addEvents()
	self._btnall:AddClickListener(self._btnallOnClick, self)
	self._btnhasget:AddClickListener(self._btnhasgetOnClick, self)
	self._btnunget:AddClickListener(self._btnungetOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function V1a6_CachotCollectionView:removeEvents()
	self._btnall:RemoveClickListener()
	self._btnhasget:RemoveClickListener()
	self._btnunget:RemoveClickListener()
	self._btnclose:RemoveClickListener()
end

function V1a6_CachotCollectionView:_btnallOnClick()
	V1a6_CachotCollectionController.instance:onSwitchCategory(V1a6_CachotEnum.CollectionCategoryType.All)
end

function V1a6_CachotCollectionView:_btnhasgetOnClick()
	V1a6_CachotCollectionController.instance:onSwitchCategory(V1a6_CachotEnum.CollectionCategoryType.HasGet)
end

function V1a6_CachotCollectionView:_btnungetOnClick()
	V1a6_CachotCollectionController.instance:onSwitchCategory(V1a6_CachotEnum.CollectionCategoryType.UnGet)
end

function V1a6_CachotCollectionView:_btncloseOnClick()
	self:closeThis()
end

function V1a6_CachotCollectionView:_editableInitView()
	self.addEventCb(self, V1a6_CachotCollectionController.instance, V1a6_CachotEvent.OnSelectCollectionItem, self.refreshCollectionInfo, self)
	self.addEventCb(self, V1a6_CachotCollectionController.instance, V1a6_CachotEvent.OnSwitchCategory, self.switchCategory, self)

	self._imagecollectionicon = gohelper.findChildImage(self.viewGO, "right/#go_collectioninfo/#simage_collection")
end

function V1a6_CachotCollectionView:onUpdateParam()
	return
end

local maxCollectionNumSingleLine = 4

function V1a6_CachotCollectionView:onOpen()
	V1a6_CachotCollectionController.instance:onOpenView(V1a6_CachotEnum.CollectionCategoryType.All, maxCollectionNumSingleLine)
end

V1a6_CachotCollectionView.IconUnLockColor = "#FFFFFF"
V1a6_CachotCollectionView.IconLockColor = "#060606"
V1a6_CachotCollectionView.IconUnLockAlpha = 1
V1a6_CachotCollectionView.IconLockAlpha = 0.7

function V1a6_CachotCollectionView:refreshCollectionInfo()
	local curSelectCollectionId = V1a6_CachotCollectionListModel.instance:getCurSelectCollectionId()

	gohelper.setActive(self._gocollectioninfo, curSelectCollectionId ~= nil)
	gohelper.setActive(self._gocollectionempty, curSelectCollectionId == nil)
	gohelper.setActive(self._goscrollempty, curSelectCollectionId == nil)

	if curSelectCollectionId then
		local collectionState = V1a6_CachotCollectionListModel.instance:getCollectionState(curSelectCollectionId)
		local collectionCfg = V1a6_CachotCollectionConfig.instance:getCollectionConfig(curSelectCollectionId)

		gohelper.setActive(self._gohasget, collectionState == V1a6_CachotEnum.CollectionState.HasGet or collectionState == V1a6_CachotEnum.CollectionState.New)
		gohelper.setActive(self._golock, collectionState == V1a6_CachotEnum.CollectionState.Locked)
		gohelper.setActive(self._gounget, collectionState == V1a6_CachotEnum.CollectionState.UnLocked)
		gohelper.setActive(self._txtname, collectionState ~= V1a6_CachotEnum.CollectionState.Locked)

		if collectionCfg and collectionState then
			local collectionIconColor = V1a6_CachotCollectionView.IconUnLockColor
			local collectionIconAlpha = V1a6_CachotCollectionView.IconUnLockAlpha

			if collectionState == V1a6_CachotEnum.CollectionState.Locked then
				self:onCollectionLockedState(collectionCfg)

				collectionIconColor = V1a6_CachotCollectionView.IconLockColor
				collectionIconAlpha = V1a6_CachotCollectionView.IconLockAlpha
			elseif collectionState == V1a6_CachotEnum.CollectionState.UnLocked then
				self:onCollectionUnLockedState(collectionCfg)
			else
				self:onCollectionHasGetState(collectionCfg)
			end

			self._simagecollection:LoadImage(ResUrl.getV1a6CachotIcon("collection/" .. collectionCfg.icon))
			SLFramework.UGUI.GuiHelper.SetColor(self._imagecollectionicon, collectionIconColor)
			ZProj.UGUIHelper.SetColorAlpha(self._imagecollectionicon, collectionIconAlpha)
		end
	end
end

function V1a6_CachotCollectionView:onCollectionLockedState(collectionCfg)
	local unLockTaskId = collectionCfg.unlockTask
	local unLockTaskCfg = lua_rogue_collecion_unlock_task.configDict[unLockTaskId]

	if unLockTaskCfg then
		self._txtunlocktask.text = unLockTaskCfg.desc or ""
	end
end

function V1a6_CachotCollectionView:onCollectionUnLockedState(collectionCfg)
	self._txtname.text = tostring(collectionCfg.name)
end

function V1a6_CachotCollectionView:onCollectionHasGetState(collectionCfg)
	gohelper.setActive(self._gohasget, true)

	self._txtname.text = tostring(collectionCfg.name)
	self._txtdesc.text = tostring(collectionCfg.desc)

	gohelper.setActive(self._gogrid1, collectionCfg.holeNum >= 1)
	gohelper.setActive(self._gogrid2, collectionCfg.holeNum >= 2)
	V1a6_CachotCollectionHelper.refreshCollectionUniqueTip(collectionCfg, self._txtuniquetips, self._gounique)
	V1a6_CachotCollectionHelper.refreshSkillDesc(collectionCfg, self._goskillcontainer, self._godescitem, self._refreshSingleSkillDesc, self._refreshSingleEffectDesc, self)
end

local effectPercentColor = "#6F3C0F"
local effectBracketColor = "#2B4E6C"

function V1a6_CachotCollectionView:_refreshSingleSkillDesc(obj, skillId, index)
	local skillCfg = lua_rule.configDict[skillId]

	if skillCfg then
		local txtEffectDesc = gohelper.findChildText(obj, "txt_desc")

		txtEffectDesc.text = HeroSkillModel.instance:skillDesToSpot(skillCfg.desc, effectPercentColor, effectBracketColor)
	end
end

function V1a6_CachotCollectionView:_refreshSingleEffectDesc(obj, effectId, index)
	local effectCfg = SkillConfig.instance:getSkillEffectDescCo(effectId)

	if effectCfg then
		local txtEffectDesc = gohelper.findChildText(obj, "txt_desc")
		local info = string.format("[%s]:%s", effectCfg.name, effectCfg.desc)

		txtEffectDesc.text = HeroSkillModel.instance:skillDesToSpot(info, effectPercentColor, effectBracketColor)
	end
end

function V1a6_CachotCollectionView:switchCategory()
	local curCategory = V1a6_CachotCollectionListModel.instance:getCurCategory()

	self:refreshCategoryUI(self._btnall.gameObject, curCategory == V1a6_CachotEnum.CollectionCategoryType.All)
	self:refreshCategoryUI(self._btnhasget.gameObject, curCategory == V1a6_CachotEnum.CollectionCategoryType.HasGet)
	self:refreshCategoryUI(self._btnunget.gameObject, curCategory == V1a6_CachotEnum.CollectionCategoryType.UnGet)

	self._scrollview.verticalNormalizedPosition = 1
end

function V1a6_CachotCollectionView:refreshCategoryUI(btn, isSelect)
	if btn then
		local unSelectUI = gohelper.findChild(btn, "btn1")
		local selectUI = gohelper.findChild(btn, "btn2")

		gohelper.setActive(selectUI, isSelect)
		gohelper.setActive(unSelectUI, not isSelect)
	end
end

function V1a6_CachotCollectionView:onClose()
	self.removeEventCb(self, V1a6_CachotCollectionController.instance, V1a6_CachotEvent.OnSelectCollectionItem, self.refreshCollectionInfo, self)
	self.removeEventCb(self, V1a6_CachotCollectionController.instance, V1a6_CachotEvent.OnSwitchCategory, self.switchCategory, self)
	V1a6_CachotCollectionController.instance:onCloseView()
end

function V1a6_CachotCollectionView:onDestroyView()
	self._simagecollection:UnLoadImage()
end

return V1a6_CachotCollectionView
