---@class SceneSettingPanel_Generate_defaultSceneType_1
---@field public gameObject UnityEngine.GameObject
---@field public toggle UnityEngine.UI.Toggle

---@class SceneSettingPanel_Generate_defaultSceneType_2
---@field public gameObject UnityEngine.GameObject
---@field public toggle UnityEngine.UI.Toggle

---@class SceneSettingPanel_Generate_defaultSceneToggleGroup
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class SceneSettingPanel_Generate_rectifyBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class SceneSettingPanel_Generate_timeScaleDisableBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class SceneSettingPanel_Generate_timeScaleType_4
---@field public gameObject UnityEngine.GameObject
---@field public toggle UnityEngine.UI.Toggle

---@class SceneSettingPanel_Generate_timeScaleType_3
---@field public gameObject UnityEngine.GameObject
---@field public toggle UnityEngine.UI.Toggle

---@class SceneSettingPanel_Generate_timeScaleType_2
---@field public gameObject UnityEngine.GameObject
---@field public toggle UnityEngine.UI.Toggle

---@class SceneSettingPanel_Generate_timeScaleType_1
---@field public gameObject UnityEngine.GameObject
---@field public toggle UnityEngine.UI.Toggle

---@class SceneSettingPanel_Generate_timeScaleTypePanel
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class SceneSettingPanel_Generate_dayTimeDisableBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class SceneSettingPanel_Generate_timeType_3
---@field public gameObject UnityEngine.GameObject
---@field public toggle UnityEngine.UI.Toggle

---@class SceneSettingPanel_Generate_timeType_2
---@field public gameObject UnityEngine.GameObject
---@field public toggle UnityEngine.UI.Toggle

---@class SceneSettingPanel_Generate_timeType_1
---@field public gameObject UnityEngine.GameObject
---@field public toggle UnityEngine.UI.Toggle

---@class SceneSettingPanel_Generate_dayTimeTypePanel
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class SceneSettingPanel_Generate_timeOpenState_onText
---@field public gameObject UnityEngine.GameObject
---@field public canvasGroup UnityEngine.CanvasGroup

---@class SceneSettingPanel_Generate_timeOpenState_offText
---@field public gameObject UnityEngine.GameObject
---@field public canvasGroup UnityEngine.CanvasGroup

---@class SceneSettingPanel_Generate_timeOpenState
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public offText SceneSettingPanel_Generate_timeOpenState_offText
---@field public onText SceneSettingPanel_Generate_timeOpenState_onText

---@class SceneSettingPanel_Generate_timeOpenOff
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public button UnityEngine.UI.Button

---@class SceneSettingPanel_Generate_timeOpenOn
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public button UnityEngine.UI.Button

---@class SceneSettingPanel_Generate_contentPanel_enemyCloseBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class SceneSettingPanel_Generate_contentPanel
---@field public gameObject UnityEngine.GameObject
---@field public enemyCloseBtn SceneSettingPanel_Generate_contentPanel_enemyCloseBtn

