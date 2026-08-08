---@class UserPanel_Generate_gMBtn
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class UserPanel_Generate_eixtGameBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class UserPanel_Generate_shareBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class UserPanel_Generate_helperBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class UserPanel_Generate_communityBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class UserPanel_Generate_codeBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class UserPanel_Generate_brithdayView_value
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class UserPanel_Generate_brithdayView
---@field public gameObject UnityEngine.GameObject
---@field public value UserPanel_Generate_brithdayView_value

---@class UserPanel_Generate_loginDayView_value
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class UserPanel_Generate_loginDayView
---@field public gameObject UnityEngine.GameObject
---@field public value UserPanel_Generate_loginDayView_value

---@class UserPanel_Generate_registerView_value
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class UserPanel_Generate_registerView
---@field public gameObject UnityEngine.GameObject
---@field public value UserPanel_Generate_registerView_value

---@class UserPanel_Generate_battleMsgTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class UserPanel_Generate_shipCountTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class UserPanel_Generate_changeSignBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class UserPanel_Generate_signTxt
---@field public gameObject UnityEngine.GameObject
---@field public text UnityEngine.UI.Text

---@class UserPanel_Generate_copyBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class UserPanel_Generate_uidTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class UserPanel_Generate_expSlider
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class UserPanel_Generate_expTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class UserPanel_Generate_levelTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class UserPanel_Generate_changeNameBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class UserPanel_Generate_userNameTxt
---@field public gameObject UnityEngine.GameObject
---@field public text UnityEngine.UI.Text

---@class UserPanel_Generate_changeHeadBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class UserPanel_Generate_headBox_headIconImg
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image
---@field public canvasGroup UnityEngine.CanvasGroup

---@class UserPanel_Generate_headBox
---@field public gameObject UnityEngine.GameObject
---@field public headIconImg UserPanel_Generate_headBox_headIconImg

---@class UserPanel_Generate_customBackPanel
---@field public gameObject UnityEngine.GameObject
---@field public customBackPanel CustomBackPanel

---@class UserPanel_Generate_showCharacter_skinImg
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public image UnityEngine.UI.Image

---@class UserPanel_Generate_showCharacter
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public canvasGroup UnityEngine.CanvasGroup
---@field public skinImg UserPanel_Generate_showCharacter_skinImg
---@field public spineRoot UnityEngine.GameObject

---@class UserPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public showCharacter UserPanel_Generate_showCharacter
---@field public customBackPanel UserPanel_Generate_customBackPanel
---@field public headBox UserPanel_Generate_headBox
---@field public changeHeadBtn UserPanel_Generate_changeHeadBtn
---@field public userNameTxt UserPanel_Generate_userNameTxt
---@field public changeNameBtn UserPanel_Generate_changeNameBtn
---@field public levelTxt UserPanel_Generate_levelTxt
---@field public expTxt UserPanel_Generate_expTxt
---@field public expSlider UserPanel_Generate_expSlider
---@field public uidTxt UserPanel_Generate_uidTxt
---@field public copyBtn UserPanel_Generate_copyBtn
---@field public signTxt UserPanel_Generate_signTxt
---@field public changeSignBtn UserPanel_Generate_changeSignBtn
---@field public shipCountTxt UserPanel_Generate_shipCountTxt
---@field public battleMsgTxt UserPanel_Generate_battleMsgTxt
---@field public registerView UserPanel_Generate_registerView
---@field public loginDayView UserPanel_Generate_loginDayView
---@field public brithdayView UserPanel_Generate_brithdayView
---@field public codeBtn UserPanel_Generate_codeBtn
---@field public communityBtn UserPanel_Generate_communityBtn
---@field public helperBtn UserPanel_Generate_helperBtn
---@field public shareBtn UserPanel_Generate_shareBtn
---@field public eixtGameBtn UserPanel_Generate_eixtGameBtn
---@field public gMBtn UserPanel_Generate_gMBtn
local UserPanel = class("UserPanel", require("WndBase"))

function UserPanel:ctor(data)
end

---@private
function UserPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("UserPanel")

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

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function UserPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function UserPanel:InitGenerate__2(Root, data)
--[[
	ShowCharacter
--]]
	local tmp = Root:Find("ShowCharacter").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.showCharacter = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function UserPanel:InitGenerate__3(Root, data)
