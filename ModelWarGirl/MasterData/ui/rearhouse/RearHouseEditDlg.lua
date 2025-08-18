-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\RearHouse\\RearHouseEditDlg.lua

local RearHouseDragObject = require("Logic/RearHouse/RearHouseDragObject")
local GridHeroStarUp = require("UI/Hero/StarUp/GridHeroStarUp")
local RearHouseDragCenter = require("Logic/RearHouse/RearHouseDragCenter")
local ResRearHouseLayer = require("ClientData/ResRearHouseLayer")
local ResRearHouseMiscConfig = require("ClientData/ResRearHouseMiscConfig")
local ResItem = require("ClientData/ResItem")
local ResRearHouseLevelConfig = require("ClientData/ResRearHouseLevelConfig")
local ResHero = require("ClientData/ResHero")
local RearHouseCommon = require("Logic/RearHouse/RearHouseCommon")
local FilterSelectPanel = require("UI/MainState/FilterSelectPanel")
local ResColor = require("ClientData/ResColor")
local ItemCell = Class("ItemCell", UIControls.ScrollViewLoopCell)

function ItemCell:ctor(...)
	self:initUI()
end

function ItemCell:initUI(...)
	self.sensor = UIControls.Button(self, "")
	self.panelSensor = UIControls.Panel(self, "")
	self.imgIcon = UIControls.Image(self, "FurniturePanel/Icon")
	self.imgNameBg = UIControls.Image(self, "FurniturePanel/BgName")
	self.txtName = UIControls.Label(self, "FurniturePanel/TextName")
	self.imgNumBg = UIControls.Image(self, "FurniturePanel/BgNum1")
	self.txtNum = UIControls.Label(self, "FurniturePanel/BgNum1/TextNum")
	self.imgWeightBg = UIControls.Image(self, "FurniturePanel/BgNum3")
	self.txtWeightNum = UIControls.Label(self, "FurniturePanel/BgNum3/TextNum2")
	self.imgComFortableBg = UIControls.Image(self, "FurniturePanel/BgNum2")
	self.txtComfortableNum = UIControls.Label(self, "FurniturePanel/BgNum2/TextNum2")
	self.imgFurnitureDis = UIControls.Image(self, "FurniturePanel/BtnDis")
	self.panelFurniture = UIControls.Panel(self, "FurniturePanel")
	self.imgNew = UIControls.Image(self, "IconNew")
	self.imgQuality = UIControls.Image(self, "FurniturePanel/ImgQuality")
	self.panelHero = UIControls.Panel(self, "HeroPanel")
	self.imgCheck = UIControls.Image(self, "HeroPanel/ImgCheck")
	self.imgHeroDis = UIControls.Image(self, "HeroPanel/Dis")

	self.panelSensor:addEventDragOnClick(self.onSensorClick)
	self.panelSensor:addEventDragOnGet(self.onDragGet)
	self.panelSensor:addEventDragOnLeave(self.onDragLeave)

	self.imgAttr = UIControls.Image(self, "FurniturePanel/BgAttr")
	self.panelOtherRoom = UIControls.Panel(self, "FurniturePanel/BtnDis/OtherRoomPanel")
	self.txtRoomIndex = UIControls.Label(self, "FurniturePanel/BtnDis/OtherRoomPanel/TextNum")
end

function ItemCell:setData(data)
	self.data = data
	self.typeId = self.data.typeId

	if self.typeId == 5 then
		self.panelHero:setVisible(true)
		self.panelFurniture:setVisible(false)

		if not self.heroGrid then
			self.heroGrid = GridHeroStarUp(self, "HeroPanel/GridHeroStarUpPanel", "System/StarUp/GridHeroStarUp")
		end

		self.heroGrid:setHero(data.hero)

		if CurAvatar:isCrystalOpened() then
			self.heroGrid:setFakeCrystalLevel(self.data.count <= 0)
		end

		self.heroGrid:setVisible(true)
	else
		self.panelHero:setVisible(false)
		self.panelFurniture:setVisible(true)

		if RearHouseCommon.isWeightType(self.typeId) then
			self.imgWeightBg:setVisible(true)
			self.imgComFortableBg:setVisible(true)
			self.txtWeightNum:setText(self.data.modelData.baseInfo.weight or 0)
			self.txtComfortableNum:setText(self.data.modelData.baseInfo.comfortable)
		else
			self.imgWeightBg:setVisible(false)
			self.imgComFortableBg:setVisible(true)
			self.txtComfortableNum:setText(self.data.modelData.baseInfo.comfortable)
		end

		local object = BaseObject.GetObject(self.data.modelId, 1)
		local qualityPath = object:getQualityPath()

		if qualityPath then
			self.imgQuality:setImage(qualityPath[1], qualityPath[2])
		end

		self.txtName:setText(self.data.modelData.name)

		local itemInfo = ResItem[self.data.modelId]

		if itemInfo and itemInfo.iconPath then
			self.imgIcon:setImage(UIConst.ITEM_ICON_PATH .. itemInfo.iconPath, itemInfo.icon)
		elseif data.heroIconPath then
			self.imgIcon:setImage(data.heroIconPath[1], data.heroIconPath[2])
		else
			self.imgIcon:setImage("", "")
		end

		self.imgAttr:setVisible(RearHouseCommon.isAttrFurniture(self.data.modelId))
	end

	if CurAvatar:isShowNew(self.data.modelId) then
		self:showNew(true)
	else
		self:showNew(false)
	end

	self:refreshNum()
