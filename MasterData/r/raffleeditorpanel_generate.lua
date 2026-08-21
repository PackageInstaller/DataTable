---@class RaffleEditorPanel_Generate_nowcount
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class RaffleEditorPanel_Generate_sRPro
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class RaffleEditorPanel_Generate_sSRPro
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class RaffleEditorPanel_Generate_limitPro
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class RaffleEditorPanel_Generate_timeLineTestBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class RaffleEditorPanel_Generate_charIdInputField
---@field public gameObject UnityEngine.GameObject
---@field public inputField UnityEngine.UI.InputField

---@class RaffleEditorPanel_Generate_resultBox_numberTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class RaffleEditorPanel_Generate_resultBox_iDTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class RaffleEditorPanel_Generate_resultBox_nameTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class RaffleEditorPanel_Generate_resultBox
---@field public gameObject UnityEngine.GameObject
---@field public nameTxt RaffleEditorPanel_Generate_resultBox_nameTxt
---@field public iDTxt RaffleEditorPanel_Generate_resultBox_iDTxt
---@field public numberTxt RaffleEditorPanel_Generate_resultBox_numberTxt

---@class RaffleEditorPanel_Generate_nowPoolText
---@field public gameObject UnityEngine.GameObject
---@field public text UnityEngine.UI.Text

---@class RaffleEditorPanel_Generate_testBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class RaffleEditorPanel_Generate_mask
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class RaffleEditorPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public mask RaffleEditorPanel_Generate_mask
---@field public testBtn RaffleEditorPanel_Generate_testBtn
---@field public nowPoolText RaffleEditorPanel_Generate_nowPoolText
---@field public resultBg UnityEngine.GameObject
---@field public resultBox RaffleEditorPanel_Generate_resultBox
---@field public charIdInputField RaffleEditorPanel_Generate_charIdInputField
---@field public timeLineTestBtn RaffleEditorPanel_Generate_timeLineTestBtn
---@field public limitPro RaffleEditorPanel_Generate_limitPro
---@field public sSRPro RaffleEditorPanel_Generate_sSRPro
---@field public sRPro RaffleEditorPanel_Generate_sRPro
---@field public nowcount RaffleEditorPanel_Generate_nowcount
local RaffleEditorPanel = class("RaffleEditorPanel", require("WndBase"))

function RaffleEditorPanel:ctor(data)
end

---@private
function RaffleEditorPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("RaffleEditorPanel")

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
function RaffleEditorPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function RaffleEditorPanel:InitGenerate__2(Root, data)
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
		UIMgr:SendUiUseMessage("RaffleEditorPanel_mask")
			if self.mask_Button_onClick then
				self:mask_Button_onClick(self.mask)
			end
		end)


end

---@private
function RaffleEditorPanel:InitGenerate__3(Root, data)
--[[
	TestBtn
--]]
	local tmp = Root:Find("TestBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.testBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("RaffleEditorPanel_testBtn")
			if self.testBtn_ScaleButton_onClick then
				self:testBtn_ScaleButton_onClick(self.testBtn)
			end
		end)


end

