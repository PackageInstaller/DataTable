-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\PlayEntry\\Boss\\BossWaveAwardBox.lua

local ResRandClient = require("ClientData/ResRandClient")
local ResColor = require("ClientData/ResColor")
local WaveAwardCell = Class("WaveAwardCell", UIControls.Child)

function WaveAwardCell:ctor(...)
	self.imgBg = UIControls.Image(self, "")
	self.imgGet = UIControls.Image(self, "ImgGet")
	self.textTitle = UIControls.Label(self, "TextTitle")
	self.textProgress = UIControls.Label(self, "TextPro")
	self.waveAwardGrids = {}
end

function WaveAwardCell:setData(bossType, order, data, passOrder, maxOrder, gridConfig)
	ClientUtils.CreateBonusGrid(self, self.waveAwardGrids, "AwardPanel", data.award, true, 3, true, nil, nil, gridConfig)

	if order <= passOrder then
		self.imgBg:setImage("Atlas/OtherBattleAtlas/ChallengeBossAtlas", "BgArrow2")
		self.imgGet:setVisible(true)
		self.textTitle:setFontColor(ResColor.GREYDIS)
		self.textProgress:setFontColor(ResColor.GREYLIGHT)

		for index, grid in ipairs(self.waveAwardGrids) do
			grid:setGet(true)
		end
	elseif order == passOrder + 1 then
		self.imgBg:setImage("Atlas/OtherBattleAtlas/ChallengeBossAtlas", "BgArrow1")
		self.textTitle:setFontColor(ResColor.BLACK)
		self.textProgress:setFontColor(ResColor.ORANGEBTN)
	else
		self.imgBg:setImage("Atlas/OtherBattleAtlas/ChallengeBossAtlas", "BgArrow3")
		self.textTitle:setFontColor(ResColor.GREYDIS)
		self.textProgress:setFontColor(ResColor.GREYDIS)
	end

	if bossType == Const.BOSS_TOWER_TYPE_ZOMBIE then
		self.textTitle:setText(Lang.get(30516))
		self.textProgress:setText(order)
	else
		self.textTitle:setText(Lang.get(708))

		local onePro = 1 / maxOrder
		local nowPro = math.floor(onePro * order * 100)

		self.textProgress:setText(nowPro .. "%")
	end
end

local strClassName = "BossWaveAwardBox"
local BossWaveAwardBox = Class(strClassName, UIControls.Window)

function BossWaveAwardBox:ctor(...)
	self.slider = UIControls.Slider(self, "Slider")
	self.cells = {}
	self.btnClose = UIControls.Button(self, "BgPanel/BtnClose")

	self.btnClose:addEventClick(Slot(self.onBtnClickClose, self))

	self.panelRebackBonus = UIControls.Panel(self, "BgPanel/TextTitle/ReturnUpPanel")
end

function BossWaveAwardBox:show(bossType, layerData, passOrder)
	local gridConfig = {}

	if CurAvatar:hasPrivilegeType(Const.PRIVITY_KEY_EBONUS_WORLD_BOSS) then
		self.panelRebackBonus:setVisible(true)

		gridConfig.PrivilegeId = Const.PRIVITY_KEY_EBONUS_WORLD_BOSS
	else
		self.panelRebackBonus:setVisible(false)
	end

	local maxAward = #layerData.wave_award

	for i = 1, maxAward do
		if not self.cells[i] then
			local cell = WaveAwardCell(self, "BgPanel/AwardList/Content", "System/ChallengeBoss/AwardNmlCell", 0, 0, true)

			self.cells[i] = cell
		end

		self.cells[i]:setData(bossType, i, layerData.wave_award[i], passOrder, maxAward, gridConfig)
	end

	self.slider:setValue(passOrder / maxAward)
end

function BossWaveAwardBox:onBtnClickClose()
	self:setVisible(false)
end

return BossWaveAwardBox
