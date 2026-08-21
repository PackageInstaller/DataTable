-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/view/setting/BattleOptionSettingView.lua

module("logic.extensions.mainui.view.setting.BattleOptionSettingView", package.seeall)

local M = class("BattleOptionSettingView", ViewComponent)
local BattleAnimaSetting = GameEnum.SystemEnum.BattleAnimaSetting

function M:buildUI()
	self._animationToggleGroup = self:getUIComponent("main_setting_tips_79324412", UIComponentType.SpaceXToggleGroup)
	self._animationToggleCompList = {}

	local animationToggleGoList = Astral.GameObjectUtil.GetChildren(self:getGo("main_setting_tips_79324412"))

	for index = 0, animationToggleGoList.Length - 1 do
		local toggleComp = animationToggleGoList[index]:GetComponent(UIComponentType.SpaceXToggle)

		table.insert(self._animationToggleCompList, toggleComp)
	end

	self._speedToggleGroup = self:getUIComponent("main_setting_tips_-1546201568", UIComponentType.SpaceXToggleGroup)
	self._speedToggleCompList = {}

	local speedToggleGoList = Astral.GameObjectUtil.GetChildren(self:getGo("main_setting_tips_-1546201568"))

	for index = 0, speedToggleGoList.Length - 1 do
		local toggleComp = speedToggleGoList[index]:GetComponent(UIComponentType.SpaceXToggle)

		table.insert(self._speedToggleCompList, toggleComp)
	end

	self._toggleAutoEnd = self:getUIComponent("main_setting_tips_58602465", UIComponentType.SpaceXToggle)
	self._toggleClickEnsure = self:getUIComponent("main_setting_tips_206155659", UIComponentType.SpaceXToggle)
	self._toggleDoubleClickStandby = self:getUIComponent("main_setting_tips_1740020393", UIComponentType.SpaceXToggle)
	self._toggleAutoShowDangerous = self:getUIComponent("main_setting_tips_1675757414", UIComponentType.SpaceXToggle)
	self._toggleTargetPrediction = self:getUIComponent("main_setting_tips_-1565415068", UIComponentType.SpaceXToggle)
	self._toggleSimpleSkill = self:getUIComponent("main_setting_tips_-1571701036", UIComponentType.SpaceXToggle)
	self._toggleNoneTarget = self:getUIComponent("main_setting_tips_1932490641", UIComponentType.SpaceXToggle)
	self._toggleShakeEnable = self:getUIComponent("main_setting_tips_-791939241", UIComponentType.SpaceXToggle)
end

function M:destroyUI()
	self._animationToggleGroup = nil
	self._animationToggleCompList = nil
end

function M:bindEvents()
	self._toggleAutoEnd:AddListener(self._onToggleAutoEnd, self)
	self._toggleClickEnsure:AddListener(self._onToggleClickEnsure, self)
	self._toggleDoubleClickStandby:AddListener(self._onToggleDoubleClickStandby, self)
	self._toggleAutoShowDangerous:AddListener(self._onToggleAutoShowDangerous, self)
	self._toggleTargetPrediction:AddListener(self._onToggleTargetPrediction, self)
	self._toggleSimpleSkill:AddListener(self._onToggleSimpleSkill, self)
	self._toggleNoneTarget:AddListener(self._onToggleNoneTarget, self)
	self._toggleShakeEnable:AddListener(self._onToggleShake, self)

	for k, v in pairs(self._animationToggleCompList) do
		v:AddListener(function(_, isOn, IsEnable)
			self:_dealAniBarClick(k, isOn, IsEnable)
		end, self)
	end

	for k, v in pairs(self._speedToggleCompList) do
		v:AddListener(function(_, isOn)
			self:_dealSpeedBarClick(k, isOn)
		end, self)
	end
end

function M:unbindEvents()
	self._toggleAutoEnd:RemoveListener()
	self._toggleClickEnsure:RemoveListener()
	self._toggleDoubleClickStandby:RemoveListener()
	self._toggleAutoShowDangerous:RemoveListener()
	self._toggleTargetPrediction:RemoveListener()
	self._toggleSimpleSkill:RemoveListener()
	self._toggleNoneTarget:RemoveListener()
	self._toggleShakeEnable:RemoveListener()

	for k, v in pairs(self._animationToggleCompList) do
		v:RemoveListener()
	end

	for k, v in pairs(self._speedToggleCompList) do
		v:RemoveListener()
	end
end

function M:onEnter()
	self:_handleSystemOpen()
	self:setEvent(true)
	self:syncSetting()
end

function M:_handleSystemOpen()
	local isOpen = SystemOpenFacade.instance:isOpen(BattleAnimaSetting)

	for k, v in pairs(self._animationToggleCompList) do
		if k > 1 then
			v.IsEnable = isOpen
		elseif not isOpen then
			v.IsOn = true

			PlayerLocalStorageModel.instance:setBattleAnimationQuality(1)
		end
	end
end

function M:onExit()
	self:setEvent(false)
