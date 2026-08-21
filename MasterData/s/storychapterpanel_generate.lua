---@class StoryChapterPanel_Generate_storyBox_sceneBox_sceneNameText
---@field public gameObject UnityEngine.GameObject
---@field public text UnityEngine.UI.Text

---@class StoryChapterPanel_Generate_storyBox_sceneBox
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public sceneNameText StoryChapterPanel_Generate_storyBox_sceneBox_sceneNameText

---@class StoryChapterPanel_Generate_storyBox_chapterNameText
---@field public gameObject UnityEngine.GameObject
---@field public text UnityEngine.UI.Text

---@class StoryChapterPanel_Generate_storyBox_chapterBox
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class StoryChapterPanel_Generate_storyBox
---@field public gameObject UnityEngine.GameObject
---@field public chapterBox StoryChapterPanel_Generate_storyBox_chapterBox
---@field public chapterNameText StoryChapterPanel_Generate_storyBox_chapterNameText
---@field public sceneList UnityEngine.GameObject
---@field public sceneBox StoryChapterPanel_Generate_storyBox_sceneBox

---@class StoryChapterPanel_Generate_chapterPicture
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class StoryChapterPanel_Generate_helpBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class StoryChapterPanel_Generate_backMainlBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class StoryChapterPanel_Generate_backBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class StoryChapterPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public rectTransform UnityEngine.RectTransform
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public backBtn StoryChapterPanel_Generate_backBtn
---@field public backMainlBtn StoryChapterPanel_Generate_backMainlBtn
---@field public helpBtn StoryChapterPanel_Generate_helpBtn
---@field public chapterPicture StoryChapterPanel_Generate_chapterPicture
---@field public content UnityEngine.GameObject
---@field public storyBox StoryChapterPanel_Generate_storyBox
local StoryChapterPanel = class("StoryChapterPanel", require("WndBase"))

function StoryChapterPanel:ctor(data)
end

---@private
function StoryChapterPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("StoryChapterPanel")

	local Root = self.transform 
	local tmp

	self:InitGenerate__1(Root,data)
	self:InitGenerate__2(Root,data)
	self:InitGenerate__3(Root,data)
	self:InitGenerate__4(Root,data)
	self:InitGenerate__5(Root,data)
	self:InitGenerate__6(Root,data)
	self:InitGenerate__7(Root,data)
	self:InitGenerate__8(Root,data)
	self:InitGenerate__9(Root,data)
	self:InitGenerate__10(Root,data)
	self:InitGenerate__11(Root,data)
	self:InitGenerate__12(Root,data)

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function StoryChapterPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.rectTransform = Root:GetComponent(TypeInfo.RectTransform)

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function StoryChapterPanel:InitGenerate__2(Root, data)
--[[
	BackPanel/BackBtn
--]]
	local tmp = Root:Find("BackPanel/BackBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.backBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("StoryChapterPanel_backBtn")
			if self.backBtn_ScaleButton_onClick then
				self:backBtn_ScaleButton_onClick(self.backBtn)
			end
		end)


end

---@private
function StoryChapterPanel:InitGenerate__3(Root, data)
--[[
	BackPanel/BackMainlBtn
--]]
	local tmp = Root:Find("BackPanel/BackMainlBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.backMainlBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("StoryChapterPanel_backMainlBtn")
			if self.backMainlBtn_ScaleButton_onClick then
				self:backMainlBtn_ScaleButton_onClick(self.backMainlBtn)
			end
		end)


end

---@private
function StoryChapterPanel:InitGenerate__4(Root, data)
--[[
	BackPanel/HelpBtn
--]]
	local tmp = Root:Find("BackPanel/HelpBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.helpBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("StoryChapterPanel_helpBtn")
			if self.helpBtn_ScaleButton_onClick then
				self:helpBtn_ScaleButton_onClick(self.helpBtn)
			end
		end)


end

---@private
function StoryChapterPanel:InitGenerate__5(Root, data)
--[[
	ChapterPicture
--]]
	local tmp = Root:Find("ChapterPicture").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.chapterPicture = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function StoryChapterPanel:InitGenerate__6(Root, data)
--[[
	ChapterBg/ScrollView/Viewport/Content
--]]
	local tmp = Root:Find("ChapterBg/ScrollView/Viewport/Content").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.content = tmp


end

---@private
function StoryChapterPanel:InitGenerate__7(Root, data)
--[[
	ChapterBg/ScrollView/Viewport/Content/StoryBox
--]]
	local tmp = Root:Find("ChapterBg/ScrollView/Viewport/Content/StoryBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.storyBox = tmp


end

---@private
function StoryChapterPanel:InitGenerate__8(Root, data)
--[[
	ChapterBg/ScrollView/Viewport/Content/StoryBox/ChapterBox
--]]
	local tmp = Root:Find("ChapterBg/ScrollView/Viewport/Content/StoryBox/ChapterBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.storyBox.chapterBox = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)


end

---@private
function StoryChapterPanel:InitGenerate__9(Root, data)
--[[
	ChapterBg/ScrollView/Viewport/Content/StoryBox/ChapterBox/ChapterNameText
--]]
	local tmp = Root:Find("ChapterBg/ScrollView/Viewport/Content/StoryBox/ChapterBox/ChapterNameText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.storyBox.chapterNameText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.Text)


end

---@private
function StoryChapterPanel:InitGenerate__10(Root, data)
--[[
	ChapterBg/ScrollView/Viewport/Content/StoryBox/SceneList
--]]
	local tmp = Root:Find("ChapterBg/ScrollView/Viewport/Content/StoryBox/SceneList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.storyBox.sceneList = tmp


end

---@private
function StoryChapterPanel:InitGenerate__11(Root, data)
--[[
	ChapterBg/ScrollView/Viewport/Content/StoryBox/SceneList/SceneBox
--]]
	local tmp = Root:Find("ChapterBg/ScrollView/Viewport/Content/StoryBox/SceneList/SceneBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.storyBox.sceneBox = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)


end

---@private
function StoryChapterPanel:InitGenerate__12(Root, data)
--[[
	ChapterBg/ScrollView/Viewport/Content/StoryBox/SceneList/SceneBox/SceneNameText
--]]
	local tmp = Root:Find("ChapterBg/ScrollView/Viewport/Content/StoryBox/SceneList/SceneBox/SceneNameText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.storyBox.sceneBox.sceneNameText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.Text)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function StoryChapterPanel:SetLocalizedText(Root)

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return StoryChapterPanel