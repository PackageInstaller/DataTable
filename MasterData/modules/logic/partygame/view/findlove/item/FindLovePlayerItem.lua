-- chunkname: @modules/logic/partygame/view/findlove/item/FindLovePlayerItem.lua

module("modules.logic.partygame.view.findlove.item.FindLovePlayerItem", package.seeall)

local FindLovePlayerItem = class("FindLovePlayerItem", SimpleListItem)

function FindLovePlayerItem:onInit()
	self.goSpine = gohelper.findChild(self.viewGO, "goSpine")
	self.textName = gohelper.findChildTextMesh(self.viewGO, "textName")
	self.imgTeamRed = gohelper.findChildTextMesh(self.viewGO, "nameBg/red")
	self.imgTeamBlue = gohelper.findChildTextMesh(self.viewGO, "nameBg/blue")
	self.imgTeamNormal = gohelper.findChildTextMesh(self.viewGO, "nameBg/normal")
	self.textScoreAdd = gohelper.findChildTextMesh(self.viewGO, "textScoreAdd")
	self.go_playerself = gohelper.findChild(self.viewGO, "go_playerself")
	self.animator = self.viewGO:GetComponent("Animator")
	self.success1 = gohelper.findChild(self.viewGO, "Bg/success")
	self.success2 = gohelper.findChild(self.viewGO, "success")
	self.fail1 = gohelper.findChild(self.viewGO, "Bg/fail")
	self.fail2 = gohelper.findChild(self.viewGO, "fail")
	self.partygameplayerhead = gohelper.findChild(self.viewGO, "partygameplayerhead")
	self.partyGamePlayerHead = GameFacade.createLuaCompByGo(self.partygameplayerhead, PartyGamePlayerHead, nil, self.viewContainer)
	self.FindLoveGameInterface = PartyGameCSDefine.FindLoveGameInterface
end

function FindLovePlayerItem:onRemoveListeners()
	TaskDispatcher.cancelTask(self.onSettleAnimEnd, self)
end

function FindLovePlayerItem:onItemShow(data)
	self.gamePartyPlayerMo = data.gamePartyPlayerMo
	self.playerIndex = self.gamePartyPlayerMo.index
	self.num = data.num

	if self.num == 2 then
		self.animator.enabled = true

		self.animator:Play("in2")
	elseif self.num == 4 and self.gamePartyPlayerMo:isMainPlayer() then
		self.animator.enabled = true

		self.animator:Play("in1")
	end

	self.partyGamePlayerHead:setData({
		isAutoShowScore = true,
		isShowBkg = true,
		isAutoShowRank = true,
		uid = self.gamePartyPlayerMo.uid
	})

	local str

	self.textName.text = self.gamePartyPlayerMo:isMainPlayer() and string.format("<color=#ffdf8a>%s</color>", self.gamePartyPlayerMo.name) or string.format("<color=#ffffff>%s</color>", self.gamePartyPlayerMo.name)

	if PartyGameModel.instance:getCurGameIsTeamType() then
		gohelper.setActive(self.imgTeamNormal, false)
		gohelper.setActive(self.imgTeamBlue, self.gamePartyPlayerMo.tempType == PartyGameEnum.GamePlayerTeamType.Blue)
		gohelper.setActive(self.imgTeamRed, self.gamePartyPlayerMo.tempType == PartyGameEnum.GamePlayerTeamType.Red)
	else
		gohelper.setActive(self.imgTeamNormal, true)
		gohelper.setActive(self.imgTeamBlue, false)
		gohelper.setActive(self.imgTeamRed, false)
	end

	gohelper.setActive(self.go_playerself, self.gamePartyPlayerMo:isMainPlayer())

	self.spine = self.spine or MonoHelper.addNoUpdateLuaComOnceToGo(self.goSpine, CommonPartyGamePlayerSpineComp)

	self.spine:initSpine(self.gamePartyPlayerMo.uid)

	self.teamId = self.FindLoveGameInterface.GetPlayerTeamId(self.playerIndex)
end

function FindLovePlayerItem:refreshScoreAdd()
	local isEndDisplay = self.FindLoveGameInterface.IsEndDisplay()
	local scoreAdd = self.FindLoveGameInterface.GetScoreAdd(self.playerIndex)
	local isShow = isEndDisplay and scoreAdd > 0

	gohelper.setActive(self.textScoreAdd, isShow)

	if isShow then
		self.textScoreAdd.text = "+" .. scoreAdd
	end
end

function FindLovePlayerItem:playScoreAnim()
	local animType = self.FindLoveGameInterface.GetAnimType(self.playerIndex)

	if animType == 2 then
		self.spine:playAnim("happyLoop", false, true)
		gohelper.setActive(self.success1, true)
		gohelper.setActive(self.success2, true)
		gohelper.setActive(self.fail1, false)
		gohelper.setActive(self.fail2, false)

		if self.gamePartyPlayerMo:isMainPlayer() then
			AudioMgr.instance:trigger(AudioEnum3_4.PartyGame14.play_ui_bulaochun_correct)
		end
	elseif animType == 1 then
		self.spine:playAnim("sad", false, true)
		gohelper.setActive(self.success1, false)
		gohelper.setActive(self.success2, false)
		gohelper.setActive(self.fail1, true)
		gohelper.setActive(self.fail2, true)

		if self.gamePartyPlayerMo:isMainPlayer() then
			AudioMgr.instance:trigger(AudioEnum3_4.PartyGame14.play_ui_bulaochun_dacuo)
		end
	end

	TaskDispatcher.runDelay(self.onSettleAnimEnd, self, 2)
end

function FindLovePlayerItem:onSettleAnimEnd()
	gohelper.setActive(self.success1, false)
	gohelper.setActive(self.success2, false)
	gohelper.setActive(self.fail1, false)
	gohelper.setActive(self.fail2, false)
end

return FindLovePlayerItem
