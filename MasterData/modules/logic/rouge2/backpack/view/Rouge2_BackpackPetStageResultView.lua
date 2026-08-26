-- chunkname: @modules/logic/rouge2/backpack/view/Rouge2_BackpackPetStageResultView.lua

module("modules.logic.rouge2.backpack.view.Rouge2_BackpackPetStageResultView", package.seeall)

local Rouge2_BackpackPetStageResultView = class("Rouge2_BackpackPetStageResultView", BaseView)

Rouge2_BackpackPetStageResultView.DelayPlayTransformAudio_1 = 0
Rouge2_BackpackPetStageResultView.DelayPlayTransformAudio_2 = 1

function Rouge2_BackpackPetStageResultView:onInitView()
	self._goRoot = gohelper.findChild(self.viewGO, "#go_Root")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#go_Root/#btn_Close")
	self._goUp = gohelper.findChild(self.viewGO, "#go_Root/#go_Up")
	self._goReset = gohelper.findChild(self.viewGO, "#go_Root/#go_Reset")
	self._goPreStage = gohelper.findChild(self.viewGO, "#go_Root/#go_PreStage")
	self._simagePreIcon = gohelper.findChildSingleImage(self.viewGO, "#go_Root/#go_PreStage/#simage_PreIcon")
	self._txtPreName = gohelper.findChildText(self.viewGO, "#go_Root/#go_PreStage/#txt_PreName")
	self._goCurStage = gohelper.findChild(self.viewGO, "#go_Root/#go_CurStage")
	self._simageCurIcon = gohelper.findChildSingleImage(self.viewGO, "#go_Root/#go_CurStage/#simage_CurIcon")
	self._txtCurName = gohelper.findChildText(self.viewGO, "#go_Root/#go_CurStage/#txt_CurName")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Rouge2_BackpackPetStageResultView:addEvents()
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
end

function Rouge2_BackpackPetStageResultView:removeEvents()
	self._btnClose:RemoveClickListener()
end

function Rouge2_BackpackPetStageResultView:_btnCloseOnClick()
	self:closeThis()
end

function Rouge2_BackpackPetStageResultView:_editableInitView()
	UIBlockMgrExtend.CircleMvDelay = 3
end

function Rouge2_BackpackPetStageResultView:onUpdateParam()
	return
end

function Rouge2_BackpackPetStageResultView:onOpen()
	self._preTalentId = self.viewParam and self.viewParam.preTalentId
	self._curTalentId = self.viewParam and self.viewParam.curTalentId
	self._preTalentCo = Rouge2_CareerConfig.instance:getTalentConfig(self._preTalentId)
	self._curTalentCo = Rouge2_CareerConfig.instance:getTalentConfig(self._curTalentId)

	if self._preTalentCo then
		self._preTalentStage = self._preTalentCo.stage or 0
	end

	if self._curTalentCo then
		self._curTalentStage = self._curTalentCo.stage or 0
	end

	self._isUp = self._curTalentStage > self._preTalentStage

	gohelper.setActive(self._goUp, self._isUp)
	gohelper.setActive(self._goReset, not self._isUp)

	self._txtPreName.text = self._preTalentCo and self._preTalentCo.name
	self._txtCurName.text = self._curTalentCo and self._curTalentCo.name

	Rouge2_IconHelper.setSummonerTalentStageIcon(self._preTalentId, self._simagePreIcon)
	Rouge2_IconHelper.setSummonerTalentStageIcon(self._curTalentId, self._simageCurIcon)
	TaskDispatcher.runDelay(self.triggerTalentAudio, self, Rouge2_BackpackPetStageResultView.DelayPlayTransformAudio_1)
	TaskDispatcher.runDelay(self.triggerTalentAudio2, self, Rouge2_BackpackPetStageResultView.DelayPlayTransformAudio_2)
end

function Rouge2_BackpackPetStageResultView:triggerTalentAudio()
	self:_triggerAudio(AudioEnum.Rouge2.TransformTalent)
end

function Rouge2_BackpackPetStageResultView:triggerTalentAudio2()
	self:_triggerAudio(AudioEnum.Rouge2.TransformTalent2)
end

function Rouge2_BackpackPetStageResultView:_triggerAudio(audioId)
	if not audioId or audioId == 0 then
		return
	end

	AudioMgr.instance:trigger(audioId)
end

function Rouge2_BackpackPetStageResultView:onOpenFinish()
	UIBlockMgrExtend.CircleMvDelay = nil
end

function Rouge2_BackpackPetStageResultView:onClose()
	TaskDispatcher.cancelTask(self.triggerTalentAudio, self)
	TaskDispatcher.cancelTask(self.triggerTalentAudio2, self)
end

function Rouge2_BackpackPetStageResultView:onDestroyView()
	self._simagePreIcon:UnLoadImage()
	self._simageCurIcon:UnLoadImage()
end

return Rouge2_BackpackPetStageResultView