end

function ItemCell:showNew(v)
	self.imgNew:setVisible(v)
end

function ItemCell:refreshState(...)
	if self.data.count == 0 then
		self:setEnable(false)
	else
		self:setEnable(true)
	end
end

function ItemCell:onDragLeave(sender)
	RearHouseDragCenter.onDragEnd()

	if self.createSuccess == true then
		self:checkHeroLevelTip()
	end
end

function ItemCell:onDragGet(sender)
	self.createSuccess = false

	if self.mWindow.dragPutEnable == true and self.data.count > 0 then
		self:_doCreate(true)
	end
end

function ItemCell:refreshNum(...)
	if self.data then
		local leftNum = self.mWindow:getLimitNumByType(self.data.typeId)

		self.txtNum:setText(self.data.count)

		self.totalNum = self.mWindow:getCurTypeTotalNum()

		if self.totalNum <= 0 then
			self.imgFurnitureDis:setVisible(true)
			self.panelOtherRoom:setVisible(false)
			self.imgCheck:setVisible(false)
			self.imgHeroDis:setVisible(true)
		elseif self.data.count == 0 then
			self.imgFurnitureDis:setVisible(true)

			local info = self:isPutedOnOtherWall()

			if info then
				for i = 1, Const.REARHOUSE_WALL_NUM do
					if info[i] then
						self.txtRoomIndex:setText(i)

						break
					end
				end

				self.panelOtherRoom:setVisible(true)
			else
				self.panelOtherRoom:setVisible(false)
			end

			self.imgCheck:setVisible(true)
			self.imgHeroDis:setVisible(false)
		elseif self.data.count > 0 then
			self.imgHeroDis:setVisible(leftNum <= 0)
			self.imgFurnitureDis:setVisible(false)
			self.imgCheck:setVisible(false)
		end
	end
end

function ItemCell:isPutedOnOtherWall(...)
	if self.typeId == Const.REARHOUSE_TYPE_HERO then
		return self.mWindow:isPutedOnOtherWall(self.data.hero.gid)
	else
		return self.mWindow:isPutedOnOtherWall(self.data.modelId)
	end
end

function ItemCell:isUnlock(...)
	local levelData = ResRearHouseLevelConfig[CurAvatar.rearHouseData.level]

	if levelData then
		return levelData.unlock_wall > 0
	else
		return true
	end
end

function ItemCell:onSensorClick(sender)
	self.createSuccess = false

	self:_doCreate(false)
end

function ItemCell:_doCreate(isDrag)
	self:showNew(false)

	if self.totalNum <= 0 then
		local info = self.mWindow:getUnlockInfo()

		if info then
			MsgManager.notice(utils.format(Lang.get(30679), info.bigLv, info.smallLv))
		end

		return
	end

	if not self:isUnlock() then
		MsgManager.notice(Lang.get(30683))

		return
	end

	if self.data.count <= 0 and self:isPutedOnOtherWall() then
		MsgManager.notice(Lang.get(30684))

		return
	end

	if self.data.count <= 0 then
		if self.typeId == 5 then
			RearHouseDragCenter.removeHeros({
				[self.data.hero.gid] = true
			})
		elseif self.typeId == 1 then
			RearHouseDragCenter.removeWallPic()
		end

		return
	end

	local leftNum = self.mWindow:getLimitNumByType(self.data.typeId)

	if RearHouseCommon.isWeightType(self.typeId) then
		if leftNum < (self.data.modelData.baseInfo.weight or 0) then
			MsgManager.notice(Lang.get(30685))

			return
		end
	elseif leftNum <= 0 and self.typeId ~= 1 then
		MsgManager.notice(Lang.get(30686))

		return
	end

	local putData = {}

	putData.data = self.data

	if self.data.hero then
		putData.hero = self.data.hero
	end

	local initData = {}

	if isDrag == true then
		initData.isNewDrag = true
	else
		initData.isNewPut = true
	end

	if self.mWindow:isInBeginnerState() then
		initData.inBeginner = true
	end

	RearHouseDragCenter.addObjFinal({
		{
			putData = putData,
			initData = initData
		}
	})

	self.createSuccess = true

	if not isDrag then
		self:checkHeroLevelTip()
	end
