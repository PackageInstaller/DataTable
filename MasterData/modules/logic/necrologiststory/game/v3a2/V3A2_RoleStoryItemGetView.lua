-- chunkname: @modules/logic/necrologiststory/game/v3a2/V3A2_RoleStoryItemGetView.lua

module("modules.logic.necrologiststory.game.v3a2.V3A2_RoleStoryItemGetView", package.seeall)

local V3A2_RoleStoryItemGetView = class("V3A2_RoleStoryItemGetView", BaseView)

function V3A2_RoleStoryItemGetView:onInitView()
	self.txtName = gohelper.findChildTextMesh(self.viewGO, "Layout/name/#txt_name")
	self.simageIcon = gohelper.findChildSingleImage(self.viewGO, "Layout/#simage_pic")
	self.txtDesc = gohelper.findChildTextMesh(self.viewGO, "Layout/#txt_dec")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3A2_RoleStoryItemGetView:addEvents()
	return
end

function V3A2_RoleStoryItemGetView:removeEvents()
	return
end

function V3A2_RoleStoryItemGetView:_editableInitView()
	return
end

function V3A2_RoleStoryItemGetView:onClickModalMask()
	if not self.animFinish then
		return
	end

	self:closeThis()
end

function V3A2_RoleStoryItemGetView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_shengyan_yishi_result)

	if self.viewParam then
		self.config = NecrologistStoryV3A2Config.instance:getItemConfig(self.viewParam)

		self:refreshView()

		self.animFinish = false

		TaskDispatcher.runDelay(self._onAnimFinish, self, 1)
	end
end

function V3A2_RoleStoryItemGetView:refreshView()
	if not self.config then
		return
	end

	self.txtName.text = self.config.name
	self.txtDesc.text = self.config.desc

	local resPath = string.format("singlebg/dungeon/rolestory_singlebg/madierda/rolestory_madierda_pic%s_1.png", self.config.image)

	self.simageIcon:LoadImage(resPath)
end

function V3A2_RoleStoryItemGetView:_onAnimFinish()
	self.animFinish = true
end

function V3A2_RoleStoryItemGetView:onDestroyView()
	TaskDispatcher.cancelTask(self._onAnimFinish, self)
	self.simageIcon:UnLoadImage()
end

return V3A2_RoleStoryItemGetView
