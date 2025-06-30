-- chunkname: @IQIGame\\UI\\MazeSelectLevel\\ChapterViewportController.lua

local m = {
	CurrentChapterCid = 0,
	IgnoreToggleValueChangeOnce = false
}

function m.New(view, onToggleChanged)
	local obj = Clone(m)

	obj:Init(view, onToggleChanged)

	return obj
end

function m:Init(view, onToggleChanged)
	self.View = view
	self.OnToggleChangedCallback = onToggleChanged

	LuaCodeInterface.BindOutlet(self.View, self)

	self.CidGoMap = {}
	self.CidRedPointMap = {}

	local listGo = self.View.transform:Find("ChapterScrollList")

	for i = 0, listGo.childCount - 1 do
		local startIndex = -1
		local chapterCid = 0
		local child = listGo:GetChild(i)
		local prefix = "Chapter_"

		startIndex = string.find(child.name, prefix)

		if startIndex == 1 then
			chapterCid = tonumber(string.sub(child.name, startIndex + #prefix))
			self.CidGoMap[chapterCid] = child.gameObject
			self.CidRedPointMap[chapterCid] = child:Find("Toggle/Image_RedPoint").gameObject
		end
	end

	for cid, go in pairs(self.CidGoMap) do
		self["DelegateOnToggleValueChanged" .. cid] = function(isOn)
			self:OnToggleValueChanged(isOn, cid)
		end
		self["DelegateOnClickLockButton" .. cid] = function()
			self:OnClickLockButton(cid)
		end

		local btn = go:GetComponentInChildren(typeof(UnityEngine.UI.Button), true)

		if btn ~= nil then
			local btnGrayComponent = btn:GetComponent(typeof(IQIGame.Onigao.Game.GrayComponent))

			btnGrayComponent:SetGray(true)
		end
	end

	self:AddListeners()
end

function m:AddListeners()
	for cid, go in pairs(self.CidGoMap) do
		go:GetComponentInChildren(typeof(UnityEngine.UI.Toggle), true).onValueChanged:AddListener(self["DelegateOnToggleValueChanged" .. cid])
		go:GetComponentInChildren(typeof(UnityEngine.UI.Button), true).onClick:AddListener(self["DelegateOnClickLockButton" .. cid])
	end
end

function m:RemoveListeners()
	for cid, go in pairs(self.CidGoMap) do
		go:GetComponentInChildren(typeof(UnityEngine.UI.Toggle), true).onValueChanged:RemoveListener(self["DelegateOnToggleValueChanged" .. cid])
		go:GetComponentInChildren(typeof(UnityEngine.UI.Button), true).onClick:RemoveListener(self["DelegateOnClickLockButton" .. cid])
	end
end

function m:Refresh(currentChapterCid)
	self.CurrentChapterCid = currentChapterCid

	local chapterNotPerfectMap, chapterMap = self:GetData()

	self.ChapterMap = chapterMap

	for cid, go in pairs(self.CidGoMap) do
		local data = chapterMap[cid]
		local isPerfect = not chapterNotPerfectMap[cid]

		go.transform:Find("Toggle/goUp/Image_Finish").gameObject:SetActive(isPerfect)
		go.transform:Find("Toggle/goDown/Image_Finish").gameObject:SetActive(isPerfect)
		UGUIUtil.SetText(go.transform:Find("Toggle/goUp/Chapter_Name/Text_01").gameObject, MazeSelectLevelUIApi:GetString("ChapterToggleOrderNameText", data.cfgChapterData.ChapterTypeName, data.cfgChapterData.Alias, data.cfgChapterData.Order))
		UGUIUtil.SetText(go.transform:Find("Toggle/goUp/Chapter_Name/Text_02").gameObject, MazeSelectLevelUIApi:GetString("ChapterToggleNameText", data.cfgChapterData.ChapterTypeName, data.cfgChapterData.Alias, data.cfgChapterData.Name))

		local tg = go:GetComponentInChildren(typeof(UnityEngine.UI.Toggle), true)
		local btn = go:GetComponentInChildren(typeof(UnityEngine.UI.Button), true)

		tg.gameObject:SetActive(data.isUnlock)
		btn.gameObject:SetActive(not data.isUnlock)
	end

	local latestChapterGo = self.CidGoMap[currentChapterCid]
	local toggle = latestChapterGo:GetComponentInChildren(typeof(UnityEngine.UI.Toggle), true)

	if not toggle.isOn then
		self.IgnoreToggleValueChangeOnce = true
		toggle.isOn = true
	end

	local currentToggleRect = UGUIUtil.GetUIRect(latestChapterGo.transform, true)
	local viewRect = UGUIUtil.GetUIRect(self.View.transform)
	local relativeY = currentToggleRect.y + currentToggleRect.h - (viewRect.y + viewRect.h)
	local indent = viewRect.h / 2
	local position = self.View.transform.position

	position.y = position.y - relativeY - indent
	self.View.transform.position = position

	self:UpdateRedPoint()
end

function m:GetData()
	local chapterNotPerfectMap = {}

	for id, cfgMazeInstanceData in pairsCfg(CfgMazeInstanceTable) do
		local mazeInfoPOD = PlayerModule.PlayerInfo.mazeInfoPOD[id]

		if (mazeInfoPOD == nil or mazeInfoPOD.score < 100) and chapterNotPerfectMap[cfgMazeInstanceData.ChapterId] == nil then
			chapterNotPerfectMap[cfgMazeInstanceData.ChapterId] = true
		end
	end

	local chapterMap = {}
	local chapterIdList = {}

	for id, cfgChapterData in pairsCfg(CfgChapterTable) do
		if cfgChapterData.Type == 2 then
			local isUnlock = ConditionModule.Check(cfgChapterData.LockCondition)

			if isUnlock then
				table.insert(chapterIdList, cfgChapterData)
			end

			chapterMap[id] = {
				cfgChapterData = cfgChapterData,
				isUnlock = isUnlock
			}
		end
	end

	if #chapterIdList == 0 then
		logError("There is no available maze")
	end

	table.sort(chapterIdList, function(cfgChapterData1, cfgChapterData2)
		return cfgChapterData1.Order < cfgChapterData2.Order
	end)

	return chapterNotPerfectMap, chapterMap
end

function m:OnToggleValueChanged(isOn, cid)
	if isOn then
		if self.IgnoreToggleValueChangeOnce then
			self.IgnoreToggleValueChangeOnce = false

			return
		end

		self:ShowChapter(cid)
	end
end

function m:OnClickLockButton(chapterCid)
	local cfgChapterData = CfgChapterTable[chapterCid]
	local cfgConditionData = CfgConditionTable[cfgChapterData.LockCondition]

	NoticeModule.ShowNoticeNoCallback(21045025, cfgConditionData.Name)
end

function m:ShowChapter(chapterCid)
	if self.CurrentChapterCid == chapterCid then
		return
	end

	self.CurrentChapterCid = chapterCid

	self.OnToggleChangedCallback(chapterCid)
end

function m:UpdateRedPoint()
	for chapterCid, redPoint in pairs(self.CidRedPointMap) do
		redPoint:SetActive(PlayerModule.CanClaimExploreReward(CfgChapterTable[chapterCid]))
	end
end

function m:Dispose()
	self:RemoveListeners()

	for i, v in pairs(self.CidGoMap) do
		self.CidGoMap[i] = nil
	end

	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
