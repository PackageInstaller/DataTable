-- chunkname: @modules/logic/fight/view/FightFloatItem.lua

module("modules.logic.fight.view.FightFloatItem", package.seeall)

local FightFloatItem = class("FightFloatItem")
local Sp01LogoPathDict = {
	[FightEnum.FloatType.crit_restrain] = "x/sp01_logo",
	[FightEnum.FloatType.crit_heal] = "x/sp01_logo",
	[FightEnum.FloatType.crit_damage] = "x/sp01_logo",
	[FightEnum.FloatType.restrain] = "x/sp01_logo",
	[FightEnum.FloatType.heal] = "x/sp01_logo",
	[FightEnum.FloatType.damage] = "x/sp01_logo",
	[FightEnum.FloatType.crit_damage_origin] = "x/sp01_logo",
	[FightEnum.FloatType.damage_origin] = "x/sp01_logo",
	[FightEnum.FloatType.additional_damage] = "x/sp01_logo",
	[FightEnum.FloatType.crit_additional_damage] = "x/sp01_logo"
}

function FightFloatItem:ctor(floatType, typeGO, randomXRange, skinId)
	self.skinId = skinId
	self.entityId = nil
	self.type = floatType
	self._typeGO = typeGO
	self._typeRectTr = typeGO.transform
	self._halfRandomXRange = randomXRange / 2
	self._txtNum = gohelper.findChildText(typeGO, "x/txtNum")
	self._csGoActivator = self._typeGO:GetComponent(typeof(ZProj.GoActivator))
	self._effectTimeScale = gohelper.onceAddComponent(self._typeGO, typeof(ZProj.EffectTimeScale))

	gohelper.setActive(self._typeGO, false)

	if Sp01LogoPathDict[self.type] then
		self.goSp01Logo = gohelper.findChild(typeGO, Sp01LogoPathDict[self.type])

		gohelper.setActive(self.goSp01Logo, false)
	end

	self._floatFunc = FightFloatItem.FloatFunc[floatType]
	self._floatEndFunc = FightFloatItem.FloatEndFunc[floatType]
end

function FightFloatItem:getGO()
	return self._typeGO
end

function FightFloatItem:startFloat(entityId, content, param, isAssassinate)
	self.startTime = Time.time
	self.entityId = entityId

	gohelper.setActive(self._typeGO, true)

	if self._txtNum then
		local content = tostring(content)

		if self.type == FightEnum.FloatType.crit_heal or self.type == FightEnum.FloatType.heal then
			content = "+" .. content
		end

		self._txtNum.text = content
	end

	self:floatAssassinate(isAssassinate)

	if self._floatFunc then
		self:_floatFunc(content, param, isAssassinate)
	end

	if self.type == FightEnum.FloatType.equipeffect and self.can_not_play_equip_effect then
		self:_onFinish()

		return
	end

	if self._csGoActivator then
		self._csGoActivator:AddFinishCallback(self._onFinish, self)
		self._csGoActivator:Play()
	else
		logWarn("no activator in fight float assset, type = " .. self.type)
		self:_onFinish()
	end

	if self._effectTimeScale then
		self._effectTimeScale:SetTimeScale(FightModel.instance:getUISpeed())
	end
end

function FightFloatItem:floatAssassinate(isAssassinate)
	if isAssassinate and not gohelper.isNil(self.goSp01Logo) then
		gohelper.setActive(self.goSp01Logo, true)
	else
		gohelper.setActive(self.goSp01Logo, false)
	end
end

function FightFloatItem:setPos(x, y)
	self.startX = x
	self.startY = y

	recthelper.setAnchor(self._typeRectTr, x, y)
end

function FightFloatItem:tweenPosY(posY)
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)
	end

	if self.equip_single_img then
		self:setPos(0, 150)

		return
	end

	self._tweenId = ZProj.TweenHelper.DOAnchorPosY(self._typeRectTr, posY, 0.15 / FightModel.instance:getUISpeed())
end

function FightFloatItem:stopFloat()
	self:_onFinish()
end

function FightFloatItem:_onFinish()
	if self._csGoActivator then
		self._csGoActivator:RemoveFinishCallback()
	end

	if self._floatEndFunc then
		self:_floatEndFunc()
	end

	FightFloatMgr.instance:floatEnd(self)

	self.entityId = nil
end

function FightFloatItem:reset()
	gohelper.setActive(self._typeGO, false)
end

function FightFloatItem:onDestroy()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end

	if self._csGoActivator then
		self._csGoActivator:Stop()
		self._csGoActivator:RemoveFinishCallback()

		self._csGoActivator = nil
	end

	if self._effectTimeScale then
		self._effectTimeScale = nil
	end

	if self.equip_single_img then
		self.equip_single_img:UnLoadImage()
	end
end

function FightFloatItem:_floatBuff(content, param)
	local itemInner = gohelper.findChild(self._typeGO, "x/item1")

	gohelper.setActive(itemInner, true)

	local child_count = itemInner.transform.childCount

	if child_count < param then
		logError("buff飘字类型找不到，或者预设中没有对应类型的样式：", param)

		return
	end

	for i = 1, child_count do
		local is_target = param == i
		local type_item = itemInner.transform:Find("type_" .. i).gameObject

		gohelper.setActive(type_item, is_target)

		if is_target then
			gohelper.findChildText(type_item, "txtNum").text = content
		end
	end