end

function ItemCell:checkHeroLevelTip()
	if self.typeId ~= Const.REARHOUSE_TYPE_HERO then
		return
	end

	if CurAvatar:isCrystalOpened() and self.data.hero and self.data.hero.realLevel > 1 then
		local function yesFunc(...)
			local heroResetDlg = UIManager.getUI("heroResetDlg", true)

			heroResetDlg:setHero(self.data.hero, Const.HERO_RESET_LEVEL)
		end

		local content = string.format(Lang.get(30680), self.data.hero:getFakeCrystalLevel())

		UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "", content, yesFunc, nil, nil)
	end
end

local TabItem = Class("TabItem", UIControls.Child)

function TabItem:ctor(...)
	self.txtName = UIControls.Label(self, "TextName")
	self.txtNum = UIControls.Label(self, "Num")
	self.txtTitle = UIControls.Label(self, "Num/Title")
	self.sensor = UIControls.Button(self, "")
	self.imgIcon = UIControls.Image(self, "Icon")

	self.sensor:addEventClick(self.onSensorClick)
end

function TabItem:onSensorClick(...)
	self.mWindow:setCurTab(self.typeId)
end

function TabItem:initData(typeId)
	self.typeId = typeId

	self.imgIcon:setImage("Atlas/BackyardAtlas/BackyardAtlas", "IconEditTab0" .. self.typeId)

	self.imgNew = UIControls.Image(self, "IconNew")

	if RearHouseCommon.isWeightType(self.typeId) then
		self.txtTitle:setText(Lang.get(30687))
	elseif self.typeId == 5 then
		-- block empty
	end

	local name = ResRearHouseLayer[typeId].type_name

	self.txtName:setText(name)
	self:setPutCount(0)
	self:refreshNum()

	if CurAvatar:isShowNew(typeId, true) then
		self:checkShowNew(true)
	end
end

function TabItem:checkShowNew(show)
	if self.typeId == 5 then
		return
	end

	if show == true then
		self.imgNew:setVisible(true)

		return
	end

	if show == false then
		CurAvatar:isShowNew(self.typeId, false)

		local isShow = self.mWindow:canPutNewObj(self.typeId, self:getLimitNum())

		self.imgNew:setVisible(isShow)

		return
	end

	if show == nil then
		local isNewGot = CurAvatar:isShowNew(self.typeId, true)
		local isShow = self.mWindow:canPutNewObj(self.typeId, self:getLimitNum())

		self.imgNew:setVisible(isNewGot or isShow)
	end
end

function TabItem:setEnable(v)
	self.sensor:setEnable(v)
end

function TabItem:setPutCount(count)
	self.putCount = self.putCount or 0

	if count == 0 then
		count = RearHouseDragCenter.getNowObjsCountByType(self.typeId)
	end

	self.putCount = self.putCount + count
end

function TabItem:refreshNum()
	local level = CurAvatar.rearHouseData.level

	level = level > 0 and level or 1

	if self.typeId == Const.REARHOUSE_TYPE_HERO then
		self.imgNew:setVisible(self.mWindow:checkPutHero(self.putCount, RearHouseDragCenter.getCurZoneId()))
	end

	self.txtNum:setText(self:getLimitNum())
	self:checkShowNew()
end

function TabItem:getLimitNum(...)
	if RearHouseCommon.isWeightType(self.typeId) then
		return self:getTotalNum() - self.mWindow:getPutWeightTotal()
	else
		return self:getTotalNum() - self.putCount
	end
end

function TabItem:getTotalNum(...)
	if self.num == nil then
		local wallIndex = RearHouseDragCenter.getCurZoneId()

		if RearHouseCommon.isWeightType(self.typeId) then
			self.num = RearHouseCommon.getTotalWeightByLevel(CurAvatar.rearHouseData.level, wallIndex)
		else
			self.num = RearHouseCommon.getLimitNumByType(self.typeId, wallIndex)
		end
	end

	return self.num
end

local COLOR_MODE = {
	NORMAL = {
		g = 214,
		a = 255,
		b = 82,
		r = 242
	},
	UP = {
		g = 74,
		a = 255,
		b = 250,
		r = 65
	},
	YELLOW = {
		g = 0.7764705882352941,
		a = 1,
		b = 0.2784313725490196,
		r = 1
	}
}
local strClassName = "RearHouseEditDlg"
local RearHouseEditDlg = Class(strClassName, UIControls.Window)

function RearHouseEditDlg:ctor(...)
	self:initUI()

	self.dragPutEnable = true
end

