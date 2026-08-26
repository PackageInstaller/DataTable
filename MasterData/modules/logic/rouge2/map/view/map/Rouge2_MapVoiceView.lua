-- chunkname: @modules/logic/rouge2/map/view/map/Rouge2_MapVoiceView.lua

module("modules.logic.rouge2.map.view.map.Rouge2_MapVoiceView", package.seeall)

local Rouge2_MapVoiceView = class("Rouge2_MapVoiceView", BaseView)

function Rouge2_MapVoiceView:onInitView()
	self._gochesstalk = gohelper.findChild(self.viewGO, "#go_chesstalk")
	self._txtchesstalk = gohelper.findChildText(self.viewGO, "#go_chesstalk/Scroll View/Viewport/Content/#txt_talk")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_MapVoiceView:addEvents()
	return
end

function Rouge2_MapVoiceView:removeEvents()
	return
end

function Rouge2_MapVoiceView:_editableInitView()
	self:hideVoice()

	self.rectTr = self._gochesstalk:GetComponent(gohelper.Type_RectTransform)
	self.viewRectTr = self.viewGO:GetComponent(gohelper.Type_RectTransform)

	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onTriggerShortVoice, self.onTriggerShortVoice, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onEndTriggerShortVoice, self.onEndTriggerShortVoice, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onActorPosChange, self.onActorPosChange, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onMapPosChange, self.onMapPosChange, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onCameraSizeChange, self.onMapPosChange, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onChangeMapInfo, self.onChangeMapInfo, self, LuaEventSystem.High)
end

function Rouge2_MapVoiceView:onChangeMapInfo()
	self:hideVoice()
end

function Rouge2_MapVoiceView:onActorPosChange(pos)
	if not self.showIng then
		return
	end

	self:updatePos(pos)
end

function Rouge2_MapVoiceView:onMapPosChange()
	if Rouge2_MapModel.instance:isPathSelect() then
		return
	end

	if not self.showIng then
		return
	end

	local actorComp = Rouge2_MapController.instance:getActorMap()

	if actorComp then
		self:updatePos(actorComp:getActorWordPos())
	end
end

function Rouge2_MapVoiceView:onTriggerShortVoice(voiceCo)
	local desc = voiceCo.desc

	AudioMgr.instance:trigger(voiceCo.audioId)

	if string.nilorempty(desc) then
		return
	end

	if Rouge2_MapModel.instance:isPathSelect() then
		return
	end

	self:showVoice()

	self._txtchesstalk.text = desc

	local actorComp = Rouge2_MapController.instance:getActorMap()

	if actorComp then
		self:updatePos(actorComp:getActorWordPos())
	end
end

function Rouge2_MapVoiceView:onEndTriggerShortVoice()
	self:hideVoice()
end

function Rouge2_MapVoiceView:hideVoice()
	gohelper.setActive(self._gochesstalk, false)

	self.showIng = false
end

function Rouge2_MapVoiceView:showVoice()
	gohelper.setActive(self._gochesstalk, true)

	self.showIng = true
end

function Rouge2_MapVoiceView:updatePos(worldPos)
	local anchorX, anchorY = recthelper.worldPosToAnchorPos2(worldPos, self.viewRectTr)
	local anchor = Rouge2_MapModel.instance:isNormalLayer() and Rouge2_MapEnum.TalkAnchorOffset[Rouge2_MapEnum.MapType.Normal] or Rouge2_MapEnum.TalkAnchorOffset[Rouge2_MapEnum.MapType.Middle]
	local offsetX, offsetY = anchor.x, anchor.y

	recthelper.setAnchor(self.rectTr, anchorX + offsetX, anchorY + offsetY)
end

return Rouge2_MapVoiceView
