-- chunkname: @modules/logic/gm/view/GM_SummonADView.lua

module("modules.logic.gm.view.GM_SummonADView", package.seeall)

local GM_SummonADView = class("GM_SummonADView")

function GM_SummonADView.register()
	GM_SummonADView.SummonMainView_register(SummonMainView)
	GM_SummonADView.SummonMainCategoryItem_register(SummonMainCategoryItem)
end

function GM_SummonADView.SummonMainView_register(T)
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
		GM_SummonMainViewContainer.addEvents(self)
	end

	function T:removeEvents(...)
		GMMinusModel.instance:callOriginalSelfFunc(self, "removeEvents", ...)
		GMMinusModel.instance:btnGM_RemoveClickListener(self)
		GM_SummonMainViewContainer.removeEvents(self)
	end

	function T._gm_showAllTabIdUpdate()
		SummonController.instance:dispatchEvent(SummonEvent.onSummonInfoGot)
	end
end

function GM_SummonADView.SummonMainCategoryItem_register(T)
	GMMinusModel.instance:saveOriginalFunc(T, "_initCurrentComponents")

	function T._initCurrentComponents(selfObj, ...)
		GMMinusModel.instance:callOriginalSelfFunc(selfObj, "_initCurrentComponents", ...)

		if not GM_SummonMainView.s_ShowAllTabId then
			return
		end

		local poolCfg = selfObj._mo.originConf
		local showDesc = gohelper.getRichColorText("=====> id:" .. tostring(poolCfg.id), "#FFFF00")

		selfObj._txtnameselect.text = showDesc
		selfObj._txtname.text = showDesc
		selfObj._txtnameen.text = showDesc
		selfObj._txtnameenselect.text = showDesc
	end
end

return GM_SummonADView