function RearHouseEditDlg:initUI(...)
	self.btnClose = UIControls.Button(self, "BtnClose", "Text")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnTips = UIControls.Button(self, "BtnTips")

	self.btnTips:addEventClick(self.onBtnTipsClick)

	self.panelEdit = UIControls.Panel(self, "EditPanel")
	self.imgNothing = UIControls.Image(self, "EditPanel/ImgNothing")
	self.panelBg = UIControls.DragClickPanel(self, "DragBg")
	self.btnSave = UIControls.Button(self, "EditPanel/BtnSave")

	self.btnSave:addEventClick(self.onBtnSaveClick)

	self.btnDelete = UIControls.Button(self, "EditPanel/BtnDelete")

	self.btnDelete:addEventClick(self.onBtnDeleteClick)

	self.btnReset = UIControls.Button(self, "EditPanel/BtnReset")

	self.btnReset:addEventClick(self.onBtnResetClick)

	self.imgWarning = UIControls.Image(self, "ImgNotice")
	self.txtWarning = UIControls.Label(self, "ImgNotice/Text")
	self.txtComfortableNum = UIControls.Label(self, "BgComfortable/TextNum")
	self.imgComfortableUp = UIControls.Image(self, "BgComfortable/ImgUp")
	self.imgComfortable = UIControls.Image(self, "BgComfortable/Icon")
	self.txtWeightNum = UIControls.Label(self, "BgKg/TextNum")
	self.panelAttr = UIControls.Panel(self, "AttrPanel")
	self.panelSingle = UIControls.Panel(self, "AttrPanel/SinglePanel")
	self.txtSingleName = UIControls.Label(self, "AttrPanel/SinglePanel/TextName")
	self.imgAttrIcon = UIControls.Image(self, "AttrPanel/SinglePanel/AttrPanel/Icon")
	self.txtSingleAttrs = {}

	for i = 1, 2 do
		local path = "AttrPanel/SinglePanel/AttrPanel/Attr" .. i
		local panel = UIControls.Panel(self, path)
		local txtDesc = UIControls.Label(self, path .. "/TextAttr")

		table.insert(self.txtSingleAttrs, {
			panel,
			txtDesc
		})
	end

	self.panelSuit = UIControls.Panel(self, "AttrPanel/SuitPanel")
	self.txtSuitName = UIControls.Label(self, "AttrPanel/SuitPanel/TextName")
	self.txtSuitPutNum = UIControls.Label(self, "AttrPanel/SuitPanel/TextName/TextNum")
	self.txtSuitAttrs = {}

	for i = 1, 3 do
		local path = "AttrPanel/SuitPanel/SuitAttr" .. i
		local panel = UIControls.Panel(self, path)
		local txtNum = UIControls.Label(self, path .. "/TextNum")
		local txtAttr = UIControls.Label(self, path .. "/TextAttr")

		table.insert(self.txtSuitAttrs, {
			panel,
			txtNum,
			txtAttr
		})
	end

	self.slider = UIControls.Slider(self, "Slider")

	self.slider:addEventValueChanged(self.onSliderValueChange)

	self.items = {}
	self.cells = {}
	self.typeUnlockDic = {}
	self.leftBtns = {}

	local wallIndex = RearHouseDragCenter.getCurZoneId()

	for level, levelInfo in ipairs(ResRearHouseLevelConfig) do
		for type, _ in ipairs(ResRearHouseLayer) do
			local num = levelInfo.part_limit[type].limit[wallIndex] or 0

			if num > 0 and not self.typeUnlockDic[type] then
				local data = CurAvatar:getRearHouseLevelInfo(level)

				data.unlockLevel = level
				self.typeUnlockDic[type] = data
			end
		end
	end

	self.scrollTab = UIControls.ScrollView(self, "EditPanel/TabListScroll")
	self.scrollView = UIControls.ScrollViewLoopH(self, "EditPanel/ItemList", 0, self.onCellChanged)
	self.curType = 5
	self._slot4filterHero = Slot(self.onHeroFilter, self)
	self.filterSelectPanel = FilterSelectPanel(self, "EditPanel/ListSelectPanel")

	self.filterSelectPanel:setFilterData(UIConst.HERO_DEFAULT_FILTER_PANEL_MAP[1], self._slot4filterHero, 1)

	local id = RearHouseDragCenter.getCurZoneId()

	self.btnClose:setText(string.format(Lang.get(30681), id))

	self.btnReverse = UIControls.Button(self, "EditPanel/OptionHero")

	self.btnReverse:addEventClick(self.onReverseBtnClick)
end

function RearHouseEditDlg:onOpen(...)
	RearHouseEditDlg.super.onOpen(self)

	self.mainState = GameFsm.getState(Const.STATE_MAIN_REAR_HOUSE)

	self.mainState:setCurUI(self)
	RearHouseDragCenter.setMode(self)
	self.mainState:setCameraOrthographic(true)

	RearHouseDragCenter.mEventDelObj = Slot(self.onDelObj, self)
	RearHouseDragCenter.mEventAddObj = Slot(self.onAddObj, self)

	local min, max = self.mainState:setCameraMode(-1, "f2o")
