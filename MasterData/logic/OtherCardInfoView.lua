-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roleinfo/view/stack/OtherCardInfoView.lua

module("logic.extensions.roleinfo.view.stack.OtherCardInfoView", package.seeall)

local OtherCardInfoView = class("OtherCardInfoView", ViewComponent)

function OtherCardInfoView:ctor()
	OtherCardInfoView.super.ctor(self)
end

function OtherCardInfoView:bindEvents()
	OtherCardInfoView.super.bindEvents(self)
	self._goodEvilBtn:AddClickListener(self._onClickGooEvil, self)
	self._badgeBtn:AddClickListener(self._onClickBadge, self)
	self._petTitleBtn:AddClickListener(self._onClickPetTitle, self)
	GameUtil.addClickHandler(self._btnEditPetShow, self._onClickEditPetShow, self)
	GameUtil.addClickHandler(self._btnHideShowRule, self._onClickBtnHideShowRule, self)
	GameUtil.addClickHandler(self._btnCopy, self._onClickCopyId, self)
end

function OtherCardInfoView:unbindEvents()
	OtherCardInfoView.super.unbindEvents(self)
	self._goodEvilBtn:RemoveClickListener()
	self._badgeBtn:RemoveClickListener()
	self._petTitleBtn:RemoveClickListener()
	GameUtil.rmClickHandler(self._btnEditPetShow)
	GameUtil.rmClickHandler(self._btnHideShowRule)
	GameUtil.rmClickHandler(self._btnCopy)
end

