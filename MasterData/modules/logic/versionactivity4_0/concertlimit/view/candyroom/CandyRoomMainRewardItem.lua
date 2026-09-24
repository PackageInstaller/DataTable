-- chunkname: @modules/logic/versionactivity4_0/concertlimit/view/candyroom/CandyRoomMainRewardItem.lua

local changeState = require("modules.logic.sp01.assassinChase.view.AssassinChaseGameView").changeState

module("modules.logic.versionactivity4_0.concertlimit.view.candyroom.CandyRoomMainRewardItem", package.seeall)

local CandyRoomMainRewardItem = class("CandyRoomMainRewardItem")

function CandyRoomMainRewardItem:init(go)
	self.go = go
	self._gonormain = gohelper.findChild(self.go, "go_normain")
	self._gonormainbg = gohelper.findChild(self._gonormain, "bg")
	self._gonormainicon = gohelper.findChild(self._gonormain, "go_icon")
	self._gonormainiconitem = gohelper.findChild(self._gonormainicon, "go_item")
	self._simagenormainicon = gohelper.findChildSingleImage(self._gonormainicon, "simage_icon")
	self._gonormainnum = gohelper.findChild(self._gonormain, "go_num")
	self._txtnormainnum = gohelper.findChildText(self._gonormainnum, "txt_num")
	self._gonormainremainnum = gohelper.findChild(self._gonormain, "#go_remainnum")
	self._txtnormainremainnum = gohelper.findChildText(self._gonormainremainnum, "#txt_nornum")
	self._txtnormainname = gohelper.findChildText(self._gonormain, "txt_name")
	self._gonormainhasget = gohelper.findChild(self._gonormain, "go_hasget")
	self._btnnormainclick = gohelper.findChildButtonWithAudio(self._gonormain, "btn_click")
	self._gosp = gohelper.findChild(self.go, "go_sp")
	self._gospbg = gohelper.findChild(self._gosp, "bg")
	self._simagespicon = gohelper.findChildSingleImage(self._gosp, "simage_spicon")
	self._simagespitem = gohelper.findChildSingleImage(self._gosp, "image_itembg/image_item")
	self._gospnum = gohelper.findChild(self._gosp, "go_num")
	self._txtspnum = gohelper.findChildText(self._gospnum, "txt_num")
	self._simagespname = gohelper.findChildSingleImage(self._gosp, "simage_spname")
	self._gospuse = gohelper.findChild(self._gosp, "go_use")
	self._gosphasget = gohelper.findChild(self._gosp, "go_hasget")
	self._btnspclick = gohelper.findChildButtonWithAudio(self._gosp, "btn_click")

	self:_initItem()
	self:_addEvents()
end

function CandyRoomMainRewardItem:_initItem()
	self._norAnim = self._gonormain:GetComponent(typeof(UnityEngine.Animator))
	self._spAnim = self._gosp:GetComponent(typeof(UnityEngine.Animator))
	self._norgetAnim = self._gonormainhasget:GetComponent(typeof(UnityEngine.Animator))
	self._spgetAnim = self._gosphasget:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(self._gonormainhasget, false)
	gohelper.setActive(self._gosphasget, false)

	self._hideTip = false
end

function CandyRoomMainRewardItem:_addEvents()
	self._btnnormainclick:AddClickListener(self._onBtnClick, self)
	self._btnspclick:AddClickListener(self._onBtnClick, self)
	CandyRoomController.instance:registerCallback(CandyRoomEvent.OnShowSummonSelectFinished, self._showSummonRewardAnim, self)
end

function CandyRoomMainRewardItem:_removeEvents()
	self._btnnormainclick:RemoveClickListener()
	self._btnspclick:RemoveClickListener()
	CandyRoomController.instance:unregisterCallback(CandyRoomEvent.OnShowSummonSelectFinished, self._showSummonRewardAnim, self)
end

function CandyRoomMainRewardItem:hideNameAndTip(hide)
	self._hideTip = hide

	gohelper.setActive(self._txtnormainname.gameObject, not self._hideTip)
	gohelper.setActive(self._gonormainremainnum, not self._hideTip and self._rewardCo.availableTime > 1 and self._getCount < self._rewardCo.availableTime)
	gohelper.setActive(self._simagespname.gameObject, not self._hideTip)
end

function CandyRoomMainRewardItem:_showSummonRewardAnim(rewardId, summonType)
	if rewardId ~= self._rewardId then
		return
	end

	if self._isSp then
		self._spAnim:Play("get", 0, 0)
	else
		self._norAnim:Play("get", 0, 0)

		if not self._getCount then
			local getCount = 0

			if summonType and summonType ~= CandyRoomEnum.SummonType.Single then
				getCount = getCount + 1
			end

			gohelper.setActive(self._gonormainremainnum, not self._hideTip and self._rewardCo.availableTime > 1 and getCount < self._rewardCo.availableTime)

			if getCount < self._rewardCo.availableTime then
				self._txtnormainremainnum.text = GameUtil.getSubPlaceholderLuaLang(luaLang("candyroom_limitgetcount"), {
					self._rewardCo.availableTime - getCount
				})
			end

			gohelper.setActive(self._gonormainhasget, getCount >= self._rewardCo.availableTime)
		end
	end
