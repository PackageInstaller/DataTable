---@class TechnologyTreePagePanel_Generate_userGuidePanel
---@field public gameObject UnityEngine.GameObject
---@field public userGuidePanel UserGuidePanel

---@class TechnologyTreePagePanel_Generate_customBackPanel
---@field public gameObject UnityEngine.GameObject
---@field public customBackPanel CustomBackPanel

---@class TechnologyTreePagePanel_Generate_btn3_lockTip
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class TechnologyTreePagePanel_Generate_btn3
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public canvasGroup UnityEngine.CanvasGroup
---@field public normal UnityEngine.GameObject
---@field public redPoint UnityEngine.GameObject
---@field public lock UnityEngine.GameObject
---@field public lockTip TechnologyTreePagePanel_Generate_btn3_lockTip

---@class TechnologyTreePagePanel_Generate_btn2_lockTip
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class TechnologyTreePagePanel_Generate_btn2
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public canvasGroup UnityEngine.CanvasGroup
---@field public normal UnityEngine.GameObject
---@field public redPoint UnityEngine.GameObject
---@field public lock UnityEngine.GameObject
---@field public lockTip TechnologyTreePagePanel_Generate_btn2_lockTip

---@class TechnologyTreePagePanel_Generate_btn1_lockTip
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class TechnologyTreePagePanel_Generate_btn1
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public canvasGroup UnityEngine.CanvasGroup
---@field public normal UnityEngine.GameObject
---@field public redPoint UnityEngine.GameObject
---@field public lock UnityEngine.GameObject
---@field public lockTip TechnologyTreePagePanel_Generate_btn1_lockTip

---@class TechnologyTreePagePanel_Generate_anchor
---@field public gameObject UnityEngine.GameObject
---@field public canvasGroup UnityEngine.CanvasGroup

---@class TechnologyTreePagePanel_Generate_sCircle
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class TechnologyTreePagePanel_Generate_circle
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public canvasGroup UnityEngine.CanvasGroup

---@class TechnologyTreePagePanel_Generate_bg
---@field public gameObject UnityEngine.GameObject
---@field public canvasGroup UnityEngine.CanvasGroup

---@class TechnologyTreePagePanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public bg TechnologyTreePagePanel_Generate_bg
---@field public circle TechnologyTreePagePanel_Generate_circle
---@field public sCircle TechnologyTreePagePanel_Generate_sCircle
---@field public anchor TechnologyTreePagePanel_Generate_anchor
---@field public btnRoot UnityEngine.GameObject
---@field public btn1 TechnologyTreePagePanel_Generate_btn1
---@field public btn2 TechnologyTreePagePanel_Generate_btn2
---@field public btn3 TechnologyTreePagePanel_Generate_btn3
---@field public customBackPanel TechnologyTreePagePanel_Generate_customBackPanel
---@field public userGuidePanel TechnologyTreePagePanel_Generate_userGuidePanel
local TechnologyTreePagePanel = class("TechnologyTreePagePanel", require("WndBase"))

function TechnologyTreePagePanel:ctor(data)
end

---@private
function TechnologyTreePagePanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("TechnologyTreePagePanel")

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
	self:InitGenerate__21(Root,data)
	self:InitGenerate__22(Root,data)
	self:InitGenerate__23(Root,data)

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function TechnologyTreePagePanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function TechnologyTreePagePanel:InitGenerate__2(Root, data)
--[[
	Bg
--]]
	local tmp = Root:Find("Bg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.bg = tmp

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function TechnologyTreePagePanel:InitGenerate__3(Root, data)
--[[
	Circle
--]]
	local tmp = Root:Find("Circle").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.circle = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function TechnologyTreePagePanel:InitGenerate__4(Root, data)
--[[
	Circle/SCircle
--]]
	local tmp = Root:Find("Circle/SCircle").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.sCircle = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function TechnologyTreePagePanel:InitGenerate__5(Root, data)
--[[
	Anchor
--]]
	local tmp = Root:Find("Anchor").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.anchor = tmp

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function TechnologyTreePagePanel:InitGenerate__6(Root, data)
--[[
	BtnRoot
--]]
	local tmp = Root:Find("BtnRoot").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.btnRoot = tmp


end

---@private
function TechnologyTreePagePanel:InitGenerate__7(Root, data)
--[[
	BtnRoot/Btn1
--]]
	local tmp = Root:Find("BtnRoot/Btn1").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.btn1 = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("TechnologyTreePagePanel_btn1")
			if self.btn1_ScaleButton_onClick then
				self:btn1_ScaleButton_onClick(self.btn1)
			end
		end)

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function TechnologyTreePagePanel:InitGenerate__8(Root, data)
--[[
	BtnRoot/Btn1/Normal
--]]
	local tmp = Root:Find("BtnRoot/Btn1/Normal").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.btn1.normal = tmp


