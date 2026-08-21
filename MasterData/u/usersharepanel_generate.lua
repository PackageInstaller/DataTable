---@class UserSharePanel_Generate_downBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class UserSharePanel_Generate_closeBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class UserSharePanel_Generate_tiktokFriendBtn
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public scaleButton ScaleButton

---@class UserSharePanel_Generate_tiktokBtn
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public scaleButton ScaleButton

---@class UserSharePanel_Generate_qqBtn
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public scaleButton ScaleButton

---@class UserSharePanel_Generate_weChatFriendBtn
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public scaleButton ScaleButton

---@class UserSharePanel_Generate_weChatBtn
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public scaleButton ScaleButton

---@class UserSharePanel_Generate_weiBoBtn
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public scaleButton ScaleButton

---@class UserSharePanel_Generate_mainBattleTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class UserSharePanel_Generate_mainBattleTitle
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class UserSharePanel_Generate_shipCountTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class UserSharePanel_Generate_shipCountTitle
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class UserSharePanel_Generate_userUIdTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class UserSharePanel_Generate_userNameTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class UserSharePanel_Generate_headIconImg
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image
---@field public canvasGroup UnityEngine.CanvasGroup

---@class UserSharePanel_Generate_showCharacter_skinImg
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public image UnityEngine.UI.Image

---@class UserSharePanel_Generate_showCharacter
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public canvasGroup UnityEngine.CanvasGroup
---@field public skinImg UserSharePanel_Generate_showCharacter_skinImg
---@field public spineRoot UnityEngine.GameObject

---@class UserSharePanel_Generate_shareArea
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class UserSharePanel_Generate_tipsRewardNum
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class UserSharePanel_Generate_tipsRewardIcon
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class UserSharePanel_Generate_bg
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public image UnityEngine.UI.Image

---@class UserSharePanel_Generate_mask
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class UserSharePanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public mask UserSharePanel_Generate_mask
---@field public bg UserSharePanel_Generate_bg
---@field public tipsRewardIcon UserSharePanel_Generate_tipsRewardIcon
---@field public tipsRewardNum UserSharePanel_Generate_tipsRewardNum
---@field public shareArea UserSharePanel_Generate_shareArea
---@field public showCharacter UserSharePanel_Generate_showCharacter
---@field public headIconImg UserSharePanel_Generate_headIconImg
---@field public userNameTxt UserSharePanel_Generate_userNameTxt
---@field public userUIdTxt UserSharePanel_Generate_userUIdTxt
---@field public shipCountTitle UserSharePanel_Generate_shipCountTitle
---@field public shipCountTxt UserSharePanel_Generate_shipCountTxt
---@field public mainBattleTitle UserSharePanel_Generate_mainBattleTitle
---@field public mainBattleTxt UserSharePanel_Generate_mainBattleTxt
---@field public weiBoBtn UserSharePanel_Generate_weiBoBtn
---@field public weChatBtn UserSharePanel_Generate_weChatBtn
---@field public weChatFriendBtn UserSharePanel_Generate_weChatFriendBtn
---@field public qqBtn UserSharePanel_Generate_qqBtn
---@field public tiktokBtn UserSharePanel_Generate_tiktokBtn
---@field public tiktokFriendBtn UserSharePanel_Generate_tiktokFriendBtn
---@field public closeBtn UserSharePanel_Generate_closeBtn
---@field public downBtn UserSharePanel_Generate_downBtn
local UserSharePanel = class("UserSharePanel", require("WndBase"))

function UserSharePanel:ctor(data)
end

---@private
function UserSharePanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("UserSharePanel")

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

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function UserSharePanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function UserSharePanel:InitGenerate__2(Root, data)
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
		UIMgr:SendUiUseMessage("UserSharePanel_mask")
			if self.mask_Button_onClick then
				self:mask_Button_onClick(self.mask)
			end
		end)


end

