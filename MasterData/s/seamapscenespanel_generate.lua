---@class SeaMapScenesPanel_Generate_backBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class SeaMapScenesPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public backBtn SeaMapScenesPanel_Generate_backBtn
local SeaMapScenesPanel = class("SeaMapScenesPanel", require("WndBase"))

function SeaMapScenesPanel:ctor(data)
end

---@private
function SeaMapScenesPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("SeaMapScenesPanel")

	local Root = self.transform 
	local tmp

	self:InitGenerate__1(Root,data)
	self:InitGenerate__2(Root,data)

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function SeaMapScenesPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function SeaMapScenesPanel:InitGenerate__2(Root, data)
--[[
	backBtn
--]]
	local tmp = Root:Find("backBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.backBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("SeaMapScenesPanel_backBtn")
			if self.backBtn_ScaleButton_onClick then
				self:backBtn_ScaleButton_onClick(self.backBtn)
			end
		end)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function SeaMapScenesPanel:SetLocalizedText(Root)

    local locObj_SeaMapScenesPanel_TextTMP = Root:Find("backBtn/Text (TMP)")
    if locObj_SeaMapScenesPanel_TextTMP then
        locObj_SeaMapScenesPanel_TextTMP.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.SeaMapScenesPanel_TextTMP
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return SeaMapScenesPanel