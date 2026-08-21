-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/view/PlayerUpgradeShow2View.lua

module("logic.extensions.common.view.PlayerUpgradeShow2View", package.seeall)

local M = class("PlayerUpgradeShow2View", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	local emptyClick = goutil.findChild(self.mainGO, "emptyClick")

	goutil.setActive(emptyClick.gameObject, false)

	local blurPath = "common_blur_rt"

	self._blurBgView = BlurBgView.New(blurPath)
	self._blurBgView.mainGO = self.mainGO

	self._blurBgView:buildUI()
	self._blurBgView:bindEvents()

	local imgBgPanel = goutil.findChild(self.mainGO, "mask/imgBgPanel")

	self._txtNum_after = goutil.findChildComponent(imgBgPanel, "levelContent/txtNum_after", UIComponentType.Text)
	self._txtEnergyName = goutil.findChildComponent(imgBgPanel, "attributeList/attributeItem1/txtAttribute", UIComponentType.Text)
	self._txtBefore = goutil.findChildComponent(imgBgPanel, "attributeList/attributeItem1/txtBefore", UIComponentType.Text)
	self._txtLater = goutil.findChildComponent(imgBgPanel, "attributeList/attributeItem1/txtLater", UIComponentType.Text)

	local itemCO = BackpackConfig.instance:getItemInfoByItemId(CommEnum.CurrencyCodeEnum.TlCode)
	local name = itemCO and itemCO.name or ""

	self._txtEnergyName.text = langF("tip_common_item_add", name)
end

function M:destroyUI()
	return
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:onEnter()
	PlayerController.instance:setNeedShowUpgradePanel(false)

	local info = self:getFirstParam()

	if info then
		local currentLevel = info.currentLevel

		self._txtNum_after.text = langF("tip_player_level_desc", currentLevel / 10, currentLevel % 10)

		local cfg_curLv = PlayerConfig.instance:getInfoByLevel(currentLevel)

		if cfg_curLv then
			self._txtLater.text = cfg_curLv.addEnergy or 0
		end

		local curEnergyNum = HealthExchangeModel.instance:getCurEnergy()
		local beforeEnergy = curEnergyNum - cfg_curLv.addEnergy

		beforeEnergy = beforeEnergy < 0 and 0 or beforeEnergy
		self._txtBefore.text = beforeEnergy
		self._txtLater.text = curEnergyNum
	end

	if self._blurBgView then
		self._blurBgView:onEnter()
	end

	BattleAudioUtil.playSEByName("ui_battle_zhijitisheng")
end

function M:onExit()
	if self._blurBgView then
		self._blurBgView:onExit()
	end
end

return M
