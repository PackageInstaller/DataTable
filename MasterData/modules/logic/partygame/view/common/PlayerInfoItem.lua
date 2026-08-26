-- chunkname: @modules/logic/partygame/view/common/PlayerInfoItem.lua

module("modules.logic.partygame.view.common.PlayerInfoItem", package.seeall)

local PlayerInfoItem = class("PlayerInfoItem", ListScrollCellExtend)

function PlayerInfoItem:onInitView()
	self._trans = self.viewGO.transform
	self._anim = gohelper.findComponentAnim(self.viewGO)
	self._gonormal = gohelper.findChild(self.viewGO, "#go_normal")
	self._bg = gohelper.findChildImage(self.viewGO, "#go_normal/#image_bg")
	self._goscoreeffect = gohelper.findChild(self.viewGO, "#go_normal/#image_bg/img_light")
	self._color = gohelper.findChildImage(self.viewGO, "#go_normal/#image_color")
	self._numbg = gohelper.findChildImage(self.viewGO, "#go_normal/#lvbg/#image_numbg")
	self._txtnum = gohelper.findChildText(self.viewGO, "#go_normal/#lvbg/#txt_num")
	self._gohead = gohelper.findChild(self.viewGO, "#go_normal/#lvbg/#image_head/#go_model")
	self._txtname = gohelper.findChildText(self.viewGO, "#go_normal/#txt_name")
	self._txtscore = gohelper.findChildText(self.viewGO, "#go_normal/#txt_score")
	self._goself = gohelper.findChild(self.viewGO, "#go_self")
	self._bgmain = gohelper.findChildImage(self.viewGO, "#go_self/#image_bg")
	self._goscoreeffectmain = gohelper.findChildImage(self.viewGO, "#go_self/#image_bg/img_light")
	self._colormain = gohelper.findChildImage(self.viewGO, "#go_self/#image_color")
	self._numbgmain = gohelper.findChildImage(self.viewGO, "#go_self/#lvbg/#image_numbg")
	self._txtselfnum = gohelper.findChildText(self.viewGO, "#go_self/#lvbg/#txt_self_num")
	self._goheadmain = gohelper.findChild(self.viewGO, "#go_self/#lvbg/#image_head/#go_model")
	self._txtselfname = gohelper.findChildText(self.viewGO, "#go_self/#txt_self_name")
	self._txtselfscore = gohelper.findChildText(self.viewGO, "#go_self/#txt_self_score")
	self._txt_addscore = gohelper.findChildText(self.viewGO, "#go_normal/#txt_addscore")
	self._txt_addscore_self = gohelper.findChildText(self.viewGO, "#go_self/#txt_addscore")

	gohelper.setActive(self._txt_addscore.gameObject, false)
	gohelper.setActive(self._txt_addscore_self.gameObject, false)
	gohelper.setActive(self._goscoreeffect, false)
	gohelper.setActive(self._goscoreeffectmain, false)

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PlayerInfoItem:addEvents()
	return
end

function PlayerInfoItem:removeEvents()
	return
end

function PlayerInfoItem:Init(mo)
	self._mo = mo
	self._txtname.text = mo:getColorName()
	self._txtselfname.text = mo:getColorName()
	self._lastScore = 0
	self._lastRank = 0
	self._nowIndex = nil
	self._isMain = false

	if mo:isMainPlayer() then
		local spine = MonoHelper.addNoUpdateLuaComOnceToGo(self._goheadmain or self._gohead, CommonPartyGamePlayerSpineComp)

		spine:initSpine(mo.uid)
		spine:enableSpineUpdate(false)
		self:onUpdateMO()
	end
end

function PlayerInfoItem:ShowMainPlayer()
	self._isMain = self._mo:isMainPlayer()

	gohelper.setActive(self._gonormal, not self._isMain)
	gohelper.setActive(self._goself, self._isMain)
	gohelper.setActive(self._go, true)
	self:onUpdateMO()
end

function PlayerInfoItem:getRank()
	return self.rank
end

