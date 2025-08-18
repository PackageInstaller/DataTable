-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\SeasonPlay\\SeasonPlaySkinPoolDlg.lua

local ResColor = require("ClientData/ResColor")
local ResShopExchg = require("ClientData/ResShopExchg")
local ResSeasonSkinShow = require("ClientData/ResSeasonSkinShow")
local DrawCardUtils = require("UI/DrawCard/DrawCardUtils")
local ActivityPanelMixin = require("UI/OpActivity/ActivityPanelMixin")
local ResItem = require("ClientData/ResItem")
local SeasonPlaySkinPoolDlg = Class("SeasonPlaySkinPoolDlg", UIControls.Window)

MixinClass(SeasonPlaySkinPoolDlg, ActivityPanelMixin)

function SeasonPlaySkinPoolDlg:initUI(...)
	self.btnClose = UIControls.Button(self, "BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnProbability = UIControls.Button(self, "MainInfoPanel/BtnProbability")

	self.btnProbability:addEventClick(self.onBtnProbabilityClick)

	self.btnDrawLog = UIControls.Button(self, "MainInfoPanel/BtnDrawLog")

	self.btnDrawLog:addEventClick(self.onBtnDrawLogClick)

	self.btnOne = UIControls.Button(self, "MainInfoPanel/DollMachinePanel/GetAwardPanel/BtnOne")

	self.btnOne:addEventClick(self.onBtnOneClick)

	self.btnTen = UIControls.Button(self, "MainInfoPanel/DollMachinePanel/GetAwardPanel/BtnTen")

	self.btnTen:addEventClick(self.onBtnTenClick)

	self.btnUp = UIControls.Button(self, "MainInfoPanel/DollMachinePanel/GetAwardPanel/BtnUp")

	self.btnUp:addEventClick(self.onBtnUpClick)

	self.btnMore1 = UIControls.Button(self, "MainInfoPanel/DollMachinePanel/HeroSkinPanel1/BtnMore")

	self.btnMore1:addEventClick(self.onBtnMore1Click)

	self.btnMore2 = UIControls.Button(self, "MainInfoPanel/DollMachinePanel/HeroSkinPanel2/BtnMore")

	self.btnMore2:addEventClick(self.onBtnMore2Click)

	self.btnBuff = UIControls.Button(self, "MainInfoPanel/DollMachinePanel/HeroSkinPanel1/BtnBuff")

	self.btnBuff:addEventClick(self.onBtnBuff1Click)

	self.btnBuff = UIControls.Button(self, "MainInfoPanel/DollMachinePanel/HeroSkinPanel2/BtnBuff")

	self.btnBuff:addEventClick(self.onBtnBuff2Click)

	self.txtBuffs = {}
	self.nmlPanels = {}
	self.soldoutPanels = {}
	self.buffPanels = {}
	self.uIClickThroughs = {}
	self.nmlPanel1 = UIControls.Panel(self, "MainInfoPanel/DollMachinePanel/HeroSkinPanel1/NmlPanel")

	table.insert(self.nmlPanels, self.nmlPanel1)

	self.soldoutPanel1 = UIControls.Panel(self, "MainInfoPanel/DollMachinePanel/HeroSkinPanel1/SoldoutPanel")

	table.insert(self.soldoutPanels, self.soldoutPanel1)

	self.txtBuff1 = UIControls.Label(self, "MainInfoPanel/DollMachinePanel/HeroSkinPanel1/BuffPanel/TextBuff")

	table.insert(self.txtBuffs, self.txtBuff1)

	self.buffPanel1 = UIControls.Panel(self, "MainInfoPanel/DollMachinePanel/HeroSkinPanel1/BuffPanel")

	table.insert(self.buffPanels, self.buffPanel1)

	self.uIClickThrough1 = UIControls.Button(self, "MainInfoPanel/DollMachinePanel/HeroSkinPanel1/BuffPanel/UIClickThrough")

	self.uIClickThrough1:addEventClick(self.onUIClickThrough1Click)
	table.insert(self.uIClickThroughs, self.uIClickThrough1)

	self.nmlPanel2 = UIControls.Panel(self, "MainInfoPanel/DollMachinePanel/HeroSkinPanel2/NmlPanel")

	table.insert(self.nmlPanels, self.nmlPanel2)

	self.soldoutPanel2 = UIControls.Panel(self, "MainInfoPanel/DollMachinePanel/HeroSkinPanel2/SoldoutPanel")

	table.insert(self.soldoutPanels, self.soldoutPanel2)

	self.txtBuff2 = UIControls.Label(self, "MainInfoPanel/DollMachinePanel/HeroSkinPanel2/BuffPanel/TextBuff")

	table.insert(self.txtBuffs, self.txtBuff2)

	self.buffPanel2 = UIControls.Image(self, "MainInfoPanel/DollMachinePanel/HeroSkinPanel2/BuffPanel")

	table.insert(self.buffPanels, self.buffPanel2)

	self.uIClickThrough2 = UIControls.Button(self, "MainInfoPanel/DollMachinePanel/HeroSkinPanel2/BuffPanel/UIClickThrough")

	self.uIClickThrough2:addEventClick(self.onUIClickThrough2Click)
	table.insert(self.uIClickThroughs, self.uIClickThrough2)

	self.imgOneNml = UIControls.Image(self, "MainInfoPanel/DollMachinePanel/GetAwardPanel/BtnOne/ImgNml")
	self.imgTenNml = UIControls.Image(self, "MainInfoPanel/DollMachinePanel/GetAwardPanel/BtnTen/ImgNml")
	self.imgNmls = {}

	table.insert(self.imgNmls, self.imgOneNml)
	table.insert(self.imgNmls, self.imgTenNml)

	self.imgDis1 = UIControls.Image(self, "MainInfoPanel/DollMachinePanel/GetAwardPanel/BtnOne/ImgDis")
	self.imgDis2 = UIControls.Image(self, "MainInfoPanel/DollMachinePanel/GetAwardPanel/BtnTen/ImgDis")
	self.imgDiss = {}

	table.insert(self.imgDiss, self.imgDis1)
	table.insert(self.imgDiss, self.imgDis2)

	self.iconCoin1 = UIControls.Image(self, "MainInfoPanel/DollMachinePanel/GetAwardPanel/BtnOne/Icon")
	self.iconCoin2 = UIControls.Image(self, "MainInfoPanel/DollMachinePanel/GetAwardPanel/BtnTen/Icon")
	self.txtNumOne = UIControls.Label(self, "MainInfoPanel/DollMachinePanel/GetAwardPanel/BtnOne/TextNum")
	self.txtNumTen = UIControls.Label(self, "MainInfoPanel/DollMachinePanel/GetAwardPanel/BtnTen/TextNum")
	self.upPaneNormal = UIControls.Panel(self, "MainInfoPanel/DollMachinePanel/GetAwardPanel/GamePlayPanel/UpPaneNormal")
	self.upPaneL = UIControls.Panel(self, "MainInfoPanel/DollMachinePanel/GetAwardPanel/GamePlayPanel/UpPaneL")
	self.upPaneR = UIControls.Panel(self, "MainInfoPanel/DollMachinePanel/GetAwardPanel/GamePlayPanel/UpPaneR")
	self.efxL = UIControls.Panel(self, "MainInfoPanel/DollMachinePanel/GetAwardPanel/BtnUp/UpPanel/EfxL")
	self.efxR = UIControls.Panel(self, "MainInfoPanel/DollMachinePanel/GetAwardPanel/BtnUp/UpPanel/EfxR")
	self.upPanel = UIControls.Panel(self, "MainInfoPanel/DollMachinePanel/GetAwardPanel/BtnUp/UpPanel")
	self.emptyUpPanel = UIControls.Panel(self, "MainInfoPanel/DollMachinePanel/GetAwardPanel/BtnUp/EmptyPanel")
	self.iconUp = UIControls.Image(self, "MainInfoPanel/DollMachinePanel/GetAwardPanel/BtnUp/UpPanel/Icon")
	self.txtUpTitle = UIControls.Label(self, "MainInfoPanel/DollMachinePanel/GetAwardPanel/BtnUp/UpPanel/TextTitle")
	self.soldOutPanel = UIControls.Panel(self, "MainInfoPanel/DollMachinePanel/GetAwardPanel/BtnUp/SoldOutPanel")
	self.pieces = {}
	self.pieces[1] = {}
	self.pieces[2] = {}
	self.canExchgRedDot = {}
	self.mapItemIdToIndex = {}
	self.flyMap = {}

	for index = 1, 2 do
		local rPath = "MainInfoPanel/DollMachinePanel/HeroSkinPanel" .. index .. "/PiecePanel"

		self.canExchgRedDot[index] = UIControls.Panel(self, rPath .. "/BtnExchange/IconNew")

		for iindex = 1, 4 do
			self.pieces[index][iindex] = {}

			local path = rPath .. "/GridPiece" .. iindex

			self.pieces[index][iindex].panel = UIControls.Panel(self, path)
			self.pieces[index][iindex].txt = UIControls.Label(self, path .. "/TextNum")
			self.pieces[index][iindex].efx = UIControls.LazyEffectPlayer(self, path .. "/Efx")
			self.pieces[index][iindex].icon = UIControls.Image(self, path .. "/Icon")
			self.pieces[index][iindex].btn = UIControls.Button(self, path)

			self.pieces[index][iindex].btn:addEventClick(self.onGridPiecesClick)
		end
	end

	self.piecePanels = {}
	self.piecePanel1 = UIControls.Panel(self, "MainInfoPanel/DollMachinePanel/HeroSkinPanel1/PiecePanel")
	self.piecePanel2 = UIControls.Panel(self, "MainInfoPanel/DollMachinePanel/HeroSkinPanel2/PiecePanel")

	table.insert(self.piecePanels, self.piecePanel1)
	table.insert(self.piecePanels, self.piecePanel2)

	self.btnExchange1 = UIControls.Button(self, "MainInfoPanel/DollMachinePanel/HeroSkinPanel1/PiecePanel/BtnExchange")

	self.btnExchange1:addEventClick(self.onBtnExchange1Click)

	self.btnExchange2 = UIControls.Button(self, "MainInfoPanel/DollMachinePanel/HeroSkinPanel2/PiecePanel/BtnExchange")

	self.btnExchange2:addEventClick(self.onBtnExchange2Click)

	self.modelStages = {}
	self.btnStore = UIControls.Button(self, "MainInfoPanel/BtnStore")

	self.btnStore:addEventClick(self.onBtnStoreClick)

	self.attentionSwitch = UIControls.Toggle(self, "MainInfoPanel/DollMachinePanel/GetAwardPanel/BgSkip/AttentionSwitch")

	self.attentionSwitch:addEventValueChanged(self.onToggleChange)

	self.aniGamePlayPanel = UIControls.UIAni(self, "MainInfoPanel/DollMachinePanel/GetAwardPanel/GamePlayPanel")

	self.aniGamePlayPanel:addEventFinish(self.aniFinishCallBack)

	if UIControls.checkControlFunc(self, "limitNumPanel") then
		self.limitNumPanel = UIControls.Panel(self, "limitNumPanel")

		self.limitNumPanel:setVisible(false)

		self.node01 = UIControls.Panel(self, "limitNumPanel/Node01")
		self.node02 = UIControls.Panel(self, "limitNumPanel/Node02")
		self.remainTxt = UIControls.Label(self, "limitNumPanel/Node01/TextNum01")
	end

	self.imgDrawBoxs = {}
	self.canExchg = {}

	for index = 1, 5 do
		local path = "MainInfoPanel/DollMachinePanel/GetAwardPanel/GamePlayPanel/Play" .. index .. "/ImgBox"

		self.imgDrawBoxs[index] = UIControls.Image(self, path)
	end

	self.aniHeroSkin1 = UIControls.UIAni(self, "MainInfoPanel/DollMachinePanel/HeroSkinPanel1")

	self.aniHeroSkin1:addEventFinish(self.aniGetSkinCallBack)

	self.aniHeroSkin2 = UIControls.UIAni(self, "MainInfoPanel/DollMachinePanel/HeroSkinPanel2")

	self.aniHeroSkin2:addEventFinish(self.aniGetSkinCallBack)

	self.modelViewport = UIControls.RawImage(self, "ModelViewport")
	self.txtTime = UIControls.Label(self, "TimePanel/TxtTime")
	self.iconNewUpOnce = UIControls.Panel(self, "MainInfoPanel/IconNew")
	self.slotRefreshTextColor = Slot(self.refreshCoinTextColor, self)
end

function SeasonPlaySkinPoolDlg:_setData()
	ClientTimerManager.RemoveSecondTickUI(self.txtTime)

	local isCloseAnimation = CurAvatar:getClientUserData("SeasonDrawMainAnimation")

	if isCloseAnimation and isCloseAnimation == "1" then
		self.attentionSwitch:setOn(true)

		self.toggleIsOn = true
	else
		self.attentionSwitch:setOn(false)

		self.toggleIsOn = false
		isCloseAnimation = "0"
	end

	CurAvatar:setClientUserData("SeasonDrawMainAnimation", isCloseAnimation)

	if self.actObj then
		local leftTime = self.actObj:getRemainOpenTime()

		if leftTime >= 0 then
			ClientTimerManager.AddSecondFormatTickUI(self.txtTime, leftTime, false, Lang.get(48655))
		end

		self.actData = self.actObj.actData

		if self.actData then
			self.actData:unsetDrawCardItemReddot()
		end

		local drawData = self.actData:getResDrawFakeRandData()

		if drawData then
			self.poolId = drawData.id

			if drawData.item_id then
				self.coinItemId = drawData.item_id

				local iconData = BaseObject.getItemIconPath(drawData.item_id)

				if iconData then
					self.iconCoin1:setImage(iconData[1], iconData[2])
					self.iconCoin2:setImage(iconData[1], iconData[2])
				end

				self:refreshCoinTextColor()
				CurAvatar:registerItemChangedCallBack(self.coinItemId, self.slotRefreshTextColor)
			end
		end

		self.upPaneNormal:setVisible(true)
		self.upPaneL:setVisible(false)
		self.upPaneR:setVisible(false)
		self.efxL:setVisible(false)
		self.efxR:setVisible(false)

		self.relateObj = self.actData:getRelatedRandReplaceActObj()

		if self.relateObj and self.relateObj.actData then
			local nowSelect

			if self.relateObj.actData.randReplaceData and self.relateObj.actData.randReplaceData[1] then
				nowSelect = self.relateObj.actData.randReplaceData[1].index
			end

			self.upPaneL:setVisible(nowSelect == 1)
			self.upPaneR:setVisible(nowSelect == 2)
			self.efxL:setVisible(nowSelect == 1)
			self.efxR:setVisible(nowSelect == 2)

			if nowSelect and nowSelect ~= 0 then
				self.upPaneNormal:setVisible(false)
				self.emptyUpPanel:setVisible(false)

				local itemId = self.relateObj.actData.clientData[1][nowSelect].show_hero_id

				self.upPanel:setVisible(true)

				local iconData = BaseObject.getItemIconPath(itemId)

				if iconData then
					self.iconUp:setImage(iconData[1], iconData[2])
				end

				if ResItem[itemId] then
					self.txtUpTitle:setText(ResItem[itemId].name)
				end
			else
				self.upPanel:setVisible(false)
				self.upPaneNormal:setVisible(true)
				self.emptyUpPanel:setVisible(true)
			end
		end

		if not self.modelStage then
			local path = "ModelStage/seasonplay01"
			local resData = self.actData:getResDetailData()

			if resData and resData.show_model_path then
				path = resData.show_model_path
			end

			self.modelStage = ModelStageManager.createUIModelStage(self, path)

			self.modelStage:connectImage(self.modelViewport)
		end

		self:refreshExchagShow()
		self:setSkinShow()
	end

	self:refreshUpRedDot()
	self:_refreshRemainCount()
end

function SeasonPlaySkinPoolDlg:refreshCoinTextColor(...)
	if self.coinItemId then
		local haveNum = CurAvatar:getItemNumById(self.coinItemId)

		if haveNum >= 5 then
			self.txtNumTen:setFontColor(ResColor.WHITE)
		else
			self.txtNumTen:setFontColor(ResColor.RED)
		end

		if haveNum >= 1 then
			self.txtNumOne:setFontColor(ResColor.WHITE)
		else
			self.txtNumOne:setFontColor(ResColor.RED)
		end
	end
end

function SeasonPlaySkinPoolDlg:refreshExchagShow(...)
	local rateMap = {}
	local relateActObject = self.actData:getRelatedActivityShopActObj()

	if relateActObject and relateActObject.actData then
		local reActData = relateActObject.actData

		for id, data in pairs(reActData.clientData) do
			if ResShopExchg[id] and ResShopExchg[id].exchg and ResShopExchg[id].use then
				if not self.exChgItemId then
					self.exChgItemId = ResShopExchg[id].use[1].ID
				end

				rateMap[ResShopExchg[id].exchg[1].key] = ResShopExchg[id].use[1].discount
			end
		end
	end

	self.shopExchgData = self.actData:getResShopExchgData()

	if self.shopExchgData then
		for index = 1, 2 do
			if not self.skinIds then
				self.skinIds = {}
			end

			if not self.itemIds then
				self.itemIds = {}
			end

			local itemId = self.shopExchgData[index].exchg[1].key
			local item = BaseObject.GetObject(itemId)

			if item.subType == Const.ITEM_STYPE_UPGRADE_SKIN then
				local updradeSkinItemId = CurAvatar:getUpgradeSkinItemIdByUpgradeItemId(itemId)

				self.skinIds[index] = updradeSkinItemId
			end

			self.itemIds[index] = self.shopExchgData[index].exchg[1].key

			local needNum = 0

			if self.shopExchgData[index] and self.shopExchgData[index].use then
				for iindex = 1, 4 do
					if self.shopExchgData[index].use[iindex] then
						self.pieces[index][iindex].panel:setVisible(true)

						local itemId = self.shopExchgData[index].use[iindex].ID
						local iconData = BaseObject.getItemIconPath(itemId)

						if iconData then
							self.pieces[index][iindex].icon:setImage(iconData[1], iconData[2])
						end

						self.flyMap[itemId] = self.pieces[index][iindex].panel

						local discount = self.shopExchgData[index].use[iindex].discount
						local nowHave = CurAvatar:getItemNumById(itemId)

						self.pieces[index][iindex].txt:setText(utils.format("%1s/%2s", nowHave, discount))

						if rateMap[itemId] then
							local rate = rateMap[itemId]
							local num = math.max(0, discount - nowHave)

							needNum = needNum + rate * num
						end

						self.pieces[index][iindex].btn.itemId = itemId
					else
						self.pieces[index][iindex].panel:setVisible(false)
					end
				end
			end

			if self.exChgItemId then
				local haveNum = CurAvatar:getItemNumById(self.exChgItemId)

				self.canExchg[index] = needNum <= haveNum
			else
				self.canExchg[index] = false
			end

			if self.canExchg[index] and not self.actData:getFirstShowExchgRedDot(index) then
				self.canExchgRedDot[index]:setVisible(true)
			else
				self.canExchgRedDot[index]:setVisible(false)
			end
		end
	end
end

function SeasonPlaySkinPoolDlg:onBtnBuff2Click()
	self.buffPanel2:setVisible(true)
end

function SeasonPlaySkinPoolDlg:onBtnBuff1Click()
	self.buffPanel1:setVisible(true)
end

function SeasonPlaySkinPoolDlg:onGetSkin(skinId)
	self.getSkinId = skinId

	local ui = UIManager.tryGetUI("seasonPlayExchangeDlg")

	if ui and ui:getVisible() then
		ui:setVisible(false)
	end

	local ui = UIManager.tryGetUI("seasonPlayShowAwardDlg")

	if ui and ui:getVisible() then
		ui:hideBtnAgain()
	end
end

function SeasonPlaySkinPoolDlg:checkGetSkinShow(...)
	if self.getSkinId then
		if self.itemIds then
			if self.itemIds[1] == self.getSkinId then
				self.aniHeroSkin1:startAni("GetHeroSkin", true)
			end

			if self.itemIds[2] == self.getSkinId then
				self.aniHeroSkin2:startAni("GetHeroSkin", true)
			end
		end
	else
		self:refreshUI()
	end
end

function SeasonPlaySkinPoolDlg:aniGetSkinCallBack(animCon, animName)
	if self.getSkinId then
		local showUi = UIManager.getUI("seasonPlayGetSkinDlg", true)

		if showUi then
			showUi:setSkinItemId(self.getSkinId)
		end

		self.getSkinId = nil

		self:refreshUI()
	end
end

function SeasonPlaySkinPoolDlg:setSkinShow(...)
	self.allHave = true

	for index = 1, 2 do
		if self.itemIds and self.itemIds[index] then
			local skinId = self.skinIds[index]
			local itemId = self.itemIds[index]

			if ResSeasonSkinShow and ResSeasonSkinShow[skinId] then
				self.txtBuffs[index]:setText(ResSeasonSkinShow[skinId].desc)
			elseif ResSeasonSkinShow[itemId] then
				self.txtBuffs[index]:setText(ResSeasonSkinShow[itemId].desc)
			end

			local have
			local item = BaseObject.GetObject(itemId)

			if item.subType == Const.ITEM_STYPE_UPGRADE_SKIN then
				have = CurAvatar:hasGetHeroSkin(skinId)

				if CurAvatar:getItemNumById(itemId) > 0 then
					have = true
				end
			else
				have = CurAvatar:hasGetHeroSkin(itemId)
			end

			self.piecePanels[index]:setVisible(not have)
			self.nmlPanels[index]:setVisible(not have)
			self.soldoutPanels[index]:setVisible(have)

			if not have then
				self.allHave = false
			end
		else
			self.allHave = false
		end
	end

	for index = 1, 2 do
		self.imgNmls[index]:setVisible(not self.allHave)
		self.imgDiss[index]:setVisible(self.allHave)
	end

	self.soldOutPanel:setVisible(self.allHave)

	if self.allHave then
		self.upPanel:setVisible(false)
		self.emptyUpPanel:setVisible(false)
	end
end

function SeasonPlaySkinPoolDlg:_refreshRemainCount(...)
	if self.limitNumPanel and CurAvatar:dayDrawCountLimitOpen() then
		self.limitNumPanel:setVisible(true)

		local todayRemain = CurAvatar:getDrawDayCount(self.actObj.opId, Const.DayDrawMaxCountFree)

		if todayRemain >= Const.DayDrawMaxCountFree then
			self.node01:setVisible(false)
			self.node02:setVisible(true)
		else
			self.node01:setVisible(true)
			self.node02:setVisible(false)
			self.remainTxt:setText(todayRemain .. "/" .. Const.DayDrawMaxCountFree)
		end
	end
end

function SeasonPlaySkinPoolDlg:onDrawResp(items)
	self.drawGetItems = items

	if self.toggleIsOn then
		self:openResultDlgAndRefreshUI()
	else
		for index, data in pairs(items or {}) do
			local itemId = data.item.id
			local showData = CurAvatar:getItemSeasonDrawShowData(itemId)
			local iconName = "IconSeasonPlay01"
			local iconPath = "Atlas/SeasonPlayCommon/SeasonPlayCommonAtlas04"

			iconName = showData and showData.quality and (showData.quality == Const.SEASON_DRAW_ITEM_QUALITY_YELLOW and "IconSeasonPlay02" or showData.quality == Const.SEASON_DRAW_ITEM_QUALITY_RED and "IconSeasonPlay03") or iconName

			self.imgDrawBoxs[index]:setImage(iconPath, iconName)
		end

		if #items == 1 then
			self.aniGamePlayPanel:startAni("SkinPoolOnce", true)
		else
			self.aniGamePlayPanel:startAni("SkinPoolMultiple", true)
		end
	end
end

function SeasonPlaySkinPoolDlg:aniFinishCallBack(...)
	self:openResultDlgAndRefreshUI()
end

function SeasonPlaySkinPoolDlg:openResultDlgAndRefreshUI(...)
	local ui = UIManager.getUI("seasonPlayShowAwardDlg", true)

	if ui then
		ui:setDrawData(self.actObj.actId, self.coinItemId)
		ui:setData(self.drawGetItems)

		for id, obj in pairs(self.flyMap or {}) do
			ui:setSpecialCustomizeFlyConfig(id, obj)
		end
	end
end

function SeasonPlaySkinPoolDlg:onToggleChange(sender, isOn)
	local isCloseAnimation = isOn == true and "1" or "0"

	self.toggleIsOn = isOn

	CurAvatar:setClientUserData("SeasonDrawMainAnimation", isCloseAnimation)
end

function SeasonPlaySkinPoolDlg:refreshUI()
	self:_setData()
end

function SeasonPlaySkinPoolDlg:onBtnOneClick()
	if not self.allHave then
		self:onButtonDrawClick(1)
	else
		MsgManager.notice(Lang.get(111314))
	end
end

function SeasonPlaySkinPoolDlg:onBtnTenClick()
	if not self.allHave then
		self:onButtonDrawClick(5)
	else
		MsgManager.notice(Lang.get(111314))
	end
end

function SeasonPlaySkinPoolDlg:onButtonDrawClick(num)
	if self.coinItemId then
		local haveNum = CurAvatar:getItemNumById(self.coinItemId)

		if num <= haveNum then
			DrawCardUtils.realDrawOpActCard(self.actObj.actId, num, Const.DrawCostTypeItem, self.coinItemId, num)
		else
			CurAvatar:jumpToShowItem(self.coinItemId, self.mWindow)
		end
	end
end

function SeasonPlaySkinPoolDlg:onGridPiecesClick(sender)
	if sender and sender.itemId then
		CurAvatar:jumpToShowItem(sender.itemId, self.mWindow)
	end
end

function SeasonPlaySkinPoolDlg:onBtnProbabilityClick()
	UIManager.getUI("seasonPlayProbabilityDlg", true):setData(self.actObj)
end

function SeasonPlaySkinPoolDlg:onBtnUpClick()
	local data = CurAvatar:getClientUserData("SeasonDrawOnceUpRedDot")

	if self.actObj then
		data = data or {}
		data[self.actObj.actId] = true
	end

	CurAvatar:setClientUserData("SeasonDrawOnceUpRedDot", data)
	UIManager.getUI("seasonPlayUpDlg", true):setData(self.relateObj, self.actObj)
end

function SeasonPlaySkinPoolDlg:refreshUpRedDot()
	local data = CurAvatar:getClientUserData("SeasonDrawOnceUpRedDot")
	local needShow = true

	if self.actObj and self.actObj.actId and data and data[self.actObj.actId] then
		needShow = false
	end

	self.iconNewUpOnce:setVisible(needShow and not self.allHave)
end

function SeasonPlaySkinPoolDlg:onBtnDrawLogClick()
	local ui = UIManager.getUI("seasonPlayDrawLogDlg", true)

	if ui then
		ui:setData(self.actObj)
	end
end

function SeasonPlaySkinPoolDlg:onBtnMoreClick(index)
	if index and self.skinIds[index] then
		BaseObject.ShowObjectTips(self.skinIds[index], index)
	elseif index and self.itemIds[index] then
		BaseObject.ShowObjectTips(self.itemIds[index], index)
	end
end

function SeasonPlaySkinPoolDlg:onBtnMore1Click()
	self:onBtnMoreClick(1)
end

function SeasonPlaySkinPoolDlg:onBtnMore2Click()
	self:onBtnMoreClick(2)
end

function SeasonPlaySkinPoolDlg:onBtnExchangeClick(index)
	if self.canExchg[index] and self.actData then
		self.actData:setFirstShowExchgRedDot(index)
	end

	UIManager.getUI("seasonPlayExchangeDlg", true):setData(self.actObj, index)
end

function SeasonPlaySkinPoolDlg:onBtnExchange1Click()
	self:onBtnExchangeClick(1)
end

function SeasonPlaySkinPoolDlg:onBtnExchange2Click()
	self:onBtnExchangeClick(2)
end

function SeasonPlaySkinPoolDlg:onUIClickThrough1Click()
	self.buffPanel1:setVisible(false)
end

function SeasonPlaySkinPoolDlg:onUIClickThrough2Click()
	self.buffPanel2:setVisible(false)
end

function SeasonPlaySkinPoolDlg:onBtnStoreClick()
	if self.actData then
		local resData = self.actData:getResDetailData()

		if resData and resData.jump_shop_id then
			JumpGuideManager.jump(resData.jump_shop_id)
		end
	end
end

function SeasonPlaySkinPoolDlg:onBtnCloseClick()
	self:setVisible(false)
end

function SeasonPlaySkinPoolDlg:destroy()
	if self.coinItemId then
		CurAvatar:unregisterItemChangedCallBack(self.coinItemId, self.slotRefreshTextColor)
	end

	SeasonPlaySkinPoolDlg.super.destroy(self)
end

return SeasonPlaySkinPoolDlg
