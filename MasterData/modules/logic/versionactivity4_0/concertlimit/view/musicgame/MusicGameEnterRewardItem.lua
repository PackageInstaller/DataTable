-- chunkname: @modules/logic/versionactivity4_0/concertlimit/view/musicgame/MusicGameEnterRewardItem.lua

module("modules.logic.versionactivity4_0.concertlimit.view.musicgame.MusicGameEnterRewardItem", package.seeall)

local MusicGameEnterRewardItem = class("MusicGameEnterRewardItem", LuaCompBase)

function MusicGameEnterRewardItem:init(go)
	self.go = go
	self._golight = gohelper.findChild(self.go, "go_light")
	self._goreward = gohelper.findChild(self.go, "go_reward")
	self._goicon = gohelper.findChild(self.go, "go_reward/go_icon")
	self._imagequality = gohelper.findChildImage(self.go, "go_reward/go_icon/image_quality")
	self._goitem = gohelper.findChild(self.go, "go_reward/go_icon/item")
	self._txtcount = gohelper.findChildText(self.go, "go_reward/go_icon/count")
	self._gocanget = gohelper.findChild(self.go, "go_reward/go_canget")
	self._btnclick = gohelper.findChildButtonWithAudio(self.go, "go_reward/go_canget/btn_click")
	self._goreceive = gohelper.findChild(self.go, "go_reward/go_receive")
	self._gopoint = gohelper.findChild(self.go, "go_point")
	self._gopointlight = gohelper.findChild(self.go, "go_point/go_pointlight")
	self._gopointgrey = gohelper.findChild(self.go, "go_point/go_pointgrey")
	self._txtgrad = gohelper.findChildText(self.go, "go_point/txt_grad")
	self._txtpoint = gohelper.findChildText(self.go, "go_point/txt_point")

	self:_initItem()
end

function MusicGameEnterRewardItem:_initItem()
	gohelper.setActive(self.go, true)

	self._actId = VersionActivity4_0Enum.ActivityId.ConcertMusicGame

	gohelper.setActive(self._goreward, true)
	self:_addEvents()
end

function MusicGameEnterRewardItem:_addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function MusicGameEnterRewardItem:_removeEvents()
	self._btnclick:RemoveClickListener()
end

function MusicGameEnterRewardItem:_btnclickOnClick()
	local canget = MusicGameModel.instance:isRewardCanGet(self._config.rewardId, self._actId)

	if not canget then
		return
	end

	Activity234Rpc.instance:sendAct234AcceptRewardRequest(self._actId)
end

function MusicGameEnterRewardItem:hideRewardState(hide)
	self._hideState = hide
end

function MusicGameEnterRewardItem:refresh(co)
	self._config = co

	gohelper.setActive(self._golight, self._config.isBigReward >= 1)

	local rewards = string.splitToNumber(self._config.bonus, "#")

	self._itemIcon = self._itemIcon or IconMgr.instance:getCommonItemIcon(self._goitem)

	self._itemIcon:setMOValue(rewards[1], rewards[2], rewards[3])
	self._itemIcon:isShowQuality(false)
	self._itemIcon:isShowCount(false)

	self._txtcount.text = luaLang("multiple") .. rewards[3]

	local itemCfg = ItemModel.instance:getItemConfig(rewards[1], rewards[2], true)

	if not itemCfg.rare then
		UISpriteSetMgr.instance:setSeasonSprite(self._imagequality, "img_pz_" .. itemCfg.rare)

		local canget = MusicGameModel.instance:isRewardCanGet(self._config.rewardId, self._actId)

		gohelper.setActive(self._gocanget, not self._hideState and canget)

		local hasget = MusicGameModel.instance:isRewardGet(self._config.rewardId, self._actId)

		gohelper.setActive(self._goreceive, not self._hideState and hasget)

		self._txtpoint.text = self._config.coinNum
		self._txtgrad.text = self._config.coinNum

		local showPoint = canget or hasget

		gohelper.setActive(self._gopointgrey, not showPoint)
		gohelper.setActive(self._gopointlight, showPoint)
		gohelper.setActive(self._txtpoint.gameObject, showPoint)
		gohelper.setActive(self._txtgrad.gameObject, not showPoint)
	end
end

function MusicGameEnterRewardItem:destroy()
	self:_removeEvents()
end

return MusicGameEnterRewardItem
