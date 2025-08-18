-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\PlayEntry\\Boss\\BossVictoryAwardBox.lua

local ResRandClient = require("ClientData/ResRandClient")
local ResBossTower = require("ClientData/ResBossTower")
local ResColor = require("ClientData/ResColor")
local BossVictoryAwardCell = Class("BossVictoryAwardCell", UIControls.Child)

function BossVictoryAwardCell:ctor(...)
	self.btnSensor = UIControls.Button(self, "AwardWaveCell")
	self.imgBg = UIControls.Image(self, "")
	self.imgGet = UIControls.Image(self, "ImgGet")
	self.textAwardLevel = UIControls.Label(self, "AwardWaveCell/TextLv")
	self.waveAwardGrids = {}
end

function BossVictoryAwardCell:setData(bossType, order, data, passOrder)
	ClientUtils.CreateBonusGrid(self, self.waveAwardGrids, "AwardPanel", data.once_award, true, 3, true)

	if order <= passOrder then
		self.imgBg:setImage("Atlas/OtherBattleAtlas/ChallengeBossAtlas", "BgArrowVic2")
		self.imgGet:setVisible(true)

		for index, grid in ipairs(self.waveAwardGrids) do
			grid:setGet(true)
		end
	elseif order == passOrder + 1 then
		self.imgBg:setImage("Atlas/OtherBattleAtlas/ChallengeBossAtlas", "BgArrowVic1")
	else
		self.imgBg:setImage("Atlas/OtherBattleAtlas/ChallengeBossAtlas", "BgArrowVic3")
	end

	self.btnSensor:setEnable(order ~= passOrder + 1)
	self.textAwardLevel:setText(order)
end

local strClassName = "BossVictoryAwardBox"
local BossVictoryAwardBox = Class(strClassName, UIControls.Window)

function BossVictoryAwardBox:ctor(...)
	self.cells = {}
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(Slot(self.onBtnClickClose, self))
end

function BossVictoryAwardBox:show(bossType, passOrder)
	local towerData = ResBossTower[bossType]
	local maxAward = math.min(#towerData, math.max(passOrder, 2) + 3)
	local startAward = maxAward - 5

	for i = 1, 5 do
		if not self.cells[i] then
			local cell = BossVictoryAwardCell(self, "BgPanel/AwardList/Content", "System/ChallengeBoss/AwardVicCell", 0, 0, true)

			self.cells[i] = cell
		end

		self.cells[i]:setData(bossType, startAward + i, towerData[startAward + i], passOrder)
	end
end

function BossVictoryAwardBox:onBtnClickClose()
	self:setVisible(false)
end

return BossVictoryAwardBox
