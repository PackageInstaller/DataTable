-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\Tips\\SingleRandomEquipTempleteTipsChild.lua

local ResEquipSuit = require("ClientData/ResEquipSuit")
local EquipTempleteTipsSuitPanel = Class("EquipTempleteTipsSuitPanel", UIControls.Panel)

function EquipTempleteTipsSuitPanel:ctor()
	self.imgSuit = UIControls.Image(self, self.mPath .. "/Icon")
	self.textName = UIControls.Label(self, self.mPath .. "/TextTitle")
end

function EquipTempleteTipsSuitPanel:setSuit(suitId)
	local suitInfo = ResEquipSuit[suitId]

	if suitInfo then
		self.textName:setText(suitInfo.name)
		self.imgSuit:setImage(UIConst.COMMON_ICON_PATH .. suitInfo.iconPath, suitInfo.icon)
	end
end

local EquipTipsStrenghPanel = require("UI/Common/Tips/EquipTipsStrenghPanel")
local SingleRandomEquipTempleteTipsChild = Class("SingleRandomEquipTempleteTipsChild", UIControls.Child)
local MAX_NUMBER_SUIT = 4

function SingleRandomEquipTempleteTipsChild:ctor()
	self:initUI()
end

function SingleRandomEquipTempleteTipsChild:initUI()
	self.textName = UIControls.Label(self, "TextName")
	self.textPart = UIControls.Label(self, "TextName/TextPosition")
	self.textDesc = UIControls.Label(self, "TextDes")
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
	self.suitPanels = {}

	for i = 1, MAX_NUMBER_SUIT do
		local cell = EquipTempleteTipsSuitPanel(self, "InfoList/Content/SuitPanel/SuitPanel" .. i)

		table.insert(self.suitPanels, cell)
	end

	self.panelPropsAttr = UIControls.Panel(self, "InfoList/Content/AttrPanel/Attr")
	self.btnTips = UIControls.Button(self, "InfoList/Content/AttrPanel/Attr/BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)

	self.imgSuitStar = UIControls.Image(self, "InfoList/Content/SuitPanel/IconStar")
	self.txtSuitStar = UIControls.Label(self, "InfoList/Content/SuitPanel/TextSuit")
	self.imgBgLine = UIControls.Image(self, "InfoList/Content/SuitPanel/BgLine")
	self.textSuitSpeTitle = UIControls.Label(self, "InfoList/Content/SuitSpePanel/TextTitle")
	self.iconSuitSpe = UIControls.Image(self, "InfoList/Content/SuitSpePanel/BgHero/IconHero")
	self.textSuitSpeAttr = UIControls.Label(self, "InfoList/Content/SuitSpePanel/AttrPanel/TextAttr")
	self.suitSpePanel = UIControls.Panel(self, "InfoList/Content/SuitSpePanel")
	self.textSuitSpeNum = UIControls.Label(self, "InfoList/Content/SuitSpePanel/TextTitle/TextNum")
	self.speBtnInfoList = {}

	for i = 1, 3 do
		local btnTab = UIControls.Button(self, "InfoList/Content/SuitSpePanel/TabPanel/Btn" .. i)

		btnTab:addEventClick(self.onBtnSpeTabClick)

		local imgBtn = UIControls.Image(self, "InfoList/Content/SuitSpePanel/TabPanel/Btn" .. i)
		local btnText = UIControls.Label(self, "InfoList/Content/SuitSpePanel/TabPanel/Btn" .. i .. "/Text")
		local imageSel = UIControls.Panel(self, "InfoList/Content/SuitSpePanel/TabPanel/Btn" .. i .. "/ImgSel")

		self.speBtnInfoList[i] = {
			btn = btnTab,
			text = btnText,
			img = imgBtn,
			imgSel = imageSel
		}
	end

	self.scrollStoryList = UIControls.ScrollView(self, "InfoList")
end

function SingleRandomEquipTempleteTipsChild:yieldSetScrollStatus()
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

function SingleRandomEquipTempleteTipsChild:setItem(equip)
	self.gridEquip = UIControls.EquipTempleteGridChild(self, "GridPanel", "System/Common/Grid/GridEquipItem", 0, 0, true)
	self.gridEquip.mEnableTips = false

	self.gridEquip:setObj(equip)

	self.equip = equip

	self.textName:setText(equip.name or "")

	local partInfo = UIConst.EQUIP_PART_CONFIG[equip.position]

	if partInfo then
		self.textPart:setText(partInfo[1])
	end

	self.textDesc:setText(equip:getDesc() or "")
	self.btnTips:setVisible(equip.haveProps == 1 or not equip.mainProp)

	if equip.mainProp then
		self.textMainAttrNum:setVisible(true)

		local mainIcon = ClientUtils.getRolePropIconByType(equip.mainProp)

		if mainIcon then
			self.iconMainAttr:setImage(mainIcon[1], mainIcon[2])
		end

		local zhName, zhValue = ClientUtils.getRolePropZhNameByType(equip.mainProp, equip.mainPropValue)

		self.textMainAttrName:setText(zhName)
		self.textMainAttrNum:setText(zhValue)
	else
		self.textMainAttrName:setText(Lang.get(30252))
		self.iconMainAttr:setImage(UIConst.COMMON_ICON_PATH .. "GridAtlas/GridEquipAtlas", "IconAttr00")
		self.textMainAttrNum:setVisible(false)
	end

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

	if equip.haveSuit == 1 then
		self.imgSuitStar:setImage("Atlas/CommonAtlas/GridAtlas/GridEquipAtlas", "IconEquipStar02Nml")
		self.txtSuitStar:setText(Lang.get(30253))
		self.imgBgLine:setVisible(true)

		for idx, suitPanel in ipairs(self.suitPanels) do
			if equip.suitIds[idx] then
				suitPanel:setVisible(true)
				suitPanel:setSuit(equip.suitIds[idx])
			else
				suitPanel:setVisible(false)
			end
		end
	else
		self.imgBgLine:setVisible(false)
		self.imgSuitStar:setImage("Atlas/CommonAtlas/GridAtlas/GridEquipAtlas", "IconEquipStar02Dis")
		self.txtSuitStar:setText(Lang.get(30251))

		for idx, suitPanel in ipairs(self.suitPanels) do
			suitPanel:setVisible(false)
		end
	end

	self.panelPropsAttr:setVisible(equip.haveProps == 1)
	self.panelStress:setEquip(equip)

	self.setScrollStatus = coroutine.start(self.yieldSetScrollStatus, self)

	self:refreshSpeSuitPanel()
end

function SingleRandomEquipTempleteTipsChild:refreshSpeSuitPanel()
	if self.equip:isDefineHeroEquip() then
		self.suitSpePanel:setVisible(true)

		for _, btnInfo in ipairs(self.speBtnInfoList) do
			btnInfo.btn:setVisible(false)
		end

		local effectEquipNum = 0

		self.textSuitSpeNum:setText(string.format("(%s/%s)", effectEquipNum, self.equip.resDefineEffctData[#self.equip.resDefineEffctData].num))

		local defaultSelectIdx = 1

		self.activeEfxLv = 0

		for i, effctData in ipairs(self.equip.resDefineEffctData) do
			if self.speBtnInfoList[i] then
				self.speBtnInfoList[i].btn:setVisible(true)
				self.speBtnInfoList[i].text:setText(string.format(Lang.get(30671), effctData.num))

				if effectEquipNum >= effctData.num then
					defaultSelectIdx = i
					self.activeEfxLv = i
				end
			end
		end

		for idx, btnInfo in ipairs(self.speBtnInfoList) do
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

		self:onBtnSpeTabClick(self.speBtnInfoList[defaultSelectIdx].btn)
		self.textSuitSpeTitle:setText(self.equip.resDefineEffctData[1].effect_name or "")

		local fakeHero = BaseObject.GetObject(self.equip.resDefineEffctData[1].hero_id)
		local iconPath = fakeHero:getQIconPath()

		if iconPath then
			self.iconSuitSpe:setImage(iconPath[1], iconPath[2])
		end
	else
		self.suitSpePanel:setVisible(false)
	end
end

function SingleRandomEquipTempleteTipsChild:onBtnSpeTabClick(sender)
	for effectLv, btnInfo in ipairs(self.speBtnInfoList) do
		local btn = btnInfo.btn

		btn:setEnable(btn ~= sender)
		btnInfo.imgSel:setVisible(btn == sender)

		if btn == sender then
			self.textSuitSpeAttr:setText(self.equip.resDefineEffctData[effectLv].effect_desc)

			local attrColor = effectLv > self.activeEfxLv and ResColor.GREYMIDDLE or ResColor.WHITE

			self.textSuitSpeAttr:setFontColor(attrColor)
		end
	end
end

function SingleRandomEquipTempleteTipsChild:onBtnTipsClick()
	self.mWindow:showRandomInfoPanel()
end

return SingleRandomEquipTempleteTipsChild