---@private
function UserSharePanel:InitGenerate__3(Root, data)
--[[
	Bg
--]]
	local tmp = Root:Find("Bg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.bg = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function UserSharePanel:InitGenerate__4(Root, data)
--[[
	Bg/ShareTipsBg/TipsRewardIcon
--]]
	local tmp = Root:Find("Bg/ShareTipsBg/TipsRewardIcon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.tipsRewardIcon = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function UserSharePanel:InitGenerate__5(Root, data)
--[[
	Bg/ShareTipsBg/TipsRewardNum
--]]
	local tmp = Root:Find("Bg/ShareTipsBg/TipsRewardNum").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.tipsRewardNum = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function UserSharePanel:InitGenerate__6(Root, data)
--[[
	shareArea
--]]
	local tmp = Root:Find("shareArea").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.shareArea = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function UserSharePanel:InitGenerate__7(Root, data)
--[[
	SceneIconMask/ShowCharacter
--]]
	local tmp = Root:Find("SceneIconMask/ShowCharacter").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.showCharacter = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function UserSharePanel:InitGenerate__8(Root, data)
--[[
	SceneIconMask/ShowCharacter/SkinImg
--]]
	local tmp = Root:Find("SceneIconMask/ShowCharacter/SkinImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.showCharacter.skinImg = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function UserSharePanel:InitGenerate__9(Root, data)
--[[
	SceneIconMask/ShowCharacter/SpineRoot
--]]
	local tmp = Root:Find("SceneIconMask/ShowCharacter/SpineRoot").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.showCharacter.spineRoot = tmp


end

---@private
function UserSharePanel:InitGenerate__10(Root, data)
--[[
	HeadIconMask/HeadIconImg
--]]
	local tmp = Root:Find("HeadIconMask/HeadIconImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.headIconImg = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function UserSharePanel:InitGenerate__11(Root, data)
--[[
	UserNameTxt
--]]
	local tmp = Root:Find("UserNameTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.userNameTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function UserSharePanel:InitGenerate__12(Root, data)
--[[
	UserUIdTxt
--]]
	local tmp = Root:Find("UserUIdTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.userUIdTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function UserSharePanel:InitGenerate__13(Root, data)
--[[
	ShipCountBg/ShipCountTitle
--]]
	local tmp = Root:Find("ShipCountBg/ShipCountTitle").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.shipCountTitle = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function UserSharePanel:InitGenerate__14(Root, data)
--[[
	ShipCountBg/ShipCountTxt
--]]
	local tmp = Root:Find("ShipCountBg/ShipCountTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.shipCountTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function UserSharePanel:InitGenerate__15(Root, data)
--[[
	MainBattleBg/MainBattleTitle
--]]
	local tmp = Root:Find("MainBattleBg/MainBattleTitle").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.mainBattleTitle = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function UserSharePanel:InitGenerate__16(Root, data)
--[[
	MainBattleBg/MainBattleTxt
--]]
	local tmp = Root:Find("MainBattleBg/MainBattleTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.mainBattleTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function UserSharePanel:InitGenerate__17(Root, data)
--[[
	ShareGroup/WeiBoBtn
--]]
	local tmp = Root:Find("ShareGroup/WeiBoBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.weiBoBtn = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("UserSharePanel_weiBoBtn")
			if self.weiBoBtn_ScaleButton_onClick then
				self:weiBoBtn_ScaleButton_onClick(self.weiBoBtn)
			end
		end)


end

---@private
function UserSharePanel:InitGenerate__18(Root, data)
--[[
	ShareGroup/WeChatBtn
--]]
	local tmp = Root:Find("ShareGroup/WeChatBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.weChatBtn = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("UserSharePanel_weChatBtn")
			if self.weChatBtn_ScaleButton_onClick then
				self:weChatBtn_ScaleButton_onClick(self.weChatBtn)
			end
		end)


end

---@private
function UserSharePanel:InitGenerate__19(Root, data)
--[[
	ShareGroup/WeChatFriendBtn
--]]
	local tmp = Root:Find("ShareGroup/WeChatFriendBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.weChatFriendBtn = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("UserSharePanel_weChatFriendBtn")
			if self.weChatFriendBtn_ScaleButton_onClick then
				self:weChatFriendBtn_ScaleButton_onClick(self.weChatFriendBtn)
			end
		end)


end

---@private
function UserSharePanel:InitGenerate__20(Root, data)
--[[
	ShareGroup/qqBtn
--]]
	local tmp = Root:Find("ShareGroup/qqBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.qqBtn = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("UserSharePanel_qqBtn")
			if self.qqBtn_ScaleButton_onClick then
				self:qqBtn_ScaleButton_onClick(self.qqBtn)
			end
		end)


end

---@private
function UserSharePanel:InitGenerate__21(Root, data)
--[[
	ShareGroup/TiktokBtn
--]]
	local tmp = Root:Find("ShareGroup/TiktokBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.tiktokBtn = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("UserSharePanel_tiktokBtn")
			if self.tiktokBtn_ScaleButton_onClick then
				self:tiktokBtn_ScaleButton_onClick(self.tiktokBtn)
			end
		end)


end

---@private
function UserSharePanel:InitGenerate__22(Root, data)
--[[
	ShareGroup/TiktokFriendBtn
--]]
	local tmp = Root:Find("ShareGroup/TiktokFriendBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.tiktokFriendBtn = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("UserSharePanel_tiktokFriendBtn")
			if self.tiktokFriendBtn_ScaleButton_onClick then
				self:tiktokFriendBtn_ScaleButton_onClick(self.tiktokFriendBtn)
			end
		end)


end

---@private
function UserSharePanel:InitGenerate__23(Root, data)
--[[
	CloseBtn
--]]
	local tmp = Root:Find("CloseBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.closeBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("UserSharePanel_closeBtn")
			if self.closeBtn_ScaleButton_onClick then
				self:closeBtn_ScaleButton_onClick(self.closeBtn)
			end
		end)


end

---@private
function UserSharePanel:InitGenerate__24(Root, data)
--[[
	downBtn
--]]
	local tmp = Root:Find("downBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.downBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("UserSharePanel_downBtn")
			if self.downBtn_ScaleButton_onClick then
				self:downBtn_ScaleButton_onClick(self.downBtn)
			end
		end)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function UserSharePanel:SetLocalizedText(Root)

    local locObj_UserSharePanel_TipsTxt = Root:Find("Bg/ShareTipsBg/TipsTxt")
    if locObj_UserSharePanel_TipsTxt then
        locObj_UserSharePanel_TipsTxt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.UserSharePanel_TipsTxt
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return UserSharePanel