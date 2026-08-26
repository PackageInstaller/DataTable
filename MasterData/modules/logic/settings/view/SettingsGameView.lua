-- chunkname: @modules/logic/settings/view/SettingsGameView.lua

module("modules.logic.settings.view.SettingsGameView", package.seeall)

local SettingsGameView = class("SettingsGameView", BaseView)

function SettingsGameView:onInitView()
	self._gorecordvideo = gohelper.findChild(self.viewGO, "scroll/Viewport/Content/#go_recordvideo")
	self._btnrecordvideo = gohelper.findChildButtonWithAudio(self._gorecordvideo, "switch/btn")
	self._gooffrecordvideo = gohelper.findChild(self._gorecordvideo, "switch/btn/off")
	self._goonrecordvideo = gohelper.findChild(self._gorecordvideo, "switch/btn/on")
	self._goenteranim = gohelper.findChild(self.viewGO, "scroll/Viewport/Content/#go_enteranim")
	self._goAuto = gohelper.findChild(self._goenteranim, "switch/btn/auto")
	self._goHand = gohelper.findChild(self._goenteranim, "switch/btn/hand")
	self._btnenteranim = gohelper.findChildButtonWithAudio(self._goenteranim, "switch/btn")
	self._gorecommend = gohelper.findChild(self.viewGO, "scroll/Viewport/Content/#go_recommend")
	self._gorecommendon = gohelper.findChild(self._gorecommend, "switch/btn/on")
	self._gorecommendoff = gohelper.findChild(self._gorecommend, "switch/btn/off")
	self._btnrecommend = gohelper.findChildButtonWithAudio(self._gorecommend, "switch/btn")
	self._gochangeenteranim = gohelper.findChild(self.viewGO, "scroll/Viewport/Content/#go_changeenteranim")
	self._btnchangeanimFirst = gohelper.findChildButtonWithAudio(self._gochangeenteranim, "switch/#btn_first")
	self._btnchangeanimEven = gohelper.findChildButtonWithAudio(self._gochangeenteranim, "switch/#btn_even")
	self._gochangeon1 = gohelper.findChild(self._gochangeenteranim, "switch/#btn_even/#go_evenon")
	self._gochangeoff1 = gohelper.findChild(self._gochangeenteranim, "switch/#btn_even/#go_evenoff")
	self._gochangeon2 = gohelper.findChild(self._gochangeenteranim, "switch/#btn_first/#go_firston")
	self._gochangeoff2 = gohelper.findChild(self._gochangeenteranim, "switch/#btn_first/#go_firstoff")
	self._goudimoenter = gohelper.findChild(self.viewGO, "scroll/Viewport/Content/#go_udimoenter")
	self._btnudimoenterclick = gohelper.findChildClick(self.viewGO, "scroll/Viewport/Content/#go_udimoenter/txt_udimoenter/#btn_click")
	self._godropudimo = gohelper.findChild(self.viewGO, "scroll/Viewport/Content/#go_udimoenter/#go_saving/dropudimo")
	self._udimoDrop = gohelper.findChildDropdown(self.viewGO, "scroll/Viewport/Content/#go_udimoenter/#go_saving/dropudimo")
	self._udimodropclick = gohelper.getClickWithAudio(self._godropudimo, AudioEnum.UI.play_ui_set_click)
	self._udimoTemplate = gohelper.findChild(self._godropudimo, "Template")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function SettingsGameView:addEvents()
	if SettingsShowHelper.canShowRecordVideo() then
		self._btnrecordvideo:AddClickListener(self._btnrecordvideoOnClick, self)
	end

	self._btnenteranim:AddClickListener(self._btnenteranimOnClick, self)
	self._btnchangeanimFirst:AddClickListener(self._btnchangeanimFirstOnClick, self)
	self._btnchangeanimEven:AddClickListener(self._btnchangeanimEvenOnClick, self)
	self._btnrecommend:AddClickListener(self._btnchangerecommendOnClick, self)
	self._btnudimoenterclick:AddClickListener(self._btnudimoenterOnClick, self)
	self._udimoDrop:AddOnValueChanged(self._onUdimoSettingValueChanged, self)
	self._udimodropclick:AddClickListener(self.udimoDropOnClick, self)
end

function SettingsGameView:removeEvents()
	if SettingsShowHelper.canShowRecordVideo() then
		self._btnrecordvideo:RemoveClickListener()
	end

	self._btnenteranim:RemoveClickListener()
	self._btnchangeanimFirst:RemoveClickListener()
	self._btnchangeanimEven:RemoveClickListener()
	self._btnrecommend:RemoveClickListener()
	self._btnudimoenterclick:RemoveClickListener()
	self._udimoDrop:RemoveOnValueChanged()
	self._udimodropclick:RemoveClickListener()
end

function SettingsGameView:_editableInitView()
	gohelper.setActive(self._gorecordvideo, SettingsShowHelper.canShowRecordVideo())
	gohelper.setActive(self._goudimoenter, SettingsShowHelper.canShowUdimo())
	self:_initUdimoDropDown()
	self:refreshRecordVideo()
	self:refreshEnterAnim()
	self:refreshRecommend()
end

local UDIMO_DROP_ITEM_HEIGHT = 84

