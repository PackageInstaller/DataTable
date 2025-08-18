-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\PlayEntry\\Boss\\BossAwardBox.lua

local ResBossTowerAward = require("ClientData/ResBossTowerAward")
local ResRandClient = require("ClientData/ResRandClient")
local BossAwardCell = Class("BossAwardCell", UIControls.ScrollViewLoopCell)

function BossAwardCell:ctor()
	self.imgBg = UIControls.Image(self, "")
	self.txtTitle = UIControls.Label(self, "TextTitle")
	self.btnGet = UIControls.Button(self, "BtnConfirm")

	self.btnGet:addEventClick(self.onAwardGetClick)

	self.txtState = UIControls.Label(self, "ImgState")
	self.gridsAward = {}
end

function BossAwardCell:setInfo(info)
	self.info = info

	self.txtTitle:setText(string.format(Lang.get(30507), info.dmg))

	local bonus = ResRandClient[info.award]
	local showIds = bonus.show_ids or {}
	local showNums = bonus.show_nums or {}

	for index = #self.gridsAward, #showIds - 1 do
		local newGrid = UIControls.getGridContainer(self, "AwardPanel")

		table.insert(self.gridsAward, newGrid)
	end

	for index, grid in ipairs(self.gridsAward) do
		if showIds[index] then
			local clientItem = BaseObject.GetObject(showIds[index], showNums[index] or 1)

			grid:setObj(clientItem)
			grid:setVisible(true)
		else
			grid:setVisible(false)
		end
	end

	local showBtn = not info.get and info.can

	self.btnGet:setVisible(showBtn)
	self.txtState:setVisible(not showBtn)

	local bgPathName = "BgLineSel"

	if not showBtn then
		if info.get then
			self.txtState:setText(Lang.get(150))

			bgPathName = "BgLineGray"
		else
			self.txtState:setText(Lang.get(99))

			bgPathName = "BgLineBlack"
		end
	end

	self.imgBg:setImage("Atlas/OtherBattleAtlas/ChallengeBossAtlas", bgPathName)
end

function BossAwardCell:onAwardGetClick(sender)
	RPC.bossTowerAwardGet({
		self.info.id
	}, self.info.bType)
end

local strClassName = "BossAwardBox"
local BossAwardBox = Class(strClassName, UIControls.Window)

function BossAwardBox:ctor()
	self:initUI()

	self._timerUpdate = Timer.New(Slot(self.onTimeUpdate, self), 0.5, -1)
	self.timeUpdate = ClientUtils.getServerTimeNextDay()
end

function BossAwardBox:initUI()
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.btnGetAll = UIControls.Button(self, "BgPanel/BtnAllConfirm")

	self.btnGetAll:addEventClick(self.onBtnGetAllClick)

	self.txtDmg = UIControls.Label(self, "BgPanel/TextAllHurtNum")
	self.txtTimeUpdate = UIControls.Label(self, "BgPanel/TextAwardBreak")
	self.cells = {}
	self.view = UIControls.ScrollViewLoopV(self, "BgPanel/ChallengeBossAwardList", 0, self.onCellChanged)
end

function BossAwardBox:destroy()
	self._timerUpdate:Stop()
	BossAwardBox.super.destroy(self)
end

function BossAwardBox:onOpen()
	BossAwardBox.super.onOpen(self)
	self._timerUpdate:Start()
end

function BossAwardBox:show(bossType)
	if bossType ~= nil then
		self.bType = bossType
	end

	local totalDmg = 0
	local awardGetMap = {}

	if CurAvatar then
		local bossInfo = CurAvatar.mBossTowerInfos[self.bType]

		if bossInfo then
			totalDmg = bossInfo.max_damage
			awardGetMap = ClientUtils.getBitsDictFromByteString(bossInfo.award_bit)
		end
	end

	self.txtDmg:setText(string.format(Lang.get(30508), ClientUtils.getNumShortStr(totalDmg)))

	local datas = ResBossTowerAward[self.bType]

	self.awardInfos = {}

	local hasAward = false

	for id, data in pairs(datas) do
		local info = {
			dmg = data.damage,
			award = data.award,
			id = id,
			bType = self.bType
		}

		info.get = awardGetMap[id] or false
		info.can = totalDmg >= info.dmg

		table.insert(self.awardInfos, info)

		if not hasAward and not info.get and info.can then
			hasAward = true
		end
	end

	local function sortInfo(a, b)
		if a.get ~= b.get then
			return a.get == false
		elseif a.can ~= b.can then
			return a.can == true
		end

		return a.dmg < b.dmg
	end

	table.sort(self.awardInfos, sortInfo)
	self.btnGetAll:setVisible(hasAward)
	self.view:setTotalCount(#self.awardInfos)
	self:onTimeUpdate()
end

function BossAwardBox:onTimeUpdate()
	if self.timeUpdate == nil then
		return
	end

	local timeLeft = self.timeUpdate - ClientUtils.getServerTime()
	local txtTime = utils.calcTimeTxt(timeLeft)

	self.txtTimeUpdate:setText(string.format(Lang.get(30509), txtTime))
end

function BossAwardBox:onCellChanged(sender, targetCell, newIdx)
	if targetCell == nil then
		targetCell = BossAwardCell(sender, "System/ChallengeBoss/ChallengeBossAwardCell", 0, 0, newIdx)
	else
		self.cells[targetCell.mIndex] = nil
		targetCell.mIndex = newIdx
	end

	self.cells[newIdx] = targetCell

	local info = self.awardInfos[newIdx]

	targetCell:setInfo(info)
end

function BossAwardBox:onBtnCloseClick(sender)
	self:setVisible(false)
end

function BossAwardBox:onBtnGetAllClick(sender)
	local ids = {}

	for i, info in ipairs(self.awardInfos) do
		if not info.get and info.can then
			table.insert(ids, info.id)
		end
	end

	if next(ids) then
		RPC.bossTowerAwardGet(ids, self.bType)
	end
end

return BossAwardBox
