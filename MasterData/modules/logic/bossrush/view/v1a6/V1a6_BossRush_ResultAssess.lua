-- chunkname: @modules/logic/bossrush/view/v1a6/V1a6_BossRush_ResultAssess.lua

module("modules.logic.bossrush.view.v1a6.V1a6_BossRush_ResultAssess", package.seeall)

local V1a6_BossRush_ResultAssess = class("V1a6_BossRush_ResultAssess", LuaCompBase)

function V1a6_BossRush_ResultAssess:onInitView()
	self._go3s1 = gohelper.findChild(self.viewGO, "3s")
	self._go4s1 = gohelper.findChild(self.viewGO, "4s")
	self._gocomplete = gohelper.findChild(self.viewGO, "#go_complete")
	self._goassess = gohelper.findChild(self.viewGO, "#go_assess")
	self._imageAssessIcon = gohelper.findChild(self.viewGO, "#go_assess/#image_AssessIcon")
	self._go3s2 = gohelper.findChild(self._goassess, "3s")
	self._go4s2 = gohelper.findChild(self._goassess, "4s")
	self._gocommon = gohelper.findChild(self._goassess, "common")
	self._goimagecomplete = gohelper.findChild(self.viewGO, "#go_complete/image_CompleteBG")
	self._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(self.viewGO)
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
	self._animationEvent = self.viewGO:GetComponent(gohelper.Type_AnimationEventWrap)
	self._animatorAssess = self._goassess:GetComponent(typeof(UnityEngine.Animator))

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a6_BossRush_ResultAssess:addEventListeners()
	self._animationEvent:AddEventListener(BossRushEnum.AnimEvtResultPanel.CompleteFinish, self._completeFinishCallback, self)
end

function V1a6_BossRush_ResultAssess:removeEventListeners()
	self._animationEvent:RemoveEventListener(BossRushEnum.AnimEvtResultPanel.CompleteFinish)
end

function V1a6_BossRush_ResultAssess:_editableInitView()
	self.layer4Gos = self:getUserDataTb_()

	table.insert(self.layer4Gos, gohelper.findChild(self.viewGO, "Layer4"))
	table.insert(self.layer4Gos, gohelper.findChild(self._goassess, "Layer4"))
	table.insert(self.layer4Gos, gohelper.findChild(self._goassess, "commonLayer4"))
	table.insert(self.layer4Gos, gohelper.findChild(self.viewGO, "#go_complete/image_CompleteBGLayer4"))
end

function V1a6_BossRush_ResultAssess:onUpdateParam()
	return
end

function V1a6_BossRush_ResultAssess:onOpen()
	return
end

function V1a6_BossRush_ResultAssess:onClose()
	return
end

function V1a6_BossRush_ResultAssess:onDestroyView()
	return
end

function V1a6_BossRush_ResultAssess:init(go)
	self.viewGO = go

	self:onInitView()

	local isSpecial = BossRushModel.instance:isSpecialLayerCurBattle()

	gohelper.setActive(self._goimagecomplete, not isSpecial)
	gohelper.setActive(self._goimagecompleteLayer4, isSpecial)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mane_post_1_6_survey)
end

function V1a6_BossRush_ResultAssess:playAnim(isEmpty, callback, callbackObj)
	self._isEmpty = isEmpty
	self._callback = {
		callback = callback,
		callbackObj = callbackObj
	}

	self._animatorPlayer:Play(BossRushEnum.V1a6_ResultAnimName.Open, self._openAnimCallback, self)
end

function V1a6_BossRush_ResultAssess:_openAnimCallback()
	if self._isEmpty then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mane_post_1_6_score)
	self._animatorPlayer:Play(BossRushEnum.V1a6_ResultAnimName.Close, self._closeAnimCallback, self)
	self._animatorAssess:Play(BossRushEnum.V1a6_ResultAnimName.Close)
end

function V1a6_BossRush_ResultAssess:_closeAnimCallback()
	if self._callback then
		self._callback.callback(self._callback.callbackObj)
	end
end

function V1a6_BossRush_ResultAssess:_completeFinishCallback()
	if self._isEmpty then
		self:_closeAnimCallback()
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mane_post_1_6_score)
		gohelper.setActive(self.viewGO, false)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mane_post_1_6_level)
	end
end

function V1a6_BossRush_ResultAssess:setData(stage, score, level, view, type)
	if view then
		local path = BossRushEnum.ResPath.v1a4_bossrush_result_assess
		local childGO = view:getResInst(path, self._imageAssessIcon.gameObject, "AssessIcon")

		self._assessItem = MonoHelper.addNoUpdateLuaComOnceToGo(childGO, V1a6_BossRush_AssessIcon)

		self._assessItem:setData(stage, score, type, type)
	end

	level = level or -1

	local is4S = level > BossRushEnum.ScoreLevel.S_AA
	local special = type == BossRushEnum.AssessType.Layer4

	gohelper.setActive(self._go4s1, not special and is4S)
	gohelper.setActive(self._go4s2, not special and is4S)
	gohelper.setActive(self._go3s1, not special and not is4S)
	gohelper.setActive(self._go3s2, not special and not is4S)
	gohelper.setActive(self._gocommon, not special)
end

function V1a6_BossRush_ResultAssess:refreshLayerGo(special)
	for _, go in pairs(self.layer4Gos) do
		gohelper.setActive(go, special)
	end
end

return V1a6_BossRush_ResultAssess
