-- chunkname: @modules/logic/gm/view/GM_CharacterBackpackView.lua

module("modules.logic.gm.view.GM_CharacterBackpackView", package.seeall)

local GM_CharacterBackpackView = class("GM_CharacterBackpackView", BaseView)
local kYellow = "#FFFF00"

function GM_CharacterBackpackView.register()
	GM_CharacterBackpackView.CharacterBackpackView_register(CharacterBackpackView)
	GM_CharacterBackpackView.CharacterBackpackCardListItem_register(CharacterBackpackCardListItem)
end

function GM_CharacterBackpackView.CharacterBackpackView_register(T)
	GMMinusModel.instance:saveOriginalFunc(T, "_editableInitView")
	GMMinusModel.instance:saveOriginalFunc(T, "addEvents")
	GMMinusModel.instance:saveOriginalFunc(T, "removeEvents")

	function T:_editableInitView(...)
		GMMinusModel.instance:callOriginalSelfFunc(self, "_editableInitView", ...)
		GMMinusModel.instance:addBtnGM(self)
	end

	function T:addEvents(...)
		GMMinusModel.instance:callOriginalSelfFunc(self, "addEvents", ...)
		GMMinusModel.instance:btnGM_AddClickListener(self)
		GM_CharacterBackpackViewContainer.addEvents(self)
	end

	function T:removeEvents(...)
		GMMinusModel.instance:callOriginalSelfFunc(self, "removeEvents", ...)
		GMMinusModel.instance:btnGM_RemoveClickListener(self)
		GM_CharacterBackpackViewContainer.removeEvents(self)
	end

	function T:_gm_showAllTabIdUpdate()
		CharacterController.instance:dispatchEvent(CharacterEvent.HeroUpdatePush)
	end

	function T:_gm_enableCheckFaceOnSelect()
		GM_CharacterView.s_AutoCheckFaceOnOpen = GM_CharacterBackpackView.s_enableCheckSelectedFace
	end

	function T:_gm_enableCheckMouthOnSelect()
		GM_CharacterView.s_AutoCheckMouthOnOpen = GM_CharacterBackpackView.s_enableCheckSelectedMouth
	end

	function T:_gm_enableCheckContentOnSelect()
		GM_CharacterView.s_AutoCheckContentOnOpen = GM_CharacterBackpackView.s_enableCheckSelectedContent
	end

	function T:_gm_enableCheckMotionOnSelect()
		GM_CharacterView.s_AutoCheckMotionOnOpen = GM_CharacterBackpackView.s_enableCheckSelectedMotion
	end
end

function GM_CharacterBackpackView.CharacterBackpackCardListItem_register(T)
	GMMinusModel.instance:saveOriginalFunc(T, "onUpdateMO")
	GMMinusModel.instance:saveOriginalFunc(T, "_onItemClick")

	function T.onUpdateMO(selfObj, ...)
		GMMinusModel.instance:callOriginalSelfFunc(selfObj, "onUpdateMO", ...)

		if GM_CharacterBackpackView.s_ShowAllTabId then
			local mo = selfObj._mo

			selfObj._heroItem._nameCnTxt.text = gohelper.getRichColorText(mo.config.id, kYellow)
		end
	end

	function T._onItemClick(selfObj, ...)
		if GM_CharacterBackpackView.s_enableCheckSelectedFace then
			GM_CharacterView.s_AutoCheckFaceOnOpen = true
		end

		if GM_CharacterBackpackView.s_enableCheckSelectedMouth then
			GM_CharacterView.s_AutoCheckMouthOnOpen = true
		end

		if GM_CharacterBackpackView.s_enableCheckSelectedContent then
			GM_CharacterView.s_AutoCheckContentOnOpen = true
		end

		if GM_CharacterBackpackView.s_enableCheckSelectedMotion then
			GM_CharacterView.s_AutoCheckMotionOnOpen = true
		end

		GMMinusModel.instance:callOriginalSelfFunc(selfObj, "_onItemClick", ...)
	end
end

function GM_CharacterBackpackView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "btnClose")
	self._item1Toggle = gohelper.findChildToggle(self.viewGO, "viewport/content/item1/Toggle")
	self._item2Toggle = gohelper.findChildToggle(self.viewGO, "viewport/content/item2/Toggle")
	self._item3Toggle = gohelper.findChildToggle(self.viewGO, "viewport/content/item3/Toggle")
	self._item4Toggle = gohelper.findChildToggle(self.viewGO, "viewport/content/item4/Toggle")
	self._item5Toggle = gohelper.findChildToggle(self.viewGO, "viewport/content/item5/Toggle")
