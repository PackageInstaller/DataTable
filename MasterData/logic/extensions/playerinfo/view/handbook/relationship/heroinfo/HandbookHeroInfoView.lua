-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/playerinfo/view/handbook/relationship/heroinfo/HandbookHeroInfoView.lua

module("logic.extensions.playerinfo.view.handbook.relationship.heroinfo.HandbookHeroInfoView", package.seeall)

local M = class("HandbookHeroInfoView", CharacterMainSystemView)
local kViewUrls = {
	"ui/views/charactersystem/information/role_file_tips.prefab",
	"ui/views/charactersystem/information/role_voice_tips.prefab",
	"ui/views/charactersystem/information/role_expression_tips.prefab"
}
local kViewClass = {
	HandbookHeroDetailFragmentView,
	HandbookHeroPassInfoFragmentView,
	CharacterVoiceView,
	CharacterExpressionView
}
local kSystemOpenEnumList = {
	[3] = GameEnum.SystemEnum.RoleVoice,
	[4] = GameEnum.SystemEnum.RoleExpression
}

M.TabType = {
	Pass = 2,
	Info = 1,
	Voice = 3,
	Expression = 4
}

local titleData = {
	{
		subTitleName = "",
		titleName = lang("tip_handbook_hero_tab_1")
	},
	{
		subTitleName = "",
		titleName = lang("tip_handbook_hero_tab_2")
	},
	{
		subTitleName = "",
		titleName = lang("tip_handbook_hero_tab_3")
	},
	{
		subTitleName = "",
		titleName = lang("tip_handbook_hero_tab_4")
	}
}

M.PagePhotoData = {
	[M.TabType.Info] = {
		static = false,
		ignoreFadeIn = true,
		toggleMask = true,
		maskPos = 0.4,
		ignorePreFadeOut = true,
		viewSp = {
			[ViewName.CharacterAnchor] = {
				static = true,
				posOffset = Vector2.New(5.9, 0)
			}
		}
	},
	[M.TabType.Pass] = {
		toggleMask = false,
		static = false,
		ignoreFadeIn = true,
		ignorePreFadeOut = true
	},
	[M.TabType.Voice] = {
		toggleMask = false,
		static = false,
		ignoreFadeIn = true,
		ignorePreFadeOut = true
	},
	[M.TabType.Expression] = {
		toggleMask = false,
		static = false,
		ignoreFadeIn = true,
		ignorePreFadeOut = true
	}
}

function M:buildUI()
	M.super.buildUI(self)

	self._rawRole.material = nil
	self._cacheMaterialRawRole = nil
	self._txtTitleName = self:getText("1&title_view_-788888785")
	self._txtTitleName.text = "档案"

	goutil.setActive(self:getGo("1&title_view_1398742689"), false)

	local prefabSubViewRoleInfo = self:getPrefab(ResName.Charactersystem_role_information_panel)
	local goSubViewRoleInfo = goutil.cloneAndSetParent(prefabSubViewRoleInfo, self:getRectTransform("character_system_main_view_602072904"))

	self._subViewRoleInfo = Astral.LuaComponentContainer.Add(goSubViewRoleInfo, HandbookHeroInfoSubViewCell)

	self._subViewRoleInfo:buildUI()
	self._subViewRoleInfo:setShow(false)
	self._tabComp:clearActiveTabIndex()
	self._tabComp:setActiveTabIndexLst({
		1,
		2,
		3,
		4
	})
	self._tabComp:setSystemOpenLst({})

	for index, value in ipairs(titleData) do
		self._tabComp:setTabName(index, value.titleName)
	end
end

function M:initViewPage()
	local adapter = DynamicPagerAdapter.New()

	for index, _ in ipairs(kViewUrls) do
		adapter:registerView(kViewUrls[index], kViewClass[index])
	end

	self._viewPager = ViewPager.New(self._detailPanelGo)

	self._viewPager:setViewPresentor(self._viewPresentor)
	self._viewPager:setAdapter(adapter)
	self._viewPager:setPageChangeCallBack(self._onPageChange, self)
end

function M:destroyUI()
	M.super.destroyUI(self)
	self._subViewRoleInfo:destroyUI()

	self._subViewRoleInfo = nil
end

function M:bindEvents()
	self._btnReturn:AddClickListener(self._onClickReturn, self)
	self._subViewRoleInfo:bindEvents()
end

function M:unbindEvents()
	self._btnReturn:RemoveClickListener()
	self._subViewRoleInfo:unbindEvents()
end

function M:onEnter()
	local info = self:getFirstParam()

	self._heroId = info.heroId
	self._isLock = info.isLock

	self._subViewRoleInfo:refreshHeroInfo(self._heroId)

	local herodata = HeroDepotModel.instance:getHeroInfoByID(self._heroId)

	self._ownHero = herodata ~= nil and herodata ~= false

	if not self._ownHero then
		herodata = CharacterUtil.getPreviewHeroData(self._heroId)
	end

	HeroDepotModel.instance:setViewPageMo({
		index = 1,
		hero = herodata,
		list = {
			herodata
		}
	})

	self._otherPlayerUI = true

	M.super.onEnter(self)

	self._maxHeroCount = 1
	self._canDrag = false

	goutil.setActive(self._toggleTabControl:getTab(self.TabType.Voice).gameObject, self._ownHero)
	goutil.setActive(self._toggleTabControl:getTab(self.TabType.Expression).gameObject, self._ownHero)
	self._toggleTabControl:selectTab(info.index or self.TabType.Info)

	if GalleryModel.instance:getIsIdUnRead(GameEnum.UnlockTypeEnum.Hero, self._heroId) then
		HandbookController.instance:setHandbookTypIdRead(GameEnum.UnlockTypeEnum.Hero, self._heroId, true)
	end

	GlobalDispatcher:dispatchEvent(EventType.REFRESH_HERO_DEPOT_DATA)
	GlobalDispatcher:dispatchEvent(EventType.REFRESH_HERO_PHOTO)
