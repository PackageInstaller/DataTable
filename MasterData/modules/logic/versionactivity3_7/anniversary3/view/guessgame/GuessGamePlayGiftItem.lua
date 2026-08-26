-- chunkname: @modules/logic/versionactivity3_7/anniversary3/view/guessgame/GuessGamePlayGiftItem.lua

module("modules.logic.versionactivity3_7.anniversary3.view.guessgame.GuessGamePlayGiftItem", package.seeall)

local GuessGamePlayGiftItem = class("GuessGamePlayGiftItem", LuaCompBase)

function GuessGamePlayGiftItem:init(go, index)
	self.go = go
	self._index = index
	self._anim = self.go:GetComponent(gohelper.Type_Animator)
	self._goopen = gohelper.findChild(self.go, "root/open")
	self._imagegift = gohelper.findChildImage(self.go, "root/open/#image_gift")
	self._goscore = gohelper.findChild(self.go, "root/open/score")
	self._txtadd = gohelper.findChildText(self.go, "root/open/score/#txt_add")
	self._txtreduce = gohelper.findChildText(self.go, "root/open/score/#txt_reduce")
	self._goresult = gohelper.findChild(self.go, "root/open/result")
	self._gowrong = gohelper.findChild(self.go, "root/open/result/wrong")
	self._gocorrect = gohelper.findChild(self.go, "root/open/result/correct")
	self._gounopen = gohelper.findChild(self.go, "root/unopen")
	self._goselect = gohelper.findChild(self.go, "root/unopen/select")
	self._gounselect = gohelper.findChild(self.go, "root/unopen/unselect")
	self._goclick = gohelper.findChild(self.go, "root/clickarea")
	self._btnclick = gohelper.getClick(self._goclick)

	gohelper.setActive(self.go, true)
	gohelper.setActive(self._goselect, false)
	gohelper.setActive(self._goscore, false)
	gohelper.setActive(self._goresult, false)
	self:_addEvents()
end

function GuessGamePlayGiftItem:_addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function GuessGamePlayGiftItem:_removeEvents()
	self._btnclick:RemoveClickListener()
end

function GuessGamePlayGiftItem:showItem(show)
	gohelper.setActive(self.go, show)
end

function GuessGamePlayGiftItem:showSelect(show)
	gohelper.setActive(self._goselect, show)
end

function GuessGamePlayGiftItem:playAnim(animName)
	self._anim:Play(animName, 0, 0)
end

function GuessGamePlayGiftItem:showResult(show, isRight)
	gohelper.setActive(self._goresult, show)

	if not show then
		return
	end

	gohelper.setActive(self._gowrong, not isRight)
	gohelper.setActive(self._gocorrect, isRight)

	if not isRight then
		AudioMgr.instance:trigger(AudioEnum3_7.Anniversary3.play_ui_beiai_kapai_red)
	end
end

function GuessGamePlayGiftItem:showScore(show, score)
	gohelper.setActive(self._goscore, show)

	if not show then
		return
	end

	gohelper.setActive(self._txtadd.gameObject, score > 0)
	gohelper.setActive(self._txtreduce.gameObject, score < 0)

	if score > 0 then
		self._txtadd.text = "+" .. score
	else
		self._txtreduce.text = score
	end
end

function GuessGamePlayGiftItem:_btnclickOnClick()
	if not self._enableClick then
		return
	end

	if self._clickCallback then
		self._clickCallback(self._clickCallbackObj, self._index)
	end
end

function GuessGamePlayGiftItem:showOpen(show)
	gohelper.setActive(self._goopen, show)
	gohelper.setActive(self._gounopen, not show)
	gohelper.setActive(self._gounselect, not show)
end

function GuessGamePlayGiftItem:enableClick(enable)
	self._enableClick = enable

	if not enable then
		self._clickCallback = nil
		self._clickCallbackObj = nil
	end
end

function GuessGamePlayGiftItem:refresh(giftId)
	self._giftId = giftId
	self._config = Activity234Config.instance:getBoxGiftCo(giftId)

	UISpriteSetMgr.instance:setV3a7Activity3ndSprite(self._imagegift, self._config.icon)
end

function GuessGamePlayGiftItem:getGiftId()
	return self._giftId or 1
end

function GuessGamePlayGiftItem:setClickCallback(callback, callbackObj)
	self._enableClick = true
	self._clickCallback = callback
	self._clickCallbackObj = callbackObj
end

function GuessGamePlayGiftItem:destroy()
	self._clickCallback = nil
	self._clickCallbackObj = nil

	self:_removeEvents()
end

return GuessGamePlayGiftItem
