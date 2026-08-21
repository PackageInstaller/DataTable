-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Logic\\Beginner\\RookieMainDlg.lua

local RectTransformType = typeof(UnityEngine.RectTransform)
local UserData = require("Helper/UserData")
local SDKConst = require("SDK/SDKConst")
local RookieMainDlg = Class("RookieMainDlg", UIControls.Window)

function RookieMainDlg:ctor()
	self:initUI()
end

local RookieUIHelperType = typeof(Framework.Tools.RookieUIHelper)
local RectTransformType = typeof(UnityEngine.RectTransform)

function RookieMainDlg:initUI()
	self.tipPanel = UIControls.Panel(self, "TipsPanel")
	self.panelTipsL = UIControls.Panel(self, "TipsPanel/TipsL")
	self.tipTextL = UIControls.Label(self, "TipsPanel/TipsL/BgTips/Text")
	self.imgNpcL = UIControls.Image(self, "TipsPanel/TipsL/BgNpc/IconNpc")
	self.panelTipsR = UIControls.Panel(self, "TipsPanel/TipsR")
	self.tipTextR = UIControls.Label(self, "TipsPanel/TipsR/BgTips/Text")
	self.imgNpcR = UIControls.Image(self, "TipsPanel/TipsR/BgNpc/IconNpc")
	self.bgMask = UIControls.Button(self, "OverLayClick")

	self.bgMask:addEventClick(self.onMaskClick)

	self.bgMask2 = UIControls.Button(self, "OverLayHigher")

	self.bgMask2:addEventClick(self.onMask2Click)

	self.panelFinger = UIControls.Panel(self, "HighLightPanel")
	self.fingerRect = self.panelFinger:getComObj():GetComponent(RectTransformType)
	self.imgFinger = UIControls.Panel(self, "HighLightPanel/IconFinger")
	self.btnSpecialClick = UIControls.Button(self, "HighLightPanel/Button")

	self.btnSpecialClick:addEventClick(self.onClickWidget)

	self.panelNoticeArrow = UIControls.Panel(self, "DragPanel")
	self.aniArrow = UIControls.UIAni(self, "DragPanel")
	self.effNoticeArrow = UIControls.Panel(self, "DragPanel/Efx")
	self.uiHelper = self:getController():GetComponent(RookieUIHelperType)

	self.uiHelper:BindLuaObj(self)
	self:cancelHooking()

	self.imgRaw = UIControls.RawImage(self, "RawImage")
	self.imgRawSmall = UIControls.RawImage(self, "RawImageS")
	self.panelQuickFunc = UIControls.Panel(self, "FuncPanel")
	self.skipQuickFunc = UIControls.Button(self, "FuncPanel/BtnSkip")

	self.skipQuickFunc:addEventClick(self.onMaskClick)
end

function RookieMainDlg:onOpen()
	RookieMainDlg.super.onOpen(self)
	self:hideRelatedDlg()
end

function RookieMainDlg:destroy()
	self:cancelHooking()
	UnityEngine.Object.Destroy(self.uiHelper)
	RookieMainDlg.super.destroy(self)
end

function RookieMainDlg:onMaskClick()
	if self.clickMaskCb ~= nil then
		self.clickMaskCb()

		if self.lockInfo then
			UserData.saveCommonData("BeginnerLock", "")

			self.lockInfo = nil
		end
	elseif self.errorClickITime == nil or Time.time - self.errorClickITime > 3 then
		self.errorClickITime = Time.time
		self.errorClickCount = 1
	else
		self.errorClickCount = self.errorClickCount + 1

		if self.errorClickCount >= 10 then
			self.gmJump = true

			self:onClickWidget()
		end
	end
end

function RookieMainDlg:onMask2Click()
	if self.clickMaskCb ~= nil then
		self.clickMaskCb()

		if self.lockInfo then
			UserData.saveCommonData("BeginnerLock", "")

			self.lockInfo = nil
		end
	elseif self.errorClickITime == nil or Time.time - self.errorClickITime > 3 then
		self.errorClickITime = Time.time
		self.errorClickCount = 1
	else
		self.errorClickCount = self.errorClickCount + 1

		if self.errorClickCount >= 10 then
			self.gmJump = true

			self:onClickWidget()
		end
	end
end

