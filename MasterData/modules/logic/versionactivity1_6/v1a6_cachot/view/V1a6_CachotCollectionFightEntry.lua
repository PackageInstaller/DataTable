-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotCollectionFightEntry.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotCollectionFightEntry", package.seeall)

local V1a6_CachotCollectionFightEntry = class("V1a6_CachotCollectionFightEntry", BaseView)

function V1a6_CachotCollectionFightEntry:ctor(rootPath)
	self._rootPath = rootPath or ""

	V1a6_CachotCollectionFightEntry.super.ctor(self)
end

function V1a6_CachotCollectionFightEntry:onInitView()
	self._rootGo = gohelper.findChild(self.viewGO, self._rootPath)

	gohelper.setActive(self._rootGo, true)

	self._btncollection = gohelper.findChildButtonWithAudio(self._rootGo, "#btn_collection")
	self._txtcollectionnum = gohelper.findChildText(self._rootGo, "#btn_collection/bg/#txt_collectionnum")
end

function V1a6_CachotCollectionFightEntry:addEvents()
	if self._btncollection then
		self._btncollection:AddClickListener(self._btncollectionOnClick, self)
	end

	self.addEventCb(self, V1a6_CachotController.instance, V1a6_CachotEvent.OnUpdateRogueInfo, self.refreshUI, self)
	self.addEventCb(self, V1a6_CachotController.instance, V1a6_CachotEvent.OnUpdateCollectionsInfo, self.updateCollectionNum, self)
end

function V1a6_CachotCollectionFightEntry:removeEvents()
	if self._btncollection then
		self._btncollection:RemoveClickListener()
	end

	self.removeEventCb(self, V1a6_CachotController.instance, V1a6_CachotEvent.OnUpdateRogueInfo, self.refreshUI, self)
	self.removeEventCb(self, V1a6_CachotController.instance, V1a6_CachotEvent.OnUpdateCollectionsInfo, self.updateCollectionNum, self)
end

function V1a6_CachotCollectionFightEntry:onOpen()
	self:refreshUI()
end

function V1a6_CachotCollectionFightEntry:refreshUI()
	self:updateCollectionNum()
end

function V1a6_CachotCollectionFightEntry:updateCollectionNum()
	local rogueInfo = V1a6_CachotModel.instance:getRogueInfo()

	if rogueInfo then
		self._txtcollectionnum.text = rogueInfo.collections and #rogueInfo.collections or 0
	end
end

function V1a6_CachotCollectionFightEntry:onClose()
	ViewMgr.instance:closeView(ViewName.V1a6_CachotCollectionBagView)
	ViewMgr.instance:closeView(ViewName.V1a6_CachotCollectionOverView)
end

function V1a6_CachotCollectionFightEntry:_btncollectionOnClick()
	if not FightModel.instance:isStartFinish() then
		return
	end

	local rogueInfo = V1a6_CachotModel.instance:getRogueInfo()

	if rogueInfo then
		V1a6_CachotController.instance:openV1a6_CachotCollectionBagView({
			isCanEnchant = false
		})
	end
end

return V1a6_CachotCollectionFightEntry
