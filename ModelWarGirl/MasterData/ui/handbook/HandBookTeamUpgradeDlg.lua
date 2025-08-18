-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\HandBook\\HandBookTeamUpgradeDlg.lua

local ResHeroProficientLevel = require("ClientData/ResHeroProficientLevel")
local ResURHeroProficientLevel = require("ClientData/ResURHeroProficientLevel")
local ResHeroPaint = require("ClientData/ResHeroPaint")
local ResColor = require("ClientData/ResColor")
local STATE = {
	UPGRADED = 1,
	CAN_UPGRADE = 2,
	CANT_UPGRADE = 3
}
local TeamVerAttrCell = Class("TeamVerAttrCell", UIControls.Child)

function TeamVerAttrCell:ctor(...)
	self:initUI()
end

function TeamVerAttrCell:initUI(...)
	self.imgNormal = UIControls.Image(self, "ImgSquare")
	self.imgChange = UIControls.Image(self, "ImgChange")
	self.txtAttr = UIControls.Label(self, "AttrPanel/TextAttr")
	self.txtAttrValue = UIControls.Label(self, "AttrPanel/TextAttrValue")
	self.txtChange = UIControls.Label(self, "AttrPanel/TextChange")
	self.txtAttrValueChange = UIControls.Label(self, "AttrPanel/TextAttrValueChange")
	self.efxAttr = UIControls.LazyEffectPlayer(self, "Efx")
end

function TeamVerAttrCell:setData(data)
	local info = data.data
	local isChange = false
	local isNew = false
	local isState = false
	local isJPPaint = false
	local _isAllUpgraded = self.mWindow:isAllUpgraded()

	if data.type == "attrs" then
		local id = info.id
		local attrName = BattleConst.PROP_TYPE_CONFIG[id]
		local zhName, valueStrPre = ClientUtils.getRolePropZhName(attrName, info.pre, false)
		local zhName, valueStrNew = ClientUtils.getRolePropZhName(attrName, info.new, false)

		self.txtAttr:setText(zhName)

		if _isAllUpgraded then
			self.txtAttrValue:setText("+" .. valueStrNew)
		elseif info.pre == 0 then
			isNew = true

			self.txtAttrValueChange:setText(zhName .. " +" .. valueStrNew)
		else
			if info.pre ~= info.new then
				isChange = true
			end

			self.txtAttrValue:setText("+" .. valueStrPre)
			self.txtAttrValueChange:setText("+" .. valueStrNew)
		end
	elseif data.type == "state" then
		isState = true

		if _isAllUpgraded then
			self.txtAttrValue:setText(info.desc)
		elseif info.isNew then
			isNew = true

			self.txtAttrValueChange:setText(info.desc)
		else
			self.txtAttrValue:setText(info.desc)
		end
	elseif data.type == "paint" then
		self.txtAttr:setText(Lang.get(30318))

		if RegionUtils.isJP() then
			isJPPaint = true
		end

		if _isAllUpgraded then
			self.txtAttrValue:setText(info[2])
		else
			self.txtAttrValue:setText(info[1])

			if info[1] == info[2] then
				-- block empty
			else
				isChange = true

				self.txtAttrValueChange:setText(info[2])
			end
		end
	end

	self.needPlayEfx = isNew or isChange

	if isNew and not _isAllUpgraded then
		self.imgChange:setImage("Atlas/HandBookAtlas/HandBookTeamAtlas1", "IconNew")
		self.txtAttr:setVisible(false)
		self.txtAttrValue:setVisible(false)
		self.txtChange:setVisible(false)
		self.txtAttrValueChange:setVisible(true)
	elseif isChange and not _isAllUpgraded then
		self.imgChange:setImage("Atlas/HandBookAtlas/HandBookTeamAtlas1", "IconUp")
		self.txtAttr:setVisible(true)
		self.txtAttrValue:setVisible(true)
		self.txtChange:setVisible(true)
		self.txtAttrValueChange:setVisible(true)
	else
		self.txtAttr:setVisible(not isState)
		self.txtAttrValue:setVisible(true)
		self.txtChange:setVisible(false)
		self.txtAttrValueChange:setVisible(false)
	end

	self.imgNormal:setVisible(not isChange and not isNew)
	self.imgChange:setVisible(isChange or isNew)

	if isJPPaint then
		self.txtChange:setVisible(false)
		self.txtAttrValue:setVisible(_isAllUpgraded or not isChange)
	end
