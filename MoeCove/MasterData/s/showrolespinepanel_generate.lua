---@class ShowRoleSpinePanel_Generate_scrollbar
---@field public gameObject UnityEngine.GameObject
---@field public scrollbar UnityEngine.UI.Scrollbar

---@class ShowRoleSpinePanel_Generate_sceneTypeText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class ShowRoleSpinePanel_Generate_sceneTypeBtn
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class ShowRoleSpinePanel_Generate_roleTypeText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class ShowRoleSpinePanel_Generate_roleTypeBtn
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class ShowRoleSpinePanel_Generate_changeBtnText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class ShowRoleSpinePanel_Generate_changeTypeBtn
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class ShowRoleSpinePanel_Generate_skipBtnText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class ShowRoleSpinePanel_Generate_exitBtn
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class ShowRoleSpinePanel_Generate_trackBtn_trackNum
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class ShowRoleSpinePanel_Generate_trackBtn
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image
---@field public scaleButton ScaleButton
---@field public trackNum ShowRoleSpinePanel_Generate_trackBtn_trackNum
---@field public isSelect UnityEngine.GameObject

---@class ShowRoleSpinePanel_Generate_groupBox_actionGroupText
---@field public gameObject UnityEngine.GameObject
---@field public text UnityEngine.UI.Text

---@class ShowRoleSpinePanel_Generate_groupBox
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image
---@field public scaleButton ScaleButton
---@field public actionGroupText ShowRoleSpinePanel_Generate_groupBox_actionGroupText

---@class ShowRoleSpinePanel_Generate_roleIDInputField
---@field public gameObject UnityEngine.GameObject
---@field public inputField UnityEngine.UI.InputField

---@class ShowRoleSpinePanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public roleSpineRoot UnityEngine.GameObject
---@field public roleIDInputField ShowRoleSpinePanel_Generate_roleIDInputField
---@field public content UnityEngine.GameObject
---@field public groupBox ShowRoleSpinePanel_Generate_groupBox
---@field public trackGroup UnityEngine.GameObject
---@field public trackBtn ShowRoleSpinePanel_Generate_trackBtn
---@field public exitBtn ShowRoleSpinePanel_Generate_exitBtn
---@field public skipBtnText ShowRoleSpinePanel_Generate_skipBtnText
---@field public changeTypeBtn ShowRoleSpinePanel_Generate_changeTypeBtn
---@field public changeBtnText ShowRoleSpinePanel_Generate_changeBtnText
---@field public roleTypeBtn ShowRoleSpinePanel_Generate_roleTypeBtn
---@field public roleTypeText ShowRoleSpinePanel_Generate_roleTypeText
---@field public sceneTypeBtn ShowRoleSpinePanel_Generate_sceneTypeBtn
---@field public sceneTypeText ShowRoleSpinePanel_Generate_sceneTypeText
---@field public scrollbar ShowRoleSpinePanel_Generate_scrollbar
local ShowRoleSpinePanel = class("ShowRoleSpinePanel", require("WndBase"))

function ShowRoleSpinePanel:ctor(data)
end

---@private
function ShowRoleSpinePanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("ShowRoleSpinePanel")

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

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function ShowRoleSpinePanel:InitGenerate__1(Root, data)
--[[
	RoleSpineRoot
--]]
	local tmp = Root:Find("RoleSpineRoot").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.roleSpineRoot = tmp


end

---@private
function ShowRoleSpinePanel:InitGenerate__2(Root, data)
--[[
	RoleIDInputField
--]]
	local tmp = Root:Find("RoleIDInputField").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.roleIDInputField = tmp

	tmp.inputField = tmp:GetComponent(TypeInfo.InputField)
	tmp.inputField.onEndEdit:RemoveAllListeners()
	tmp.inputField.onEndEdit:AddListener(function (content)
			if self.roleIDInputField_InputField_onEndEdit then
				self:roleIDInputField_InputField_onEndEdit(self.roleIDInputField,content)
			end
		end)


end

---@private
function ShowRoleSpinePanel:InitGenerate__3(Root, data)
--[[
	ScrollView/Viewport/Content
--]]
	local tmp = Root:Find("ScrollView/Viewport/Content").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.content = tmp


end

