-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\PVPMode\\TopPVP\\TopPvpEnterTipsPanel.lua

local strClassName = "TopPvpEnterTipsPanel"
local TopPvpEnterTipsPanel = Class(strClassName, UIControls.Panel)

function TopPvpEnterTipsPanel:ctor(...)
	self:initUI()
end

function TopPvpEnterTipsPanel:initUI()
	self.enterBtn = UIControls.Button(self, self.mPath)

	self.enterBtn:addEventClick(self.onenterBtnClick)
	self:refreshUI()
end

function TopPvpEnterTipsPanel:show(isshow)
	self.enterBtn:setVisible(isshow)
end

function TopPvpEnterTipsPanel:onenterBtnClick()
	local actObj = CurAvatar:getTopPVPActivity()

	if actObj then
		local actData = actObj.actData
		local ui = UIManager.getUI("topPvpMainDlg", true, true)

		if ui then
			ui:onShowActivity({
				actObj.clientTemplateData,
				actObj
			})
		end

		if actData:checkKnockoutNowRoundQualification() and ui then
			ui.panelKnockoutPanel:refreshUI(3)
		end
	else
		return
	end
end

function TopPvpEnterTipsPanel:refreshUI()
	local actData = CurAvatar:getTopPVPActivityData()

	if actData and actData:checkTopPvpCrossdata() then
		local nowState = actData:getTopPvpStage()

		if nowState then
			if actData.stateMap[nowState] == "KnockoutRoomFight" then
				self:show(true)
			else
				self:show(false)
			end
		end
	else
		self:show(false)
	end
end

return TopPvpEnterTipsPanel
