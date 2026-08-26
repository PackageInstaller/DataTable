-- chunkname: @modules/logic/rouge2/backpack/view/Rouge2_BackpackTalentStageResetItem.lua

module("modules.logic.rouge2.backpack.view.Rouge2_BackpackTalentStageResetItem", package.seeall)

local Rouge2_BackpackTalentStageResetItem = class("Rouge2_BackpackTalentStageResetItem", LuaCompBase)

function Rouge2_BackpackTalentStageResetItem:init(go)
	self.go = go
	self._goUnlock = gohelper.findChild(self.go, "go_Unlock")
	self._txtPetName = gohelper.findChildText(self.go, "go_Unlock/txt_PetName")
	self._simagePetIcon1 = gohelper.findChildSingleImage(self.go, "go_Unlock/bg/simage_PetIcon")
	self._goLock = gohelper.findChild(self.go, "go_Lock")
	self._simagePetIcon2 = gohelper.findChildSingleImage(self.go, "go_Lock/bg/simage_PetIcon")
	self._goSelect = gohelper.findChild(self.go, "go_Select")
	self._btnClick = gohelper.findChildButtonWithAudio(self.go, "btn_Click", AudioEnum.Rouge2.SelectPetStage)

	gohelper.setActive(self._goSelect, false)
end

function Rouge2_BackpackTalentStageResetItem:addEventListeners()
	self._btnClick:AddClickListener(self._btnClickOnClick, self)
	self.addEventCb(self, Rouge2_Controller.instance, Rouge2_Event.OnUpdateRougeInfo, self._onUpdateRougeInfo, self)
	self.addEventCb(self, Rouge2_Controller.instance, Rouge2_Event.OnSelectTalentStage, self._onSelectTalentStage, self)
end

function Rouge2_BackpackTalentStageResetItem:removeEventListeners()
	self._btnClick:RemoveClickListener()
end

function Rouge2_BackpackTalentStageResetItem:_btnClickOnClick()
	if self._isSelect then
		return
	end

	if self._status ~= Rouge2_Enum.BagTalentStatus.Active then
		GameFacade.showToast(ToastEnum.Rouge2LockTalentStage)

		return
	end

	Rouge2_Controller.instance:dispatchEvent(Rouge2_Event.OnSelectTalentStage, self._talentId)
end

function Rouge2_BackpackTalentStageResetItem:onUpdateMO(talentId, index)
	self:refreshInfo(talentId)
	self:refreshStatus()
end

function Rouge2_BackpackTalentStageResetItem:refreshInfo(talentId)
	self._talentId = talentId
	self._talentCo = Rouge2_CareerConfig.instance:getTalentConfig(talentId)
	self._talentName = self._talentCo.name
end

function Rouge2_BackpackTalentStageResetItem:refreshStatus()
	self._status = Rouge2_BackpackModel.instance:getTalentStatus(self._talentId)

	self:refreshUI()
end

function Rouge2_BackpackTalentStageResetItem:refreshUI()
	self._txtPetName.text = self._talentName

	Rouge2_IconHelper.setSummonerTalentStageIcon(self._talentId, self._simagePetIcon1)
	Rouge2_IconHelper.setSummonerTalentStageIcon(self._talentId, self._simagePetIcon2)
	gohelper.setActive(self._goUnlock, self._status == Rouge2_Enum.BagTalentStatus.Active)
	gohelper.setActive(self._goLock, self._status ~= Rouge2_Enum.BagTalentStatus.Active)
end

function Rouge2_BackpackTalentStageResetItem:_onSelectTalentStage(talentId)
	self:onSelect(self._talentId == talentId)
end

function Rouge2_BackpackTalentStageResetItem:onSelect(isSelect)
	if self._isSelect == isSelect then
		return
	end

	self._isSelect = isSelect

	gohelper.setActive(self._goSelect, isSelect)
end

function Rouge2_BackpackTalentStageResetItem:_onUpdateRougeInfo()
	self:refreshStatus()
end

return Rouge2_BackpackTalentStageResetItem