end

function M:onExit()
	M.super.onExit(self)
	self:_unbindEvents()

	self._spinePosExpression = nil

	HeroDepotModel.instance:clearViewPageMo()
end

function M:_bindEvents()
	GlobalDispatcher:addEventListener(EventType.HERO_INFO_TAB_CHANGE, self._refreshRolePlot, self)
end

function M:_unbindEvents()
	GlobalDispatcher:removeEventListener(EventType.HERO_INFO_TAB_CHANGE, self._refreshRolePlot, self)
end

function M:getHeroId()
	return self._heroId
end

function M:_onClickReturn()
	if ViewMgr.instance:isOpen(ViewName.CharacterAnchor) then
		ViewMgr.instance:close(ViewName.CharacterAnchor)
		GlobalDispatcher:dispatchEvent(EventType.CHARACTER_DETAIL_STATUS_CHANGE, true)
		GlobalDispatcher:dispatchEvent(EventType.CHARACTER_MAINUI_SHOW_STATUS_CHANGE, true, true)
	else
		self:close()
		GlobalDispatcher:dispatchEvent(EventType.CHARACTER_MAINUI_SHOW_STATUS_CHANGE, true, true, false)
	end
end

function M:_onClickHome()
	return
end

function M:_refreshRolePlot(e, isInVoiceView, data)
	self._subViewRoleInfo:refreshRolePlot(e, isInVoiceView, data)
end

function M:getSpinLoadParamTable()
	local transform = self._spinePosExpression and self._subViewRoleInfo:getExpressionSpineTransform() or self._photoCenterPointGo.transform
	local cutCenterPos = {
		transform.anchoredPosition.x,
		transform.anchoredPosition.y,
		transform.localScale.x,
		transform.localScale.y
	}
	local paramTable = {}

	paramTable.photo = self._photoUnit
	paramTable.heroId = self._heroData:getId()
	paramTable.modelId = self._heroData:getModelId()
	paramTable.iconType = self._spinePosExpression and IconType.CharaterBust or IconType.CharacterSystem
	paramTable.cutCenterPos = cutCenterPos
	paramTable.isShowEgg = true
	paramTable.showShadow = true
	paramTable.needIgnore = true
	paramTable.useOriginPos = false
	paramTable.needTweenScale = true

	return paramTable
end

function M:_onPageChange(index)
	self._tabIndex = index

	self._subViewRoleInfo:refreshRolePlot(nil, false)
	self:updateRoleMaterial(index)
	self:showRoleInfoSubView(index)
	self:changeSpinePos(index)
	self:updateBg(index)
end

function M:updateRoleMaterial(index)
	if index == M.TabType.Info then
		self._rawRole.material = self._characterBlurMat
	else
		self._rawRole.material = nil
	end
end

function M:updateTitleName(index)
	self._txtTitleName.text = titleData[index].titleName
end

function M:updateBg(powerLv)
	local index = self._tabIndex

	if index == self.TabType.Info then
		self:setBgPhoto("1601001_1", false)
	else
		local path = GameUrl.getBigBgUrlByPrefix("charactersystem/authority_copy", string.format("bg_authority2_%d", index))

		self:setBgPhoto(path, true)
	end
end

function M:showRoleInfoSubView(index)
	if index == self.TabType.Info then
		self._subViewRoleInfo:setShow(false)
	else
		self._subViewRoleInfo:setShow(true)
	end
end

function M:changeSpinePos(index)
	local spinePosExpression = index == self.TabType.Expression
	local needReflash = false

	if self._spinePosExpression == nil or self._spinePosExpression ~= spinePosExpression then
		needReflash = true
		self._spinePosExpression = spinePosExpression
	end

	if needReflash then
		local paramTable = self:getSpinLoadParamTable()
		local cutInfo = SpineCutShowLoader.getSpineLiHuiParam(paramTable)
		local localx, localy, scalex, scaley = cutInfo[1], cutInfo[2], cutInfo[3], cutInfo[4]
		local roleUnit = self._photoUnit:getUnit()

		roleUnit.go.transform:DOKill(false)

		local orgPosX = Astral.TransformUtil.GetLocalPosX(roleUnit.go.transform)
		local orgPosY = Astral.TransformUtil.GetLocalPosY(roleUnit.go.transform)
		local samePos = math.floor(orgPosX * 100) == math.floor(localx * 100)

		if samePos and math.floor(orgPosY * 100) == math.floor(localy * 100) then
			samePos = false
		end

		if samePos then
			return
		end

		roleUnit.go.transform:DOScale(scalex, 0.25):SetEase(DG.Tweening.Ease.Linear)
		roleUnit.go.transform:DOLocalMoveX(localx, 0.25):SetEase(DG.Tweening.Ease.Linear)
		roleUnit.go.transform:DOLocalMoveY(localy, 0.25):SetEase(DG.Tweening.Ease.Linear)
	end
end

function M:_updateCharacterScale(tabIndex)
	M.super._updateCharacterScale(self, tabIndex)
end

function M:_updateCharacterOffset(tabIndex, heroChange, spineEnter, next)
	M.super._updateCharacterOffset(self, tabIndex, heroChange, spineEnter, next)
end

return M
