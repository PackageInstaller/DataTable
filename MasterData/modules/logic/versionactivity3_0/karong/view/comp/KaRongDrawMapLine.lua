-- chunkname: @modules/logic/versionactivity3_0/karong/view/comp/KaRongDrawMapLine.lua

module("modules.logic.versionactivity3_0.karong.view.comp.KaRongDrawMapLine", package.seeall)

local KaRongDrawMapLine = class("KaRongDrawMapLine", KaRongDrawBaseLine)

KaRongDrawMapLine.SwitchOffIconUrl = "duandian_1"

function KaRongDrawMapLine:ctor(go, fillOrigin_left, fillOrigin_right)
	KaRongDrawMapLine.super.ctor(self, go)

	self._fillOrigin_left = fillOrigin_left
	self._fillOrigin_right = fillOrigin_right
	self._gomap = gohelper.findChild(self.go, "#go_map")
	self._gopath = gohelper.findChild(self.go, "#go_path")
	self._goswitch = gohelper.findChild(self.go, "#go_map/#go_switch")
	self._imageindex = gohelper.findChildImage(self.go, "#go_map/#go_switch/#image_index")
	self._imagecontent = gohelper.findChildImage(self.go, "#go_map/#go_switch/#image_content")
	self._switchAnim = gohelper.findChildComponent(self.go, "#go_map/#go_switch", gohelper.Type_Animator)

	gohelper.setActive(self._gomap, true)
	gohelper.setActive(self._gopath, false)
end

function KaRongDrawMapLine:onInit(x1, y1, x2, y2)
	KaRongDrawMapLine.super.onInit(self, x1, y1, x2, y2)
	self.addEventCb(self, KaRongDrawController.instance, KaRongDrawEvent.SwitchLineState, self.onSwitchLine, self)

	local anchorX, anchorY = KaRongDrawModel.instance:getLineAnchor(x1, y1, x2, y2)

	recthelper.setAnchor(self.go.transform, anchorX, anchorY)
	self:_setIcon()
end

function KaRongDrawMapLine:_setIcon()
	local lineState = KaRongDrawModel.instance:getMapLineState(self.x1, self.y1, self.x2, self.y2)
	local isSwitchOff = lineState == KaRongDrawEnum.LineState.Switch_Off
	local isSwitchOn = lineState == KaRongDrawEnum.LineState.Switch_On

	if isSwitchOff then
		local ctrlMo = KaRongDrawModel.instance:getInteractLineCtrl(self.x1, self.y1, self.x2, self.y2)
		local group = ctrlMo and ctrlMo.group
		local iconUrl = group and KaRongDrawEnum.InteractIndexIcon[group]

		if iconUrl then
			UISpriteSetMgr.instance:setV3a0KaRongSprite(self._imageindex, iconUrl)
		end

		UISpriteSetMgr.instance:setV3a0KaRongSprite(self._imagecontent, KaRongDrawMapLine.SwitchOffIconUrl)
	end

	if isSwitchOff or isSwitchOn then
		gohelper.setActive(self._goswitch, true)

		local switchAnim = isSwitchOff and "none" or "disappear"

		self._switchAnim:Play(switchAnim, 0, 0)
	else
		gohelper.setActive(self._goswitch, false)
	end
end

function KaRongDrawMapLine:onSwitchLine(startPosX, startPosY, endPosX, endPosY)
	if startPosX ~= self.x1 or startPosY ~= self.y1 or self.x2 ~= endPosX or self.y2 ~= endPosY then
		return
	end

	self:_setIcon()
end

return KaRongDrawMapLine
