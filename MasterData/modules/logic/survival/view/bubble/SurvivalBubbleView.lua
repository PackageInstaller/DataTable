-- chunkname: @modules/logic/survival/view/bubble/SurvivalBubbleView.lua

module("modules.logic.survival.view.bubble.SurvivalBubbleView", package.seeall)

local SurvivalBubbleView = class("SurvivalBubbleView", BaseView)

function SurvivalBubbleView:onInitView()
	self.root = gohelper.findChild(self.viewGO, "bubbleview")
	self.res = gohelper.findChild(self.root, "res")
	self.container = gohelper.findChild(self.root, "container")
	self.bubbleItem = gohelper.findChild(self.res, "bubbleItem")
	self.survivalBubbleComp = SurvivalMapHelper.instance:getSurvivalBubbleComp()
	self.bubbleDic = {}
end

function SurvivalBubbleView:addEvents()
	self.addEventCb(self, self.survivalBubbleComp, SurvivalEvent.OnShowBubble, self.onShowBubble, self)
	self.addEventCb(self, self.survivalBubbleComp, SurvivalEvent.OnRemoveBubble, self.onRemoveBubble, self)
end

function SurvivalBubbleView:onOpen()
	return
end

function SurvivalBubbleView:onClose()
	return
end

function SurvivalBubbleView:onShowBubble(param)
	local id = param.id
	local survivalBubble = param.survivalBubble
	local go = gohelper.clone(self.bubbleItem, self.container)
	local bubble = MonoHelper.addNoUpdateLuaComOnceToGo(go, SurvivalDialogueItem)

	bubble:setData(id, survivalBubble, self.container)

	self.bubbleDic[id] = bubble
end

function SurvivalBubbleView:onRemoveBubble(param)
	local id = param.id

	gohelper.destroy(self.bubbleDic[id].go)

	self.bubbleDic[id] = nil
end

function SurvivalBubbleView:onDestroyView()
	return
end

return SurvivalBubbleView
