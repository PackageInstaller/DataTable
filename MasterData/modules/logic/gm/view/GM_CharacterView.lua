-- chunkname: @modules/logic/gm/view/GM_CharacterView.lua

module("modules.logic.gm.view.GM_CharacterView", package.seeall)

local GM_CharacterView = class("GM_CharacterView", BaseView)
local kYellow = "#FFFF00"

GM_CharacterView.s_AutoCheckFaceOnOpen = false
GM_CharacterView.s_AutoCheckMouthOnOpen = false
GM_CharacterView.s_AutoCheckContentOnOpen = false
GM_CharacterView.s_AutoCheckMotionOnOpen = false

local function _checkFace(heroId, obj)
	local checkcer = Checker_HeroVoiceFace.New(heroId)

	checkcer:exec(obj)
	checkcer:log()
end

local function _checkMouth(heroId, obj)
	local checkcer = Checker_HeroVoiceMouth.New(heroId)

	checkcer:exec(obj)
	checkcer:log()
end

local function _checkContent(heroId, obj)
	local checkcer = Checker_HeroVoiceContent.New(heroId)

	checkcer:exec(obj)
	checkcer:log()
end

local function _checkMotion(heroId, obj)
	local checkcer = Checker_HeroVoiceMotion.New(heroId)

	checkcer:exec(obj)
	checkcer:log()
end

function GM_CharacterView.register()
	GM_CharacterView.CharacterView_register(CharacterView)
end

function GM_CharacterView.CharacterView_register(T)
	GMMinusModel.instance:saveOriginalFunc(T, "_editableInitView")
	GMMinusModel.instance:saveOriginalFunc(T, "addEvents")
	GMMinusModel.instance:saveOriginalFunc(T, "removeEvents")
	GMMinusModel.instance:saveOriginalFunc(T, "_refreshInfo")
	GMMinusModel.instance:saveOriginalFunc(T, "_onSpineLoaded")

	function T:_editableInitView(...)
		GMMinusModel.instance:callOriginalSelfFunc(self, "_editableInitView", ...)
		GMMinusModel.instance:addBtnGM(self)
	end

	function T:addEvents(...)
		GMMinusModel.instance:callOriginalSelfFunc(self, "addEvents", ...)
		GMMinusModel.instance:btnGM_AddClickListener(self)
		GM_CharacterViewContainer.addEvents(self)
	end

	function T:removeEvents(...)
		GMMinusModel.instance:callOriginalSelfFunc(self, "removeEvents", ...)
		GMMinusModel.instance:btnGM_RemoveClickListener(self)
		GM_CharacterViewContainer.removeEvents(self)
	end

	function T._onSpineLoaded(selfObj, ...)
		GMMinusModel.instance:callOriginalSelfFunc(selfObj, "_onSpineLoaded", ...)

		local heroMO = selfObj._heroMO
		local heroId = heroMO.heroId
		local obj = selfObj._uiSpine

		if GM_CharacterView.s_AutoCheckFaceOnOpen then
			_checkFace(heroId, obj)
		end

		if GM_CharacterView.s_AutoCheckMouthOnOpen then
			_checkMouth(heroId, obj)
		end

		if GM_CharacterView.s_AutoCheckContentOnOpen then
			_checkContent(heroId, obj)
		end

		if GM_CharacterView.s_AutoCheckMotionOnOpen then
			_checkMotion(heroId, obj)
		end
	end

	function T._refreshInfo(selfObj, ...)
		GMMinusModel.instance:callOriginalSelfFunc(selfObj, "_refreshInfo", ...)

		if GM_CharacterView.s_ShowAllTabId then
			local heroMO = selfObj._heroMO
			local heroId = heroMO.heroId
			local heroCO = heroMO.config

			selfObj._txtnamecn.text = gohelper.getRichColorText(heroId, kYellow) .. heroCO.name
		end
	end

	function T._gm_showAllTabIdUpdate(selfObj)
		selfObj:_refreshInfo()
	end

	function T._gm_onClickCheckFace(selfObj)
		local heroMO = selfObj._heroMO
		local heroId = heroMO.heroId
		local obj = selfObj._uiSpine

		_checkFace(heroId, obj)
	end

	function T._gm_onClickCheckMouth(selfObj)
		local heroMO = selfObj._heroMO
		local heroId = heroMO.heroId
		local obj = selfObj._uiSpine

		_checkMouth(heroId, obj)
	end
end

function GM_CharacterView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "btnClose")
	self._item1Toggle = gohelper.findChildToggle(self.viewGO, "viewport/content/item1/Toggle")
	self._item2Btn = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item2/Button")
	self._item3Btn = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item3/Button")
	self._item4Btn = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item4/Button")
	self._item5Btn = gohelper.findChildButtonWithAudio(self.viewGO, "viewport/content/item5/Button")
end

function GM_CharacterView:addEvents()
	self._btnClose:AddClickListener(self.closeThis, self)
	self._item1Toggle:AddOnValueChanged(self._onItem1ToggleValueChanged, self)
	self._item2Btn:AddClickListener(self._onItem2Click, self)
	self._item3Btn:AddClickListener(self._onItem3Click, self)
	self._item4Btn:AddClickListener(self._onItem4Click, self)
	self._item5Btn:AddClickListener(self._onItem5Click, self)
end

function GM_CharacterView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._item1Toggle:RemoveOnValueChanged()
	self._item2Btn:RemoveClickListener()
	self._item3Btn:RemoveClickListener()
	self._item4Btn:RemoveClickListener()
	self._item5Btn:RemoveClickListener()
end

function GM_CharacterView:onOpen()
	self:_refreshItem1()
end

function GM_CharacterView:onDestroyView()
	return
end

GM_CharacterView.s_ShowAllTabId = false

function GM_CharacterView:_refreshItem1()
	self._item1Toggle.isOn = GM_CharacterView.s_ShowAllTabId
end

function GM_CharacterView:_onItem1ToggleValueChanged()
	local isOn = self._item1Toggle.isOn

	GM_CharacterView.s_ShowAllTabId = isOn

	GMController.instance:dispatchEvent(GMEvent.CharacterView_ShowAllTabIdUpdate, isOn)
end

function GM_CharacterView:_onItem2Click()
	GMController.instance:dispatchEvent(GMEvent.CharacterView_OnClickCheckFace)
end

function GM_CharacterView:_onItem3Click()
	GMController.instance:dispatchEvent(GMEvent.CharacterView_OnClickCheckMouth)
end

function GM_CharacterView:_onItem4Click()
	GMController.instance:dispatchEvent(GMEvent.CharacterView_OnClickCheckContent)
end

function GM_CharacterView:_onItem5Click()
	GMController.instance:dispatchEvent(GMEvent.CharacterView_OnClickCheckMotion)
end

return GM_CharacterView
