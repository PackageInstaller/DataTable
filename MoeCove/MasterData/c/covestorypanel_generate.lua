---@class CoveStoryPanel_Generate_nextBtn
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class CoveStoryPanel_Generate_wordsText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.RubyTextMeshProUGUI

---@class CoveStoryPanel_Generate_nameText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.RubyTextMeshProUGUI

---@class CoveStoryPanel_Generate_mask
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class CoveStoryPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public mask CoveStoryPanel_Generate_mask
---@field public storyScreen UnityEngine.GameObject
---@field public storyUIGroup UnityEngine.GameObject
---@field public storyWords UnityEngine.GameObject
---@field public nameText CoveStoryPanel_Generate_nameText
---@field public wordsText CoveStoryPanel_Generate_wordsText
---@field public cutOffLine UnityEngine.GameObject
---@field public doNextIcon UnityEngine.GameObject
---@field public nextBtn CoveStoryPanel_Generate_nextBtn
local CoveStoryPanel = class("CoveStoryPanel", require("WndBase"))

function CoveStoryPanel:ctor(data)
end

---@private
function CoveStoryPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("CoveStoryPanel")

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

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function CoveStoryPanel:InitGenerate__1(Root, data)
--[[
	Mask
--]]
	local tmp = Root:Find("Mask").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.mask = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("CoveStoryPanel_mask")
			if self.mask_Button_onClick then
				self:mask_Button_onClick(self.mask)
			end
		end)


end

---@private
function CoveStoryPanel:InitGenerate__2(Root, data)
--[[
	StoryScreen
--]]
	local tmp = Root:Find("StoryScreen").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.storyScreen = tmp


end

---@private
function CoveStoryPanel:InitGenerate__3(Root, data)
--[[
	StoryScreen/StoryUIGroup
--]]
	local tmp = Root:Find("StoryScreen/StoryUIGroup").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.storyUIGroup = tmp


end

---@private
function CoveStoryPanel:InitGenerate__4(Root, data)
--[[
	StoryScreen/StoryUIGroup/StoryWords
--]]
	local tmp = Root:Find("StoryScreen/StoryUIGroup/StoryWords").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.storyWords = tmp


end

---@private
function CoveStoryPanel:InitGenerate__5(Root, data)
--[[
	StoryScreen/StoryUIGroup/StoryWords/Image/NameText
--]]
	local tmp = Root:Find("StoryScreen/StoryUIGroup/StoryWords/Image/NameText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.nameText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.RubyTextMeshProUGUI)


end

---@private
function CoveStoryPanel:InitGenerate__6(Root, data)
--[[
	StoryScreen/StoryUIGroup/StoryWords/WordsText
--]]
	local tmp = Root:Find("StoryScreen/StoryUIGroup/StoryWords/WordsText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.wordsText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.RubyTextMeshProUGUI)


end

---@private
function CoveStoryPanel:InitGenerate__7(Root, data)
--[[
	StoryScreen/StoryUIGroup/StoryWords/CutOffLine
--]]
	local tmp = Root:Find("StoryScreen/StoryUIGroup/StoryWords/CutOffLine").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.cutOffLine = tmp


end

---@private
function CoveStoryPanel:InitGenerate__8(Root, data)
--[[
	StoryScreen/StoryUIGroup/StoryWords/GameObject/DoNextIcon
--]]
	local tmp = Root:Find("StoryScreen/StoryUIGroup/StoryWords/GameObject/DoNextIcon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.doNextIcon = tmp


end

---@private
function CoveStoryPanel:InitGenerate__9(Root, data)
--[[
	StoryScreen/StoryUIGroup/StoryWords/nextBtn
--]]
	local tmp = Root:Find("StoryScreen/StoryUIGroup/StoryWords/nextBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.nextBtn = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("CoveStoryPanel_nextBtn")
			if self.nextBtn_Button_onClick then
				self:nextBtn_Button_onClick(self.nextBtn)
			end
		end)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function CoveStoryPanel:SetLocalizedText(Root)

    local locObj_CoveStoryPanel_NameText = Root:Find("StoryScreen/StoryUIGroup/StoryWords/Image/NameText")
    if locObj_CoveStoryPanel_NameText then
        locObj_CoveStoryPanel_NameText.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.CoveStoryPanel_NameText
    end

    local locObj_CoveStoryPanel_WordsText = Root:Find("StoryScreen/StoryUIGroup/StoryWords/WordsText")
    if locObj_CoveStoryPanel_WordsText then
        locObj_CoveStoryPanel_WordsText.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.CoveStoryPanel_WordsText
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return CoveStoryPanel