end

function TeamVerAttrCell:playEffect(...)
	if self.mWindow.isInit or not self.needPlayEfx then
		return
	end

	self.efxAttr:setVisible(true)
	self.efxAttr:playEffect()
end

local TeamVerCell = Class("TeamVerCell", UIControls.Child)

function TeamVerCell:ctor(...)
	self:initUI()

	self.state = nil
end

function TeamVerCell:initUI(...)
	self.imgBar = UIControls.MaterialProgress(self, "BgProgress/ImgBar")
	self.imgVer = UIControls.Image(self, "VerPanel/ImgVer")
	self.txtVer = UIControls.Label(self, "VerPanel/TextVer")
	self.uis = {}

	local path = {
		"BgProgress",
		"VerPanel"
	}

	for i, p in ipairs(path) do
		local panel = UIControls.Panel(self, p)

		table.insert(self.uis, panel)
	end

	self.efxVer = UIControls.LazyEffectPlayer(self, "Efx")
	self.btnSensor = UIControls.Button(self, "")

	self.btnSensor:addEventClick(self.onBtnSensorClick)

	self.mEventCellClick = nil
end

function TeamVerCell:setData(level)
	self.level = level

	local info = self.mParent.resData[level]
	local isShow = false

	if info then
		isShow = true

		self.txtVer:setText(level)
	end

	for i, ui in ipairs(self.uis) do
		ui:setVisible(isShow)
	end

	self.state = self.mWindow:getUpgradeState(self.level)

	if self.level <= self.mWindow.centerLevel then
		self.imgVer:setImage("Atlas/HandBookAtlas/HandBookTeamAtlas1", "BgVersion")
		self.txtVer:setFontColor(ResColor.COLORRANK04)
	else
		self.imgVer:setImage("Atlas/HandBookAtlas/HandBookTeamAtlas1", "BgVersionDis")
		self.txtVer:setFontColor(ResColor.GREYLIGHT)
	end
end

function TeamVerCell:setSelected(v)
	self.btnSensor:setEnable(not v)
end

function TeamVerCell:playEffect(...)
	self.efxVer:setVisible(true)
	self.efxVer:playEffect()
end

function TeamVerCell:onBtnSensorClick(...)
	if self.mEventCellClick then
		self.mEventCellClick(self)
	end
end

function TeamVerCell:showBarValue(v)
	if not v then
		self.imgBar:setVisible(false)
		self:setObjGray(self.level > self.mWindow.centerLevel)
		self.uis[1]:setVisible(false)

		return
	end

	self:setObjGray(false)

	local preInfo = self.mWindow.resData[self.level - 1]
	local nowInfo = self.mWindow.resData[self.level]

	if not nowInfo then
		self.uis[1]:setVisible(false)
	else
		self.uis[1]:setVisible(true)

		local gScore, tScore = 0, 0

		if preInfo then
			gScore = preInfo.group_score
			tScore = preInfo.total_score or 0
		end

		local gOffset = nowInfo.group_score - gScore
		local tOffset = (nowInfo.total_score or 0) - tScore
		local myGScore = 0
		local gInfo = CurAvatar:getProficientGInfo(self.mWindow.teamIndex, self.mWindow.teamIndex)

		if gInfo then
			myGScore = gInfo.score
		end

		local myTotalScore = CurAvatar:getTotalProficient()
		local value = (math.min(gOffset, myGScore - gScore) + math.min(tOffset, myTotalScore - tScore)) / (tOffset + gOffset)

		self.imgBar:setValue(value)
	end
end

local strClassName = "HandBookTeamUpgradeDlg"
local HandBookTeamUpgradeDlg = Class(strClassName, UIControls.Window)

function HandBookTeamUpgradeDlg:ctor(...)
	self:initUI()
	self:initData()
end

