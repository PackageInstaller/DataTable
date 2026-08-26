-- chunkname: @modules/logic/versionactivity2_8/molideer/view/game/MoLiDeErTeamItem.lua

module("modules.logic.versionactivity2_8.molideer.view.game.MoLiDeErTeamItem", package.seeall)

local MoLiDeErTeamItem = class("MoLiDeErTeamItem", LuaCompBase)

function MoLiDeErTeamItem:init(go)
	self.viewGO = go
	self._goSelected = gohelper.findChild(self.viewGO, "image_HeadBG/#go_Selected")
	self._simageHead = gohelper.findChildSingleImage(self.viewGO, "image_HeadBG/image/#simage_Head")
	self._goCD = gohelper.findChild(self.viewGO, "image_HeadBG/#go_CD")
	self._btnDetail = gohelper.findChildButtonWithAudio(self.viewGO, "image_HeadBG/#btn_Detail")
	self._goBuff = gohelper.findChild(self.viewGO, "image_HeadBG/#go_Buff")
	self._imageHeadBG = gohelper.findChildImage(self.viewGO, "image_HeadBG")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MoLiDeErTeamItem:_editableInitView()
	self._imageHead = gohelper.findChildImage(self.viewGO, "image_HeadBG/image/#simage_Head")
	self._animator = gohelper.findChildComponent(self.viewGO, "image_HeadBG", typeof(UnityEngine.Animator))
end

function MoLiDeErTeamItem:addEventListeners()
	self._btnDetail:AddClickListener(self.onDetailClick, self)
	self.addEventCb(self, MoLiDeErGameController.instance, MoLiDeErEvent.UIDispatchTeam, self.onDispatchTeam, self)
	self.addEventCb(self, MoLiDeErGameController.instance, MoLiDeErEvent.UIWithDrawTeam, self.onWithDrawTeam, self)
end

function MoLiDeErTeamItem:removeEventListeners()
	self._btnDetail:RemoveClickListener()
	self.removeEventCb(self, MoLiDeErGameController.instance, MoLiDeErEvent.UIDispatchTeam, self.onDispatchTeam, self)
	self.removeEventCb(self, MoLiDeErGameController.instance, MoLiDeErEvent.UIWithDrawTeam, self.onWithDrawTeam, self)
end

function MoLiDeErTeamItem:onWithDrawTeam(teamId)
	if self.teamId == nil then
		return
	end

	if self.viewGO.activeSelf == true and self.state == MoLiDeErEnum.DispatchState.Main and teamId == self.teamId then
		self:showAnim(MoLiDeErEnum.AnimName.RoleItemOut, true)
		TaskDispatcher.runDelay(self.onFadeOutEnd, self, 0.5)
	end
end

function MoLiDeErTeamItem:onFadeOutEnd()
	TaskDispatcher.cancelTask(self.onFadeOutEnd, self)
	self:showAnim(MoLiDeErEnum.AnimName.RoleItemIn, false)
end

function MoLiDeErTeamItem:onDispatchTeam(teamId)
	if self.teamId == nil then
		return
	end

	if self.viewGO.activeSelf == true and self.state == MoLiDeErEnum.DispatchState.Main and teamId == self.teamId then
		self:showAnim(MoLiDeErEnum.AnimName.RoleItemIn, true)
	end
end

function MoLiDeErTeamItem:showAnim(animName, playAnim)
	local animTime = playAnim and 0 or 1

	self._animator:Play(animName, 0, animTime)
	logNormal("莫莉德尔 角色活动 播放角色item动画：" .. animName .. " time: " .. tostring(animTime))
end

function MoLiDeErTeamItem:onDetailClick()
	local teamId = self.teamId

	if teamId == MoLiDeErGameModel.instance:getSelectTeamId() then
		return
	end

	local optionId = MoLiDeErGameModel.instance:getSelectOptionId()

	if self.state == MoLiDeErEnum.DispatchState.Dispatch and optionId ~= 0 and optionId ~= nil then
		local gameInfoMo = MoLiDeErGameModel.instance:getCurGameInfo()
		local canDispatch, toastId = MoLiDeErHelper.isTeamCanChose(gameInfoMo, self.info, optionId)

		if canDispatch == false then
			if toastId ~= nil then
				GameFacade.showToast(toastId)
			end

			return
		end
	end

	MoLiDeErGameModel.instance:setSelectTeamId(self.teamId)
end

function MoLiDeErTeamItem:setData(info, state)
	self.info = info
	self.teamId = info.teamId
	self.state = state
	self._teamConfig = MoLiDeErConfig.instance:getTeamConfig(info.teamId)

	self:refreshUI()
end

function MoLiDeErTeamItem:setActive(active)
	gohelper.setActive(self.viewGO, active)
end

function MoLiDeErTeamItem:setSelect(isSelect)
	if self.teamId == nil then
		return
	end

	gohelper.setActive(self.viewGO, not isSelect)
	gohelper.setActive(self._goSelected, isSelect)
	self:refreshBuffState()
end

function MoLiDeErTeamItem:refreshUI()
	local config = self._teamConfig

	if not string.nilorempty(config.picture) then
		self._simageHead:LoadImage(config.picture, MoLiDeErHelper.handleImage, {
			imgTransform = self._simageHead.transform,
			offsetParam = config.iconOffset
		})
	end

	self:refreshState()
end

function MoLiDeErTeamItem:refreshState()
	if self.teamId == nil then
		return
	end

	local gameInfoMo = MoLiDeErGameModel.instance:getCurGameInfo()
	local isDispatching = (self.state == MoLiDeErEnum.DispatchState.Dispatch or self.state == MoLiDeErEnum.DispatchState.Main) and gameInfoMo:isInDispatching(self.info.teamId)
	local optionId = MoLiDeErGameModel.instance:getSelectOptionId()
	local haveCount = self.info.roundActionTime > 0 and self.info.roundActedTime < self.info.roundActionTime

	gohelper.setActive(self._goCD, isDispatching)

	local iconColor = not isDispatching and (self.state == MoLiDeErEnum.DispatchState.Dispatch or self.state == MoLiDeErEnum.DispatchState.Main and optionId or nil) and MoLiDeErHelper.isTeamEnable(optionId, self.teamId) and haveCount and MoLiDeErEnum.EventBgColor.Normal or MoLiDeErEnum.EventBgColor.Dispatching

	UIColorHelper.set(self._imageHeadBG, iconColor)
	UIColorHelper.set(self._imageHead, iconColor)
	self:refreshBuffState()
end

function MoLiDeErTeamItem:refreshBuffState()
	local selectOptionId = MoLiDeErGameModel.instance:getSelectOptionId()

	if self.state == MoLiDeErEnum.DispatchState.Dispatch then
		local haveBuff = selectOptionId ~= nil and MoLiDeErHelper.isTeamBuffed(selectOptionId, self.teamId)

		gohelper.setActive(self._goBuff, haveBuff)
	else
		gohelper.setActive(self._goBuff, false)
	end
end

function MoLiDeErTeamItem:clear()
	self.teamId = nil
	self.state = nil
	self.info = nil
	self._teamConfig = nil
end

function MoLiDeErTeamItem:onDestroy()
	return
end

return MoLiDeErTeamItem
