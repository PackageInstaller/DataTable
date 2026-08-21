---@class SkinPanel_Generate_planarReflectionRenderer
---@field public gameObject UnityEngine.GameObject
---@field public planarReflectionController PlanarReflectionController

---@class SkinPanel_Generate_rolePoint
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform

---@class SkinPanel_Generate_objCamera
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public camera UnityEngine.Camera

---@class SkinPanel_Generate_camPoint
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform

---@class SkinPanel_Generate_animBox_animNameTxt
---@field public gameObject UnityEngine.GameObject
---@field public text UnityEngine.UI.Text

---@class SkinPanel_Generate_animBox_animIcon
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image
---@field public canvasGroup UnityEngine.CanvasGroup

---@class SkinPanel_Generate_animBox_isSelect
---@field public gameObject UnityEngine.GameObject
---@field public canvasGroup UnityEngine.CanvasGroup

---@class SkinPanel_Generate_animBox
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public canvasGroup UnityEngine.CanvasGroup
---@field public isSelect SkinPanel_Generate_animBox_isSelect
---@field public animIcon SkinPanel_Generate_animBox_animIcon
---@field public animNameTxt SkinPanel_Generate_animBox_animNameTxt

---@class SkinPanel_Generate_customSkinBox_roleIconImg
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class SkinPanel_Generate_customSkinBox_btn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public canvasGroup UnityEngine.CanvasGroup

---@class SkinPanel_Generate_customSkinBox
---@field public gameObject UnityEngine.GameObject
---@field public btn SkinPanel_Generate_customSkinBox_btn
---@field public roleIconImg SkinPanel_Generate_customSkinBox_roleIconImg
---@field public isLock UnityEngine.GameObject
---@field public isSelect UnityEngine.GameObject
---@field public isEquip UnityEngine.GameObject

---@class SkinPanel_Generate_tagBox_tagTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class SkinPanel_Generate_tagBox
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image
---@field public tagTxt SkinPanel_Generate_tagBox_tagTxt

---@class SkinPanel_Generate_customBackPanel
---@field public gameObject UnityEngine.GameObject
---@field public customBackPanel CustomBackPanel

---@class SkinPanel_Generate_skinMsgTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class SkinPanel_Generate_changeBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class SkinPanel_Generate_nullTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class SkinPanel_Generate_bar
---@field public gameObject UnityEngine.GameObject
---@field public scrollbar UnityEngine.UI.Scrollbar

---@class SkinPanel_Generate_isHasCountTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class SkinPanel_Generate_skinNameTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class SkinPanel_Generate_nameTxt
---@field public gameObject UnityEngine.GameObject
---@field public text UnityEngine.UI.Text

---@class SkinPanel_Generate_changeModeBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class SkinPanel_Generate_showBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class SkinPanel_Generate_showCharacter_skinImg
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public image UnityEngine.UI.Image

---@class SkinPanel_Generate_showCharacter
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public canvasGroup UnityEngine.CanvasGroup
---@field public skinImg SkinPanel_Generate_showCharacter_skinImg
---@field public spineRoot UnityEngine.GameObject

---@class SkinPanel_Generate_skinMode
---@field public gameObject UnityEngine.GameObject
---@field public canvasGroup UnityEngine.CanvasGroup

---@class SkinPanel_Generate_animObj
---@field public gameObject UnityEngine.GameObject
---@field public rawImage UnityEngine.UI.RawImage

---@class SkinPanel_Generate_modelMode
---@field public gameObject UnityEngine.GameObject
---@field public canvasGroup UnityEngine.CanvasGroup

