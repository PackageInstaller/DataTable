-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Battle\\BattleRecordDlg.lua

local BattleConst = require("Common/FrameBattle/BattleConst")
local ResStarUpCondition = require("ClientData/ResStarUpCondition")
local RECORD_CONFIG = {
	{
		"totalDamage"
	},
	{
		"receiveDamage"
	},
	{
		"totalHeal"
	},
	{
		"receiveHeal"
	}
}
local BattleRecordCell = Class("BattleRecordCell", UIControls.Child)

function BattleRecordCell:ctor()
	self.bgFill = UIControls.Image(self, "Slider/FillArea/Fill")
	self.imgMvp = UIControls.Image(self, "ImgMvp")
	self.textNum = UIControls.Label(self, "TextNum")
	self.sliderRate = UIControls.Slider(self, "Slider")
	self.imgHero = UIControls.Image(self, "HeadPanel/ImgIcon")
	self.txtTitle = UIControls.Label(self, "TextTitle")
	self.imgFriend = UIControls.Image(self, "ImgHelp")

	self.imgMvp:setVisible(false)
end

function BattleRecordCell:setInfo(obj, num, totalNum, isMax)
	if obj.hero then
		local icon = obj.hero:getIconPath(true)

		if icon then
			self.imgHero:setImage(icon[1], icon[2])
		end

		self.imgFriend:setVisible(false)
	elseif obj.monsterID then
		local mIcon = UIConst.getMonsterHeadIconPath(obj.monsterID)

		if mIcon then
			self.imgHero:setImage(mIcon[1], mIcon[2])
		end

		if obj.camp == BattleConst.CAMP_PLAYER then
			self.imgFriend:setVisible(true)
		else
			self.imgFriend:setVisible(false)
		end
	end

	self.textNum:setText(num)

	if totalNum > 0 then
		self.sliderRate:setValue(0)
		self.sliderRate:setValue(num / totalNum, 0.5)
	else
		self.sliderRate:setValue(0)
	end

	self.txtTitle:setText(self.mWindow.curTab:getText())
end

local strClassName = "BattleRecordDlg"
local BattleRecordDlg = Class(strClassName, UIControls.Window)

function BattleRecordDlg:ctor()
	self:initUI()
end

function BattleRecordDlg:initUI()
	self.monsterPanel = UIControls.Panel(self, "BgPanel/BattleDataCellPanel2")
	self.linePanel = UIControls.Panel(self, "BgPanel/LinePanel")
	self.tabBtns = {}

	for index, btnConfig in ipairs(RECORD_CONFIG) do
		local newBtn = UIControls.Button(self, "BgPanel/TabPanel/Btn" .. index, "Text")

		newBtn.index = index
		newBtn.config = btnConfig

		newBtn:addEventClick(self.onClickTab)
		table.insert(self.tabBtns, newBtn)
	end

	self.friendCells = {}
	self.enemyCells = {}
end

function BattleRecordDlg:onShow(hideMonster, objMgr)
	local hide = hideMonster or false
	local battleState = GameFsm.getCurState()

	if battleState.isZombieBattle and battleState:isZombieBattle() then
		hide = true
	end

	self.monsterPanel:setVisible(not hide)
	self.linePanel:setVisible(not hide)

	local _objMgr = objMgr

	if _objMgr == nil then
		_objMgr = battleState:getBattleObjMgr()
	end

	local recorder = _objMgr and _objMgr.resultRecord or {}

	self.recordFriend = {}
	self.recordEnemy = {}

	for objId, info in pairs(recorder or {}) do
		local obj = _objMgr:getObjectByKey(objId)

		if obj then
			info.obj = obj
			info.level = obj.showLevel or 0

			if obj and (obj.heroID or obj.monsterID) and not obj.master then
				if obj.camp == BattleConst.CAMP_PLAYER then
					table.insert(self.recordFriend, info)
				elseif obj.camp == BattleConst.CAMP_MONSTER then
					table.insert(self.recordEnemy, info)
				end
			end
		end
	end

	for index = #self.friendCells, #self.recordFriend - 1 do
		local newCell = BattleRecordCell(self, "BgPanel/BattleDataCellPanel1", "System/Battle/Result/BattleDataCell")

		newCell.bgFill:setImage("Atlas/BattleAtlas/BattleResultAtlas/BattleResultAtlasNew", "BarWe")
		table.insert(self.friendCells, newCell)
	end

	if not hide then
		for index = #self.enemyCells, #self.recordEnemy - 1 do
			local newCell = BattleRecordCell(self, "BgPanel/BattleDataCellPanel2", "System/Battle/Result/BattleDataCell")

			newCell.bgFill:setImage("Atlas/BattleAtlas/BattleResultAtlas/BattleResultAtlasNew", "BarEnemy")
			table.insert(self.enemyCells, newCell)
		end
	end

	self:onClickTab(self.tabBtns[1])
