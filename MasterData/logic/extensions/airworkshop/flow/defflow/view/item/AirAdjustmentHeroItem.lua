-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/item/AirAdjustmentHeroItem.lua

module("logic.extensions.airworkshop.flow.defflow.view.item.AirAdjustmentHeroItem", package.seeall)

local M = class("AirAdjustmentHeroItem", UIReusableLuaBehavior)
local kEnableColor = "#FFFFFFFF"
local kDisableColor = "#FFFFFF66"

function M:buildUI()
	self._imgIcon = goutil.findChildImageComponent(self.mainGO, "heroIcon")
	self._imgQuality = goutil.findChildImageComponent(self.mainGO, "imgQuality")
	self._imgQualityLine = goutil.findChildImageComponent(self.mainGO, "imgQuality/imgLine")
	self._imgCareerBg = goutil.findChildImageComponent(self.mainGO, "imgCareerDi_1")
	self._txtLv = goutil.findChildTextComponent(self.mainGO, "txtLv")
	self._career = UIBattleCareer.New(goutil.findChild(self.mainGO, "career"))
	self._animation = goutil.addComponentOnce(self.mainGO, ComponentType.Animation)
	self._goMask = goutil.findChild(self.mainGO, "imgMask")
	self._goSelect = goutil.findChild(self.mainGO, "imgSelect")

	local goClick = goutil.findChild(self.mainGO, "click")

	self._transform = self.mainGO.transform
	self._btnClick = Astral.ButtonAdapter.Get(goClick)
	self._btnDrag = Astral.UIDragTrigger.Get(goClick)
	self._passEvent = PassEvent.Get(goClick)

	self._btnClick:AddClickListener(self._onClickIcon, self)
	self._btnClick:SetClickInterval(0.2)
	self._btnDrag:AddBeginDragListener(self._onBeginDrag, self)
	self._btnDrag:AddDragListener(self._onDrag, self)
	self._btnDrag:AddEndDragListener(self._onEndDrag, self)

	self._isDraging = false
	self._handler = false
	self._heroId = false
	self._enable = false
end

function M:destroyUI()
	self._btnClick:RemoveClickListener()
	self._btnDrag:RemoveBeginDragListener()
	self._btnDrag:RemoveDragListener()
	self._btnDrag:RemoveEndDragListener()
	self._career:destroy()

	self._animation = nil
	self._transform = nil
	self._btnClick = nil
	self._btnDrag = nil
	self._imgIcon = nil
	self._imgQuality = nil
	self._imgCareerBg = nil
	self._goMask = nil
	self._txtLv = nil
	self._handler = false
	self._enable = false
end

function M:onEnter()
	self._isDraging = false

	self._animation:Stop()

	local transform = self.mainGO.transform

	RectTransformUtils.ResetRectTransform(transform)
end

function M:onExit()
	self._handler = false

	IconLoader.clearSprite(self._imgIcon)
	Astral.TransformUtil.SetLocalRotation(self._imgIcon.gameObject.transform, 0, 0, 0)
end

function M:setHeroMO(heroMO)
	self._heroId = heroMO:getId()
	self._txtLv.text = heroMO:getLevel()

	self._career:setCareerAndColorType(heroMO:getCareer(), heroMO:getColorType())

	local modelCO = ModelConfig.instance:getModelConfig(heroMO:getModelId())

	IconLoader.setSprite(self._imgIcon, IconType.RoleHeadIcon, modelCO.headIconName)

	local rotation = modelCO.headIconReverse == 1 and 180 or 0

	Astral.TransformUtil.SetLocalRotation(self._imgIcon.gameObject.transform, 0, rotation, 0)
	IconLoader.setSprite(self._imgCareerBg, IconType.DynSpriteAtlas_Battle, BattleIconName.getColorTypeBg(heroMO:getColorType()))
	IconLoader.setSprite(self._imgQuality, IconType.DynSpriteAtlas_Battle, BattleIconName.getQualityIcon(heroMO:getQuality()))
	IconLoader.setSprite(self._imgQualityLine, IconType.DynSpriteAtlas_Battle, BattleIconName.getQualityLineIcon(heroMO:getQuality()))
end

function M:setEnable(enable)
	self._enable = enable

	if enable then
		Astral.ColorUtil.SetImageColor(self._imgIcon, kEnableColor)
		Astral.ColorUtil.SetImageColor(self._imgQuality, kEnableColor)
		goutil.setActive(self._goMask, false)
	else
		Astral.ColorUtil.SetImageColor(self._imgIcon, kDisableColor)
		Astral.ColorUtil.SetImageColor(self._imgQuality, kDisableColor)
		goutil.setActive(self._goMask, true)
	end
end

function M:getHeroId()
	return self._heroId
end

function M:setPassToGameObject(passToGO)
	return
end

function M:setHandler(handler)
	self._handler = handler
end

function M:setSelected(selected, isSelectByClick)
	goutil.setActive(self._goSelect, selected)
	AnimationUtils.ResetToLastFrame(self._animation)
	self._animation:Stop()
end

function M:playSelectAnimation()
	self._animation:Play("battleheroitem_rising")
end

function M:playUnselectAnimation()
	self._animation:Play("battleheroitem_fall")
end

function M:playEnterAnimation()
	self._animation:Play("battleheroitem_open")
end

function M:_onClickIcon()
	printWarn("M _onClickIcon")

	if not self:_checkEnable() then
		return
	end

	if self._isDraging then
		return
	end

	self._handler:onClickHeadItem(self)
end

function M:_onEndDrag(eventData)
	local position = eventData.position

	self._handler:onEndDragHeadItem(self, position.x, position.y)

	self._isDraging = false
end

local kTan = math.tan(math.rad(15))

function M:_onBeginDrag(eventData)
	local isPassEvent = true
	local delta = eventData.delta

	if math.abs(delta.y) >= math.abs(delta.x) * kTan and self:_checkEnable() then
		local position = eventData.position

		self._handler:onBeginDragHeadItem(self, position.x, position.y)

		isPassEvent = false
	end

	self._passEvent.isPassEvent = isPassEvent
	self._isDraging = true
end

function M:_onDrag(eventData)
	local position = eventData.position

	self._handler:onDragHeadItem(self, position.x, position.y)
end

function M:_checkEnable()
	if self._enable then
		return true
	end

	self._handler:onTriggerDisable(self)
end

return M
