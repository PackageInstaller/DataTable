-- chunkname: @modules/logic/versionactivity2_7/coopergarland/view/CooperGarlandLevelItem.lua

module("modules.logic.versionactivity2_7.coopergarland.view.CooperGarlandLevelItem", package.seeall)

local CooperGarlandLevelItem = class("CooperGarlandLevelItem", LuaCompBase)

function CooperGarlandLevelItem:init(go)
	self._go = go
	self._goType1 = gohelper.findChild(self._go, "#go_Type1")
	self._goIcon = gohelper.findChild(self._go, "#go_Type1/image_Stage")
	self._goType2 = gohelper.findChild(self._go, "#go_Type2")
	self._goSPIcon = gohelper.findChild(self._go, "#go_Type2/image_Stage")
	self._goStageItem = gohelper.findChild(self._go, "#go_Type1/#go_StageItem")
	self._imageStageItem = gohelper.findChildImage(self._go, "#go_Type1/#go_StageItem")
	self.spStageList = self:getUserDataTb_()
	self.spStageImageList = self:getUserDataTb_()

	local stageGO
	local gameIndex = 0

	repeat
		gameIndex = gameIndex + 1
		stageGO = gohelper.findChild(self._go, string.format("#go_Type2/#go_StageItem%s", gameIndex))

		if stageGO then
			self.spStageList[gameIndex] = stageGO
			self.spStageImageList[gameIndex] = stageGO:GetComponent(gohelper.Type_Image)
		end
	until gohelper.isNil(stageGO)

	self._goSelected = gohelper.findChild(self._go, "#go_Selected")
	self._goLocked = gohelper.findChild(self._go, "#go_Locked")
	self._goStar1 = gohelper.findChild(self._go, "Stars/#go_Star1")
	self._goStar2 = gohelper.findChild(self._go, "Stars/#go_Star2")
	self._goStar3 = gohelper.findChild(self._go, "Stars/#go_Star3")
	self._imageStageNum = gohelper.findChildImage(self._go, "#image_StageNum")
	self._txtStageName = gohelper.findChildText(self._go, "#txt_StageName")
	self._btnclick = gohelper.getClickWithDefaultAudio(self._go)
	self._animator = gohelper.findChildAnim(self._go, "")
end

function CooperGarlandLevelItem:addEventListeners()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self.addEventCb(self, CooperGarlandController.instance, CooperGarlandEvent.OnAct192InfoUpdate, self.refreshUI, self)
end

function CooperGarlandLevelItem:removeEventListeners()
	self._btnclick:RemoveClickListener()
	self.removeEventCb(self, CooperGarlandController.instance, CooperGarlandEvent.OnAct192InfoUpdate, self.refreshUI, self)
end

function CooperGarlandLevelItem:_btnclickOnClick()
	CooperGarlandController.instance:clickEpisode(self.actId, self.episodeId)
end

function CooperGarlandLevelItem:setData(actId, episodeId, index, gameIndex)
	self.actId = actId
	self.episodeId = episodeId
	self.index = index
	self.gameIndex = gameIndex

	self:setInfo()
	self:refreshUI()
end

function CooperGarlandLevelItem:setInfo()
	self._txtStageName.text = CooperGarlandConfig.instance:getEpisodeName(self.actId, self.episodeId)

	UISpriteSetMgr.instance:setV2a7CooperGarlandSprite(self._imageStageNum, string.format("v2a7_coopergarland_level_stage_0%s", self.index))

	if self.gameIndex then
		for i, stageGO in ipairs(self.spStageList) do
			gohelper.setActive(stageGO, self.gameIndex == i)
		end
	end

	gohelper.setActive(self._goType1, not self.gameIndex)
	gohelper.setActive(self._goType2, self.gameIndex)
end

function CooperGarlandLevelItem:refreshUI(animName)
	self:refreshStatus(animName)
	self:refreshSelected()
end

function CooperGarlandLevelItem:refreshStatus(animName)
	local isFinished = false
	local isUnlock = CooperGarlandModel.instance:isUnlockEpisode(self.actId, self.episodeId)

	if isUnlock then
		isFinished = CooperGarlandModel.instance:isFinishedEpisode(self.actId, self.episodeId)
	end

	gohelper.setActive(self._goStar1, not isFinished)
	gohelper.setActive(self._goStar2, isFinished and not self.gameIndex)
	gohelper.setActive(self._goStar3, isFinished and self.gameIndex)

	local stageColor = isUnlock and "#FFFFFF" or "#969696"

	if self.gameIndex then
		SLFramework.UGUI.GuiHelper.SetColor(self.spStageImageList[self.gameIndex], stageColor)
		ZProj.UGUIHelper.SetGrayscale(self.spStageList[self.gameIndex], not isUnlock)
		ZProj.UGUIHelper.SetGrayscale(self._goSPIcon, not isUnlock)
	else
		SLFramework.UGUI.GuiHelper.SetColor(self._imageStageItem, stageColor)
		ZProj.UGUIHelper.SetGrayscale(self._goStageItem, not isUnlock)
		ZProj.UGUIHelper.SetGrayscale(self._goIcon, not isUnlock)
	end

	SLFramework.UGUI.GuiHelper.SetColor(self._imageStageNum, isUnlock and "#FFFFFF" or "#C8C8C8")
	ZProj.UGUIHelper.SetGrayscale(self._imageStageNum.gameObject, not isUnlock)
	gohelper.setActive(self._goLocked, not isUnlock)
	self:_playAnim(animName)
end

function CooperGarlandLevelItem:_playAnim(animName)
	if string.nilorempty(animName) then
		return
	end

	self._animator:Play(animName, 0, 0)
end

function CooperGarlandLevelItem:refreshSelected()
	local isSelected = CooperGarlandModel.instance:isNewestEpisode(self.actId, self.episodeId)

	gohelper.setActive(self._goSelected, isSelected)
end

return CooperGarlandLevelItem
