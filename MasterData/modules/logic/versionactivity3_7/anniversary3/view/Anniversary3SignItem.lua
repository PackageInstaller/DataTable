-- chunkname: @modules/logic/versionactivity3_7/anniversary3/view/Anniversary3SignItem.lua

module("modules.logic.versionactivity3_7.anniversary3.view.Anniversary3SignItem", package.seeall)

local Anniversary3SignItem = class("Anniversary3SignItem", LuaCompBase)

function Anniversary3SignItem:init(go)
	self.go = go
	self._goBg = gohelper.findChild(self.go, "bg")
	self._txtDay = gohelper.findChildText(self.go, "#txt_day")
	self._goTomorrowTag = gohelper.findChild(self.go, "#go_TomorrowTag")
	self._gorewardicon = gohelper.findChild(self.go, "reward2/#go_itemicon")
	self._imagerare = gohelper.findChildImage(self.go, "reward2/image_bg")
	self._txtrewardcount = gohelper.findChildText(self.go, "reward2/txt_rewardcount")
	self._gocanget = gohelper.findChild(self.go, "#go_canget")
	self._btncanget = gohelper.findChildButtonWithAudio(self.go, "#go_canget")
	self._gohasget = gohelper.findChild(self.go, "#go_hasget")
	self._gohasgetmask = gohelper.findChild(self.go, "#go_hasget/bgmask")
	self._btnlatter = gohelper.findChildButtonWithAudio(self.go, "#go_hasget/#btn_latter")

	gohelper.setActive(self.go, true)

	self._anim = self.go:GetComponent(gohelper.Type_Animator)
	self._itemClick = gohelper.getClickWithAudio(self._goBg)
	self._itemClick2 = gohelper.getClickWithAudio(self._gohasgetmask)

	if self._gorewardicon then
		gohelper.setActive(self._gorewardicon, true)

		self._item = IconMgr.instance:getCommonItemIcon(self._gorewardicon)
	end

	self._actId = VersionActivity3_7Enum.ActivityId.Anniversary3Sign

	self:_addEvents()
end

function Anniversary3SignItem:_addEvents()
	self._btnlatter:AddClickListener(self._onbtnlatterOnClick, self)
	self._btncanget:AddClickListener(self._onItemClick, self)
	self._itemClick:AddClickListener(self._onItemClick, self)
	self._itemClick2:AddClickListener(self._onItemClick, self)
end

function Anniversary3SignItem:_removeEvents()
	self._btnlatter:RemoveClickListener()
	self._btncanget:RemoveClickListener()
	self._itemClick:RemoveClickListener()
	self._itemClick2:RemoveClickListener()
end

function Anniversary3SignItem:_onbtnlatterOnClick()
	local data = {}

	data.day = self._index

	Anniversary3Controller.instance:openAnniversary3SignRoleTalkView(data)
end

function Anniversary3SignItem:_onItemClick()
	AudioMgr.instance:trigger(AudioEnum.UI.Store_Good_Click)

	if not ActivityModel.instance:isActOnLine(self._actId) then
		GameFacade.showToast(ToastEnum.BattlePass)

		return
	end

	local couldGet = ActivityType101Model.instance:isType101RewardCouldGet(self._actId, self._index)

	if couldGet then
		Activity101Rpc.instance:sendGet101BonusRequest(self._actId, self._index, self._onBonusGetDone, self)

		return
	end

	local co = ActivityConfig.instance:getNorSignActivityCo(self._actId, self._index)
	local itemCo = string.splitToNumber(co.bonus, "#")

	MaterialTipController.instance:showMaterialInfo(itemCo[1], itemCo[2])
end

function Anniversary3SignItem:_onBonusGetDone(cmd, resultCode)
	if resultCode ~= 0 then
		return
	end

	local data = {}

	data.day = self._index

	Anniversary3Controller.instance:openAnniversary3SignRoleTalkView(data)
end

function Anniversary3SignItem:refresh(index, mo)
	self._mo = mo
	self._index = index

	if index < 10 then
		self._txtDay.text = "0" .. index or index
	end

	local rewardGet = ActivityType101Model.instance:isType101RewardGet(self._actId, index)
	local couldGet = ActivityType101Model.instance:isType101RewardCouldGet(self._actId, index)

	gohelper.setActive(self._gohasget, rewardGet)
	gohelper.setActive(self._gocanget, couldGet)

	if not self._item then
		return
	end

	local co = ActivityConfig.instance:getNorSignActivityCo(self._actId, index)
	local itemCo = string.splitToNumber(co.bonus, "#")
	local itemCfg = ItemModel.instance:getItemConfig(itemCo[1], itemCo[2])

	if not itemCfg.rare then
		UISpriteSetMgr.instance:setRoomSprite(self._imagerare, "huangyuan_pz_" .. CharacterEnum.Color[itemCfg.rare])

		self._txtrewardcount.text = luaLang("multiple") .. itemCo[3]

		local totalday = ActivityType101Model.instance:getType101LoginCount(self._actId)

		gohelper.setActive(self._goTomorrowTag, index == totalday + 1)
		self._item:setMOValue(itemCo[1], itemCo[2], itemCo[3])
		self._item:isShowQuality(false)
		self._item:isShowCount(false)
		self._item:customOnClickCallback(self._onItemClick, self)
	end
end

function Anniversary3SignItem:destroy()
	self:_removeEvents()
end

return Anniversary3SignItem
