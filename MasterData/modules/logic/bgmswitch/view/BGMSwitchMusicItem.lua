-- chunkname: @modules/logic/bgmswitch/view/BGMSwitchMusicItem.lua

module("modules.logic.bgmswitch.view.BGMSwitchMusicItem", package.seeall)

local BGMSwitchMusicItem = class("BGMSwitchMusicItem")

function BGMSwitchMusicItem:init(go)
	self.go = go
	self._gorandom = gohelper.findChild(go, "random")
	self._imagerandombg = gohelper.findChildImage(go, "random/image_randombg")
	self._imageselect = gohelper.findChildImage(go, "random/randomitemselected")
	self._btnrandomitem = gohelper.getClickWithAudio(self._imagerandombg.gameObject)
	self._gorandomselected = gohelper.findChild(go, "random/randomitemselected")
	self._imagerandomicon = gohelper.findChildImage(go, "random/image_randomicon")
	self._txtrandom = gohelper.findChildText(go, "random/txt_random")
	self._txtrandomen = gohelper.findChildText(go, "random/txt_random/txt_randomEn")
	self._gorandommusic = gohelper.findChild(go, "random/randommusic")
	self._gonormal = gohelper.findChild(go, "normal")
	self._imagenormalbg = gohelper.findChildImage(go, "normal/image_normalbg")
	self._txtnormalname = gohelper.findChildText(go, "normal/txt_ItemName")
	self._btnlike = gohelper.findChildButton(go, "normal/btnlike")
	self._golikeBg = gohelper.findChild(go, "normal/btnlike/image_LikeBG")
	self._golike = gohelper.findChild(go, "normal/btnlike/golike")
	self._golikeEffect = gohelper.findChild(go, "normal/btnlike/golike/image_Like/love_select")
	self._gonormalselected = gohelper.findChild(go, "normal/normalitemselected ")
	self._gonormalmusic = gohelper.findChild(go, "normal/normalmusic")
	self._musicAni = self._gonormalmusic:GetComponent(typeof(UnityEngine.Animation))
	self._btnnormalitem = gohelper.getClickWithAudio(self._imagenormalbg.gameObject)

	local reddotParentGO = gohelper.findChild(go, "reddot")

	self._itemRedDotComp = RedDotController.instance:addNotEventRedDot(reddotParentGO, self._isNotRead, self)
	self._isSelected = false

	self:addEvents()
end

function BGMSwitchMusicItem:addEvents()
	self._btnrandomitem:AddClickListener(self._btnrandomitemOnClick, self)
	self._btnnormalitem:AddClickListener(self._btnnormalitemOnClick, self)
	self._btnlike:AddClickListener(self._btnlikeOnClick, self)
	BGMSwitchController.instance:registerCallback(BGMSwitchEvent.BgmFavorite, self._refreshItem, self)
	BGMSwitchController.instance:registerCallback(BGMSwitchEvent.BgmMarkRead, self._bgmMarkRead, self)
end

function BGMSwitchMusicItem:removeEvents()
	self._btnrandomitem:RemoveClickListener()
	self._btnnormalitem:RemoveClickListener()
	self._btnlike:RemoveClickListener()
	BGMSwitchController.instance:unregisterCallback(BGMSwitchEvent.BgmFavorite, self._refreshItem, self)
	BGMSwitchController.instance:unregisterCallback(BGMSwitchEvent.BgmMarkRead, self._bgmMarkRead, self)
end

function BGMSwitchMusicItem:_btnrandomitemOnClick()
	local isRandom = BGMSwitchModel.instance:isRandomMode()

	if isRandom then
		return
	end

	local prevBgmId = BGMSwitchModel.instance:getCurBgm()

	BGMSwitchModel.instance:setCurBgm(BGMSwitchModel.RandomBgmId)
	BGMSwitchController.instance:dispatchEvent(BGMSwitchEvent.ItemSelected)

	local currSelBgmList = BGMSwitchModel.instance:getCurrentUsingBgmList()

	StatController.instance:track(StatEnum.EventName.SwitchBGM, {
		[StatEnum.EventProperties.AudioId] = "",
		[StatEnum.EventProperties.AudioName] = "",
		[StatEnum.EventProperties.BeforeSwitchAudio] = BGMSwitchConfig.instance:getBgmName(prevBgmId),
		[StatEnum.EventProperties.OperationType] = "click Random",
		[StatEnum.EventProperties.PlayMode] = "Random",
		[StatEnum.EventProperties.AudioSheet] = BGMSwitchConfig.instance:getBgmNames(currSelBgmList)
	})
	BGMSwitchAudioTrigger.play_ui_replay_tapswitch()
end

