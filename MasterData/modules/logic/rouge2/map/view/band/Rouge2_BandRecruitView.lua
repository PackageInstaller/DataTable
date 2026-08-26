-- chunkname: @modules/logic/rouge2/map/view/band/Rouge2_BandRecruitView.lua

module("modules.logic.rouge2.map.view.band.Rouge2_BandRecruitView", package.seeall)

local Rouge2_BandRecruitView = class("Rouge2_BandRecruitView", BaseView)

function Rouge2_BandRecruitView:onInitView()
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_click")
	self._golayout = gohelper.findChild(self.viewGO, "layout")
	self._goselect = gohelper.findChild(self.viewGO, "layout/#go_select")
	self._gopos = gohelper.findChild(self.viewGO, "layout/#go_select/#go_pos")
	self._btnshouqi = gohelper.findChildButtonWithAudio(self.viewGO, "layout/#go_select/#btn_shouqi")
	self._goContent = gohelper.findChild(self.viewGO, "bottom/#go_has/scroll_hero/Viewport/Content")
	self._goheroitem = gohelper.findChild(self.viewGO, "bottom/#go_has/scroll_hero/Viewport/Content/#go_heroitem")
	self._scrollView = gohelper.findChildScrollRect(self.viewGO, "layout/scroll_view")
	self._gotopleft = gohelper.findChild(self.viewGO, "#go_topleft")
	self._goempty = gohelper.findChild(self.viewGO, "bottom/#go_empty")
	self._gohas = gohelper.findChild(self.viewGO, "bottom/#go_has")
	self._gomaxcost = gohelper.findChild(self.viewGO, "bottom/#go_maxcost")
	self._gocostpoint = gohelper.findChild(self.viewGO, "bottom/#go_maxcost/#go_costpoint")
	self._goFireEmpty = gohelper.findChild(self.viewGO, "layout/#go_FireEmpty")
	self._btnExit = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Exit")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_BandRecruitView:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self._btnshouqi:AddClickListener(self._btnshouqiOnClick, self)
	self._btnExit:AddClickListener(self._btnExitOnClick, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.OnSelectBandMember, self._onSelectBandMember, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onUpdateMapInfo, self._onUpdateMapInfo, self)
end

function Rouge2_BandRecruitView:removeEvents()
	self._btnclick:RemoveClickListener()
	self._btnshouqi:RemoveClickListener()
	self._btnExit:RemoveClickListener()
end

function Rouge2_BandRecruitView:_btnclickOnClick()
	Rouge2_BandMemberListModel.instance:selectFireHero(nil)
	Rouge2_BandMemberListModel.instance:selectMember(nil)
end

function Rouge2_BandRecruitView:_btnshouqiOnClick()
	Rouge2_BandMemberListModel.instance:selectMember(nil)
end

function Rouge2_BandRecruitView:_btnExitOnClick()
	self.viewContainer:overrideCloseCallback()
end

function Rouge2_BandRecruitView:_editableInitView()
	self._maxBandCost = Rouge2_MapConfig.instance:getMaxBandCost()
	self._goFireContent = gohelper.findChild(self.viewGO, "layout/scroll_view/Viewport/Content")
	self._goFireItem = self:getResInst(self.viewContainer._viewSetting.otherRes[1], self._goFireContent, "#go_fireItem")

	gohelper.setActive(self._goFireItem, false)

	self._goScrollView = self._scrollView.gameObject
	self._layoutAnimator = gohelper.onceAddComponent(self._golayout, gohelper.Type_Animator)
end

function Rouge2_BandRecruitView:onUpdateParam()
	return
end

function Rouge2_BandRecruitView:onOpen()
	if self.viewParam then
		Rouge2_BandMemberListModel.instance:initInfo(self.viewParam)
		self:refreshUI()
	end
end

function Rouge2_BandRecruitView:refreshUI()
	self:refreshBandCost()
	self:refresBandMemberList()
	self:refreshFireHeroList()
	self:refreshSelectMember()
end

function Rouge2_BandRecruitView:refreshBandCost()
	self._curBandCost = Rouge2_BandMemberListModel.instance:getCurBandCost()

	gohelper.setActive(self._goempty, self._curBandCost <= 0)
	gohelper.setActive(self._gohas, self._curBandCost > 0)
	gohelper.CreateNumObjList(self._gomaxcost, self._gocostpoint, self._maxBandCost, self._refreshCostPoint, self)
