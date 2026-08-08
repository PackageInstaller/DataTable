---@class AS06MainPanel_Generate_customBackPanel
---@field public gameObject UnityEngine.GameObject
---@field public customBackPanel CustomBackPanel

---@class AS06MainPanel_Generate_goBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class AS06MainPanel_Generate_shopBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class AS06MainPanel_Generate_trialBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class AS06MainPanel_Generate_taskBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class AS06MainPanel_Generate_simulateBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class AS06MainPanel_Generate_battleBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class AS06MainPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public rectTransform UnityEngine.RectTransform
---@field public battleBtn AS06MainPanel_Generate_battleBtn
---@field public simulateBtn AS06MainPanel_Generate_simulateBtn
---@field public taskBtn AS06MainPanel_Generate_taskBtn
---@field public trialBtn AS06MainPanel_Generate_trialBtn
---@field public shopBtn AS06MainPanel_Generate_shopBtn
---@field public goBtn AS06MainPanel_Generate_goBtn
---@field public customBackPanel AS06MainPanel_Generate_customBackPanel
---@field public tipText UnityEngine.GameObject
local AS06MainPanel = class("AS06MainPanel", require("WndBase"))

function AS06MainPanel:ctor(data)
end

---@private
function AS06MainPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("AS06MainPanel")

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

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function AS06MainPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.rectTransform = Root:GetComponent(TypeInfo.RectTransform)


end

---@private
function AS06MainPanel:InitGenerate__2(Root, data)
--[[
	AdjustRoot/BattleBtn
--]]
	local tmp = Root:Find("AdjustRoot/BattleBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.battleBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("AS06MainPanel_battleBtn")
			if self.battleBtn_ScaleButton_onClick then
				self:battleBtn_ScaleButton_onClick(self.battleBtn)
			end
		end)


end

---@private
function AS06MainPanel:InitGenerate__3(Root, data)
--[[
	AdjustRoot/SimulateBtn
--]]
	local tmp = Root:Find("AdjustRoot/SimulateBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.simulateBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("AS06MainPanel_simulateBtn")
			if self.simulateBtn_ScaleButton_onClick then
				self:simulateBtn_ScaleButton_onClick(self.simulateBtn)
			end
		end)


end

---@private
function AS06MainPanel:InitGenerate__4(Root, data)
--[[
	AdjustRoot/TaskBtn
--]]
	local tmp = Root:Find("AdjustRoot/TaskBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.taskBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("AS06MainPanel_taskBtn")
			if self.taskBtn_ScaleButton_onClick then
				self:taskBtn_ScaleButton_onClick(self.taskBtn)
			end
		end)


end

---@private
function AS06MainPanel:InitGenerate__5(Root, data)
--[[
	AdjustRoot/TrialBtn
--]]
	local tmp = Root:Find("AdjustRoot/TrialBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.trialBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("AS06MainPanel_trialBtn")
			if self.trialBtn_ScaleButton_onClick then
				self:trialBtn_ScaleButton_onClick(self.trialBtn)
			end
		end)


end

---@private
function AS06MainPanel:InitGenerate__6(Root, data)
--[[
	AdjustRoot/ShopBtn
--]]
	local tmp = Root:Find("AdjustRoot/ShopBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.shopBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("AS06MainPanel_shopBtn")
			if self.shopBtn_ScaleButton_onClick then
				self:shopBtn_ScaleButton_onClick(self.shopBtn)
			end
		end)


end

---@private
function AS06MainPanel:InitGenerate__7(Root, data)
--[[
	GoBtn
--]]
	local tmp = Root:Find("GoBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.goBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("AS06MainPanel_goBtn")
			if self.goBtn_ScaleButton_onClick then
				self:goBtn_ScaleButton_onClick(self.goBtn)
			end
		end)


end

---@private
function AS06MainPanel:InitGenerate__8(Root, data)
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
function AS06MainPanel:InitGenerate__9(Root, data)
--[[
	Tip/TipText
--]]
	local tmp = Root:Find("Tip/TipText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.tipText = tmp


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function AS06MainPanel:SetLocalizedText(Root)

    local locObj_AS06MainPanel_Text = Root:Find("AdjustRoot/BattleBtn/Text")
    if locObj_AS06MainPanel_Text then
        locObj_AS06MainPanel_Text.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.AS06MainPanel_Text
    end

    local locObj_AS06MainPanel_Sn_Text = Root:Find("AdjustRoot/SimulateBtn/Text")
    if locObj_AS06MainPanel_Sn_Text then
        locObj_AS06MainPanel_Sn_Text.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.AS06MainPanel_Sn_Text
    end

    local locObj_AS06MainPanel_Tn_Text = Root:Find("AdjustRoot/TaskBtn/Text")
    if locObj_AS06MainPanel_Tn_Text then
        locObj_AS06MainPanel_Tn_Text.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.AS06MainPanel_Tn_Text
    end

    local locObj_AS06MainPanel_At_Tn_Text = Root:Find("AdjustRoot/TrialBtn/Text")
    if locObj_AS06MainPanel_At_Tn_Text then
        locObj_AS06MainPanel_At_Tn_Text.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.AS06MainPanel_At_Tn_Text
    end

    local locObj_AS06MainPanel_At_Sn_Text = Root:Find("AdjustRoot/ShopBtn/Text")
    if locObj_AS06MainPanel_At_Sn_Text then
        locObj_AS06MainPanel_At_Sn_Text.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.AS06MainPanel_At_Sn_Text
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return AS06MainPanel