---@class AffectionEventPanel_Generate_affectionExpTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class AffectionEventPanel_Generate_affectionLevelTxt
---@field public gameObject UnityEngine.GameObject
---@field public text UnityEngine.UI.Text

---@class AffectionEventPanel_Generate_bottomPart
---@field public gameObject UnityEngine.GameObject
---@field public canvasGroup UnityEngine.CanvasGroup

---@class AffectionEventPanel_Generate_affectionExp
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class AffectionEventPanel_Generate_affectionLevelUp
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public image UnityEngine.UI.Image
---@field public canvasGroup UnityEngine.CanvasGroup
---@field public effect UnityEngine.GameObject

---@class AffectionEventPanel_Generate_eventBtn_3_confirmBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public canvasGroup UnityEngine.CanvasGroup

---@class AffectionEventPanel_Generate_eventBtn_3_exitBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public canvasGroup UnityEngine.CanvasGroup

---@class AffectionEventPanel_Generate_eventBtn_3_eventChoseTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class AffectionEventPanel_Generate_eventBtn_3
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public canvasGroup UnityEngine.CanvasGroup
---@field public eventChoseTxt AffectionEventPanel_Generate_eventBtn_3_eventChoseTxt
---@field public exitBtn AffectionEventPanel_Generate_eventBtn_3_exitBtn
---@field public confirmBtn AffectionEventPanel_Generate_eventBtn_3_confirmBtn
---@field public pressImage UnityEngine.GameObject

---@class AffectionEventPanel_Generate_eventBtn_2_confirmBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public canvasGroup UnityEngine.CanvasGroup

---@class AffectionEventPanel_Generate_eventBtn_2_exitBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public canvasGroup UnityEngine.CanvasGroup

---@class AffectionEventPanel_Generate_eventBtn_2_eventChoseTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class AffectionEventPanel_Generate_eventBtn_2
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public canvasGroup UnityEngine.CanvasGroup
---@field public eventChoseTxt AffectionEventPanel_Generate_eventBtn_2_eventChoseTxt
---@field public exitBtn AffectionEventPanel_Generate_eventBtn_2_exitBtn
---@field public confirmBtn AffectionEventPanel_Generate_eventBtn_2_confirmBtn
---@field public pressImage UnityEngine.GameObject

---@class AffectionEventPanel_Generate_eventBtn_1_confirmBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public canvasGroup UnityEngine.CanvasGroup

---@class AffectionEventPanel_Generate_eventBtn_1_exitBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public canvasGroup UnityEngine.CanvasGroup

---@class AffectionEventPanel_Generate_eventBtn_1_eventChoseTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class AffectionEventPanel_Generate_eventBtn_1
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public canvasGroup UnityEngine.CanvasGroup
---@field public eventChoseTxt AffectionEventPanel_Generate_eventBtn_1_eventChoseTxt
---@field public exitBtn AffectionEventPanel_Generate_eventBtn_1_exitBtn
---@field public confirmBtn AffectionEventPanel_Generate_eventBtn_1_confirmBtn
---@field public pressImage UnityEngine.GameObject

---@class AffectionEventPanel_Generate_optionBtnList
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class AffectionEventPanel_Generate_eventMsgTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class AffectionEventPanel_Generate_eventTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class AffectionEventPanel_Generate_dialogueInfo
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class AffectionEventPanel_Generate_showCharacter_skinImg
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public image UnityEngine.UI.Image

---@class AffectionEventPanel_Generate_showCharacter
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public canvasGroup UnityEngine.CanvasGroup
---@field public skinImg AffectionEventPanel_Generate_showCharacter_skinImg
---@field public spineRoot UnityEngine.GameObject

---@class AffectionEventPanel_Generate_mask
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class AffectionEventPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public mask AffectionEventPanel_Generate_mask
---@field public showCharacter AffectionEventPanel_Generate_showCharacter
---@field public dialogueInfo AffectionEventPanel_Generate_dialogueInfo
---@field public eventTxt AffectionEventPanel_Generate_eventTxt
---@field public eventMsgTxt AffectionEventPanel_Generate_eventMsgTxt
---@field public optionBtnList AffectionEventPanel_Generate_optionBtnList
---@field public pos_1 UnityEngine.GameObject
---@field public pos_2 UnityEngine.GameObject
---@field public pos_3 UnityEngine.GameObject
---@field public eventBtn_1 AffectionEventPanel_Generate_eventBtn_1
---@field public eventBtn_2 AffectionEventPanel_Generate_eventBtn_2
---@field public eventBtn_3 AffectionEventPanel_Generate_eventBtn_3
---@field public affectionLevelUp AffectionEventPanel_Generate_affectionLevelUp
---@field public affectionExp AffectionEventPanel_Generate_affectionExp
---@field public bottomPart AffectionEventPanel_Generate_bottomPart
---@field public affectionLevelTxt AffectionEventPanel_Generate_affectionLevelTxt
---@field public affectionExpTxt AffectionEventPanel_Generate_affectionExpTxt
local AffectionEventPanel = class("AffectionEventPanel", require("WndBase"))