end

function RearHouseEditDlg:initLeftUI(...)
	local typeTxt = {
		Lang.get(30688),
		Lang.get(30689),
		Lang.get(30690)
	}
	local typeItem = {
		{
			5
		},
		{
			8,
			3,
			2
		},
		{
			1,
			4,
			6
		}
	}

	table.sort(typeItem[3], function(v1, v2)
		if RearHouseCommon.isWeightType(v1) == RearHouseCommon.isWeightType(v2) then
			return v1 < v2
		elseif RearHouseCommon.isWeightType(v1) then
			return true
		else
			return false
		end
	end)

	local flag = 0

	for i = 1, 3 do
		local tab = UIControls.Child(self, "EditPanel/TabListScroll/Content", "System/Backyard/TitleEditTab")

		tab:setVisible(true)

		tab.txtTitle = UIControls.Label(tab, "Text")

		tab.txtTitle:setText(typeTxt[i])

		local items = typeItem[i]

		for i, typeId in ipairs(items) do
			local btn = TabItem(self, "EditPanel/TabListScroll/Content", "System/Backyard/BtnEditTab", nil, nil, nil, nil, nil, flag)

			btn:setVisible(true)
			btn:initData(typeId)

			self.leftBtns[typeId] = btn
			flag = flag + 1
		end
	end

	self.leftUIInited = true
end

function RearHouseEditDlg:jumpToMid(mid)
	local info = RearHouseCommon.getFurnitureInfo(mid)

	self:show()

	if info then
		self:setCurTab(info.type_id)

		local datas = self.items[self.curType]

		if datas then
			self:refreshList(info.model_id)
		end
	end
end

function RearHouseEditDlg:show()
	local data = RearHouseDragCenter.getModelData()
	local count

	if data then
		local heroData = data[5]
		local dic = {}

		self.items = {}

		if CurAvatar:isCrystalOpened() == true then
			for i, info in ipairs(CurAvatar.crystalData.priests) do
				dic[info.hero] = true
			end
		end

		for typeId, items in pairs(data) do
			if typeId ~= 7 then
				self.items[typeId] = {}

				for i, item in ipairs(items) do
					if typeId == Const.REARHOUSE_TYPE_HERO then
						if not dic[item.hero.gid] then
							table.insert(self.items[typeId], item)
						end
					else
						table.insert(self.items[typeId], item)
					end
				end
			end
		end
	end

	self._allHeroDatas = self.items[5] or {}
	self._allHeros = {}

	for i, heroData in ipairs(self.items[5] or {}) do
		table.insert(self._allHeros, heroData.hero)
	end

	self:_filterHeros()
	self:sortByCurConfig(true)
	self:initLeftUI()
	self:setCurTab(self.curType)
	self:calculateComfortable()
	self:refreshUI()
end

function RearHouseEditDlg:refreshUI()
	self:onComfortableChange()

	CurAvatar.rearHouseData.comfort = self.comfortable

	local leftWeight = self:getPutWeightTotal()
	local level = CurAvatar.rearHouseData.level

	level = level > 0 and level or 1

	local limitWeight = RearHouseCommon.getTotalWeightByLevel(level, RearHouseDragCenter.getCurZoneId())

	self.txtWeightNum:setText(leftWeight .. "/" .. limitWeight)
end

function RearHouseEditDlg:onComfortableChange(...)
	self.txtComfortableNum:setText(self.comfortable)

	local fontColor = COLOR_MODE.YELLOW

	if self.comfortable > CurAvatar.rearHouseData.max_comfort then
		if RearHouseCommon.isNewPrivilege(self.comfortable) then
			self.imgComfortableUp:setVisible(true)
		else
			self.imgComfortableUp:setVisible(false)
		end

		fontColor = ResColor.GREEN

		self.txtComfortableNum:setFontColor(fontColor)
	else
		self.imgComfortableUp:setVisible(false)
		self.txtComfortableNum:setColorByRGBA(fontColor.r, fontColor.g, fontColor.b, fontColor.a)
	end
end

function RearHouseEditDlg:calculateComfortable(...)
	self.comfortable = self:getComfortableOtherWalls()

	local objs = RearHouseDragCenter.getObjsByType({
		1,
		2,
		3,
		4,
		6,
		7,
		8
	})

	if objs then
		for i, obj in ipairs(objs) do
			self.comfortable = self.comfortable + obj.putData.data.modelData.baseInfo.comfortable
		end
	end
end

