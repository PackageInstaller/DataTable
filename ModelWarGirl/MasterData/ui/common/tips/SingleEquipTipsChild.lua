-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Tips\\SingleEquipTipsChild.lua

local ResEquipSuit = require("ClientData/ResEquipSuit")
local EquipTipsStrenghPanel = require("UI/Common/Tips/EquipTipsStrenghPanel")
local EvoEquipReturnPanel = require("UI/Common/Tips/EvoEquipReturnPanel")
local ResEquipQuality = require("ClientData/ResEquipQuality")
local ResClientNotice = require("ClientData/ResClientNotice")
local ResEquipBuildMisc = require("ClientData/ResEquipBuildMisc")
local EquipTipsAttrCell = Class("EquipTipsAttrCell", UIControls.Panel)

function EquipTipsAttrCell:ctor()
	self.textName = UIControls.Label(self, self.mPath .. "/TextTitle")
	self.textNumber = UIControls.Label(self, self.mPath .. "/TextNum")
end

function EquipTipsAttrCell:setAttr(attrType, value)
	self.attrType = attrType

	local zhName, attrValue = ClientUtils.getRolePropZhNameByType(attrType, value)

	self.textName:setText(zhName)
	self.textNumber:setText(attrValue)
end

local START_CONFIG = {
	"StarDis",
	"StarOne",
	"StarTwo",
	"StarThree",
	"StarFour",
	"SixstarOne",
	"SixstarTwo",
	"SixstarThree",
	"SixstarFour"
}
local MAX_NUMBER_ASSIST_ATTR = 4
local SingleEquipTipsChild = Class("SingleEquipTipsChild", UIControls.Child)