function OtherCardInfoView:buildUI()
	OtherCardInfoView.super.buildUI(self)

	self._bg = self:getGo("bg")
	self._skin = self:getGo("skin")
	self._changeGroup = self:getGo("changeGroup"):GetComponent("UIChangeGroup")
	self.btnHead = self:getBtn("Nego_Head/ImgC_Head")

	local goHead = self:getGo("Nego_Head")

	self._goodEvilIcon = goutil.findChildComponent(self.mainGO, "Nego_Info/goodEvilIcon", "UIImageSpriteChange")
	self._goodEvilBtn = self:getBtn("Nego_Info/goodEvilIcon")
	self._ImgC_Head = goutil.findChild(goHead, "ImgC_Head/img_head")
	self.txtName = self:getTxt("Nego_Head/txtName")
	self.txtID = self:getTxt("Nego_Head/txtID")
	self.btnEditName = self:getBtn("Nego_Head/txtName/btnEditName")
	self.btnEditHead = self:getBtn("Nego_Head/btnEditHead")
	self._btnCopy = self:getGo("Nego_Head/btnCopy")
	self.txtAtk = self:getTxt("Nego_Info/maxPower/txtMaxPower")
	self._txtLocation = self:getTxt("Nego_Info/locationName/txtLocation")
	self.txtCount = self:getTxt("ScrollView/Viewport/Content/Nego_Sprite/txtSpriteNum")
	self.txtArena = self:getTxt("Nego_Info/showInfo/info_3/txtInfoNum")
	self.txtTournament = self:getTxt("Nego_Info/showInfo/info_4/txtInfoNum")
	self.txtAchievement = self:getTxt("Nego_Info/showInfo/info_5/txtInfoNum")
	self.txtFamilyBattle = self:getTxt("Nego_Info/showInfo/info_6/txtInfoNum")
	self._btnShowRule = self:getGo("Nego_Info/showInfo/info_6/btnShowRule")
	self._detailShowRule = self:getGo("detail")
	self._btnHideShowRule = self:getGo("detail/btnHide")
	self._txtDetailShowRule = self:getTxt("detail/detail/txt")
	self.btnCharmValue = self:getGo("Nego_Info/btnCharmValue")
	self.txtCharmValue = goutil.findChildTextComponent(self.btnCharmValue, "txtValue")
	self._arrow = self:getGo("arrow")

	local scrollView = self:getGo("ScrollView")

	self._scrollerTableView = Framework.ScrollRectAdapter.Get(scrollView)
	self._btnEditPetShow = goutil.findChild(self.mainGO, "ScrollView/Viewport/Content/Nego_Sprite/btnEditPetShow")
	self._petScrollerview = goutil.findChild(self.mainGO, "ScrollView/Viewport/Content/Nego_Sprite/petScrollerview")
	self._petScrollercell = goutil.findChild(self.mainGO, "ScrollView/Viewport/Content/Nego_Sprite/petScrollercell")
	self._petScrollList = ScrollerList.create(self._petScrollerview, self._petScrollercell, GameUtil.handler(self._updatePetCell, self), GameUtil.handler(self._clearPetCell, self))
	self.goLevelInfo = goutil.findChild(goHead, "levelInfo")

	if self.goLevelInfo then
		self.txtLevel2 = goutil.findChildTextComponent(self.goLevelInfo, "txtLevel")
		self.levelSliderProcess = self:getSlider("Nego_Head/levelInfo/slider")
		self.txtCurNum = goutil.findChildTextComponent(self.goLevelInfo, "txtCur")
	end

	self._txtBadgeNum = goutil.findChildTextComponent(self.mainGO, "ScrollView/Viewport/Content/Nego_Badge/txtBadgeNum")
	self._badgeBtn = self:getBtn("ScrollView/Viewport/Content/Nego_Badge/txtBadgeNum/btn")
	self._showBadgeList = {}

	for i = 1, 3 do
		local go = goutil.findChild(self.mainGO, "ScrollView/Viewport/Content/Nego_Badge/badge/item" .. i)

		table.insert(self._showBadgeList, go)
	end

	self._txtPetTitleNum = goutil.findChildTextComponent(self.mainGO, "ScrollView/Viewport/Content/Nego_PetTitle/txtPetTitleNum")
	self._petTitleBtn = self:getBtn("ScrollView/Viewport/Content/Nego_PetTitle/txtPetTitleNum/btn")
	self._showPetTitleList = {}

	for i = 1, 3 do
		local go = goutil.findChild(self.mainGO, "ScrollView/Viewport/Content/Nego_PetTitle/pettitle/item" .. i)

		table.insert(self._showPetTitleList, go)
	end

	self.a1 = self:getImg("arrow")
	self.a2 = self:getTxt("Nego_Head/levelInfo/txtLevel")
	self.a3 = self:getTxt("Nego_Head/txtName")
	self.a4 = self:getTxt("Nego_Head/txtID")
	self.a5 = self:getTxt("Nego_Head/txtID/lbName")
	self.a6 = self:getTxt("Nego_Info/btnCharmValue/txtValue")
	self.a7 = self:getTxt("Nego_Info/maxPower/txtMaxPower")
	self.a8 = self:getTxt("Nego_Info/maxPower/txtMaxPower/txt")
	self.a9 = self:getTxt("Nego_Info/locationName/txtLocation")
	self.a10 = self:getTxt("Nego_Info/locationName/txtLocation/txt")
	self.a11 = self:getTxt("Nego_Info/showInfo/info_1/txtInfoName")
	self.a12 = self:getTxt("Nego_Info/showInfo/info_1/txtInfoNum")
	self.a13 = self:getTxt("Nego_Info/showInfo/info_2/txtInfoName")
	self.a14 = self:getTxt("Nego_Info/showInfo/info_2/txtInfoNum")
	self.a15 = self:getTxt("Nego_Info/showInfo/info_3/txtInfoName")
	self.a16 = self:getTxt("Nego_Info/showInfo/info_3/txtInfoNum")
	self.a17 = self:getTxt("Nego_Info/showInfo/info_4/txtInfoName")
	self.a18 = self:getTxt("Nego_Info/showInfo/info_4/txtInfoNum")
	self.a19 = self:getImg("ScrollView/Viewport/Content/Nego_Sprite/titlebg")
	self.a20 = self:getImg("ScrollView/Viewport/Content/Nego_Sprite/titlebg/line")
	self.a21 = self:getImg("ScrollView/Viewport/Content/Nego_Sprite/Image2")
	self.a22 = self:getImg("ScrollView/Viewport/Content/Nego_PetTitle/titlebg")
	self.a23 = self:getImg("ScrollView/Viewport/Content/Nego_PetTitle/titlebg/line")
	self.a24 = self:getImg("ScrollView/Viewport/Content/Nego_PetTitle/Image")
	self.a25 = self:getImg("ScrollView/Viewport/Content/Nego_Badge/titlebg")
	self.a26 = self:getImg("ScrollView/Viewport/Content/Nego_Badge/titlebg/line")
	self.a27 = self:getImg("ScrollView/Viewport/Content/Nego_Badge/Image")
	self.a28 = self:getTxt("ScrollView/Viewport/Content/Nego_Sprite/txtSpriteTitle")
	self.a29 = self:getTxt("ScrollView/Viewport/Content/Nego_PetTitle/txtPetTitleTitle")
	self.a30 = self:getTxt("ScrollView/Viewport/Content/Nego_PetTitle/txtPetTitleNum")
	self.a31 = self:getTxt("ScrollView/Viewport/Content/Nego_PetTitle/txtPetTitleNum/Text")
	self.a32 = self:getTxt("ScrollView/Viewport/Content/Nego_Badge/txtBadgeTitle")
	self.a33 = self:getTxt("ScrollView/Viewport/Content/Nego_Badge/txtBadgeNum")
	self.a34 = self:getTxt("ScrollView/Viewport/Content/Nego_Badge/txtBadgeNum/Text")
	self.a35 = self:getImg("Nego_Info/maxPower/txtMaxPower/icon")
	self.a36 = self:getTxt("Nego_Info/maxPower/txtMaxPower")
	self.a37 = self:getTxt("Nego_Info/maxPower/txtMaxPower/txt")
	self.a38 = self:getTxt("Nego_Info/showInfo/info_5/txtInfoName")
	self.a39 = self:getTxt("Nego_Info/showInfo/info_5/txtInfoNum")
	self.a40 = self:getTxt("Nego_Info/showInfo/info_6/txtInfoName")
	self.a41 = self:getTxt("Nego_Info/showInfo/info_6/txtInfoNum")
	self.a42 = self:getTxt("ScrollView/Viewport/Content/Nego_Sprite/txtSpriteNum/txtSpriteTitle2")
	self.a43 = self:getImg("Nego_Head/levelInfo/slider/Background")
	self.a44 = self:getImg("ScrollView/Viewport/Content/Nego_Sprite/petScrollercell/zdl/img")
	self.a45 = self:getTxt("ScrollView/Viewport/Content/Nego_Sprite/petScrollercell/zdl/txt")
	self.a46 = self:getTxt("Nego_Info/maxPower/txtMaxPowerRank")
	self._nameOutline = self:getGo("Nego_Head/txtName"):GetComponent(ComponentType.OutlineEx)
	self._levelOutline = self:getGo("Nego_Head/levelInfo/txtLevel"):GetComponent(ComponentType.OutlineEx)
	self._comps = {
		self.a1,
		self.a2,
		self.a3,
		self.a4,
		self.a5,
		self.a6,
		self.a7,
		self.a8,
		self.a9,
		self.a10,
		self.a11,
		self.a12,
		self.a13,
		self.a14,
		self.a15,
		self.a16,
		self.a17,
		self.a18,
		self.a19,
		self.a20,
		self.a21,
		self.a22,
		self.a23,
		self.a24,
		self.a25,
		self.a26,
		self.a27,
		self.a28,
		self.a29,
		self.a30,
		self.a31,
		self.a32,
		self.a33,
		self.a34,
		self.a35,
		self.a36,
		self.a37,
		self.a38,
		self.a39,
		self.a40,
		self.a41,
		self.a42,
		self.a43,
		self.a44,
		self.a45,
		self.a46
	}
	self._txtMaxPowerRank = self:getTxt("Nego_Info/maxPower/txtMaxPowerRank")
	self._huawen_pettitle = self:getGo("ScrollView/Viewport/Content/Nego_PetTitle/huawen"):GetComponent(ComponentType.UIImageSpriteChange)
	self._item1_pettitle = self:getGo("ScrollView/Viewport/Content/Nego_PetTitle/pettitle/item1"):GetComponent(ComponentType.UIImageSpriteChange)
	self._item2_pettitle = self:getGo("ScrollView/Viewport/Content/Nego_PetTitle/pettitle/item2"):GetComponent(ComponentType.UIImageSpriteChange)
	self._item3_pettitle = self:getGo("ScrollView/Viewport/Content/Nego_PetTitle/pettitle/item3"):GetComponent(ComponentType.UIImageSpriteChange)
	self._huawen_badge = self:getGo("ScrollView/Viewport/Content/Nego_Badge/huawen"):GetComponent(ComponentType.UIImageSpriteChange)
	self._item1_badge = self:getGo("ScrollView/Viewport/Content/Nego_Badge/badge/item1"):GetComponent(ComponentType.UIImageSpriteChange)
	self._item2_badge = self:getGo("ScrollView/Viewport/Content/Nego_Badge/badge/item2"):GetComponent(ComponentType.UIImageSpriteChange)
	self._item3_badge = self:getGo("ScrollView/Viewport/Content/Nego_Badge/badge/item3"):GetComponent(ComponentType.UIImageSpriteChange)
	self._petShowViewCon = self:getGo("petShowViewCon")
