---@class QuestionPanel_Generate_rewardRt_reward
---@field public gameObject UnityEngine.GameObject
---@field public customBox CustomBox

---@class QuestionPanel_Generate_rewardRt
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public reward QuestionPanel_Generate_rewardRt_reward

---@class QuestionPanel_Generate_typeBtn_isSelect_typeTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class QuestionPanel_Generate_typeBtn_isSelect
---@field public gameObject UnityEngine.GameObject
---@field public typeTxt QuestionPanel_Generate_typeBtn_isSelect_typeTxt

---@class QuestionPanel_Generate_typeBtn_typeTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class QuestionPanel_Generate_typeBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public typeOff UnityEngine.GameObject
---@field public typeTxt QuestionPanel_Generate_typeBtn_typeTxt
---@field public isSelect QuestionPanel_Generate_typeBtn_isSelect
---@field public red UnityEngine.GameObject

---@class QuestionPanel_Generate_customMsgPanel
---@field public gameObject UnityEngine.GameObject
---@field public customMsgPanel CustomMsgPanel

---@class QuestionPanel_Generate_rewardedBtn_btnNametxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class QuestionPanel_Generate_rewardedBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public btnNametxt QuestionPanel_Generate_rewardedBtn_btnNametxt

---@class QuestionPanel_Generate_goWebBtn_btnNametxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class QuestionPanel_Generate_goWebBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public btnNametxt QuestionPanel_Generate_goWebBtn_btnNametxt

---@class QuestionPanel_Generate_getRewardBtn_btnNametxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class QuestionPanel_Generate_getRewardBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public btnNametxt QuestionPanel_Generate_getRewardBtn_btnNametxt

---@class QuestionPanel_Generate_activeTimeText
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public text UnityEngine.UI.Text

---@class QuestionPanel_Generate_itemRoot
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public horizontalLayoutGroup UnityEngine.UI.HorizontalLayoutGroup

---@class QuestionPanel_Generate_togglePanel
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public verticalLayoutGroup UnityEngine.UI.VerticalLayoutGroup

---@class QuestionPanel_Generate_tipsTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class QuestionPanel_Generate_titlebg
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class QuestionPanel_Generate_mask
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class QuestionPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public rectTransform UnityEngine.RectTransform
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public mask QuestionPanel_Generate_mask
---@field public titlebg QuestionPanel_Generate_titlebg
---@field public tipsTxt QuestionPanel_Generate_tipsTxt
---@field public togglePanel QuestionPanel_Generate_togglePanel
---@field public itemRoot QuestionPanel_Generate_itemRoot
---@field public activeTimeText QuestionPanel_Generate_activeTimeText
---@field public getRewardBtn QuestionPanel_Generate_getRewardBtn
---@field public goWebBtn QuestionPanel_Generate_goWebBtn
---@field public rewardedBtn QuestionPanel_Generate_rewardedBtn
---@field public customMsgPanel QuestionPanel_Generate_customMsgPanel
---@field public typeBtn QuestionPanel_Generate_typeBtn
---@field public rewardRt QuestionPanel_Generate_rewardRt
local QuestionPanel = class("QuestionPanel", require("WndBase"))

function QuestionPanel:ctor(data)
end

---@private
function QuestionPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("QuestionPanel")

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

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function QuestionPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.rectTransform = Root:GetComponent(TypeInfo.RectTransform)

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function QuestionPanel:InitGenerate__2(Root, data)
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
		UIMgr:SendUiUseMessage("QuestionPanel_mask")
			if self.mask_Button_onClick then
				self:mask_Button_onClick(self.mask)
			end
		end)


end

