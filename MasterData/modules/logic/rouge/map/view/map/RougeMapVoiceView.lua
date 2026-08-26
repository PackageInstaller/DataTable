-- chunkname: @modules/logic/rouge/map/view/map/RougeMapVoiceView.lua

module("modules.logic.rouge.map.view.map.RougeMapVoiceView", package.seeall)

local RougeMapVoiceView = class("RougeMapVoiceView", BaseView)

function RougeMapVoiceView:onInitView()
	self._gochesstalk = gohelper.findChild(self.viewGO, "#go_chesstalk")
	self._txtchesstalk = gohelper.findChildText(self.viewGO, "#go_chesstalk/Scroll View/Viewport/Content/#txt_talk")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RougeMapVoiceView:addEvents()
	return
end

function RougeMapVoiceView:removeEvents()
	return
end

function RougeMapVoiceView:_editableInitView()
	self:hideVoice()

	self.rectTr = self._gochesstalk:GetComponent(gohelper.Type_RectTransform)
	self.viewRectTr = self.viewGO:GetComponent(gohelper.Type_RectTransform)

	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onTriggerShortVoice, self.onTriggerShortVoice, self)
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onEndTriggerShortVoice, self.onEndTriggerShortVoice, self)
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onActorPosChange, self.onActorPosChange, self)
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onMapPosChange, self.onMapPosChange, self)
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onCameraSizeChange, self.onMapPosChange, self)
	self.addEventCb(self, RougeMapController.instance, RougeMapEvent.onChangeMapInfo, self.onChangeMapInfo, self, LuaEventSystem.High)
end

function RougeMapVoiceView:onChangeMapInfo()
	self:hideVoice()
end

function RougeMapVoiceView:onActorPosChange(pos)
	if not self.showIng then
		return
	end

	self:updatePos(pos)
end

function RougeMapVoiceView:onMapPosChange()
	if RougeMapModel.instance:isPathSelect() then
		return
	end

	if not self.showIng then
		return
	end

	local actorComp = RougeMapController.instance:getActorMap()

	if actorComp then
		self:updatePos(actorComp:getActorWordPos())
	end
end

function RougeMapVoiceView:onTriggerShortVoice(voiceCo)
	local desc = voiceCo.desc

	AudioMgr.instance:trigger(voiceCo.audioId)

	if string.nilorempty(desc) then
		return
	end

	if RougeMapModel.instance:isPathSelect() then
		return
	end

	self:showVoice()

	self._txtchesstalk.text = desc

	local actorComp = RougeMapController.instance:getActorMap()

	if actorComp then
		self:updatePos(actorComp:getActorWordPos())
	end
end

function RougeMapVoiceView:onEndTriggerShortVoice()
	self:hideVoice()
end

function RougeMapVoiceView:hideVoice()
	gohelper.setActive(self._gochesstalk, false)

	self.showIng = false
end

function RougeMapVoiceView:showVoice()
	gohelper.setActive(self._gochesstalk, true)

	self.showIng = true
end

function RougeMapVoiceView:updatePos(worldPos)
	local anchorX, anchorY = recthelper.worldPosToAnchorPos2(worldPos, self.viewRectTr)
	local anchor = RougeMapModel.instance:isNormalLayer() and RougeMapEnum.TalkAnchorOffset[RougeMapEnum.MapType.Normal] or RougeMapEnum.TalkAnchorOffset[RougeMapEnum.MapType.Middle]
	local offsetX, offsetY = anchor.x, anchor.y

	recthelper.setAnchor(self.rectTr, anchorX + offsetX, anchorY + offsetY)
end

return RougeMapVoiceView