function RearHouseEditDlg:setCurTab(typeId)
	if self.curType then
		self.leftBtns[self.curType]:setEnable(true)
	end

	self.curType = typeId

	self.leftBtns[self.curType]:setEnable(false)
	self.leftBtns[self.curType]:checkShowNew(false)

	if self.curType == 5 then
		self.filterSelectPanel:setVisible(true)
		self:sortByCurConfig(true)
		self.btnReverse:setVisible(true)

		if self.reverse then
			self.btnReverse:playAnimator("BtnSwitchSetOn")
		else
			self.btnReverse:playAnimator("BtnSwitchSetOff")
		end
	else
		self.filterSelectPanel:setVisible(false)
		self.btnReverse:setVisible(false)
	end

	self:refreshList()
end

function RearHouseEditDlg:getLimitNumByType(typeId)
	if self.leftBtns[typeId] then
		return self.leftBtns[typeId]:getLimitNum()
	end
end

function RearHouseEditDlg:getPutWeightTotal(...)
	local wallIndex = RearHouseDragCenter.getCurZoneId()

	if self.leftUIInited ~= true then
		return RearHouseCommon.getPutWeight(wallIndex)
	end

	local putWeight = 0

	for i, btn in pairs(self.leftBtns) do
		if RearHouseCommon.isWeightType(btn.typeId) then
			putWeight = putWeight + btn.putCount
		end
	end

	return putWeight
end

function RearHouseEditDlg:canPutNewObj(typeId, limitNum)
	local objs = self.items[typeId]

	if objs then
		for i, data in ipairs(objs) do
			if RearHouseCommon.isWeightType(typeId) then
				if data.count > 0 and limitNum >= (data.modelData.baseInfo.weight or 0) then
					return true
				end
			elseif data.count > 0 and limitNum > 0 then
				return true
			end
		end
	end

	return false
end

function RearHouseEditDlg:getUnlockInfo(typeId)
	typeId = typeId or self.curType

	if typeId then
		return self.typeUnlockDic[typeId]
	end
end

function RearHouseEditDlg:getCurTypeTotalNum(...)
	if self.curType then
		return self.leftBtns[self.curType]:getTotalNum()
	end

	return 0
end

local function sortForNoneHero(a, b)
	if a.count <= 0 and b.count > 0 then
		return false
	elseif b.count <= 0 and a.count > 0 then
		return true
	else
		local itemA, itemB = ResItem[a.modelId], ResItem[b.modelId]

		if itemA and itemB then
			if itemA.quality == itemB.quality then
				return itemA.id > itemB.id
			else
				return (itemA.quality or 0) > (itemB.quality or 0)
			end
		end
	end
end

function RearHouseEditDlg:refreshList(jumpModelId)
	local jumpIdex
	local datas = self.items[self.curType]
	local count = #datas

	if count <= 0 then
		self.imgNothing:setVisible(true)
	else
		self.imgNothing:setVisible(false)
	end

	if jumpModelId then
		for i, info in ipairs(datas or {}) do
			if jumpModelId == info.modelId then
				jumpIdex = i

				break
			end
		end
	end

	jumpIdex = jumpIdex and math.max(1, jumpIdex - 8)

	if self.curType ~= Const.REARHOUSE_TYPE_HERO and datas and #datas > 1 then
		table.sort(datas, sortForNoneHero)
	end

	self.scrollView:setTotalCount(count, jumpIdex)
end

function RearHouseEditDlg:destroy(...)
	RearHouseEditDlg.super.destroy(self)
	RearHouseDragCenter.leaveMode()
end

function RearHouseEditDlg:showWarning(show, content)
	self.imgWarning:setVisible(show)

	if content then
		self.txtWarning:setText(content)
	end
end

function RearHouseEditDlg:setSliderValue(value)
	self.slider:setValue(value)
end

function RearHouseEditDlg:onSliderValueChange(com, value)
	RearHouseDragCenter.onSliderValueChange(value)
end

function RearHouseEditDlg:onBtnFilterClick(...)
	local filterUI = UIManager.getUI("siftBoxDlg", true)

	filterUI:setIsHaveAll(true)
	filterUI:initFilterInfo(self.filterMap or UIConst.HERO_DEFAULT_FILTER_MAP, self._curFilterInfo, self._slot4filterHero)
	filterUI:setTitle(Lang.get(30691))
end

function RearHouseEditDlg:onHeroFilter(filterFunc, filterInfo)
	self._filterFunc = filterFunc
	self._curFilterInfo = filterInfo

	self:_filterHeros()
	self:sortByCurConfig(true)
	self:refreshList()
	UIManager.getUI("siftBoxDlg", false)
end

function RearHouseEditDlg:sortByCurConfig(needRefresh)
	if not needRefresh then
		return
	end

	if self.items[5] then
		table.sort(self.items[5], function(v1, v2)
			if v1.count == v2.count then
				if v1.hero.star == v2.hero.star then
					if v1.hero.step == v2.hero.step then
						if v1.hero.level == v2.hero.level then
							return v1.hero.id > v2.hero.id
						else
							return v1.hero.level > v2.hero.level
						end
					else
						return v1.hero.step > v2.hero.step
					end
				else
					return v1.hero.star > v2.hero.star
				end
			elseif v1.count > 0 then
				if self.reverse then
					return true
				else
					return false
				end
			elseif v2.count > 0 then
				if self.reverse then
					return false
				else
					return true
				end
			end
		end)
	end