function BGMSwitchMusicItem:_btnnormalitemOnClick()
	local isRandom = BGMSwitchModel.instance:isRandomMode()
	local prevBgmId = BGMSwitchModel.instance:getCurBgm()

	if not isRandom and prevBgmId == self._config.id then
		return
	end

	BGMSwitchModel.instance:setCurBgm(self._config.id)
	BGMSwitchController.instance:dispatchEvent(BGMSwitchEvent.ItemSelected, prevBgmId)

	local currSelBgmList = BGMSwitchModel.instance:getCurrentUsingBgmList()

	StatController.instance:track(StatEnum.EventName.SwitchBGM, {
		[StatEnum.EventProperties.AudioId] = tostring(self._config.id),
		[StatEnum.EventProperties.AudioName] = self._config.audioName,
		[StatEnum.EventProperties.BeforeSwitchAudio] = BGMSwitchConfig.instance:getBgmName(prevBgmId),
		[StatEnum.EventProperties.OperationType] = "click Loop",
		[StatEnum.EventProperties.PlayMode] = "LoopOne",
		[StatEnum.EventProperties.AudioSheet] = BGMSwitchConfig.instance:getBgmNames(currSelBgmList)
	})
	BGMSwitchAudioTrigger.play_ui_replay_tapswitch()
end

function BGMSwitchMusicItem:_btnlikeOnClick()
	local favorite = not BGMSwitchModel.instance:isBgmFavorite(self._config.id)

	gohelper.setActive(self._golikeEffect, true)
	BgmRpc.instance:sendSetFavoriteBgmRequest(self._config.id, favorite)
	BGMSwitchAudioTrigger.play_ui_replay_heart(favorite)
end

function BGMSwitchMusicItem:setItem(mo)
	if not mo then
		self._random = true
	else
		self._random = false
		self._mo = mo
		self._config = BGMSwitchConfig.instance:getBGMSwitchCO(mo.bgmId)
	end

	gohelper.setActive(self._gorandom, self._random)
	gohelper.setActive(self._gonormal, not self._random)
	self:_refreshItem()
end

function BGMSwitchMusicItem:_refreshItem()
	self._isSelected = false

	if self._random then
		self:_setRandom()
	else
		self:_setNormal()
	end

	self:_refreshRedDot()
end

function BGMSwitchMusicItem:_refreshRedDot()
	if self._itemRedDotComp then
		self._itemRedDotComp:refreshRedDot()
	end
end

function BGMSwitchMusicItem:_bgmMarkRead(bgmId)
	if not self._random and self._config and bgmId == self._config.id then
		self:_refreshRedDot()
	end
end

function BGMSwitchMusicItem:_isNotRead()
	return (false or nil) and true
end

function BGMSwitchMusicItem:_setRandom()
	self._isSelected = BGMSwitchModel.instance:isRandomMode()

	gohelper.setActive(self._gorandomselected, self._isSelected)

	local isUsedRandomBgmId = BGMSwitchModel.instance:isRandomBgmId(BGMSwitchModel.instance:getUsedBgmIdFromServer()) and BGMSwitchModel.instance:isLocalRemoteListTypeMatched()

	gohelper.setActive(self._gorandommusic, isUsedRandomBgmId)
end

function BGMSwitchMusicItem:_setNormal()
	self._txtnormalname.text = self._config.audioName

	local isLoopOne = BGMSwitchModel.instance:isLoopOneMode()

	self._isSelected = BGMSwitchModel.instance:getCurBgm() == self._config.id and isLoopOne

	gohelper.setActive(self._gonormalselected, self._isSelected)

	local isLove = BGMSwitchModel.instance:isBgmFavorite(self._config.id)

	gohelper.setActive(self._golike, isLove)
	gohelper.setActive(self._golikeBg, not isLove)

	local isPlaying = BGMSwitchModel.instance:getUsedBgmIdFromServer() == self._config.id and BGMSwitchModel.instance:isLocalRemoteListTypeMatched()

	gohelper.setActive(self._gonormalmusic, isPlaying)
	UISpriteSetMgr.instance:setBgmSwitchToggleSprite(self._imagenormalbg, self._config.audioBg)

	if self._isSelected and self:_isNotRead() then
		BgmRpc.instance:sendReadBgmRequest(self._config.id)
	end
end

function BGMSwitchMusicItem:isSelected()
	return self._isSelected
end

function BGMSwitchMusicItem:hide(hide)
	gohelper.setActive(self._golikeEffect, false)
	gohelper.setActive(self.go, not hide)

	self._musicAni.enabled = false
end

function BGMSwitchMusicItem:showSwitchEffect()
	self._musicAni.enabled = true

	self._musicAni:Play()
end

function BGMSwitchMusicItem:setRandom(random)
	self._random = random
end

function BGMSwitchMusicItem:destroy()
	self:removeEvents()
end

return BGMSwitchMusicItem