function AffectionEventPanel:ctor(data)
end

---@private
function AffectionEventPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("AffectionEventPanel")

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
	self:InitGenerate__24(Root,data)
	self:InitGenerate__25(Root,data)
	self:InitGenerate__26(Root,data)
	self:InitGenerate__27(Root,data)
	self:InitGenerate__28(Root,data)
	self:InitGenerate__29(Root,data)
	self:InitGenerate__30(Root,data)
	self:InitGenerate__31(Root,data)
	self:InitGenerate__32(Root,data)
	self:InitGenerate__33(Root,data)

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function AffectionEventPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function AffectionEventPanel:InitGenerate__2(Root, data)
--[[
	AdjustRoot/Mask
--]]
	local tmp = Root:Find("AdjustRoot/Mask").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.mask = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("AffectionEventPanel_mask")
			if self.mask_Button_onClick then
				self:mask_Button_onClick(self.mask)
			end
		end)


end

---@private
function AffectionEventPanel:InitGenerate__3(Root, data)
--[[
	AdjustRoot/RoleBg/ShowCharacter
--]]
	local tmp = Root:Find("AdjustRoot/RoleBg/ShowCharacter").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.showCharacter = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function AffectionEventPanel:InitGenerate__4(Root, data)
--[[
	AdjustRoot/RoleBg/ShowCharacter/SkinImg
--]]
	local tmp = Root:Find("AdjustRoot/RoleBg/ShowCharacter/SkinImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.showCharacter.skinImg = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function AffectionEventPanel:InitGenerate__5(Root, data)
--[[
	AdjustRoot/RoleBg/ShowCharacter/SpineRoot
--]]
	local tmp = Root:Find("AdjustRoot/RoleBg/ShowCharacter/SpineRoot").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.showCharacter.spineRoot = tmp


end

---@private
function AffectionEventPanel:InitGenerate__6(Root, data)
--[[
	AdjustRoot/dialogueInfo
--]]
	local tmp = Root:Find("AdjustRoot/dialogueInfo").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.dialogueInfo = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function AffectionEventPanel:InitGenerate__7(Root, data)
--[[
	AdjustRoot/dialogueInfo/EventTxt
--]]
	local tmp = Root:Find("AdjustRoot/dialogueInfo/EventTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.eventTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function AffectionEventPanel:InitGenerate__8(Root, data)
--[[
	AdjustRoot/dialogueInfo/MsgView/Viewport/EventMsgTxt
--]]
	local tmp = Root:Find("AdjustRoot/dialogueInfo/MsgView/Viewport/EventMsgTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.eventMsgTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function AffectionEventPanel:InitGenerate__9(Root, data)
--[[
	AdjustRoot/optionBtnList
--]]
	local tmp = Root:Find("AdjustRoot/optionBtnList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.optionBtnList = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function AffectionEventPanel:InitGenerate__10(Root, data)
--[[
	AdjustRoot/optionBtnList/Pos_1
--]]
	local tmp = Root:Find("AdjustRoot/optionBtnList/Pos_1").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.pos_1 = tmp


end

---@private
function AffectionEventPanel:InitGenerate__11(Root, data)
--[[
	AdjustRoot/optionBtnList/Pos_2
--]]
	local tmp = Root:Find("AdjustRoot/optionBtnList/Pos_2").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.pos_2 = tmp


end

---@private
function AffectionEventPanel:InitGenerate__12(Root, data)
--[[
	AdjustRoot/optionBtnList/Pos_3
--]]
	local tmp = Root:Find("AdjustRoot/optionBtnList/Pos_3").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.pos_3 = tmp


end

---@private
function AffectionEventPanel:InitGenerate__13(Root, data)
--[[
	AdjustRoot/optionBtnList/EventBtn_1
--]]
	local tmp = Root:Find("AdjustRoot/optionBtnList/EventBtn_1").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.eventBtn_1 = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function AffectionEventPanel:InitGenerate__14(Root, data)
--[[
	AdjustRoot/optionBtnList/EventBtn_1/bg/EventChoseTxt
--]]
	local tmp = Root:Find("AdjustRoot/optionBtnList/EventBtn_1/bg/EventChoseTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.eventBtn_1.eventChoseTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function AffectionEventPanel:InitGenerate__15(Root, data)
--[[
	AdjustRoot/optionBtnList/EventBtn_1/bg/ExitBtn
--]]
	local tmp = Root:Find("AdjustRoot/optionBtnList/EventBtn_1/bg/ExitBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.eventBtn_1.exitBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function AffectionEventPanel:InitGenerate__16(Root, data)
--[[
	AdjustRoot/optionBtnList/EventBtn_1/bg/ConfirmBtn
--]]
	local tmp = Root:Find("AdjustRoot/optionBtnList/EventBtn_1/bg/ConfirmBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.eventBtn_1.confirmBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function AffectionEventPanel:InitGenerate__17(Root, data)
--[[
	AdjustRoot/optionBtnList/EventBtn_1/bg/pressImage
--]]
	local tmp = Root:Find("AdjustRoot/optionBtnList/EventBtn_1/bg/pressImage").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.eventBtn_1.pressImage = tmp


end

---@private
function AffectionEventPanel:InitGenerate__18(Root, data)
--[[
	AdjustRoot/optionBtnList/EventBtn_2
--]]
	local tmp = Root:Find("AdjustRoot/optionBtnList/EventBtn_2").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.eventBtn_2 = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function AffectionEventPanel:InitGenerate__19(Root, data)
--[[
	AdjustRoot/optionBtnList/EventBtn_2/bg/EventChoseTxt
--]]
	local tmp = Root:Find("AdjustRoot/optionBtnList/EventBtn_2/bg/EventChoseTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.eventBtn_2.eventChoseTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function AffectionEventPanel:InitGenerate__20(Root, data)
--[[
	AdjustRoot/optionBtnList/EventBtn_2/bg/ExitBtn
--]]
	local tmp = Root:Find("AdjustRoot/optionBtnList/EventBtn_2/bg/ExitBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.eventBtn_2.exitBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function AffectionEventPanel:InitGenerate__21(Root, data)
--[[
	AdjustRoot/optionBtnList/EventBtn_2/bg/ConfirmBtn
--]]
	local tmp = Root:Find("AdjustRoot/optionBtnList/EventBtn_2/bg/ConfirmBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.eventBtn_2.confirmBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function AffectionEventPanel:InitGenerate__22(Root, data)
--[[
	AdjustRoot/optionBtnList/EventBtn_2/bg/pressImage
--]]
	local tmp = Root:Find("AdjustRoot/optionBtnList/EventBtn_2/bg/pressImage").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.eventBtn_2.pressImage = tmp


end

---@private
function AffectionEventPanel:InitGenerate__23(Root, data)
--[[
	AdjustRoot/optionBtnList/EventBtn_3
--]]
	local tmp = Root:Find("AdjustRoot/optionBtnList/EventBtn_3").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.eventBtn_3 = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function AffectionEventPanel:InitGenerate__24(Root, data)
--[[
	AdjustRoot/optionBtnList/EventBtn_3/bg/EventChoseTxt
--]]
	local tmp = Root:Find("AdjustRoot/optionBtnList/EventBtn_3/bg/EventChoseTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.eventBtn_3.eventChoseTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function AffectionEventPanel:InitGenerate__25(Root, data)
--[[
	AdjustRoot/optionBtnList/EventBtn_3/bg/ExitBtn
--]]
	local tmp = Root:Find("AdjustRoot/optionBtnList/EventBtn_3/bg/ExitBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.eventBtn_3.exitBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function AffectionEventPanel:InitGenerate__26(Root, data)
--[[
	AdjustRoot/optionBtnList/EventBtn_3/bg/ConfirmBtn
--]]
	local tmp = Root:Find("AdjustRoot/optionBtnList/EventBtn_3/bg/ConfirmBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.eventBtn_3.confirmBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function AffectionEventPanel:InitGenerate__27(Root, data)
--[[
	AdjustRoot/optionBtnList/EventBtn_3/bg/pressImage
--]]
	local tmp = Root:Find("AdjustRoot/optionBtnList/EventBtn_3/bg/pressImage").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.eventBtn_3.pressImage = tmp


end

---@private
function AffectionEventPanel:InitGenerate__28(Root, data)
--[[
	AdjustRoot/AffectionLevelUp
--]]
	local tmp = Root:Find("AdjustRoot/AffectionLevelUp").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.affectionLevelUp = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.image = tmp:GetComponent(TypeInfo.Image)

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function AffectionEventPanel:InitGenerate__29(Root, data)
--[[
	AdjustRoot/AffectionLevelUp/AffectionExp
--]]
	local tmp = Root:Find("AdjustRoot/AffectionLevelUp/AffectionExp").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.affectionExp = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function AffectionEventPanel:InitGenerate__30(Root, data)
--[[
	AdjustRoot/AffectionLevelUp/bottomPart
--]]
	local tmp = Root:Find("AdjustRoot/AffectionLevelUp/bottomPart").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.bottomPart = tmp

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function AffectionEventPanel:InitGenerate__31(Root, data)
--[[
	AdjustRoot/AffectionLevelUp/bottomPart/AffectionLevelTxt
--]]
	local tmp = Root:Find("AdjustRoot/AffectionLevelUp/bottomPart/AffectionLevelTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.affectionLevelTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.Text)


end

---@private
function AffectionEventPanel:InitGenerate__32(Root, data)
--[[
	AdjustRoot/AffectionLevelUp/bottomPart/AffectionExpBg/AffectionExpTxt
--]]
	local tmp = Root:Find("AdjustRoot/AffectionLevelUp/bottomPart/AffectionExpBg/AffectionExpTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.affectionExpTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function AffectionEventPanel:InitGenerate__33(Root, data)
--[[
	AdjustRoot/AffectionLevelUp/effect
--]]
	local tmp = Root:Find("AdjustRoot/AffectionLevelUp/effect").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.affectionLevelUp.effect = tmp


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function AffectionEventPanel:SetLocalizedText(Root)

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return AffectionEventPanel