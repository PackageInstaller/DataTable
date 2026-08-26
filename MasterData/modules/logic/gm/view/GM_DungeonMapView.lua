-- chunkname: @modules/logic/gm/view/GM_DungeonMapView.lua

module("modules.logic.gm.view.GM_DungeonMapView", package.seeall)

local GM_DungeonMapView = class("GM_DungeonMapView", BaseView)

function GM_DungeonMapView.register()
	GM_DungeonMapView.DungeonMapView_register(DungeonMapView)
	GM_DungeonMapView.DungeonMapEpisodeItem_register(DungeonMapEpisodeItem)
end

function GM_DungeonMapView.DungeonMapView_register(T)
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
		GM_DungeonMapViewContainer.addEvents(self)
	end

	function T:removeEvents(...)
		GMMinusModel.instance:callOriginalSelfFunc(self, "removeEvents", ...)
		GMMinusModel.instance:btnGM_RemoveClickListener(self)
		GM_DungeonMapViewContainer.removeEvents(self)
	end

	function T:_gm_showAllTabIdUpdate()
		DungeonController.instance:dispatchEvent(DungeonEvent.OnUpdateDungeonInfo)
	end
end

function GM_DungeonMapView.DungeonMapEpisodeItem_register(T)
	GMMinusModel.instance:saveOriginalFunc(T, "onUpdateParam")

	function T.onUpdateParam(selfObj, ...)
		GMMinusModel.instance:callOriginalSelfFunc(selfObj, "onUpdateParam", ...)

		if GM_DungeonMapView.s_ShowAllTabId then
			local cfg = selfObj._config

			selfObj._txtsectionname.text = tostring(cfg.id) .. "\n" .. cfg.name
		end
	end
end

function GM_DungeonMapView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "btnClose")
	self._item1Toggle = gohelper.findChildToggle(self.viewGO, "viewport/content/item1/Toggle")
end

function GM_DungeonMapView:addEvents()
	self._btnClose:AddClickListener(self.closeThis, self)
	self._item1Toggle:AddOnValueChanged(self._onItem1ToggleValueChanged, self)
end

function GM_DungeonMapView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._item1Toggle:RemoveOnValueChanged()
end

function GM_DungeonMapView:onOpen()
	self:_refreshItem1()
end

function GM_DungeonMapView:onDestroyView()
	return
end

GM_DungeonMapView.s_ShowAllTabId = false

function GM_DungeonMapView:_refreshItem1()
	self._item1Toggle.isOn = GM_DungeonMapView.s_ShowAllTabId
end

function GM_DungeonMapView:_onItem1ToggleValueChanged()
	local isOn = self._item1Toggle.isOn

	GM_DungeonMapView.s_ShowAllTabId = isOn

	GMController.instance:dispatchEvent(GMEvent.DungeonMapView_ShowAllTabIdUpdate, isOn)
end

return GM_DungeonMapView