---@class SkinPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public modelMode SkinPanel_Generate_modelMode
---@field public animObj SkinPanel_Generate_animObj
---@field public animList UnityEngine.GameObject
---@field public skinMode SkinPanel_Generate_skinMode
---@field public showCharacter SkinPanel_Generate_showCharacter
---@field public showBtn SkinPanel_Generate_showBtn
---@field public changeModeBtn SkinPanel_Generate_changeModeBtn
---@field public nameTxt SkinPanel_Generate_nameTxt
---@field public skinNameTxt SkinPanel_Generate_skinNameTxt
---@field public isHasCountTxt SkinPanel_Generate_isHasCountTxt
---@field public tagList UnityEngine.GameObject
---@field public content UnityEngine.GameObject
---@field public bar SkinPanel_Generate_bar
---@field public isEquip UnityEngine.GameObject
---@field public isNull UnityEngine.GameObject
---@field public nullTxt SkinPanel_Generate_nullTxt
---@field public changeBtn SkinPanel_Generate_changeBtn
---@field public skinMsgTxt SkinPanel_Generate_skinMsgTxt
---@field public customBackPanel SkinPanel_Generate_customBackPanel
---@field public tagBox SkinPanel_Generate_tagBox
---@field public customSkinBox SkinPanel_Generate_customSkinBox
---@field public animBox SkinPanel_Generate_animBox
---@field public camPoint SkinPanel_Generate_camPoint
---@field public objCamera SkinPanel_Generate_objCamera
---@field public rolePoint SkinPanel_Generate_rolePoint
---@field public showBg UnityEngine.GameObject
---@field public planarReflectionRenderer SkinPanel_Generate_planarReflectionRenderer
local SkinPanel = class("SkinPanel", require("WndBase"))

function SkinPanel:ctor(data)
end

---@private
function SkinPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("SkinPanel")

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
	self:InitGenerate__34(Root,data)
	self:InitGenerate__35(Root,data)
	self:InitGenerate__36(Root,data)
	self:InitGenerate__37(Root,data)
	self:InitGenerate__38(Root,data)
	self:InitGenerate__39(Root,data)

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function SkinPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function SkinPanel:InitGenerate__2(Root, data)
--[[
	ModelMode
--]]
	local tmp = Root:Find("ModelMode").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.modelMode = tmp

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function SkinPanel:InitGenerate__3(Root, data)
--[[
	ModelMode/AnimObj
--]]
	local tmp = Root:Find("ModelMode/AnimObj").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.animObj = tmp

	tmp.rawImage = tmp:GetComponent(TypeInfo.RawImage)


end

