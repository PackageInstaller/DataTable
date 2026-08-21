-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\OpActivity\\ActivityCollectWordsComposeDlg.lua

local strClassName = "ActivityCollectWordsComposeDlg"
local ActivityCollectWordsComposeDlg = Class(strClassName, UIControls.Window)

function ActivityCollectWordsComposeDlg:ctor()
	self:initUI()
end

function ActivityCollectWordsComposeDlg:initUI()
	self.textTime = UIControls.Label(self, "NumPanel/TextNum")
	self.uiAni = UIControls.UIAni(self, "")

	self.uiAni:addEventFinish(self.showBonus)
end

function ActivityCollectWordsComposeDlg:setData(composeTimes)
	self.textTime:setText("x" .. composeTimes)
end

function ActivityCollectWordsComposeDlg:showBonus()
	local bonus = CurAvatar.collectWordsComposeBonus

	if bonus then
		local function onClose()
			self:setVisible(false)
		end

		CurAvatar:onGetBonusNotice("commonBonusCollectWordsDlg", "onShow", {
			bonus[1],
			bonus[2],
			bonus[3],
			bonus[4],
			bonus[5],
			bonus[6],
			bonus[7],
			Lang.get(338),
			onClose
		})
	end
end

function ActivityCollectWordsComposeDlg:onClose()
	local mainDlg = UIManager.tryGetUI("activityCollectWordsDlg")

	if mainDlg then
		mainDlg:checkPlayAVG()
	end

	ActivityCollectWordsComposeDlg.super.onClose(self)
end

return ActivityCollectWordsComposeDlg
