-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreamyouth/view/GrowthroadView.lua

module("logic.extensions.dreamyouth.view.GrowthroadView", package.seeall)

local GrowthroadView = class("GrowthroadView", ViewComponent)

function GrowthroadView:ctor()
	GrowthroadView.super.ctor(self)
end

function GrowthroadView:unbindEvents()
	self._longPressed:RemoveListener()
	GameUtil.rmClickHandler(self._btnLevel)
	GameUtil.rmClickHandler(self._btnWakeUp)
	GameUtil.rmClickHandler(self._btnPet)
	GrowthroadView.super.unbindEvents(self)
end

function GrowthroadView:bindEvents()
	GrowthroadView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnLevel, GameUtil.handler(self._strengthenLevel, self))
	GameUtil.addClickHandler(self._btnWakeUp, GameUtil.handler(self._strengthenWakeUp, self))
	GameUtil.addClickHandler(self._btnPet, GameUtil.handler(self._onClickPet, self))
	self._longPressed:AddListener(function(target, isUp)
		self:_onLongPressed(isUp)
	end, self)
end

function GrowthroadView:buildUI()
	GrowthroadView.super.buildUI(self)

	self._sliderExp = goutil.findChildComponent(self.mainGO, "lv/bloodbar", "Slider")
	self._txtProgress = self:getTxt("lv/txt_power")
	self._btnLevel = self:getGo("btnLevel")
	self._btnLevelText = self:getTxt("btnLevel/Text")
	self._txtLevelCost = self:getTxt("level/txtCost")
	self._levelCost = self:getGo("level/txtCost")
	self._iconLevelCost = self:getGo("level/txtCost/icon")
	self._btnWakeUp = self:getGo("btnWakeUp")
	self._btnWakeUpText = self:getTxt("btnWakeUp/Text")
	self._wakeupCost = self:getGo("wakeup/txtCost")
	self._txtWakeUpCost = self:getTxt("wakeup/txtCost")
	self._iconWakeUpCost = self:getGo("wakeup/txtCost/icon")
	self._txtWakeupReceive = self:getGo("txtWakeupReceive")
	self._txtLevelReceive = self:getGo("txtLevelReceive")
	self._btnPet = self:getBtn("btnPet")
	self._btnPetText = self:getTxt("btnPet/Text")
	self._longPressed = self._btnPet:GetComponent("UILongPressed")
	self._txtNum = self:getTxt("txt_num")
	self._eff = {}
	self._effParent = {
		self:getGo("lv/eff"),
		self:getGo("level/eff"),
		(self:getGo("wakeup/eff"))
	}
	self._petS = self:getGo("pet/conS")
	self._petL = self:getGo("pet/mask/conL")
	self._roleS = nil
	self._roleL = nil
end

function GrowthroadView:onExit()
	DreamyouthController.instance:unregisterNotify(DreamyouthController.STRENGTHEN, self._onStrengthen, self)
	DreamyouthController.instance:unregisterNotify(DreamyouthController.DATA_CHANGE, self._updateUI, self)
	RoleObjectPool.instance:removeRole(self._roleS)
	uGuiUtil.clearImage(self._petL)

	self._roleS = nil
	self._roleL = nil

	for i = 1, 3 do
		if self._eff[i] then
			UIEffectManager.instance:stopEffect(self._eff[i])
		end
	end

	uGuiUtil.clearImage(self._iconLevelCost)
	uGuiUtil.clearImage(self._iconWakeUpCost)
	GrowthroadView.super.onExit(self)
end

function GrowthroadView:onEnter()
	GrowthroadView.super.onEnter(self)
	DreamyouthController.instance:registerNotify(DreamyouthController.DATA_CHANGE, self._updateUI, self)
	DreamyouthController.instance:registerNotify(DreamyouthController.STRENGTHEN, self._onStrengthen, self)
	DreamyouthController.instance:getStrengthenInfo()
	uGuiUtil.setSpriteToImage(self._iconLevelCost, uGuiUtil.SpriteType.BigBg, DreamyouthConfig.instance:getCoinIconUrl())
	uGuiUtil.setSpriteToImage(self._iconWakeUpCost, uGuiUtil.SpriteType.BigBg, DreamyouthConfig.instance:getCoinIconUrl())
