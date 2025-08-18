-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\RearHouse\\RearHouseLvUpDlg.lua

local ResRearHouseLevelConfig = require("ClientData/ResRearHouseLevelConfig")
local ResColor = require("ClientData/ResColor")
local ResItem = require("ClientData/ResItem")
local ResRearHouseLayer = require("ClientData/ResRearHouseLayer")
local ResRearHouseMiscConfig = require("ClientData/ResRearHouseMiscConfig")
local RearHouseDragCenter = require("Logic/RearHouse/RearHouseDragCenter")
local ResConditionLimit = require("ClientData/ResConditionLimit")
local RearHouseCommon = require("Logic/RearHouse/RearHouseCommon")
local DOTweenComponent = typeof(Framework.EffectSystem.DOTweenComponent)
local strClassName = "RearHouseLvUpDlg"
local RearHouseLvUpDlg = Class(strClassName, UIControls.Window)
local TYPE_CONTRAST
local LEVEL_UNLOCK = {
	[ResRearHouseMiscConfig[1].crystal_unlock_lv] = {
		Lang.get(30704)
	},
	[ResRearHouseMiscConfig[1].shop_unlock_lv] = {
		Lang.get(30705)
	},
	[ResRearHouseMiscConfig[1].dispatch_unlock_lv] = {
		Lang.get(30706)
	},
	[ResRearHouseMiscConfig[1].clean_unlock_lv] = {
		Lang.get(30707)
	}
}

for i, lv in ipairs(ResRearHouseMiscConfig[1].other_wall_unlock_lv) do
	LEVEL_UNLOCK[lv] = {
		Lang.get(30708)
	}
end

local WEIGTH_TYPE = 8
local TOTAL_BAR_ANI_TIME = 1.5
local COLOR = {
	GRAY = {
		g = 0.6705882352941176,
		a = 1,
		b = 0.6705882352941176,
		r = 0.6705882352941176
	},
	BLUE = {
		g = 0.6627450980392157,
		a = 1,
		b = 0.9019607843137255,
		r = 0.25098039215686274
	}
}

function RearHouseLvUpDlg:ctor(...)
	self:initTypeContrast()
	self:initUI()
	self:initUnlockData()
end

function RearHouseLvUpDlg:onOpen(...)
	RearHouseLvUpDlg.super.onOpen(self)
	self:refreshUI(true)
end

function RearHouseLvUpDlg:destroy(...)
	RearHouseLvUpDlg.super.destroy(self)

	self.tweenComFlag = nil
end

function RearHouseLvUpDlg:initUnlockData(...)
	local index = 1
	local tempData = {}

	for i, info in pairs(LEVEL_UNLOCK) do
		tempData[i] = {}

		for _, desc in ipairs(info) do
			table.insert(tempData[i], desc)
		end
	end

	for i, info in ipairs(ResRearHouseLevelConfig) do
		if info.unlock_wall == index then
			local desc = self:_getUnlockDesc(i)

			if tempData[i] then
				table.insert(tempData[i], desc)
			else
				tempData[i] = {
					desc
				}
			end

			index = index == Const.REARHOUSE_WALL_LOCK_NUM and 1 or index + 1
		end
	end

	self.unlockDesc = {}

	for i, info in pairs(tempData) do
		table.insert(self.unlockDesc, {
			index = i,
			data = info
		})
	end

	table.sort(self.unlockDesc, function(v1, v2)
		return v1.index < v2.index
	end)

	self.unlockDescDic = tempData
end

function RearHouseLvUpDlg:_getUnlockDesc(level)
	if Const.REARHOUSE_WALL_NUM > 1 then
		for i = Const.REARHOUSE_WALL_NUM, 1, -1 do
			local unlockLevel = RearHouseCommon.getWallUnlockLevel(i)

			if unlockLevel <= level then
				if i < 2 then
					return Lang.get(30709), unlockLevel == level
				else
					return Lang.get(30710), unlockLevel == level
				end
			end
		end
	end

	return Lang.get(30709)
end

