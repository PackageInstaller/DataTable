-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bag/view/PetUpView.lua

module("logic.extensions.bag.view.PetUpView", package.seeall)

local PetUpView = class("PetUpView", ViewComponent)
local ViewNames = {
	[GameEnum.PetUpType.PetAwake] = ViewName.PetAwakeLvupView,
	[GameEnum.PetUpType.PetStarLvup] = ViewName.PetStarLvup,
	[GameEnum.PetUpType.PetTalentLvup] = ViewName.PetTalentLvup,
	[GameEnum.PetUpType.PetUpgrade] = ViewName.PetUpgradeView,
	[GameEnum.PetUpType.PetEquipLvup] = ViewName.PetEquipLvup,
	[GameEnum.PetUpType.PetAwakeRing] = ViewName.PetRingLvup
}

function PetUpView:onEnterFinished()
	PetUpView.super.onEnterFinished(self)

	self._txtDesc.text = PetCvController.instance:playPetCv(self._petMo.curFaceId, GameEnum.PetCvType.PetUp)
end

function PetUpView:unbindEvents()
	PetUpView.super.unbindEvents(self)
	self._closeButton:RemoveClickListener()
end

function PetUpView:bindEvents()
	PetUpView.super.bindEvents(self)
	self._closeButton:AddClickListener(self.close, self)
end

function PetUpView:onExit()
	PetUpView.super.onExit(self)
	UIEffectManager.instance:stopEffect(self._eff)

	for _, eff in ipairs(self._effs) do
		UIEffectManager.instance:stopEffect(eff)
	end

	self._effs = {}

	PetCvController.instance:turnOffCurCv()
end

local effPaths = {
	{
		loop = false,
		goPath = "mainGO/point_bg",
		path = "fx_ui_tianfutisheng/fx_ui_baise_01.prefab"
	}
}

function PetUpView:buildUI()
	PetUpView.super.buildUI(self)

	local go = self:getGo("mainGO")

	self._closeButton = self:getBtn("bg")
	self._txtDesc = goutil.findChildTextComponent(go, "txtDesc")
	self._rolePoint = goutil.findChild(go, "rolepoint")
	self._container = goutil.findChild(go, "container")
	self._mainGO = go
end

function PetUpView:onEnter()
	PetUpView.super.onEnter(self)

	local params = self:getOpenParam()

	self._upType = params[1]
	self._petMo = params[2]
	self._preMo = params[3]
	self._isShow = {}

	local raceId = checknumber(self._petMo.curFaceId)
	local displayBagOffset = CharactorFacade.instance:getBattleResultModelUIPosAndScale(raceId)
	local x, y, scale = 0, 0, 1

	if displayBagOffset then
		x = checknumber(displayBagOffset[1])
		y = checknumber(displayBagOffset[2])
		scale = displayBagOffset[3] or 1
	end

	self._role = RoleObjectPool.instance:addRoleToParent(self._role, raceId, self._rolePoint, scale, nil, true, x, y)
	self._isShow[self._upType] = true

	self:showTabAt(self._container, ViewNames[self._upType], self._petMo, self._preMo, params[4])

	self._effs = UIEffectManager.instance:playHudEffects(effPaths, self.mainGO)

	local path = "fx_ui_tujian/fx_ui_tujian_all.prefab"

	self._eff = UIEffectManager.instance:playHUDEffect(path, self.mainGO, true, nil, nil, function(finishHandlerTarget, eff)
		GoUtil.SetSortingOrder(eff.effGo, UGUIToolHelper.GetNodeCanvansSortingOrder(self.mainGO) + 1)
	end, nil, false)
end

function PetUpView:_onClickClose()
	self._upType = BagPetsFacade.instance:getPetUpType(self._petMo, self._preMo, self._isShow)

	if self._upType ~= nil then
		self._isShow[self._upType] = true

		self:showTabAt(self._container, ViewNames[self._upType], self._petMo, self._preMo)
	else
		self:close()
	end
end

return PetUpView
