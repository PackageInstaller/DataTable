-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/scuffle/view/ScufflePetCard.lua

module("logic.extensions.scuffle.view.ScufflePetCard", package.seeall)

local ScufflePetCard = class("ScufflePetCard")

function ScufflePetCard:ctor()
	return
end

function ScufflePetCard:buildUI(go)
	self._go = go
	self._node = goutil.findChild(go, "node")
	self._headIcon = goutil.findChild(go, "node/con/petIcon")
	self._txtPower = goutil.findChildTextComponent(go, "node/power/txtPower")
	self._attr = goutil.findChildComponent(go, "node/attr", "UIImageSpriteChange")
	self._imgKuang = goutil.findChildComponent(go, "node/imgKuang", "UIImageSpriteChange")
	self._txtLevel = goutil.findChildTextComponent(go, "node/level/txtLevel")
	self._btnClick = Framework.ButtonAdapter.GetFrom(go, "node")
end

function ScufflePetCard:init(index, id, delayTime, isLeft)
	self._btnClick:AddClickListener(self._onBtnClick, self)

	local bagPetMo = ScuffleModel.instance:createPet(id)

	self._bagPetMo = bagPetMo

	self:_setShow(bagPetMo)
	self:_startTween(delayTime, isLeft)
end

function ScufflePetCard:_setShow(bagPetMo)
	self._txtPower.text = bagPetMo:getFightingPower()
	self._txtLevel.text = bagPetMo:getPetLv() .. "级"

	self._imgKuang:SetState(bagPetMo:getRare())

	local raceId = bagPetMo:getDefineId()
	local cfg = CharacterConfig.instance:getPetCo(raceId)

	if cfg then
		local race = PetSkinConfig.instance:getFisrtEleAttrIdx(bagPetMo.curFaceId)

		self._attr:SetState(race - 1)
	end

	local modelCfg = CharacterConfig.instance:getModelCo(checknumber(bagPetMo.curFaceId))

	if modelCfg then
		uGuiUtil.setSpriteToImage(self._headIcon, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl(modelCfg.cardName))
	end
end

function ScufflePetCard:onReset()
	self._btnClick:RemoveClickListener()

	if self._headIcon then
		local img = Framework.ImageBigBG.Get(self._headIcon)

		if img then
			img:ClearImage()
		end
	end

	self._bagPetMo = nil

	self:_stopTween()
end

function ScufflePetCard:_onBtnClick()
	if self._bagPetMo then
		CommonTipsMgr.instance:showPetTips(self._bagPetMo)
	end
end

function ScufflePetCard:_startTween(delayTime, isLeft)
	local x = isLeft and 804 or -804

	UnityTweens.TweenPosition.StartTween(self._node, Vector3.New(x, 0, 0), Vector3.New(0, 0, 0), 0.3, UnityTweens.EaseType.easeOutBack, delayTime, UnityTweens.CoordSpace.Anchor)
end

function ScufflePetCard:_stopTween()
	UnityTweens.UITweenFade.StopTween(self._node)
end

return ScufflePetCard