function HandBookTeamUpgradeDlg:initUI(...)
	self.aniVerInfo = UIControls.UIAni(self, "BgPanel/VerInfoPanel")
	self.panelOther = UIControls.Panel(self, "BgPanel/VerInfoPanel/OtherPanel")
	self.txtOther = UIControls.Label(self, "BgPanel/VerInfoPanel/OtherPanel/Text")
	self.imgArrow = UIControls.Image(self, "BgPanel/VerInfoPanel/OtherPanel/ImgArrow")
	self.imgUpgradeRedHint = UIControls.Image(self, "BgPanel/VerInfoPanel/BtnUpdate/IconNew")
	self.btnUpgrade = UIControls.Button(self, "BgPanel/VerInfoPanel/BtnUpdate")

	self.btnUpgrade:addEventClick(self.onBtnUpgradeClick)

	self.scrollPage = UIControls.ScrollView(self, "BgPanel/VerList")

	self.scrollPage:addScrollCorrectOnChanged(self.onCorrectEvent)
	self:setScrollEnable(false)

	self.conditonUIs = {}

	for i = 1, 2 do
		local path = "BgPanel/VerInfoPanel/Condition" .. i
		local panel = UIControls.Panel(self, path)
		local txtTitle = UIControls.Label(self, path .. "/TextTitle")
		local txtNum = UIControls.Label(self, path .. "/TextNum")

		table.insert(self.conditonUIs, {
			panel,
			txtTitle,
			txtNum
		})
	end

	self.attrCells = {}
	self.centerIndex = 2
end

function HandBookTeamUpgradeDlg:onOpen(...)
	HandBookTeamUpgradeDlg.super.onOpen(self)
end

function HandBookTeamUpgradeDlg:show(teamIndex, isURTeam)
	self.teamIndex = teamIndex
	self.isURTeam = isURTeam
	self.resData = self.isURTeam and ResURHeroProficientLevel or ResHeroProficientLevel
	self.isInit = true

	self:refreshData()
end

function HandBookTeamUpgradeDlg:initData(...)
	self.verCells = {}

	for i = 1, 4 do
		local cell = TeamVerCell(self, "BgPanel/VerList/Content", "System/HandBook/HandBookVerCell", 0, 0, true)

		table.insert(self.verCells, cell)

		cell.mEventCellClick = Slot(self.onCellClick, self)
	end
end

