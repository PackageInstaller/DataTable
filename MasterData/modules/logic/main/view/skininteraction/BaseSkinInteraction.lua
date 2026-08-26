-- chunkname: @modules/logic/main/view/skininteraction/BaseSkinInteraction.lua

module("modules.logic.main.view.skininteraction.BaseSkinInteraction", package.seeall)

local BaseSkinInteraction = class("BaseSkinInteraction")

function BaseSkinInteraction:init(view, skinId)
	self._view = view
	self._skinId = skinId
	self._behaviorList = {}

	self:_onInit()
end

function BaseSkinInteraction:getSkinId()
	return self._skinId
end

function BaseSkinInteraction:onBodyChange(prevBodyName, curBodyName)
	self:_callBehavior("_onBodyChange", prevBodyName, curBodyName)
	self:_onBodyChange(prevBodyName, curBodyName)
end

function BaseSkinInteraction:_onBodyChange(prevBodyName, curBodyName)
	return
end

function BaseSkinInteraction:isCustomDrag()
	return false
end

function BaseSkinInteraction:needRespond()
	return false
end

function BaseSkinInteraction:canPlay(config)
	return true
end

function BaseSkinInteraction:selectFromGroup(config)
	return config
end

function BaseSkinInteraction:isPlayingVoice()
	return false
end

function BaseSkinInteraction:beginDrag()
	return
end

function BaseSkinInteraction:endDrag()
	return
end

function BaseSkinInteraction:onCloseFullView()
	return
end

function BaseSkinInteraction:_checkPosInBound(pos)
	return self._view:_checkPosInBound(pos)
end

function BaseSkinInteraction:_clickDefault(pos)
	self._view:_clickDefault(pos)
end

function BaseSkinInteraction:_onInit()
	return
end

function BaseSkinInteraction:_callBehavior(funcName, funcParam1, funcParam2)
	for _, behavior in ipairs(self._behaviorList) do
		behavior[funcName](behavior, funcParam1, funcParam2)
	end
end

function BaseSkinInteraction:_addBehavior(behavior)
	table.insert(self._behaviorList, behavior)
	behavior:init(self._view, self._skinId)
end

function BaseSkinInteraction:onClick(pos)
	self:_onClick(pos)
end

function BaseSkinInteraction:beforePlayVoice(config)
	self:_beforePlayVoice(config)
end

function BaseSkinInteraction:_beforePlayVoice(config)
	return
end

function BaseSkinInteraction:afterPlayVoice(config)
	self:_afterPlayVoice(config)
end

function BaseSkinInteraction:_afterPlayVoice(config)
	return
end

function BaseSkinInteraction:playVoiceFinish(config)
	self:_onPlayVoiceFinish(config)
end

function BaseSkinInteraction:_onPlayVoiceFinish(config)
	return
end

function BaseSkinInteraction:playVoice(config)
	self._view:playVoice(config)
end

function BaseSkinInteraction:onPlayVoice(config)
	self._voiceConfig = config

	self:_onPlayVoice()
end

function BaseSkinInteraction:_onPlayVoice()
	return
end

function BaseSkinInteraction:onStopVoice()
	self:_onStopVoice()
end

function BaseSkinInteraction:_onStopVoice()
	return
end

function BaseSkinInteraction:_onClick(pos)
	return
end

function BaseSkinInteraction:onDestroy()
	self:_callBehavior("_onDestroy")
	self:_onDestroy()
end

function BaseSkinInteraction:_onDestroy()
	return
end

return BaseSkinInteraction
