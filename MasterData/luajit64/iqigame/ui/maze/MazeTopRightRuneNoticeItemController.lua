-- chunkname: @IQIGame\\UI\\Maze\\MazeTopRightRuneNoticeItemController.lua

local m = {
	GO_UP_DURATION = 0.5,
	Type = 2,
	MoveElapsedTime = -1,
	GAP = 55,
	Preparing = false
}
local EndlessMazeRuneCell = require("IQIGame.UI.EndlessMazeRune.EndlessMazeRuneCell")

function m.New(view, onRecycle)
	local obj = Clone(m)

	obj:Init(view, onRecycle)

	return obj
end

function m:Init(view, onRecycle)
	self.View = view
	self.OnRecycle = onRecycle

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.DelegateOnFadeoutComplete()
		self:OnFadeoutComplete()
	end

	function self.DelegateOnClickDetailBtn()
		self:OnClickDetailBtn()
	end

	self.RuneCell = EndlessMazeRuneCell.New(self.RuneSlotUI)

	local uiTweeners = self.View:GetComponentsInChildren(typeof(UITweener))

	self.UITweeners = {}

	for i = 0, uiTweeners.Length - 1 do
		self.UITweeners[i + 1] = uiTweeners[i]
	end

	self.DetailBtn:GetComponent("Button").onClick:AddListener(self.DelegateOnClickDetailBtn)
end

function m:SetData(noticeData)
	self.Preparing = true
	self.NoticeData = noticeData

	local cfgRuneData = CfgRuneTable[noticeData.cid]

	self.RuneCell:SetDataByCfgData(cfgRuneData)
	UGUIUtil.SetText(self.NoticeTypeText, EndlessMazeMainUIApi:GetString("MazeTopRightRuneNoticeTypeText", noticeData.subType))
	UGUIUtil.SetText(self.RuneNameText, cfgRuneData.Name)
end

function m:StartMove(hasPrevious)
	self.MoveElapsedTime = 0

	if not self.Preparing then
		local anchoredPosition = self.View.transform.anchoredPosition

		self.StartPos = anchoredPosition:Clone()
		self.EndPos = anchoredPosition:Clone()
		self.EndPos.y = self.EndPos.y + m.GAP
	elseif not hasPrevious then
		self.MoveElapsedTime = m.GO_UP_DURATION
	end

	self.TweenAlpha = self.View:GetComponentInChildren(typeof(TweenAlpha))

	self.TweenAlpha:SetOnFinishedOneShot(self.DelegateOnFadeoutComplete)
end

function m:Update(elapseSeconds, realElapseSeconds)
	if self.MoveElapsedTime ~= -1 then
		self.MoveElapsedTime = self.MoveElapsedTime + elapseSeconds

		local lerpValue = self.MoveElapsedTime / m.GO_UP_DURATION

		if lerpValue > 1 then
			lerpValue = 1
			self.MoveElapsedTime = -1
		end

		if not self.Preparing then
			self.View.transform.anchoredPosition = Vector2.Lerp(self.StartPos, self.EndPos, lerpValue)
		elseif lerpValue == 1 then
			self.Preparing = false

			self.View:SetActive(true)
		end
	end
end

function m:Reset()
	self.View:SetActive(false)

	for i = 1, #self.UITweeners do
		local uiTweener = self.UITweeners[i]

		uiTweener:ResetToBeginning()

		uiTweener.enabled = true
	end

	self.View.transform.anchoredPosition = Vector2.zero
	self.Preparing = false
end

function m:OnFadeoutComplete()
	if self.OnRecycle ~= nil then
		self.OnRecycle(self)
	end
end

function m:OnClickDetailBtn()
	if self.NoticeData.subType == Constant.Maze.RuneNoticeTypeUnseal then
		UIModule.Open(Constant.UIControllerName.EndlessMazeRuneNoticeUnsealUI, Constant.UILayer.UI, self.NoticeData.userData)
	elseif self.NoticeData.subType == Constant.Maze.RuneNoticeTypeEffect then
		-- block empty
	elseif self.NoticeData.subType == Constant.Maze.RuneNoticeTypeEvolution then
		UIModule.Open(Constant.UIControllerName.EndlessMazeRuneNoticeChangeUI, Constant.UILayer.UI, self.NoticeData.userData)
	elseif self.NoticeData.subType == Constant.Maze.RuneNoticeTypeSplit then
		UIModule.Open(Constant.UIControllerName.EndlessMazeRuneSplitUI, Constant.UILayer.UI, self.NoticeData.userData)
	end
end

function m:Dispose()
	AssetUtil.UnloadAsset(self)
	self.DetailBtn:GetComponent("Button").onClick:RemoveListener(self.DelegateOnClickDetailBtn)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
	self.OnRecycle = nil
end

return m