---@class SceneSettingPanel_Generate_mask
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class SceneSettingPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public mask SceneSettingPanel_Generate_mask
---@field public contentPanel SceneSettingPanel_Generate_contentPanel
---@field public timeOpenOn SceneSettingPanel_Generate_timeOpenOn
---@field public timeOpenOff SceneSettingPanel_Generate_timeOpenOff
---@field public timeOpenState SceneSettingPanel_Generate_timeOpenState
---@field public dayTimeTypePanel SceneSettingPanel_Generate_dayTimeTypePanel
---@field public timeType_1 SceneSettingPanel_Generate_timeType_1
---@field public timeType_2 SceneSettingPanel_Generate_timeType_2
---@field public timeType_3 SceneSettingPanel_Generate_timeType_3
---@field public dayTimeDisableBtn SceneSettingPanel_Generate_dayTimeDisableBtn
---@field public timeScaleTypePanel SceneSettingPanel_Generate_timeScaleTypePanel
---@field public timeScaleType_1 SceneSettingPanel_Generate_timeScaleType_1
---@field public timeScaleType_2 SceneSettingPanel_Generate_timeScaleType_2
---@field public timeScaleType_3 SceneSettingPanel_Generate_timeScaleType_3
---@field public timeScaleType_4 SceneSettingPanel_Generate_timeScaleType_4
---@field public timeScaleDisableBtn SceneSettingPanel_Generate_timeScaleDisableBtn
---@field public rectifyBtn SceneSettingPanel_Generate_rectifyBtn
---@field public defaultSceneToggleGroup SceneSettingPanel_Generate_defaultSceneToggleGroup
---@field public defaultSceneType_2 SceneSettingPanel_Generate_defaultSceneType_2
---@field public defaultSceneType_1 SceneSettingPanel_Generate_defaultSceneType_1
local SceneSettingPanel = class("SceneSettingPanel", require("WndBase"))

function SceneSettingPanel:ctor(data)
end

---@private
function SceneSettingPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("SceneSettingPanel")

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
function SceneSettingPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function SceneSettingPanel:InitGenerate__2(Root, data)
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
		UIMgr:SendUiUseMessage("SceneSettingPanel_mask")
			if self.mask_Button_onClick then
				self:mask_Button_onClick(self.mask)
			end
		end)


end

---@private
function SceneSettingPanel:InitGenerate__3(Root, data)
--[[
	BoxBg/contentPanel
--]]
	local tmp = Root:Find("BoxBg/contentPanel").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.contentPanel = tmp


end

---@private
function SceneSettingPanel:InitGenerate__4(Root, data)
--[[
	BoxBg/contentPanel/TitleBg/EnemyCloseBtn
--]]
	local tmp = Root:Find("BoxBg/contentPanel/TitleBg/EnemyCloseBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.contentPanel.enemyCloseBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("SceneSettingPanel_enemyCloseBtn")
			if self.enemyCloseBtn_ScaleButton_onClick then
				self:enemyCloseBtn_ScaleButton_onClick(self.contentPanel.enemyCloseBtn)
			end
		end)


end

---@private
function SceneSettingPanel:InitGenerate__5(Root, data)
--[[
	BoxBg/contentPanel/itemPanel/menuItem_1/timeOpen/timeOpenOn
--]]
	local tmp = Root:Find("BoxBg/contentPanel/itemPanel/menuItem_1/timeOpen/timeOpenOn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.timeOpenOn = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("SceneSettingPanel_timeOpenOn")
			if self.timeOpenOn_Button_onClick then
				self:timeOpenOn_Button_onClick(self.timeOpenOn)
			end
		end)


end

---@private
function SceneSettingPanel:InitGenerate__6(Root, data)
--[[
	BoxBg/contentPanel/itemPanel/menuItem_1/timeOpen/timeOpenOff
--]]
	local tmp = Root:Find("BoxBg/contentPanel/itemPanel/menuItem_1/timeOpen/timeOpenOff").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.timeOpenOff = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("SceneSettingPanel_timeOpenOff")
			if self.timeOpenOff_Button_onClick then
				self:timeOpenOff_Button_onClick(self.timeOpenOff)
			end
		end)


end

---@private
function SceneSettingPanel:InitGenerate__7(Root, data)
--[[
	BoxBg/contentPanel/itemPanel/menuItem_1/timeOpen/timeOpenState
--]]
	local tmp = Root:Find("BoxBg/contentPanel/itemPanel/menuItem_1/timeOpen/timeOpenState").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.timeOpenState = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function SceneSettingPanel:InitGenerate__8(Root, data)
