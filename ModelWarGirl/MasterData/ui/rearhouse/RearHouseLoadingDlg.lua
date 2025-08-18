-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\RearHouse\\RearHouseLoadingDlg.lua

local strClassName = "RearHouseLoadingDlg"
local RearHouseLoadingDlg = Class(strClassName, UIControls.Window)

function RearHouseLoadingDlg:ctor(...)
	self.coTime = coroutine.start(function(...)
		coroutine.wait(1)
		self:setVisible(false)
	end)
end

function RearHouseLoadingDlg:onOpen(...)
	RearHouseLoadingDlg.super.onOpen(self)

	local ui = UIManager.getUI("rearHouseVisitChooseDlg", nil, false)

	if ui then
		ui:setVisible(false)
	end

	local ui = UIManager.getUI("rankMainDlg", nil, false)

	if ui and ui.typeRank == Const.RANK_TYPE_HOUSEFAVOR then
		ui:setVisible(false)
	end
end

function RearHouseLoadingDlg:destroy(...)
	RearHouseLoadingDlg.super.destroy(self)

	if self.coTime then
		coroutine.stop(self.coTime)
	end

	self.coTime = nil

	local ui = UIManager.getUI("rearHouseMainDlg", nil, false)

	if ui then
		ui:refreshUI()
	end
end

return RearHouseLoadingDlg
