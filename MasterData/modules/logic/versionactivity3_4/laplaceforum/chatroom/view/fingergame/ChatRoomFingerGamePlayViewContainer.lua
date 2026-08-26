-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/chatroom/view/fingergame/ChatRoomFingerGamePlayViewContainer.lua

module("modules.logic.versionactivity3_4.laplaceforum.chatroom.view.fingergame.ChatRoomFingerGamePlayViewContainer", package.seeall)

local ChatRoomFingerGamePlayViewContainer = class("ChatRoomFingerGamePlayViewContainer", BaseViewContainer)

function ChatRoomFingerGamePlayViewContainer:buildViews()
	return {
		ChatRoomFingerGamePlayView.New(),
		TabViewGroup.New(1, "#go_btns")
	}
end

function ChatRoomFingerGamePlayViewContainer:buildTabViews(tabContainerId)
	if tabContainerId == 1 then
		self.navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		self.navigateButtonView:setCloseCheck(self.closeCallback, self)

		return {
			self.navigateButtonView
		}
	end
end

function ChatRoomFingerGamePlayViewContainer:closeCallback()
	local resultType = ChatRoomFingerGameModel.instance:getResultType()

	if resultType ~= ChatRoomEnum.GameResultType.None or ChatRoomFingerGameModel.instance:isDiscardFlip() then
		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.LaplaceChatRoomFingerGameExit, MsgBoxEnum.BoxType.Yes_No, self.onClickYes, nil, nil, self, nil)

	return false
end

function ChatRoomFingerGamePlayViewContainer:onClickYes()
	self:closeThis()
	ChatRoomFingerGameModel.instance:abandon()
end

return ChatRoomFingerGamePlayViewContainer