--[[
	BoxBg/contentPanel/itemPanel/menuItem_1/timeOpen/timeOpenState/OffText
--]]
	local tmp = Root:Find("BoxBg/contentPanel/itemPanel/menuItem_1/timeOpen/timeOpenState/OffText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.timeOpenState.offText = tmp

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function SceneSettingPanel:InitGenerate__9(Root, data)
--[[
	BoxBg/contentPanel/itemPanel/menuItem_1/timeOpen/timeOpenState/OnText
--]]
	local tmp = Root:Find("BoxBg/contentPanel/itemPanel/menuItem_1/timeOpen/timeOpenState/OnText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.timeOpenState.onText = tmp

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function SceneSettingPanel:InitGenerate__10(Root, data)
--[[
	BoxBg/contentPanel/itemPanel/menuItem_2/dayTimeTypePanel
--]]
	local tmp = Root:Find("BoxBg/contentPanel/itemPanel/menuItem_2/dayTimeTypePanel").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.dayTimeTypePanel = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function SceneSettingPanel:InitGenerate__11(Root, data)
--[[
	BoxBg/contentPanel/itemPanel/menuItem_2/dayTimeTypePanel/timeType_1
--]]
	local tmp = Root:Find("BoxBg/contentPanel/itemPanel/menuItem_2/dayTimeTypePanel/timeType_1").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.timeType_1 = tmp

	tmp.toggle = tmp:GetComponent(TypeInfo.Toggle)
	tmp.toggle.onValueChanged:RemoveAllListeners()
	tmp.toggle.onValueChanged:AddListener(function (isOn)
			if self.timeType_1_Toggle_onValueChanged then
				self:timeType_1_Toggle_onValueChanged(self.timeType_1,isOn)
			end
		end)


end

---@private
function SceneSettingPanel:InitGenerate__12(Root, data)
--[[
	BoxBg/contentPanel/itemPanel/menuItem_2/dayTimeTypePanel/timeType_2
--]]
	local tmp = Root:Find("BoxBg/contentPanel/itemPanel/menuItem_2/dayTimeTypePanel/timeType_2").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.timeType_2 = tmp

	tmp.toggle = tmp:GetComponent(TypeInfo.Toggle)
	tmp.toggle.onValueChanged:RemoveAllListeners()
	tmp.toggle.onValueChanged:AddListener(function (isOn)
			if self.timeType_2_Toggle_onValueChanged then
				self:timeType_2_Toggle_onValueChanged(self.timeType_2,isOn)
			end
		end)


end

---@private
function SceneSettingPanel:InitGenerate__13(Root, data)
--[[
	BoxBg/contentPanel/itemPanel/menuItem_2/dayTimeTypePanel/timeType_3
--]]
	local tmp = Root:Find("BoxBg/contentPanel/itemPanel/menuItem_2/dayTimeTypePanel/timeType_3").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.timeType_3 = tmp

	tmp.toggle = tmp:GetComponent(TypeInfo.Toggle)
	tmp.toggle.onValueChanged:RemoveAllListeners()
	tmp.toggle.onValueChanged:AddListener(function (isOn)
			if self.timeType_3_Toggle_onValueChanged then
				self:timeType_3_Toggle_onValueChanged(self.timeType_3,isOn)
			end
		end)


end

---@private
function SceneSettingPanel:InitGenerate__14(Root, data)
--[[
	BoxBg/contentPanel/itemPanel/menuItem_2/dayTimeDisableBtn
--]]
	local tmp = Root:Find("BoxBg/contentPanel/itemPanel/menuItem_2/dayTimeDisableBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.dayTimeDisableBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("SceneSettingPanel_dayTimeDisableBtn")
			if self.dayTimeDisableBtn_ScaleButton_onClick then
				self:dayTimeDisableBtn_ScaleButton_onClick(self.dayTimeDisableBtn)
			end
		end)


end

---@private
function SceneSettingPanel:InitGenerate__15(Root, data)
--[[
	BoxBg/contentPanel/itemPanel/menuItem_3/timeScaleTypePanel
--]]
	local tmp = Root:Find("BoxBg/contentPanel/itemPanel/menuItem_3/timeScaleTypePanel").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.timeScaleTypePanel = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function SceneSettingPanel:InitGenerate__16(Root, data)
--[[
	BoxBg/contentPanel/itemPanel/menuItem_3/timeScaleTypePanel/timeScaleType_1
--]]
	local tmp = Root:Find("BoxBg/contentPanel/itemPanel/menuItem_3/timeScaleTypePanel/timeScaleType_1").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.timeScaleType_1 = tmp

	tmp.toggle = tmp:GetComponent(TypeInfo.Toggle)
	tmp.toggle.onValueChanged:RemoveAllListeners()
	tmp.toggle.onValueChanged:AddListener(function (isOn)
			if self.timeScaleType_1_Toggle_onValueChanged then
				self:timeScaleType_1_Toggle_onValueChanged(self.timeScaleType_1,isOn)
			end
		end)


end

---@private
function SceneSettingPanel:InitGenerate__17(Root, data)
--[[
	BoxBg/contentPanel/itemPanel/menuItem_3/timeScaleTypePanel/timeScaleType_2
--]]
	local tmp = Root:Find("BoxBg/contentPanel/itemPanel/menuItem_3/timeScaleTypePanel/timeScaleType_2").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.timeScaleType_2 = tmp

	tmp.toggle = tmp:GetComponent(TypeInfo.Toggle)
	tmp.toggle.onValueChanged:RemoveAllListeners()
	tmp.toggle.onValueChanged:AddListener(function (isOn)
			if self.timeScaleType_2_Toggle_onValueChanged then
				self:timeScaleType_2_Toggle_onValueChanged(self.timeScaleType_2,isOn)
			end
		end)


end

---@private
function SceneSettingPanel:InitGenerate__18(Root, data)
--[[
	BoxBg/contentPanel/itemPanel/menuItem_3/timeScaleTypePanel/timeScaleType_3
--]]
	local tmp = Root:Find("BoxBg/contentPanel/itemPanel/menuItem_3/timeScaleTypePanel/timeScaleType_3").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.timeScaleType_3 = tmp

	tmp.toggle = tmp:GetComponent(TypeInfo.Toggle)
	tmp.toggle.onValueChanged:RemoveAllListeners()
	tmp.toggle.onValueChanged:AddListener(function (isOn)
			if self.timeScaleType_3_Toggle_onValueChanged then
				self:timeScaleType_3_Toggle_onValueChanged(self.timeScaleType_3,isOn)
			end
		end)


end

---@private
function SceneSettingPanel:InitGenerate__19(Root, data)
--[[
	BoxBg/contentPanel/itemPanel/menuItem_3/timeScaleTypePanel/timeScaleType_4
--]]
	local tmp = Root:Find("BoxBg/contentPanel/itemPanel/menuItem_3/timeScaleTypePanel/timeScaleType_4").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.timeScaleType_4 = tmp

	tmp.toggle = tmp:GetComponent(TypeInfo.Toggle)
	tmp.toggle.onValueChanged:RemoveAllListeners()
	tmp.toggle.onValueChanged:AddListener(function (isOn)
			if self.timeScaleType_4_Toggle_onValueChanged then
				self:timeScaleType_4_Toggle_onValueChanged(self.timeScaleType_4,isOn)
			end
		end)


end

---@private
function SceneSettingPanel:InitGenerate__20(Root, data)
--[[
	BoxBg/contentPanel/itemPanel/menuItem_3/timeScaleDisableBtn
--]]
	local tmp = Root:Find("BoxBg/contentPanel/itemPanel/menuItem_3/timeScaleDisableBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.timeScaleDisableBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("SceneSettingPanel_timeScaleDisableBtn")
			if self.timeScaleDisableBtn_ScaleButton_onClick then
				self:timeScaleDisableBtn_ScaleButton_onClick(self.timeScaleDisableBtn)
			end
		end)


end

---@private
function SceneSettingPanel:InitGenerate__21(Root, data)
--[[
	BoxBg/contentPanel/itemPanel/menuItem_4/rectifyBtn
--]]
	local tmp = Root:Find("BoxBg/contentPanel/itemPanel/menuItem_4/rectifyBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rectifyBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("SceneSettingPanel_rectifyBtn")
			if self.rectifyBtn_ScaleButton_onClick then
				self:rectifyBtn_ScaleButton_onClick(self.rectifyBtn)
			end
		end)


end

---@private
function SceneSettingPanel:InitGenerate__22(Root, data)
--[[
	BoxBg/contentPanel/itemPanel/menuItem_5/defaultSceneToggleGroup
--]]
	local tmp = Root:Find("BoxBg/contentPanel/itemPanel/menuItem_5/defaultSceneToggleGroup").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.defaultSceneToggleGroup = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function SceneSettingPanel:InitGenerate__23(Root, data)
--[[
	BoxBg/contentPanel/itemPanel/menuItem_5/defaultSceneToggleGroup/defaultSceneType_2
--]]
	local tmp = Root:Find("BoxBg/contentPanel/itemPanel/menuItem_5/defaultSceneToggleGroup/defaultSceneType_2").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.defaultSceneType_2 = tmp

	tmp.toggle = tmp:GetComponent(TypeInfo.Toggle)
	tmp.toggle.onValueChanged:RemoveAllListeners()
	tmp.toggle.onValueChanged:AddListener(function (isOn)
			if self.defaultSceneType_2_Toggle_onValueChanged then
				self:defaultSceneType_2_Toggle_onValueChanged(self.defaultSceneType_2,isOn)
			end
		end)


end

---@private
function SceneSettingPanel:InitGenerate__24(Root, data)
--[[
	BoxBg/contentPanel/itemPanel/menuItem_5/defaultSceneToggleGroup/defaultSceneType_1
--]]
	local tmp = Root:Find("BoxBg/contentPanel/itemPanel/menuItem_5/defaultSceneToggleGroup/defaultSceneType_1").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.defaultSceneType_1 = tmp

	tmp.toggle = tmp:GetComponent(TypeInfo.Toggle)
	tmp.toggle.onValueChanged:RemoveAllListeners()
	tmp.toggle.onValueChanged:AddListener(function (isOn)
			if self.defaultSceneType_1_Toggle_onValueChanged then
				self:defaultSceneType_1_Toggle_onValueChanged(self.defaultSceneType_1,isOn)
			end
		end)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function SceneSettingPanel:SetLocalizedText(Root)

    local locObj_SceneSettingPanel_TitleNameTxt = Root:Find("BoxBg/contentPanel/TitleBg/TitleNameBg/TitleNameTxt")
    if locObj_SceneSettingPanel_TitleNameTxt then
        locObj_SceneSettingPanel_TitleNameTxt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.SceneSettingPanel_TitleNameTxt
    end

    local locObj_SceneSettingPanel_nameText = Root:Find("BoxBg/contentPanel/itemPanel/menuItem_1/nameText")
    if locObj_SceneSettingPanel_nameText then
        locObj_SceneSettingPanel_nameText.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.SceneSettingPanel_nameText
    end

    local locObj_SceneSettingPanel_desText = Root:Find("BoxBg/contentPanel/itemPanel/menuItem_1/desText")
    if locObj_SceneSettingPanel_desText then
        locObj_SceneSettingPanel_desText.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.SceneSettingPanel_desText
    end

    local locObj_SceneSettingPanel_OnText = Root:Find("BoxBg/contentPanel/itemPanel/menuItem_1/timeOpen/timeOpenOn/OnText")
    if locObj_SceneSettingPanel_OnText then
        locObj_SceneSettingPanel_OnText.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.SceneSettingPanel_OnText
    end

    local locObj_SceneSettingPanel_OffText = Root:Find("BoxBg/contentPanel/itemPanel/menuItem_1/timeOpen/timeOpenOff/OffText")
    if locObj_SceneSettingPanel_OffText then
        locObj_SceneSettingPanel_OffText.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.SceneSettingPanel_OffText
    end

    local locObj_SceneSettingPanel_te_OffText = Root:Find("BoxBg/contentPanel/itemPanel/menuItem_1/timeOpen/timeOpenState/OffText")
    if locObj_SceneSettingPanel_te_OffText then
        locObj_SceneSettingPanel_te_OffText.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.SceneSettingPanel_te_OffText
    end

    local locObj_SceneSettingPanel_te_OnText = Root:Find("BoxBg/contentPanel/itemPanel/menuItem_1/timeOpen/timeOpenState/OnText")
    if locObj_SceneSettingPanel_te_OnText then
        locObj_SceneSettingPanel_te_OnText.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.SceneSettingPanel_te_OnText
    end

    local locObj_SceneSettingPanel_m2_nameText = Root:Find("BoxBg/contentPanel/itemPanel/menuItem_2/nameText")
    if locObj_SceneSettingPanel_m2_nameText then
        locObj_SceneSettingPanel_m2_nameText.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.SceneSettingPanel_m2_nameText
    end

    local locObj_SceneSettingPanel_m2_desText = Root:Find("BoxBg/contentPanel/itemPanel/menuItem_2/desText")
    if locObj_SceneSettingPanel_m2_desText then
        locObj_SceneSettingPanel_m2_desText.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.SceneSettingPanel_m2_desText
    end

    local locObj_SceneSettingPanel_Label = Root:Find("BoxBg/contentPanel/itemPanel/menuItem_2/dayTimeTypePanel/timeType_1/Label")
    if locObj_SceneSettingPanel_Label then
        locObj_SceneSettingPanel_Label.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.SceneSettingPanel_Label
    end

    local locObj_SceneSettingPanel_t2_Label = Root:Find("BoxBg/contentPanel/itemPanel/menuItem_2/dayTimeTypePanel/timeType_2/Label")
    if locObj_SceneSettingPanel_t2_Label then
        locObj_SceneSettingPanel_t2_Label.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.SceneSettingPanel_t2_Label
    end

    local locObj_SceneSettingPanel_t3_Label = Root:Find("BoxBg/contentPanel/itemPanel/menuItem_2/dayTimeTypePanel/timeType_3/Label")
    if locObj_SceneSettingPanel_t3_Label then
        locObj_SceneSettingPanel_t3_Label.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.SceneSettingPanel_t3_Label
    end

    local locObj_SceneSettingPanel_TextTMP = Root:Find("BoxBg/contentPanel/itemPanel/menuItem_2/dayTimeDisableBtn/Text (TMP)")
    if locObj_SceneSettingPanel_TextTMP then
        locObj_SceneSettingPanel_TextTMP.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.SceneSettingPanel_TextTMP
    end

    local locObj_SceneSettingPanel_m3_nameText = Root:Find("BoxBg/contentPanel/itemPanel/menuItem_3/nameText")
    if locObj_SceneSettingPanel_m3_nameText then
        locObj_SceneSettingPanel_m3_nameText.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.SceneSettingPanel_m3_nameText
    end

    local locObj_SceneSettingPanel_m3_desText = Root:Find("BoxBg/contentPanel/itemPanel/menuItem_3/desText")
    if locObj_SceneSettingPanel_m3_desText then
        locObj_SceneSettingPanel_m3_desText.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.SceneSettingPanel_m3_desText
    end

    local locObj_SceneSettingPanel_t1_Label = Root:Find("BoxBg/contentPanel/itemPanel/menuItem_3/timeScaleTypePanel/timeScaleType_1/Label")
    if locObj_SceneSettingPanel_t1_Label then
        locObj_SceneSettingPanel_t1_Label.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.SceneSettingPanel_t1_Label
    end

    local locObj_SceneSettingPanel_tl_t2_Label = Root:Find("BoxBg/contentPanel/itemPanel/menuItem_3/timeScaleTypePanel/timeScaleType_2/Label")
    if locObj_SceneSettingPanel_tl_t2_Label then
        locObj_SceneSettingPanel_tl_t2_Label.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.SceneSettingPanel_tl_t2_Label
    end

    local locObj_SceneSettingPanel_tl_t3_Label = Root:Find("BoxBg/contentPanel/itemPanel/menuItem_3/timeScaleTypePanel/timeScaleType_3/Label")
    if locObj_SceneSettingPanel_tl_t3_Label then
        locObj_SceneSettingPanel_tl_t3_Label.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.SceneSettingPanel_tl_t3_Label
    end

    local locObj_SceneSettingPanel_t4_Label = Root:Find("BoxBg/contentPanel/itemPanel/menuItem_3/timeScaleTypePanel/timeScaleType_4/Label")
    if locObj_SceneSettingPanel_t4_Label then
        locObj_SceneSettingPanel_t4_Label.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.SceneSettingPanel_t4_Label
    end

    local locObj_SceneSettingPanel_tn_TextTMP = Root:Find("BoxBg/contentPanel/itemPanel/menuItem_3/timeScaleDisableBtn/Text (TMP)")
    if locObj_SceneSettingPanel_tn_TextTMP then
        locObj_SceneSettingPanel_tn_TextTMP.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.SceneSettingPanel_tn_TextTMP
    end

    local locObj_SceneSettingPanel_m4_nameText = Root:Find("BoxBg/contentPanel/itemPanel/menuItem_4/nameText")
    if locObj_SceneSettingPanel_m4_nameText then
        locObj_SceneSettingPanel_m4_nameText.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.SceneSettingPanel_m4_nameText
    end

    local locObj_SceneSettingPanel_m4_desText = Root:Find("BoxBg/contentPanel/itemPanel/menuItem_4/desText")
    if locObj_SceneSettingPanel_m4_desText then
        locObj_SceneSettingPanel_m4_desText.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.SceneSettingPanel_m4_desText
    end

    local locObj_SceneSettingPanel_rn_TextTMP = Root:Find("BoxBg/contentPanel/itemPanel/menuItem_4/rectifyBtn/Text (TMP)")
    if locObj_SceneSettingPanel_rn_TextTMP then
        locObj_SceneSettingPanel_rn_TextTMP.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.SceneSettingPanel_rn_TextTMP
    end

    local locObj_SceneSettingPanel_m5_nameText = Root:Find("BoxBg/contentPanel/itemPanel/menuItem_5/nameText")
    if locObj_SceneSettingPanel_m5_nameText then
        locObj_SceneSettingPanel_m5_nameText.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.SceneSettingPanel_m5_nameText
    end

    local locObj_SceneSettingPanel_m5_desText = Root:Find("BoxBg/contentPanel/itemPanel/menuItem_5/desText")
    if locObj_SceneSettingPanel_m5_desText then
        locObj_SceneSettingPanel_m5_desText.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.SceneSettingPanel_m5_desText
    end

    local locObj_SceneSettingPanel_d2_Label = Root:Find("BoxBg/contentPanel/itemPanel/menuItem_5/defaultSceneToggleGroup/defaultSceneType_2/Label")
    if locObj_SceneSettingPanel_d2_Label then
        locObj_SceneSettingPanel_d2_Label.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.SceneSettingPanel_d2_Label
    end

    local locObj_SceneSettingPanel_d1_Label = Root:Find("BoxBg/contentPanel/itemPanel/menuItem_5/defaultSceneToggleGroup/defaultSceneType_1/Label")
    if locObj_SceneSettingPanel_d1_Label then
        locObj_SceneSettingPanel_d1_Label.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.SceneSettingPanel_d1_Label
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return SceneSettingPanel