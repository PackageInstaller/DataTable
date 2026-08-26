-- chunkname: @modules/logic/versionactivity1_5/act142/view/game/Activity142GetCollectionView.lua

module("modules.logic.versionactivity1_5.act142.view.game.Activity142GetCollectionView", package.seeall)

local Activity142GetCollectionView = class("Activity142GetCollectionView", BaseView)

function Activity142GetCollectionView:onInitView()
	self._simageicon = gohelper.findChildImage(self.viewGO, "content/#go_collection/#simage_icon")
	self._txtcollectiontitle = gohelper.findChildText(self.viewGO, "content/#go_collection/#txt_collectiontitle")
	self._txtcollectiondesc = gohelper.findChildText(self.viewGO, "content/#go_collection/#txt_collectiontitle/#txt_collectiondesc")
	self._btnclose = gohelper.getClick(self.viewGO)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity142GetCollectionView:addEvents()
	self._btnclose:AddClickListener(self.closeThis, self)
end

function Activity142GetCollectionView:_editableInitView()
	return
end

function Activity142GetCollectionView:removeEvents()
	self._btnclose:RemoveClickListener()
end

function Activity142GetCollectionView:onOpen()
	if self.viewParam then
		local collectionId = self.viewParam.collectionId

		if not collectionId then
			logError("Activity142GetCollectionView error, collectionId is nil")

			return
		end

		local actId = Activity142Model.instance:getActivityId()
		local collectionCfg = Activity142Config.instance:getCollectionCfg(actId, collectionId, true)

		if not collectionCfg then
			return
		end

		self._txtcollectiontitle.text = collectionCfg.name
		self._txtcollectiondesc.text = collectionCfg.desc

		if collectionCfg.icon then
			UISpriteSetMgr.instance:setV1a5ChessSprite(self._simageicon, collectionCfg.icon)
		end

		Activity142Model.instance:setHasCollection(collectionId)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_lvhu_notebook_get)
	end
end

function Activity142GetCollectionView:onClose()
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.RewardIsClose)
end

function Activity142GetCollectionView:onDestroyView()
	return
end

return Activity142GetCollectionView