end

function BattleRecordDlg:onShowByType(type, hideMonster, objMgrs)
	local hide = hideMonster or false
	local battleState = GameFsm.getCurState()

	if battleState.isZombieBattle and battleState:isZombieBattle() then
		hide = true
	end

	local _objMgrs = objMgrs

	if _objMgrs == nil then
		_objMgrs = battleState:getBattleObjMgrs()
	end

	self.tabLeftBtns = {}

	local paneName, btnName

	if type == BattleConst.BATTLE_TYPE_WORLD_BOSS then
		paneName = "BgPanel/EliteTabPanel"
		btnName = "BgPanel/EliteTabPanel/Btn"
	end

	self.panelLeftBtn = UIControls.Panel(self, paneName)

	self.panelLeftBtn:setVisible(true)

	for i = 1, #_objMgrs do
		if UIControls.checkControlFunc(self, btnName .. i) then
			local btn = UIControls.Button(self, btnName .. i, "Text")

			btn.index = i
			btn.hideMonster = hide
			btn.objMgr = _objMgrs[i] or {}

			btn:addEventClick(self.onClickLeftTab)
			table.insert(self.tabLeftBtns, btn)
		end
	end

	self:onClickLeftTab(self.tabLeftBtns[1])
end

function BattleRecordDlg:onClickLeftTab(sender)
	for _, btn in ipairs(self.tabLeftBtns) do
		btn:setEnable(sender ~= btn)
	end

	if sender.objMgr then
		self:onShow(sender.hideMonster, sender.objMgr)
	end
end

function BattleRecordDlg:onClickTab(sender)
	for _, btn in ipairs(self.tabBtns) do
		btn:setEnable(sender ~= btn)
	end

	local attrName = sender.config[1]

	self.curTab = sender

	local maxValue = 0
	local myData = {}

	for _, info in ipairs(self.recordFriend) do
		if info[attrName] and maxValue < info[attrName] then
			maxValue = info[attrName]
		end

		table.insert(myData, info)
	end

	local enemyData = {}

	for _, info in ipairs(self.recordEnemy) do
		if info[attrName] and maxValue < info[attrName] then
			maxValue = info[attrName]
		end

		table.insert(enemyData, info)
	end

	table.sort(myData, function(a, b)
		if a[attrName] ~= b[attrName] then
			return a[attrName] > b[attrName]
		else
			return a.level > b.level
		end
	end)

	for index, cell in ipairs(self.friendCells) do
		if myData[index] then
			cell:setVisible(true)
			cell:setInfo(myData[index].obj, myData[index][attrName] or 0, maxValue, index == 1 and attrName == "totalDamage")
		else
			cell:setVisible(false)
		end
	end

	table.sort(enemyData, function(a, b)
		return (a[attrName] or 0) > (b[attrName] or 0)
	end)

	for index, cell in ipairs(self.enemyCells) do
		if enemyData[index] then
			cell:setVisible(true)
			cell:setInfo(enemyData[index].obj, enemyData[index][attrName] or 0, maxValue)
		else
			cell:setVisible(false)
		end
	end
end

return BattleRecordDlg
