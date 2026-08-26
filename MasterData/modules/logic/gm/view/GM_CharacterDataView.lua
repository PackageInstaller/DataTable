-- chunkname: @modules/logic/gm/view/GM_CharacterDataView.lua

module("modules.logic.gm.view.GM_CharacterDataView", package.seeall)

local GM_CharacterDataView = class("GM_CharacterDataView")

function GM_CharacterDataView.register()
	GM_CharacterDataView.CharacterDataVoiceView_register(CharacterDataVoiceView)
	GM_CharacterDataView.CharacterVoiceItem_register(CharacterVoiceItem)
end

function GM_CharacterDataView.CharacterDataVoiceView_register(T)
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
		GM_CharacterDataVoiceViewContainer.addEvents(self)
	end

	function T:removeEvents(...)
		GMMinusModel.instance:callOriginalSelfFunc(self, "removeEvents", ...)
		GMMinusModel.instance:btnGM_RemoveClickListener(self)
		GM_CharacterDataVoiceViewContainer.removeEvents(self)
	end

	function T._gm_showAllTabIdUpdate(selfObj)
		selfObj:_refreshVoice()
	end
end

function GM_CharacterDataView.CharacterVoiceItem_register(T)
	GMMinusModel.instance:saveOriginalFunc(T, "_refreshItem")

	function T._refreshItem(selfObj, ...)
		GMMinusModel.instance:callOriginalSelfFunc(selfObj, "_refreshItem", ...)

		if not GM_CharacterDataVoiceView.s_ShowAllTabId then
			return
		end

		local mo = selfObj._mo
		local id = mo.id

		selfObj._txtvoicename.text = tostring(id) .. " " .. mo.name
	end
end

return GM_CharacterDataView
