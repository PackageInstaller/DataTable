-- chunkname: @modules/logic/versionactivity1_9/fairyland/view/element/FairyLandChessNpc.lua

module("modules.logic.versionactivity1_9.fairyland.view.element.FairyLandChessNpc", package.seeall)

local FairyLandChessNpc = class("FairyLandChessNpc", FairyLandElementBase)

FairyLandChessNpc.Setting = {
	[2] = {
		chat = "fairyland_chat01",
		chess = "fairyland_chess1"
	},
	[4] = {
		chat = "fairyland_chat02",
		chess = "fairyland_chess2"
	},
	[6] = {
		chat = "fairyland_chat03",
		chess = "fairyland_chess3"
	},
	[8] = {
		chat = "fairyland_chat04",
		chess = "fairyland_chess4"
	}
}

function FairyLandChessNpc:onInitView()
	self.rootGo = gohelper.findChild(self._go, "root")
	self.imgChessRoot = gohelper.findChild(self.rootGo, "image_Chess")
	self.animChess = self.imgChessRoot:GetComponent(typeof(UnityEngine.Animator))
	self.imgChess = gohelper.findChildImage(self.rootGo, "image_Chess/#image_chess/image_chess")
	self.goChess = self.imgChess.gameObject
	self.goChat = gohelper.findChild(self.rootGo, "#image_Chat")
	self.imageChat = gohelper.findChildImage(self.rootGo, "#image_Chat")

	gohelper.setActive(self.goChat, false)

	self.chatClick = gohelper.findChildClickWithAudio(self.rootGo, "#image_Chat")

	self.chatClick:AddClickListener(self.onClickChat, self)

	local setting = FairyLandChessNpc.Setting[self._config.type]

	UISpriteSetMgr.instance:setFairyLandSprite(self.imgChess, setting.chess, true)
	UISpriteSetMgr.instance:setFairyLandSprite(self.imageChat, setting.chat, true)
end

function FairyLandChessNpc:onDestroyElement()
	self.chatClick:RemoveClickListener()
end

function FairyLandChessNpc:onRefresh()
	local puzzleId = self:getCurPuzzle()
	local isPass = FairyLandModel.instance:isPassPuzzle(puzzleId)
	local puzzleConfig = FairyLandConfig.instance:getFairlyLandPuzzleConfig(puzzleId)

	if isPass and FairyLandModel.instance:isFinishDialog(puzzleConfig.successTalkId) then
		self:setFinish()

		return
	end

	local dialogId = puzzleConfig.beforeTalkId
	local lastElementId = self:getElementId() - 1

	if dialogId == 0 or not FairyLandModel.instance:isFinishElement(lastElementId) then
		gohelper.setActive(self.goChat, false)
	else
		local isFinishDialog = FairyLandModel.instance:isFinishDialog(dialogId)

		gohelper.setActive(self.goChat, not isFinishDialog)
	end
end

function FairyLandChessNpc:onClickChat()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_gudu_bubble_click)

	local puzzleId = self:getCurPuzzle()
	local puzzleConfig = FairyLandConfig.instance:getFairlyLandPuzzleConfig(puzzleId)
	local param = {}

	param.dialogId = puzzleConfig.beforeTalkId
	param.dialogType = FairyLandEnum.DialogType.Bubble
	param.leftElement = FairyLandModel.instance:getDialogElement()
	param.rightElement = self

	FairyLandController.instance:openDialogView(param)
	gohelper.setActive(self.goChat, false)
	FairyLandController.instance:dispatchEvent(FairyLandEvent.SetTextBgVisible)
end

function FairyLandChessNpc:getCurPuzzle()
	local puzzleIds = string.splitToNumber(self._config.puzzleId, "#")

	for i, v in ipairs(puzzleIds) do
		if not FairyLandModel.instance:isPassPuzzle(v) then
			return v
		end
	end

	return puzzleIds[#puzzleIds]
end

function FairyLandChessNpc:getClickGO()
	return self.goChess
end

function FairyLandChessNpc:playDialog()
	self.animChess:Play("jump", 0, 0)
end

return FairyLandChessNpc
