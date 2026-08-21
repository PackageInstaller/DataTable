-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/view/message/AirWorkShopMessageLogTipsView.lua

module("logic.extensions.airworkshop.view.message.AirWorkShopMessageLogTipsView", package.seeall)

local M = class("AirWorkShopMessageLogTipsView", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._btnExit = self:getBtnByPath("middle_tips_common_bg/clickExit")
	self._btnClose = self:getBtnByPath("middle_tips_common_bg/btnClose")
	self._btnEditorMsg = Astral.SimpleLuaComponentContainer.Add(goutil.findChild(self.mainGO, "allContent/layout/objBottom/btn_right").gameObject, CommButton)
	self._goEmpty = self:getGo("air_workshop_message_log_tips_-903284101")
	self._loopList = LoopListHelper.New(self:getGo("air_workshop_message_log_tips_-1635516407"))

	self._loopList:InitListView(0, self._onCellUpdate, self)
end

function M:destroyUI()
	for _, cell in pairs(self._cellComps or {}) do
		cell.destroyUI()
	end

	self._loopList:Dispose()

	self._loopList = nil
	self._cellComps = nil
end

function M:bindEvents()
	self._btnExit:AddClickListener(self._onClickClose, self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnEditorMsg:AddClickListener(self._onClickEditorMsg, self)
end

function M:unbindEvents()
	self._btnExit:RemoveClickListener()
	self._btnClose:RemoveClickListener()
	self._btnEditorMsg:RemoveClickListener()
end

function M:onEnter()
	self:setEvent(true)
	self._loopList:ClearCells()

	local info = self:getFirstParam()

	self._mapId = info.id
	self._cover = info.cover

	self._btnEditorMsg:setActive(not info.hideEditBtn)
	self._btnEditorMsg:setInteractable(info.editBtnInteractable)
	self._btnEditorMsg:setActiveState(info.editBtnInteractable)
	AirWorkShopDefAgent.instance:sendGetCommentsRequest(self._mapId)
end

function M:onExit()
	self:setEvent(false)
	self._loopList:ClearCells()

	self._lstCommentRecordNO = nil

	CriwareAudioFacade.instance:stopVoice()
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(AirWorkShopEventType.ON_GET_MAP_COMMENTS_REPLY, self._handleOnGetMapCommentsReply, self)
	else
		GlobalDispatcher:removeEventListener(AirWorkShopEventType.ON_GET_MAP_COMMENTS_REPLY, self._handleOnGetMapCommentsReply, self)
	end
end

function M:_handleOnGetMapCommentsReply(e, lstCommentRecordNO)
	self._lstCommentRecordNO = lstCommentRecordNO

	self:refreshView()
end

function M:_onClickClose()
	self:close()
end

function M:_onClickEditorMsg()
	ViewMgr.instance:open(ViewName.AirWorkShopMsgLogView, {
		mapId = self._mapId,
		cover = self._cover
	})
end

function M:_onCellClickVoice(voiceResId)
	if voiceResId > 0 then
		local heroId = math.floor(voiceResId / 1000) + 2000000
		local audioId = voiceResId % 1000
		local cfg = CharacterAudioConfig.instance:getCharacterAudioCOByHeroIdAndAudioId(heroId, audioId)
		local voiceId = cfg and cfg.voiceId or -1
		local VoiceEnumRes = CharacterInfoEnum.VoiceRes[audioId]
		local voiceRes = VoiceEnumRes and string.format(VoiceEnumRes, heroId) or voiceId
		local wwiseCo = CriwareAudioConfig.instance:getCOByName(voiceRes)

		if not wwiseCo then
			if Astral.OSDef.isEditor then
				FloatWordMgr.instance:show(string.format("角色[%s]audioId[%s]无法找到资源", heroId, audioId))
			elseif enableErrorLog then
				printError(string.format("角色[%s]audioId[%s]无法找到资源", heroId, audioId))
			end

			return
		end

		CriwareAudioFacade.instance:playVoiceByName(voiceRes, self.mainGO, nil, nil)
	end
end

function M:refreshView()
	local len = self._lstCommentRecordNO and #self._lstCommentRecordNO or 0

	if len > 0 then
		goutil.setActive(self._loopList:GetLoopListView().gameObject, true)
		self._loopList:SetListItemCount(len, true)
		self._loopList:RefreshAllShownItem()
	else
		self._loopList:ClearCells()
		goutil.setActive(self._loopList:GetLoopListView().gameObject, false)
	end

	goutil.setActive(self._goEmpty, len == 0)
end

function M:_onCellUpdate(curIndex)
	curIndex = curIndex + 1

	local data = self._lstCommentRecordNO[curIndex]
	local prefabName = "message_log_item"
	local item = self._loopList:NewListViewItem(prefabName)

	self:_writeData(item.gameObject, data)

	return item
end

function M:_writeData(go, CommentRecordNO)
	if not self._cellComps then
		self._cellComps = {}
	end

	local instanceId = go:GetInstanceID()
	local shower = self._cellComps[instanceId]

	if not shower then
		shower = {
			go = go,
			imgPlayerMask = goutil.findChildImageComponent(go, "headIcon/headIconShadow"),
			txtPlayerName = goutil.findChildComponent(go, "txtPlayerName", UIComponentType.Text),
			txtTime = goutil.findChildComponent(go, "txtTime", UIComponentType.Text),
			txtContent = goutil.findChildComponent(go, "txtContent", UIComponentType.TextMeshProUGUI),
			imgEmoji = goutil.findChildImageComponent(go, "imgEmoticon"),
			goVoiceMark = goutil.findChild(go, "imgVoice").gameObject,
			btnVoice = UIComponentType.ButtonAdapter(goutil.findChild(go, "btnVoiceClick").gameObject)
		}

		function shower.getVoiceResId()
			return shower.voiceResId
		end

		shower.btnVoice:AddClickListener(function()
			self:_onCellClickVoice(shower.getVoiceResId())
		end, self)

		function shower.destroyUI()
			shower.btnVoice:RemoveClickListener()
		end

		self._cellComps[instanceId] = shower
	end

	shower.txtPlayerName.text = CommentRecordNO.player.nickname
	shower.userId = CommentRecordNO.player.userId

	local portraitCO = BackpackConfig.instance:getItemInfoByItemId(CommentRecordNO.player.portrait)

	if portraitCO then
		IconLoader.setSprite(shower.imgPlayerMask, IconType.PlayerInfoMask, portraitCO.icon)
	end

	shower.txtTime.text = ServerTime.formatTimeServerLook(CommentRecordNO.time * 0.001, "%Y/%m/%d")

	local msg = CommentRecordNO.msg
	local leaveMsgMo = LeaveMsgMO.New(msg)
	local voice = leaveMsgMo:getVoice()
	local emoji = leaveMsgMo:getEmoji()

	shower.voiceResId = voice

	if voice > 0 then
		leaveMsgMo:setPageType(LeaveMsgEnum.MsgType.Voice)

		shower.txtContent.text = "<line-indent=6%>" .. string.format("%s", leaveMsgMo:getPreviewMsg())
	else
		leaveMsgMo:setPageType(LeaveMsgEnum.MsgType.Word)

		if leaveMsgMo:getPageAllFinish(LeaveMsgEnum.MsgType.Word) then
			shower.txtContent.text = string.format("%s", leaveMsgMo:getPreviewMsg())
		else
			shower.txtContent.text = nil
		end
	end

	goutil.setActive(shower.goVoiceMark, voice > 0)
	goutil.setActive(shower.imgEmoji.gameObject, emoji > 0)

	if emoji > 0 then
		local cfg = ChatConfig.instance:getConfigByKey(ConfigName.ChatEmoji, emoji)

		IconLoader.setSprite(shower.imgEmoji, IconType.ChatEmoji, cfg.icon)
	end
end

return M
