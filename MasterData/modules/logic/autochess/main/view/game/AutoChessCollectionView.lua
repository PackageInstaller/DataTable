-- chunkname: @modules/logic/autochess/main/view/game/AutoChessCollectionView.lua

module("modules.logic.autochess.main.view.game.AutoChessCollectionView", package.seeall)

local AutoChessCollectionView = class("AutoChessCollectionView", BaseView)

function AutoChessCollectionView:onInitView()
	self._scrollCollection = gohelper.findChildScrollRect(self.viewGO, "#scroll_Collection")
	self._goContent = gohelper.findChild(self.viewGO, "#scroll_Collection/Viewport/#go_Content")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function AutoChessCollectionView:addEvents()
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
end

function AutoChessCollectionView:removeEvents()
	self._btnClose:RemoveClickListener()
end

function AutoChessCollectionView:onClickModalMask()
	self:closeThis()
end

function AutoChessCollectionView:_btnCloseOnClick()
	self:closeThis()
end

function AutoChessCollectionView:onOpen()
	if self.viewParam then
		self.collectionIds = self.viewParam

		for _, id in ipairs(self.collectionIds) do
			local go = self:getResInst(AutoChessStrEnum.ResPath.CollectionItem, self._goContent)
			local item = MonoHelper.addNoUpdateLuaComOnceToGo(go, AutoChessCollectionItem)

			item:setData(id)
			item:setScrollParentGo(self._scrollCollection.gameObject)
		end
	end
end

return AutoChessCollectionView
