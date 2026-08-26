-- chunkname: @modules/logic/versionactivity3_4/goldenmilletpresent/view/V3a4_GoldenMilletPresentDisplayView.lua

module("modules.logic.versionactivity3_4.goldenmilletpresent.view.V3a4_GoldenMilletPresentDisplayView", package.seeall)

local V3a4_GoldenMilletPresentDisplayView = class("V3a4_GoldenMilletPresentDisplayView", BaseViewExtended)

function V3a4_GoldenMilletPresentDisplayView:onInitView()
	gohelper.setActive(self.viewGO, true)

	self._skinItemList = {}

	for i = 1, GoldenMilletEnum.DISPLAY_SKIN_COUNT do
		local skinItem = self:getUserDataTb_()
		local btnChildPath = string.format("present%s/#btn_Present", i)
		local btnPresent = gohelper.findChildButtonWithAudio(self.viewGO, btnChildPath)

		skinItem.go = gohelper.findChild(self.viewGO, "present" .. i)
		skinItem.txtskin = gohelper.findChildText(skinItem.go, "img_namebg/txt" .. i)
		skinItem.txtname = gohelper.findChildText(skinItem.txtskin.gameObject, "txt_name" .. i)

		if btnPresent then
			skinItem.btn = btnPresent
		end

		table.insert(self._skinItemList, skinItem)
	end

	self._goHasReceiveTip = gohelper.findChild(self.viewGO, "#go_ReceiveTip")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")
	self._btnGoto = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Goto")
	self._btnBgClose = gohelper.findChildButtonWithAudio(self.viewGO, "close")
	self._txtReceiveRemainTime = gohelper.findChildText(self.viewGO, "image_TimeBG/#txt_remainTime")
	self._rewardItemList = {}

	for i = 1, 2 do
		local item = self:getUserDataTb_()

		item.go = gohelper.findChild(self.viewGO, "#scroll_Reward/Viewport/Content/#go_rewarditem" .. i)
		item.imgBg = gohelper.findChildImage(item.go, "go_icon")
		item.goIcon = gohelper.findChild(item.go, "go_icon/icon")

		table.insert(self._rewardItemList, item)
	end

	self._actId = GoldenMilletPresentModel.instance:getGoldenMilletPresentActId()
end

function V3a4_GoldenMilletPresentDisplayView:addEvents()
	for i, skinItem in ipairs(self._skinItemList) do
		skinItem.btn:AddClickListener(self._btnPresentOnClick, self, i)
	end

	if self._btnClose then
		self._btnClose:AddClickListener(self._btnCloseOnClick, self)
	end

	if self._btnBgClose then
		self._btnBgClose:AddClickListener(self._btnCloseOnClick, self)
	end

	if self._btnGoto then
		self._btnGoto:AddClickListener(self._btnGotoOnClick, self)
	end
end

function V3a4_GoldenMilletPresentDisplayView:removeEvents()
	for _, skinItem in ipairs(self._skinItemList) do
		skinItem.btn:RemoveClickListener()
	end

	if self._btnClose then
		self._btnClose:RemoveClickListener()
	end

	if self._btnBgClose then
		self._btnBgClose:RemoveClickListener()
	end

	if self._btnGoto then
		self._btnGoto:RemoveClickListener()
	end
end

function V3a4_GoldenMilletPresentDisplayView:_btnPresentOnClick(index)
	local isOpen = GoldenMilletPresentModel.instance:isGoldenMilletPresentOpen(true)

	if not isOpen then
		return
	end

	local isGood = index > 2

	if isGood then
		if not GoldenMilletEnum.Index2Good[index] then
			local id = GoldenMilletEnum.Index2Skin[index]

			if not isGood then
				CharacterController.instance:openCharacterSkinTipView({
					isShowHomeBtn = false,
					skinId = id
				})
			else
				local goodMo = StoreModel.instance:getGoodsMO(tonumber(id))

				if not goodMo then
					return
				end

				ViewMgr.instance:openView(ViewName.StoreSkinPreviewView, {
					goodsMO = StoreModel.instance:getGoodsMO(tonumber(id))
				})
			end
		end
	end
end

function V3a4_GoldenMilletPresentDisplayView:_btnCloseOnClick()
	self:closeThis()
end

function V3a4_GoldenMilletPresentDisplayView:_btnGotoOnClick()
	GameFacade.jump(10173)
end

function V3a4_GoldenMilletPresentDisplayView:onOpen()
	self:refreshRemainTime()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
	TaskDispatcher.runRepeat(self.refreshRemainTime, self, TimeUtil.OneMinuteSecond)

	local haveReceived = GoldenMilletPresentModel.instance:haveReceivedSkin()

	gohelper.setActive(self._goHasReceiveTip, haveReceived)
	AudioMgr.instance:trigger(AudioEnum.UI.GoldenMilletDisplayViewOpen)
	self:_initName()
	self:_initReward()
end

function V3a4_GoldenMilletPresentDisplayView:_initReward()
	local temp = ActivityConfig.instance:getNorSignActivityCo(self._actId, 1).bonus
	local config = GameUtil.splitString2(temp, true)

	for index, rewardItem in ipairs(self._rewardItemList) do
		local co = config[index]
		local type, id, num = co[1], co[2], co[3]
		local config, icon = ItemModel.instance:getItemConfigAndIcon(type, id, true)

		rewardItem.itemIcon = IconMgr.instance:getCommonPropItemIcon(rewardItem.goIcon)

		rewardItem.itemIcon:setMOValue(type, id, num, nil, true)
		UISpriteSetMgr.instance:setCommonSprite(rewardItem.imgBg, "bgequip" .. config.rare)
	end
end

function V3a4_GoldenMilletPresentDisplayView:_initName()
	for index, skinItem in ipairs(self._skinItemList) do
		local skinId = GoldenMilletEnum.Index2Skin[index]
		local skinCo = SkinConfig.instance:getSkinCo(skinId)
		local heroConfig = HeroConfig.instance:getHeroCO(skinCo.characterId)

		skinItem.txtskin.text = skinCo.characterSkin
		skinItem.txtname.text = "— " .. heroConfig.name
	end
end

function V3a4_GoldenMilletPresentDisplayView:refreshRemainTime()
	local actId = GoldenMilletPresentModel.instance:getGoldenMilletPresentActId()
	local actInfoMo = ActivityModel.instance:getActMO(actId)
	local timeStr = actInfoMo:getRemainTimeStr3(false, true)

	self._txtReceiveRemainTime.text = string.format(luaLang("remain"), timeStr)
end

function V3a4_GoldenMilletPresentDisplayView:onClose()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
end

function V3a4_GoldenMilletPresentDisplayView:onDestroy()
	for _, btnPresent in ipairs(self._btnPresentList) do
		btnPresent:RemoveClickListener()
	end
end

return V3a4_GoldenMilletPresentDisplayView
