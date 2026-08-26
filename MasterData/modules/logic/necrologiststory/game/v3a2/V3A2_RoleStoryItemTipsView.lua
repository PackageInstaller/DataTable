-- chunkname: @modules/logic/necrologiststory/game/v3a2/V3A2_RoleStoryItemTipsView.lua

module("modules.logic.necrologiststory.game.v3a2.V3A2_RoleStoryItemTipsView", package.seeall)

local V3A2_RoleStoryItemTipsView = class("V3A2_RoleStoryItemTipsView", BaseView)

function V3A2_RoleStoryItemTipsView:onInitView()
	self.txtTitle = gohelper.findChildTextMesh(self.viewGO, "Layout/right/#txt_title")
	self.simageIcon = gohelper.findChildSingleImage(self.viewGO, "Layout/right/picNode/#simage_pic")
	self.goLock = gohelper.findChild(self.viewGO, "Layout/right/picNode/lock")
	self.txtLockSource = gohelper.findChildTextMesh(self.viewGO, "Layout/right/picNode/lock/#txt_source")
	self.txtLock = gohelper.findChildTextMesh(self.viewGO, "Layout/right/picNode/lock/tipsbg2/txt_lock")
	self.goUnlock = gohelper.findChild(self.viewGO, "Layout/right/picNode/unlock")
	self.txtUnlockSource = gohelper.findChildTextMesh(self.viewGO, "Layout/right/picNode/unlock/#txt_source")
	self.txtDesc = gohelper.findChildTextMesh(self.viewGO, "Layout/right/picNode/unlock/#txt_dec")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3A2_RoleStoryItemTipsView:addEvents()
	return
end

function V3A2_RoleStoryItemTipsView:removeEvents()
	return
end

function V3A2_RoleStoryItemTipsView:_editableInitView()
	return
end

function V3A2_RoleStoryItemTipsView:onClickModalMask()
	self:closeThis()
end

function V3A2_RoleStoryItemTipsView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_shengyan_yishi_click)

	self.config = self.viewParam and self.viewParam.config

	self:refreshView()
end

function V3A2_RoleStoryItemTipsView:refreshView()
	if not self.config then
		return
	end

	self.txtTitle.text = self.config.name
	self.txtLockSource.text = self.config.sourceDesc
	self.txtUnlockSource.text = self.config.sourceDesc
	self.txtDesc.text = self.config.desc

	local gameBaseMO = NecrologistStoryModel.instance:getGameMO(NecrologistStoryEnum.RoleStoryId.V3A2)
	local isUnlock = gameBaseMO:isItemUnlock(self.config.id)
	local resPath = string.format("singlebg/dungeon/rolestory_singlebg/madierda/rolestory_madierda_pic%s_%s.png", self.config.image, isUnlock and 1 or 0)

	self.simageIcon:LoadImage(resPath)
	gohelper.setActive(self.goLock, not isUnlock)
	gohelper.setActive(self.goUnlock, isUnlock)
end

function V3A2_RoleStoryItemTipsView:onDestroyView()
	self.simageIcon:UnLoadImage()
end

return V3A2_RoleStoryItemTipsView