function SingleEquipTipsChild:ctor()
	self.panelSelf = UIControls.Panel(self, "")
	self.textName = UIControls.Label(self, "TextName")
	self.textPart = UIControls.Label(self, "TextName/TextPosition")
	self.textDesc = UIControls.Label(self, "InfoList/Content/TextDes")
	self.iconMainAttr = UIControls.Image(self, "InfoList/Content/AttrPanel/AttrMainPanel/AttrMain01/Icon")
	self.textMainAttrName = UIControls.Label(self, "InfoList/Content/AttrPanel/AttrMainPanel/AttrMain01/TextTitle")
	self.textMainAttrNum = UIControls.Label(self, "InfoList/Content/AttrPanel/AttrMainPanel/AttrMain01/TextNum")
	self.panelMainAttr2 = UIControls.Panel(self, "InfoList/Content/AttrPanel/AttrMainPanel/AttrMain02")
	self.iconMainAttr2 = UIControls.Image(self, "InfoList/Content/AttrPanel/AttrMainPanel/AttrMain02/Icon")
	self.textMainAttr2Name = UIControls.Label(self, "InfoList/Content/AttrPanel/AttrMainPanel/AttrMain02/TextTitle")
	self.textMainAttr2Num = UIControls.Label(self, "InfoList/Content/AttrPanel/AttrMainPanel/AttrMain02/TextNum")
	self.panelMainAttr4 = UIControls.Panel(self, "InfoList/Content/AttrPanel/AttrMainPanel/AttrMain04")
	self.iconMainAttr4 = UIControls.Image(self, "InfoList/Content/AttrPanel/AttrMainPanel/AttrMain04/Icon")
	self.textMainAttr4Name = UIControls.Label(self, "InfoList/Content/AttrPanel/AttrMainPanel/AttrMain04/TextTitle")
	self.textMainAttr4Num = UIControls.Label(self, "InfoList/Content/AttrPanel/AttrMainPanel/AttrMain04/TextNum")
	self.panelStress = EquipTipsStrenghPanel(self, "InfoList/Content/StrengthPanel")
	self.panelMainAttr3 = UIControls.Panel(self, "InfoList/Content/AttrPanel/AttrMainPanel/AttrMain03")
	self.iconMainAttr3 = UIControls.Image(self, "InfoList/Content/AttrPanel/AttrMainPanel/AttrMain03/Icon")
	self.textMainAttr3Name = UIControls.Label(self, "InfoList/Content/AttrPanel/AttrMainPanel/AttrMain03/TextTitle")
	self.textMainAttr3Num = UIControls.Label(self, "InfoList/Content/AttrPanel/AttrMainPanel/AttrMain03/TextNum")
	self.imgAttr3Bg = UIControls.Image(self, "InfoList/Content/AttrPanel/AttrMainPanel/AttrMain03/Bg")
	self.assistCells = {}

	for i = 1, MAX_NUMBER_ASSIST_ATTR do
		local cell = EquipTipsAttrCell(self, "InfoList/Content/AttrPanel/Attr0" .. i)

		table.insert(self.assistCells, cell)
	end

	self.imgSuit = UIControls.Image(self, "InfoList/Content/SuitPanel/Icon")
	self.imgSuitStar = UIControls.Image(self, "InfoList/Content/SuitPanel/IconStar")
	self.textSuitName = UIControls.Label(self, "InfoList/Content/SuitPanel/TextTitle")
	self.textSuitNumber = UIControls.Label(self, "InfoList/Content/SuitPanel/TextTitle/TextNum")
	self.textSuitDesc = UIControls.Label(self, "InfoList/Content/SuitPanel/TextDes")
	self.scrollStoryList = UIControls.ScrollView(self, "InfoList")
	self.suitSpePanel = UIControls.Panel(self, "InfoList/Content/SuitSpePanel")
	self.suitSpeBgTitle = UIControls.Image(self, "InfoList/Content/SuitSpePanel/BgTitle")
	self.textSuitSpeTitle = UIControls.Label(self, "InfoList/Content/SuitSpePanel/TextTitle")
	self.iconSuitSpeBgHero = UIControls.Image(self, "InfoList/Content/SuitSpePanel/BgHero")
	self.iconSuitSpeBg = UIControls.Image(self, "InfoList/Content/SuitSpePanel/BgHero/Bg")
	self.iconSuitSpe = UIControls.Image(self, "InfoList/Content/SuitSpePanel/BgHero/IconHero")
	self.textSuitSpeAttr = UIControls.Label(self, "InfoList/Content/SuitSpePanel/AttrPanel/TextAttr")
	self.textSuitSpeNum = UIControls.Label(self, "InfoList/Content/SuitSpePanel/TextTitle/TextNum")
	self.speBtnInfoList = {}

	for i = 1, 3 do
		local btnTab = UIControls.Button(self, "InfoList/Content/SuitSpePanel/TabPanel/Btn" .. i)

		btnTab:addEventClick(self.onBtnSpeTabClick)

		local imgBtn = UIControls.Image(self, "InfoList/Content/SuitSpePanel/TabPanel/Btn" .. i)
		local btnText = UIControls.Label(self, "InfoList/Content/SuitSpePanel/TabPanel/Btn" .. i .. "/Text")
		local imageSel = UIControls.Panel(self, "InfoList/Content/SuitSpePanel/TabPanel/Btn" .. i .. "/ImgSel")
		local efxUnlock

		if UIControls.checkControlFunc(self, "InfoList/Content/SuitSpePanel/TabPanel/Btn" .. i .. "/EfxUnlock") then
			efxUnlock = UIControls.Panel(self, "InfoList/Content/SuitSpePanel/TabPanel/Btn" .. i .. "/EfxUnlock")
		end

		self.speBtnInfoList[i] = {
			btn = btnTab,
			text = btnText,
			img = imgBtn,
			imgSel = imageSel,
			efx = efxUnlock
		}
	end

	if UIControls.checkControlFunc(self, "BtnRecovery") then
		self.btnRecovery = UIControls.Button(self, "BtnRecovery")

		self.btnRecovery:addEventClick(self.onBtnRecoveryClick)
	end

	if UIControls.checkControlFunc(self, "BgReturn") then
		self.bgReturn = EvoEquipReturnPanel(self, "BgReturn")
	end

	if UIControls.checkControlFunc(self, "InfoList/Content/SuitSpePanel/QualitySlider") then
		self.qualitySlider = UIControls.Slider(self, "InfoList/Content/SuitSpePanel/QualitySlider")
		self.txtBuildExp = UIControls.Label(self, "InfoList/Content/SuitSpePanel/QualitySlider/TextNum")
		self.imgBuildQuality = UIControls.Image(self, "InfoList/Content/SuitSpePanel/QualitySlider/ImgQuality")
	end

	if UIControls.checkControlFunc(self, "InfoList/Content/SuitSpePanel/TextTitle/ImgNew") then
		self.imgNew = UIControls.Panel(self, "InfoList/Content/SuitSpePanel/TextTitle/ImgNew")
	end

	if UIControls.checkControlFunc(self, "InfoList/Content/SuitSpePanel/QualitySlider/ImgUpPanel") then
		self.imgUp = UIControls.Panel(self, "InfoList/Content/SuitSpePanel/QualitySlider/ImgUpPanel")
	end

	if UIControls.checkControlFunc(self, "InfoList/Content/SuitSpePanel/TextTitle/TextNum/ImgTips") then
		self.btnTips = UIControls.Button(self, "InfoList/Content/SuitSpePanel/TextTitle/TextNum/ImgTips")

		self.btnTips:addEventClick(self.onBtnTipsClick)
	end

	self.animInfo = UIControls.UIAni(self, "InfoList")
