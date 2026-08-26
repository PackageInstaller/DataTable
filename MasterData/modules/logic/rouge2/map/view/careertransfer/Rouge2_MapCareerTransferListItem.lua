-- chunkname: @modules/logic/rouge2/map/view/careertransfer/Rouge2_MapCareerTransferListItem.lua

module("modules.logic.rouge2.map.view.careertransfer.Rouge2_MapCareerTransferListItem", package.seeall)

local Rouge2_MapCareerTransferListItem = class("Rouge2_MapCareerTransferListItem", LuaCompBase)

function Rouge2_MapCareerTransferListItem:init(go)
	self.go = go
	self._imageIcon = gohelper.findChild(self.go, "image_Icon")
	self._txtName = gohelper.findChildText(self.go, "txt_Name")
	self._goLocked = gohelper.findChild(self.go, "go_Locked")
	self._goSelected = gohelper.findChild(self.go, "go_Selected")
	self._btnClick = gohelper.findChildButtonWithAudio(self.go, "btn_Click")

	gohelper.setActive(self._goSelected, false)
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onSelectTransferCareer, self._onSelectTransferCareer, self)
end

function Rouge2_MapCareerTransferListItem:addEventListeners()
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
end

function Rouge2_MapCareerTransferListItem:removeEventListeners()
	self._btnClick:RemoveClickListener()
end

function Rouge2_MapCareerTransferListItem:_btnClickOnClick()
	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onSelectTransferCareer, self._careerCo)
end

function Rouge2_MapCareerTransferListItem:onUpdateMO(careerCo)
	self._careerCo = careerCo
	self._careerId = careerCo.id
	self._txtName.text = self._careerCo and self._careerCo.name

	Rouge2_IconHelper.setCareerIcon(self._careerId, self._imageIcon)
end

function Rouge2_MapCareerTransferListItem:_onSelectTransferCareer(careerCo)
	gohelper.setActive(self._goSelected, self._careerId == careerCo.id)
end

return Rouge2_MapCareerTransferListItem