function RearHouseLvUpDlg:initTypeContrast(...)
	local data = RearHouseCommon.getLevelUpNumInfo()

	table.insert(data, 1, WEIGTH_TYPE)

	TYPE_CONTRAST = data

	table.sort(TYPE_CONTRAST, function(v1, v2)
		if v1 == Const.REARHOUSE_TYPE_HERO then
			return true
		elseif v2 == Const.REARHOUSE_TYPE_HERO then
			return false
		else
			return v1 < v2
		end
	end)
end

function RearHouseLvUpDlg:initUI(...)
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnAll = UIControls.Button(self, "BgPanel/BtnAll")

	self.btnAll:addEventClick(self.onBtnAllClick)

	self.btnAll.txtMore = UIControls.Label(self, "BgPanel/BtnAll/Text1")
	self.btnAll.txtNomal = UIControls.Label(self, "BgPanel/BtnAll/Text2")
	self.txtLvNum = UIControls.Label(self, "BgPanel/LvProgressBar/ImgLv/TextLvNum")
	self.txtMax = UIControls.Label(self, "BgPanel/LvProgressBar/ImgLv/TextLvMax")
	self.imgFlag = UIControls.Image(self, "BgPanel/LvProgressBar/ImgLv")
	self.tweenComFlag = self.imgFlag:getGameObject():GetComponent(DOTweenComponent)

	local panelFlagBar = UIControls.Panel(self, "BgPanel/LvProgressBar")

	self.totalBarHeight = panelFlagBar:getRectSize().height
	self.panelMoreInfo = UIControls.Panel(self, "BgPanel/BackyardPanel")
	self.txtLvBefore = UIControls.Label(self, "BgPanel/BackyardPanel/TextBefore")
	self.txtLvAfter2 = UIControls.Label(self, "BgPanel/BackyardPanel/TextAfter")
	self.txtLvLimit = UIControls.Label(self, "BgPanel/PurviewPanel/TextTitle")
	self.txtUnlockDesc = UIControls.Label(self, "BgPanel/PurviewPanel/Text")
	self.txtConditionDesc = UIControls.Label(self, "BgPanel/TextRule")
	self.panelPurview = UIControls.Panel(self, "BgPanel/PurviewPanel")
	self.aniLevelUp = UIControls.UIAni(self, "BgPanel")
	self.redHintUpgrade = UIControls.RedDot(self, "BgPanel/BtnConfirm/IconNew")

	self.redHintUpgrade:addHint({
		UIConst.RD_HINT_REAR_HOUSE_UPGREAD_BTN
	})

	self.btnConfirm = UIControls.Button(self, "BgPanel/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)

	self.txtUpgrade = UIControls.Label(self, "BgPanel/BtnConfirm/Text")
	self.txtConfirmEn = UIControls.Label(self, "BgPanel/BtnConfirm/TextEng")
	self.txtPrompt = UIControls.Label(self, "BgPanel/TextPrompt")
	self.imgMax = UIControls.Image(self, "BgPanel/ImgMax")
	self.levelCells = {}
	self.costUIs = {}

	for i = 1, 2 do
		local data = {}

		data.imgIcon = UIControls.Image(self, "BgPanel/BtnConfirm/Icon" .. i)
		data.txtNum = UIControls.Label(self, "BgPanel/BtnConfirm/TextNum" .. i)

		table.insert(self.costUIs, data)
	end

	self.contrastCells = {}
end

function RearHouseLvUpDlg:getAttrCell(index)
	local cell = self.contrastCells[index]

	if cell then
		return cell
	end

	local cell = UIControls.Child(self, "BgPanel/BackyardPanel/BackyardList/Content", "System/Backyard/CellBackyardLvUpNum", 0, 0, true)

	cell.curName = UIControls.Label(cell, "TextTitle")
	cell.curLimitNum = UIControls.Label(cell, "TextNum1")
	cell.nextLimitNum = UIControls.Label(cell, "TextNum2")
	cell.imgArrow = UIControls.Image(cell, "BgArrow")
	cell.txt1 = UIControls.Label(cell, "Text1")
	cell.txt2 = UIControls.Label(cell, "Text2")

	table.insert(self.contrastCells, cell)

	return cell
end

function RearHouseLvUpDlg:_refreshFlagAni(isFirst)
	local duration = TOTAL_BAR_ANI_TIME / self.curPartNums

	if self.curPartIndex == 1 then
		duration = 0
	end

	if isFirst then
		duration = 0
	end

	self:_playSound(isFirst)
	self:_flagMove(self.curPartIndex, duration)
end

function RearHouseLvUpDlg:_playSound(isFirst)
	if isFirst or self.stopRefresh == true then
		-- block empty
	elseif self.curPartIndex == 1 then
		CueManager.playUiSfx("Audios/SFX/UI/ui_backyard_upgrade2.ogg")
	else
		CueManager.playUiSfx("Audios/SFX/UI/ui_backyard_upgrade1.ogg")
	end
end

function RearHouseLvUpDlg:_refreshFlag(...)
	for i = 1, self.curPartNums do
		local cell

		if self.levelCells[i] then
			cell = self.levelCells[i]
		else
			cell = UIControls.Child(self, "BgPanel/LvProgressBar", "System/Backyard/CellLvUpFlagpole", 0, 0, true)
			cell.imgDis = UIControls.Image(cell, "ImgDis")

			table.insert(self.levelCells, cell)
		end

		cell:setVisible(true)

		if self.curPartNums - i < self.curPartIndex then
			cell.imgDis:setVisible(false)
		else
			cell.imgDis:setVisible(true)
		end
	end

	for i = self.curPartNums + 1, #self.levelCells do
		self.levelCells[i]:setVisible(false)
	end
end

function RearHouseLvUpDlg:_refreshDetailInfo(...)
	local curLevel = CurAvatar.rearHouseData.level

	if Const.REVIEW_VERSION then
		self.txtLvBefore:setText(Lang.get(1203) .. self.curBigLevel .. "." .. self.curPartIndex)
	else
		self.txtLvBefore:setText("LV" .. self.curBigLevel .. "." .. self.curPartIndex)
	end

	local nextLevel = math.min(#ResRearHouseLevelConfig, curLevel + 1)
	local curData = ResRearHouseLevelConfig[curLevel]
	local nextData = ResRearHouseLevelConfig[nextLevel]

	self.nextData = nextData

	local count, bigLv, smallLv = self:_getSmallLevelCount(nextLevel)

	if self.isMaxLevel == false then
		if Const.REVIEW_VERSION then
			self.txtLvAfter2:setText(Lang.get(1203) .. bigLv .. "." .. smallLv)
		else
			self.txtLvAfter2:setText("LV" .. bigLv .. "." .. smallLv)
		end
	else
		self.txtLvAfter2:setText("MAX")
	end

	local index = 0
	local _curLimit, _nextLimit

	for j = 1, Const.REARHOUSE_WALL_NUM do
		local level = RearHouseCommon.getWallUnlockLevel(j)

		if level <= nextLevel then
			index = index + 1

			local cell = self:getAttrCell(index)

			cell.curName:setText(string.format(Lang.get(30700), j))
			cell.curName:setFontColor(ResColor.ORANGEBTN)
			cell.curLimitNum:setVisible(false)
			cell.nextLimitNum:setVisible(false)
			cell.imgArrow:setVisible(false)
			cell.txt1:setVisible(false)
			cell.txt2:setVisible(false)
		else
			break
		end

		for i, typeId in ipairs(TYPE_CONTRAST) do
			index = index + 1

			local cell = self:getAttrCell(index)
			local name = ResRearHouseLayer[typeId].type_name

			if RearHouseCommon.isWeightType(typeId) then
				name = Lang.get(30711)
				_curLimit = RearHouseCommon.getTotalWeightByLevel(curLevel, j)
				_nextLimit = RearHouseCommon.getTotalWeightByLevel(nextLevel, j)
			else
				name = string.format(Lang.get(30701), name)
				_curLimit = curData.part_limit[typeId].limit[j] or 0
				_nextLimit = nextData.part_limit[typeId].limit[j] or 0
			end

			cell.curName:setFontColor(ResColor.WHITE)
			cell.curName:setText(name)
			cell.curLimitNum:setText(_curLimit)

			if self.isMaxLevel == false then
				cell.nextLimitNum:setText(_nextLimit)
			else
				cell.nextLimitNum:setText("MAX")
			end

			if typeId == Const.REARHOUSE_TYPE_HERO and ResRearHouseMiscConfig[1].crystal_unlock_lv == nextLevel then
				cell.curName:setText("")
				cell.curLimitNum:setText("")
				cell.nextLimitNum:setText("")
				cell.imgArrow:setVisible(false)
				cell.txt1:setVisible(true)
				cell.txt2:setVisible(true)
			else
				cell.txt1:setVisible(false)
				cell.txt2:setVisible(false)
				cell.imgArrow:setVisible(true)
			end
		end
	end
end

function RearHouseLvUpDlg:_refreshCondition(...)
	local hideRule = false

	if RearHouseCommon.isPart1Max() then
		self.txtPrompt:setVisible(false)
		self.btnConfirm:setVisible(false)

		hideRule = true or hideRule
	end

	local limitId = self.nextData.condition_limit

	if limitId ~= nil then
		self.limitDesc = string.format(Lang.get(30702), ResConditionLimit[limitId].unlock_desc)

		self.txtConditionDesc:setText(self.limitDesc)

		self.conditonLimit = ConditionLimitManager.inLimitState(self.nextData.condition_limit)
		self.nextLimitId = limitId
	else
		self.conditonLimit = false
	end

	if self.conditonLimit and hideRule == false then
		self.txtConditionDesc:setVisible(true)
	else
		self.txtConditionDesc:setVisible(false)
	end

	self.costEnough = true
	self.lackItemNames = {}

	local costData = self.nextData.resource_consume

	for i, uiData in ipairs(self.costUIs) do
		if costData[i] then
			uiData.imgIcon:setVisible(true)
			uiData.txtNum:setVisible(true)

			local item = BaseObject.GetObject(costData[i].id)
			local iconPath = item:getIconPath()

			uiData.imgIcon:setImage(iconPath[1], iconPath[2])

			local ownNum = CurAvatar:getItemNumById(costData[i].id)

			if ownNum >= costData[i].num then
				-- block empty
			else
				table.insert(self.lackItemNames, item.name)
			end

			self.costEnough = self.costEnough and ownNum >= costData[i].num

			uiData.txtNum:setText(ClientUtils.getNumShortStr(costData[i].num))

			if self.conditonLimit or not self.costEnough then
				self:_setLabelColor(uiData.txtNum, COLOR.GRAY)
			elseif self.costEnough then
				uiData.txtNum:setFontColor(ResColor.WHITE)
			else
				uiData.txtNum:setFontColor(ResColor.RED)
			end
		else
			uiData.imgIcon:setVisible(false)
			uiData.txtNum:setVisible(false)
		end
	end

	local isGray = false

	if self.conditonLimit or not self.costEnough then
		isGray = true

		self.btnConfirm:setObjGray(true)
		self:_setLabelColor(self.txtConfirmEn, COLOR.GRAY)
		self:_setLabelColor(self.txtUpgrade, COLOR.GRAY)
	else
		isGray = false

		self.btnConfirm:setObjGray(false)
		self:_setLabelColor(self.txtConfirmEn, COLOR.BLUE)
		self.txtUpgrade:setFontColor(ResColor.WHITE)
	end
end

function RearHouseLvUpDlg:_refreshNextUnlockInfo(...)
	local nextUnlockLevel = 0
	local descs = {}
	local curLevel = CurAvatar.rearHouseData.level

	for i, info in ipairs(self.unlockDesc) do
		if curLevel < info.index then
			nextUnlockLevel = info.index

			for _, desc in ipairs(info.data) do
				table.insert(descs, desc)
			end

			break
		end
	end

	self.nextUnlockLevel = nextUnlockLevel

	if nextUnlockLevel == 0 then
		self.panelPurview:setVisible(false)
		self.panelMoreInfo:setVisible(true)
		self.btnAll:setVisible(false)
	else
		local count, bigLv, smallLv = self:_getSmallLevelCount(nextUnlockLevel)

		if Const.REVIEW_VERSION then
			self.txtLvLimit:setText(utils.format(Lang.get(111365), bigLv, smallLv))
		else
			self.txtLvLimit:setText(utils.format(Lang.get(30703), bigLv, smallLv))
		end

		local content = ""

		for i, desc in ipairs(descs) do
			content = content .. desc

			if i ~= #descs then
				content = content .. "\n"
			end
		end

		self.txtUnlockDesc:setText(content)
	end
end

function RearHouseLvUpDlg:refreshUI(isFirst)
	if self.stopRefresh == true then
		return
	end

	local curLevel = CurAvatar.rearHouseData.level
	local heroName = Lang.get(423)
	local count, bigLv, smallLv = self:_getSmallLevelCount(curLevel)

	self.curBigLevel = bigLv
	self.curPartIndex = smallLv
	self.curPartNums = count
	self.isMaxLevel = curLevel == #ResRearHouseLevelConfig

	self:_refreshFlagAni(isFirst)
	self:_refreshFlag()
	self:_refreshDetailInfo()
	self:_refreshCondition()
	self:_refreshNextUnlockInfo()

	if self.isMaxLevel == true then
		self.txtLvNum:setVisible(false)
		self.txtMax:setVisible(true)
		self.btnAll:setVisible(false)
		self.btnConfirm:setVisible(false)
		self.imgMax:setVisible(true)
	else
		self.txtLvNum:setVisible(true)
		self.txtLvNum:setText(bigLv .. "." .. smallLv)
		self.txtMax:setVisible(false)
	end
end

function RearHouseLvUpDlg:onLevelUpSuccess(...)
	MsgManager.notice(Lang.get(30712))

	if CurAvatar.rearHouseData.level >= #ResRearHouseLevelConfig then
		-- block empty
	elseif CurAvatar.rearHouseData.level == self.nextUnlockLevel then
		local data = {
			unlockLevel = self.nextUnlockLevel,
			unlockDescs = self.unlockDescDic[self.nextUnlockLevel]
		}

		RearHouseDragCenter.unlockEffect(data)
		self:setVisible(false)

		self.stopRefresh = true

		return
	end

	self.aniLevelUp:startAni("ShowBackyardLvUp")
end

function RearHouseLvUpDlg:_setLabelColor(label, color)
	label:setColorByRGBA(color.r, color.g, color.b, color.a)
end

function RearHouseLvUpDlg:onBtnCloseClick(...)
	self:setVisible(false)
end

function RearHouseLvUpDlg:onBtnAllClick(...)
	if self.panelMoreInfo:getVisible() == false then
		self.btnAll.txtNomal:setVisible(true)
		self.btnAll.txtMore:setVisible(false)
		self.panelMoreInfo:setVisible(true)
		self.panelPurview:setVisible(false)
	else
		self.btnAll.txtNomal:setVisible(false)
		self.btnAll.txtMore:setVisible(true)
		self.panelMoreInfo:setVisible(false)
		self.panelPurview:setVisible(self.nextUnlockLevel ~= 0)
	end
end

function RearHouseLvUpDlg:onBtnConfirmClick(...)
	if self.conditonLimit then
		MsgManager.notice(ConditionLimitManager.getLimitUnlockDesc(self.nextLimitId))
	elseif not self.costEnough then
		if self.lackItemNames and #self.lackItemNames > 0 then
			MsgManager.notice(string.format(Lang.get(30029), self.lackItemNames[1]))
		end
	else
		RPC.houseLevelUp()
	end
end

function RearHouseLvUpDlg:_flagMove(curPartIndex, duration)
	local partY = self.totalBarHeight / self.curPartNums
	local x = self.imgFlag:getPosition().x

	self.tweenComFlag:UITweenMove(Vector3(x, -(self.curPartNums - curPartIndex) * partY, 0), duration, nil)
end

function RearHouseLvUpDlg:_getSmallLevelCount(level)
	local data = CurAvatar:getRearHouseLevelInfo(level)

	return data.count, data.bigLv, data.smallLv
end

return RearHouseLvUpDlg