end

function FightFloatItem:hideEquipFloat()
	if self.type == FightEnum.FloatType.equipeffect then
		gohelper.setActive(self._typeGO, false)
	end
end

function FightFloatItem:_floatEquipEffect(content, param)
	local tar_entity = FightHelper.getEntity(self.entityId)

	if tar_entity and tar_entity.marked_alpha == 0 then
		self:hideEquipFloat()

		self.can_not_play_equip_effect = true

		return
	end

	self.can_not_play_equip_effect = false

	local ani_root = self._typeGO.transform:Find("ani")

	self.equip_single_img = self.equip_single_img or gohelper.findChildSingleImage(self._typeGO, "ani/simage_equipicon")

	local materialPropsCtrl = ani_root:GetComponent(typeof(ZProj.MaterialPropsCtrl))

	materialPropsCtrl.mas:Clear()

	for i = 0, ani_root.childCount - 1 do
		local child_transform = ani_root:GetChild(i):GetComponent(gohelper.Type_Image)

		child_transform.material = UnityEngine.Object.Instantiate(child_transform.material)

		materialPropsCtrl.mas:Add(child_transform.material)
	end

	self.equip_single_img:LoadImage(ResUrl.getFightEquipFloatIcon("xinxiang" .. param.id))
end

function FightFloatItem:_floatTotal(content, param, isAssassinate)
	local from_entity = FightHelper.getEntity(param.fromId)
	local def_entity = FightHelper.getEntity(param.defenderId)
	local childRoot = gohelper.findChild(self._typeGO, "x")

	gohelper.setActive(childRoot, from_entity and def_entity)

	if from_entity and def_entity then
		local tar_index = param.isRestrain and 1 or 3

		for i = 1, 3 do
			local text = gohelper.findChildText(self._typeGO, "x/txtNum" .. i)
			local logo = gohelper.findChild(self._typeGO, "x/sp01_logo" .. i)

			gohelper.setActive(text.gameObject, i == tar_index)
			gohelper.setActive(logo, isAssassinate and i == tar_index)

			local title = gohelper.findChild(self._typeGO, "x/title" .. i)

			if title then
				gohelper.setActive(title, i == tar_index)
			end

			if i == tar_index then
				text.text = content

				if self.skinId == FightFloatMgr.SkinId.Duck_3_9 then
					self:updateDuckFloatPosition(title, text)
				end

				if isAssassinate then
					AudioMgr.instance:trigger(20305030)
				end
			end
		end
	end
end

FightFloatItem.Interval = -10
FightFloatItem.InitOffset = 15

function FightFloatItem:updateDuckFloatPosition(titleGo, text)
	local positionGo = gohelper.findChild(titleGo, "icon_position")

	if not positionGo then
		return
	end

	local textRectTr = text:GetComponent(gohelper.Type_RectTransform)
	local positionRectTr = positionGo:GetComponent(gohelper.Type_RectTransform)
	local pivot = textRectTr.pivot
	local txtWidth = text.preferredWidth
	local screenPos = recthelper.uiPosToScreenPos(textRectTr)
	local anchorX, anchorY = recthelper.screenPosToAnchorPos2(screenPos, titleGo.transform)

	anchorX = anchorX - txtWidth * pivot.x

	recthelper.setAnchor(positionRectTr, anchorX, anchorY)

	local len = text.text:len()

	recthelper.setWidth(positionRectTr, txtWidth + (len - 1) * FightFloatItem.Interval + FightFloatItem.InitOffset)
end

function FightFloatItem:_floatStress(content, param)
	local itemInner = gohelper.findChild(self._typeGO, "x/item1")

	gohelper.setActive(itemInner, true)

	local child_count = itemInner.transform.childCount

	if child_count < param then
		logError("压力飘字类型找不到，或者预设中没有对应类型的样式：", param)

		return
	end

	for i = 1, child_count do
		local is_target = param == i
		local type_item = itemInner.transform:Find("type_" .. i).gameObject

		gohelper.setActive(type_item, is_target)

		if is_target then
			gohelper.findChildText(type_item, "txtNum").text = content
		end
	end
end

function FightFloatItem:_floatBuffEnd()
	return
end

FightFloatItem.FloatFunc = {
	[FightEnum.FloatType.buff] = FightFloatItem._floatBuff,
	[FightEnum.FloatType.equipeffect] = FightFloatItem._floatEquipEffect,
	[FightEnum.FloatType.total] = FightFloatItem._floatTotal,
	[FightEnum.FloatType.total_origin] = FightFloatItem._floatTotal,
	[FightEnum.FloatType.stress] = FightFloatItem._floatStress
}
FightFloatItem.FloatEndFunc = {
	[FightEnum.FloatType.buff] = FightFloatItem._floatBuffEnd
}

return FightFloatItem