---@private
function SkinPanel:InitGenerate__4(Root, data)
--[[
	ModelMode/AnimBg/Scroll View/Viewport/AnimList
--]]
	local tmp = Root:Find("ModelMode/AnimBg/Scroll View/Viewport/AnimList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.animList = tmp


end

---@private
function SkinPanel:InitGenerate__5(Root, data)
--[[
	SkinMode
--]]
	local tmp = Root:Find("SkinMode").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.skinMode = tmp

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function SkinPanel:InitGenerate__6(Root, data)
--[[
	SkinMode/ShowCharacter
--]]
	local tmp = Root:Find("SkinMode/ShowCharacter").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.showCharacter = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function SkinPanel:InitGenerate__7(Root, data)
--[[
	SkinMode/ShowCharacter/SkinImg
--]]
	local tmp = Root:Find("SkinMode/ShowCharacter/SkinImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.showCharacter.skinImg = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function SkinPanel:InitGenerate__8(Root, data)
--[[
	SkinMode/ShowCharacter/SpineRoot
--]]
	local tmp = Root:Find("SkinMode/ShowCharacter/SpineRoot").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.showCharacter.spineRoot = tmp


end

---@private
function SkinPanel:InitGenerate__9(Root, data)
--[[
	AdjustRoot/BtnList/ShowBtn
--]]
	local tmp = Root:Find("AdjustRoot/BtnList/ShowBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.showBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("SkinPanel_showBtn")
			if self.showBtn_ScaleButton_onClick then
				self:showBtn_ScaleButton_onClick(self.showBtn)
			end
		end)


end

---@private
function SkinPanel:InitGenerate__10(Root, data)
--[[
	AdjustRoot/BtnList/ChangeModeBtn
--]]
	local tmp = Root:Find("AdjustRoot/BtnList/ChangeModeBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.changeModeBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("SkinPanel_changeModeBtn")
			if self.changeModeBtn_ScaleButton_onClick then
				self:changeModeBtn_ScaleButton_onClick(self.changeModeBtn)
			end
		end)


end

---@private
function SkinPanel:InitGenerate__11(Root, data)
--[[
	AdjustRoot/MsgView/NameBg/NameTxt
--]]
	local tmp = Root:Find("AdjustRoot/MsgView/NameBg/NameTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.nameTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.Text)


end

---@private
function SkinPanel:InitGenerate__12(Root, data)
--[[
	AdjustRoot/MsgView/SkinNameBg/SkinNameTxt
--]]
	local tmp = Root:Find("AdjustRoot/MsgView/SkinNameBg/SkinNameTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.skinNameTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function SkinPanel:InitGenerate__13(Root, data)
--[[
	AdjustRoot/MsgView/IsHasBg/IsHasCountTxt
--]]
	local tmp = Root:Find("AdjustRoot/MsgView/IsHasBg/IsHasCountTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.isHasCountTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function SkinPanel:InitGenerate__14(Root, data)
--[[
	AdjustRoot/MsgView/TagList
--]]
	local tmp = Root:Find("AdjustRoot/MsgView/TagList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.tagList = tmp


end

---@private
function SkinPanel:InitGenerate__15(Root, data)
--[[
	AdjustRoot/MsgView/SkinBoxList/Viewport/Content
--]]
	local tmp = Root:Find("AdjustRoot/MsgView/SkinBoxList/Viewport/Content").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.content = tmp


end

---@private
function SkinPanel:InitGenerate__16(Root, data)
--[[
	AdjustRoot/MsgView/SkinBoxList/bar
--]]
	local tmp = Root:Find("AdjustRoot/MsgView/SkinBoxList/bar").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.bar = tmp

	tmp.scrollbar = tmp:GetComponent(TypeInfo.Scrollbar)


end

---@private
function SkinPanel:InitGenerate__17(Root, data)
--[[
	AdjustRoot/MsgView/IsEquip
--]]
	local tmp = Root:Find("AdjustRoot/MsgView/IsEquip").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.isEquip = tmp


end

---@private
function SkinPanel:InitGenerate__18(Root, data)
--[[
	AdjustRoot/MsgView/IsNull
--]]
	local tmp = Root:Find("AdjustRoot/MsgView/IsNull").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.isNull = tmp


end

---@private
function SkinPanel:InitGenerate__19(Root, data)
--[[
	AdjustRoot/MsgView/IsNull/NullTxt
--]]
	local tmp = Root:Find("AdjustRoot/MsgView/IsNull/NullTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.nullTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function SkinPanel:InitGenerate__20(Root, data)
--[[
	AdjustRoot/MsgView/ChangeBtn
--]]
	local tmp = Root:Find("AdjustRoot/MsgView/ChangeBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.changeBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("SkinPanel_changeBtn")
			if self.changeBtn_ScaleButton_onClick then
				self:changeBtn_ScaleButton_onClick(self.changeBtn)
			end
		end)


end

---@private
function SkinPanel:InitGenerate__21(Root, data)
--[[
	AdjustRoot/MsgView/Scroll View/Viewport/SkinMsgTxt
--]]
	local tmp = Root:Find("AdjustRoot/MsgView/Scroll View/Viewport/SkinMsgTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.skinMsgTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function SkinPanel:InitGenerate__22(Root, data)
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
function SkinPanel:InitGenerate__23(Root, data)
--[[
	Custom/TagBox
--]]
	local tmp = Root:Find("Custom/TagBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.tagBox = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function SkinPanel:InitGenerate__24(Root, data)
--[[
	Custom/TagBox/TagTxt
--]]
	local tmp = Root:Find("Custom/TagBox/TagTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.tagBox.tagTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function SkinPanel:InitGenerate__25(Root, data)
--[[
	Custom/CustomSkinBox
--]]
	local tmp = Root:Find("Custom/CustomSkinBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.customSkinBox = tmp


end

---@private
function SkinPanel:InitGenerate__26(Root, data)
--[[
	Custom/CustomSkinBox/btn
--]]
	local tmp = Root:Find("Custom/CustomSkinBox/btn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.customSkinBox.btn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function SkinPanel:InitGenerate__27(Root, data)
--[[
	Custom/CustomSkinBox/btn/RoleIconMask/RoleIconImg
--]]
	local tmp = Root:Find("Custom/CustomSkinBox/btn/RoleIconMask/RoleIconImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.customSkinBox.roleIconImg = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function SkinPanel:InitGenerate__28(Root, data)
--[[
	Custom/CustomSkinBox/btn/IsLock
--]]
	local tmp = Root:Find("Custom/CustomSkinBox/btn/IsLock").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.customSkinBox.isLock = tmp


end

---@private
function SkinPanel:InitGenerate__29(Root, data)
--[[
	Custom/CustomSkinBox/btn/IsSelect
--]]
	local tmp = Root:Find("Custom/CustomSkinBox/btn/IsSelect").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.customSkinBox.isSelect = tmp


end

---@private
function SkinPanel:InitGenerate__30(Root, data)
--[[
	Custom/CustomSkinBox/btn/IsEquip
--]]
	local tmp = Root:Find("Custom/CustomSkinBox/btn/IsEquip").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.customSkinBox.isEquip = tmp


end

---@private
function SkinPanel:InitGenerate__31(Root, data)
--[[
	Custom/AnimBox
--]]
	local tmp = Root:Find("Custom/AnimBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.animBox = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function SkinPanel:InitGenerate__32(Root, data)
--[[
	Custom/AnimBox/IsSelect
--]]
	local tmp = Root:Find("Custom/AnimBox/IsSelect").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.animBox.isSelect = tmp

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function SkinPanel:InitGenerate__33(Root, data)
--[[
	Custom/AnimBox/AnimIcon
--]]
	local tmp = Root:Find("Custom/AnimBox/AnimIcon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.animBox.animIcon = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function SkinPanel:InitGenerate__34(Root, data)
--[[
	Custom/AnimBox/AnimNameBg/AnimNameTxt
--]]
	local tmp = Root:Find("Custom/AnimBox/AnimNameBg/AnimNameTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.animBox.animNameTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.Text)


end

---@private
function SkinPanel:InitGenerate__35(Root, data)
--[[
	Custom/CamPoint
--]]
	local tmp = Root:Find("Custom/CamPoint").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.camPoint = tmp

	tmp.transform = tmp:GetComponent(TypeInfo.Transform)


end

---@private
function SkinPanel:InitGenerate__36(Root, data)
--[[
	Custom/CamPoint/ObjCamera
--]]
	local tmp = Root:Find("Custom/CamPoint/ObjCamera").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.objCamera = tmp

	tmp.transform = tmp:GetComponent(TypeInfo.Transform)

	tmp.camera = tmp:GetComponent(TypeInfo.Camera)


end

---@private
function SkinPanel:InitGenerate__37(Root, data)
--[[
	Custom/RolePoint
--]]
	local tmp = Root:Find("Custom/RolePoint").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rolePoint = tmp

	tmp.transform = tmp:GetComponent(TypeInfo.Transform)


end

---@private
function SkinPanel:InitGenerate__38(Root, data)
--[[
	Custom/RolePoint/ShowBg
--]]
	local tmp = Root:Find("Custom/RolePoint/ShowBg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.showBg = tmp


end

---@private
function SkinPanel:InitGenerate__39(Root, data)
--[[
	Custom/Planar Reflection Renderer
--]]
	local tmp = Root:Find("Custom/Planar Reflection Renderer").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.planarReflectionRenderer = tmp

	tmp.planarReflectionController = tmp:GetComponent(TypeInfo.PlanarReflectionController)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function SkinPanel:SetLocalizedText(Root)

    local locObj_SkinPanel_Txt = Root:Find("AdjustRoot/MsgView/IsHasBg/Txt")
    if locObj_SkinPanel_Txt then
        locObj_SkinPanel_Txt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.SkinPanel_Txt
    end

    local locObj_SkinPanel_MaxTips = Root:Find("AdjustRoot/MsgView/IsEquip/MaxTips")
    if locObj_SkinPanel_MaxTips then
        locObj_SkinPanel_MaxTips.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.SkinPanel_MaxTips
    end

    local locObj_SkinPanel_txt = Root:Find("AdjustRoot/MsgView/ChangeBtn/txt")
    if locObj_SkinPanel_txt then
        locObj_SkinPanel_txt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.SkinPanel_txt
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return SkinPanel