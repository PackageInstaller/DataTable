-- chunkname: @modules/logic/gm/view/GM_SummonHeroDetailView.lua

module("modules.logic.gm.view.GM_SummonHeroDetailView", package.seeall)

local GM_SummonHeroDetailView = class("GM_SummonHeroDetailView", BaseView)
local sf = string.format
local kYellow = "#FFFF00"

function GM_SummonHeroDetailView.register()
	GM_SummonHeroDetailView.SummonHeroDetailView_register(SummonHeroDetailView)
end

function GM_SummonHeroDetailView.SummonHeroDetailView_register(T)
	GMMinusModel.instance:saveOriginalFunc(T, "_editableInitView")
	GMMinusModel.instance:saveOriginalFunc(T, "addEvents")
	GMMinusModel.instance:saveOriginalFunc(T, "removeEvents")
	GMMinusModel.instance:saveOriginalFunc(T, "_refreshHero")

	function T:_editableInitView(...)
		GMMinusModel.instance:callOriginalSelfFunc(self, "_editableInitView", ...)
		GMMinusModel.instance:addBtnGM(self)
	end

	function T:addEvents(...)
		GMMinusModel.instance:callOriginalSelfFunc(self, "addEvents", ...)
		GMMinusModel.instance:btnGM_AddClickListener(self)
		GM_SummonHeroDetailViewContainer.addEvents(self)
	end

	function T:removeEvents(...)
		GMMinusModel.instance:callOriginalSelfFunc(self, "removeEvents", ...)
		GMMinusModel.instance:btnGM_RemoveClickListener(self)
		GM_SummonHeroDetailViewContainer.removeEvents(self)
	end

	function T._refreshHero(selfObj, ...)
		GMMinusModel.instance:callOriginalSelfFunc(selfObj, "_refreshHero", ...)

		if not GM_SummonHeroDetailView.s_ShowAllTabId then
			return
		end

		local heroId = selfObj._heroId
		local skinId = selfObj._skinId
		local heroConfig = HeroConfig.instance:getHeroCO(heroId)
		local skinConfig = SkinConfig.instance:getSkinCo(skinId)

		if skinConfig then
			selfObj._txtnameen.text = heroConfig.nameEng .. sf(" (skinId: %s)", gohelper.getRichColorText(skinId, kYellow))
		end

		selfObj._txtname.text = heroConfig.name .. gohelper.getRichColorText(heroId, kYellow)
	end

	function T._gm_showAllTabIdUpdate(selfObj)
		selfObj:_refreshUI()
	end
end

function GM_SummonHeroDetailView:onInitView()
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "btnClose")
	self._item1Toggle = gohelper.findChildToggle(self.viewGO, "viewport/content/item1/Toggle")
end

function GM_SummonHeroDetailView:addEvents()
	self._btnClose:AddClickListener(self.closeThis, self)
	self._item1Toggle:AddOnValueChanged(self._onItem1ToggleValueChanged, self)
end

function GM_SummonHeroDetailView:removeEvents()
	self._btnClose:RemoveClickListener()
	self._item1Toggle:RemoveOnValueChanged()
end

function GM_SummonHeroDetailView:onOpen()
	self:_refreshItem1()
end

function GM_SummonHeroDetailView:onDestroyView()
	return
end

GM_SummonHeroDetailView.s_ShowAllTabId = false

function GM_SummonHeroDetailView:_refreshItem1()
	self._item1Toggle.isOn = GM_SummonHeroDetailView.s_ShowAllTabId
end

function GM_SummonHeroDetailView:_onItem1ToggleValueChanged()
	local isOn = self._item1Toggle.isOn

	GM_SummonHeroDetailView.s_ShowAllTabId = isOn

	GMController.instance:dispatchEvent(GMEvent.SummonHeroDetailView_ShowAllTabIdUpdate, isOn)
end

return GM_SummonHeroDetailView
