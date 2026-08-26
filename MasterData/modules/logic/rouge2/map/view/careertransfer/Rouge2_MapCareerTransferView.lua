-- chunkname: @modules/logic/rouge2/map/view/careertransfer/Rouge2_MapCareerTransferView.lua

module("modules.logic.rouge2.map.view.careertransfer.Rouge2_MapCareerTransferView", package.seeall)

local Rouge2_MapCareerTransferView = class("Rouge2_MapCareerTransferView", BaseView)

function Rouge2_MapCareerTransferView:onInitView()
	self._goRoot = gohelper.findChild(self.viewGO, "#go_Root")
	self._scrollCareerList = gohelper.findChildScrollRect(self.viewGO, "#go_Root/#scroll_CareerList")
	self._goCareerContent = gohelper.findChild(self.viewGO, "#go_Root/#scroll_CareerList/Viewport/Content")
	self._goCareerItem = gohelper.findChild(self.viewGO, "#go_Root/#scroll_CareerList/Viewport/Content/#go_CareerItem")
	self._goContainer = gohelper.findChild(self.viewGO, "#go_Root/#go_Container")
	self._txtName = gohelper.findChildText(self.viewGO, "#go_Root/#go_Container/#txt_Name")
	self._txtDesc = gohelper.findChildText(self.viewGO, "#go_Root/#go_Container/#txt_Desc")
	self._txtNewPassiveSkillDesc = gohelper.findChildText(self.viewGO, "#go_Root/#go_Container/NewPassiveSkill/Viewport/Content/#txt_NewPassiveSkillDesc")
	self._goAttribute = gohelper.findChild(self.viewGO, "#go_Root/#go_Container/#go_Attribute")
	self._goRecommendAttrList = gohelper.findChild(self.viewGO, "#go_Root/#go_Container/recommendAttr/#go_RecommendAttrList")
	self._goRecommendAttrItem = gohelper.findChild(self.viewGO, "#go_Root/#go_Container/recommendAttr/#go_RecommendAttrList/#go_RecommendAttrItem")
	self._goRecommendTeamList = gohelper.findChild(self.viewGO, "#go_Root/#go_Container/recommendTeam/#go_RecommendTeamList")
	self._goRecommendTeamItem = gohelper.findChild(self.viewGO, "#go_Root/#go_Container/recommendTeam/#go_RecommendTeamList/#go_RecommendTeamItem")
	self._goDifficultyList = gohelper.findChild(self.viewGO, "#go_Root/#go_Container/difficulty/#go_DifficultyList")
	self._goDifficultyItem = gohelper.findChild(self.viewGO, "#go_Root/#go_Container/difficulty/#go_DifficultyList/#go_DifficultyItem")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_MapCareerTransferView:addEvents()
	return
end

function Rouge2_MapCareerTransferView:removeEvents()
	return
end

function Rouge2_MapCareerTransferView:_editableInitView()
	self.addEventCb(self, Rouge2_MapController.instance, Rouge2_MapEvent.onSelectTransferCareer, self._onSelectTransferCareer, self)
end

function Rouge2_MapCareerTransferView:onUpdateParam()
	return
end

function Rouge2_MapCareerTransferView:onOpen()
	local careerId = Rouge2_Model.instance:getCareerId()
	local transferCareerConfigList = Rouge2_CareerConfig.instance:mainCareerId2TransferCareerConfigs(careerId) or {}
	local defaultSelectCareer = transferCareerConfigList and transferCareerConfigList[1]

	gohelper.CreateObjList(self, self._refreshTransferCareerItem, transferCareerConfigList, self._goCareerContent, self._goCareerItem, Rouge2_MapCareerTransferListItem)
	Rouge2_MapController.instance:dispatchEvent(Rouge2_MapEvent.onSelectTransferCareer, defaultSelectCareer)
end

function Rouge2_MapCareerTransferView:_refreshTransferCareerItem(careerItem, careerCo, index)
	careerItem:onUpdateMO(careerCo)
end

function Rouge2_MapCareerTransferView:_onSelectTransferCareer(careerCo)
	self._txtName.text = careerCo.name
	self._txtDesc.text = careerCo.careerTransferDesc
	self._txtNewPassiveSkillDesc.text = careerCo.passiveSkillBrief

	if not careerCo.difficulty then
		gohelper.CreateNumObjList(self._goDifficultyList, self._goDifficultyItem, careerCo.difficulty)

		local recommendAttrIdList = Rouge2_CareerConfig.instance:getCareerRecommendAttrList(careerCo.id)

		gohelper.CreateObjList(self, self._refreshRecommendAttrItem, recommendAttrIdList, self._goRecommendAttrList, self._goRecommendAttrItem)
	end
end

function Rouge2_MapCareerTransferView:_refreshRecommendAttrItem(obj, attrId, index)
	local imageAttr = gohelper.findChildImage(obj, "image_RecommendAttr")

	Rouge2_IconHelper.setAttributeIcon(attrId, imageAttr)
end

function Rouge2_MapCareerTransferView:_refreshRecommendTeamItem(obj, recommendTeam, index)
	local txtRecommendTeam = gohelper.findChildText(obj, "txt_RecommendTeam")

	txtRecommendTeam.text = recommendTeam
end

function Rouge2_MapCareerTransferView:onClose()
	return
end

function Rouge2_MapCareerTransferView:onDestroyView()
	return
end

return Rouge2_MapCareerTransferView