function RookieMainDlg:onClickWidget()
	if self.lockInfo then
		UserData.saveCommonData("BeginnerLock", "")

		self.lockInfo = nil
	end

	if self.clickCb ~= nil then
		self.clickCb(self.gmJump)
	end
end

function RookieMainDlg:_setNoticeInfo(widget, noticeInfo)
	local notice = noticeInfo[1]

	if notice and notice ~= "" then
		self.tipPanel:setVisible(true)

		if widget then
			local pos = widget.position

			self.uiHelper:AddFollowTransform(self.tipPanel:getComObj().transform)
		else
			self.tipPanel:setPosition(0, 0)
		end

		local coord = noticeInfo[2] or {}

		if noticeInfo[3] == 1 then
			self.tipTextR:setText(notice)
			self.panelTipsR:setPosition(coord[1] or 0, coord[2] or 0)
			self.panelTipsR:setVisible(true)
			self.panelTipsL:setVisible(false)
		else
			self.tipTextL:setText(notice)
			self.panelTipsL:setPosition(coord[1] or 0, coord[2] or 0)
			self.panelTipsR:setVisible(false)
			self.panelTipsL:setVisible(true)
		end

		if noticeInfo[4] then
			self.imgNpcL:setImage("Atlas/PlayerGuideAtlas/PlayerGuideAtlas", noticeInfo[4])
			self.imgNpcR:setImage("Atlas/PlayerGuideAtlas/PlayerGuideAtlas", noticeInfo[4])
		else
			self.imgNpcL:setImage("Atlas/PlayerGuideAtlas/PlayerGuideAtlas", "Face001")
			self.imgNpcR:setImage("Atlas/PlayerGuideAtlas/PlayerGuideAtlas", "Face001")
		end
	else
		self.tipPanel:setVisible(false)
	end
end

function RookieMainDlg:startClickOpera(widget, noticeInfo, clickCb, beginnerId, step)
	if beginnerId and step then
		self.lockInfo = "beginnerId:" .. beginnerId .. " step:" .. step

		UserData.saveCommonData("BeginnerLock", self.lockInfo)
	end

	self:clear()
	self.uiHelper:HookWidget(widget, true)

	local pos = widget.position

	self:_setNoticeInfo(widget, noticeInfo)
	self.panelFinger:setVisible(true)
	self.imgFinger:setVisible(true)

	self.fingerRect.anchorMin = widget.anchorMin
	self.fingerRect.anchorMax = widget.anchorMax
	self.fingerRect.anchoredPosition = widget.anchoredPosition
	self.fingerRect.sizeDelta = widget.sizeDelta
	self.fingerRect.pivot = widget.pivot

	self.uiHelper:AddFollowTransform(self.panelFinger:getComObj().transform)

	self.clickCb = clickCb

	self.bgMask:setVisible(true)
	self:reportBuriedPoint(beginnerId, step)
	self:hideRelatedDlg(true)
end

local COMMON_SIZE = 900

function RookieMainDlg:startArrowNotice(startPos, startWorldPos, endPos, endWorldPos)
	local rect = self.panelNoticeArrow:getComObj():GetComponent(RectTransformType)

	self.uiHelper:NoticeWidgtCenter(endPos, endWorldPos, startPos, startWorldPos, rect)
	self.aniArrow:setAniSpeed(math.min(1.5, COMMON_SIZE / rect.sizeDelta.x))
	self.panelNoticeArrow:setVisible(true)
	self.effNoticeArrow:setVisible(true)
end

function RookieMainDlg:startNoticeOpera(widget, noticeInfo)
	self:clear()
	self:_setNoticeInfo(widget, noticeInfo)
end

function RookieMainDlg:startMazeDragOpera(widget, noticeInfo, clickCb)
	self:clear()
	self.uiHelper:HookWidget(widget, false)
	self:_setNoticeInfo(widget, noticeInfo)

	self.clickCb = clickCb

	self.panelNoticeArrow:setVisible(true)
	self.effNoticeArrow:setVisible(false)

	self.dragDist = 0

	local mazeMainDlg = UIManager.tryGetUI("mazeMainDlg")

	if mazeMainDlg then
		mazeMainDlg.dragExtraFunc = Slot(self.onMazeDrag, self)
	end
end

function RookieMainDlg:onMazeDrag(deltaX)
	if deltaX < 0 then
		self.dragDist = self.dragDist - deltaX

		if self.dragDist > 0.25 then
			if self.clickCb then
				self.clickCb()
			end

			local mazeMainDlg = UIManager.tryGetUI("mazeMainDlg")

			if mazeMainDlg then
				mazeMainDlg.dragExtraFunc = nil
			end
		end
	end
