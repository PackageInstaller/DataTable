-- chunkname: @modules/logic/versionactivity2_2/tianshinana/view/TianShiNaNaLevelView.lua

module("modules.logic.versionactivity2_2.tianshinana.view.TianShiNaNaLevelView", package.seeall)

local TianShiNaNaLevelView = class("TianShiNaNaLevelView", BaseView)

function TianShiNaNaLevelView:onInitView()
	self._btnReset = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_reset")
	self._animTips = gohelper.findChild(self.viewGO, "Top/Tips"):GetComponent(typeof(UnityEngine.Animator))
	self._txtRound = gohelper.findChildTextMesh(self.viewGO, "Top/Tips/image_TipsBG/#txt_round")
	self._sliderRound = gohelper.findChildSlider(self.viewGO, "Top/Tips/image_TipsBG/#slider_round")
	self._goTips2 = gohelper.findChild(self.viewGO, "Top/Tips2")
	self._txtTips2 = gohelper.findChildTextMesh(self.viewGO, "Top/Tips2/image_TipsBG/#txt_Tips")
	self._mainTarget = gohelper.findChild(self.viewGO, "TargetList/mainTarget")
	self._mainTargetDesc = gohelper.findChildTextMesh(self.viewGO, "TargetList/mainTarget/#txt_TargetDesc")
	self._mainTargetIcon = gohelper.findChild(self.viewGO, "TargetList/mainTarget/#go_TargetIcon")
	self._subTarget = gohelper.findChild(self.viewGO, "TargetList/subTarget")
	self._headTips = gohelper.findChild(self.viewGO, "#go_HeadTips")
	self._headTips1 = gohelper.findChild(self.viewGO, "#go_HeadTips/1")
	self._headTips2 = gohelper.findChild(self.viewGO, "#go_HeadTips/2")
end

function TianShiNaNaLevelView:addEvents()
	self._btnReset:AddClickListener(self._onResetClick, self)
	TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.RoundUpdate, self._refreshRound, self)
	TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.ResetScene, self._refreshRound, self)
	TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.StatuChange, self._onStatuChange, self)
	TianShiNaNaController.instance:registerCallback(TianShiNaNaEvent.WaitClickJumpRound, self._onClickJumpRound, self)
end

function TianShiNaNaLevelView:removeEvents()
	self._btnReset:RemoveClickListener()
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.RoundUpdate, self._refreshRound, self)
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.ResetScene, self._refreshRound, self)
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.StatuChange, self._onStatuChange, self)
	TianShiNaNaController.instance:unregisterCallback(TianShiNaNaEvent.WaitClickJumpRound, self._onClickJumpRound, self)
end

function TianShiNaNaLevelView:onOpen()
	GuideModel.instance:setFlag(GuideModel.GuideFlag.MaskUseMainCamera, 1)

	self._targetIcons = self:getUserDataTb_()

	local episodeCo = TianShiNaNaModel.instance.episodeCo
	local arr = string.split(episodeCo.conditionStr, "#")
	local len = #arr

	gohelper.setActive(self._subTarget, false)

	if len == 0 then
		gohelper.setActive(self._mainTarget, false)
	elseif len == 1 then
		gohelper.setActive(self._mainTarget, true)
	else
		gohelper.setActive(self._mainTarget, true)

		for i = 2, #arr do
			local go = gohelper.cloneInPlace(self._subTarget)

			gohelper.setActive(go, true)

			local text = gohelper.findChildTextMesh(go, "#txt_TargetDesc")
			local icon = gohelper.findChild(go, "#go_TargetIcon")

			text.text = arr[i]
			self._targetIcons[i] = icon

			ZProj.UGUIHelper.SetGrayFactor(icon, 1)
		end
	end

	self._mainTargetTxt = arr[1] or ""
	self._subTargetConditionTxts = string.split(episodeCo.subConditionStr, "|") or {}
	self._subTargetConditions = GameUtil.splitString2(episodeCo.subCondition, true) or {}
	self._conditions = not string.nilorempty(episodeCo.exStarCondition) and GameUtil.splitString2(episodeCo.exStarCondition, true) or {}

	ZProj.UGUIHelper.SetGrayFactor(self._mainTargetIcon, 1)
	self:_refreshRound()