---@private
function ShowRoleSpinePanel:InitGenerate__4(Root, data)
--[[
	ScrollView/Viewport/Content/GroupBox
--]]
	local tmp = Root:Find("ScrollView/Viewport/Content/GroupBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.groupBox = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)


end

---@private
function ShowRoleSpinePanel:InitGenerate__5(Root, data)
--[[
	ScrollView/Viewport/Content/GroupBox/ActionGroupText
--]]
	local tmp = Root:Find("ScrollView/Viewport/Content/GroupBox/ActionGroupText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.groupBox.actionGroupText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.Text)


end

---@private
function ShowRoleSpinePanel:InitGenerate__6(Root, data)
--[[
	TrackGroup
--]]
	local tmp = Root:Find("TrackGroup").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.trackGroup = tmp


end

---@private
function ShowRoleSpinePanel:InitGenerate__7(Root, data)
--[[
	TrackGroup/TrackBtn
--]]
	local tmp = Root:Find("TrackGroup/TrackBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.trackBtn = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)


end

---@private
function ShowRoleSpinePanel:InitGenerate__8(Root, data)
--[[
	TrackGroup/TrackBtn/TrackNum
--]]
	local tmp = Root:Find("TrackGroup/TrackBtn/TrackNum").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.trackBtn.trackNum = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function ShowRoleSpinePanel:InitGenerate__9(Root, data)
--[[
	TrackGroup/TrackBtn/IsSelect
--]]
	local tmp = Root:Find("TrackGroup/TrackBtn/IsSelect").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.trackBtn.isSelect = tmp


end

---@private
function ShowRoleSpinePanel:InitGenerate__10(Root, data)
--[[
	ExitBtn
--]]
	local tmp = Root:Find("ExitBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.exitBtn = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("ShowRoleSpinePanel_exitBtn")
			if self.exitBtn_Button_onClick then
				self:exitBtn_Button_onClick(self.exitBtn)
			end
		end)


end

---@private
function ShowRoleSpinePanel:InitGenerate__11(Root, data)
--[[
	ExitBtn/SkipBtnText
--]]
	local tmp = Root:Find("ExitBtn/SkipBtnText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.skipBtnText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function ShowRoleSpinePanel:InitGenerate__12(Root, data)
--[[
	ChangeTypeBtn
--]]
	local tmp = Root:Find("ChangeTypeBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.changeTypeBtn = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("ShowRoleSpinePanel_changeTypeBtn")
			if self.changeTypeBtn_Button_onClick then
				self:changeTypeBtn_Button_onClick(self.changeTypeBtn)
			end
		end)


end

---@private
function ShowRoleSpinePanel:InitGenerate__13(Root, data)
--[[
	ChangeTypeBtn/ChangeBtnText
--]]
	local tmp = Root:Find("ChangeTypeBtn/ChangeBtnText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.changeBtnText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function ShowRoleSpinePanel:InitGenerate__14(Root, data)
--[[
	RoleTypeBtn
--]]
	local tmp = Root:Find("RoleTypeBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.roleTypeBtn = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("ShowRoleSpinePanel_roleTypeBtn")
			if self.roleTypeBtn_Button_onClick then
				self:roleTypeBtn_Button_onClick(self.roleTypeBtn)
			end
		end)


end

---@private
function ShowRoleSpinePanel:InitGenerate__15(Root, data)
--[[
	RoleTypeBtn/RoleTypeText
--]]
	local tmp = Root:Find("RoleTypeBtn/RoleTypeText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.roleTypeText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function ShowRoleSpinePanel:InitGenerate__16(Root, data)
--[[
	SceneTypeBtn
--]]
	local tmp = Root:Find("SceneTypeBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.sceneTypeBtn = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("ShowRoleSpinePanel_sceneTypeBtn")
			if self.sceneTypeBtn_Button_onClick then
				self:sceneTypeBtn_Button_onClick(self.sceneTypeBtn)
			end
		end)


end

---@private
function ShowRoleSpinePanel:InitGenerate__17(Root, data)
--[[
	SceneTypeBtn/SceneTypeText
--]]
	local tmp = Root:Find("SceneTypeBtn/SceneTypeText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.sceneTypeText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function ShowRoleSpinePanel:InitGenerate__18(Root, data)
--[[
	Scrollbar
--]]
	local tmp = Root:Find("Scrollbar").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.scrollbar = tmp

	tmp.scrollbar = tmp:GetComponent(TypeInfo.Scrollbar)
	tmp.scrollbar.onValueChanged:RemoveAllListeners()
	tmp.scrollbar.onValueChanged:AddListener(function (value)
			if self.scrollbar_Scrollbar_onValueChanged then
				self:scrollbar_Scrollbar_onValueChanged(self.scrollbar,value)
			end
		end)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function ShowRoleSpinePanel:SetLocalizedText(Root)

    local locObj_ShowRoleSpinePanel_Placeholder = Root:Find("RoleIDInputField/Placeholder")
    if locObj_ShowRoleSpinePanel_Placeholder then
        locObj_ShowRoleSpinePanel_Placeholder.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.ShowRoleSpinePanel_Placeholder
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return ShowRoleSpinePanel