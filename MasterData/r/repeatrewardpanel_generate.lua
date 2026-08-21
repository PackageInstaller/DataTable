---@class RepeatRewardPanel_Generate_quickAnimaBtn
---@field public gameObject UnityEngine.GameObject
---@field public clickListener ClickListener

---@class RepeatRewardPanel_Generate_customMsgPanel
---@field public gameObject UnityEngine.GameObject
---@field public customMsgPanel CustomMsgPanel

---@class RepeatRewardPanel_Generate_customBox
---@field public gameObject UnityEngine.GameObject
---@field public customBox CustomBox

---@class RepeatRewardPanel_Generate_oKBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class RepeatRewardPanel_Generate_allRewardList
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class RepeatRewardPanel_Generate_scrollView2
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public scrollRect UnityEngine.UI.ScrollRect

---@class RepeatRewardPanel_Generate_allReward
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class RepeatRewardPanel_Generate_expSlider
---@field public gameObject UnityEngine.GameObject
---@field public slider UnityEngine.UI.Slider

---@class RepeatRewardPanel_Generate_addExpText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class RepeatRewardPanel_Generate_nowExpText
---@field public gameObject UnityEngine.GameObject
---@field public text UnityEngine.UI.Text

---@class RepeatRewardPanel_Generate_levelText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class RepeatRewardPanel_Generate_levelNameText
---@field public gameObject UnityEngine.GameObject
---@field public text UnityEngine.UI.Text

---@class RepeatRewardPanel_Generate_singleRewardBox_countText
---@field public gameObject UnityEngine.GameObject
---@field public text UnityEngine.UI.Text

---@class RepeatRewardPanel_Generate_singleRewardBox
---@field public gameObject UnityEngine.GameObject
---@field public countText RepeatRewardPanel_Generate_singleRewardBox_countText
---@field public itemBoxList UnityEngine.GameObject

---@class RepeatRewardPanel_Generate_singleRewardList
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public verticalLayoutGroup UnityEngine.UI.VerticalLayoutGroup

---@class RepeatRewardPanel_Generate_scrollView
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public scrollRect UnityEngine.UI.ScrollRect

---@class RepeatRewardPanel_Generate_singleReward
---@field public gameObject UnityEngine.GameObject
---@field public canvasGroup UnityEngine.CanvasGroup

---@class RepeatRewardPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public canvasGroup UnityEngine.CanvasGroup
---@field public image1 UnityEngine.GameObject
---@field public image2 UnityEngine.GameObject
---@field public image3 UnityEngine.GameObject
---@field public image4 UnityEngine.GameObject
---@field public singleReward RepeatRewardPanel_Generate_singleReward
---@field public scrollView RepeatRewardPanel_Generate_scrollView
---@field public singleRewardList RepeatRewardPanel_Generate_singleRewardList
---@field public singleRewardBox RepeatRewardPanel_Generate_singleRewardBox
---@field public levelNameText RepeatRewardPanel_Generate_levelNameText
---@field public levelText RepeatRewardPanel_Generate_levelText
---@field public nowExpText RepeatRewardPanel_Generate_nowExpText
---@field public addExpText RepeatRewardPanel_Generate_addExpText
---@field public expSlider RepeatRewardPanel_Generate_expSlider
---@field public allReward RepeatRewardPanel_Generate_allReward
---@field public scrollView2 RepeatRewardPanel_Generate_scrollView2
---@field public allRewardList RepeatRewardPanel_Generate_allRewardList
---@field public oKBtn RepeatRewardPanel_Generate_oKBtn
---@field public customBox RepeatRewardPanel_Generate_customBox
---@field public customMsgPanel RepeatRewardPanel_Generate_customMsgPanel
---@field public quickAnimaBtn RepeatRewardPanel_Generate_quickAnimaBtn
local RepeatRewardPanel = class("RepeatRewardPanel", require("WndBase"))

function RepeatRewardPanel:ctor(data)
end

---@private
function RepeatRewardPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("RepeatRewardPanel")

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
function RepeatRewardPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.canvasGroup = Root:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function RepeatRewardPanel:InitGenerate__2(Root, data)
--[[
	TitleBg/TitleIcon/Image1
--]]
	local tmp = Root:Find("TitleBg/TitleIcon/Image1").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.image1 = tmp