end

function OtherCardInfoView:destroyUI()
	OtherCardInfoView.super.destroyUI(self)
end

function OtherCardInfoView:onEnter()
	OtherCardInfoView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.UpdateExterior, self._updateExteriorUI, self)
	self.addGEvent(self, GlobalNotify.CardInfoMarkPetIdxAsNew, self._markPetIdxAsNew, self)
	self.addGEvent(self, GlobalNotify.UpdateCardInfoBagPetScrollview, self._onUpdatePetColUI, self)
	self.addGEvent(self, GlobalNotify.RankDataGet, self.refresh, self)
	self._scrollerTableView:AddOnValueChanged(self._onDragScrollerEnd, self)
	goutil.setActive(self._arrow.gameObject, false)
	self:_onDragScrollerEnd()
	self:_setBagPetColVisual(false)

	self._compColors = {}
	self._compIconsName = {}
	self._compOutlineColors = {}

	self:initData()
	self:initUI()
	self:refresh()
	GameUtil.SetActive(self._btnCopy, Clipboard._checkCanUse())
end

function OtherCardInfoView:initData()
	self.curMo = RoleModel.instance:getCardInfoMo(self:_getCardBelong())

	TableUtil.printTable(self.curMo)
	self:_updateExteriorUI()

	local petCfg = CharacterConfig.instance:getPetCfg()

	self._allPetBookNum = 0

	for _, cfg in ipairs(petCfg) do
		if PetbookModel.instance:getIsHandBookPet(cfg) then
			self._allPetBookNum = self._allPetBookNum + 1
		end
	end

	self:_initColorData()