--[[
	ShowCharacter/SkinImg
--]]
	local tmp = Root:Find("ShowCharacter/SkinImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.showCharacter.skinImg = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function UserPanel:InitGenerate__4(Root, data)
--[[
	ShowCharacter/SpineRoot
--]]
	local tmp = Root:Find("ShowCharacter/SpineRoot").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.showCharacter.spineRoot = tmp


end

---@private
function UserPanel:InitGenerate__5(Root, data)
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
function UserPanel:InitGenerate__6(Root, data)
--[[
	AdjustRoot/UserMsgPanel/HeadBox
--]]
	local tmp = Root:Find("AdjustRoot/UserMsgPanel/HeadBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.headBox = tmp


end

---@private
function UserPanel:InitGenerate__7(Root, data)
--[[
	AdjustRoot/UserMsgPanel/HeadBox/mask/HeadIconImg
--]]
	local tmp = Root:Find("AdjustRoot/UserMsgPanel/HeadBox/mask/HeadIconImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.headBox.headIconImg = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function UserPanel:InitGenerate__8(Root, data)
--[[
	AdjustRoot/UserMsgPanel/HeadBox/ChangeHeadBtn
--]]
	local tmp = Root:Find("AdjustRoot/UserMsgPanel/HeadBox/ChangeHeadBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.changeHeadBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("UserPanel_changeHeadBtn")
			if self.changeHeadBtn_ScaleButton_onClick then
				self:changeHeadBtn_ScaleButton_onClick(self.changeHeadBtn)
			end
		end)


end

---@private
function UserPanel:InitGenerate__9(Root, data)
--[[
	AdjustRoot/UserMsgPanel/UserNameTxt
--]]
	local tmp = Root:Find("AdjustRoot/UserMsgPanel/UserNameTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.userNameTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.Text)


end

---@private
function UserPanel:InitGenerate__10(Root, data)
--[[
	AdjustRoot/UserMsgPanel/ChangeNameBtn
--]]
	local tmp = Root:Find("AdjustRoot/UserMsgPanel/ChangeNameBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.changeNameBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("UserPanel_changeNameBtn")
			if self.changeNameBtn_ScaleButton_onClick then
				self:changeNameBtn_ScaleButton_onClick(self.changeNameBtn)
			end
		end)


end

---@private
function UserPanel:InitGenerate__11(Root, data)
--[[
	AdjustRoot/UserMsgPanel/LevelView/LevelTxt
--]]
	local tmp = Root:Find("AdjustRoot/UserMsgPanel/LevelView/LevelTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.levelTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function UserPanel:InitGenerate__12(Root, data)
--[[
	AdjustRoot/UserMsgPanel/LevelView/ExpTxt
--]]
	local tmp = Root:Find("AdjustRoot/UserMsgPanel/LevelView/ExpTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.expTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function UserPanel:InitGenerate__13(Root, data)
--[[
	AdjustRoot/UserMsgPanel/LevelView/ExpSliderBg/ExpSlider
--]]
	local tmp = Root:Find("AdjustRoot/UserMsgPanel/LevelView/ExpSliderBg/ExpSlider").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.expSlider = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function UserPanel:InitGenerate__14(Root, data)
--[[
	AdjustRoot/UserMsgPanel/UidBg/UidTxt
--]]
	local tmp = Root:Find("AdjustRoot/UserMsgPanel/UidBg/UidTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.uidTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function UserPanel:InitGenerate__15(Root, data)
--[[
	AdjustRoot/UserMsgPanel/UidBg/CopyBtn
--]]
	local tmp = Root:Find("AdjustRoot/UserMsgPanel/UidBg/CopyBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.copyBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("UserPanel_copyBtn")
			if self.copyBtn_ScaleButton_onClick then
				self:copyBtn_ScaleButton_onClick(self.copyBtn)
			end
		end)


end

---@private
function UserPanel:InitGenerate__16(Root, data)
--[[
	AdjustRoot/UserMsgPanel/SignBg/SignTxt
--]]
	local tmp = Root:Find("AdjustRoot/UserMsgPanel/SignBg/SignTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.signTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.Text)


end

---@private
function UserPanel:InitGenerate__17(Root, data)
--[[
	AdjustRoot/UserMsgPanel/SignBg/ChangeSignBtn
--]]
	local tmp = Root:Find("AdjustRoot/UserMsgPanel/SignBg/ChangeSignBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.changeSignBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("UserPanel_changeSignBtn")
			if self.changeSignBtn_ScaleButton_onClick then
				self:changeSignBtn_ScaleButton_onClick(self.changeSignBtn)
			end
		end)


end

---@private
function UserPanel:InitGenerate__18(Root, data)
--[[
	AdjustRoot/UserMsgPanel/ShipCountBg/ShipCountTxt
--]]
	local tmp = Root:Find("AdjustRoot/UserMsgPanel/ShipCountBg/ShipCountTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.shipCountTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function UserPanel:InitGenerate__19(Root, data)
--[[
	AdjustRoot/UserMsgPanel/BattleMsgBg/BattleMsgTxt
--]]
	local tmp = Root:Find("AdjustRoot/UserMsgPanel/BattleMsgBg/BattleMsgTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.battleMsgTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function UserPanel:InitGenerate__20(Root, data)
--[[
	AdjustRoot/UserMsgPanel/RegisterView
--]]
	local tmp = Root:Find("AdjustRoot/UserMsgPanel/RegisterView").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.registerView = tmp


end

---@private
function UserPanel:InitGenerate__21(Root, data)
--[[
	AdjustRoot/UserMsgPanel/RegisterView/Value
--]]
	local tmp = Root:Find("AdjustRoot/UserMsgPanel/RegisterView/Value").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.registerView.value = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function UserPanel:InitGenerate__22(Root, data)
--[[
	AdjustRoot/UserMsgPanel/LoginDayView
--]]
	local tmp = Root:Find("AdjustRoot/UserMsgPanel/LoginDayView").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.loginDayView = tmp


end

---@private
function UserPanel:InitGenerate__23(Root, data)
--[[
	AdjustRoot/UserMsgPanel/LoginDayView/Value
--]]
	local tmp = Root:Find("AdjustRoot/UserMsgPanel/LoginDayView/Value").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.loginDayView.value = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function UserPanel:InitGenerate__24(Root, data)
--[[
	AdjustRoot/UserMsgPanel/BrithdayView
--]]
	local tmp = Root:Find("AdjustRoot/UserMsgPanel/BrithdayView").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.brithdayView = tmp


end

---@private
function UserPanel:InitGenerate__25(Root, data)
--[[
	AdjustRoot/UserMsgPanel/BrithdayView/Value
--]]
	local tmp = Root:Find("AdjustRoot/UserMsgPanel/BrithdayView/Value").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.brithdayView.value = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function UserPanel:InitGenerate__26(Root, data)
--[[
	AdjustRoot/UserMsgPanel/BtnList/CodeBtn
--]]
	local tmp = Root:Find("AdjustRoot/UserMsgPanel/BtnList/CodeBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.codeBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("UserPanel_codeBtn")
			if self.codeBtn_ScaleButton_onClick then
				self:codeBtn_ScaleButton_onClick(self.codeBtn)
			end
		end)


end

---@private
function UserPanel:InitGenerate__27(Root, data)
--[[
	AdjustRoot/UserMsgPanel/BtnList/CommunityBtn
--]]
	local tmp = Root:Find("AdjustRoot/UserMsgPanel/BtnList/CommunityBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.communityBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("UserPanel_communityBtn")
			if self.communityBtn_ScaleButton_onClick then
				self:communityBtn_ScaleButton_onClick(self.communityBtn)
			end
		end)


end

---@private
function UserPanel:InitGenerate__28(Root, data)
--[[
	AdjustRoot/UserMsgPanel/BtnList/HelperBtn
--]]
	local tmp = Root:Find("AdjustRoot/UserMsgPanel/BtnList/HelperBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.helperBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("UserPanel_helperBtn")
			if self.helperBtn_ScaleButton_onClick then
				self:helperBtn_ScaleButton_onClick(self.helperBtn)
			end
		end)


end

---@private
function UserPanel:InitGenerate__29(Root, data)
--[[
	AdjustRoot/UserMsgPanel/BtnList/ShareBtn
--]]
	local tmp = Root:Find("AdjustRoot/UserMsgPanel/BtnList/ShareBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.shareBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("UserPanel_shareBtn")
			if self.shareBtn_ScaleButton_onClick then
				self:shareBtn_ScaleButton_onClick(self.shareBtn)
			end
		end)


end

---@private
function UserPanel:InitGenerate__30(Root, data)
--[[
	AdjustRoot/EixtGameBtn
--]]
	local tmp = Root:Find("AdjustRoot/EixtGameBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.eixtGameBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("UserPanel_eixtGameBtn")
			if self.eixtGameBtn_ScaleButton_onClick then
				self:eixtGameBtn_ScaleButton_onClick(self.eixtGameBtn)
			end
		end)


end

---@private
function UserPanel:InitGenerate__31(Root, data)
--[[
	GMBtn
--]]
	local tmp = Root:Find("GMBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.gMBtn = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("UserPanel_gMBtn")
			if self.gMBtn_Button_onClick then
				self:gMBtn_Button_onClick(self.gMBtn)
			end
		end)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function UserPanel:SetLocalizedText(Root)

    local locObj_UserPanel_txt = Root:Find("AdjustRoot/UserMsgPanel/LevelView/LevelTxt/txt")
    if locObj_UserPanel_txt then
        locObj_UserPanel_txt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.UserPanel_txt
    end

    local locObj_UserPanel_ShipCountTitle = Root:Find("AdjustRoot/UserMsgPanel/ShipCountBg/ShipCountTitle")
    if locObj_UserPanel_ShipCountTitle then
        locObj_UserPanel_ShipCountTitle.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.UserPanel_ShipCountTitle
    end

    local locObj_UserPanel_BattleMsgTitle = Root:Find("AdjustRoot/UserMsgPanel/BattleMsgBg/BattleMsgTitle")
    if locObj_UserPanel_BattleMsgTitle then
        locObj_UserPanel_BattleMsgTitle.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.UserPanel_BattleMsgTitle
    end

    local locObj_UserPanel_Title = Root:Find("AdjustRoot/UserMsgPanel/RegisterView/Title")
    if locObj_UserPanel_Title then
        locObj_UserPanel_Title.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.UserPanel_Title
    end

    local locObj_UserPanel_Lw_Title = Root:Find("AdjustRoot/UserMsgPanel/LoginDayView/Title")
    if locObj_UserPanel_Lw_Title then
        locObj_UserPanel_Lw_Title.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.UserPanel_Lw_Title
    end

    local locObj_UserPanel_Bw_Title = Root:Find("AdjustRoot/UserMsgPanel/BrithdayView/Title")
    if locObj_UserPanel_Bw_Title then
        locObj_UserPanel_Bw_Title.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.UserPanel_Bw_Title
    end

    local locObj_UserPanel_Ng_txt = Root:Find("AdjustRoot/UserMsgPanel/BtnList/CodeBtn/NameBg/txt")
    if locObj_UserPanel_Ng_txt then
        locObj_UserPanel_Ng_txt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.UserPanel_Ng_txt
    end

    local locObj_UserPanel_Cn_Ng_txt = Root:Find("AdjustRoot/UserMsgPanel/BtnList/CommunityBtn/NameBg/txt")
    if locObj_UserPanel_Cn_Ng_txt then
        locObj_UserPanel_Cn_Ng_txt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.UserPanel_Cn_Ng_txt
    end

    local locObj_UserPanel_Hn_Ng_txt = Root:Find("AdjustRoot/UserMsgPanel/BtnList/HelperBtn/NameBg/txt")
    if locObj_UserPanel_Hn_Ng_txt then
        locObj_UserPanel_Hn_Ng_txt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.UserPanel_Hn_Ng_txt
    end

    local locObj_UserPanel_Sn_Ng_txt = Root:Find("AdjustRoot/UserMsgPanel/BtnList/ShareBtn/NameBg/txt")
    if locObj_UserPanel_Sn_Ng_txt then
        locObj_UserPanel_Sn_Ng_txt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.UserPanel_Sn_Ng_txt
    end

    local locObj_UserPanel_TextTMP = Root:Find("AdjustRoot/EixtGameBtn/Image/Text (TMP)")
    if locObj_UserPanel_TextTMP then
        locObj_UserPanel_TextTMP.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.UserPanel_TextTMP
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return UserPanel