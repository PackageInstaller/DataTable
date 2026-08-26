-- chunkname: @modules/logic/partygame/view/common/PartyGamePlayerHead.lua

module("modules.logic.partygame.view.common.PartyGamePlayerHead", package.seeall)

local PartyGamePlayerHead = class("PartyGamePlayerHead", PartyGameCompBase)

function PartyGamePlayerHead:onInit()
	self._imagebg = gohelper.findChildImage(self.viewGO, "#image_bg")
	self._gohead = gohelper.findChild(self.viewGO, "#go_head")
	self._imageframe = gohelper.findChildImage(self.viewGO, "#go_head/#image_frame")
	self._imagecolor = gohelper.findChildImage(self.viewGO, "#go_head/#image_color")
	self._gomodel = gohelper.findChild(self.viewGO, "#go_head/mask/#go_model")
	self._gorank = gohelper.findChild(self.viewGO, "#go_head/#go_rank")
	self._imagenumbg = gohelper.findChildImage(self.viewGO, "#go_head/#go_rank/#image_numbg")
	self._txtrank = gohelper.findChildText(self.viewGO, "#go_head/#go_rank/#txt_rank")
	self._txtscore = gohelper.findChildText(self.viewGO, "#txt_score")
	self._goarrow = gohelper.findChild(self.viewGO, "#go_arrow")
	self._txtscoreadd = gohelper.findChildText(self.viewGO, "#txt_scoreadd")

	gohelper.setActive(self._txtscoreadd, false)
end

function PartyGamePlayerHead:onDestroy()
	TaskDispatcher.cancelTask(self.onScoreAddAnimEnd, self)
end

function PartyGamePlayerHead:onSetData(data)
	self.uid = data.uid
	self.playerMo = PartyGameModel.instance:getPlayerMoByUid(self.uid)
	self.isShowBkg = data.isShowBkg
	self.isAutoShowRank = data.isAutoShowRank
	self.isAutoShowScore = data.isAutoShowScore
	self.curGame = PartyGameController.instance:getCurPartyGame()

	gohelper.setActive(self._imagebg.gameObject, self.isShowBkg)

	self.headSpine = self.headSpine or MonoHelper.addNoUpdateLuaComOnceToGo(self._gomodel, CommonPartyGamePlayerSpineComp)

	self.headSpine:initSpine(self.uid)
	self.headSpine:enableSpineUpdate(false)

	self.isAutoShowArrow = data.isAutoShowArrow

	if self.isAutoShowArrow then
		gohelper.setActive(self._goarrow, self.playerMo:isMainPlayer())
	else
		gohelper.setActive(self._goarrow, false)
	end
end

function PartyGamePlayerHead:onViewUpdate()
	if not self.uid then
		return
	end

	self.rank = self.curGame:getRank(self.uid)

	local imageIndex = (self.rank > 4 or self.rank < 1) and 4 or self.rank

	if self.isAutoShowRank then
		gohelper.setActive(self._gorank, true)

		self._txtrank.text = self.rank >= 4 and string.format("<color=#EFEDE3>%s</color>", self.rank) or string.format("<color=#FCFCFC>%s</color>", self.rank)

		UISpriteSetMgr.instance:setV3a4LaplaceSprite(self._imagenumbg, "v3a4_party_common_rankbg_" .. imageIndex .. "_1")
	else
		gohelper.setActive(self._gorank, false)
	end

	if self.isShowBkg then
		UISpriteSetMgr.instance:setV3a4LaplaceSprite(self._imagebg, "v3a4_party_common_rankbg_" .. imageIndex .. "_2")
	end

	UISpriteSetMgr.instance:setV3a4LaplaceSprite(self._imageframe, "v3a4_party_common_rankbg_" .. imageIndex .. "_3")

	if self.isAutoShowScore then
		local score = self.curGame:getPlayerScore(self.uid)

		gohelper.setActive(self._txtscore.gameObject, true)

		self._txtscore.text = self.playerMo:isMainPlayer() and string.format("<color=#FFA119>%s</color>", score) or string.format("<color=#FFFFFF>%s</color>", score)
	else
		gohelper.setActive(self._txtscore.gameObject, false)
	end

	local _, color = self.playerMo:getColorName()

	self._imagecolor.color = color
end

function PartyGamePlayerHead:setScoreAddAnim(isPlay, value)
	if isPlay then
		gohelper.setActive(self._txtscoreadd.gameObject, true)

		self._txtscoreadd.text = "+" .. value

		TaskDispatcher.runDelay(self.onScoreAddAnimEnd, self, 1)
	else
		gohelper.setActive(self._txtscoreadd, false)
	end
end

function PartyGamePlayerHead:onScoreAddAnimEnd()
	gohelper.setActive(self._txtscoreadd, false)
end

function PartyGamePlayerHead:setAddScoreScale(scale)
	transformhelper.setLocalScale(self._txtscoreadd.transform, scale, scale, scale)
end

return PartyGamePlayerHead
