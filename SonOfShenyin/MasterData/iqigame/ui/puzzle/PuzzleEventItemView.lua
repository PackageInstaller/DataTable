-- chunkname: @IQIGame\\UI\\Puzzle\\PuzzleEventItemView.lua

local PuzzleEventItemView = {}

function PuzzleEventItemView.New(go, mainView)
	local o = Clone(PuzzleEventItemView)

	o:Initialize(go, mainView)

	return o
end

function PuzzleEventItemView:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function PuzzleEventItemView:InitComponent()
	self.img = self.image:GetComponent("Image")
	self.imageIcon = self.icon:GetComponent("Image")
end

function PuzzleEventItemView:InitDelegate()
	return
end

function PuzzleEventItemView:AddListener()
	return
end

function PuzzleEventItemView:RemoveListener()
	return
end

function PuzzleEventItemView:OnDestroy()
	return
end

function PuzzleEventItemView:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function PuzzleEventItemView:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function PuzzleEventItemView:Refresh(Data, index)
	self.data = Data

	if self.data == 0 then
		self:Hide()

		return
	end

	LuaUtility.SetGameObjectShow(self.contentText, false)
	LuaUtility.SetGameObjectShow(self.image, false)
	LuaUtility.SetGameObjectShow(self.icon, false)
	LuaUtility.SetText(self.orderText, index)

	local cfg = CfgUtil.GetCfgStoryIncidentDataWithID(self.data)

	if cfg.Type == Constant.StoryEventDataType.Text then
		LuaUtility.SetText(self.contentText, cfg.Text)
		LuaUtility.SetGameObjectShow(self.contentText, true)
	elseif cfg.Type == Constant.StoryEventDataType.Image then
		LuaUtility.LoadImage(self, cfg.Url, self.img, function()
			self.img:SetNativeSize()
		end)
		LuaUtility.SetGameObjectShow(self.image, true)
	elseif cfg.Type == Constant.StoryEventDataType.Icon then
		LuaUtility.LoadImage(self, cfg.Url, self.imageIcon, function()
			self.imageIcon:SetNativeSize()
			LuaUtility.SetAnchoredPositionWithRectTransform(self.icon:GetComponent("RectTransform"), cfg.Skew[1], cfg.Skew[2])
		end)
		LuaUtility.SetGameObjectShow(self.icon, true)
	end

	self:Show()
end

return PuzzleEventItemView
