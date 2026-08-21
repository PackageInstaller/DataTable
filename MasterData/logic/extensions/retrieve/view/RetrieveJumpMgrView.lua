-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/retrieve/view/RetrieveJumpMgrView.lua

module("logic.extensions.retrieve.view.RetrieveJumpMgrView", package.seeall)

local M = class("RetrieveJumpMgrView", ViewComponent)

function M:buildUI()
	self._raycast = self:getBtn("retrieve_jump_view_659503145")

	self._raycast:SetClickInterval(0.3)

	self._continueBtn = self:getBtn("retrieve_jump_view_-350953562")
	self._enterVideo = self:getGo("retrieve_jump_view_-145262591")
	self._openEffect = CriWareVideoMgr.Get(self._enterVideo)
end

function M:_setButtonState(active)
	goutil.setActive(self._raycast.gameObject, active)

	local systemOpen = SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.LotteryJumpOver, false)
	local lotteryResultList = RetrieveController.instance:getCacheLotteryResult()

	if #lotteryResultList == RetrieveEnum.LotteryNum.Ten then
		goutil.setActive(self._continueBtn.gameObject, systemOpen and active)
	else
		goutil.setActive(self._continueBtn.gameObject, false)
	end
end

function M:destroyUI()
	self._raycast = nil
	self._continueBtn = nil
	self._index = nil

	if self._openEffect then
		self._openEffect:DestroyMovie()
	end
end

function M:_setEvent(add)
	if add then
		RetrieveDispatcher:addEventListener(RetrieveEventType.Show_Jump_View, self._onShowJumpView, self)
		RetrieveDispatcher:addEventListener(RetrieveEventType.Show_Lottery_UI_Finish, self._onShowRoleUiInfo, self)
	else
		RetrieveDispatcher:removeEventListener(RetrieveEventType.Show_Jump_View, self._onShowJumpView, self)
		RetrieveDispatcher:removeEventListener(RetrieveEventType.Show_Lottery_UI_Finish, self._onShowRoleUiInfo, self)
	end
end

function M:_onShowRoleUiInfo(evt)
	local lotteryResultList = RetrieveController.instance:getCacheLotteryResult()

	if #lotteryResultList == RetrieveEnum.LotteryNum.One then
		self._canJumpOutForSingle = true
	elseif #lotteryResultList == RetrieveEnum.LotteryNum.Ten and self._stayForAnim then
		self._stayForAnim = false
	end
end

function M:bindEvents()
	self._raycast:AddClickListener(self._onClickRaycast, self)
	self._continueBtn:AddClickListener(self._onClickContinue, self)
end

function M:unbindEvents()
	self._raycast:RemoveClickListener()
	self._continueBtn:RemoveClickListener()
end

function M:onEnter()
	self:_setEvent(true)

	local systemOpen = SystemOpenFacade.instance:isOpen(GameEnum.SystemEnum.LotteryJumpOver, false)

	goutil.setActive(self._continueBtn.gameObject, systemOpen)

	self._canJumpOutForSingle = false
	self._lotteryResultCache = RetrieveController.instance:getCacheLotteryResult()
	self._isSingleModel = #self._lotteryResultCache == 1
	self._index = 0

	goutil.setActive(self.mainGO, false)

	self._stayForAnim = true
end

function M:_onShowJumpView(evt, isLucky)
	goutil.setActive(self.mainGO, true)
	goutil.setActive(self._enterVideo, true)
	self:_setButtonState(false)

	self._canJumpOutForSingle = false

	local hasA = false
	local hasS = 0
	local lotteryResultList = self._lotteryResultCache

	for i, characterInfo in ipairs(lotteryResultList) do
		local quality = false
		local characterCO = CharacterConfig.instance:getCfgInfoByID(characterInfo.characterCode)

		quality = characterCO.quality

		if quality == GameEnum.QualityEnum.S then
			hasS = hasS + 1
		elseif quality == GameEnum.QualityEnum.A then
			hasA = true
		end
	end

	local isJin = hasS > 0
	local videoBaseName = isLucky and "sx-s410_chouka_selection_%s_red" or "sx-s410_chouka_selection_%s"
	local qualityName = "b"

	if isJin then
		qualityName = "s"
	elseif hasA then
		qualityName = "a"
	end

	local videoName = string.format(videoBaseName, qualityName)
	local fullVideoPath = GameUrl.getVideoUrl(videoName)

	self._openEffect:PlayMovie(fullVideoPath, true, false, self._onPlayFinished, self)
	CriwareAudioFacade.instance:playBgmInnerById(CriwareAudioEnum.music_main_zhaomu_03)
end

function M:_onPlayFinished()
	self._openEffect:StopMovie()
	goutil.setActive(self._enterVideo, false)
	self:_showRoleInfo()
	self:_setButtonState(true)
end

function M:_showRoleInfo()
	self._index = self._index + 1

	local lotteryResultList = self._lotteryResultCache
	local resultData = lotteryResultList[self._index]

	if resultData.isNew or resultData.isAiLiSi then
		self._stayForAnim = true
	else
		self._stayForAnim = false
	end

	RetrieveFacade.instance:showGetRole(resultData.characterCode, resultData.conversion, RetrieveEnum.ShowRoleType.Lottery, self._index, resultData.isNew)
end

function M:onExit()
	self._openEffect:Reset()
	self:_setEvent(false)

	self._index = 0
	self._canJumpOutForSingle = false
end

function M:_onClickRaycast()
	if self._isSingleModel then
		if self._canJumpOutForSingle then
			self:_onClickContinue()
		end

		return
	end

	if self._stayForAnim then
		return
	end

	local lotteryResultList = self._lotteryResultCache

	if self._index < #lotteryResultList then
		self:_showRoleInfo()
	else
		self:_onClickContinue()
	end
end

function M:_onClickContinue()
	CriwareAudioFacade.instance:stopVoice()

	if RetrieveModel.instance:getIsTest() then
		RetrieveModel.instance:onReset()
		GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_TO_MAIN)

		return
	end

	if GuideController.instance:isGuiding() then
		self:close()

		return
	end

	RetrieveDispatcher:dispatchEvent(RetrieveEventType.Retrieve_FLOW_END, self._isSingleModel)
end

return M