end

function RookieMainDlg:startForceNoticeOpera(widget, noticeInfo, clickCb, beginnerId, step, closeBlack, extraChild, extraCoord)
	if beginnerId and step then
		self.lockInfo = "beginnerId:" .. beginnerId .. " step:" .. step

		UserData.saveCommonData("BeginnerLock", self.lockInfo)
	end

	self:clear()

	if widget then
		self.uiHelper:HookWidget(widget, false)
		self.panelFinger:setVisible(true)
		self.imgFinger:setVisible(false)

		self.fingerRect.anchorMin = widget.anchorMin
		self.fingerRect.anchorMax = widget.anchorMax
		self.fingerRect.anchoredPosition = widget.anchoredPosition
		self.fingerRect.sizeDelta = widget.sizeDelta
		self.fingerRect.pivot = widget.pivot

		self.btnSpecialClick:setVisible(true)
	end

	self:_setNoticeInfo(widget, noticeInfo)

	self.clickCb = clickCb

	if closeBlack then
		self.bgMask:setVisible(false)
	else
		self.bgMask:setVisible(true)
	end

	self.bgMask2:setVisible(true)

	self.clickMaskCb = clickCb

	if extraChild and extraChild ~= "" then
		self.extraChildPath = extraChild
		self.extraChild = UIControls.Child(self, "", "System/PlayerGuide/" .. extraChild)

		self.extraChild:setVisible(true)

		if extraCoord and extraCoord[1] and extraCoord[2] then
			self.extraChild:setPosition(extraCoord[1], extraCoord[2])
		end

		self.panelFinger:setVisible(false)
		self.bgMask2:setVisible(false)
		self.bgMask:setVisible(false)
		self.panelQuickFunc:setVisible(true)
		self.skipQuickFunc:setVisible(true)
	end

	self:hideRelatedDlg(true)
end

function RookieMainDlg:showRawImage(imagePath, isSmall, clickCb)
	self:clear()

	if isSmall then
		self.imgRawSmall:setVisible(true)
		self.imgRawSmall:setImage("NoAlpha/" .. imagePath)
	else
		self.imgRaw:setVisible(true)
		self.imgRaw:setImage("NoAlpha/" .. imagePath)
	end

	self.bgMask:setVisible(true)

	self.clickMaskCb = clickCb
end

function RookieMainDlg:clear()
	self.imgRaw:setVisible(false)
	self.imgRawSmall:setVisible(false)
	self:cancelHooking()
	self.panelFinger:setVisible(false)
	self.tipPanel:setVisible(false)

	self.clickCb = nil
	self.clickMaskCb = nil

	self.bgMask:setVisible(false)
	self.bgMask2:setVisible(false)

	if self.extraChild then
		self.extraChild:destroy()

		self.extraChild = nil
	end

	self.extraChildPath = nil

	self.panelQuickFunc:setVisible(false)
end

function RookieMainDlg:cancelHooking()
	self.uiHelper:CancelHooking()
	self.panelNoticeArrow:setVisible(false)
end

function RookieMainDlg:setVisible(v, hideAndDestroy)
	if self.lockInfo then
		UserData.saveCommonData("BeginnerLock", "")

		self.lockInfo = nil
	end

	self:cancelHooking()
	RookieMainDlg.super.setVisible(self, v, hideAndDestroy)
end

function RookieMainDlg:reportBuriedPoint(beginnerId, step)
	if beginnerId == 102 and step == 1 then
		SDKAgent.sendRoleInfo(SDKConst.RoleInfoType.GUIDE_1_1)
	elseif beginnerId == 121 and step == 5 then
		SDKAgent.sendRoleInfo(SDKConst.RoleInfoType.GUIDE_1_12)
	end
end

local BEGINNER_HIDE_UIS = {
	rebackBonusDlg = 0,
	activityMainDlg = 0
}

function RookieMainDlg:hideRelatedDlg(forceMode)
	for uiName, flag in pairs(BEGINNER_HIDE_UIS) do
		if flag == 1 then
			if forceMode then
				UIManager.tryHideUI(uiName)
			end
		else
			UIManager.tryHideUI(uiName)
		end
	end
end

return RookieMainDlg
