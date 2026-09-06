-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jumpgame/view/JumpResultView.lua

module("logic.extensions.jumpgame.view.JumpResultView", package.seeall)

local JumpResultView = class("JumpResultView", ViewComponent)

function JumpResultView:ctor()
	JumpResultView.super.ctor(self)

	self._success = false
end

function JumpResultView:bindEvents()
	self._closeButton:AddClickListener(self._onClickCloseBtn, self)
	self._Btn_Great:AddClickListener(self._onClickClose, self)
	self._Btn_Over:AddClickListener(self._onClickClose, self)
	self._Btn_Continue:AddClickListener(self._onClickContinue, self)
end

function JumpResultView:unbindEvents()
	self._closeButton:RemoveClickListener()
	self._Btn_Great:RemoveClickListener()
	self._Btn_Over:RemoveClickListener()
	self._Btn_Continue:RemoveClickListener()
end

function JumpResultView:buildUI()
	self._closeButton = self:getBtn("Main/btnClose")
	self._Btn_Great = self:getBtn("Btn_Great")
	self._Btn_Over = self:getBtn("Btn_Over")
	self._Btn_Continue = self:getBtn("Btn_Continue")
	self._Txt_targetNum = self:getGo("img1/Txt_targetNum"):GetComponent(goutil.Type_UIText)
	self._Txt_target = self:getGo("img1/Txt_target"):GetComponent(goutil.Type_UIText)
	self._txtDesc = self:getGo("img2/txtDesc"):GetComponent(goutil.Type_UIText)
	self._txtNum2 = self:getGo("img2/txtNum2"):GetComponent(goutil.Type_UIText)
end

function JumpResultView:destroyUI()
	return
end

function JumpResultView:onEnter()
	local collectItemType = self._viewPresentor._openParam[2][1]
	local initCollectNumTable = self._viewPresentor._openParam[2][2]

	self.closeCallback = self._viewPresentor._openParam[3]

	local strs = {
		"梅花之证",
		"八卦之证"
	}

	if collectItemType == 1 then
		self._Txt_target.text = strs[1] .. "："
	elseif collectItemType == 2 then
		self._Txt_target.text = strs[2] .. "："
	end

	self._txtDesc.text = langPara("累计找到%s", strs[collectItemType])
	self._txtNum2.text = initCollectNumTable[1] + JumpGameModel.instance:returnCollect() .. "/" .. initCollectNumTable[2]
	self._Txt_targetNum.text = JumpGameModel.instance:returnCollect()
	self._success = self._viewPresentor:getFirstParam()

	self._Btn_Continue.gameObject:SetActive(true)
	self._Btn_Over.gameObject:SetActive(true)
	self._Btn_Great.gameObject:SetActive(true)

	if self._success then
		self._Btn_Continue.gameObject:SetActive(false)
		self._Btn_Over.gameObject:SetActive(false)
	else
		self._Btn_Great.gameObject:SetActive(false)
	end
end

function JumpResultView:onEnterFinished()
	return
end

function JumpResultView:onExit()
	return
end

function JumpResultView:onExitFinished()
	return
end

function JumpResultView:_onClickCloseBtn()
	if not self._success then
		self:_onClickContinue()
	else
		self:_onClickClose()
	end
end

function JumpResultView:_onClickClose()
	if not self._success then
		self._Btn_Continue.gameObject:SetActive(false)
		self._Btn_Over.gameObject:SetActive(false)
		self._Btn_Great.gameObject:SetActive(true)

		self._success = true

		return
	end

	local challengeId = ChallengeModel.instance:getCurId()
	local count = JumpGameModel.instance:returnCollect()
	local reqExtParams = "{\"count\":" .. count .. ",\"starGame\":\"false\"}"

	ChallengeController.instance:extTeamOpt(18, 3, "17_Accumulate", reqExtParams, function()
		local isNotOpenChallengeView = true

		ChallengeFacade.instance:startChallange(challengeId, function(prePhase)
			self:close()
			UIStateManager.instance:popByName(ViewName.JumpGameView)

			local curPhase = ChallengeModel.instance:getCurPhase()

			if prePhase == curPhase then
				-- block empty
			else
				UIStateManager.instance:popByName(ViewName.XiongMaoJumpView)
			end
		end, isNotOpenChallengeView)
	end)
end

function JumpResultView:_onClickContinue()
	GlobalDispatcher:dispatch(GlobalNotify.JumpPause, false)
	self:close()
end

return JumpResultView
