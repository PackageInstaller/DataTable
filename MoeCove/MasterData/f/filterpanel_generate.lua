---@class FilterPanel_Generate_modeBox_selectModeTxt
---@field public gameObject UnityEngine.GameObject
---@field public text UnityEngine.UI.Text

---@class FilterPanel_Generate_modeBox
---@field public gameObject UnityEngine.GameObject
---@field public selectModeTxt FilterPanel_Generate_modeBox_selectModeTxt
---@field public modeList UnityEngine.GameObject

---@class FilterPanel_Generate_modeBtn_isSelect_starTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class FilterPanel_Generate_modeBtn_isSelect_rankIcon
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class FilterPanel_Generate_modeBtn_selectNameTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class FilterPanel_Generate_modeBtn_isSelect
---@field public gameObject UnityEngine.GameObject
---@field public rankMode UnityEngine.GameObject
---@field public rankIcon FilterPanel_Generate_modeBtn_isSelect_rankIcon
---@field public starMode UnityEngine.GameObject
---@field public starTxt FilterPanel_Generate_modeBtn_isSelect_starTxt

---@class FilterPanel_Generate_modeBtn_starTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class FilterPanel_Generate_modeBtn_rankIcon
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class FilterPanel_Generate_modeBtn_modeNameTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class FilterPanel_Generate_modeBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public modeNameTxt FilterPanel_Generate_modeBtn_modeNameTxt
---@field public rankMode UnityEngine.GameObject
---@field public rankIcon FilterPanel_Generate_modeBtn_rankIcon
---@field public starMode UnityEngine.GameObject
---@field public starTxt FilterPanel_Generate_modeBtn_starTxt
---@field public isSelect FilterPanel_Generate_modeBtn_isSelect
---@field public selectNameTxt FilterPanel_Generate_modeBtn_selectNameTxt

---@class FilterPanel_Generate_saveBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class FilterPanel_Generate_allClearBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class FilterPanel_Generate_okBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class FilterPanel_Generate_closeBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class FilterPanel_Generate_mask
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class FilterPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public mask FilterPanel_Generate_mask
---@field public closeBtn FilterPanel_Generate_closeBtn
---@field public teamList UnityEngine.GameObject
---@field public modeAllList UnityEngine.GameObject
---@field public okBtn FilterPanel_Generate_okBtn
---@field public allClearBtn FilterPanel_Generate_allClearBtn
---@field public saveBtn FilterPanel_Generate_saveBtn
---@field public modeBtn FilterPanel_Generate_modeBtn
---@field public modeBox FilterPanel_Generate_modeBox
local FilterPanel = class("FilterPanel", require("WndBase"))

function FilterPanel:ctor(data)
end

---@private
function FilterPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("FilterPanel")

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

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function FilterPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function FilterPanel:InitGenerate__2(Root, data)
--[[
	mask
--]]
	local tmp = Root:Find("mask").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.mask = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("FilterPanel_mask")
			if self.mask_Button_onClick then
				self:mask_Button_onClick(self.mask)
			end
		end)


end

---@private
function FilterPanel:InitGenerate__3(Root, data)
--[[
	PanelBg/Art/TitleBg/CloseBtn
--]]
	local tmp = Root:Find("PanelBg/Art/TitleBg/CloseBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.closeBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("FilterPanel_closeBtn")
			if self.closeBtn_ScaleButton_onClick then
				self:closeBtn_ScaleButton_onClick(self.closeBtn)
			end
		end)


end

