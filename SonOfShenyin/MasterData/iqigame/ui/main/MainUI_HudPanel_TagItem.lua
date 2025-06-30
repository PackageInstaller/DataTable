-- chunkname: @IQIGame\\UI\\Main\\MainUI_HudPanel_TagItem.lua

local MainUI_HudPanel_TagItem = {}
local dataName_npcTag = "npcTag"
local stateName_main = "main"
local stateName_chapter = "branchTag_chapter"
local stateName_RPG = "branchTag_RPG"
local stateName_saunterEvent = "saunterEvent"
local stateName_smallEvent = "smallEvent"
local stateName_affinity = "affinity"
local stateName_daily = "daily"
local stateName_hunt = "hunt"

function MainUI_HudPanel_TagItem.New(go, mainView)
	local o = Clone(MainUI_HudPanel_TagItem)

	o:Initialize(go, mainView)

	return o
end

function MainUI_HudPanel_TagItem:Initialize(go, mainView)
	LuaCodeInterface.BindOutlet(go, self)

	self.gameObject = go
	self.mainView = mainView
	self.canvas = mainView:GetCanvas()
	self.isFree = true

	self:InitComponent()
	self:InitDelegate()
	self:AddListener()
end

function MainUI_HudPanel_TagItem:InitComponent()
	return
end

function MainUI_HudPanel_TagItem:InitDelegate()
	return
end

function MainUI_HudPanel_TagItem:AddListener()
	return
end

function MainUI_HudPanel_TagItem:RemoveListener()
	return
end

function MainUI_HudPanel_TagItem:Show()
	LuaUtility.SetGameObjectShow(self.gameObject, true)
end

function MainUI_HudPanel_TagItem:Hide()
	LuaUtility.SetGameObjectShow(self.gameObject, false)
end

function MainUI_HudPanel_TagItem:Free()
	self.isFree = true
end

function MainUI_HudPanel_TagItem:GetIsFree()
	return self.isFree
end

function MainUI_HudPanel_TagItem:Refresh(mountPoint, actionType, compId)
	local follower = LuaUtility.GameObjectGetOrAddComponent(self.gameObject, typeof(UIFollower))

	follower:Init(UnityEngine.Camera.main, GameEntry.UICamera, mountPoint.transform, self.canvas)

	if actionType == Constant.RPGTagType.MainTag then
		LuaUtility.SetStateController(self.gameObject, dataName_npcTag, stateName_main)
	elseif actionType == Constant.RPGTagType.BranchTag then
		LuaUtility.SetStateController(self.gameObject, dataName_npcTag, stateName_chapter)
	elseif actionType == Constant.RPGTagType.BranchTag_RPG then
		LuaUtility.SetStateController(self.gameObject, dataName_npcTag, stateName_RPG)
	elseif actionType == Constant.RPGTagType.SaunterEvent then
		LuaUtility.SetStateController(self.gameObject, dataName_npcTag, stateName_saunterEvent)
	elseif actionType == Constant.RPGTagType.SmallEvent then
		LuaUtility.SetStateController(self.gameObject, dataName_npcTag, stateName_smallEvent)
	elseif actionType == Constant.RPGTagType.Affinity then
		LuaUtility.SetStateController(self.gameObject, dataName_npcTag, stateName_affinity)
	elseif actionType == Constant.RPGTagType.Daily then
		LuaUtility.SetStateController(self.gameObject, dataName_npcTag, stateName_daily)
	elseif actionType == Constant.RPGTagType.Hunt then
		LuaUtility.SetStateController(self.gameObject, dataName_npcTag, stateName_hunt)
	end

	self.gameObject.name = compId
	self.isFree = false
end

function MainUI_HudPanel_TagItem:OnDestroy()
	LuaCodeInterface.ClearOutlet(self.gameObject, self)
	GameObject.Destroy(self.gameObject)

	self.gameObject = nil
end

return MainUI_HudPanel_TagItem
