---@class SkillTreeOnPanel_Generate_pointBox_skillNameTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class SkillTreeOnPanel_Generate_pointBox_skillMode_skillView_iconImg
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class SkillTreeOnPanel_Generate_pointBox_skillMode_skillView
---@field public gameObject UnityEngine.GameObject
---@field public canvasGroup UnityEngine.CanvasGroup
---@field public iconBg UnityEngine.GameObject
---@field public iconImg SkillTreeOnPanel_Generate_pointBox_skillMode_skillView_iconImg

---@class SkillTreeOnPanel_Generate_pointBox_skillMode_iconImg
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class SkillTreeOnPanel_Generate_pointBox_skillMode
---@field public gameObject UnityEngine.GameObject
---@field public mainView UnityEngine.GameObject
---@field public iconImg SkillTreeOnPanel_Generate_pointBox_skillMode_iconImg
---@field public skillView SkillTreeOnPanel_Generate_pointBox_skillMode_skillView

---@class SkillTreeOnPanel_Generate_pointBox_mainMode_iconImg
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class SkillTreeOnPanel_Generate_pointBox_mainMode
---@field public gameObject UnityEngine.GameObject
---@field public mainBg UnityEngine.GameObject
---@field public iconImg SkillTreeOnPanel_Generate_pointBox_mainMode_iconImg

---@class SkillTreeOnPanel_Generate_pointBox
---@field public gameObject UnityEngine.GameObject
---@field public canvasGroup UnityEngine.CanvasGroup
---@field public mainMode SkillTreeOnPanel_Generate_pointBox_mainMode
---@field public skillMode SkillTreeOnPanel_Generate_pointBox_skillMode
---@field public skillNameTxt SkillTreeOnPanel_Generate_pointBox_skillNameTxt

---@class SkillTreeOnPanel_Generate_art
---@field public gameObject UnityEngine.GameObject
---@field public canvas UnityEngine.Canvas

---@class SkillTreeOnPanel_Generate_imgBg
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class SkillTreeOnPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public imgBg SkillTreeOnPanel_Generate_imgBg
---@field public art SkillTreeOnPanel_Generate_art
---@field public pointBox SkillTreeOnPanel_Generate_pointBox
---@field public effect_Ui_SkillTreeOn UnityEngine.GameObject
local SkillTreeOnPanel = class("SkillTreeOnPanel", require("WndBase"))

function SkillTreeOnPanel:ctor(data)
end

---@private
function SkillTreeOnPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("SkillTreeOnPanel")

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

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function SkillTreeOnPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function SkillTreeOnPanel:InitGenerate__2(Root, data)
--[[
	ImgBg
--]]
	local tmp = Root:Find("ImgBg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.imgBg = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("SkillTreeOnPanel_imgBg")
			if self.imgBg_Button_onClick then
				self:imgBg_Button_onClick(self.imgBg)
			end
		end)


end

---@private
function SkillTreeOnPanel:InitGenerate__3(Root, data)
--[[
	Art
--]]
	local tmp = Root:Find("Art").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.art = tmp

	tmp.canvas = tmp:GetComponent(TypeInfo.Canvas)


end

---@private
function SkillTreeOnPanel:InitGenerate__4(Root, data)
--[[
	PointBox
--]]
	local tmp = Root:Find("PointBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.pointBox = tmp

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function SkillTreeOnPanel:InitGenerate__5(Root, data)
--[[
	PointBox/MainMode
--]]
	local tmp = Root:Find("PointBox/MainMode").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.pointBox.mainMode = tmp


end

---@private
function SkillTreeOnPanel:InitGenerate__6(Root, data)
--[[
	PointBox/MainMode/MainBg
--]]
	local tmp = Root:Find("PointBox/MainMode/MainBg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.pointBox.mainMode.mainBg = tmp


end

---@private
function SkillTreeOnPanel:InitGenerate__7(Root, data)
--[[
	PointBox/MainMode/MainBg/Mainimg/IconImg
--]]
	local tmp = Root:Find("PointBox/MainMode/MainBg/Mainimg/IconImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.pointBox.mainMode.iconImg = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function SkillTreeOnPanel:InitGenerate__8(Root, data)
--[[
	PointBox/SkillMode
--]]
	local tmp = Root:Find("PointBox/SkillMode").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.pointBox.skillMode = tmp


end

---@private
function SkillTreeOnPanel:InitGenerate__9(Root, data)
--[[
	PointBox/SkillMode/MainBg/MainView
--]]
	local tmp = Root:Find("PointBox/SkillMode/MainBg/MainView").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.pointBox.skillMode.mainView = tmp


end

---@private
function SkillTreeOnPanel:InitGenerate__10(Root, data)
--[[
	PointBox/SkillMode/MainBg/MainView/IconImg
--]]
	local tmp = Root:Find("PointBox/SkillMode/MainBg/MainView/IconImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.pointBox.skillMode.iconImg = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function SkillTreeOnPanel:InitGenerate__11(Root, data)
--[[
	PointBox/SkillMode/MainBg/SkillView
--]]
	local tmp = Root:Find("PointBox/SkillMode/MainBg/SkillView").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.pointBox.skillMode.skillView = tmp

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function SkillTreeOnPanel:InitGenerate__12(Root, data)
--[[
	PointBox/SkillMode/MainBg/SkillView/IconBg
--]]
	local tmp = Root:Find("PointBox/SkillMode/MainBg/SkillView/IconBg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.pointBox.skillMode.skillView.iconBg = tmp


end

---@private
function SkillTreeOnPanel:InitGenerate__13(Root, data)
--[[
	PointBox/SkillMode/MainBg/SkillView/IconBg/IconImg
--]]
	local tmp = Root:Find("PointBox/SkillMode/MainBg/SkillView/IconBg/IconImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.pointBox.skillMode.skillView.iconImg = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function SkillTreeOnPanel:InitGenerate__14(Root, data)
--[[
	PointBox/SkillNameTxt
--]]
	local tmp = Root:Find("PointBox/SkillNameTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.pointBox.skillNameTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function SkillTreeOnPanel:InitGenerate__15(Root, data)
--[[
	PointBox/Effect_Ui_SkillTreeOn
--]]
	local tmp = Root:Find("PointBox/Effect_Ui_SkillTreeOn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.effect_Ui_SkillTreeOn = tmp


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function SkillTreeOnPanel:SetLocalizedText(Root)

    local locObj_SkillTreeOnPanel_TipsText = Root:Find("Art/TipsBg/TipsText")
    if locObj_SkillTreeOnPanel_TipsText then
        locObj_SkillTreeOnPanel_TipsText.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.SkillTreeOnPanel_TipsText
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return SkillTreeOnPanel