end

function TianShiNaNaLevelView:_refreshRound()
	if not TianShiNaNaModel.instance.totalRound then
		local totalRound = 0
		local nowRound = totalRound - TianShiNaNaModel.instance.nowRound
		local isRoundAdd = not not (self._nowRound and nowRound + 1 == self._nowRound)

		self._nowRound = nowRound
		self._txtRound.text = string.format("<color=#e99b56>%d</color>/%d", nowRound, totalRound)

		self._sliderRound:SetValue(nowRound / totalRound)

		if TianShiNaNaModel.instance:isWaitClick() then
			self._txtTips2.text = luaLang("act167_cantplace")

			gohelper.setActive(self._goTips2, true)
			self:setHeadTips(true)
		end

		self:_refreshMainTarget()

		if isRoundAdd then
			self._animTips:Play("open", 0, 0)
		end
	end
end

function TianShiNaNaLevelView:_refreshMainTarget()
	local nowProgress = 0

	for index, arr in ipairs(self._subTargetConditions) do
		local isNoFinish = false

		for _, id in ipairs(arr) do
			if TianShiNaNaModel.instance.unitMos[id] then
				isNoFinish = true

				break
			end
		end

		if isNoFinish then
			nowProgress = index

			break
		end
	end

	if not self._mainTargetProgress then
		-- block empty
	elseif self._mainTargetProgress == nowProgress then
		return
	elseif nowProgress > self._mainTargetProgress then
		-- block empty
	end

	self._mainTargetProgress = nowProgress
	self._mainTargetDesc.text = nowProgress == 0 and self._mainTargetTxt or self._subTargetConditionTxts[nowProgress]
end

function TianShiNaNaLevelView:_onResetClick()
	if TianShiNaNaHelper.isBanOper() then
		return
	end

	MessageBoxController.instance:showMsgBox(MessageBoxIdDefine.Act167Reset, MsgBoxEnum.BoxType.Yes_No, self._sendReset, nil, nil, self)
end

function TianShiNaNaLevelView:_sendReset()
	Activity167Rpc.instance:sendAct167ReStartEpisodeRequest(VersionActivity2_2Enum.ActivityId.TianShiNaNa, TianShiNaNaModel.instance.episodeCo.id)
end

function TianShiNaNaLevelView:_onStatuChange(preStatu, nowStatu)
	if nowStatu == TianShiNaNaEnum.CurState.SelectDir then
		self._txtTips2.text = luaLang("act167_place")

		gohelper.setActive(self._goTips2, true)
		self:setHeadTips(true)
	elseif nowStatu == TianShiNaNaEnum.CurState.Rotate then
		self._txtTips2.text = luaLang("act167_slide")

		gohelper.setActive(self._goTips2, true)
		self:setHeadTips(true)
	else
		self:setHeadTips(false)
		gohelper.setActive(self._goTips2, false)
	end
end

function TianShiNaNaLevelView:_onClickJumpRound()
	self:setHeadTips(false)
	gohelper.setActive(self._goTips2, false)
end

function TianShiNaNaLevelView:setHeadTips(isShow)
	if isShow then
		gohelper.setActive(self._headTips, true)

		local nextCubeType = TianShiNaNaModel.instance:getNextCubeType()

		gohelper.setActive(self._headTips1, nextCubeType == 2)
		gohelper.setActive(self._headTips2, nextCubeType == 1)
	else
		gohelper.setActive(self._headTips, false)
	end
end

function TianShiNaNaLevelView:onClose()
	GuideModel.instance:setFlag(GuideModel.GuideFlag.MaskUseMainCamera, nil)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2TianShiNaNa.stop_ui_youyu_foot)
	TianShiNaNaModel.instance:sendStat("主动中断")
end

return TianShiNaNaLevelView
