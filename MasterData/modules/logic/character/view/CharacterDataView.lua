-- chunkname: @modules/logic/character/view/CharacterDataView.lua

module("modules.logic.character.view.CharacterDataView", package.seeall)

local CharacterDataView = class("CharacterDataView", BaseView)

function CharacterDataView:onInitView()
	self._scrollchildview = gohelper.findChildScrollRect(self.viewGO, "#scroll_childview")
	self._content1 = gohelper.findChild(self.viewGO, "content1")
	self._content2 = gohelper.findChild(self.viewGO, "content/content2")
	self._content3 = gohelper.findChild(self.viewGO, "content/content3")
	self._page1go = gohelper.findChild(self.viewGO, "catagory/page1")
	self._page2go = gohelper.findChild(self.viewGO, "catagory/page2")
	self._page3go = gohelper.findChild(self.viewGO, "catagory/page3")
	self._page4go = gohelper.findChild(self.viewGO, "catagory/page4")
	self._goculturereddot = gohelper.findChild(self.viewGO, "catagory/page4/#go_reddot")
	self._goitemreddot = gohelper.findChild(self.viewGO, "catagory/page3/#go_reddot")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CharacterDataView:addEvents()
	return
end

function CharacterDataView:removeEvents()
	return
end

function CharacterDataView:_editableInitView()
	self._page1click = SLFramework.UGUI.UIClickListener.Get(self._page1go)
	self._page2click = SLFramework.UGUI.UIClickListener.Get(self._page2go)
	self._page3click = SLFramework.UGUI.UIClickListener.Get(self._page3go)
	self._page4click = SLFramework.UGUI.UIClickListener.Get(self._page4go)

	self._page1click:AddClickListener(self._page1OnClick, self)
	self._page2click:AddClickListener(self._page2OnClick, self)
	self._page3click:AddClickListener(self._page3OnClick, self)
	self._page4click:AddClickListener(self._page4OnClick, self)

	self._pagenow = 1

	self.addEventCb(self, RedDotController.instance, RedDotEvent.RefreshClientCharacterDot, self.refreshRedDot, self)
end

function CharacterDataView:_page1OnClick()
	self:_selectPage(1)
end

function CharacterDataView:_page2OnClick()
	self:_selectPage(2)
end

function CharacterDataView:_page3OnClick()
	self:_selectPage(3)
end

function CharacterDataView:_page4OnClick()
	self:_selectPage(4)
end

function CharacterDataView:_selectPage(num)
	if num == self._pagenow then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_role_introduce_switch)
	self:_setNowPage(num)

	local preloadFunction

	if num == 2 then
		preloadFunction = module_views_preloader.CharacterDataVoiceView
	elseif num == 3 then
		preloadFunction = module_views_preloader.CharacterDataItemView
	elseif num == 4 then
		preloadFunction = module_views_preloader.CharacterDataCultureView
	end

	if preloadFunction then
		preloadFunction(function()
			self.viewContainer:switchTab(num)
		end)
	else
		self.viewContainer:switchTab(num)
	end
end

function CharacterDataView:_setNowPage(num)
	for i = 1, 4 do
		local goselected = gohelper.findChild(self.viewGO, "catagory/page" .. i .. "/#go_selected")
		local gounselected = gohelper.findChild(self.viewGO, "catagory/page" .. i .. "/#go_unselected")

		gohelper.setActive(goselected, i == num)
		gohelper.setActive(gounselected, i ~= num)
	end

	self._pagenow = num
end

function CharacterDataView:onUpdateParam()
	self:onOpen()
end

function CharacterDataView:onOpenFinish()
	local go = gohelper.findChild(ViewMgr.instance:getUIRoot(), "POPUP_SECOND")

	gohelper.addChild(go, self.viewGO)

	self._heroId = CharacterDataModel.instance:getCurHeroId()

	if self._heroId then
		local heroinfo = HeroModel.instance:getByHeroId(self._heroId)

		if heroinfo then
			::label_13_0::

			local skinCo = SkinConfig.instance:getSkinCo(heroinfo.skin)

			if not skinCo then
				return
			end

			local skinId = skinCo.id
			local config = skinId and lua_skin_ui_bloom.configDict[skinId]

			if config and config[CharacterVoiceEnum.UIBloomView.CharacterDataView] == 1 then
				PostProcessingMgr.instance:setUIBloom(true)
			end
		end
	end
end

function CharacterDataView:onOpen()
	UnityEngine.Shader.EnableKeyword("_TRANSVERSEALPHA_ON")

	if type(self.viewParam) == "table" then
		self.heroId = self.viewParam.heroId
		self.fromHandbookView = self.viewParam.fromHandbookView
	else
		self.heroId = self.viewParam
		self.fromHandbookView = false
	end

	CharacterDataModel.instance:setCurHeroId(self.heroId)
	self.addEventCb(self, CharacterController.instance, CharacterEvent.SelectPage, self._onSelectPage, self)
	self:refreshRedDot()
end

function CharacterDataView:_onSelectPage(page)
	self:_selectPage(page)
end

function CharacterDataView:refreshRedDot()
	local cultureRedDowShow = CharacterModel.instance:hasCultureRewardGet(self.heroId)

	gohelper.setActive(self._goculturereddot, cultureRedDowShow)

	local itemRedDowShow = CharacterModel.instance:hasItemRewardGet(self.heroId)

	gohelper.setActive(self._goitemreddot, itemRedDowShow)
end

function CharacterDataView:onClose()
	UnityEngine.Shader.DisableKeyword("_TRANSVERSEALPHA_ON")
	PostProcessingMgr.instance:setUIBloom(false)

	local go = gohelper.findChild(ViewMgr.instance:getUIRoot(), "POPUP_TOP")

	gohelper.addChild(go, self.viewGO)
end

function CharacterDataView:onDestroyView()
	self._page1click:RemoveClickListener()
	self._page2click:RemoveClickListener()
	self._page3click:RemoveClickListener()
	self._page4click:RemoveClickListener()
end

return CharacterDataView
