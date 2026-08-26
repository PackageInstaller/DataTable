-- chunkname: @modules/logic/dungeon/view/DungeonMapOtherBtnView.lua

module("modules.logic.dungeon.view.DungeonMapOtherBtnView", package.seeall)

local DungeonMapOtherBtnView = class("DungeonMapOtherBtnView", BaseView)

function DungeonMapOtherBtnView:onInitView()
	self._gotopright = gohelper.findChild(self.viewGO, "#go_topright")
	self._btnequipstore = gohelper.findChildButtonWithAudio(self.viewGO, "#go_topright/#btn_equipstore")
	self._txtequipstore = gohelper.findChildText(self.viewGO, "#go_topright/#btn_equipstore/#txt_equipstore")
	self._txtequipstoreen = gohelper.findChildText(self.viewGO, "#go_topright/#btn_equipstore/#txt_equipstoreen")
	self._gorolestory = gohelper.findChild(self.viewGO, "#go_rolestory")
	self._btnrolestory = gohelper.findChildButtonWithAudio(self.viewGO, "#go_rolestory/#btn_review")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DungeonMapOtherBtnView:addEvents()
	self._btnequipstore:AddClickListener(self._btnEquipStoreOnClick, self)
	self._btnrolestory:AddClickListener(self._btnRoleStoryOnClick, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseView, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnOpenView, self._onOpenView, self)
end

function DungeonMapOtherBtnView:removeEvents()
	self._btnequipstore:RemoveClickListener()
	self._btnrolestory:RemoveClickListener()
end

function DungeonMapOtherBtnView:_btnRoleStoryOnClick()
	RoleStoryController.instance:openReviewView()
end

function DungeonMapOtherBtnView:_btnEquipStoreOnClick()
	StoreController.instance:openStoreView(StoreEnum.StoreId.SummonEquipExchange)
end

function DungeonMapOtherBtnView:_editableInitView()
	return
end

function DungeonMapOtherBtnView:_onOpenView(viewName)
	if viewName == ViewName.DungeonMapLevelView then
		self:refreshUI()
	end
end

function DungeonMapOtherBtnView:_onCloseView(viewName)
	if viewName == ViewName.DungeonMapLevelView then
		self:refreshUI()
	end
end

function DungeonMapOtherBtnView:onUpdateParam()
	self:refreshUI()
end

function DungeonMapOtherBtnView:onOpen()
	self._txtequipstore.text = luaLang("equip_store_name")
	self._txtequipstoreen.text = "PSYCHUBE SHOP"

	self:refreshUI()
end

function DungeonMapOtherBtnView:refreshUI()
	local chapterType = DungeonModel.instance.curChapterType

	self.isEquipDungeon = chapterType == DungeonEnum.ChapterType.Equip

	gohelper.setActive(self._gotopright, self.isEquipDungeon and not ViewMgr.instance:isOpen(ViewName.DungeonMapLevelView))
	gohelper.setActive(self._gorolestory, not ViewMgr.instance:isOpen(ViewName.DungeonMapLevelView) and DungeonModel.instance:chapterListIsRoleStory() and RoleStoryModel.instance:isShowReplayStoryBtn())
end

function DungeonMapOtherBtnView:onClose()
	return
end

function DungeonMapOtherBtnView:onDestroyView()
	return
end

return DungeonMapOtherBtnView