function HandBookTeamUpgradeDlg:refreshAttrUI(...)
	local attrs = self:getDiffInfo(self.centerLevel - 1, self.centerLevel)
	local count = math.max(#attrs, #self.attrCells)

	for i = 1, count do
		local cell = self.attrCells[i]

		if not cell then
			cell = TeamVerAttrCell(self, "BgPanel/AttrPanel", "System/HandBook/HandBookVerAttrCell", 0, 0, true)

			table.insert(self.attrCells, cell)
		end

		if attrs[i] and (attrs[i].type ~= "paint" or not self.mWindow.isURTeam) then
			cell:setData(attrs[i])
		else
			cell:setVisible(false)
		end
	end
end

function HandBookTeamUpgradeDlg:getUpgradeState(level)
	local info = CurAvatar:getProficientInfo(self.teamIndex, self.isURTeam)

	if info == nil then
		return STATE.CANT_UPGRADE
	end

	local gInfo = CurAvatar:getProficientGInfo(self.teamIndex, self.isURTeam)

	if gInfo == nil then
		return STATE.CANT_UPGRADE
	end

	if level <= gInfo.level then
		return STATE.UPGRADED
	elseif level > info.level then
		return STATE.CANT_UPGRADE
	else
		return STATE.CAN_UPGRADE
	end
end

function HandBookTeamUpgradeDlg:isAllUpgraded(...)
	local cell = self.verCells[2]
	local state = cell.state

	return cell.state == STATE.UPGRADED
end

function HandBookTeamUpgradeDlg:refreshConditonUI()
	local cell = self.verCells[2]
	local state = cell.state
	local showCon = false
	local score = 0

	if state == STATE.CAN_UPGRADE or state == STATE.CANT_UPGRADE or cell.level == 1 then
		showCon = true

		for i, ui in ipairs(self.conditonUIs) do
			ui[1]:setVisible(true)
		end

		local name = Lang.get(45936)

		if RegionUtils.isCN() or RegionUtils.isTW() and Const.HERO_TEAM_CONFIG[self.teamIndex] then
			name = Const.HERO_TEAM_CONFIG[self.teamIndex].name
		end

		self.conditonUIs[1][2]:setText(name)

		local nextInfo = self:getLimitLevelInfo(cell.level)
		local preInfo = self:getLimitLevelInfo(cell.level - 1)
		local curScore = self:getCurScore()
		local totalScore = CurAvatar:getTotalProficient()

		self.conditonUIs[1][3]:setText(curScore .. "/" .. nextInfo.group_score)

		if nextInfo.total_score == 0 or nextInfo.total_score == preInfo.total_score then
			self.conditonUIs[2][1]:setVisible(false)
		else
			self.conditonUIs[2][2]:setText(Lang.get(1076))
			self.conditonUIs[2][3]:setText(totalScore .. "/" .. nextInfo.total_score)
		end

		self.canUpgrade = curScore >= nextInfo.group_score and totalScore >= nextInfo.total_score

		if self.canUpgrade then
			self.btnUpgrade:setEnable(true)
			self.imgUpgradeRedHint:setVisible(true)
		else
			self.btnUpgrade:setEnable(false)
			self.imgUpgradeRedHint:setVisible(false)
		end
	else
		self.btnUpgrade:setEnable(false)
		self.imgUpgradeRedHint:setVisible(false)

		showCon = false

		for i, ui in ipairs(self.conditonUIs) do
			ui[1]:setVisible(false)
		end

		self.txtOther:setText(Lang.get(30319))
	end

	self.panelOther:setVisible(not showCon)
	self:showConditionInfo(true)
end

function HandBookTeamUpgradeDlg:refreshSelect(...)
	local cell = self.verCells[self.centerIndex]

	if self.curCell then
		self.curCell:setSelected(false)
	end

	self.curCell = cell

	if self.curCell then
		self.curCell:setSelected(true)
	end
end

function HandBookTeamUpgradeDlg:refreshUI(isOut)
	self.isInit = false

	local gInfo = CurAvatar:getProficientGInfo(self.teamIndex, self.isURTeam)

	if gInfo and gInfo.level == #self.resData then
		self:refreshData()
	else
		self:showConditionInfo(false)

		self.inEffectShow = true
		self.coEfxVer = coroutine.start(function(...)
			local cell = self.verCells[2]

			if cell then
				cell:playEffect()
			end

			for i, cell in ipairs(self.attrCells) do
				cell:playEffect()
			end

			coroutine.wait(0.8)
			self:setScrollEnable(true)
			self.scrollPage:scrollToCorrectPage(2)
		end)
	end
end

function HandBookTeamUpgradeDlg:refreshData(...)
	local gInfo = CurAvatar:getProficientGInfo(self.teamIndex, self.isURTeam)
	local centerLevel = 1

	if gInfo then
		centerLevel = gInfo.level + 1
	end

	centerLevel = math.max(1, math.min(#self.resData, centerLevel))
	self.centerLevel = centerLevel

	local data = {
		centerLevel - 1,
		centerLevel,
		centerLevel + 1,
		centerLevel + 2
	}

	for i, level in ipairs(data) do
		self.verCells[i]:setData(level)
		self.verCells[i]:showBarValue(level == centerLevel)
	end

	self:refreshAttrUI()
	self:refreshConditonUI()
	self:refreshSelect()
end

function HandBookTeamUpgradeDlg:getCurScore(...)
	local gInfo = CurAvatar:getProficientGInfo(self.teamIndex, self.isURTeam)

	if gInfo then
		return gInfo.score
	end

	return 0
end

function HandBookTeamUpgradeDlg:getLimitLevelInfo(level)
	level = math.max(1, math.min(#self.resData, level))

	return self.resData[level]
end

function HandBookTeamUpgradeDlg:getPaintLevelByPLevel(level)
	local info = self.resData[level]

	if info then
		for i = #ResHeroPaint[1], 1, -1 do
			local data = ResHeroPaint[1][i]

			if info.level >= data.proficient_level then
				return data
			end
		end
	end

	for i = #ResHeroPaint[1], 1, -1 do
		local data = ResHeroPaint[1][i]

		if data.proficient_level == 0 then
			return data
		end
	end

	return ResHeroPaint[1][1]
end

function HandBookTeamUpgradeDlg:getDiffInfo(preLevel, newLevel)
	local data = {}
	local prePaintInfo = self:getPaintLevelByPLevel(preLevel)
	local newPaintInfo = self:getPaintLevelByPLevel(newLevel)

	if newPaintInfo.proficient_level ~= 0 and (prePaintInfo.card_show_id ~= 0 or newPaintInfo.card_show_id ~= 0) then
		table.insert(data, {
			type = "paint",
			data = {
				prePaintInfo.name,
				newPaintInfo.name
			},
			index = newPaintInfo.proficient_level
		})
	end

	local preInfo = self.resData[preLevel]
	local newInfo = self.resData[newLevel]
	local isFind = false
	local order = 0

	for i, newAttr in ipairs(newInfo.attrs or {}) do
		isFind = false

		if preInfo then
			for j, preAttr in ipairs(preInfo.attrs or {}) do
				if preAttr == newAttr then
					isFind = true

					table.insert(data, {
						type = "attrs",
						data = {
							id = newAttr,
							pre = preInfo.value[j] or 0,
							new = newInfo.value[i] or 0
						},
						index = self:_getFirstShowBuffIndex(newAttr)
					})

					break
				end
			end
		end

		if not isFind then
			order = order + 1

			table.insert(data, {
				type = "attrs",
				data = {
					pre = 0,
					id = newAttr,
					new = newInfo.value[i] or 0
				},
				index = self:_getFirstShowBuffIndex(newAttr) + order
			})
		end
	end

	for i = 1, newLevel or 0 do
		local info = self.resData[i]

		if info and info.state_id then
			table.insert(data, {
				type = "state",
				data = {
					desc = info.state_desc or "",
					isNew = i == newLevel
				},
				index = i
			})
		end
	end

	table.sort(data, function(v1, v2)
		return v1.index < v2.index
	end)

	return data
end

function HandBookTeamUpgradeDlg:_getFirstShowBuffIndex(id)
	for i, info in ipairs(self.resData) do
		for j, bid in ipairs(info.attrs or {}) do
			if id == bid then
				return i
			end
		end
	end

	return 0
end

function HandBookTeamUpgradeDlg:setScrollEnable(v)
	local obj = self.scrollPage:getComObj()

	if obj then
		obj.horizontal = v
	end
end

function HandBookTeamUpgradeDlg:showConditionInfo(v)
	local name = "ShowVerInfo"

	if not v then
		name = "HideVerInfo"
	end

	self.aniVerInfo:startAni(name)
end

function HandBookTeamUpgradeDlg:destroy(...)
	HandBookTeamUpgradeDlg.super.destroy(self)

	if self.coScoll then
		coroutine.stop(self.coScoll)

		self.coScoll = nil
	end

	if self.coEfxVer then
		coroutine.stop(self.coEfxVer)

		self.coEfxVer = nil
	end

	local ui = UIManager.getUI("handBookTeamDetailDlg", nil, false)

	if ui then
		ui:checkLevelUpAni()
	end
end

function HandBookTeamUpgradeDlg:onCorrectEvent(sender, currentPageIndex)
	self:setScrollEnable(false)

	if currentPageIndex ~= 1 then
		self.coScoll = coroutine.start(function(...)
			coroutine.wait(0.25)

			self.inEffectShow = false

			self:refreshData()
			self.scrollPage:scrollToCorrectPage(1, true)
		end)
	end
end

function HandBookTeamUpgradeDlg:onCellClick(cell)
	if cell.level < self.centerLevel then
		MsgManager.notice(Lang.get(30320))
	else
		MsgManager.notice(Lang.get(30321))
	end
end

function HandBookTeamUpgradeDlg:onBtnUpgradeClick(...)
	if self.inEffectShow == true then
		return
	end

	if not self.canUpgrade then
		MsgManager.notice(Lang.get(30322))

		return
	end

	local cell = self.verCells[2]
	local is_ur = self.isURTeam and 1 or 0

	RPC.proficentLevelUp(self.teamIndex, cell.level, is_ur)
end

return HandBookTeamUpgradeDlg
