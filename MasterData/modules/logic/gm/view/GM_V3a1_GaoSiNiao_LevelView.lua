-- chunkname: @modules/logic/gm/view/GM_V3a1_GaoSiNiao_LevelView.lua

module("modules.logic.gm.view.GM_V3a1_GaoSiNiao_LevelView", package.seeall)

local GM_V3a1_GaoSiNiao_LevelView = class("GM_V3a1_GaoSiNiao_LevelView", BaseView)
local kYellow = "#FFFF00"

function GM_V3a1_GaoSiNiao_LevelView.register()
	GM_V3a1_GaoSiNiao_LevelView.V3a1_GaoSiNiao_LevelView_register(V3a1_GaoSiNiao_LevelView)
	GM_V3a1_GaoSiNiao_LevelView.V3a1_GaoSiNiao_LevelViewStageItem_register(V3a1_GaoSiNiao_LevelViewStageItem)
end

function GM_V3a1_GaoSiNiao_LevelView.V3a1_GaoSiNiao_LevelView_register(T)
	GMMinusModel.instance:saveOriginalFunc(T, "_editableInitView")
	GMMinusModel.instance:saveOriginalFunc(T, "addEvents")
	GMMinusModel.instance:saveOriginalFunc(T, "removeEvents")

	function T:_editableInitView(...)
		GMMinusModel.instance:callOriginalSelfFunc(self, "_editableInitView", ...)
		GMMinusModel.instance:addBtnGM(self)

		self._gm_txt_Endless = gohelper.findChildText(self._btnEndlessGo, "txt_Endless")
	end

	function T:addEvents(...)
		GMMinusModel.instance:callOriginalSelfFunc(self, "addEvents", ...)
		GMMinusModel.instance:btnGM_AddClickListener(self)
		GM_V3a1_GaoSiNiao_LevelViewContainer.addEvents(self)
	end

	function T:removeEvents(...)
		GMMinusModel.instance:callOriginalSelfFunc(self, "removeEvents", ...)
		GMMinusModel.instance:btnGM_RemoveClickListener(self)
		GM_V3a1_GaoSiNiao_LevelViewContainer.removeEvents(self)
	end

	function T._gm_showAllTabIdUpdate(selfObj)
		selfObj._gm_txt_Endless.text = luaLang("p_v3a1_gaosiniao_level_txt_Endless")

		selfObj:_refresh()

		if not GM_V3a1_GaoSiNiao_LevelView.s_ShowAllTabId then
			return
		end

		local episodeCO = selfObj:_spCO()

		if episodeCO then
			local episodeId = episodeCO.episodeId

			selfObj._gm_txt_Endless.text = gohelper.getRichColorText(episodeId, kYellow)
		end
	end

	function T._gm_enableEditModeOnSelect(selfObj, isOn)
		GM_V3a1_GaoSiNiao_GameView.s_isEditMode = not not isOn
	end
end

function GM_V3a1_GaoSiNiao_LevelView.V3a1_GaoSiNiao_LevelViewStageItem_register(T)
	GMMinusModel.instance:saveOriginalFunc(T, "setData")

	function T.setData(selfObj, ...)
		GMMinusModel.instance:callOriginalSelfFunc(selfObj, "setData", ...)

		if not GM_V3a1_GaoSiNiao_LevelView.s_ShowAllTabId then
			return
		end

		selfObj._txtstagename.text = gohelper.getRichColorText(selfObj:episodeId(), kYellow)
	end
end

function GM_V3a1_GaoSiNiao_LevelView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "btnClose")
	self._item1Toggle = gohelper.findChildToggle(self.viewGO, "viewport/content/item1/Toggle")
	self._item2Toggle = gohelper.findChildToggle(self.viewGO, "viewport/content/item2/Toggle")
end

function GM_V3a1_GaoSiNiao_LevelView:addEvents()
	self._btnClose:AddClickListener(self.closeThis, self)
	self._item1Toggle:AddOnValueChanged(self._onItem1ToggleValueChanged, self)
	self._item2Toggle:AddOnValueChanged(self._onItem2ToggleValueChanged, self)
end

function GM_V3a1_GaoSiNiao_LevelView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._item1Toggle:RemoveOnValueChanged()
	self._item2Toggle:RemoveOnValueChanged()
end

function GM_V3a1_GaoSiNiao_LevelView:onUpdateParam()
	self:refresh()
end

function GM_V3a1_GaoSiNiao_LevelView:onOpen()
	self:onUpdateParam()
end

function GM_V3a1_GaoSiNiao_LevelView:refresh()
	self:_refreshItem1()
	self:_refreshItem2()
end

function GM_V3a1_GaoSiNiao_LevelView:onDestroyView()
	return
end

GM_V3a1_GaoSiNiao_LevelView.s_ShowAllTabId = false

function GM_V3a1_GaoSiNiao_LevelView:_refreshItem1()
	self._item1Toggle.isOn = GM_V3a1_GaoSiNiao_LevelView.s_ShowAllTabId
end

function GM_V3a1_GaoSiNiao_LevelView:_onItem1ToggleValueChanged()
	local isOn = self._item1Toggle.isOn

	GM_V3a1_GaoSiNiao_LevelView.s_ShowAllTabId = isOn

	GMController.instance:dispatchEvent(GMEvent.V3a1_GaoSiNiao_LevelView_ShowAllTabIdUpdate, isOn)
end

GM_V3a1_GaoSiNiao_LevelView.s_EnableEditModeOnSelect = false

function GM_V3a1_GaoSiNiao_LevelView:_refreshItem2()
	local isOn = GM_V3a1_GaoSiNiao_LevelView.s_EnableEditModeOnSelect

	GM_V3a1_GaoSiNiao_GameView.s_isEditMode = not not isOn
	self._item2Toggle.isOn = isOn
end

function GM_V3a1_GaoSiNiao_LevelView:_onItem2ToggleValueChanged()
	local isOn = self._item2Toggle.isOn

	GM_V3a1_GaoSiNiao_LevelView.s_EnableEditModeOnSelect = isOn

	GMController.instance:dispatchEvent(GMEvent.V3a1_GaoSiNiao_LevelView_EnableEditModeOnSelect, isOn)
end

return GM_V3a1_GaoSiNiao_LevelView
