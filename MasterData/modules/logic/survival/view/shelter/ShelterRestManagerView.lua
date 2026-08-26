-- chunkname: @modules/logic/survival/view/shelter/ShelterRestManagerView.lua

module("modules.logic.survival.view.shelter.ShelterRestManagerView", package.seeall)

local ShelterRestManagerView = class("ShelterRestManagerView", BaseView)

function ShelterRestManagerView:onInitView()
	self.btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "btnclose")
	self.goRight = gohelper.findChild(self.viewGO, "Panel/Right")
	self.txtRest = gohelper.findChildTextMesh(self.viewGO, "Panel/Right/#go_Rest/Title/Layout/txt_Rest")
	self.txtMember = gohelper.findChildTextMesh(self.viewGO, "Panel/Right/#go_Rest/Title/Layout/#txt_MemberNum")
end

function ShelterRestManagerView:addEvents()
	self.addClickCb(self, self.btnClose, self.onClickClose, self)
	self.addEventCb(self, SurvivalController.instance, SurvivalEvent.OnBuildingInfoUpdate, self.onBuildingInfoUpdate, self)
end

function ShelterRestManagerView:removeEvents()
	self:removeClickCb(self.btnClose)
	self.removeEventCb(self, SurvivalController.instance, SurvivalEvent.OnBuildingInfoUpdate, self.onBuildingInfoUpdate, self)
end

function ShelterRestManagerView:onClickClose()
	self:closeThis()
end

function ShelterRestManagerView:onBuildingInfoUpdate()
	self:refreshView()
end

function ShelterRestManagerView:onClickGridItem(item)
	if not item.data then
		return
	end

	if SurvivalShelterNpcListModel.instance:setSelectNpcId(item.data.id) then
		self:refreshView()
	end
end

function ShelterRestManagerView:_dropHealthHero()
	SurvivalShelterRestListModel.instance:dropHealthHero(self.buildingInfo)
end

function ShelterRestManagerView:onOpen()
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_general_2)
	self:refreshParam()
	self:refreshView()
	UIBlockHelper.instance:startBlock(self.viewName, 0.4, self.viewName)
	TaskDispatcher.runDelay(self._dropHealthHero, self, 0.4)
end

function ShelterRestManagerView:refreshParam()
	self.buildingId = self.viewParam.buildingId

	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()

	self.buildingInfo = weekInfo:getBuildingInfo(self.buildingId)

	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnOpenBuildingView, self.buildingInfo:getBuildingType())
end

function ShelterRestManagerView:refreshView()
	if not self.buildingInfo then
		return
	end

	self:refreshList()
	self:refreshInfoView()
end

function ShelterRestManagerView:refreshList()
	local unBuild = self.buildingInfo.level == 0

	if unBuild or not self.buildingInfo:isEqualType(SurvivalEnum.BuildingType.Health) then
		gohelper.setActive(self.goRight, false)

		return
	end

	gohelper.setActive(self.goRight, true)
	SurvivalShelterRestListModel.instance:refreshList(self.buildingInfo)

	self.txtRest.text = self.buildingInfo.baseCo.name

	local heroNum = tabletool.len(self.buildingInfo.heros)
	local heroCount = self.buildingInfo:getAttr(SurvivalEnum.AttrType.LoungeRoleNum)

	self.txtMember.text = string.format("%s/%s", heroNum, heroCount)
end

function ShelterRestManagerView:refreshInfoView()
	if not self.infoView then
		local prefabRes = self.viewContainer:getRes(self.viewContainer:getSetting().otherRes.infoView)
		local parentGO = gohelper.findChild(self.viewGO, "Panel/go_manageinfo")

		self.infoView = ShelterManagerInfoView.getView(prefabRes, parentGO, "infoView")
	end

	local param = {}

	param.showType = SurvivalEnum.InfoShowType.Building
	param.showId = self.buildingId

	self.infoView:refreshParam(param)
end

function ShelterRestManagerView:onDestroyView()
	TaskDispatcher.cancelTask(self._dropHealthHero, self)
end

return ShelterRestManagerView
