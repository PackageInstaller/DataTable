-- chunkname: @modules/logic/versionactivity2_8/molideer/view/game/MoLiDeErEventItem.lua

module("modules.logic.versionactivity2_8.molideer.view.game.MoLiDeErEventItem", package.seeall)

local MoLiDeErEventItem = class("MoLiDeErEventItem", LuaCompBase)

function MoLiDeErEventItem:init(go)
	self.viewGO = go
	self._imagePoint = gohelper.findChildImage(self.viewGO, "#image_Point")
	self._imageIcon = gohelper.findChildImage(self.viewGO, "#image_Icon")
	self._imageStar = gohelper.findChildImage(self.viewGO, "#image_Star")
	self._imageLine = gohelper.findChildImage(self.viewGO, "#image_Line")
	self._imagePointFinish = gohelper.findChildImage(self.viewGO, "#image_Pointfinish")
	self._imageIconFinish = gohelper.findChildImage(self.viewGO, "#image_Iconfinish")
	self._imageStarFinish = gohelper.findChildImage(self.viewGO, "#image_Starfinish")
	self._imageLineFinish = gohelper.findChildImage(self.viewGO, "#image_Linefinish")
	self._txtNum = gohelper.findChildText(self.viewGO, "#txt_Num")
	self._simageHead = gohelper.findChildSingleImage(self.viewGO, "#go_Dispatch/image_HeadBG/image/#simage_Head")
	self._txtTime = gohelper.findChildText(self.viewGO, "#go_Dispatch/#txt_Time")
	self._goDispatch = gohelper.findChild(self.viewGO, "#go_Dispatch")
	self._btnDetail = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Detail")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function MoLiDeErEventItem:_editableInitView()
	self._animator = gohelper.findChildComponent(self.viewGO, "", gohelper.Type_Animator)
	self._roleAnimator = gohelper.findChildComponent(self.viewGO, "#go_Dispatch", gohelper.Type_Animator)
end

function MoLiDeErEventItem:addEventListeners()
	self._btnDetail:AddClickListener(self.onDetailClick, self)
end

function MoLiDeErEventItem:removeEventListeners()
	self._btnDetail:RemoveClickListener()
end

function MoLiDeErEventItem:onDetailClick()
	local eventId = MoLiDeErGameModel.instance:getSelectEventId()
	local selfEventId = self._eventId

	if eventId == selfEventId then
		return
	end

	MoLiDeErGameModel.instance:setSelectEventId(selfEventId)
end

function MoLiDeErEventItem:setData(eventId, isChose, eventEndRound, currentRound, teamId, showAnim)
	self._eventId = eventId
	self._isChose = isChose
	self._currentRound = currentRound
	self._eventEndRound = eventEndRound
	self._teamId = teamId

	self:refreshUI(showAnim)
end

function MoLiDeErEventItem:setActive(active)
	gohelper.setActive(self.viewGO, active)
end

function MoLiDeErEventItem:setAtFirst()
	gohelper.setAsFirstSibling(self.viewGO)
end

function MoLiDeErEventItem:showAnim(animName, playAnim)
	local animTime = playAnim and 0 or 1

	self._animator:Play(animName, 0, animTime)
end

function MoLiDeErEventItem:showRoleAnim(animName, playAnim)
	local animTime = playAnim and 0 or 1

	self._roleAnimator:Play(animName, 0, animTime)
end

