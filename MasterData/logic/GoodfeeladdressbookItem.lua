-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goodfeel/view/GoodfeeladdressbookItem.lua

module("logic.extensions.goodfeel.view.GoodfeeladdressbookItem", package.seeall)

local GoodfeeladdressbookItem = class("GoodfeeladdressbookItem", BaseLuaOnce)

function GoodfeeladdressbookItem:ctor(go)
	GoodfeeladdressbookItem.super.ctor(self, go)

	self._petId = 0
end

function GoodfeeladdressbookItem:buildUI()
	GoodfeeladdressbookItem.super.buildUI(self)

	self._icon = self:getGo("mask/icon")
	self._lvText = self:getText("lvText")
	self._nameText = self:getText("nameText")
	self._btn = GameUtil.asBtn(self.mainGO)
	self._bgChange = self.mainGO:GetComponent(ComponentType.UIImageSpriteChange)
	self._dot = self:getGo("dot")
	self._imgNameChange = self:getGo("imgName"):GetComponent(ComponentType.UIImageSpriteChange)
end

function GoodfeeladdressbookItem:bindEvents()
	GoodfeeladdressbookItem.super.bindEvents(self)
	self._btn:AddClickListener(self._onClick, self)
end

function GoodfeeladdressbookItem:unbindEvents()
	GoodfeeladdressbookItem.super.unbindEvents(self)
	self._btn:RemoveClickListener()
end

function GoodfeeladdressbookItem:onEnter(data)
	GoodfeeladdressbookItem.super.onEnter(self)

	self._raceId = data.raceId

	RedPointController.instance:regRedPoint(self._dot, GoodFeelModel.instance:getAdressItemRedPointKey(self._raceId))

	local co = CharacterConfig.instance:getPetCo(self._raceId)

	if co then
		self._bgChange:SetState(co.rare - 1)
		self._imgNameChange:SetState(co.rare - 1)

		self._nameText.text = co.name
		self._lvText.text = GoodFeelModel.instance:getPetGoodFeelLv(self._raceId, data.goodFeelingExp)

		local skinId = data.raceId
		local petList = {}
		local pets = BagModel.instance:getPets()

		for k, pet in pairs(pets) do
			if pet:getDefineId() == data.raceId then
				local power = pet:getFightingPower()

				table.insert(petList, {
					pet = pet,
					power = power
				})
			end
		end

		table.sort(petList, function(a, b)
			return a.power > b.power
		end)

		local maxPowerPet = petList[1]

		if maxPowerPet then
			skinId = maxPowerPet.pet.curFaceId
		end

		local mCfg = CharacterConfig.instance:getModelCo(skinId)

		if mCfg then
			uGuiUtil.setSpriteToImage(self._icon, nil, GameUrl.getPetImgUrl(mCfg.cardName))
		end

		self._nameText.text = PetSkinConfig.instance:getPetSkinName(skinId)
	else
		printError("不存在的co raceId", self._raceId)
	end
end

function GoodfeeladdressbookItem:onExit()
	GoodfeeladdressbookItem.super.onExit(self)
	RedPointController.instance:unregRedPoint(self._dot)
	uGuiUtil.clearImage(self._icon)
end

function GoodfeeladdressbookItem:_onClick()
	if self._raceId > 0 then
		GoodFeelModel.instance:setPetShowViewCurrRaceId(self._raceId)
		UIStateManager.instance:push(ViewName.GoodfeelpetshowView)
	end
end

return GoodfeeladdressbookItem