end

function OtherCardInfoView:_initColorData()
	local cfg = BattleStartAnimConfig.instance:getPlayerMessageSkinColorCfgById(self._messageSkinId)

	if cfg then
		for i = 1, #self._comps do
			table.insert(self._compColors, cfg["color" .. i])
		end

		for i = #self._comps + 1, #self._comps + 4 do
			table.insert(self._compIconsName, cfg["icon" .. i])
		end

		for i = 1, 1 do
			table.insert(self._compOutlineColors, cfg["outline" .. i])
		end
	end

	if #self._compColors <= 0 then
		printError("检查个人信息配色是不是没配 id:", self._messageSkinId)
	end
end

function OtherCardInfoView:initUI()
	for i = 1, #self._comps do
		local curComp = self._comps[i]

		if curComp == nil then
			printError("未获得的组件:" .. i)
		end

		if curComp ~= nil then
			curComp.color = Framework.ColorUtil.ParseColor(self:_checkColor(self._compColors[i]))
		end
	end

	self._huawen_pettitle:ChangeSprite(self._compIconsName[1])
	self._item1_pettitle:ChangeSprite(self._compIconsName[2])
	self._item2_pettitle:ChangeSprite(self._compIconsName[3])
	self._item3_pettitle:ChangeSprite(self._compIconsName[4])
	self._huawen_badge:ChangeSprite(self._compIconsName[1])
	self._item1_badge:ChangeSprite(self._compIconsName[2])
	self._item2_badge:ChangeSprite(self._compIconsName[3])
	self._item3_badge:ChangeSprite(self._compIconsName[4])

	local color = Framework.ColorUtil.ParseColor(self:_checkColor(self._compOutlineColors[1]))

	self._nameOutline:SetColorRGBA(color.r, color.b, color.g, color.a)
	self._levelOutline:SetColorRGBA(color.r, color.b, color.g, color.a)
end

function OtherCardInfoView:_checkColor(str)
	if not string.nilorempty(str) and string.find(str, "#") == nil then
		str = "#" .. str
	end

	return str or "#FFFFFF"
end

function OtherCardInfoView:_updateExteriorUI()
	if self.curMo.playerMessageSkinId > 0 then
		self._messageSkinId = self.curMo.playerMessageSkinId or 1
	end

	local cfg = BattleStartAnimConfig.instance:getPlayerMessageSkinCfgById(self._messageSkinId)

	GameUtil.SetActive(self._bg, self._messageSkinId <= 1)
	GameUtil.SetActive(self._skin, self._messageSkinId > 1)

	if cfg and self._messageSkinId > 1 then
		uGuiUtil.setSpriteToImage(self._skin, uGuiUtil.SpriteType.BigBg, GameUrl.getBigbgFolderUrl("exterior", cfg.bg), function(obj)
			local img = obj[1]:GetComponent(goutil.Type_UIImage)

			img.raycastTarget = false
		end, {
			self._skin
		})
	end
end

function OtherCardInfoView:_onDragScrollerEnd()
	local rate = self._scrollerTableView.scrollRect.verticalNormalizedPosition

	goutil.setActive(self._arrow.gameObject, rate >= 0.3)
end

function OtherCardInfoView:refreshHead()
	if self.curMo then
		if self.curMo:getIsMe() then
			HeadItemController.instance:setMyHeadCell(self._ImgC_Head)
		else
			HeadItemController.instance:setHeadCell(self._ImgC_Head, self.curMo.headIconId, self.curMo.headFrameId, self.curMo.vipLv)
		end
	end
end