---@private
function RaffleEditorPanel:InitGenerate__4(Root, data)
--[[
	NowPoolID/NowPoolText
--]]
	local tmp = Root:Find("NowPoolID/NowPoolText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.nowPoolText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.Text)


end

---@private
function RaffleEditorPanel:InitGenerate__5(Root, data)
--[[
	ResultBg
--]]
	local tmp = Root:Find("ResultBg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.resultBg = tmp


end

---@private
function RaffleEditorPanel:InitGenerate__6(Root, data)
--[[
	ResultBg/ResultBox
--]]
	local tmp = Root:Find("ResultBg/ResultBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.resultBox = tmp


end

---@private
function RaffleEditorPanel:InitGenerate__7(Root, data)
--[[
	ResultBg/ResultBox/NameTxt
--]]
	local tmp = Root:Find("ResultBg/ResultBox/NameTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.resultBox.nameTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function RaffleEditorPanel:InitGenerate__8(Root, data)
--[[
	ResultBg/ResultBox/IDTxt
--]]
	local tmp = Root:Find("ResultBg/ResultBox/IDTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.resultBox.iDTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function RaffleEditorPanel:InitGenerate__9(Root, data)
--[[
	ResultBg/ResultBox/NumberTxt
--]]
	local tmp = Root:Find("ResultBg/ResultBox/NumberTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.resultBox.numberTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function RaffleEditorPanel:InitGenerate__10(Root, data)
--[[
	TimeLineTestBg/Text5/CharIdInputField
--]]
	local tmp = Root:Find("TimeLineTestBg/Text5/CharIdInputField").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.charIdInputField = tmp

	tmp.inputField = tmp:GetComponent(TypeInfo.InputField)
	tmp.inputField.onEndEdit:RemoveAllListeners()
	tmp.inputField.onEndEdit:AddListener(function (content)
			if self.charIdInputField_InputField_onEndEdit then
				self:charIdInputField_InputField_onEndEdit(self.charIdInputField,content)
			end
		end)


end

---@private
function RaffleEditorPanel:InitGenerate__11(Root, data)
--[[
	TimeLineTestBg/TimeLineTestBtn
--]]
	local tmp = Root:Find("TimeLineTestBg/TimeLineTestBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.timeLineTestBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("RaffleEditorPanel_timeLineTestBtn")
			if self.timeLineTestBtn_ScaleButton_onClick then
				self:timeLineTestBtn_ScaleButton_onClick(self.timeLineTestBtn)
			end
		end)


end

---@private
function RaffleEditorPanel:InitGenerate__12(Root, data)
--[[
	ProbabilityBg/Text1/LimitPro
--]]
	local tmp = Root:Find("ProbabilityBg/Text1/LimitPro").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.limitPro = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function RaffleEditorPanel:InitGenerate__13(Root, data)
--[[
	ProbabilityBg/Text2/SSRPro
--]]
	local tmp = Root:Find("ProbabilityBg/Text2/SSRPro").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.sSRPro = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function RaffleEditorPanel:InitGenerate__14(Root, data)
--[[
	ProbabilityBg/Text3/SRPro
--]]
	local tmp = Root:Find("ProbabilityBg/Text3/SRPro").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.sRPro = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function RaffleEditorPanel:InitGenerate__15(Root, data)
--[[
	ProbabilityBg/Text4/Nowcount
--]]
	local tmp = Root:Find("ProbabilityBg/Text4/Nowcount").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.nowcount = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function RaffleEditorPanel:SetLocalizedText(Root)

    local locObj_RaffleEditorPanel_Text = Root:Find("TestBtn/Text")
    if locObj_RaffleEditorPanel_Text then
        locObj_RaffleEditorPanel_Text.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.RaffleEditorPanel_Text
    end

    local locObj_RaffleEditorPanel_Pg_Text = Root:Find("TimeLineTestBg/Text")
    if locObj_RaffleEditorPanel_Pg_Text then
        locObj_RaffleEditorPanel_Pg_Text.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.RaffleEditorPanel_Pg_Text
    end

    local locObj_RaffleEditorPanel_Text1 = Root:Find("TimeLineTestBg/Text5")
    if locObj_RaffleEditorPanel_Text1 then
        locObj_RaffleEditorPanel_Text1.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.RaffleEditorPanel_Text1
    end

    local locObj_RaffleEditorPanel_Placeholder = Root:Find("TimeLineTestBg/Text5/CharIdInputField/Placeholder")
    if locObj_RaffleEditorPanel_Placeholder then
        locObj_RaffleEditorPanel_Placeholder.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.RaffleEditorPanel_Placeholder
    end

    local locObj_RaffleEditorPanel_Text = Root:Find("TimeLineTestBg/TimeLineTestBtn/Text")
    if locObj_RaffleEditorPanel_Text then
        locObj_RaffleEditorPanel_Text.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.RaffleEditorPanel_Text
    end

    local locObj_RaffleEditorPanel_Pg_Text = Root:Find("ProbabilityBg/Text")
    if locObj_RaffleEditorPanel_Pg_Text then
        locObj_RaffleEditorPanel_Pg_Text.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.RaffleEditorPanel_Pg_Text
    end

    local locObj_RaffleEditorPanel_Text1 = Root:Find("ProbabilityBg/Text1")
    if locObj_RaffleEditorPanel_Text1 then
        locObj_RaffleEditorPanel_Text1.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.RaffleEditorPanel_Text1
    end

    local locObj_RaffleEditorPanel_Text2 = Root:Find("ProbabilityBg/Text2")
    if locObj_RaffleEditorPanel_Text2 then
        locObj_RaffleEditorPanel_Text2.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.RaffleEditorPanel_Text2
    end

    local locObj_RaffleEditorPanel_Text3 = Root:Find("ProbabilityBg/Text3")
    if locObj_RaffleEditorPanel_Text3 then
        locObj_RaffleEditorPanel_Text3.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.RaffleEditorPanel_Text3
    end

    local locObj_RaffleEditorPanel_Text4 = Root:Find("ProbabilityBg/Text4")
    if locObj_RaffleEditorPanel_Text4 then
        locObj_RaffleEditorPanel_Text4.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.RaffleEditorPanel_Text4
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return RaffleEditorPanel