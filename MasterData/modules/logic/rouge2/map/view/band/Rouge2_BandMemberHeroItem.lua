-- chunkname: @modules/logic/rouge2/map/view/band/Rouge2_BandMemberHeroItem.lua

module("modules.logic.rouge2.map.view.band.Rouge2_BandMemberHeroItem", package.seeall)

local Rouge2_BandMemberHeroItem = class("Rouge2_BandMemberHeroItem", ListScrollCell)

function Rouge2_BandMemberHeroItem:init(go)
	self.go = go
	self._simageHeroIcon = gohelper.findChildSingleImage(self.go, "heroicon")
	self._goSelect = gohelper.findChild(self.go, "#go_select")
	self._btnClick = gohelper.findChildButtonWithAudio(self.go, "btn_click")
	self._goCostList = gohelper.findChild(self.go, "rongliang")
	self._goCostPoint = gohelper.findChild(self.go, "rongliang/point")
end

function Rouge2_BandMemberHeroItem:addEventListeners()
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.OnSelectBandMember, self._onSelectBandMember, self)
end

function Rouge2_BandMemberHeroItem:removeEventListeners()
	self._btnClick:RemoveClickListener()
end

function Rouge2_BandMemberHeroItem:_btnClickOnClick()
	local isSelect = Rouge2_BandMemberListModel.instance:isSelectMember(self._index)

	if isSelect then
		return
	end

	Rouge2_BandMemberListModel.instance:selectMember(self._index)
end

function Rouge2_BandMemberHeroItem:onUpdateMO(bandCo, index, isNew)
	self._index = index
	self._bandCo = bandCo
	self._bandId = bandCo and bandCo.id
	self._cost = self._bandCo and self._bandCo.cost

	self:refreshUI()

	if isNew then
		AudioMgr.instance:trigger(AudioEnum.Rouge2.HasRecruitNewBand)
	end
end

function Rouge2_BandMemberHeroItem:refreshUI()
	Rouge2_IconHelper.setBandHeroIcon(self._bandId, self._simageHeroIcon)
	gohelper.CreateNumObjList(self._goCostList, self._goCostPoint, self._cost)
	self:refreshSelectUI()
end

function Rouge2_BandMemberHeroItem:refreshSelectUI()
	local isSelect = Rouge2_BandMemberListModel.instance:isSelectMember(self._index)

	gohelper.setActive(self._goSelect, isSelect)
end

function Rouge2_BandMemberHeroItem:_onSelectBandMember(index)
	self:refreshSelectUI()
end

function Rouge2_BandMemberHeroItem:onDestroy()
	self._simageHeroIcon:UnLoadImage()
end

return Rouge2_BandMemberHeroItem