end

function CandyRoomMainRewardItem:_onBtnClick()
	local rewardList = GameUtil.splitString2(self._rewardCo.reward, true)
	local hasGet = self._getCount >= self._rewardCo.availableTime
	local itemCount = ItemModel.instance:getItemQuantity(self._itemCos[1], self._itemCos[2])
	local showUse = hasGet and itemCount > 0

	MaterialTipController.instance:showMaterialInfo(rewardList[1][1], rewardList[1][2], showUse)
end

function CandyRoomMainRewardItem:refresh(rewardCo)
	self._rewardCo = rewardCo
	self._rewardId = rewardCo.id
	self._isSp = self._rewardCo and self._rewardCo.isSp and self._rewardCo.isSp == 1
	self._itemCos = string.splitToNumber(self._rewardCo.reward, "#")
	self._itemCo, self._itemIcon = ItemModel.instance:getItemConfigAndIcon(self._itemCos[1], self._itemCos[2])

	gohelper.setActive(self._gosp, self._isSp)
	gohelper.setActive(self._gonormain, not self._isSp)

	self._getCount = CandyRoomModel.instance:getSummonedCountByRewardId(self._rewardId)

	local waitShowCount = CandyRoomModel.instance:getWaitShowRewardsCount(self._rewardId)

	self._getCount = self._getCount - waitShowCount

	if self._isSp then
		self:_refreshSp()
	else
		self:_refreshNorMain()
	end

	self._hasInit = true
end

function CandyRoomMainRewardItem:getRewardId()
	return self._rewardId
end

function CandyRoomMainRewardItem:_refreshSp()
	gohelper.setActive(self._simagespname.gameObject, true)

	local hasGet = self._getCount >= self._rewardCo.availableTime
	local iconName = hasGet and string.format("%smask", self._rewardCo.spMainIcon) or self._rewardCo.spMainIcon

	self._simagespname:LoadImage(ResUrl.getV4a0ConcertCandyRoomLangIcon(self._rewardCo.spMainTitle))
	self._simagespicon:LoadImage(ResUrl.getV4a0ConcertCandyRoomSingleBg(iconName))
	gohelper.setActive(self._gospnum, self._itemCos[3] > 1)

	self._txtspnum.text = self._itemCos[3]

	self._simagespitem:LoadImage(self._itemIcon)
	self._spAnim:Play("idle", 0, 0)

	local itemCount = ItemModel.instance:getItemQuantity(self._itemCos[1], self._itemCos[2])
	local showUse = hasGet and itemCount > 0

	gohelper.setActive(self._gospuse, showUse)
	gohelper.setActive(self._gosphasget, hasGet and not showUse)

	if self._hasInit and hasGet and not showUse and not self._gosphasget.activeSelf then
		self._spgetAnim:Play("open", 0, 0)
	else
		self._spgetAnim:Play("idle", 0, 0)
	end
end

function CandyRoomMainRewardItem:_refreshNorMain()
	local showSpIcon = not LuaUtil.isEmptyStr(self._rewardCo.mainShowIcon)

	gohelper.setActive(self._simagenormainicon.gameObject, showSpIcon)
	gohelper.setActive(self._gonormainiconitem.gameObject, not showSpIcon)

	if showSpIcon then
		self._simagenormainicon:LoadImage(ResUrl.getV4a0ConcertCandyRoomSingleBg(self._rewardCo.mainShowIcon))
	else
		self._item = self._item or IconMgr.instance:getCommonItemIcon(self._gonormainiconitem)

		self._item:setMOValue(self._itemCos[1], self._itemCos[2], self._itemCos[3])
		self._item:setCanShowDeadLine(false)
		self._item:isShowCount(false)
		self._item:isShowName(false)
		self._item:isShowQuality(false)
	end

	self._norAnim:Play("idle", 0, 0)
	gohelper.setActive(self._gonormainnum, self._itemCos[3] > 1)

	self._txtnormainnum.text = self._itemCos[3]
	self._txtnormainname.text = self._itemCo.name

	gohelper.setActive(self._gonormainremainnum, not self._hideTip and self._rewardCo.availableTime > 1 and self._getCount < self._rewardCo.availableTime)

	if self._rewardCo.availableTime > 1 and self._getCount < self._rewardCo.availableTime then
		self._txtnormainremainnum.text = GameUtil.getSubPlaceholderLuaLang(luaLang("candyroom_limitgetcount"), {
			self._rewardCo.availableTime - self._getCount
		})
	end

	gohelper.setActive(self._gonormainhasget, self._getCount >= self._rewardCo.availableTime)

	if self._getCount >= self._rewardCo.availableTime and not self._gonormainhasget.activeSelf then
		local animName = self._hasInit and "open" or "idle"

		self._norgetAnim:Play(animName, 0, 0)
	end
end

function CandyRoomMainRewardItem:destroy()
	self._simagespitem:UnLoadImage()
	self._simagespicon:UnLoadImage()
	self._simagespname:UnLoadImage()
	self:_removeEvents()
end

return CandyRoomMainRewardItem
