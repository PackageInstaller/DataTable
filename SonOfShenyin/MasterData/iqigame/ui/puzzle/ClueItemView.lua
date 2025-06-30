-- chunkname: @IQIGame\\UI\\Puzzle\\ClueItemView.lua

local ClueItemView = {}

function ClueItemView.New(go, mainView)
	local o = Clone(ClueItemView)

	o:Initialize(go, mainView)

	return o
end

function ClueItemView:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function ClueItemView:InitComponent()
	self.clueImg = self.clueImg:GetComponent("Image")
end

function ClueItemView:InitDelegate()
	function self.delegateOnClickButtonDetail()
		self:OnClickButtonDetail()
	end
end

function ClueItemView:AddListener()
	self.buttonDetail:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonDetail)
end

function ClueItemView:RemoveListener()
	self.buttonDetail:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonDetail)
end

function ClueItemView:OnClickButtonDetail()
	self.mainView:OnClickClue(self)
end

function ClueItemView:OnDestroy()
	return
end

function ClueItemView:GetIsSelected()
	return self.selectImg.activeSelf
end

function ClueItemView:Selected()
	LuaUtility.SetGameObjectShow(self.selectImg, true)
end

function ClueItemView:UnSelected()
	LuaUtility.SetGameObjectShow(self.selectImg, false)
end

function ClueItemView:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function ClueItemView:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)

	self.gameObject.name = 0
end

function ClueItemView:ShowComposeFlag()
	LuaUtility.SetGameObjectShow(self.tagImg, true)
end

function ClueItemView:HideComposeFlag()
	LuaUtility.SetGameObjectShow(self.tagImg, false)
end

function ClueItemView:Refresh(Data)
	self.data = Data
	self.gameObject.name = self.data

	self:UnSelected()

	self.cfgClue = CfgUtil.GetCfgCluesDataWithID(self.data)

	LuaUtility.LoadImage(self, self.cfgClue.Icon, self.clueImg)
	LuaUtility.SetText(self.nameText, self.cfgClue.CluesName)
	LuaUtility.SetText(self.descText, self.cfgClue.Des)
	LuaUtility.SetGameObjectShow(self.detailBtn, self.cfgClue.IsSurvey)

	if self.mainView.detailPanel:GetIsSelected(self.data) then
		self:Selected()
	end
end

return ClueItemView
