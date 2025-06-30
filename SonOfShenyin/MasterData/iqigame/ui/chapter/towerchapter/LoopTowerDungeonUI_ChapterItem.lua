-- chunkname: @IQIGame\\UI\\Chapter\\TowerChapter\\LoopTowerDungeonUI_ChapterItem.lua

local LoopTowerDungeonUI_ChapterItem = {}

function LoopTowerDungeonUI_ChapterItem.New(go, mainView)
	local o = Clone(LoopTowerDungeonUI_ChapterItem)

	o:Initialize(go, mainView)

	return o
end

function LoopTowerDungeonUI_ChapterItem:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function LoopTowerDungeonUI_ChapterItem:InitComponent()
	return
end

function LoopTowerDungeonUI_ChapterItem:InitDelegate()
	function self.delegateOnClickButtonClick()
		self:OnClickButtonClick()
	end
end

function LoopTowerDungeonUI_ChapterItem:AddListener()
	self.buttonClick:GetComponent("Button").onClick:AddListener(self.delegateOnClickButtonClick)
end

function LoopTowerDungeonUI_ChapterItem:RemoveListener()
	self.buttonClick:GetComponent("Button").onClick:RemoveListener(self.delegateOnClickButtonClick)
end

function LoopTowerDungeonUI_ChapterItem:OnClickButtonClick()
	self.mainView:OnChapterSelected(self)
end

function LoopTowerDungeonUI_ChapterItem:Selected()
	LuaUtility.SetGameObjectShow(self.selectedRoot, true)
end

function LoopTowerDungeonUI_ChapterItem:UnSelected()
	LuaUtility.SetGameObjectShow(self.selectedRoot, false)
end

function LoopTowerDungeonUI_ChapterItem:OnDestroy()
	return
end

function LoopTowerDungeonUI_ChapterItem:Refresh(Data)
	self.data = Data

	if not LuaUtility.StrIsNullOrEmpty(self.data.TowerHeadImg) then
		LuaUtility.LoadImage(self, self.data.TowerHeadImg, self.imageBg:GetComponent("Image"))
	end

	local isPassAll = TowerChapterModule.GetTowerChapterIsAllPass(self.data.Id)

	LuaUtility.SetGameObjectShow(self.completeRoot, isPassAll)
end

return LoopTowerDungeonUI_ChapterItem
