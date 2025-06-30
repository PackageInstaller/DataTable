-- chunkname: @IQIGame\\UI\\Chapter\\BossChapter\\BossChapterItem.lua

local m = {}

function m.New(view)
	local obj = Clone(m)

	obj:Init(view)

	return obj
end

function m:Init(view)
	self.View = view

	LuaCodeInterface.BindOutlet(self.View, self)

	function self.delegateEnterStageBtn()
		self:OnOpenStageBtnClick()
	end

	self:AddListeners()
end

function m:AddListeners()
	self.View:GetComponent("Button").onClick:AddListener(self.delegateEnterStageBtn)
end

function m:RemoveListeners()
	self.View:GetComponent("Button").onClick:RemoveListener(self.delegateEnterStageBtn)
end

function m:SetData(chapterData, chapterIndex)
	self.chapterData = chapterData
	self.chapterCfg = chapterData:GetCfg()
	self.chapterIndex = chapterIndex

	local path = UIGlobalApi.GetImagePath(self.chapterCfg.BossHeadImg)

	self:LoadImg(path, self.BossBg)

	self.isUnLock = ConditionModule.Check(self.chapterCfg.UnlockConditionId)

	self:RefreshChapterInfo()
end

function m:RefreshChapterInfo()
	self.Unlock:SetActive(self.isUnLock)
	self.Lock:SetActive(not self.isUnLock)

	if self.isUnLock then
		local strs = string.split(self.chapterCfg.Name, "|")

		UGUIUtil.SetText(self.ChapterName, strs[1])
		UGUIUtil.SetText(self.BossName, strs[2])
		UGUIUtil.SetText(self.BossTitle, ChapterUIApi:GetBossTitle())
		UGUIUtil.SetText(self.OrderTitle, ChapterUIApi:GetOrderTitle(self.chapterIndex))
	else
		UGUIUtil.SetText(self.ChapterIndexText, self.chapterIndex < 10 and "0" .. self.chapterIndex or self.chapterIndex)
	end
end

function m:OnOpenStageBtnClick()
	if not ConditionModule.Check(self.chapterData:GetCfg().UnlockConditionId) then
		NoticeModule.ShowNotice(49005)

		return
	end

	UIModule.Open(Constant.UIControllerName.BossDupUI, Constant.UILayer.UI, self.chapterData)
end

function m:LoadImg(path, obj)
	AssetUtil.LoadImage(self, path, obj:GetComponent("Image"))
end

function m:Dispose()
	self:RemoveListeners()
	AssetUtil.UnloadAsset(self)
	LuaCodeInterface.ClearOutlet(self.View, self)

	self.View = nil
end

return m
