-- chunkname: @modules/logic/necrologiststory/game/v3a4/V3A4_RoleStoryPointItem.lua

module("modules.logic.necrologiststory.game.v3a4.V3A4_RoleStoryPointItem", package.seeall)

local V3A4_RoleStoryPointItem = class("V3A4_RoleStoryPointItem", LuaCompBase)

function V3A4_RoleStoryPointItem:init(go)
	self.go = go
	self.transform = go.transform

	recthelper.setAnchor(self.transform, 0, 0)

	self.txtName = gohelper.findChildTextMesh(self.go, "name")
	self.simageItem = gohelper.findChildSingleImage(self.go, "Image")
	self.goImage = gohelper.findChild(self.go, "Image")
	self.pointList = {}

	for i = 1, 6 do
		local point = gohelper.findChild(self.go, string.format("points/%s", i))

		table.insert(self.pointList, point)
	end

	self.btnClick = gohelper.findButtonWithAudio(self.go)
	self.anim = self.go:GetComponent(typeof(UnityEngine.Animator))
end

function V3A4_RoleStoryPointItem:addEventListeners()
	self.addClickCb(self, self.btnClick, self.onClickBtn, self)
end

function V3A4_RoleStoryPointItem:removeEventListeners()
	self:removeClickCb(self.btnClick)
end

function V3A4_RoleStoryPointItem:onClickBtn()
	self.anim:Play("click", 0, 0)
	NecrologistStoryController.instance:dispatchEvent(NecrologistStoryEvent.V3A4_PutItem, self)
end

function V3A4_RoleStoryPointItem:setData(config)
	self.config = config

	self:refreshView()
end

function V3A4_RoleStoryPointItem:refreshView()
	gohelper.setActive(self.go, true)

	self.txtName.text = self.config.name

	self.simageItem:LoadImage(self.config.resource)

	for i, v in ipairs(self.pointList) do
		gohelper.setActive(v, i <= self.config.point)
	end
end

function V3A4_RoleStoryPointItem:onDestroy()
	self.simageItem:UnLoadImage()
end

return V3A4_RoleStoryPointItem