end

function GM_CharacterBackpackView:addEvents()
	self._btnClose:AddClickListener(self.closeThis, self)
	self._item1Toggle:AddOnValueChanged(self._onItem1ToggleValueChanged, self)
	self._item2Toggle:AddOnValueChanged(self._onItem2ToggleValueChanged, self)
	self._item3Toggle:AddOnValueChanged(self._onItem3ToggleValueChanged, self)
	self._item4Toggle:AddOnValueChanged(self._onItem4ToggleValueChanged, self)
	self._item5Toggle:AddOnValueChanged(self._onItem5ToggleValueChanged, self)
end

function GM_CharacterBackpackView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._item1Toggle:RemoveOnValueChanged()
	self._item2Toggle:RemoveOnValueChanged()
	self._item3Toggle:RemoveOnValueChanged()
	self._item4Toggle:RemoveOnValueChanged()
	self._item5Toggle:RemoveOnValueChanged()
end

function GM_CharacterBackpackView:onOpen()
	self:_refreshItem1()
	self:_refreshItem2()
	self:_refreshItem3()
	self:_refreshItem4()
	self:_refreshItem5()
end

function GM_CharacterBackpackView:onDestroyView()
	return
end

GM_CharacterBackpackView.s_ShowAllTabId = false

function GM_CharacterBackpackView:_refreshItem1()
	self._item1Toggle.isOn = GM_CharacterBackpackView.s_ShowAllTabId
end

function GM_CharacterBackpackView:_onItem1ToggleValueChanged()
	local isOn = self._item1Toggle.isOn

	GM_CharacterBackpackView.s_ShowAllTabId = isOn

	GMController.instance:dispatchEvent(GMEvent.CharacterBackpackView_ShowAllTabIdUpdate, isOn)
end

GM_CharacterBackpackView.s_enableCheckSelectedFace = false

function GM_CharacterBackpackView:_refreshItem2()
	self._item2Toggle.isOn = GM_CharacterBackpackView.s_enableCheckSelectedFace
end

function GM_CharacterBackpackView:_onItem2ToggleValueChanged()
	local isOn = self._item2Toggle.isOn

	GM_CharacterBackpackView.s_enableCheckSelectedFace = isOn

	GMController.instance:dispatchEvent(GMEvent.CharacterBackpackView_EnableCheckFaceOnSelect, isOn)
end

GM_CharacterBackpackView.s_enableCheckSelectedMouth = false

function GM_CharacterBackpackView:_refreshItem3()
	self._item3Toggle.isOn = GM_CharacterBackpackView.s_enableCheckSelectedMouth
end

function GM_CharacterBackpackView:_onItem3ToggleValueChanged()
	local isOn = self._item3Toggle.isOn

	GM_CharacterBackpackView.s_enableCheckSelectedMouth = isOn

	GMController.instance:dispatchEvent(GMEvent.CharacterBackpackView_EnableCheckMouthOnSelect, isOn)
end

GM_CharacterBackpackView.s_enableCheckSelectedContent = false

function GM_CharacterBackpackView:_refreshItem4()
	self._item4Toggle.isOn = GM_CharacterBackpackView.s_enableCheckSelectedContent
end

function GM_CharacterBackpackView:_onItem4ToggleValueChanged()
	local isOn = self._item4Toggle.isOn

	GM_CharacterBackpackView.s_enableCheckSelectedContent = isOn

	GMController.instance:dispatchEvent(GMEvent.CharacterBackpackView_EnableCheckContentOnSelect, isOn)
end

GM_CharacterBackpackView.s_enableCheckSelectedMotion = false

function GM_CharacterBackpackView:_refreshItem5()
	self._item5Toggle.isOn = GM_CharacterBackpackView.s_enableCheckSelectedMotion
end

function GM_CharacterBackpackView:_onItem5ToggleValueChanged()
	local isOn = self._item5Toggle.isOn

	GM_CharacterBackpackView.s_enableCheckSelectedMotion = isOn

	GMController.instance:dispatchEvent(GMEvent.CharacterBackpackView_EnableCheckMotionOnSelect, isOn)
end

return GM_CharacterBackpackView