function OtherCardInfoView:refresh()
	self.txtName.text = "" .. self.curMo.userName
	self.txtID.text = "" .. self.curMo.userId

	local petNumPer = self.curMo.petCount / self._allPetBookNum * 100

	petNumPer = math.min(100, petNumPer)
	self.txtCount.text = "" .. string.format("%.2f", petNumPer) .. "%"

	self:refreshHead()

	local kingArenaHistoryBestRank = self.curMo.kingArenaHistoryBestRank

	self.txtArena.text = kingArenaHistoryBestRank and kingArenaHistoryBestRank > 0 and langPara("第%s名", kingArenaHistoryBestRank) or lang("未上榜")

	local peakTournamentInfo = self.curMo.peakTournamentInfo

	if peakTournamentInfo and peakTournamentInfo.knockoutRank > 0 then
		self.txtTournament.text = peakTournamentInfo.isGlobal == true and langPara("全服第%s名", peakTournamentInfo.knockoutRank) or langPara("战区第%s名", peakTournamentInfo.knockoutRank)
	elseif peakTournamentInfo and peakTournamentInfo.qualifierLevelId > 0 then
		local cfg = PeakTournamentConfig.instance:getPtQuaLevelDataById(checkint(peakTournamentInfo.activityId), checkint(peakTournamentInfo.qualifierLevelId))

		self.txtTournament.text = cfg.levelName
	else
		self.txtTournament.text = lang("未上榜")
	end

	local achievementRank = self.curMo.achievementRank

	self.txtAchievement.text = ""
	self.txtAchievement.text = checknumber(achievementRank) > 0 and string.format("全服%d名", achievementRank) or "未上榜"

	local familyBattleZoneRank = self.curMo.familyBattleZoneRank
	local familyBattleSpaceRank = self.curMo.familyBattleSpaceRank

	self.txtFamilyBattle.text = familyBattleSpaceRank > 0 and langPara("全服%s名", familyBattleSpaceRank) or familyBattleZoneRank > 0 and langPara("战区%s名", familyBattleZoneRank) or lang("未上榜")
	self.txtAtk.text = self.curMo.userId == RoleModel.instance:getUserId() and "" .. GlobalModel.instance:getCurrStrength() or "" .. self.curMo.maxZdl
	self._txtLocation.text = "" .. self.curMo.location
	self._txtMaxPowerRank.text = ""

	local spaceMaxZdlRank = self.curMo.spaceMaxZdlRank

	self._txtMaxPowerRank.text = checknumber(spaceMaxZdlRank) > 0 and (checknumber(spaceMaxZdlRank) > 10000 and "(全服10000+)" or string.format("(全服%s名)", spaceMaxZdlRank)) or "(未上榜)"

	self:_onUpdatePetColUI()
	GameUtil.SetActive(self._btnEditPetShow, self:_getCardBelong() == RoleModel.CardBelong.My)

	if self.goLevelInfo then
		local playerExp = self.curMo.playerExp
		local lv = MofangModel.instance:getCurLv(playerExp)
		local levelCfg = MofangConfig.instance:getCfgById(lv)

		self.txtLevel2.text = "Lv." .. lv

		local curNum = playerExp
		local needNum = MofangModel.instance:getUpgradeNeed(lv)
		local preNeedNum = MofangModel.instance:getUpgradeNeed(lv - 1)
		local curLvNum = curNum - preNeedNum
		local curLvNeed = needNum - preNeedNum

		if lv == MofangModel.instance:getMaxLv() then
			self.levelSliderProcess:SetValue(1)

			self.txtCurNum.text = lang("满级")
		else
			local rate = curLvNum / curLvNeed

			self.levelSliderProcess:SetValue(rate)

			self.txtCurNum.text = string.format("%s/%s", curLvNum, curLvNeed)
		end
	end

	self._txtBadgeNum.text = self.curMo.badgeNum

	self:_changeBadge(self.curMo.badgeIds)

	self._txtPetTitleNum.text = self.curMo.petTitleNum

	GameUtil.SetActive(self._txtPetTitleEmpty, self.curMo.petTitleNum == 0)
	self:_updatePetTitle(self.curMo.petTitles)
	goutil.setActive(self._goodEvilIcon.gameObject, false)

	self.txtCharmValue.text = SendFlowerModel.instance:getCurShowStr(self.curMo.charmValue)

	goutil.setActive(self._detailShowRule, false)
end

function OtherCardInfoView:_changeBadge(badgeIds)
	for i = 1, #self._showBadgeList do
		local go = self._showBadgeList[i]
		local con = goutil.findChild(go, "icon")
		local change = go:GetComponent("UIImageSpriteChange")
		local starGroup = goutil.findChild(go, "starLv")

		MaterialMgr.resetAll(con)
		GameUtil.SetActive(starGroup, false)
		goutil.setActive(goutil.findChild(go, "bg"), badgeIds[i])
		change:SetState(self._messageSkinId - 1)

		if badgeIds[i] and checknumber(badgeIds[i].left) > 0 then
			local proxy = MaterialMgr.setCell(MatType.Item_Badge, badgeIds[i].left, con)

			GameUtil.setLocalScale(proxy.view.transform, 1.3, 1.3, 1)

			if proxy then
				proxy.binder:setActiveImgC_Bg(false)
				proxy.binder:setGray(false)
				proxy:setAutoTips(false)
				proxy.binder:setLevel(badgeIds[i].right)
			end

			local cfg = BadgeConfig.instance:getDefineById(badgeIds[i].left)
			local iconGroupCfg = BadgeConfig.instance:getIconGroup(cfg.iconGroupId)

			if iconGroupCfg and not iconGroupCfg[badgeIds[i].right] then
				GameUtil.SetActive(starGroup, true)

				local addLevel = badgeIds[i].right - #iconGroupCfg
				local totalCount = starGroup.transform.childCount
				local iconState = 0

				if addLevel > 0 then
					iconState = math.floor((addLevel - 1) / totalCount)
				end

				addLevel = addLevel - iconState * totalCount

				for i = 1, starGroup.transform.childCount do
					local starGo = goutil.findChild(starGroup, "star_" .. i)
					local starImgChange = starGo:GetComponent(ComponentType.UIImageSpriteChange)

					starImgChange:SetState(iconState)
					GameUtil.SetActive(starGo, i <= addLevel)
				end
			else
				GameUtil.SetActive(starGroup, false)
			end
		end
	end
