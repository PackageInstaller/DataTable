-- chunkname: @IQIGame\\UI\\Common\\CvUIFrame.lua

CvUIFrame = {}

function CvUIFrame.New(go, uiName)
	local o = Clone(CvUIFrame)

	o:Init(go, uiName)

	return o
end

function CvUIFrame:Init(go, uiName)
	LuaCodeInterface.BindOutlet(go, self)

	self.goView = go

	if uiName ~= nil then
		self.goContent.transform.sizeDelta = Vector2.New(SoulUIApi:GetString("cvFrameWidth", uiName), self.goContent.transform.sizeDelta.y)
	end

	self.tfContent = self.goContentTxt:GetComponent("Text")
	self.tfContent.text = ""

	function self.dgtOnShowCVUI(cvID)
		self:Open(cvID)
	end

	function self.dgtOnHideCVUI()
		self:Close()
	end

	self.goView:SetActive(false)
end

function CvUIFrame:RefreshView(offset)
	self:RefreshPos(offset)
	self.goView:SetActive(false)
end

function CvUIFrame:Open(cvID)
	self.cvID = cvID

	local cfgCvRow = CfgCVTable[self.cvID]

	self.tfContent.text = string.gsub(cfgCvRow.Text, "{PlayerName}", PlayerModule.PlayerInfo.baseInfo.pName)

	self.goView:SetActive(true)
end

function CvUIFrame:Close()
	self.goView:SetActive(false)
end

function CvUIFrame:RefreshPos(offset)
	if offset ~= nil then
		self.goView:GetComponent("RectTransform").anchoredPosition = offset
	end
end

function CvUIFrame:Dispose()
	self:Close()
end

function CvUIFrame:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.goView, self)

	self.goView = nil
end