function MoLiDeErEventItem:refreshUI(showAnim)
	local isChose = self._isChose
	local eventEndRound = self._eventEndRound
	local currentRound = self._currentRound
	local isComplete = eventEndRound ~= 0 and eventEndRound <= currentRound
	local isDispatch = isChose and currentRound < eventEndRound and self._teamId ~= nil and self._teamId ~= 0
	local curGameInfo = MoLiDeErGameModel.instance:getCurGameInfo()

	if showAnim then
		::label_11_0::

		local var_11_0 = curGameInfo.newBackTeamEventDic[self._eventId]

		if curGameInfo.newBackTeamEventDic[self._eventId] then
			local isWithDraw = not isDispatch

			if isComplete then
				if not MoLiDeErEnum.EventState.Complete then
					local state = MoLiDeErEnum.EventState.Unlock
					local suffix = tostring(state)
					local finishSuffix = tostring(MoLiDeErEnum.EventState.Complete)
					local config = MoLiDeErConfig.instance:getEventConfig(self._eventId)

					UISpriteSetMgr.instance:setMoLiDeErSprite(self._imageIcon, string.format("v2a8_molideer_game_stage_%s_%s", config.eventType, suffix))
					UISpriteSetMgr.instance:setMoLiDeErSprite(self._imageStar, "v2a8_molideer_game_stage_star_" .. suffix)
					UISpriteSetMgr.instance:setMoLiDeErSprite(self._imageLine, "v2a8_molideer_game_stage_line_" .. suffix)
					UISpriteSetMgr.instance:setMoLiDeErSprite(self._imagePoint, "v2a8_molideer_game_stage_point_" .. suffix)

					if isComplete then
						UISpriteSetMgr.instance:setMoLiDeErSprite(self._imageIconFinish, string.format("v2a8_molideer_game_stage_%s_%s", config.eventType, finishSuffix))
						UISpriteSetMgr.instance:setMoLiDeErSprite(self._imageStarFinish, "v2a8_molideer_game_stage_star_" .. finishSuffix)
						UISpriteSetMgr.instance:setMoLiDeErSprite(self._imageLineFinish, "v2a8_molideer_game_stage_line_" .. finishSuffix)
						UISpriteSetMgr.instance:setMoLiDeErSprite(self._imagePointFinish, "v2a8_molideer_game_stage_point_" .. finishSuffix)
					end

					gohelper.setActive(self._imageIconFinish.gameObject, isComplete)
					gohelper.setActive(self._imageStarFinish.gameObject, isComplete)
					gohelper.setActive(self._imageLineFinish.gameObject, isComplete)
					gohelper.setActive(self._imagePointFinish.gameObject, isComplete)

					local titleColor, iconColor

					if isDispatch then
						titleColor = MoLiDeErEnum.EventTitleColor.Dispatching
						iconColor = MoLiDeErEnum.EventBgColor.Dispatching
					else
						titleColor = isComplete and MoLiDeErEnum.EventTitleColor.Complete or MoLiDeErEnum.EventTitleColor.NoComplete
						iconColor = MoLiDeErEnum.EventBgColor.Normal
					end

					UIColorHelper.set(self._imageIcon, iconColor)

					local actId = MoLiDeErModel.instance:getCurActId()
					local titleId = MoLiDeErEnum.EventName[config.eventType]
					local titleConfig = MoLiDeErConfig.instance:getConstConfig(actId, titleId)
					local titleStr = GameUtil.getSubPlaceholderLuaLangOneParam(titleConfig.value2, config.number)

					self._txtNum.text = string.format("<color=%s>%s</color>", titleColor, titleStr)
					self.viewGO.name = config.eventId

					gohelper.setActive(self._goDispatch, not isComplete and isDispatch or isWithDraw)

					local positionData = string.splitToNumber(config.position, "#")

					transformhelper.setLocalPosXY(self.viewGO.transform, positionData[1], positionData[2])
					self:showAnim(MoLiDeErEnum.AnimName.GameViewEventItemOpen, false)

					if not isDispatch and not isWithDraw then
						return
					end

					local teamId, reduceRound

					if isDispatch then
						if not MoLiDeErEnum.AnimName.GameViewEventRoleIn then
							local animName = MoLiDeErEnum.AnimName.GameViewEventRoleOut

							if isDispatch then
								reduceRound = eventEndRound - currentRound
								teamId = self._teamId
							elseif isWithDraw then
								teamId = curGameInfo.newBackTeamEventDic[self._eventId]
								self._txtTime.text = tostring(reduceRound)
							end

							self._txtTime.text = tostring(reduceRound)

							local teamConfig = MoLiDeErConfig.instance:getTeamConfig(teamId)

							if not string.nilorempty(teamConfig.picture) then
								self._simageHead:LoadImage(teamConfig.picture, MoLiDeErHelper.handleImage, {
									imgTransform = self._simageHead.transform,
									offsetParam = teamConfig.iconOffset
								})
							end

							self:showRoleAnim(animName, showAnim)
						end
					end
				end
			end
		end
	end
end

function MoLiDeErEventItem:onDestroy()
	return
end

return MoLiDeErEventItem