end

function GrowthroadView:_strengthenWakeUp()
	DreamyouthController.instance:strengthenWakeUp()
end

function GrowthroadView:_strengthenLevel()
	DreamyouthController.instance:strengthenLevel()
end

function GrowthroadView:_strengthenPet(isEnd, value)
	DreamyouthController.instance:strengthenPet(isEnd, value)
end

function GrowthroadView:_onClickPet()
	self:_strengthenPet(true, 1)
end

function GrowthroadView:_playGainEffect(type)
	local effParent = self._effParent[type]

	self._eff[type] = UIEffectManager.instance:playEffect(self, (type == DreamyouthConfig.instance.ST_Pet or nil) and "20211126/zhumengnuoya/fx_ui_zhurunengliang_nuoya.prefab", effParent, 0, 0, false, nil, nil, function(target, eff)
		eff.effGo.transform:SetParent(effParent.transform)
		GameUtil.setLocalPos(eff.effGo.transform, 0, 0, 0)
		GameUtil.setLocalScale(eff.effGo.transform, 1, 1, 1)
	end)
end

function GrowthroadView:_onLongPressTick()
	local isEnd = DreamyouthModel.instance:checkHasGainPet() or DreamyouthModel.instance:coinNum() <= 0

	if isEnd then
		removetimer(self._onLongPressTick, self)

		return
	end

	if self:_strengthenPet(false, 3) then
		removetimer(self._onLongPressTick, self)
	else
		self:_updateUI()
	end
end

function GrowthroadView:_onLongPressed(isUp)
	if not isUp then
		settimer(0, self._onLongPressTick, self)
	else
		removetimer(self._onLongPressTick, self)
		self:_strengthenPet(true, 0)
	end
end

function GrowthroadView:_onStrengthen(type)
	self:_playGainEffect(type)
	self:_updateUI()
end

function GrowthroadView:_updateUI()
	local useNum = DreamyouthModel.instance:curProgress()
	local maxNum = DreamyouthConfig.instance:coinForStrengthenType(DreamyouthConfig.instance.ST_Pet)

	self._sliderExp.value = useNum / maxNum
	self._txtProgress.text = string.format("%s/%s", useNum, maxNum)
	self._txtLevelCost.text = "x" .. DreamyouthConfig.instance:coinForStrengthenType(DreamyouthConfig.instance.ST_Level)
	self._txtWakeUpCost.text = "x" .. DreamyouthConfig.instance:coinForStrengthenType(DreamyouthConfig.instance.ST_WakeUp)

	local isLevelMax = DreamyouthModel.instance:checkStrengthenCountTotalMax(DreamyouthConfig.instance.ST_Level)

	goutil.setActive(self._levelCost, not isLevelMax)
	goutil.setActive(self._btnLevel, not isLevelMax)
	goutil.setActive(self._txtLevelReceive, isLevelMax)

	local isWakeupMax = DreamyouthModel.instance:checkStrengthenCountTotalMax(DreamyouthConfig.instance.ST_WakeUp)

	goutil.setActive(self._wakeupCost, not isWakeupMax)
	goutil.setActive(self._btnWakeUp, not isWakeupMax)
	goutil.setActive(self._txtWakeupReceive, isWakeupMax)

	if DreamyouthModel.instance:checkStrengthenCountTotalMax(DreamyouthConfig.instance.ST_Pet) then
		if self._roleL == nil then
			uGuiUtil.setSpriteToImage(self._petL, uGuiUtil.SpriteType.BigBg, GameUrl.getPetImgUrl("img_14005_zhumengnuoya"))

			self._roleL = true
		end

		goutil.setActive(self._petS, false)
		goutil.setActive(self._petL, true)
	else
		if self._roleS == nil then
			self._roleS = RoleObjectPool.instance:addRoleToParent(self._roleS, 10140, self._petS)
		end

		goutil.setActive(self._petS, true)
		goutil.setActive(self._petL, false)
	end
end

function GrowthroadView:_setBtnGray(btn, btnTxt, boolV)
	if boolV then
		GameUtil.setBtnState(btn, btnTxt, true)
	end
end

return GrowthroadView
