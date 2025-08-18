-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityChooseDiceDlg.lua

local MAX_ROLL_NUM = 6
local strClassName = "ActivityChooseDiceDlg"
local ActivityChooseDiceDlg = Class(strClassName, UIControls.Window)

function ActivityChooseDiceDlg:ctor()
	self.rollBtns = {}

	for index = 1, MAX_ROLL_NUM do
		local newBtn = UIControls.Button(self, "Bg/ChoicePanel/Btn" .. index)

		newBtn.diceNum = index

		newBtn:addEventClick(self.onBtnChoose)
		table.insert(self.rollBtns, newBtn)
	end

	self.btnClose = UIControls.Button(self, "Bg/BtnClose")

	self.btnClose:addEventClick(self.onBtnClose)

	self.btnConfirm = UIControls.Button(self, "Bg/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirm)

	self.iconEvent = UIControls.Image(self, "Bg/BtnConfirm/SpPanel")
	self.imgCost = UIControls.Image(self, "Bg/BtnConfirm/CostPanel/Icon")
	self.textCost = UIControls.Label(self, "Bg/BtnConfirm/CostPanel/TextNum")
end

function ActivityChooseDiceDlg:onShow(speEvent, chooseCb, monoMainDlg)
	local AtlasPath = "Atlas/ActivityAtlas/ActivityMonopolyAtlas"

	if monoMainDlg.replaceableCellPath and monoMainDlg.replaceableCellPath[2] then
		AtlasPath = "Atlas/ActivityAtlas/" .. monoMainDlg.replaceableCellPath[2]
	elseif monoMainDlg.replaceableCellPath and monoMainDlg.replaceableCellPath[3] then
		AtlasPath = "Atlas/ActivityAtlas/" .. monoMainDlg.replaceableCellPath[3] .. "ActivityMonopolyAtlas"
	end

	if speEvent == 1 then
		self.iconEvent:setVisible(true)
		self.iconEvent:setImage(AtlasPath, "IconLucky")
	elseif speEvent == 2 then
		self.iconEvent:setVisible(true)
		self.iconEvent:setImage(AtlasPath, "IconUnlucky")
	elseif speEvent == 3 then
		for index = 1, MAX_ROLL_NUM do
			local newIcon = UIControls.Image(self, "Bg/ChoicePanel/Btn" .. index .. "/Icon")

			newIcon:setImage(AtlasPath, "BgDice01")
		end

		self.iconEvent:setVisible(false)
	else
		self.iconEvent:setVisible(false)
	end

	self.chooseNum = nil
	self.chooseCb = chooseCb
end

function ActivityChooseDiceDlg:onBtnConfirm()
	if self.chooseNum and self.chooseCb then
		self.chooseCb(self.chooseNum)
		self:setVisible(false)
	else
		MsgManager.notice(Lang.get(30613))
	end
end

function ActivityChooseDiceDlg:onBtnClose()
	self:setVisible(false)
end

function ActivityChooseDiceDlg:onBtnChoose(sender)
	self.chooseNum = sender.diceNum

	for index, btn in ipairs(self.rollBtns) do
		btn:setEnable(sender ~= btn)
	end
end

return ActivityChooseDiceDlg
