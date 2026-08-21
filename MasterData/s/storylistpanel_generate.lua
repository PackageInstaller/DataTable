---@class StoryListPanel_Generate_storyBox_storyNameTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class StoryListPanel_Generate_storyBox_indexTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class StoryListPanel_Generate_storyBox
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public button UnityEngine.UI.Button
---@field public bg UnityEngine.GameObject
---@field public isNone UnityEngine.GameObject
---@field public isOpen UnityEngine.GameObject
---@field public isSelect UnityEngine.GameObject
---@field public indexTxt StoryListPanel_Generate_storyBox_indexTxt
---@field public storyNameTxt StoryListPanel_Generate_storyBox_storyNameTxt
---@field public icon UnityEngine.GameObject
---@field public isLock UnityEngine.GameObject

---@class StoryListPanel_Generate_customBackPanel
---@field public gameObject UnityEngine.GameObject
---@field public customBackPanel CustomBackPanel

---@class StoryListPanel_Generate_playBtn_txt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class StoryListPanel_Generate_playBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public txt StoryListPanel_Generate_playBtn_txt

---@class StoryListPanel_Generate_storyMsgTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class StoryListPanel_Generate_role_M
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public image UnityEngine.UI.Image

---@class StoryListPanel_Generate_role_R
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public image UnityEngine.UI.Image

---@class StoryListPanel_Generate_role_L
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public image UnityEngine.UI.Image

---@class StoryListPanel_Generate_background
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class StoryListPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public rectTransform UnityEngine.RectTransform
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public storyBoxList UnityEngine.GameObject
---@field public background StoryListPanel_Generate_background
---@field public role_L StoryListPanel_Generate_role_L
---@field public role_R StoryListPanel_Generate_role_R
---@field public role_M StoryListPanel_Generate_role_M
---@field public isNone UnityEngine.GameObject
---@field public storyMsgTxt StoryListPanel_Generate_storyMsgTxt
---@field public playBtn StoryListPanel_Generate_playBtn
---@field public customBackPanel StoryListPanel_Generate_customBackPanel
---@field public storyBox StoryListPanel_Generate_storyBox
local StoryListPanel = class("StoryListPanel", require("WndBase"))

function StoryListPanel:ctor(data)
end