function SettingsGameView:_initUdimoDropDown()
	local nameList = {}

	self._udimoSettingIdList = UdimoConfig.instance:getLockSettingIdList()

	for _, id in ipairs(self._udimoSettingIdList) do
		local name = UdimoConfig.instance:getSettingName(id)

		table.insert(nameList, name)
	end

	self._udimoDrop:ClearOptions()
	self._udimoDrop:AddOptions(nameList)

	local contentHeight = #nameList * UDIMO_DROP_ITEM_HEIGHT

	recthelper.setHeight(self._udimoTemplate.transform, contentHeight)

	local curUdimoSettingId = UdimoModel.instance:getUdimoSettingId()
	local index = tabletool.indexOf(self._udimoSettingIdList, curUdimoSettingId)

	if not index then
		index = 1

		local defaultSetting = UdimoConfig.instance:getDefaultSettingId()

		curUdimoSettingId = defaultSetting

		UdimoController.instance:changeUdimoLockSetting(defaultSetting)
	end

	self._udimoDrop:SetValue(index - 1)

	self._udimoDropIndex = self._udimoDrop:GetValue()
end

function SettingsGameView:_onUdimoSettingValueChanged(index)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_plot_common)

	self._udimoDropIndex = index

	local settingId = self._udimoSettingIdList[index + 1]

	UdimoController.instance:changeUdimoLockSetting(settingId)
	self:_refreshUdimoDropDown()
	UdimoStatController.instance:gameSetting(settingId)
end

function SettingsGameView:udimoDropOnClick()
	self:_refreshUdimoDropDown()
end

function SettingsGameView:onDestroyView()
	return
end

function SettingsGameView:refreshRecommend(isOn)
	if isOn == nil then
		isOn = SettingsModel.instance:isTypeOn(SettingsEnum.PushType.Allow_Recommend)
	end

	gohelper.setActive(self._gorecommendon, isOn)
	gohelper.setActive(self._gorecommendoff, not isOn)
end

function SettingsGameView:refreshRecordVideo()
	local isOn = SettingsModel.instance:getRecordVideo()

	gohelper.setActive(self._gooffrecordvideo, not isOn)
	gohelper.setActive(self._goonrecordvideo, isOn)
end

function SettingsGameView:refreshEnterAnim()
	local limitedRoleMO = SettingsModel.instance.limitedRoleMO
	local isAuto = limitedRoleMO:isAuto()

	gohelper.setActive(self._goAuto, isAuto)
	gohelper.setActive(self._goHand, not isAuto)
	gohelper.setActive(self._gochangeenteranim, isAuto)
	gohelper.setActive(self._gochangeon1, limitedRoleMO:isEveryLogin())
	gohelper.setActive(self._gochangeoff1, not limitedRoleMO:isEveryLogin())
	gohelper.setActive(self._gochangeon2, limitedRoleMO:isDaily())
	gohelper.setActive(self._gochangeoff2, not limitedRoleMO:isDaily())
end

function SettingsGameView:_refreshUdimoDropDown()
	local content = gohelper.findChild(self._godropudimo, "Dropdown List/Viewport/Content")

	if not content then
		return
	end

	local contentTrans = content.transform
	local childCount = contentTrans.childCount

	for i = 1, childCount do
		local child = contentTrans:GetChild(i - 1)
		local bg = gohelper.findChild(child.gameObject, "BG")

		gohelper.setActive(bg, false)
	end

	local selectedItem = contentTrans:GetChild(self._udimoDropIndex + 1)

	if selectedItem then
		local bg = gohelper.findChild(selectedItem.gameObject, "BG")

		gohelper.setActive(bg, true)
	end
end

function SettingsGameView:_btnrecordvideoOnClick()
	if SettingsController.instance:checkSwitchRecordVideo() then
		self:refreshRecordVideo()
	end
end

function SettingsGameView:_btnenteranimOnClick()
	local limitedRoleMO = SettingsModel.instance.limitedRoleMO

	if limitedRoleMO:isAuto() then
		limitedRoleMO:setManual()
	else
		limitedRoleMO:setAuto()
	end

	self:_delaySaveSetting()
	self:refreshEnterAnim()
end

function SettingsGameView:_btnchangeanimFirstOnClick()
	local limitedRoleMO = SettingsModel.instance.limitedRoleMO

	if limitedRoleMO:isAuto() and not limitedRoleMO:isDaily() then
		limitedRoleMO:setDaily()
		self:_delaySaveSetting()
		self:refreshEnterAnim()
	end
end

function SettingsGameView:_btnchangeanimEvenOnClick()
	local limitedRoleMO = SettingsModel.instance.limitedRoleMO

	if limitedRoleMO:isAuto() and not limitedRoleMO:isEveryLogin() then
		limitedRoleMO:setEveryLogin()
		self:_delaySaveSetting()
		self:refreshEnterAnim()
	end
end

function SettingsGameView:_btnchangerecommendOnClick()
	local isServerOn = SettingsModel.instance:isTypeOn(SettingsEnum.PushType.Allow_Recommend)

	UserSettingRpc.instance:sendUpdateSettingInfoRequest(SettingsEnum.PushType.Allow_Recommend, isServerOn and "0" or "1")
	self:refreshRecommend(not isServerOn)

	local var_17_0 = {}

	if isServerOn then
		var_17_0[StatEnum.EventProperties.Status] = StatEnum.OpenCloseStatus.Close or StatEnum.OpenCloseStatus.Open
	end

	StatController.instance:track(StatEnum.EventName.SetFriendRecommended, var_17_0)
end

function SettingsGameView:_btnudimoenterOnClick()
	UdimoController.instance:enterUdimo()
end

function SettingsGameView:_delaySaveSetting()
	TaskDispatcher.cancelTask(self._saveSetting, self)
	TaskDispatcher.runDelay(self._saveSetting, self, 0.15)
end

function SettingsGameView:_saveSetting()
	if SDKMgr.instance:isEmulator() then
		PlayerPrefsHelper.save()
	end
end

return SettingsGameView