end

function M:setEvent(isAdd)
	if isAdd then
		GlobalDispatcher:addEventListener(EventType.SETTING_TAB_CHANGE, self._onSettingTabChange, self)
	else
		GlobalDispatcher:removeEventListener(EventType.SETTING_TAB_CHANGE, self._onSettingTabChange, self)
	end
end

function M:_onSettingTabChange()
	self:syncSetting()
end

function M:syncSetting()
	local aniQuality = PlayerLocalStorageModel.instance:getBattleAnimationQuality()

	self._animationToggleGroup:TryActiveChildOn(self._animationToggleCompList[aniQuality], true)

	local speed = PlayerLocalStorageModel.instance:getSpeedAdjust()

	self._speedToggleGroup:TryActiveChildOn(self._speedToggleCompList[speed], true)

	self._toggleAutoEnd.IsOn = PlayerLocalStorageModel.instance:getAutoEnd()
	self._toggleClickEnsure.IsOn = PlayerLocalStorageModel.instance:getClickEnsure()
	self._toggleDoubleClickStandby.IsOn = PlayerLocalStorageModel.instance:getDoubleClickStandby()
	self._toggleAutoShowDangerous.IsOn = PlayerLocalStorageModel.instance:getAutoShowDangerous()
	self._toggleTargetPrediction.IsOn = PlayerLocalStorageModel.instance:getTargetPrediction()
	self._toggleSimpleSkill.IsOn = PlayerLocalStorageModel.instance:getSimpleSkillCast()
	self._toggleNoneTarget.IsOn = PlayerLocalStorageModel.instance:getNoneTarget()
	self._toggleShakeEnable.IsOn = PlayerLocalStorageModel.instance:getShakeEnable()
end

function M:_dealAniBarClick(index, isOn, IsEnable)
	if not IsEnable then
		SystemOpenFacade.instance:isOpen(BattleAnimaSetting, true)

		return
	end

	if isOn then
		self._curAniSettingIndex = index

		PlayerLocalStorageModel.instance:setBattleAnimationQuality(index)
		GlobalDispatcher:dispatchEvent(EventType.SETTING_CONTENT_CHANGE, SettingConst.kBattleAnimationQuality, index)
	end
end

function M:_dealSpeedBarClick(index, isOn)
	if isOn then
		if index > 1 and not SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.FightSpeed, true) then
			local activeTab = self._speedToggleCompList[self._curSpeedSettingIndex]

			if activeTab then
				activeTab.IsOn = true
			end

			return
		end

		self._curSpeedSettingIndex = index

		PlayerLocalStorageModel.instance:setSpeedAdjust(index)
		GlobalDispatcher:dispatchEvent(EventType.SETTING_CONTENT_CHANGE, SettingConst.kSpeedAdjust, index)
	end
end

function M:_onToggleAutoEnd(index, isOn)
	PlayerLocalStorageModel.instance:setAutoEnd(isOn)
	GlobalDispatcher:dispatchEvent(EventType.SETTING_CONTENT_CHANGE, SettingConst.kAutoEnd, isOn)
end

function M:_onToggleClickEnsure(index, isOn)
	PlayerLocalStorageModel.instance:setClickEnsure(isOn)
	GlobalDispatcher:dispatchEvent(EventType.SETTING_CONTENT_CHANGE, SettingConst.kClickEnsure, isOn)
end

function M:_onToggleDoubleClickStandby(index, isOn)
	PlayerLocalStorageModel.instance:setDoubleClickStandby(isOn)
	GlobalDispatcher:dispatchEvent(EventType.SETTING_CONTENT_CHANGE, SettingConst.kDoubleClickStandby, isOn)
end

function M:_onToggleAutoShowDangerous(index, isOn)
	PlayerLocalStorageModel.instance:setAutoShowDangerous(isOn)
	GlobalDispatcher:dispatchEvent(EventType.SETTING_CONTENT_CHANGE, SettingConst.kAutoShowDangerous, isOn)
end

function M:_onToggleTargetPrediction(index, isOn)
	PlayerLocalStorageModel.instance:setTargetPrediction(isOn)
	GlobalDispatcher:dispatchEvent(EventType.SETTING_CONTENT_CHANGE, SettingConst.kTargetPrediction, isOn)
end

function M:_onToggleSimpleSkill(index, isOn)
	PlayerLocalStorageModel.instance:setSimpleSkillCast(isOn)
	GlobalDispatcher:dispatchEvent(EventType.SETTING_CONTENT_CHANGE, SettingConst.kSimpleSkillCast, isOn)
end

function M:_onToggleNoneTarget(index, isOn)
	PlayerLocalStorageModel.instance:setNoneTarget(isOn)
	GlobalDispatcher:dispatchEvent(EventType.SETTING_CONTENT_CHANGE, SettingConst.kNoneTarget, isOn)
end

function M:_onToggleShake(index, isOn)
	PlayerLocalStorageModel.instance:setShakeEnable(isOn)
end

return M