---@private
function QuestionPanel:InitGenerate__3(Root, data)
--[[
	BoxBg/titlebg
--]]
	local tmp = Root:Find("BoxBg/titlebg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.titlebg = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function QuestionPanel:InitGenerate__4(Root, data)
--[[
	BoxBg/titlebg/TipsTxt
--]]
	local tmp = Root:Find("BoxBg/titlebg/TipsTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.tipsTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function QuestionPanel:InitGenerate__5(Root, data)
--[[
	BoxBg/TogglePanel
--]]
	local tmp = Root:Find("BoxBg/TogglePanel").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.togglePanel = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.verticalLayoutGroup = tmp:GetComponent(TypeInfo.VerticalLayoutGroup)


end

---@private
function QuestionPanel:InitGenerate__6(Root, data)
--[[
	BoxBg/ItemRoot
--]]
	local tmp = Root:Find("BoxBg/ItemRoot").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.itemRoot = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.horizontalLayoutGroup = tmp:GetComponent(TypeInfo.HorizontalLayoutGroup)


end

---@private
function QuestionPanel:InitGenerate__7(Root, data)
--[[
	BoxBg/activeTimeRoot/activeTimeText
--]]
	local tmp = Root:Find("BoxBg/activeTimeRoot/activeTimeText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.activeTimeText = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.text = tmp:GetComponent(TypeInfo.Text)


end

---@private
function QuestionPanel:InitGenerate__8(Root, data)
--[[
	BoxBg/questingBtnGroup/getRewardBtn
--]]
	local tmp = Root:Find("BoxBg/questingBtnGroup/getRewardBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.getRewardBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("QuestionPanel_getRewardBtn")
			if self.getRewardBtn_ScaleButton_onClick then
				self:getRewardBtn_ScaleButton_onClick(self.getRewardBtn)
			end
		end)


end

---@private
function QuestionPanel:InitGenerate__9(Root, data)
--[[
	BoxBg/questingBtnGroup/getRewardBtn/btnNametxt
--]]
	local tmp = Root:Find("BoxBg/questingBtnGroup/getRewardBtn/btnNametxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.getRewardBtn.btnNametxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function QuestionPanel:InitGenerate__10(Root, data)
--[[
	BoxBg/questingBtnGroup/goWebBtn
--]]
	local tmp = Root:Find("BoxBg/questingBtnGroup/goWebBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.goWebBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("QuestionPanel_goWebBtn")
			if self.goWebBtn_ScaleButton_onClick then
				self:goWebBtn_ScaleButton_onClick(self.goWebBtn)
			end
		end)


end

---@private
function QuestionPanel:InitGenerate__11(Root, data)
--[[
	BoxBg/questingBtnGroup/goWebBtn/btnNametxt
--]]
	local tmp = Root:Find("BoxBg/questingBtnGroup/goWebBtn/btnNametxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.goWebBtn.btnNametxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function QuestionPanel:InitGenerate__12(Root, data)
--[[
	BoxBg/questingBtnGroup/rewardedBtn
--]]
	local tmp = Root:Find("BoxBg/questingBtnGroup/rewardedBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardedBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("QuestionPanel_rewardedBtn")
			if self.rewardedBtn_ScaleButton_onClick then
				self:rewardedBtn_ScaleButton_onClick(self.rewardedBtn)
			end
		end)


end

---@private
function QuestionPanel:InitGenerate__13(Root, data)
--[[
	BoxBg/questingBtnGroup/rewardedBtn/btnNametxt
--]]
	local tmp = Root:Find("BoxBg/questingBtnGroup/rewardedBtn/btnNametxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardedBtn.btnNametxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function QuestionPanel:InitGenerate__14(Root, data)
--[[
	CustomMsgPanel
--]]
	local tmp = Root:Find("CustomMsgPanel").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.customMsgPanel = tmp

	tmp.customMsgPanel = tmp:AddComponentLua("CustomMsgPanel", data)


end

---@private
function QuestionPanel:InitGenerate__15(Root, data)
--[[
	Custom/TypeBtn
--]]
	local tmp = Root:Find("Custom/TypeBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.typeBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("QuestionPanel_typeBtn")
			if self.typeBtn_ScaleButton_onClick then
				self:typeBtn_ScaleButton_onClick(self.typeBtn)
			end
		end)


end

---@private
function QuestionPanel:InitGenerate__16(Root, data)
--[[
	Custom/TypeBtn/TypeOff
--]]
	local tmp = Root:Find("Custom/TypeBtn/TypeOff").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.typeBtn.typeOff = tmp


end

---@private
function QuestionPanel:InitGenerate__17(Root, data)
--[[
	Custom/TypeBtn/TypeOff/TypeTxt
--]]
	local tmp = Root:Find("Custom/TypeBtn/TypeOff/TypeTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.typeBtn.typeTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function QuestionPanel:InitGenerate__18(Root, data)
--[[
	Custom/TypeBtn/IsSelect
--]]
	local tmp = Root:Find("Custom/TypeBtn/IsSelect").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.typeBtn.isSelect = tmp


end

---@private
function QuestionPanel:InitGenerate__19(Root, data)
--[[
	Custom/TypeBtn/IsSelect/TypeTxt
--]]
	local tmp = Root:Find("Custom/TypeBtn/IsSelect/TypeTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.typeBtn.isSelect.typeTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function QuestionPanel:InitGenerate__20(Root, data)
--[[
	Custom/TypeBtn/Red
--]]
	local tmp = Root:Find("Custom/TypeBtn/Red").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.typeBtn.red = tmp


end

---@private
function QuestionPanel:InitGenerate__21(Root, data)
--[[
	Custom/rewardRt
--]]
	local tmp = Root:Find("Custom/rewardRt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardRt = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function QuestionPanel:InitGenerate__22(Root, data)
--[[
	Custom/rewardRt/reward
--]]
	local tmp = Root:Find("Custom/rewardRt/reward").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardRt.reward = tmp

	tmp.customBox = tmp:AddComponentLua("CustomBox", data)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function QuestionPanel:SetLocalizedText(Root)

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return QuestionPanel