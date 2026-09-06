-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petrelation/view/PetrelationAlertView.lua

module("logic.extensions.petrelation.view.PetrelationAlertView", package.seeall)

local PetrelationAlertView = class("PetrelationAlertView", ViewComponent)

function PetrelationAlertView:ctor()
	PetrelationAlertView.super.ctor(self)
end

function PetrelationAlertView:buildUI()
	PetrelationAlertView.super.buildUI(self)

	self._img = self:getGo("img")
	self._pets = self:getGo("img/bg/pets")
	self._cell = self:getGo("img/bg/cell")
	self._closeBtn = self:getBtn("close")
	self._txtTip = goutil.findChildTextComponent(self.mainGO, "img/bg/cell/txtTip")
end

function PetrelationAlertView:bindEvents()
	PetrelationAlertView.super.bindEvents(self)
	self._closeBtn:AddClickListener(self.showNext, self)
end

function PetrelationAlertView:unbindEvents()
	PetrelationAlertView.super.unbindEvents(self)
	self._closeBtn:RemoveClickListener()
end

function PetrelationAlertView:destroyUI()
	PetrelationAlertView.super.destroyUI(self)
end

function PetrelationAlertView:onEnter()
	PetrelationAlertView.super.onEnter(self)

	self.petMoMap = self:getFirstParam()

	self:showNext()
end

function PetrelationAlertView:onEnterFinished()
	PetrelationAlertView.super.onEnterFinished(self)
end

function PetrelationAlertView:onExit()
	PetrelationAlertView.super.onExit(self)

	local vector = GameUtil.getLocalPos(self._img)

	GameUtil.setLocalPos(self._img, vector.x, 24)

	for i = self._pets.transform.childCount - 1, 0, -1 do
		goutil.destroy(self._pets.transform:GetChild(i).gameObject)
	end

	UIEffectManager.instance:stopEffect(self._eff)
	removetimer(self.showNext, self)

	self.petMoMap = {}
end

function PetrelationAlertView:onExitFinished()
	PetrelationAlertView.super.onExitFinished(self)
end

function PetrelationAlertView:_autoClose()
	self:close()
end

function PetrelationAlertView:showNext()
	local bound, petMoMap = PetRelationController.instance:getNextShow()

	if bound then
		self.petMoMap = petMoMap

		self:showEffect(bound)
	else
		self:close()
	end
end

local effPath = "fx_ui_shangzhenjiban/fx_ui_shangzhenjiban.prefab"

function PetrelationAlertView:showEffect(bound, callBack)
	GameUtil.SetActive(self.mainGO, false)
	GameUtil.SetActive(self.mainGO, true)

	self._eff = UIEffectManager.instance:playEffect(self, effPath, nil, 0, 0, false, nil, function()
		return
	end, function(finishHandler, eff)
		GameUtil.setLocalScale(eff.effGo, 1, 1, 1)
		GameUtil.setAnchoredPos(eff.effGo, 0, 0)
		eff.effGo.transform:SetParent(self:getGo("point_fx").transform)
	end)

	if #bound >= 2 then
		local pet_1, pet_2 = goutil.findChild(self._cell, "pet_1"), goutil.findChild(self._cell, "pet_2")
		local raceId1 = checknumber(bound[1])

		if self.petMoMap[raceId1] then
			local modelCo = CharacterConfig.instance:getModelCo(self.petMoMap[raceId1].curFaceId or raceId1)

			uGuiUtil.setSpriteToImage(pet_1, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(modelCo.headName))

			for i = 2, #bound do
				local raceId2 = checknumber(bound[i])

				if self.petMoMap[raceId2] then
					modelCo = CharacterConfig.instance:getModelCo(self.petMoMap[raceId2].curFaceId)

					uGuiUtil.setSpriteToImage(pet_2, uGuiUtil.SpriteType.BigBg, GameUrl.getCharacterIconUrl(modelCo.headName))
				end
			end

			goutil.setActive(self._cell, true)

			self._txtTip.text = bound.name

			settimer(1.4, self.showNext, self, false)
		end
	else
		self:showNext()
	end
end

return PetrelationAlertView