end

function RearHouseEditDlg:onReverseBtnClick()
	self.reverse = not self.reverse

	if self.reverse then
		self.btnReverse:playAnimator("BtnSwitchOn")
	else
		self.btnReverse:playAnimator("BtnSwitchOff")
	end

	self:sortByCurConfig(true)
	self:refreshList()
end

function RearHouseEditDlg:_filterHeros(...)
	local heroDic = {}

	for i, hero in ipairs(self._allHeros) do
		if self._filterFunc == nil or self._filterFunc(hero) then
			heroDic[hero.gid] = true
		end
	end

	local _curHeroDatas = {}

	for i, data in ipairs(self._allHeroDatas) do
		if heroDic[data.hero.gid] then
			table.insert(_curHeroDatas, data)
		end
	end

	self.items[5] = _curHeroDatas
end

function RearHouseEditDlg:onDelObj(objs)
	local dic = {}

	for _, obj in ipairs(objs) do
		local typeId = obj.putData.data.typeId

		dic[typeId] = dic[typeId] or 0

		if RearHouseCommon.isWeightType(obj.putData.data.typeId) then
			dic[typeId] = dic[typeId] - obj.putData.data.modelData.baseInfo.weight or 0
		else
			dic[typeId] = dic[typeId] - 1
		end

		if obj.putData.data.modelData.baseInfo.comfortable then
			self.comfortable = self.comfortable - obj.putData.data.modelData.baseInfo.comfortable
		end
	end

	self:refreshLimitInfo(dic)
	self:refreshList()
	self:refreshUI()
end

function RearHouseEditDlg:onAddObj(objs)
	local dic = {}

	for _, obj in ipairs(objs) do
		if obj.initData and not obj.initData.isStage then
			local typeId = obj.putData.data.typeId

			dic[typeId] = dic[typeId] or 0

			if RearHouseCommon.isWeightType(obj.putData.data.typeId) then
				dic[typeId] = dic[typeId] + obj.putData.data.modelData.baseInfo.weight or 0
			else
				dic[typeId] = dic[typeId] + 1
			end

			if obj.putData.data.modelData.baseInfo.comfortable then
				self.comfortable = self.comfortable + obj.putData.data.modelData.baseInfo.comfortable
			end
		end
	end

	self:refreshLimitInfo(dic)
	self:refreshList()
	self:refreshUI()
end

function RearHouseEditDlg:refreshLimitInfo(dic)
	local isContainWeightType = false

	for i, btn in pairs(self.leftBtns) do
		if dic[btn.typeId] then
			isContainWeightType = isContainWeightType or RearHouseCommon.isWeightType(btn.typeId)

			if btn.typeId == 5 then
				self:sortByCurConfig(false)
			end

			btn:setPutCount(dic[btn.typeId])
		end
	end

	for i, btn in pairs(self.leftBtns) do
		if dic[btn.typeId] ~= nil or isContainWeightType and RearHouseCommon.isWeightType(btn.typeId) then
			btn:refreshNum()
		end
	end
end

function RearHouseEditDlg:onBtnResetClick(...)
	local content = Lang.get(30692)

	local function yesFunc(...)
		RearHouseDragCenter.resetOpration()
	end

	UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "", content, yesFunc, nil, -1)
end

function RearHouseEditDlg:setDragPutEnable(v)
	if v then
		self.dragPutEnable = v == 1
	end
end

function RearHouseEditDlg:onBtnCloseClick(...)
	if RearHouseDragCenter.isChanged() then
		local content = Lang.get(30693)

		local function yesFunc(...)
			RearHouseDragCenter.resetOpration()
			self:close()
		end

		UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "", content, yesFunc, nil, -1)
	else
		self:close()
	end
end

function RearHouseEditDlg:close(...)
	RearHouseDragCenter.onQuitEditMode(true)
	self.mainState:setCameraOrthographic(false)
	self.mainState:setCameraMode(99, "o2f")
	self.slider:setVisible(false)
	self:setVisible(false)
end

function RearHouseEditDlg:onBtnTipsClick(...)
	return
end

function RearHouseEditDlg:canSave(...)
	for typeId, items in pairs(self.items) do
		if self:getLimitNumByType(typeId) < 0 then
			MsgManager.notice(Lang.get(30694))

			return false
		end
	end

	return true
end