end

function OtherCardInfoView:_updatePetTitle(petTitles)
	for i = 1, #self._showPetTitleList do
		local go = self._showPetTitleList[i]
		local con = goutil.findChild(go, "icon")
		local change = go:GetComponent("UIImageSpriteChange")

		MaterialMgr.resetAll(con)
		goutil.setActive(goutil.findChild(go, "bg"), petTitles[i])
		goutil.setActive(goutil.findChild(go, "txt"), petTitles[i] == nil or petTitles[i] <= 0)
		change:SetState(self._messageSkinId - 1)

		if petTitles[i] then
			local proxy = MaterialMgr.setCell(MatType.PetTitle, petTitles[i], con)

			GameUtil.setLocalScale(proxy.view.transform, 1, 1, 1)

			if proxy then
				proxy.binder:setGray(false)
				proxy:setAutoTips(false)
			end
		end
	end
end

function OtherCardInfoView:onClickPet(fmo)
	if fmo then
		local petMo = fmo:getPetMo()

		if petMo then
			UIStateManager.instance:open(ViewName.PetDetail, petMo)
		end
	end
end

function OtherCardInfoView:onEnterFinished()
	OtherCardInfoView.super.onEnterFinished(self)
end

function OtherCardInfoView:onExit()
	OtherCardInfoView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.UpdateExterior, self._updateExteriorUI, self)
	self._scrollerTableView:RemoveOnValueChanged()

	for i, go in ipairs(self._showBadgeList) do
		local con = goutil.findChild(go, "icon")

		MaterialMgr.resetAll(con)
	end

	for i, go in ipairs(self._showPetTitleList) do
		local con = goutil.findChild(go, "icon")

		MaterialMgr.resetAll(con)
	end

	self:_onClearPetCol()
	self:_clearAllMarkPetIdx()
	self:_clearAllAddEff()
	uGuiUtil.clearImage(self._skin)
end

function OtherCardInfoView:onExitFinished()
	OtherCardInfoView.super.onExitFinished(self)
end

function OtherCardInfoView:_handleChangePetFavorPetsRes()
	return
end

function OtherCardInfoView:_getCardBelong()
	return RoleModel.CardBelong.Other
end

function OtherCardInfoView:_getCardInfoMo()
	return RoleModel.instance:getCardInfoMo(self:_getCardBelong())
end

function OtherCardInfoView:_getPetIdListOfFavour()
	return self:_getCardInfoMo():getFavourPetIds()
end

function OtherCardInfoView:_isFullOfFavour()
	local maxCount = self:_getMaxCountOfFavourPet()

	return maxCount <= self:_getCardInfoMo():getFavourPetCount()
end

function OtherCardInfoView:_getMaxCountOfFavourPet()
	return 6
end

function OtherCardInfoView:_isSelectedPetOfPetId(petId)
	return self:_getCardInfoMo():isHaveFavourPet(petId)
end

function OtherCardInfoView:_isSelectedPetOfRaceId(raceId)
	return self:_getCardInfoMo():isHaveFavourPetOfRace(raceId)
end

function OtherCardInfoView:_setFavourPetIds(petId, isAdd)
	self:_getCardInfoMo():setFavourPetIds(petId, isAdd)
end

function OtherCardInfoView:_getNewIdxList()
	return self._petIdxAsNew or {}
end

function OtherCardInfoView:_markPetIdxAsNew(petIdx, isToAdd)
	if self._petIdxAsNew == nil then
		self._petIdxAsNew = {}
	end

	if isToAdd then
		if table.indexof(self._petIdxAsNew, petIdx) == false then
			table.insert(self._petIdxAsNew, petIdx)
		end
	else
		table.removebyvalue(self._petIdxAsNew, petIdx)
	end
end

function OtherCardInfoView:_clearAllMarkPetIdx()
	if self._petIdxAsNew then
		table.clear(self._petIdxAsNew)

		self._petIdxAsNew = nil
	end
end

function OtherCardInfoView:_isNewPetIdx(petIdx)
	if self._petIdxAsNew then
		return table.indexof(self._petIdxAsNew, petIdx) ~= false
	end

	return false
end

