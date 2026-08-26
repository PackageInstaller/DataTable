-- chunkname: @modules/logic/survival/view/map/SurvivalInitTeamViewContainer.lua

module("modules.logic.survival.view.map.SurvivalInitTeamViewContainer", package.seeall)

local SurvivalInitTeamViewContainer = class("SurvivalInitTeamViewContainer", BaseViewContainer)
local ViewProcess = {
	SelectMap = 1,
	Preview = 2
}
local ViewProcessToIndex = {}

for k, v in pairs(ViewProcess) do
	ViewProcessToIndex[v] = k
end

function SurvivalInitTeamViewContainer:buildViews()
	self._mapSelectView = SurvivalMapSelectView.New("Panel/#go_Map")
	self._previewTeamView = SurvivalPreviewTeamView.New("Panel/#go_Overview")

	return {
		self._mapSelectView,
		self._previewTeamView,
		TabViewGroup.New(1, "#go_lefttop")
	}
end

function SurvivalInitTeamViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			self.navigateView
		}
	end
end

function SurvivalInitTeamViewContainer:preStep()
	self._curProcess = self._curProcess - 1

	if ViewProcessToIndex[self._curProcess] then
		self:updateViewShow()
	else
		self:closeThis()
	end
end

function SurvivalInitTeamViewContainer:nextStep()
	self._curProcess = self._curProcess + 1

	if ViewProcessToIndex[self._curProcess] then
		self:updateViewShow()
	else
		self._curProcess = self._curProcess - 1

		local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
		local mapId = SurvivalMapModel.instance:getSelectMapId()
		local dayMode = SurvivalMapModel.instance.dayMode

		ViewMgr.instance:openView(ViewName.SurvivalShopView, {
			shopMo = weekInfo.preExploreShop,
			mapId = mapId,
			dayMode = dayMode
		})
	end
end

function SurvivalInitTeamViewContainer:onContainerInit()
	self._lights = self:getUserDataTb_()
	self._viewAnim = gohelper.findChildAnim(self.viewGO, "")
	self._animWeight = gohelper.findChildAnim(self.viewGO, "Panel/Weight")
	self._txtWeight = gohelper.findChildTextMesh(self.viewGO, "Panel/Weight/#txt_WeightNum")
	self._curProcess = ViewProcess.SelectMap

	self:updateViewShow()
	self.addEventCb(self, GuideController.instance, GuideEvent.StartGuideStep, self._onFinishGuideStep, self)
end

function SurvivalInitTeamViewContainer:updateViewShow()
	if self._curProcess == ViewProcess.SelectMap then
		AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_wenming_page)
	else
		AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_general_1)
	end

	self._previewTeamView:setIsShow(self._curProcess == ViewProcess.Preview)
	gohelper.setActive(self._animWeight, self._curProcess ~= ViewProcess.SelectMap)
	SurvivalController.instance:dispatchEvent(SurvivalEvent.GuideWaitInitViewTab, tostring(self._curProcess))
end

function SurvivalInitTeamViewContainer:_onFinishGuideStep()
	TaskDispatcher.runDelay(self._delayProcessEvent, self, 0)
end

function SurvivalInitTeamViewContainer:_delayProcessEvent()
	SurvivalController.instance:dispatchEvent(SurvivalEvent.GuideWaitInitViewTab, tostring(self._curProcess))
end

function SurvivalInitTeamViewContainer:setWeightNum()
	local weekMo = SurvivalShelterModel.instance:getWeekInfo()

	self._txtWeight.text = weekMo:getDerivedAttrFinalValue(SurvivalEnum.DerivedAttr.Weight)
end

function SurvivalInitTeamViewContainer:playAnim(animName)
	self._viewAnim:Play(animName, 0, 0)
end

function SurvivalInitTeamViewContainer:onContainerClose()
	self.removeEventCb(self, GuideController.instance, GuideEvent.StartGuideStep, self._onFinishGuideStep, self)
	SurvivalInitTeamViewContainer.super.onContainerClose(self)
end

return SurvivalInitTeamViewContainer
