-- chunkname: @IQIGame\\UI\\Archives\\DisplayDetaillPanel.lua

local DisplayDetaillPanel = {}

function DisplayDetaillPanel.New(go, mainView)
	local o = Clone(DisplayDetaillPanel)

	o:Initialize(go, mainView)

	return o
end

function DisplayDetaillPanel:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function DisplayDetaillPanel:InitComponent()
	self.scloseBtn = self.scloseBtn:GetComponent("Button")
end

function DisplayDetaillPanel:InitDelegate()
	function self.scloseBtnClickDelegate()
		self:scloseBtnClick()
	end
end

function DisplayDetaillPanel:AddListener()
	self.scloseBtn.onClick:AddListener(self.scloseBtnClickDelegate)
end

function DisplayDetaillPanel:RemoveListener()
	self.scloseBtn.onClick:RemoveListener(self.scloseBtnClickDelegate)
end

function DisplayDetaillPanel:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function DisplayDetaillPanel:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function DisplayDetaillPanel:OnDestroy()
	AssetUtil.UnloadAsset(self)
	self:RemoveListener()
end

function DisplayDetaillPanel:Refresh(cid)
	local cfgData = TaskSystemModule.GetCfgTaskDataWithID(cid)

	LuaUtility.SetText(self.achievementNameText, cfgData.Name)
	LuaUtility.LoadImage(self, UIGlobalApi.GetIconPath(cfgData.EmblemIcon), self.displayItemImg:GetComponent("Image"))
	LuaUtility.SetText(self.gainContentText, cfgData.Desc)
end

function DisplayDetaillPanel:scloseBtnClick()
	self:Hide()
end

return DisplayDetaillPanel