end

---@private
function TechnologyTreePagePanel:InitGenerate__9(Root, data)
--[[
	BtnRoot/Btn1/Normal/RedPoint
--]]
	local tmp = Root:Find("BtnRoot/Btn1/Normal/RedPoint").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.btn1.redPoint = tmp


end

---@private
function TechnologyTreePagePanel:InitGenerate__10(Root, data)
--[[
	BtnRoot/Btn1/Lock
--]]
	local tmp = Root:Find("BtnRoot/Btn1/Lock").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.btn1.lock = tmp


end

---@private
function TechnologyTreePagePanel:InitGenerate__11(Root, data)
--[[
	BtnRoot/Btn1/Lock/LockTip
--]]
	local tmp = Root:Find("BtnRoot/Btn1/Lock/LockTip").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.btn1.lockTip = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function TechnologyTreePagePanel:InitGenerate__12(Root, data)
--[[
	BtnRoot/Btn2
--]]
	local tmp = Root:Find("BtnRoot/Btn2").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.btn2 = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("TechnologyTreePagePanel_btn2")
			if self.btn2_ScaleButton_onClick then
				self:btn2_ScaleButton_onClick(self.btn2)
			end
		end)

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function TechnologyTreePagePanel:InitGenerate__13(Root, data)
--[[
	BtnRoot/Btn2/Normal
--]]
	local tmp = Root:Find("BtnRoot/Btn2/Normal").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.btn2.normal = tmp


end

---@private
function TechnologyTreePagePanel:InitGenerate__14(Root, data)
--[[
	BtnRoot/Btn2/Normal/RedPoint
--]]
	local tmp = Root:Find("BtnRoot/Btn2/Normal/RedPoint").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.btn2.redPoint = tmp


end

---@private
function TechnologyTreePagePanel:InitGenerate__15(Root, data)
--[[
	BtnRoot/Btn2/Lock
--]]
	local tmp = Root:Find("BtnRoot/Btn2/Lock").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.btn2.lock = tmp


end

---@private
function TechnologyTreePagePanel:InitGenerate__16(Root, data)
--[[
	BtnRoot/Btn2/Lock/LockTip
--]]
	local tmp = Root:Find("BtnRoot/Btn2/Lock/LockTip").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.btn2.lockTip = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function TechnologyTreePagePanel:InitGenerate__17(Root, data)
--[[
	BtnRoot/Btn3
--]]
	local tmp = Root:Find("BtnRoot/Btn3").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.btn3 = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("TechnologyTreePagePanel_btn3")
			if self.btn3_ScaleButton_onClick then
				self:btn3_ScaleButton_onClick(self.btn3)
			end
		end)

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function TechnologyTreePagePanel:InitGenerate__18(Root, data)
--[[
	BtnRoot/Btn3/Normal
--]]
	local tmp = Root:Find("BtnRoot/Btn3/Normal").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.btn3.normal = tmp


end

---@private
function TechnologyTreePagePanel:InitGenerate__19(Root, data)
--[[
	BtnRoot/Btn3/Normal/RedPoint
--]]
	local tmp = Root:Find("BtnRoot/Btn3/Normal/RedPoint").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.btn3.redPoint = tmp


end

---@private
function TechnologyTreePagePanel:InitGenerate__20(Root, data)
--[[
	BtnRoot/Btn3/Lock
--]]
	local tmp = Root:Find("BtnRoot/Btn3/Lock").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.btn3.lock = tmp


end

---@private
function TechnologyTreePagePanel:InitGenerate__21(Root, data)
--[[
	BtnRoot/Btn3/Lock/LockTip
--]]
	local tmp = Root:Find("BtnRoot/Btn3/Lock/LockTip").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.btn3.lockTip = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function TechnologyTreePagePanel:InitGenerate__22(Root, data)
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
function TechnologyTreePagePanel:InitGenerate__23(Root, data)
--[[
	UserGuidePanel
--]]
	local tmp = Root:Find("UserGuidePanel").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.userGuidePanel = tmp

	tmp.userGuidePanel = tmp:AddComponentLua("UserGuidePanel", data)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function TechnologyTreePagePanel:SetLocalizedText(Root)

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return TechnologyTreePagePanel