function RearHouseEditDlg:onBtnSaveClick(...)
	if not self:canSave() then
		return
	end

	if RearHouseDragCenter.save() then
		MsgManager.notice(Lang.get(30695))
		RearHouseDragCenter.saveToServer()
		self:close()
	else
		local content = Lang.get(30696)

		local function yesFunc(...)
			RearHouseDragCenter.saveToServer(true)
			self:close()
		end

		UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "", content, nil, yesFunc, -1, Lang.get(30697), Lang.get(30698))
		self:showWarning(true)
	end
end

function RearHouseEditDlg:onBtnDeleteClick(...)
	local content = Lang.get(30699)

	local function yesFunc(...)
		RearHouseDragCenter.delAllObj()
	end

	UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, "", content, yesFunc, nil, -1)
end

function RearHouseEditDlg:onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = ItemCell(sender, "System/Backyard/GridFurniture", newIdx)
	else
		if targetCell.mIndex then
			self.cells[targetCell.mIndex] = nil
		end

		targetCell.mIndex = newIdx
	end

	self.cells[newIdx] = targetCell

	targetCell:setData(self.items[self.curType][newIdx])
end

function RearHouseEditDlg:setBeginnerState(...)
	self.inBeginnerState = true
end

function RearHouseEditDlg:isInBeginnerState(...)
	return self.inBeginnerState
end

function RearHouseEditDlg:checkAttrInfo(info)
	if info then
		self.panelAttr:setVisible(true)

		if #info.model_ids == 1 then
			self.panelSingle:setVisible(true)
			self.panelSuit:setVisible(false)

			local iconPath, strs = RearHouseCommon.getSingleAttrIconAndDescs(info)

			if strs then
				for i = 1, #self.txtSingleAttrs do
					local info = self.txtSingleAttrs[i]

					if strs[i] then
						info[1]:setVisible(true)
						info[2]:setText(strs[i])
					else
						info[1]:setVisible(false)
					end
				end
			end

			if iconPath then
				self.imgAttrIcon:setImage(iconPath[1], iconPath[2])
			end

			local item = ResItem[info.model_ids[1]]

			if item and item.name then
				self.txtSingleName:setText(item.name)
			else
				self.txtSingleName:setText("")
			end
		else
			self.panelSuit:setVisible(true)
			self.panelSingle:setVisible(false)
			self.txtSuitName:setText(info.name)

			local putNum = RearHouseDragCenter.getCurValidAttrNum(info)

			self.txtSuitPutNum:setText(string.format(Lang.get(30682), putNum))

			local effectNumInfos = RearHouseCommon.getSuitAttrDescs(info)

			if effectNumInfos then
				for i = 1, math.max(#effectNumInfos, #self.txtSuitAttrs) do
					local child = self.txtSuitAttrs[i]

					if effectNumInfos[i] then
						child[1]:setVisible(true)
						child[2]:setText(string.format(Lang.get(30671), effectNumInfos[i].num))
						child[3]:setText(effectNumInfos[i].desc)

						if putNum >= effectNumInfos[i].num then
							child[2]:setFontColor(ResColor.ORANGEBTN)
							child[3]:setFontColor(ResColor.ORANGEBTN)
						else
							child[2]:setFontColor(ResColor.GREYLIGHT)
							child[3]:setFontColor(ResColor.GREYLIGHT)
						end
					elseif child then
						child[1]:setVisible(false)
					end
				end
			end
		end
	else
		self.panelAttr:setVisible(false)
	end
end

function RearHouseEditDlg:isPutedOnOtherWall(id)
	if self.putedMap == nil then
		self.putedMap = RearHouseDragCenter.getPutedMap()
	end

	return self.putedMap[id]
end

function RearHouseEditDlg:getComfortableOtherWalls(...)
	if self.otherWallComfort then
		return self.otherWallComfort
	end

	if self.putedMap == nil then
		self.putedMap = RearHouseDragCenter.getPutedMap()
	end

	local num = 0

	for mid, info in pairs(self.putedMap) do
		num = num + RearHouseCommon.getComfortByMid(mid) * info.num
	end

	self.otherWallComfort = num

	return self.otherWallComfort
end

function RearHouseEditDlg:checkPutHero(putCount, wallIndex)
	local totalCount = utils.getTableElemCount(CurAvatar.heroDic)
	local limitNum = RearHouseCommon.getLimitNumByType(Const.REARHOUSE_TYPE_HERO, wallIndex)
	local result = false

	if CurAvatar:isCrystalOpened() then
		local count = 0
		local putedCount = 0

		if putCount then
			count = putCount
			putedCount = putCount

			for _, heroInfo in ipairs(CurAvatar.rearHouseData.hero_data.hero) do
				if heroInfo.pos.area ~= wallIndex then
					count = count + 1
				end
			end
		end

		if putedCount < limitNum and totalCount - count - #CurAvatar.crystalData.priests > 0 then
			result = true
		end
	end

	return result
end

return RearHouseEditDlg
