-- chunkname: @/tmp/or_script/lua_compile/dm/battle/view/BattlePauseMediator.lua

BattlePauseResponse = {
	kContinue = 2,
	kLeave = 1
}

local kBtnHandlers = {
	["main.continueBtn.button"] = {
		func = "onContinueClicked"
	},
	["main.leaveBtn.button"] = {
		func = "onLeaveClicked"
	},
	["main.Node_hp_1.Button"] = {
		func = "onHpSimpleClicked"
	},
	["main.Node_hp_2.Button"] = {
		func = "onHpShowClicked"
	},
	["main.Node_hp_3.Button"] = {
		func = "onHpHideClicked"
	},
	["main.Node_effect_1.Button"] = {
		func = "onEffectShowClicked"
	},
	["main.Node_effect_2.Button"] = {
		func = "onEffectHideClicked"
	}
}

BattlePauseMediator = class("BattlePauseMediator", PopupViewMediator, _M)

BattlePauseMediator:has("_settingSystem", {
	is = "r"
}):injectWith("SettingSystem")

function BattlePauseMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	local bgNode = self:getView():getChildByFullName("main.bg")

	bindWidget(self, bgNode, PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onContinueClicked, self)
		},
		title = Strings:get("Pause_Title"),
		title1 = Strings:get("UITitle_EN_Zhandouzhanting")
	})
	self:bindWidget("main.continueBtn", OneLevelViceButton, {
		ignoreAddKerning = true
	})
	self:bindWidget("main.leaveBtn", OneLevelMainButton, {
		ignoreAddKerning = true
	})

	local settingModel = self._settingSystem:getSettingModel()

	self._hpShow = settingModel:getHpShowSetting()
	self._effectShow = settingModel:getEffectShowSetting()

	self:refreshHpShow()
	self:refreshEffectShow()
end

function BattlePauseMediator:onTouchMaskLayer()
	return
end

function BattlePauseMediator:leaveWithData()
	self:onContinueClicked()
end

function BattlePauseMediator:onContinueClicked(sender, eventType)
	self._settingSystem:setHpShow(self._hpShow)

	local settingModel = self._settingSystem:getSettingModel()

	settingModel:setEffectShowSetting(self._effectShow)
	self:close({
		opt = BattlePauseResponse.kContinue,
		hpShow = self._hpShow,
		effectShow = self._effectShow
	})
end

function BattlePauseMediator:onLeaveClicked(sender, eventType)
	self:close({
		opt = BattlePauseResponse.kLeave
	})
end

function BattlePauseMediator:onHpSimpleClicked(sender, eventType)
	if self._hpShow == BattleHp_ShowType.Simple then
		return
	end

	self._hpShow = BattleHp_ShowType.Simple

	self:refreshHpShow()
end

function BattlePauseMediator:onHpShowClicked(sender, eventType)
	if self._hpShow == BattleHp_ShowType.Show then
		return
	end

	self._hpShow = BattleHp_ShowType.Show

	self:refreshHpShow()
end

function BattlePauseMediator:onHpHideClicked(sender, eventType)
	if self._hpShow == BattleHp_ShowType.Hide then
		return
	end

	self._hpShow = BattleHp_ShowType.Hide

	self:refreshHpShow()
end

function BattlePauseMediator:onEffectShowClicked(sender, eventType)
	if self._effectShow == BattleEffect_ShowType.All then
		return
	end

	self._effectShow = BattleEffect_ShowType.All

	self:refreshEffectShow()
end

function BattlePauseMediator:onEffectHideClicked(sender, eventType)
	if self._effectShow == BattleEffect_ShowType.Smooth then
		return
	end

	self._effectShow = BattleEffect_ShowType.Smooth

	self:refreshEffectShow()
end

function BattlePauseMediator:refreshHpShow()
	local hpShow = self._hpShow

	for i = 1, 3 do
		local nodeBase = self:getView():getChildByFullName("main.Node_hp_" .. i)
		local image_select = nodeBase:getChildByFullName("Image_select")

		if hpShow == BattleHp_ShowType.Simple and i == 1 or hpShow == BattleHp_ShowType.Show and i == 2 or hpShow == BattleHp_ShowType.Hide and i == 3 then
			image_select:setVisible(true)
		else
			image_select:setVisible(false)
		end
	end
end

function BattlePauseMediator:refreshEffectShow()
	local effectShow = self._effectShow

	for i = 1, 2 do
		local nodeBase = self:getView():getChildByFullName("main.Node_effect_" .. i)
		local image_select = nodeBase:getChildByFullName("Image_select")

		if effectShow == BattleEffect_ShowType.Smooth and i == 2 or effectShow == BattleEffect_ShowType.All and i == 1 then
			image_select:setVisible(true)
		else
			image_select:setVisible(false)
		end
	end
end