function OtherCardInfoView:_onUpdatePetColUI()
	local function reloadFinish()
		local idxList = self:_getNewIdxList()
		local index = checknumber(idxList[#idxList])
		local cellIndex = index - 1

		if cellIndex > 0 then
			local function springFinishCallback(tableview)
				local cell = self._petScrollList._tableview:GetCellAtIndex(cellIndex)
				local effRoot = cell and goutil.findChild(cell.gameObject, "item")

				if not goutil.isNil(effRoot) then
					self:_markPetIdxAsNew(index, false)
					self:_showAddEff(effRoot)
				end

				self._petScrollList._tableview:RegisterOnSetOffsetSpringFinishCallback(nil)
			end

			local offset = self._petScrollList._tableview:GetOffsetByIndex(cellIndex)
			local currOffset = self._petScrollList._tableview:GetOffset()
			local viewSize = self._petScrollList._tableview:GetViewSize()
			local cellSize = self._petScrollList._tableview:GetCellSize(cellIndex)

			if currOffset <= offset and offset <= currOffset + viewSize - cellSize then
				springFinishCallback()
			else
				self._petScrollList._tableview:RegisterOnSetOffsetSpringFinishCallback(springFinishCallback)
			end
		end

		self._petScrollList:MoveCellInView(cellIndex, true)
	end

	self._petScrollList:regReloadFinish(reloadFinish)

	local list = {}
	local belong = self:_getCardBelong()

	if belong == RoleModel.CardBelong.My then
		for idx = 1, self:_getMaxCountOfFavourPet() do
			table.insert(list, idx)
		end
	elseif belong == RoleModel.CardBelong.Other then
		for idx = 1, self:_getCardInfoMo():getFavourPetCount() do
			table.insert(list, idx)
		end
	end

	self._petScrollList:reloadData(list)
end

function OtherCardInfoView:_onClearPetCol()
	self._petScrollList:dispose()
end

function OtherCardInfoView:_updatePetCell(view, cell, petIdx, tag)
	local mainGo = cell.gameObject
	local petId = checknumber(self:_getPetIdListOfFavour()[petIdx])
	local petMo = self:_getCardInfoMo():getPetMoOfFavour(petId)
	local raceId = petMo and petMo:getDefineId() or 0
	local zdlValue = petMo and petMo:getFightingPower() or 0
	local isSelected = self:_isSelectedPetOfPetId(petId)
	local imgBg = goutil.findChild(mainGo, "imgBg")
	local item = goutil.findChild(mainGo, "item")
	local btnSelect = goutil.findChild(mainGo, "btnSelect")
	local zdlGo = goutil.findChild(mainGo, "zdl")
	local zdlImg = goutil.findChild(mainGo, "zdl/img"):GetComponent(ComponentType.Image)
	local txtZdl = goutil.findChildTextComponent(mainGo, "zdl/txt")
	local change = goutil.findChildComponent(mainGo, "zdl", "UIChangeGroup")

	GameUtil.SetActive(zdlGo, petMo ~= nil)

	if petMo then
		txtZdl.text = zdlValue
	end

	zdlImg.color = Framework.ColorUtil.ParseColor(self:_checkColor(self._compColors[44]))
	txtZdl.color = Framework.ColorUtil.ParseColor(self:_checkColor(self._compColors[45]))

	GameUtil.SetActive(imgBg, not isSelected)
	self:_clearAddEff(item)

	local isRevertBase = false

	if petMo then
		local faceId = petMo.curFaceId

		if PetskinController.instance:isClientNotShowIfNotForever(petMo.curFaceId) then
			faceId = petMo.raceId
			isRevertBase = true
		end

		local proxy = MaterialMgr.setCellByMo(petMo, item)

		proxy.binder:setAutoTips(false)
		proxy.binder:setLvl(petMo:getPetLv())
	else
		MaterialMgr.resetAll(item)
	end

	local function handler()
		local isPetSelected = self:_isSelectedPetOfPetId(petId)

		if isPetSelected then
			if petMo then
				local showPetMo = petMo

				if isRevertBase then
					showPetMo = petMo:GetClone()
					showPetMo.name = MaterialMgr.getMaterialsName(MatType.Pet, petMo.raceId)
					showPetMo.curFaceId = petMo.raceId
				end

				UIStateManager.instance:open(ViewName.PetDetail, showPetMo)
			end
		else
			self:_updateBagPetList()
			self:_setBagPetColVisual(true)
		end

		self:_onUpdatePetColUI()
	end

	GameUtil.addClickHandler(btnSelect, handler)
end

function OtherCardInfoView:_clearPetCell(cell)
	local mainGo = cell.gameObject
	local item = goutil.findChild(mainGo, "item")
	local btnSelect = goutil.findChild(mainGo, "btnSelect")

	MaterialMgr.resetAll(item)
	GameUtil.rmClickHandler(btnSelect)
end

function OtherCardInfoView:_showAddEff(mainGo)
	local effGo = mainGo
	local path = "fx_ui_zhuangbeijiemian/fx_ui_fangru_zhuangbei"

	self:_clearAddEff(mainGo)

	if effGo and not string.nilorempty(path) then
		local pathName = path .. ".prefab"

		local function func(_, eff)
			eff:setClipping(self._petScrollerview:GetComponent(goutil.Type_RectTransform))
			eff:setParent(effGo.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1, 1, 1)
		end

		if self._addEffList == nil then
			self._addEffList = {}
		end

		self._addEffList[effGo] = UIEffectManager.instance:playEffect(self, pathName, effGo, 0, 0, false, false, nil, func, nil)
	end
end

function OtherCardInfoView:_clearAllAddEff()
	if self._addEffList then
		for mainGo, eff in pairs(self._addEffList) do
			self:_clearAddEff(mainGo)
		end
	end
end

function OtherCardInfoView:_clearAddEff(mainGo)
	if self._addEffList then
		UIEffectManager.instance:stopEffect(self._addEffList[mainGo])
	end
end

function OtherCardInfoView:_updateBagPetList()
	self._bagPetMoList = {}

	if not BagPetsController.instance:getReady() then
		return
	end

	local allPets = BagPetsController.instance:getBagPets()

	for k, v in ipairs(allPets) do
		if self:onFilter(v) then
			table.insert(self._bagPetMoList, v)
		end
	end

	local limit = ConstConfig.instance:getPetLimltCount()

	if limit > 0 and limit <= #self._bagPetMoList then
		-- block empty
	else
		local names, opt = BagModel.instance:GetSortParms()

		names[1] = FormationGroupModel.checkIsInTeamByMo

		ArraySort.sortOn(self._bagPetMoList, names, opt)
	end

	self:_updateBagPetListOfSelect()
end

function OtherCardInfoView:_updateBagPetListOfSelect()
	if self._bagPetMoList == nil then
		return
	end

	local selectedList = {}
	local unselectedList = {}

	for _, petMo in ipairs(self._bagPetMoList) do
		if self:_isSelectedPetOfPetId(petMo:getPetId()) then
			table.insert(selectedList, petMo)
		else
			table.insert(unselectedList, petMo)
		end
	end

	local mergedList = {}

	for _, item in ipairs(selectedList) do
		table.insert(mergedList, item)
	end

	for _, item in ipairs(unselectedList) do
		table.insert(mergedList, item)
	end

	self._bagPetMoList = mergedList
end

function OtherCardInfoView:onFilter(pet)
	local petCo = CharacterConfig.instance:getPetCo(pet.raceId)
	local isHit = self:_isMatch(petCo, pet.rare, pet.curFaceId)

	if not string.nilorempty(self._currSearching) then
		local str = StringUtil.RelpaceEscapeChar(self._currSearching)
		local count = string.find(petCo.name, str)

		if not count then
			return false
		end
	end

	return isHit
end

function OtherCardInfoView:_isMatch(cfg, rare, skinId)
	return PetFilterMgr.instance:checkIsMatch(PetFilterMgr.TYPE_PETVIEW, cfg, rare, skinId)
end

function OtherCardInfoView:_onClickShowRule()
	local ruleKey = "Family_Battle_Rank_Info_Rule"
	local ruleCo = RulesConfig.instance:getRuleCo(ruleKey)
	local showStr = string.format("策划请配置 export_说明规则  in  s说明规则.xlsx :  %s", tostring(ruleKey))

	if ruleCo then
		self._txtDetailShowRule.text = ruleCo.rules
	end

	goutil.setActive(self._detailShowRule, true)
end

function OtherCardInfoView:_onClickBtnHideShowRule()
	goutil.setActive(self._detailShowRule, false)
end

function OtherCardInfoView:_onClickCopyId()
	Clipboard.copy(self.txtID.text)
	TipsFacade.instance:openCommonTips("复制成功")
end

function OtherCardInfoView:_setBagPetColVisual(isToShow)
	self._isBagPetColInShow = isToShow

	if isToShow then
		GlobalDispatcher:dispatch(GlobalNotify.CardInfoOpenPetShowSeletView, self._bagPetMoList or {})
	end
end

function OtherCardInfoView:_isBagPetColShowing()
	return checkbool(self._isBagPetColInShow)
end

function OtherCardInfoView:onHeadClick()
	return
end

function OtherCardInfoView:_onClickGooEvil()
	UIStateManager.instance:push(ViewName.GoodeviltipView, self.curMo.moralVal)
end

function OtherCardInfoView:_onClickCharmValue()
	SendFlowerController.instance:openCharmValueView(self.curMo)
end

function OtherCardInfoView:_onClickBadge()
	if self.curMo then
		UIStateManager.instance:push(ViewName.BadgeShowView, self.curMo.userId)
	end
end

function OtherCardInfoView:_onClickPetTitle()
	if self.curMo then
		UIStateManager.instance:push(ViewName.PetTitleOverView, self.curMo.userId)
	end
end

function OtherCardInfoView:_onClickEditPetShow()
	if self:_getCardBelong() ~= RoleModel.CardBelong.My then
		return
	end

	self:_updateBagPetList()
	self:_setBagPetColVisual(true)
end

return OtherCardInfoView