end

---@private
function RepeatRewardPanel:InitGenerate__3(Root, data)
--[[
	TitleBg/TitleIcon/Image2
--]]
	local tmp = Root:Find("TitleBg/TitleIcon/Image2").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.image2 = tmp


end

---@private
function RepeatRewardPanel:InitGenerate__4(Root, data)
--[[
	TitleBg/TitleIcon/Image3
--]]
	local tmp = Root:Find("TitleBg/TitleIcon/Image3").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.image3 = tmp


end

---@private
function RepeatRewardPanel:InitGenerate__5(Root, data)
--[[
	TitleBg/TitleIcon/Image4
--]]
	local tmp = Root:Find("TitleBg/TitleIcon/Image4").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.image4 = tmp


end

---@private
function RepeatRewardPanel:InitGenerate__6(Root, data)
--[[
	SingleReward
--]]
	local tmp = Root:Find("SingleReward").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.singleReward = tmp

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function RepeatRewardPanel:InitGenerate__7(Root, data)
--[[
	SingleReward/ScrollView
--]]
	local tmp = Root:Find("SingleReward/ScrollView").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.scrollView = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.scrollRect = tmp:GetComponent(TypeInfo.ScrollRect)


end

---@private
function RepeatRewardPanel:InitGenerate__8(Root, data)
--[[
	SingleReward/ScrollView/Viewport/SingleRewardList
--]]
	local tmp = Root:Find("SingleReward/ScrollView/Viewport/SingleRewardList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.singleRewardList = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.verticalLayoutGroup = tmp:GetComponent(TypeInfo.VerticalLayoutGroup)


end

---@private
function RepeatRewardPanel:InitGenerate__9(Root, data)
--[[
	SingleReward/ScrollView/Viewport/SingleRewardList/SingleRewardBox
--]]
	local tmp = Root:Find("SingleReward/ScrollView/Viewport/SingleRewardList/SingleRewardBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.singleRewardBox = tmp


end

---@private
function RepeatRewardPanel:InitGenerate__10(Root, data)
--[[
	SingleReward/ScrollView/Viewport/SingleRewardList/SingleRewardBox/CountText
--]]
	local tmp = Root:Find("SingleReward/ScrollView/Viewport/SingleRewardList/SingleRewardBox/CountText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.singleRewardBox.countText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.Text)


end

---@private
function RepeatRewardPanel:InitGenerate__11(Root, data)
--[[
	SingleReward/ScrollView/Viewport/SingleRewardList/SingleRewardBox/ItemBoxList
--]]
	local tmp = Root:Find("SingleReward/ScrollView/Viewport/SingleRewardList/SingleRewardBox/ItemBoxList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.singleRewardBox.itemBoxList = tmp


end

---@private
function RepeatRewardPanel:InitGenerate__12(Root, data)
--[[
	ResultInfo/LevelNameBg/LevelNameText
--]]
	local tmp = Root:Find("ResultInfo/LevelNameBg/LevelNameText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.levelNameText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.Text)


end

---@private
function RepeatRewardPanel:InitGenerate__13(Root, data)
--[[
	ResultInfo/UserLevelBg/LevelBg/LevelText
--]]
	local tmp = Root:Find("ResultInfo/UserLevelBg/LevelBg/LevelText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.levelText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function RepeatRewardPanel:InitGenerate__14(Root, data)
--[[
	ResultInfo/UserLevelBg/NowExpText
--]]
	local tmp = Root:Find("ResultInfo/UserLevelBg/NowExpText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.nowExpText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.Text)


end

---@private
function RepeatRewardPanel:InitGenerate__15(Root, data)
--[[
	ResultInfo/UserLevelBg/AddExpText
--]]
	local tmp = Root:Find("ResultInfo/UserLevelBg/AddExpText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.addExpText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function RepeatRewardPanel:InitGenerate__16(Root, data)
--[[
	ResultInfo/UserLevelBg/ExpSlider
--]]
	local tmp = Root:Find("ResultInfo/UserLevelBg/ExpSlider").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.expSlider = tmp

	tmp.slider = tmp:GetComponent(TypeInfo.Slider)


end

---@private
function RepeatRewardPanel:InitGenerate__17(Root, data)
--[[
	AllReward
--]]
	local tmp = Root:Find("AllReward").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.allReward = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function RepeatRewardPanel:InitGenerate__18(Root, data)
--[[
	AllReward/ScrollView2
--]]
	local tmp = Root:Find("AllReward/ScrollView2").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.scrollView2 = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.scrollRect = tmp:GetComponent(TypeInfo.ScrollRect)


end

---@private
function RepeatRewardPanel:InitGenerate__19(Root, data)
--[[
	AllReward/ScrollView2/Viewport/AllRewardList
--]]
	local tmp = Root:Find("AllReward/ScrollView2/Viewport/AllRewardList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.allRewardList = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function RepeatRewardPanel:InitGenerate__20(Root, data)
--[[
	AllReward/OKBtn
--]]
	local tmp = Root:Find("AllReward/OKBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.oKBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("RepeatRewardPanel_oKBtn")
			if self.oKBtn_ScaleButton_onClick then
				self:oKBtn_ScaleButton_onClick(self.oKBtn)
			end
		end)


end

---@private
function RepeatRewardPanel:InitGenerate__21(Root, data)
--[[
	CustomBox
--]]
	local tmp = Root:Find("CustomBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.customBox = tmp

	tmp.customBox = tmp:AddComponentLua("CustomBox", data)


end

---@private
function RepeatRewardPanel:InitGenerate__22(Root, data)
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
function RepeatRewardPanel:InitGenerate__23(Root, data)
--[[
	quickAnimaBtn
--]]
	local tmp = Root:Find("quickAnimaBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.quickAnimaBtn = tmp

	tmp.clickListener = tmp:GetComponent(TypeInfo.ClickListener)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function RepeatRewardPanel:SetLocalizedText(Root)

    local locObj_RepeatRewardPanel_SingleRewardTitle = Root:Find("SingleReward/SingleRewardTitleBg/SingleRewardTitle")
    if locObj_RepeatRewardPanel_SingleRewardTitle then
        locObj_RepeatRewardPanel_SingleRewardTitle.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.RepeatRewardPanel_SingleRewardTitle
    end

    local locObj_RepeatRewardPanel_LevelNameTitle = Root:Find("ResultInfo/LevelNameBg/LevelNameTitleBg/LevelNameTitle")
    if locObj_RepeatRewardPanel_LevelNameTitle then
        locObj_RepeatRewardPanel_LevelNameTitle.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.RepeatRewardPanel_LevelNameTitle
    end

    local locObj_RepeatRewardPanel_UserLevelTitle = Root:Find("ResultInfo/UserLevelBg/UserLevelTitleBg/UserLevelTitle")
    if locObj_RepeatRewardPanel_UserLevelTitle then
        locObj_RepeatRewardPanel_UserLevelTitle.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.RepeatRewardPanel_UserLevelTitle
    end

    local locObj_RepeatRewardPanel_LevelHeadText = Root:Find("ResultInfo/UserLevelBg/LevelBg/LevelHeadText")
    if locObj_RepeatRewardPanel_LevelHeadText then
        locObj_RepeatRewardPanel_LevelHeadText.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.RepeatRewardPanel_LevelHeadText
    end

    local locObj_RepeatRewardPanel_RoleFavorabilityTitle = Root:Find("ResultInfo/RoleFavorabilityBg/RoleFavorabilityTitleBg/RoleFavorabilityTitle")
    if locObj_RepeatRewardPanel_RoleFavorabilityTitle then
        locObj_RepeatRewardPanel_RoleFavorabilityTitle.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.RepeatRewardPanel_RoleFavorabilityTitle
    end

    local locObj_RepeatRewardPanel_RoleFavorabilityText = Root:Find("ResultInfo/RoleFavorabilityBg/RoleFavorabilityTextBg/RoleFavorabilityText")
    if locObj_RepeatRewardPanel_RoleFavorabilityText then
        locObj_RepeatRewardPanel_RoleFavorabilityText.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.RepeatRewardPanel_RoleFavorabilityText
    end

    local locObj_RepeatRewardPanel_OKText = Root:Find("AllReward/OKBtn/OKText")
    if locObj_RepeatRewardPanel_OKText then
        locObj_RepeatRewardPanel_OKText.gameObject:GetComponent(TypeInfo.Text).text = UILanguageEnum.RepeatRewardPanel_OKText
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return RepeatRewardPanel