-- chunkname: @modules/logic/rouge2/map/view/band/Rouge2_BandRecruitHeroItem.lua

module("modules.logic.rouge2.map.view.band.Rouge2_BandRecruitHeroItem", package.seeall)

local Rouge2_BandRecruitHeroItem = class("Rouge2_BandRecruitHeroItem", ListScrollCell)

function Rouge2_BandRecruitHeroItem:init(go)
	self.go = go
	self._simageHeroIcon = gohelper.findChildSingleImage(self.go, "hero/#image_heroicon")
	self._txtName = gohelper.findChildText(self.go, "hero/#txt_Name")
	self._scrollDesc = gohelper.findChild(self.go, "#scroll_dec"):GetComponent(typeof(ZProj.LimitedScrollRect))
	self._txtDesc = gohelper.findChildText(self.go, "#scroll_dec/Viewport/Content/txt_desc")
	self._goSelect = gohelper.findChild(self.go, "#go_Select")
	self._goRecruit = gohelper.findChild(self.go, "bottom/#go_zhaomu")
	self._goRemove = gohelper.findChild(self.go, "bottom/#go_huishou")
	self._btnRecruit = gohelper.findChildButtonWithAudio(self.go, "bottom/#btn_zhaomu", AudioEnum.Rouge2.RecruitBand)
	self._btnRemove = gohelper.findChildButtonWithAudio(self.go, "bottom/#btn_huishou", AudioEnum.Rouge2.FireBandMember)
	self._btnClick = gohelper.getClickWithDefaultAudio(self.go)
	self._btnClick2 = gohelper.getClickWithDefaultAudio(self._txtDesc.gameObject)
	self._goCostList = gohelper.findChild(self.go, "bottom/rongliang")
	self._goCostPoint = gohelper.findChild(self.go, "bottom/rongliang/point")
	self._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.go)
	self._animator = gohelper.onceAddComponent(self.go, gohelper.Type_Animator)

	SkillHelper.addHyperLinkClick(self._txtDesc)
end

function Rouge2_BandRecruitHeroItem:addEventListeners()
	self._btnRemove:AddClickListener(self._btnRemoveOnClick, self)
	self._btnRecruit:AddClickListener(self._btnRecruitOnClick, self)
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
	self._btnClick2:AddClickListener(self._btnClickOnClick, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.OnSelectBandFireHero, self._onSelectFireHero, self)
end

function Rouge2_BandRecruitHeroItem:removeEventListeners()
	self._btnRemove:RemoveClickListener()
	self._btnRecruit:RemoveClickListener()
	self._btnClick:RemoveClickListener()
	self._btnClick2:RemoveClickListener()
end

function Rouge2_BandRecruitHeroItem:_btnRemoveOnClick()
	local isRecruit = Rouge2_BandMemberListModel.instance:isBandRecruit(self._bandId)

	if not isRecruit then
		return
	end

	GameUtil.setActiveUIBlock("Rouge2_BandRecruitHeroItem", true, false)
	self.playAnim(self, "close", self._sendRpc2RemoveBandMember, self)
end

function Rouge2_BandRecruitHeroItem:_sendRpc2RemoveBandMember()
	GameUtil.setActiveUIBlock("Rouge2_BandRecruitHeroItem", false, true)
	Rouge2_Rpc.instance:sendRouge2RemoveBandMemberRequest({
		self._bandId
	})
end

function Rouge2_BandRecruitHeroItem:_btnRecruitOnClick()
	local isRecruit = Rouge2_BandMemberListModel.instance:isBandRecruit(self._bandId)

	if isRecruit then
		return
	end

	local allCost = Rouge2_BandMemberListModel.instance:getCurBandCost()

	if allCost + self._cost > Rouge2_MapConfig.instance:getMaxBandCost() then
		GameFacade.showToast(ToastEnum.Rouge2BandCost)

		return
	end

	GameUtil.setActiveUIBlock("Rouge2_BandRecruitHeroItem", true, false)
	self.playAnim(self, "close", self._sendRpc2RecruitBandMember, self)
end

function Rouge2_BandRecruitHeroItem:_sendRpc2RecruitBandMember()
	GameUtil.setActiveUIBlock("Rouge2_BandRecruitHeroItem", false, true)
	Rouge2_BandMemberListModel.instance:selectFireHero(nil)
	Rouge2_Rpc.instance:sendRouge2SelectBandMemberRequest({
		self._bandId
	})
end

function Rouge2_BandRecruitHeroItem:_btnClickOnClick()
	local isSelect = Rouge2_BandMemberListModel.instance:isSelectFireHero(self._index)

	if isSelect then
		return
	end

	Rouge2_BandMemberListModel.instance:selectFireHero(self._index)
end

function Rouge2_BandRecruitHeroItem:onUpdateMO(bandCo, index, goParentScroll, isNewFire)
	if not gohelper.isNil(goParentScroll) then
		self._scrollDesc.parentGameObject = goParentScroll
	end

	if self._isClose then
		if isNewFire then
			self:playAnim("open")
		else
			self._animator.enabled = true

			self._animator:Play("open", 0, 1)
		end
	end

	self._index = index
	self._bandCo = bandCo
	self._bandId = bandCo and bandCo.id
	self._cost = self._bandCo and self._bandCo.cost
	self._isSelect = Rouge2_BandMemberListModel.instance:isSelectFireHero(self._index)

	self:refreshUI()
end

function Rouge2_BandRecruitHeroItem:refreshUI()
	self._txtName.text = self._bandCo and self._bandCo.name
	self._txtDesc.text = self._bandCo and SkillHelper.buildDesc(self._bandCo.desc)

	Rouge2_IconHelper.setBandHeroIcon(self._bandId, self._simageHeroIcon)
	gohelper.CreateNumObjList(self._goCostList, self._goCostPoint, self._cost)
	self:refreshSelectUI()
end

function Rouge2_BandRecruitHeroItem:refreshSelectUI()
	local isRecruit = Rouge2_BandMemberListModel.instance:isBandRecruit(self._bandId)

	gohelper.setActive(self._goRemove, isRecruit)
	gohelper.setActive(self._goRecruit.gameObject, not isRecruit)
	gohelper.setActive(self._btnRemove.gameObject, isRecruit and self._isSelect)
	gohelper.setActive(self._btnRecruit.gameObject, not isRecruit and self._isSelect)
	gohelper.setActive(self._goSelect, self._isSelect)
end

function Rouge2_BandRecruitHeroItem:_onSelectFireHero(index)
	self._isSelect = index == self._index or self._index == -1

	self:refreshSelectUI()
end

function Rouge2_BandRecruitHeroItem:playAnim(animName, callback, callbackObj)
	self._animatorPlayer:Play(animName, callback or self._defaultPlayAnimCallback, callbackObj or self)

	self._isClose = animName == "close"
end

function Rouge2_BandRecruitHeroItem:_defaultPlayAnimCallback()
	return
end

function Rouge2_BandRecruitHeroItem:onDestroy()
	GameUtil.setActiveUIBlock("Rouge2_BandRecruitHeroItem", false, true)
	self._simageHeroIcon:UnLoadImage()
end

return Rouge2_BandRecruitHeroItem
