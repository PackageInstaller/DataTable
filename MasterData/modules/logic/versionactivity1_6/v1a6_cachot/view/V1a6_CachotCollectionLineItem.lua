-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotCollectionLineItem.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotCollectionLineItem", package.seeall)

local V1a6_CachotCollectionLineItem = class("V1a6_CachotCollectionLineItem", MixScrollCell)

function V1a6_CachotCollectionLineItem:init(go)
	self.viewGO = go
	self._golayout = gohelper.findChild(go, "#go_layout")
	self._gotop = gohelper.findChild(go, "#go_top")
	self._imagetitleicon = gohelper.findChildImage(go, "#go_top/#image_titleicon")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a6_CachotCollectionLineItem:addEventListeners()
	return
end

function V1a6_CachotCollectionLineItem:removeEventListeners()
	return
end

function V1a6_CachotCollectionLineItem:onUpdateMO(mo, mixType, param)
	self._mo = mo

	self:_initCloneCollectionItemRes()
	self:refreshUI()
end

function V1a6_CachotCollectionLineItem:_editableInitView()
	self._animator = gohelper.onceAddComponent(self.viewGO, gohelper.Type_Animator)

	V1a6_CachotCollectionController.instance:registerCallback(V1a6_CachotEvent.OnSwitchCategory, self._resetAnimPlayState, self)
end

function V1a6_CachotCollectionLineItem:refreshUI()
	gohelper.setActive(self._gotop, self._mo._isTop)
	UISpriteSetMgr.instance:setV1a6CachotSprite(self._imagetitleicon, "v1a6_cachot_icon_collectionsort" .. self._mo.collectionType)
	gohelper.CreateObjList(self, self._onUpdateCollectionItem, self._mo.collectionList, self._golayout, self._cloneCollectionItemRes, V1a6_CachotCollectionItem)
	self:_playAnim()
end

function V1a6_CachotCollectionLineItem:_onUpdateCollectionItem(obj, collectionCfg, index)
	gohelper.setActive(obj.viewGO, collectionCfg ~= nil)

	if collectionCfg then
		obj:onUpdateMO(collectionCfg, self._index)
	end
end

function V1a6_CachotCollectionLineItem:_initCloneCollectionItemRes()
	if not self._cloneCollectionItemRes then
		local viewSetting = ViewMgr.instance:getSetting(self._view.viewName)

		self._cloneCollectionItemRes = self._view.viewContainer:getRes(viewSetting.otherRes[1])
	end
end

function V1a6_CachotCollectionLineItem:_playAnim()
	if self._mo._isTop and not self._isPlayOpenAnimFinished then
		self._animator:Play("open", 0, 0)

		self._isPlayOpenAnimFinished = true
	else
		self._animator:Play("idle", 0, 0)
	end
end

function V1a6_CachotCollectionLineItem:_resetAnimPlayState()
	self._isPlayOpenAnimFinished = false

	self:_playAnim()
end

function V1a6_CachotCollectionLineItem:onDestroy()
	self._cloneCollectionItemRes = nil

	V1a6_CachotCollectionController.instance:unregisterCallback(V1a6_CachotEvent.OnSwitchCategory, self._resetAnimPlayState, self)
end

return V1a6_CachotCollectionLineItem
