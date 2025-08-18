-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/Logic\\Beginner\\RookieFocusChild.lua

local RectTransformType = typeof(UnityEngine.RectTransform)
local RookieFocusChild = Class("RookieFocusChild", UIControls.Child)

function RookieFocusChild:ctor()
	self.panelEff = UIControls.Panel(self, "EfxClick")
	self.tipPanel = UIControls.Panel(self, "TipsPanel")
	self.panelTipsL = UIControls.Panel(self, "TipsPanel/TipsL")
	self.tipTextL = UIControls.Label(self, "TipsPanel/TipsL/BgTips/Text")
	self.imgNpcL = UIControls.Image(self, "TipsPanel/TipsL/BgNpc/IconNpc")
	self.panelTipsR = UIControls.Panel(self, "TipsPanel/TipsR")
	self.tipTextR = UIControls.Label(self, "TipsPanel/TipsR/BgTips/Text")
	self.dynamicNewPanel = UIControls.Panel(self, "OtherBattleNewPanel")
	self.imgNpcR = UIControls.Image(self, "TipsPanel/TipsR/BgNpc/IconNpc")
end

local PIVOT_VALUE = Vector2(0.5, 0.5)
local MARK_DEFAULT_POS = Vector2(0, 0)

function RookieFocusChild:focus(uiTransform, noticeInfo, dynamicNew)
	local rect = self:getController():GetComponent(RectTransformType)

	rect.sizeDelta = uiTransform.sizeDelta
	rect.pivot = PIVOT_VALUE
	rect.anchorMin = PIVOT_VALUE
	rect.anchorMax = PIVOT_VALUE
	rect.anchoredPosition = MARK_DEFAULT_POS

	if dynamicNew == "1" then
		self.panelEff:setVisible(false)
		self.dynamicNewPanel:setVisible(true)
	else
		self.panelEff:setVisible(true)
		self.dynamicNewPanel:setVisible(false)
	end

	self:_setNoticeInfo(noticeInfo)
end

function RookieFocusChild:_setNoticeInfo(noticeInfo)
	local notice = noticeInfo[1]

	if notice and notice ~= "" then
		self.tipPanel:setVisible(true)

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

return RookieFocusChild