---@private
function FilterPanel:InitGenerate__4(Root, data)
--[[
	PanelBg/Art/TeamList
--]]
	local tmp = Root:Find("PanelBg/Art/TeamList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.teamList = tmp


end

---@private
function FilterPanel:InitGenerate__5(Root, data)
--[[
	PanelBg/Scroll View/Viewport/ModeAllList
--]]
	local tmp = Root:Find("PanelBg/Scroll View/Viewport/ModeAllList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.modeAllList = tmp


end

---@private
function FilterPanel:InitGenerate__6(Root, data)
--[[
	PanelBg/OkBtn
--]]
	local tmp = Root:Find("PanelBg/OkBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.okBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("FilterPanel_okBtn")
			if self.okBtn_ScaleButton_onClick then
				self:okBtn_ScaleButton_onClick(self.okBtn)
			end
		end)


end

---@private
function FilterPanel:InitGenerate__7(Root, data)
--[[
	PanelBg/AllClearBtn
--]]
	local tmp = Root:Find("PanelBg/AllClearBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.allClearBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("FilterPanel_allClearBtn")
			if self.allClearBtn_ScaleButton_onClick then
				self:allClearBtn_ScaleButton_onClick(self.allClearBtn)
			end
		end)


end

---@private
function FilterPanel:InitGenerate__8(Root, data)
--[[
	PanelBg/SaveBtn
--]]
	local tmp = Root:Find("PanelBg/SaveBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.saveBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("FilterPanel_saveBtn")
			if self.saveBtn_ScaleButton_onClick then
				self:saveBtn_ScaleButton_onClick(self.saveBtn)
			end
		end)


end

---@private
function FilterPanel:InitGenerate__9(Root, data)
--[[
	ModeBtn
--]]
	local tmp = Root:Find("ModeBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.modeBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("FilterPanel_modeBtn")
			if self.modeBtn_ScaleButton_onClick then
				self:modeBtn_ScaleButton_onClick(self.modeBtn)
			end
		end)


end

---@private
function FilterPanel:InitGenerate__10(Root, data)
--[[
	ModeBtn/ModeNameTxt
--]]
	local tmp = Root:Find("ModeBtn/ModeNameTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.modeBtn.modeNameTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function FilterPanel:InitGenerate__11(Root, data)
--[[
	ModeBtn/RankMode
--]]
	local tmp = Root:Find("ModeBtn/RankMode").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.modeBtn.rankMode = tmp


end

---@private
function FilterPanel:InitGenerate__12(Root, data)
--[[
	ModeBtn/RankMode/RankIcon
--]]
	local tmp = Root:Find("ModeBtn/RankMode/RankIcon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.modeBtn.rankIcon = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function FilterPanel:InitGenerate__13(Root, data)
--[[
	ModeBtn/StarMode
--]]
	local tmp = Root:Find("ModeBtn/StarMode").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.modeBtn.starMode = tmp


end

---@private
function FilterPanel:InitGenerate__14(Root, data)
--[[
	ModeBtn/StarMode/StarTxt
--]]
	local tmp = Root:Find("ModeBtn/StarMode/StarTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.modeBtn.starTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function FilterPanel:InitGenerate__15(Root, data)
--[[
	ModeBtn/IsSelect
--]]
	local tmp = Root:Find("ModeBtn/IsSelect").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.modeBtn.isSelect = tmp


end

---@private
function FilterPanel:InitGenerate__16(Root, data)
--[[
	ModeBtn/IsSelect/SelectNameTxt
--]]
	local tmp = Root:Find("ModeBtn/IsSelect/SelectNameTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.modeBtn.selectNameTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function FilterPanel:InitGenerate__17(Root, data)
--[[
	ModeBtn/IsSelect/RankMode
--]]
	local tmp = Root:Find("ModeBtn/IsSelect/RankMode").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.modeBtn.isSelect.rankMode = tmp


end

---@private
function FilterPanel:InitGenerate__18(Root, data)
--[[
	ModeBtn/IsSelect/RankMode/RankIcon
--]]
	local tmp = Root:Find("ModeBtn/IsSelect/RankMode/RankIcon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.modeBtn.isSelect.rankIcon = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function FilterPanel:InitGenerate__19(Root, data)
--[[
	ModeBtn/IsSelect/StarMode
--]]
	local tmp = Root:Find("ModeBtn/IsSelect/StarMode").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.modeBtn.isSelect.starMode = tmp


end

---@private
function FilterPanel:InitGenerate__20(Root, data)
--[[
	ModeBtn/IsSelect/StarMode/StarTxt
--]]
	local tmp = Root:Find("ModeBtn/IsSelect/StarMode/StarTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.modeBtn.isSelect.starTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function FilterPanel:InitGenerate__21(Root, data)
--[[
	ModeBox
--]]
	local tmp = Root:Find("ModeBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.modeBox = tmp


end

---@private
function FilterPanel:InitGenerate__22(Root, data)
--[[
	ModeBox/ModeTitle/SelectModeTxt
--]]
	local tmp = Root:Find("ModeBox/ModeTitle/SelectModeTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.modeBox.selectModeTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.Text)


end

---@private
function FilterPanel:InitGenerate__23(Root, data)
--[[
	ModeBox/ModeList
--]]
	local tmp = Root:Find("ModeBox/ModeList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.modeBox.modeList = tmp


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function FilterPanel:SetLocalizedText(Root)

    local locObj_FilterPanel_TitleText = Root:Find("PanelBg/Art/TitleBg/TitleText")
    if locObj_FilterPanel_TitleText then
        locObj_FilterPanel_TitleText.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.FilterPanel_TitleText
    end

    local locObj_FilterPanel_TextTMP = Root:Find("PanelBg/OkBtn/Text (TMP)")
    if locObj_FilterPanel_TextTMP then
        locObj_FilterPanel_TextTMP.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.FilterPanel_TextTMP
    end

    local locObj_FilterPanel_An_TextTMP = Root:Find("PanelBg/AllClearBtn/Text (TMP)")
    if locObj_FilterPanel_An_TextTMP then
        locObj_FilterPanel_An_TextTMP.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.FilterPanel_An_TextTMP
    end

    local locObj_FilterPanel_Sn_TextTMP = Root:Find("PanelBg/SaveBtn/Text (TMP)")
    if locObj_FilterPanel_Sn_TextTMP then
        locObj_FilterPanel_Sn_TextTMP.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.FilterPanel_Sn_TextTMP
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return FilterPanel