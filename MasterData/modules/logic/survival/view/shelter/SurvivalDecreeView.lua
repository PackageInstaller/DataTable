-- chunkname: @modules/logic/survival/view/shelter/SurvivalDecreeView.lua

module("modules.logic.survival.view.shelter.SurvivalDecreeView", package.seeall)

local SurvivalDecreeView = class("SurvivalDecreeView", BaseView)

function SurvivalDecreeView:onInitView()
	self.goLayout = gohelper.findChild(self.viewGO, "#go_Leader/LayoutGroup")
	self.layout = self.goLayout:GetComponent(gohelper.Type_HorizontalLayoutGroup)
	self.itemList = {}
	self.goInfoRoot = gohelper.findChild(self.viewGO, "Left/go_info")
end

function SurvivalDecreeView:addEvents()
	self.addEventCb(self, SurvivalController.instance, SurvivalEvent.OnShelterBagUpdate, self.onShelterBagUpdate, self)
	self.addEventCb(self, SurvivalController.instance, SurvivalEvent.OnBuildingInfoUpdate, self.onBuildingInfoUpdate, self)
	self.addEventCb(self, SurvivalController.instance, SurvivalEvent.OnDecreeDataUpdate, self.onDecreeDataUpdate, self)
end

function SurvivalDecreeView:removeEvents()
	self.removeEventCb(self, SurvivalController.instance, SurvivalEvent.OnBuildingInfoUpdate, self.onBuildingInfoUpdate, self)
	self.removeEventCb(self, SurvivalController.instance, SurvivalEvent.OnShelterBagUpdate, self.onShelterBagUpdate, self)
	self.removeEventCb(self, SurvivalController.instance, SurvivalEvent.OnDecreeDataUpdate, self.onDecreeDataUpdate, self)
end

function SurvivalDecreeView:onShelterBagUpdate()
	self:refreshInfoView()
end

function SurvivalDecreeView:onBuildingInfoUpdate()
	self:refreshInfoView()
end

function SurvivalDecreeView:onDecreeDataUpdate()
	self:refreshView()
end

function SurvivalDecreeView:onOpen()
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_general_2)
	self:refreshView()
	self:playOpenAnim()
end

function SurvivalDecreeView:refreshView()
	local itemCount = self:getItemCount()

	for i = 1, itemCount do
		local item = self:getItem(i)

		item:updateItem(i)
	end

	self:refreshInfoView()
end

function SurvivalDecreeView:getItemCount()
	local maxCount = 2
	local count = 0
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local buildingInfo = weekInfo:getBuildingInfoByBuildType(SurvivalEnum.BuildingType.Decree)

	if buildingInfo then
		for i = maxCount, 1, -1 do
			local buildConfig = SurvivalConfig.instance:getBuildingConfig(buildingInfo.buildingId, i, true)

			if buildConfig then
				count = i

				break
			end
		end
	end

	return count
end

function SurvivalDecreeView:getItem(index)
	local item = self.itemList[index]

	if not item then
		local go = self.viewContainer:getResInst(self.viewContainer:getSetting().otherRes.itemRes, self.goLayout, tostring(index))

		item = MonoHelper.addNoUpdateLuaComOnceToGo(go, SurvivalDecreeItem)
		self.itemList[index] = item
	end

	return item
end

function SurvivalDecreeView:playOpenAnim()
	ZProj.UGUIHelper.RebuildLayout(self.goLayout.transform)

	self.layout.enabled = false

	for i, v in ipairs(self.itemList) do
		gohelper.setActive(v.viewGO, false)
	end

	self._animIndex = 0

	TaskDispatcher.runRepeat(self._playItemOpenAnim, self, 0.1, #self.itemList)
end

function SurvivalDecreeView:_playItemOpenAnim()
	self._animIndex = self._animIndex + 1

	local item = self.itemList[self._animIndex]

	if item then
		gohelper.setActive(item.viewGO, true)
	end

	if self._animIndex >= #self.itemList then
		TaskDispatcher.cancelTask(self._playItemOpenAnim, self)
		TaskDispatcher.runDelay(self.playSwitchAnim, self, 0.4)
	end
end

function SurvivalDecreeView:playSwitchAnim()
	for i, v in ipairs(self.itemList) do
		v:playSwitchAnim()
	end
end

function SurvivalDecreeView:refreshInfoView()
	local weekInfo = SurvivalShelterModel.instance:getWeekInfo()
	local buildingInfo = weekInfo:getBuildingInfoByBuildType(SurvivalEnum.BuildingType.Decree)

	if not self.infoView then
		local prefabRes = self.viewContainer:getRes(self.viewContainer:getSetting().otherRes.infoView)

		self.infoView = ShelterManagerInfoView.getView(prefabRes, self.goInfoRoot, "infoView")
	end

	local param = {}

	param.showType = SurvivalEnum.InfoShowType.Building

	if buildingInfo then
		param.showId = buildingInfo.id or 0
	end

	self.infoView:refreshParam(param)
end

function SurvivalDecreeView:onClose()
	if PopupController.instance:isPause() then
		PopupController.instance:setPause(ViewName.SurvivalDecreeVoteView, false)
	end
end

function SurvivalDecreeView:onDestroyView()
	TaskDispatcher.cancelTask(self.playSwitchAnim, self)
	TaskDispatcher.cancelTask(self._playItemOpenAnim, self)
end

return SurvivalDecreeView