---@private
function StoryListPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("StoryListPanel")

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
	self:InitGenerate__13(Root,data)
	self:InitGenerate__14(Root,data)
	self:InitGenerate__15(Root,data)
	self:InitGenerate__16(Root,data)
	self:InitGenerate__17(Root,data)
	self:InitGenerate__18(Root,data)
	self:InitGenerate__19(Root,data)
	self:InitGenerate__20(Root,data)

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function StoryListPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.rectTransform = Root:GetComponent(TypeInfo.RectTransform)

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function StoryListPanel:InitGenerate__2(Root, data)
--[[
	AdjustRoot/Scroll View/Viewport/StoryBoxList
--]]
	local tmp = Root:Find("AdjustRoot/Scroll View/Viewport/StoryBoxList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.storyBoxList = tmp


end

---@private
function StoryListPanel:InitGenerate__3(Root, data)
--[[
	AdjustRoot/PicView/Mask/Background
--]]
	local tmp = Root:Find("AdjustRoot/PicView/Mask/Background").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.background = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function StoryListPanel:InitGenerate__4(Root, data)
--[[
	AdjustRoot/PicView/Mask/Background/Role_L
--]]
	local tmp = Root:Find("AdjustRoot/PicView/Mask/Background/Role_L").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.role_L = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function StoryListPanel:InitGenerate__5(Root, data)
--[[
	AdjustRoot/PicView/Mask/Background/Role_R
--]]
	local tmp = Root:Find("AdjustRoot/PicView/Mask/Background/Role_R").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.role_R = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function StoryListPanel:InitGenerate__6(Root, data)
--[[
	AdjustRoot/PicView/Mask/Background/Role_M
--]]
	local tmp = Root:Find("AdjustRoot/PicView/Mask/Background/Role_M").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.role_M = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function StoryListPanel:InitGenerate__7(Root, data)
--[[
	AdjustRoot/MsgBg/IsNone
--]]
	local tmp = Root:Find("AdjustRoot/MsgBg/IsNone").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.isNone = tmp


end

---@private
function StoryListPanel:InitGenerate__8(Root, data)
--[[
	AdjustRoot/MsgBg/StoryMsgTxt
--]]
	local tmp = Root:Find("AdjustRoot/MsgBg/StoryMsgTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.storyMsgTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function StoryListPanel:InitGenerate__9(Root, data)
--[[
	AdjustRoot/MsgBg/PlayBtn
--]]
	local tmp = Root:Find("AdjustRoot/MsgBg/PlayBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.playBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("StoryListPanel_playBtn")
			if self.playBtn_ScaleButton_onClick then
				self:playBtn_ScaleButton_onClick(self.playBtn)
			end
		end)


end

---@private
function StoryListPanel:InitGenerate__10(Root, data)
--[[
	AdjustRoot/MsgBg/PlayBtn/txt
--]]
	local tmp = Root:Find("AdjustRoot/MsgBg/PlayBtn/txt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.playBtn.txt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function StoryListPanel:InitGenerate__11(Root, data)
--[[
	CustomBackPanel
--]]
	local tmp = Root:Find("CustomBackPanel").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.customBackPanel = tmp

	tmp.customBackPanel = tmp:AddComponentLua("CustomBackPanel", data)


end

---@private
function StoryListPanel:InitGenerate__12(Root, data)
--[[
	Custom/StoryBox
--]]
	local tmp = Root:Find("Custom/StoryBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.storyBox = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.button = tmp:GetComponent(TypeInfo.Button)


end

---@private
function StoryListPanel:InitGenerate__13(Root, data)
--[[
	Custom/StoryBox/bg
--]]
	local tmp = Root:Find("Custom/StoryBox/bg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.storyBox.bg = tmp


end

---@private
function StoryListPanel:InitGenerate__14(Root, data)
--[[
	Custom/StoryBox/bg/IsNone
--]]
	local tmp = Root:Find("Custom/StoryBox/bg/IsNone").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.storyBox.isNone = tmp


end

---@private
function StoryListPanel:InitGenerate__15(Root, data)
--[[
	Custom/StoryBox/bg/IsOpen
--]]
	local tmp = Root:Find("Custom/StoryBox/bg/IsOpen").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.storyBox.isOpen = tmp


end

---@private
function StoryListPanel:InitGenerate__16(Root, data)
--[[
	Custom/StoryBox/IsSelect
--]]
	local tmp = Root:Find("Custom/StoryBox/IsSelect").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.storyBox.isSelect = tmp


end

---@private
function StoryListPanel:InitGenerate__17(Root, data)
--[[
	Custom/StoryBox/IndexTxt
--]]
	local tmp = Root:Find("Custom/StoryBox/IndexTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.storyBox.indexTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function StoryListPanel:InitGenerate__18(Root, data)
--[[
	Custom/StoryBox/StoryNameTxt
--]]
	local tmp = Root:Find("Custom/StoryBox/StoryNameTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.storyBox.storyNameTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function StoryListPanel:InitGenerate__19(Root, data)
--[[
	Custom/StoryBox/icon
--]]
	local tmp = Root:Find("Custom/StoryBox/icon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.storyBox.icon = tmp


end

---@private
function StoryListPanel:InitGenerate__20(Root, data)
--[[
	Custom/StoryBox/IsLock
--]]
	local tmp = Root:Find("Custom/StoryBox/IsLock").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.storyBox.isLock = tmp


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function StoryListPanel:SetLocalizedText(Root)

    local locObj_StoryListPanel_IsNone = Root:Find("AdjustRoot/MsgBg/IsNone")
    if locObj_StoryListPanel_IsNone then
        locObj_StoryListPanel_IsNone.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.StoryListPanel_IsNone
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return StoryListPanel