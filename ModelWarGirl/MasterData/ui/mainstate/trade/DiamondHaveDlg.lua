-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\MainState\\Trade\\DiamondHaveDlg.lua

local strClassName = "DiamondHaveDlg"
local DiamondHaveDlg = Class(strClassName, UIControls.Window)

function DiamondHaveDlg:ctor(...)
	self:initUI()
end

function DiamondHaveDlg:initUI(...)
	self.txtTitle = UIControls.Label(self, "Bg/TextTitle")
	self.txtTips = UIControls.Label(self, "Bg/TextTips")

	for i = 1, 3 do
		local path = "Bg/DiamondPanel/Diamond" .. i

		self["txtName" .. i] = UIControls.Label(self, path .. "/TextTitle")
		self["txtValue" .. i] = UIControls.Label(self, path .. "/TextNum")
	end

	self.btnConfirm = UIControls.Button(self, "Bg/BtnConfirm")

	self.btnConfirm:addEventClick(self.onBtnConfirmClick)
end

function DiamondHaveDlg:onOpen(...)
	DiamondHaveDlg.super.onOpen(self)
	self:show()
end

function DiamondHaveDlg:show(...)
	self.txtTitle:setText("다이아 정보")
	self.txtName1:setText("유료 획득")
	self.txtName2:setText("무료 획득")
	self.txtName3:setText("전체 획득")
	self.txtTips:setVisible(true)

	local diamondBuy = CurAvatar:getMoneyByType(Const.MONEY_TYPE_DIAMOND_BUY)
	local diamondFree = CurAvatar:getMoneyByType(Const.MONEY_TYPE_DIAMOND)

	self.txtValue1:setText(diamondBuy)
	self.txtValue2:setText(diamondFree)

	if diamondBuy >= 0 then
		self.txtValue3:setText(diamondBuy + diamondFree)
		self.txtTips:setText("무료로 획득한 다이아가 먼저 소모됩니다. ")
	else
		self.txtValue3:setText("동결 중")
		self.txtTips:setText("무료로 획득한 다이아가 먼저 소모됩니다. \n유료로 획득한 다이아의 수가 마이너스로 변경되어 계정이 동결된 상태입니다. ")
	end
end

function DiamondHaveDlg:onBtnConfirmClick(...)
	self:setVisible(false)
end

return DiamondHaveDlg
