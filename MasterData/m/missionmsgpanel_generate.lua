---@class MissionMsgPanel_Generate_achievementBox_finishTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class MissionMsgPanel_Generate_achievementBox_tittleTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class MissionMsgPanel_Generate_achievementBox
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public canvasGroup UnityEngine.CanvasGroup
---@field public tittleTxt MissionMsgPanel_Generate_achievementBox_tittleTxt
---@field public finishTxt MissionMsgPanel_Generate_achievementBox_finishTxt

---@class MissionMsgPanel_Generate_normalBox_finishTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class MissionMsgPanel_Generate_normalBox_tittleTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class MissionMsgPanel_Generate_normalBox_typeBg5
---@field public gameObject UnityEngine.GameObject
---@field public canvasGroup UnityEngine.CanvasGroup

---@class MissionMsgPanel_Generate_normalBox_typeBg2
---@field public gameObject UnityEngine.GameObject
---@field public canvasGroup UnityEngine.CanvasGroup

---@class MissionMsgPanel_Generate_normalBox_typeBg1
---@field public gameObject UnityEngine.GameObject
---@field public canvasGroup UnityEngine.CanvasGroup

---@class MissionMsgPanel_Generate_normalBox
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public canvasGroup UnityEngine.CanvasGroup
---@field public typeBg1 MissionMsgPanel_Generate_normalBox_typeBg1
---@field public typeBg2 MissionMsgPanel_Generate_normalBox_typeBg2
---@field public typeBg5 MissionMsgPanel_Generate_normalBox_typeBg5
---@field public tittleTxt MissionMsgPanel_Generate_normalBox_tittleTxt
---@field public finishTxt MissionMsgPanel_Generate_normalBox_finishTxt

---@class MissionMsgPanel_Generate_mask
---@field public gameObject UnityEngine.GameObject
---@field public canvasGroup UnityEngine.CanvasGroup

---@class MissionMsgPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public mask MissionMsgPanel_Generate_mask
---@field public normalBox MissionMsgPanel_Generate_normalBox
---@field public achievementBox MissionMsgPanel_Generate_achievementBox
local MissionMsgPanel = class("MissionMsgPanel", require("ToastBase"))

function MissionMsgPanel:ctor(data)
end

---@private
function MissionMsgPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("MissionMsgPanel")

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

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function MissionMsgPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function MissionMsgPanel:InitGenerate__2(Root, data)
--[[
	Mask
--]]
	local tmp = Root:Find("Mask").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.mask = tmp

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function MissionMsgPanel:InitGenerate__3(Root, data)
--[[
	NormalBox
--]]
	local tmp = Root:Find("NormalBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.normalBox = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function MissionMsgPanel:InitGenerate__4(Root, data)
--[[
	NormalBox/TypeBg1
--]]
	local tmp = Root:Find("NormalBox/TypeBg1").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.normalBox.typeBg1 = tmp

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function MissionMsgPanel:InitGenerate__5(Root, data)
--[[
	NormalBox/TypeBg2
--]]
	local tmp = Root:Find("NormalBox/TypeBg2").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.normalBox.typeBg2 = tmp

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function MissionMsgPanel:InitGenerate__6(Root, data)
--[[
	NormalBox/TypeBg5
--]]
	local tmp = Root:Find("NormalBox/TypeBg5").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.normalBox.typeBg5 = tmp

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function MissionMsgPanel:InitGenerate__7(Root, data)
--[[
	NormalBox/TittleTxt
--]]
	local tmp = Root:Find("NormalBox/TittleTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.normalBox.tittleTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function MissionMsgPanel:InitGenerate__8(Root, data)
--[[
	NormalBox/FinishTxt
--]]
	local tmp = Root:Find("NormalBox/FinishTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.normalBox.finishTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function MissionMsgPanel:InitGenerate__9(Root, data)
--[[
	AchievementBox
--]]
	local tmp = Root:Find("AchievementBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.achievementBox = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function MissionMsgPanel:InitGenerate__10(Root, data)
--[[
	AchievementBox/TitleBg/TittleTxt
--]]
	local tmp = Root:Find("AchievementBox/TitleBg/TittleTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.achievementBox.tittleTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function MissionMsgPanel:InitGenerate__11(Root, data)
--[[
	AchievementBox/FinishTxt
--]]
	local tmp = Root:Find("AchievementBox/FinishTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.achievementBox.finishTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function MissionMsgPanel:SetLocalizedText(Root)

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return MissionMsgPanel