-- chunkname: @modules/logic/herogroup/view/HeroGroupRecommendCharacterItem.lua

module("modules.logic.herogroup.view.HeroGroupRecommendCharacterItem", package.seeall)

local HeroGroupRecommendCharacterItem = class("HeroGroupRecommendCharacterItem", ListScrollCell)

function HeroGroupRecommendCharacterItem:init(go)
	self._gounselectedbg = gohelper.findChild(go, "#go_info/#go_unselectedbg")
	self._gobeselectedbg = gohelper.findChild(go, "#go_info/#go_beselectedbg")
	self._txtcharactername = gohelper.findChildText(go, "#go_info/canvasgroup/#txt_charactername")
	self._txtrate = gohelper.findChildText(go, "#go_info/canvasgroup/#txt_rate")
	self._simagecharacter = gohelper.findChildSingleImage(go, "#go_info/canvasgroup/#simage_character")
	self._btnclick = gohelper.findChildButtonWithAudio(go, "#go_info/#btn_click")
	self._goinfo = gohelper.findChild(go, "#go_info")
	self._gonull = gohelper.findChild(go, "#go_null")
	self._txtrank = gohelper.findChildText(go, "#txt_rank")
	self._gomask = gohelper.findChild(go, "#go_info/#go_mask")
	self._anim = go:GetComponent(typeof(UnityEngine.Animator))
end

function HeroGroupRecommendCharacterItem:addEventListeners()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function HeroGroupRecommendCharacterItem:removeEventListeners()
	self._btnclick:RemoveClickListener()
end

function HeroGroupRecommendCharacterItem:_btnclickOnClick()
	if self._mo.isEmpty then
		return
	end

	if not self._isSelect then
		self._view:selectCell(self._index, true)
	end
end

function HeroGroupRecommendCharacterItem:onSelect(select)
	self._isSelect = select

	if self._isSelect and not HeroGroupRecommendGroupListModel.instance:isShowSampleMo(self._mo) then
		HeroGroupRecommendGroupListModel.instance:setGroupList(self._mo)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnClickRecommendCharacter)
	end

	if self._mo.isEmpty then
		return
	end

	gohelper.setActive(self._gounselectedbg, not self._isSelect)
	gohelper.setActive(self._gobeselectedbg, self._isSelect)

	local stateType = self:_getCurStateType()

	self:_setInfoShowByStateType(stateType)
end

HeroGroupRecommendCharacterItem.StateType = {
	UnSelectedUnOwner = 3,
	SelectedAndOwner = 2,
	SelectedUnOwner = 1,
	UnSelectedAndOwner = 4
}

function HeroGroupRecommendCharacterItem:_getCurStateType()
	local stateType
	local heroMO = HeroModel.instance:getByHeroId(self._mo.heroId)

	return not heroMO and (self._isSelect and HeroGroupRecommendCharacterItem.StateType.SelectedUnOwner or HeroGroupRecommendCharacterItem.StateType.UnSelectedUnOwner) or self._isSelect and HeroGroupRecommendCharacterItem.StateType.SelectedAndOwner or HeroGroupRecommendCharacterItem.StateType.UnSelectedAndOwner
end

function HeroGroupRecommendCharacterItem:_setInfoShowByStateType(stateType)
	if stateType == HeroGroupRecommendCharacterItem.StateType.SelectedUnOwner or stateType == HeroGroupRecommendCharacterItem.StateType.SelectedAndOwner then
		SLFramework.UGUI.GuiHelper.SetColor(self._txtcharactername, "#433A3A")
		ZProj.UGUIHelper.SetColorAlpha(self._txtcharactername, 1)
		SLFramework.UGUI.GuiHelper.SetColor(self._txtrate, "#433A3A")
		ZProj.UGUIHelper.SetColorAlpha(self._txtrate, 1)
		SLFramework.UGUI.GuiHelper.SetColor(self._txtrank, "#433A3A")
		ZProj.UGUIHelper.SetColorAlpha(self._txtrank, 0.4)

		self._txtcharactername.fontSize = 48
	elseif stateType == HeroGroupRecommendCharacterItem.StateType.UnSelectedUnOwner then
		SLFramework.UGUI.GuiHelper.SetColor(self._txtcharactername, "#979797")
		ZProj.UGUIHelper.SetColorAlpha(self._txtcharactername, 0.3)
		SLFramework.UGUI.GuiHelper.SetColor(self._txtrate, "#979797")
		ZProj.UGUIHelper.SetColorAlpha(self._txtrate, 0.3)
		SLFramework.UGUI.GuiHelper.SetColor(self._txtrank, "#73726F")
		ZProj.UGUIHelper.SetColorAlpha(self._txtrank, 0.15)

		self._txtcharactername.fontSize = 42
	else
		SLFramework.UGUI.GuiHelper.SetColor(self._txtcharactername, "#979797")
		ZProj.UGUIHelper.SetColorAlpha(self._txtcharactername, 1)
		SLFramework.UGUI.GuiHelper.SetColor(self._txtrate, "#979797")
		ZProj.UGUIHelper.SetColorAlpha(self._txtrate, 1)
		SLFramework.UGUI.GuiHelper.SetColor(self._txtrank, "#73726F")
		ZProj.UGUIHelper.SetColorAlpha(self._txtrank, 0.15)

		self._txtcharactername.fontSize = 42
	end

	gohelper.setActive(self._gomask, stateType == HeroGroupRecommendCharacterItem.StateType.UnSelectedUnOwner or stateType == HeroGroupRecommendCharacterItem.StateType.UnSelectedAndOwner)
end

function HeroGroupRecommendCharacterItem:onUpdateMO(mo)
	self._mo = mo

	gohelper.setActive(self._gonull, self._mo.isEmpty)
	gohelper.setActive(self._goinfo, not self._mo.isEmpty)

	self._txtrank.text = GameUtil.fillZeroInLeft(self._index, 2)

	if self._mo.isEmpty then
		SLFramework.UGUI.GuiHelper.SetColor(self._txtrank, "#73726F")
		ZProj.UGUIHelper.SetColorAlpha(self._txtrank, 0.15)
		gohelper.setActive(self._gounselectedbg, true)
		gohelper.setActive(self._gobeselectedbg, false)

		return
	end

	local heroConfig = HeroConfig.instance:getHeroCO(self._mo.heroId)

	self._txtcharactername.text = heroConfig.name
	self._txtrate.text = string.format("%s%%", math.floor(self._mo.rate * 10000) / 100)

	local skinConfig = SkinConfig.instance:getSkinCo(heroConfig.skinId)

	self._simagecharacter:LoadImage(ResUrl.getHeadIconSmall(skinConfig.headIcon))
end

function HeroGroupRecommendCharacterItem:getAnimator()
	return self._anim
end

function HeroGroupRecommendCharacterItem:onDestroy()
	self._simagecharacter:UnLoadImage()
end

return HeroGroupRecommendCharacterItem