end

function SingleEquipTipsChild:onBtnRecoveryClick()
	self.bgReturn:changeVisible()
end

function SingleEquipTipsChild:refreshSpeSuitPanel()
	if self.equip:isDefineHeroEquip() then
		self.suitSpePanel:setVisible(true)

		for _, btnInfo in ipairs(self.speBtnInfoList) do
			btnInfo.btn:setVisible(false)
		end

		local effectEquipNum = self.wearedEffectNum or 0
		local isWearedInOther = self.isWearedInOther or false

		self.heroDic = CurAvatar.heroDic

		local mainBagDlg = UIManager.getUI("mainBagDlg", nil, false)

		if mainBagDlg and mainBagDlg.panelWear and mainBagDlg.panelWear:getVisible() and mainBagDlg.panelWear.isEditPlan then
			self.heroDic = {}

			for _, hero in ipairs(mainBagDlg.panelWear.wearedHeroList) do
				self.heroDic[hero.gid] = hero
			end
		end

		local battleBeforeWearDlg = UIManager.getUI("battleBeforeWearDlg", nil, false)

		if battleBeforeWearDlg and battleBeforeWearDlg.panelWear and battleBeforeWearDlg.panelWear.isEditPlan then
			self.heroDic = {}

			for _, hero in ipairs(battleBeforeWearDlg.panelWear.wearedHeroList) do
				self.heroDic[hero.gid] = hero
			end
		end

		if self.equip.inWearing and self.heroDic[self.equip.inWearing] then
			local wearedHero = self.heroDic[self.equip.inWearing]
			local speSuits = wearedHero:getSpeSuitCounts()

			effectEquipNum = speSuits[self.equip.resDefineEffctData[1].effect_id] ~= nil and #speSuits[self.equip.resDefineEffctData[1].effect_id] or 0

			if speSuits[self.equip.resDefineEffctData[1].effect_id] ~= nil then
				effectEquipNum = wearedHero:getRealSpeSuitCounts(speSuits[self.equip.resDefineEffctData[1].effect_id], effectEquipNum)
			end

			if self.equip:getDefineHeroId() ~= wearedHero.id then
				isWearedInOther = true
			end
		end

		if isWearedInOther then
			self.suitSpeBgTitle:setImageGray(true)
			self.iconSuitSpeBgHero:setImageGray(true)
			self.iconSuitSpeBg:setImageGray(true)
			self.iconSuitSpe:setImageGray(true)
			self.textSuitSpeNum:setText(Lang.get(51402))
		else
			self.suitSpeBgTitle:setImageGray(false)
			self.iconSuitSpeBgHero:setImageGray(false)
			self.iconSuitSpeBg:setImageGray(false)
			self.iconSuitSpe:setImageGray(false)
			self.textSuitSpeNum:setText(string.format("(%s/%s)", effectEquipNum, self.equip.resDefineEffctData[#self.equip.resDefineEffctData].num))
		end

		local defaultSelectIdx = 1

		self.activeEfxLv = 0
		self.unLockIdx = 0

		for i, effctData in ipairs(self.equip.resDefineEffctData) do
			if self.speBtnInfoList[i] then
				self.speBtnInfoList[i].btn:setVisible(true)
				self.speBtnInfoList[i].text:setText(string.format(Lang.get(30671), effctData.num))

				if self.equip.buildQuality and ResEquipQuality[self.equip.buildQuality] and ResEquipQuality[self.equip.buildQuality].exclusive_num >= effctData.num then
					self.activeEfxNum = ResEquipQuality[self.equip.buildQuality].exclusive_num
					self.unLockIdx = i
				end

				if effectEquipNum >= effctData.num then
					defaultSelectIdx = i
					self.activeEfxLv = i
				end
			end
		end

		for idx, btnInfo in ipairs(self.speBtnInfoList) do
			if btnInfo.efx and idx < 3 then
				btnInfo.efx:setVisible(false)
			end

			if Const.EQUIP_BUILD_OPEN and self.unLockIdx and idx > self.unLockIdx then
				btnInfo.img:setImage("Atlas/HeroAtlas/HeroEquipPowerUpAtlas", "BgProgressLock")
				btnInfo.text:setFontColor(ResColor.GREYMIDDLE)
				btnInfo.text:setVisible(false)
			else
				btnInfo.text:setVisible(true)

				if idx > self.activeEfxLv then
					btnInfo.img:setImage("Atlas/CommonAtlas/TipsNewAtlas", "BgTabDis")
					btnInfo.text:setFontColor(ResColor.GREYMIDDLE)
				elseif idx == self.activeEfxLv then
					btnInfo.img:setImage("Atlas/CommonAtlas/TipsNewAtlas", "BgTabAct")
					btnInfo.text:setFontColor(ResColor.WHITE)
				else
					btnInfo.img:setImage("Atlas/CommonAtlas/TipsNewAtlas", "BgTabNml")
					btnInfo.text:setFontColor(ResColor.WHITE)
				end
			end
		end

		self:onBtnSpeTabClick(self.speBtnInfoList[defaultSelectIdx].btn)
		self.textSuitSpeTitle:setText(self.equip.resDefineEffctData[1].effect_name or "")

		local fakeHero = BaseObject.GetObject(self.equip.resDefineEffctData[1].hero_id)
		local iconPath = fakeHero:getQIconPath()

		if iconPath then
			self.iconSuitSpe:setImage(iconPath[1], iconPath[2])
		end

		if Const.EQUIP_BUILD_OPEN and self.qualitySlider then
			self.qualitySlider:setVisible(true)

			if self.equip.buildQuality and self.equip.buildQuality < Const.EQUIP_BUILD_MAX then
				local exp = self.equip.buildExp or 0

				self.qualitySlider:setValue(exp / ResEquipQuality[self.equip.buildQuality].limit)
				self.txtBuildExp:setText(exp .. "/" .. ResEquipQuality[self.equip.buildQuality].limit)

				if self.imgUp and self.equip.showBuildUp then
					self.imgUp:setVisible(true)
				end
			else
				self.qualitySlider:setValue(1)

				local exp = ResEquipQuality[Const.EQUIP_BUILD_MAX - 1].limit

				self.txtBuildExp:setText("MAX")

				if self.imgUp then
					self.imgUp:setVisible(false)
				end
			end

			if self.equip.buildType and self.equip.buildType == Const.BUILD_TYPE_NORMAL then
				if self.imgNew then
					self.imgNew:setVisible(true)
				end

				self.textSuitSpeNum:setText("")
				self.imgBuildQuality:setImage("Atlas/HeroAtlas/HeroEquipPowerUpAtlas", "BgProgressRandom")
				self.gridEquip:hideBgHeroAndShowStar(true)
			else
				if self.imgNew then
					self.imgNew:setVisible(false)
				end

				self.imgBuildQuality:setImage("Atlas/HeroAtlas/HeroEquipPowerUpAtlas", "BgProgress" .. ResEquipQuality[self.equip.buildQuality].name)
			end
		elseif self.qualitySlider then
			self.qualitySlider:setVisible(false)
		end
	else
		self.suitSpePanel:setVisible(false)
	end
end

function SingleEquipTipsChild:onEquipBuild(newEquip)
	if self.imgNew then
		self.imgNew:setVisible(false)
	end

	if self.qualitySlider then
		self.newEquip = newEquip

		local oldExp = self.equip.buildExp or 0
		local critShowMin = 400

		for i, v in pairs(ResEquipBuildMisc) do
			critShowMin = v.crit_show_min
		end

		if critShowMin <= self.newEquip.buildExp - oldExp then
			self.animInfo:startAni("AniSuccess", true)
		end

		if self.newEquip.buildExp < ResEquipQuality[self.equip.buildQuality].limit then
			self.qualitySlider:setValue(self.newEquip.buildExp / ResEquipQuality[self.equip.buildQuality].limit, 0.5)
			self.txtBuildExp:setText(self.newEquip.buildExp .. "/" .. ResEquipQuality[self.equip.buildQuality].limit)

			self.refreshSliderTimer = Timer.New(Slot(self.updateWindowData, self), 0.5, 1)

			self.refreshSliderTimer:Start()
		else
			self.qualitySlider:setValue(1, 0.5)
			self.txtBuildExp:setText(self.newEquip.buildExp .. "/" .. ResEquipQuality[self.equip.buildQuality].limit)

			self.refreshSliderTimer = Timer.New(Slot(self.updateBuildSlider, self), 0.5, 1)

			self.refreshSliderTimer:Start()
		end
	end
end

function SingleEquipTipsChild:updateBuildSlider()
	if self.refreshSliderTimer then
		self.refreshSliderTimer:Stop()

		self.refreshSliderTimer = nil
	end

	self.equip.buildQuality = self.equip.buildQuality + 1

	if self.speBtnInfoList[self.equip.buildQuality - 1] and self.speBtnInfoList[self.equip.buildQuality - 1].efx then
		self.speBtnInfoList[self.equip.buildQuality - 1].efx:setVisible(true)
	end

	self.imgBuildQuality:setImage("Atlas/HeroAtlas/HeroEquipPowerUpAtlas", "BgProgress" .. ResEquipQuality[self.equip.buildQuality].name)

	if self.equip.buildQuality >= Const.EQUIP_BUILD_MAX then
		self.qualitySlider:setValue(1)
		self.txtBuildExp:setText("MAX")
		self:updateWindowData()
	else
		self.qualitySlider:setValue(0)

		if self.newEquip.buildExp < ResEquipQuality[self.equip.buildQuality].limit then
			self.qualitySlider:setValue(self.newEquip.buildExp / ResEquipQuality[self.equip.buildQuality].limit, 0.5)
			self.txtBuildExp:setText(self.newEquip.buildExp .. "/" .. ResEquipQuality[self.equip.buildQuality].limit)

			self.refreshSliderTimer = Timer.New(Slot(self.updateWindowData, self), 0.5, 1)

			self.refreshSliderTimer:Start()
		else
			self.qualitySlider:setValue(1, 0.5)
			self.txtBuildExp:setText(self.newEquip.buildExp .. "/" .. ResEquipQuality[self.equip.buildQuality].limit)

			self.refreshSliderTimer = Timer.New(Slot(self.updateBuildSlider, self), 0.5, 1)

			self.refreshSliderTimer:Start()
		end
	end
end

function SingleEquipTipsChild:updateWindowData()
	if self.refreshSliderTimer then
		self.refreshSliderTimer:Stop()

		self.refreshSliderTimer = nil
	end

	self.mWindow:refreshItemList()
end

function SingleEquipTipsChild:onBtnSpeTabClick(sender)
	for effectLv, btnInfo in ipairs(self.speBtnInfoList) do
		local btn = btnInfo.btn

		btn:setEnable(btn ~= sender)
		btnInfo.imgSel:setVisible(btn == sender)

		if btn == sender then
			if Const.EQUIP_BUILD_OPEN and self.unLockIdx and effectLv > self.unLockIdx then
				self.textSuitSpeAttr:setText(ResClientNotice[656].notice)
				self.textSuitSpeAttr:setFontColor(ResColor.WHITE)
			else
				self.textSuitSpeAttr:setText(self.equip.resDefineEffctData[effectLv].effect_desc)

				local attrColor = effectLv > self.activeEfxLv and ResColor.GREYMIDDLE or ResColor.WHITE

				self.textSuitSpeAttr:setFontColor(attrColor)
			end
		end
	end
end

function SingleEquipTipsChild:setItem(equip, equipList)
	if not self.gridEquip then
		self.gridEquip = UIControls.EquipGridChild(self, "GridPanel", "System/Common/Grid/GridEquipItem", 0, 0, true)
	end

	self.gridEquip.mEnableTips = false
	self.equip = equip

	self.gridEquip:setObj(equip)

	if self.bgReturn then
		self.bgReturn:setEquip(self.equip)
	end

	if self.btnRecovery then
		self.btnRecovery:setVisible(self.equip.evolve > 0)
	end

	self.textName:setText(equip.name or "")

	local partInfo = UIConst.EQUIP_PART_CONFIG[equip.part]

	if partInfo then
		self.textPart:setText(partInfo[1])
	end

	self.textDesc:setText(equip:getDesc() or "")

	local mainIcon = ClientUtils.getRolePropIconByType(equip.mainProp)

	if mainIcon then
		self.iconMainAttr:setImage(mainIcon[1], mainIcon[2])
	end

	local zhName, zhValue = ClientUtils.getRolePropZhNameByType(equip.mainProp, equip.mainPropValue)

	self.textMainAttrName:setText(zhName)
	self.textMainAttrNum:setText(zhValue)

	if equip.mainProp2 then
		self.panelMainAttr2:setVisible(true)

		local mainIcon = ClientUtils.getRolePropIconByType(equip.mainProp2)

		if mainIcon then
			self.iconMainAttr2:setImage(mainIcon[1], mainIcon[2])
		end

		local zhName, zhValue = ClientUtils.getRolePropZhNameByType(equip.mainProp2, equip.mainProp2Value)

		self.textMainAttr2Name:setText(zhName)
		self.textMainAttr2Num:setText(zhValue)
	else
		self.panelMainAttr2:setVisible(false)
	end

	if equip.mainProp4 then
		self.panelMainAttr4:setVisible(true)

		local mainIcon = ClientUtils.getRolePropIconByType(equip.mainProp4)

		if mainIcon then
			self.iconMainAttr4:setImage(mainIcon[1], mainIcon[2])
		end

		local zhName, zhValue = ClientUtils.getRolePropZhNameByType(equip.mainProp4, equip.mainProp4Value)

		self.textMainAttr4Name:setText(zhName)
		self.textMainAttr4Num:setText(zhValue)
	else
		self.panelMainAttr4:setVisible(false)
	end

	if equip.mainProp3 then
		self.panelMainAttr3:setVisible(true)

		local mainIcon = ClientUtils.getRolePropIconByType(equip.mainProp3)

		if mainIcon then
			self.iconMainAttr3:setImage(mainIcon[1], mainIcon[2])
		end

		local zhName, zhValue = ClientUtils.getRolePropZhNameByType(equip.mainProp3, equip.mainProp3Value)

		self.textMainAttr3Name:setText(zhName)
		self.textMainAttr3Num:setText(zhValue)

		local attr3Color = equip:getAttr3Color()

		if attr3Color then
			self.textMainAttr3Name:setColorByRGBA(attr3Color[1] / 255, attr3Color[2] / 255, attr3Color[3] / 255)
			self.textMainAttr3Num:setColorByRGBA(attr3Color[1] / 255, attr3Color[2] / 255, attr3Color[3] / 255)
			self.iconMainAttr3:setColorByRGBA(attr3Color[1], attr3Color[2], attr3Color[3])
		end

		local imgBackPath = equip:getAttr3BackImgPath()

		if imgBackPath then
			self.imgAttr3Bg:setImage(imgBackPath[1], imgBackPath[2])
		end
	else
		self.panelMainAttr3:setVisible(false)
	end

	for index, cell in ipairs(self.assistCells) do
		local info = equip.assistProps[index]

		if info then
			cell:setVisible(true)
			cell:setAttr(info[1], info[2])
		else
			cell:setVisible(false)
		end
	end

	local suitInfo = ResEquipSuit[equip.suitId]

	if equip.haveSuit == 1 and suitInfo then
		local nowSuitId = equip.suitId

		self.textSuitName:setText(suitInfo.name)
		self.textSuitDesc:setVisible(true)
		self.textSuitDesc:setText(suitInfo.des)
		self.imgSuit:setVisible(true)
		self.imgSuit:setImage(UIConst.COMMON_ICON_PATH .. suitInfo.iconPath, suitInfo.icon)
		self.imgSuitStar:setImage("Atlas/CommonAtlas/GridAtlas/GridEquipAtlas", "IconEquipStar02Nml")

		local suitOrder = 0
		local _nowOrder = 0
		local needNum = suitInfo.need_num
		local equips = equipList

		if equips == nil and equip.inWearing then
			equips = CurAvatar:getHeroEquips(equip.inWearing)
		end

		if equips then
			for part = 1, UIConst.EQUIP_PART_MAX_NUM do
				local pEquip = equips[part]

				if equip.part == part then
					pEquip = equip
				end

				if pEquip and pEquip.suitId == nowSuitId then
					_nowOrder = _nowOrder + 1

					if needNum <= _nowOrder then
						_nowOrder = 0

						if part >= equip.part then
							suitOrder = needNum

							break
						end
					end
				end
			end
		end

		self.textSuitNumber:setVisible(true)

		if suitOrder == needNum then
			self.textSuitNumber:setText(needNum .. "/" .. needNum)
		else
			self.textSuitNumber:setText(_nowOrder .. "/" .. needNum)
		end
	else
		self.imgSuitStar:setImage("Atlas/CommonAtlas/GridAtlas/GridEquipAtlas", "IconEquipStar02Dis")
		self.textSuitName:setText(Lang.get(30251))
		self.imgSuit:setVisible(false)
		self.textSuitNumber:setVisible(false)
		self.textSuitDesc:setVisible(false)
	end

	self.panelStress:setEquip(equip)

	if self.isDynamicHeight then
		self.setScrollStatus = coroutine.start(self.yieldSetScrollStatusByDynamicHeight, self)
	else
		self.setScrollStatus = coroutine.start(self.yieldSetScrollStatus, self)
	end

	self:refreshSpeSuitPanel()
end

function SingleEquipTipsChild:yieldSetScrollStatusByDynamicHeight()
	self.scrollStoryList:gotoTop()
	coroutine.step()

	local contentSize = self.scrollStoryList:getContentSize()
	local listWidth = self.panelSelf:getRectSize().width

	if contentSize[2] <= 655 then
		self.panelSelf:setRectSize(listWidth, 670)
		self.scrollStoryList:cancelScroll()
	elseif contentSize[2] > 655 and contentSize[2] <= 855 then
		self.panelSelf:setRectSize(listWidth, contentSize[2] + 13)
		self.scrollStoryList:cancelScroll()
	else
		self.panelSelf:setRectSize(listWidth, 868)
		self.scrollStoryList:openScroll(true)
	end
end

function SingleEquipTipsChild:yieldSetScrollStatus()
	self.scrollStoryList:gotoTop()
	coroutine.step()

	local contentSize = self.scrollStoryList:getContentSize()
	local maxHeight = self.scrollStoryList:getSize().height

	if maxHeight >= contentSize[2] then
		self.scrollStoryList:cancelScroll()
	else
		self.scrollStoryList:openScroll(true)
	end
end

function SingleEquipTipsChild:setSpSuitNum(equipList, hero)
	local suitInfo = ResEquipSuit[self.equip.suitId]

	self.gridEquip.preInWearing = hero.gid

	self.gridEquip:refreshSpeSuitInfo()

	if self.equip:getDefineHeroId() and self.equip:getDefineHeroId() ~= hero.id then
		self.isWearedInOther = true
	else
		self.isWearedInOther = false
	end

	local speEquips = {}

	if self.equip.haveSuit == 1 and suitInfo or self.equip:getDefineHeroId() and self.equip:getDefineHeroId() == hero.id then
		local nowSuitId = self.equip.suitId
		local suitOrder = 0
		local _nowOrder = 0
		local needNum = suitInfo.need_num

		self.textSuitNumber:setVisible(self.equip.haveSuit == 1 and suitInfo ~= nil)

		local equips = equipList

		self.wearedEffectNum = 0

		self.textSuitSpeNum:setFontColor(ResColor.WHITE)

		if equips then
			local suitOrderBreak = false

			for part = 1, UIConst.EQUIP_PART_MAX_NUM do
				local pEquip = equips[part]

				if self.equip.part == part then
					pEquip = self.equip
				end

				if pEquip then
					if pEquip:getDefineHeroId() and pEquip:getDefineHeroId() == hero.id and self.equip:getDefineHeroId() == hero.id then
						self.textSuitSpeNum:setFontColor(ResColor.GREEN)

						self.wearedEffectNum = self.wearedEffectNum + 1

						table.insert(speEquips, pEquip)
					end

					if pEquip.suitId == nowSuitId and not suitOrderBreak then
						_nowOrder = _nowOrder + 1

						if needNum <= _nowOrder then
							_nowOrder = 0

							if part >= self.equip.part then
								suitOrder = needNum
								suitOrderBreak = true
							end
						end
					end
				end
			end
		end

		if suitOrder == needNum then
			self.textSuitNumber:setText(needNum .. "/" .. needNum)
		else
			self.textSuitNumber:setText(_nowOrder .. "/" .. needNum)
		end

		self.textSuitNumber:setFontColor(ResColor.GREEN)
	else
		self.textSuitNumber:setVisible(false)
	end

	self.wearedEffectNum = hero:getRealSpeSuitCounts(speEquips, self.wearedEffectNum)

	self:refreshSpeSuitPanel()
end

function SingleEquipTipsChild:onBtnTipsClick(...)
	UIManager.getUI("infoNotice", true):showSystemInfo(Const.INFO_NOTICE_SPETIPS)
end

return SingleEquipTipsChild
