-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fishinggame/model/FishingGameFishCon.lua

module("logic.extensions.fishinggame.model.FishingGameFishCon", package.seeall)

local FishingGameFishCon = class("FishingGameFishCon", FishingGameUnitCon)

function FishingGameFishCon:ctor(container, gameView)
	FishingGameFishCon.super.ctor(self, container)

	self._gameView = gameView
	self._spineCtrl = FishingGameSpineCtrl.New()
end

function FishingGameFishCon:buildUI()
	self._img = goutil.findChild(self.container, "img")
	self._spine = goutil.findChild(self.container, "spine")
end

function FishingGameFishCon:_onSetUI()
	if not self.container or not self._unit then
		return
	end

	if self._img then
		GameUtil.SetActive(self._img, false)
	end

	if not string.nilorempty(self._unit.resPath) and self._img then
		local resPath = string.format("ui/bigbg/views/fishinggame/%s.png", self._unit.resPath)

		uGuiUtil.setSpriteToImage(self._img, uGuiUtil.SpriteType.BigBg, resPath)

		local image = self.container:GetComponent(goutil.Type_UIImage)

		if image then
			image:SetNativeSize()
		end

		GameUtil.setWidth(self._img, self._unit.width)
		GameUtil.setHeight(self._img, self._unit.height)
		GameUtil.SetActive(self._img, true)
	end

	if not string.nilorempty(self._unit.spinePath) and self._spine then
		self._spineCtrl:onInit(self._spine, self._gameView, self._unit.spinePath)
		GameUtil.SetActive(self._spine, true)
	end

	self:updateDirection(self._unit.rotationY, self._unit.rotationZ)
	self:setGray(false)
end

function FishingGameFishCon:updateDirection(rotationY, rotationZ)
	if self._spine and self._unit and not string.nilorempty(self._unit.spinePath) then
		local spineScale = checknumber(self._unit.spineScale)

		if spineScale <= 0 then
			spineScale = 1
		end

		local curState = self._unit:getCurState()
		local isRotationDirect = curState == FishingGameEnum.UnitState.Attack or curState == FishingGameEnum.UnitState.AttackHit

		if not isRotationDirect and rotationY == 180 then
			if not -spineScale then
				local scaleX = spineScale

				GameUtil.setLocalRotation(self.container, 0, 0, rotationZ or 0)
				GameUtil.setLocalScale(self._spine, scaleX, spineScale, spineScale)

				return
			end
		end
	end

	FishingGameFishCon.super.updateDirection(self, rotationY, rotationZ)
end

function FishingGameFishCon:playDefaultAnim()
	if self._spineCtrl then
		self._spineCtrl:playDefaultAnim()
	end
end

function FishingGameFishCon:playAttackAnim()
	if self._spineCtrl then
		self._spineCtrl:playAttackAnim()
	end
end

function FishingGameFishCon:reset()
	if self._spineCtrl then
		self._spineCtrl:_clearSpine()
	end

	if self.container then
		GameUtil.setLocalRotation(self.container, 0, 0, 0)
	end

	FishingGameFishCon.super.reset(self)
end

function FishingGameFishCon:destroy()
	FishingGameFishCon.super.destroy(self)
end

return FishingGameFishCon