end

function Rouge2_BandRecruitView:_refreshCostPoint(obj, index)
	local golight = gohelper.findChild(obj, "light")
	local godark = gohelper.findChild(obj, "dark")

	gohelper.setActive(golight, index <= self._curBandCost)
	gohelper.setActive(godark, index > self._curBandCost)
end

function Rouge2_BandRecruitView:refresBandMemberList()
	self._preBandMemberNum = self._curBandMemberNum
	self._bandMemberList = Rouge2_BandMemberListModel.instance:getBandMemberList()

	if self._bandMemberList then
		self._curBandMemberNum = #self._bandMemberList or 0
	end

	self._preBandMemberNum = self._preBandMemberNum or self._curBandMemberNum

	gohelper.CreateObjList(self, self._refreshBandMemberItem, self._bandMemberList, self._goContent, self._goheroitem, Rouge2_BandMemberHeroItem)
end

function Rouge2_BandRecruitView:_refreshBandMemberItem(memberItem, bandCo, index)
	local isNew = index > self._preBandMemberNum

	memberItem:onUpdateMO(bandCo, index, isNew)
end

function Rouge2_BandRecruitView:refreshFireHeroList()
	self._fireHeroList = Rouge2_BandMemberListModel.instance:getFireHeroList()
	self._preFireHeroNum = self._fireHeroNum or 0

	if self._fireHeroList then
		self._fireHeroNum = #self._fireHeroList or 0
	end

	self._isFireEmpty = self._fireHeroNum <= 0

	gohelper.setActive(self._goFireEmpty, self._isFireEmpty)
	gohelper.CreateObjList(self, self._refreshFireHerotem, self._fireHeroList, self._goFireContent, self._goFireItem, Rouge2_BandRecruitHeroItem)
end

function Rouge2_BandRecruitView:_refreshFireHerotem(fireHeroItem, bandCo, index)
	local isNewFire = index > self._preFireHeroNum

	fireHeroItem:onUpdateMO(bandCo, index, self._goScrollView, isNewFire)
end

function Rouge2_BandRecruitView:refreshSelectMember()
	local var_17_0 = self._selectMemberIndex

	if self._selectMemberIndex then
		var_17_0 = self._bandMemberList

		if self._bandMemberList then
			local selectMemberCo = self._bandMemberList[self._selectMemberIndex]

			gohelper.setActive(self._goselect, selectMemberCo ~= nil)

			if not selectMemberCo then
				self._selectMemberIndex = nil

				return
			end

			if not self._selectMemberItem then
				local goMemberItem = self:getResInst(self.viewContainer._viewSetting.otherRes[1], self._gopos)

				self._selectMemberItem = MonoHelper.addNoUpdateLuaComOnceToGo(goMemberItem, Rouge2_BandRecruitHeroItem)
			end

			self._selectMemberItem:onUpdateMO(selectMemberCo, -1)

			self._selectMemberItem._isSelect = true

			self._selectMemberItem:refreshSelectUI()

			if not self._preSelectMemberIndex then
				self._selectMemberItem:playAnim("open")
			end
		end
	end
end

function Rouge2_BandRecruitView:_onSelectBandMember(memberIndex)
	self._preSelectMemberIndex = self._selectMemberIndex
	self._selectMemberIndex = memberIndex

	self:refreshSelectMember()

	if not self._preSelectMemberIndex and self._selectMemberIndex then
		self._layoutAnimator:Play("uncollapse", 0, 0)
	elseif self._preSelectMemberIndex and not self._selectMemberIndex then
		self._layoutAnimator:Play("collapse", 0, 0)
	end
end

function Rouge2_BandRecruitView:_onUpdateMapInfo()
	local interactiveType = Rouge2_MapModel.instance:getCurInteractType()
	local interactiveJson = Rouge2_MapModel.instance:getCurInteractiveJson()

	if interactiveType ~= Rouge2_MapEnum.InteractType.Band or not interactiveJson then
		self:closeThis()

		return
	end

	Rouge2_BandMemberListModel.instance:updateInfo(interactiveJson.bandSet)
	self:refreshUI()
end

function Rouge2_BandRecruitView:onClose()
	return
end

function Rouge2_BandRecruitView:onDestroyView()
	return
end

return Rouge2_BandRecruitView
