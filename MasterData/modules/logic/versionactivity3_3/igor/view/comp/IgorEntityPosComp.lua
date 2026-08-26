-- chunkname: @modules/logic/versionactivity3_3/igor/view/comp/IgorEntityPosComp.lua

module("modules.logic.versionactivity3_3.igor.view.comp.IgorEntityPosComp", package.seeall)

local IgorEntityPosComp = class("IgorEntityPosComp", LuaCompBase)

function IgorEntityPosComp:init(go)
	self.go = go
	self.transform = self.go.transform
	self.parentTransform = self.transform.parent
	self.goRoot = gohelper.findChild(self.go, "root")
	self.goLine = gohelper.findChild(self.go, "root/vx_location/img_line")
	self.goHp = gohelper.findChild(self.go, "root/HP")

	gohelper.setActive(self.goHp, false)

	self.anim = self.goRoot:GetComponent(typeof(UnityEngine.Animator))
end

function IgorEntityPosComp:addEventListeners()
	self.addEventCb(self, IgorController.instance, IgorEvent.OnUpdateTempEntityPos, self.onUpdatePos, self)
end

function IgorEntityPosComp:removeEventListeners()
	self.removeEventCb(self, IgorController.instance, IgorEvent.OnUpdateTempEntityPos, self.onUpdatePos, self)
end

function IgorEntityPosComp:setCardArea(cardArea)
	self.cardArea = cardArea
end

function IgorEntityPosComp:onUpdatePos(rectTransform)
	if not rectTransform or self:isInCardArea(rectTransform) then
		self:setPos()

		return
	end

	local gameMO = IgorModel.instance:getCurGameMo()
	local oursideMo = gameMO:getOursideMo()
	local skillData = oursideMo:getSkillMO(IgorEnum.SkillType.Transfer)

	if skillData:isHasRemainTimes() then
		self:setPos()

		return
	end

	local position = recthelper.uiPosToScreenPos(rectTransform)

	self:setPos(position)
end

function IgorEntityPosComp:setPos(position)
	if not position then
		gohelper.setActive(self.goRoot, false)

		return
	end

	local putX, putY = IgorHelper.getPutEntityPosByScreenPos(position)
	local gameMO = IgorModel.instance:getCurGameMo()
	local ret, limitX, limitY = gameMO:isInLimitRect(putX, putY)

	if not ret then
		putX = limitX
		putY = limitY
	end

	gohelper.setActive(self.goRoot, true)
	gohelper.setActive(self.goLine, ret)
	self.anim:Play("locate")
	gameMO:setPutTempPos(putX, putY)

	local anchorPosX, anchorPosY = recthelper.screenPosToAnchorPos2(Vector2(putX, putY), self.parentTransform)

	transformhelper.setLocalPosXY(self.transform, anchorPosX, anchorPosY)
end

function IgorEntityPosComp:isInCardArea(transform)
	return ZProj.UGUIHelper.Overlaps(transform, self.cardArea, CameraMgr.instance:getUICamera())
end

function IgorEntityPosComp:onDestroy()
	return
end

return IgorEntityPosComp
