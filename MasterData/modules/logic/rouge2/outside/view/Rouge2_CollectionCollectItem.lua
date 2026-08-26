-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_CollectionCollectItem.lua

module("modules.logic.rouge2.outside.view.Rouge2_CollectionCollectItem", package.seeall)

local Rouge2_CollectionCollectItem = class("Rouge2_CollectionCollectItem", LuaCompBase)

function Rouge2_CollectionCollectItem:init(go)
	self.go = go
	self._simageicon = gohelper.findChildSingleImage(self.go, "#simage_icon")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_CollectionCollectItem:_editableInitView()
	self.animator = gohelper.findChildComponent(self.go, "", gohelper.Type_Animator)
end

function Rouge2_CollectionCollectItem:setInfo(config)
	self.config = config

	Rouge2_IconHelper.setRelicsIcon(config.id, self._simageicon)
end

function Rouge2_CollectionCollectItem:showNewFlag()
	return
end

function Rouge2_CollectionCollectItem:onDestroy()
	self._simageicon:UnLoadImage()
end

return Rouge2_CollectionCollectItem
