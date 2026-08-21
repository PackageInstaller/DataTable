-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/battle/viewcampadjustment/BattleCampAdjustmentHeroItem.lua

module("logic.extensions.battle.viewcampadjustment.BattleCampAdjustmentHeroItem", package.seeall)

local BattleCampAdjustmentHeroItem = class("BattleCampAdjustmentHeroItem", UIReusableLuaBehavior)
local kEnableColor = "#FFFFFFFF"
local kDisableColor = "#FFFFFF66"

function BattleCampAdjustmentHeroItem:buildUI()
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

	self._laberPos = goutil.findChild(self.mainGO, "labelPos")
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

function BattleCampAdjustmentHeroItem:destroyUI()
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

function BattleCampAdjustmentHeroItem:onEnter()
	self._isDraging = false

	self._animation:Stop()

	local transform = self.mainGO.transform

	RectTransformUtils.ResetRectTransform(transform)
	getres(ResName.Com_Label, function(res)
		if res.IsSuccess then
			res:Retain()

			local template = goutil.clone(res:GetMainAsset())

			goutil.addChildToParent(template, self._laberPos)

			local commLabel = Astral.SimpleLuaComponentContainer.Add(template, CommLabel)

			commLabel:setData(CommLabel.SignType.SignTrial)
		end
	end, nil)
	goutil.setActive(self._laberPos, false)
end

function BattleCampAdjustmentHeroItem:onExit()
	self._handler = false

	IconLoader.clearSprite(self._imgIcon)
	Astral.TransformUtil.SetLocalRotation(self._imgIcon.gameObject.transform, 0, 0, 0)
end

function BattleCampAdjustmentHeroItem:setHeroMO(heroMO)
	self._heroId = heroMO:getId()
	self._txtLv.text = "Lv." .. heroMO:getLevel()

	self._career:setCareerAndColorType(heroMO:getCareer(), heroMO:getColorType())

	local modelCO = ModelConfig.instance:getModelConfig(heroMO:getModelId())

	IconLoader.setSprite(self._imgIcon, IconType.RoleHeadIcon, modelCO.headIconName)

	local rotation = modelCO.headIconReverse == 1 and 180 or 0

	Astral.TransformUtil.SetLocalRotation(self._imgIcon.gameObject.transform, 0, rotation, 0)
	IconLoader.setSprite(self._imgCareerBg, IconType.DynSpriteAtlas_Battle, BattleIconName.getColorTypeBg(heroMO:getColorType()))
	IconLoader.setSprite(self._imgQuality, IconType.DynSpriteAtlas_Battle, BattleIconName.getQualityIcon(heroMO:getQuality()))
	IconLoader.setSprite(self._imgQualityLine, IconType.DynSpriteAtlas_Battle, BattleIconName.getQualityLineIcon(heroMO:getQuality()))
	goutil.setActive(self._laberPos, heroMO.isTrial)
end

function BattleCampAdjustmentHeroItem:setEnable(enable)
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

function BattleCampAdjustmentHeroItem:getHeroId()
	return self._heroId
end

function BattleCampAdjustmentHeroItem:setPassToGameObject(passToGO)
	return
end

function BattleCampAdjustmentHeroItem:setHandler(handler)
	self._handler = handler
end

function BattleCampAdjustmentHeroItem:setSelected(selected, isSelectByClick)
	goutil.setActive(self._goSelect, selected)
	AnimationUtils.ResetToLastFrame(self._animation)
	self._animation:Stop()

	if not isSelectByClick then
		Astral.TransformUtil.SetLocalPosY(self._transform, selected and 21.3 or 0)
	end
end

function BattleCampAdjustmentHeroItem:playSelectAnimation()
	self._animation:Play("battleheroitem_rising")
end

function BattleCampAdjustmentHeroItem:playUnselectAnimation()
	self._animation:Play("battleheroitem_fall")
end

function BattleCampAdjustmentHeroItem:playEnterAnimation()
	self._animation:Play("battleheroitem_open")
end

function BattleCampAdjustmentHeroItem:_onClickIcon()
	if not self:_checkEnable() then
		return
	end

	if self._isDraging then
		return
	end

	self._handler:onClickHeadItem(self)
end

function BattleCampAdjustmentHeroItem:_onEndDrag(eventData)
	local position = eventData.position

	self._handler:onEndDragHeadItem(self, position.x, position.y)

	self._isDraging = false
end

local kTan = math.tan(math.rad(30))

function BattleCampAdjustmentHeroItem:_onBeginDrag(eventData)
	local isPassEvent = true
	local delta = eventData.delta

	if self:_checkEnable() and delta.y >= math.abs(delta.x) * kTan then
		local position = eventData.position

		self._handler:onBeginDragHeadItem(self, position.x, position.y)

		isPassEvent = false
	end

	self._passEvent.isPassEvent = isPassEvent
	self._isDraging = true
end

function BattleCampAdjustmentHeroItem:_onDrag(eventData)
	local position = eventData.position

	self._handler:onDragHeadItem(self, position.x, position.y)
end

function BattleCampAdjustmentHeroItem:_checkEnable()
	if self._enable then
		return true
	end

	self._handler:onTriggerDisable(self)
end

return BattleCampAdjustmentHeroItem
