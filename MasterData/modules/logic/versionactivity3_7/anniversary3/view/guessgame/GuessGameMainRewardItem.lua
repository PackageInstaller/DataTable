-- chunkname: @modules/logic/versionactivity3_7/anniversary3/view/guessgame/GuessGameMainRewardItem.lua

module("modules.logic.versionactivity3_7.anniversary3.view.guessgame.GuessGameMainRewardItem", package.seeall)

local GuessGameMainRewardItem = class("GuessGameMainRewardItem", LuaCompBase)

function GuessGameMainRewardItem:init(go)
	self.go = go
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
	self._txtpoint = gohelper.findChildText(self.go, "go_point/txt_point")

	gohelper.setActive(self.go, true)

	self._actId = VersionActivity3_7Enum.ActivityId.Anniversary3GuessGame

	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function GuessGameMainRewardItem:_btnclickOnClick()
	local canget = GuessGameModel.instance:isRewardCanGet(self._config.rewardId, self._actId)

	if not canget then
		return
	end

	Activity234Rpc.instance:sendAct234AcceptRewardRequest(self._actId)
end

function GuessGameMainRewardItem:refresh(co)
	self._config = co
	self._txtpoint.text = self._config.coinNum

	local rewards = string.splitToNumber(self._config.bonus, "#")

	self._itemIcon = IconMgr.instance:getCommonItemIcon(self._goitem)

	self._itemIcon:setMOValue(rewards[1], rewards[2], rewards[3])
	self._itemIcon:isShowQuality(false)
	self._itemIcon:isShowCount(false)

	self._txtcount.text = luaLang("multiple") .. rewards[3]

	local itemCfg = ItemModel.instance:getItemConfig(rewards[1], rewards[2], true)

	if not itemCfg.rare then
		UISpriteSetMgr.instance:setSeasonSprite(self._imagequality, "img_pz_" .. itemCfg.rare)

		local canget = GuessGameModel.instance:isRewardCanGet(self._config.rewardId, self._actId)

		gohelper.setActive(self._gocanget, canget)

		local hasget = GuessGameModel.instance:isRewardGet(self._config.rewardId, self._actId)

		gohelper.setActive(self._goreceive, hasget)

		local showPoint = canget or hasget

		gohelper.setActive(self._gopointgrey, not showPoint)
		gohelper.setActive(self._gopointlight, showPoint)
	end
end

function GuessGameMainRewardItem:destroy()
	self._btnclick:RemoveClickListener()
end

return GuessGameMainRewardItem
