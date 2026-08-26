-- chunkname: @modules/logic/survival/view/bubble/SurvivalDialogueItem.lua

module("modules.logic.survival.view.bubble.SurvivalDialogueItem", package.seeall)

local SurvivalDialogueItem = class("SurvivalDialogueItem", LuaCompBase)

function SurvivalDialogueItem:init(go)
	self.go = go
	self.textContent = gohelper.findChildTextMesh(go, "root/#textContent")
	self.uiFollower = go:GetComponent(gohelper.Type_UIFollower)
	self.mainCamera = CameraMgr.instance:getMainCamera()
	self.uiCamera = CameraMgr.instance:getUICamera()
end

function SurvivalDialogueItem:setData(id, survivalBubble, container)
	self.id = id
	self.survivalBubble = survivalBubble
	self.container = container
	self.survivalBubbleParam = survivalBubble.survivalBubbleParam
	self.tarTransform = survivalBubble.transform
	self.textContent.text = self.survivalBubbleParam.content

	self.uiFollower:Set(self.mainCamera, self.uiCamera, self.container.transform, self.tarTransform, 0, 1, 0, 0, 0)
	self.uiFollower:SetEnable(true)
end

return SurvivalDialogueItem
