-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\PlayEntry\\Boss\\BossAwardInfoDlg.lua

local ResBossTowerExpandLevel = require("ClientData/ResBossTowerExpandLevel")
local ResBossTowerExpandMisc = require("ClientData/ResBossTowerExpandMisc")
local BossAwardCell = Class("BossAwardCell", UIControls.Child)

function BossAwardCell:ctor(...)
	self:initUI()
end

function BossAwardCell:initUI(...)
	self.imgDiff = UIControls.Image(self, "ContentPanel/IconDifficult")
	self.txtFirstAward = UIControls.Label(self, "ContentPanel/FirstAwardPanel/Text")
	self.txtDiffDes = UIControls.Label(self, "ContentPanel/IconDifficult/BgTxt/Text")
	self.panelAni = UIControls.Panel(self, "ContentPanel")
	self.firstAwards = {}
	self.cleanAwards = {}
end

function BossAwardCell:setData(info)
	ClientUtils.CreateBonusGrid(self, self.firstAwards, "ContentPanel/FirstAwardPanel/GridPanel", info.first_award, true, nil, true)
	ClientUtils.CreateBonusGrid(self, self.cleanAwards, "ContentPanel/CleanAwardPanel/GridPanel", info.clean_award, true, nil, true)

	if info.diff ~= 1 then
		local item = BaseObject.GetObject(ResBossTowerExpandMisc[1].show_id)
		local grid = UIControls.getGridAwardContainer(self, "ContentPanel/FirstAwardPanel/GridPanel")

		grid:setVisible(true)
		grid:setObj(item)
		table.insert(self.firstAwards, grid)
	end

	self.imgDiff:setImage("Atlas/OtherBattleAtlas/ChallengeBossAtlas4", "IconDifficulty0" .. info.diff)
	self.txtFirstAward:setText(utils.format(Lang.get(50542), UIConst.BOSS_EXPAND_DIFF_CONFIG[info.diff].des))
	self.txtDiffDes:setText(UIConst.BOSS_EXPAND_DIFF_CONFIG[info.diff].des)

	local isPassed, isFighting = self.mWindow:getPassInfo(info.diff)

	if isPassed then
		for _, item in ipairs(self.firstAwards) do
			item:setGet(true)
			item:setIconGray(true)
		end

		self.panelAni:playAnimator("NewChallengeBossAwardDis")
	elseif isFighting then
		self.panelAni:playAnimator("NewChallengeBossAwardSel")
	else
		self.panelAni:playAnimator("NewChallengeBossAwardNml")

		for _, item in ipairs(self.firstAwards) do
			item:setIconGray(true)
		end

		for _, item in ipairs(self.cleanAwards) do
			item:setIconGray(true)
		end

		self.imgDiff:setImageGray(true)
	end
end

local strClassName = "BossAwardInfoDlg"
local BossAwardInfoDlg = Class(strClassName, UIControls.Window)

function BossAwardInfoDlg:ctor(...)
	self:initUI()
end

function BossAwardInfoDlg:initUI()
	self.btnClose = UIControls.Button(self, "Bg/BtnClose")

	self.btnClose:addEventClick(self.onBtnCloseClick)

	self.cells = {}
end

function BossAwardInfoDlg:onOpen(...)
	BossAwardInfoDlg.super.onOpen(self)
end

function BossAwardInfoDlg:show(towerId, layer, towerData)
	self.towerData = towerData
	self.layer = layer

	local layerData = ResBossTowerExpandLevel[towerId][layer]

	for i, info in ipairs(layerData) do
		local cell = BossAwardCell(self, "Bg/AwardInfoList/Content", "System/ChallengeBoss/ChallengeBossAwardInfoCell", 0, 0, true)

		cell:setData(info)
		table.insert(self.cells, cell)
	end
end

function BossAwardInfoDlg:getPassInfo(level)
	local data = self.towerData.layer_data[self.layer]
	local isPreOpen = false

	if self.layer == 1 then
		isPreOpen = true
	elseif self.towerData.layer_data[self.layer - 1].pass_level > 0 then
		isPreOpen = true
	end

	if data then
		return level <= data.pass_level, isPreOpen and data.pass_level + 1 == level
	end
end

function BossAwardInfoDlg:onBtnCloseClick(...)
	self:setVisible(false)
end

return BossAwardInfoDlg