function PlayerInfoItem:onUpdateMO()
	local score = 0

	self.rank = 0

	local isFinish
	local curGame = PartyGameController.instance:getCurPartyGame()

	if self._mo ~= nil and curGame ~= nil then
		score, isFinish = curGame:getPlayerScore(self._mo.uid)
		self.rank = curGame:getRank(self._mo.uid)
	end

	if type(score) == "number" and self._lastScore ~= score then
		PartyGameController.instance:dispatchEvent(PartyGameEvent.ScoreChange, self._mo.uid, score - self._lastScore)
	end

	self._lastScore = score
	self._lastRank = self.rank

	local isFinishChange = isFinish and not self._lastFinish

	self._lastFinish = isFinish

	self:refreshData(score, self.rank, isFinishChange)
end

function PlayerInfoItem.sort(a, b)
	if a._lastRank == b._lastRank then
		return a._mo.uid < b._mo.uid
	end

	if a._lastRank == 0 then
		return false
	end

	if b._lastRank == 0 then
		return true
	end

	return a._lastRank < b._lastRank
end

function PlayerInfoItem:updateIndex(nowIndex)
	local isForce = self._nowIndex == nil

	if nowIndex == self._nowIndex then
		return
	end

	self:killTween()

	self._nowIndex = nowIndex

	local anchorY = -(nowIndex - 1) * 120

	if isForce then
		recthelper.setAnchorY(self._trans, anchorY)

		self._anim.speed = 0

		self._anim:Play("in", 0, 0)
		self._anim:Update(0)
		TaskDispatcher.runDelay(self._playOpenAnim, self, (nowIndex - 1) * 0.05)
	else
		self._tweenId = ZProj.TweenHelper.DOAnchorPosY(self._trans, anchorY, 0.4)
	end
end

function PlayerInfoItem:_playOpenAnim()
	self._anim.speed = 1
end

function PlayerInfoItem:killTween()
	if self._tweenId then
		ZProj.TweenHelper.KillById(self._tweenId)

		self._tweenId = nil
	end
end

function PlayerInfoItem:refreshData(score, rank, isFinishChange)
	if isFinishChange or type(score) == "number" and type(self._preScore) == "number" and score > self._preScore then
		if self._isMain then
			gohelper.setActive(self._goscoreeffectmain, false)
			gohelper.setActive(self._goscoreeffectmain, true)
		else
			gohelper.setActive(self._goscoreeffect, false)
			gohelper.setActive(self._goscoreeffect, true)
		end
	end

	self._preScore = score

	if self._isMain then
		self._txtselfscore.text = tostring(score)
	else
		self._txtscore.text = tostring(score)
	end

	local rankTxt = rank

	if rank >= 4 then
		rankTxt = string.format("<color=#EFEDE3>%s</color>", rank)
	end

	if self._isMain then
		self._txtselfnum.text = rankTxt
	else
		self._txtnum.text = rankTxt
	end

	local imageIndex = (rank > 4 or rank < 1) and 4 or rank
	local _, color = self._mo:getColorName()

	if self._isMain then
		self._colormain.color = color

		UISpriteSetMgr.instance:setV3a4LaplaceSprite(self._bgmain, "v3a4_party_common_rankbg_" .. imageIndex)
		UISpriteSetMgr.instance:setV3a4LaplaceSprite(self._numbgmain, "v3a4_party_common_rankbg_" .. imageIndex .. "_1")
	else
		self._color.color = color

		UISpriteSetMgr.instance:setV3a4LaplaceSprite(self._bg, "v3a4_party_common_rankbg_" .. imageIndex)
		UISpriteSetMgr.instance:setV3a4LaplaceSprite(self._numbg, "v3a4_party_common_rankbg_" .. imageIndex .. "_1")
	end
end

function PlayerInfoItem:playScoreAdd(score)
	if self._isMain then
		self._txt_addscore_self.text = "+" .. score

		gohelper.setActive(self._txt_addscore_self.gameObject, true)
	else
		self._txt_addscore.text = "+" .. score

		gohelper.setActive(self._txt_addscore.gameObject, true)
	end

	TaskDispatcher.runDelay(self.onPlayScoreAddAnimEnd, self, 1.5)
end

function PlayerInfoItem:onPlayScoreAddAnimEnd()
	if self._isMain then
		gohelper.setActive(self._txt_addscore_self.gameObject, false)
	else
		gohelper.setActive(self._txt_addscore.gameObject, false)
	end
end

function PlayerInfoItem:onDestroyView()
	self._mo = nil

	self:killTween()
	TaskDispatcher.cancelTask(self._playOpenAnim, self)
	TaskDispatcher.cancelTask(self.onPlayScoreAddAnimEnd, self)
end

return PlayerInfoItem
