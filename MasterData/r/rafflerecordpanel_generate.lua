---@class RaffleRecordPanel_Generate_rightPageBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class RaffleRecordPanel_Generate_nowPageTxt
---@field public gameObject UnityEngine.GameObject
---@field public text UnityEngine.UI.Text

---@class RaffleRecordPanel_Generate_leftPageBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class RaffleRecordPanel_Generate_recordBox_timeTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class RaffleRecordPanel_Generate_recordBox_nameTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class RaffleRecordPanel_Generate_recordBox_typeTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class RaffleRecordPanel_Generate_recordBox
---@field public gameObject UnityEngine.GameObject
---@field public evenNumber UnityEngine.GameObject
---@field public typeTxt RaffleRecordPanel_Generate_recordBox_typeTxt
---@field public nameTxt RaffleRecordPanel_Generate_recordBox_nameTxt
---@field public timeTxt RaffleRecordPanel_Generate_recordBox_timeTxt

---@class RaffleRecordPanel_Generate_probabilityTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class RaffleRecordPanel_Generate_statisticsTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class RaffleRecordPanel_Generate_closeBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class RaffleRecordPanel_Generate_titleText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class RaffleRecordPanel_Generate_mask
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class RaffleRecordPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public mask RaffleRecordPanel_Generate_mask
---@field public titleText RaffleRecordPanel_Generate_titleText
---@field public closeBtn RaffleRecordPanel_Generate_closeBtn
---@field public statisticsTxt RaffleRecordPanel_Generate_statisticsTxt
---@field public probabilityTxt RaffleRecordPanel_Generate_probabilityTxt
---@field public recordBoxList UnityEngine.GameObject
---@field public recordBox RaffleRecordPanel_Generate_recordBox
---@field public leftPageBtn RaffleRecordPanel_Generate_leftPageBtn
---@field public nowPageTxt RaffleRecordPanel_Generate_nowPageTxt
---@field public rightPageBtn RaffleRecordPanel_Generate_rightPageBtn
local RaffleRecordPanel = class("RaffleRecordPanel", require("WndBase"))

function RaffleRecordPanel:ctor(data)
end

---@private
function RaffleRecordPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("RaffleRecordPanel")

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
function RaffleRecordPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function RaffleRecordPanel:InitGenerate__2(Root, data)
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
		UIMgr:SendUiUseMessage("RaffleRecordPanel_mask")
			if self.mask_Button_onClick then
				self:mask_Button_onClick(self.mask)
			end
		end)


end

---@private
function RaffleRecordPanel:InitGenerate__3(Root, data)
--[[
	BoxBg/TitleSideBg/Titlebg/TitleText
--]]
	local tmp = Root:Find("BoxBg/TitleSideBg/Titlebg/TitleText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.titleText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function RaffleRecordPanel:InitGenerate__4(Root, data)
--[[
	BoxBg/TitleSideBg/CloseBtn
--]]
	local tmp = Root:Find("BoxBg/TitleSideBg/CloseBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.closeBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("RaffleRecordPanel_closeBtn")
			if self.closeBtn_ScaleButton_onClick then
				self:closeBtn_ScaleButton_onClick(self.closeBtn)
			end
		end)


end

---@private
function RaffleRecordPanel:InitGenerate__5(Root, data)
--[[
	BoxBg/StatisticsBoxBg/StatisticsTxt
--]]
	local tmp = Root:Find("BoxBg/StatisticsBoxBg/StatisticsTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.statisticsTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function RaffleRecordPanel:InitGenerate__6(Root, data)
--[[
	BoxBg/StatisticsBoxBg/ProbabilityTxt
--]]
	local tmp = Root:Find("BoxBg/StatisticsBoxBg/ProbabilityTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.probabilityTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function RaffleRecordPanel:InitGenerate__7(Root, data)
--[[
	BoxBg/RecordBoxList
--]]
	local tmp = Root:Find("BoxBg/RecordBoxList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.recordBoxList = tmp


end

---@private
function RaffleRecordPanel:InitGenerate__8(Root, data)
--[[
	BoxBg/RecordBoxList/RecordBox
--]]
	local tmp = Root:Find("BoxBg/RecordBoxList/RecordBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.recordBox = tmp


end

---@private
function RaffleRecordPanel:InitGenerate__9(Root, data)
--[[
	BoxBg/RecordBoxList/RecordBox/EvenNumber
--]]
	local tmp = Root:Find("BoxBg/RecordBoxList/RecordBox/EvenNumber").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.recordBox.evenNumber = tmp


end

---@private
function RaffleRecordPanel:InitGenerate__10(Root, data)
--[[
	BoxBg/RecordBoxList/RecordBox/TypeTxt
--]]
	local tmp = Root:Find("BoxBg/RecordBoxList/RecordBox/TypeTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.recordBox.typeTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function RaffleRecordPanel:InitGenerate__11(Root, data)
--[[
	BoxBg/RecordBoxList/RecordBox/NameTxt
--]]
	local tmp = Root:Find("BoxBg/RecordBoxList/RecordBox/NameTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.recordBox.nameTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function RaffleRecordPanel:InitGenerate__12(Root, data)
--[[
	BoxBg/RecordBoxList/RecordBox/TimeTxt
--]]
	local tmp = Root:Find("BoxBg/RecordBoxList/RecordBox/TimeTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.recordBox.timeTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function RaffleRecordPanel:InitGenerate__13(Root, data)
--[[
	BoxBg/PageTurning/LeftPageBtn
--]]
	local tmp = Root:Find("BoxBg/PageTurning/LeftPageBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.leftPageBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("RaffleRecordPanel_leftPageBtn")
			if self.leftPageBtn_ScaleButton_onClick then
				self:leftPageBtn_ScaleButton_onClick(self.leftPageBtn)
			end
		end)


end

---@private
function RaffleRecordPanel:InitGenerate__14(Root, data)
--[[
	BoxBg/PageTurning/NowPageBg/NowPageTxt
--]]
	local tmp = Root:Find("BoxBg/PageTurning/NowPageBg/NowPageTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.nowPageTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.Text)


end

---@private
function RaffleRecordPanel:InitGenerate__15(Root, data)
--[[
	BoxBg/PageTurning/RightPageBtn
--]]
	local tmp = Root:Find("BoxBg/PageTurning/RightPageBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rightPageBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("RaffleRecordPanel_rightPageBtn")
			if self.rightPageBtn_ScaleButton_onClick then
				self:rightPageBtn_ScaleButton_onClick(self.rightPageBtn)
			end
		end)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function RaffleRecordPanel:SetLocalizedText(Root)

    local locObj_RaffleRecordPanel_TitleText2 = Root:Find("BoxBg/TitleSideBg/Titlebg/TitleText2")
    if locObj_RaffleRecordPanel_TitleText2 then
        locObj_RaffleRecordPanel_TitleText2.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.RaffleRecordPanel_TitleText2
    end

    local locObj_RaffleRecordPanel_StatisticsTitleTxt = Root:Find("BoxBg/StatisticsBoxBg/StatisticsTitleTxt")
    if locObj_RaffleRecordPanel_StatisticsTitleTxt then
        locObj_RaffleRecordPanel_StatisticsTitleTxt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.RaffleRecordPanel_StatisticsTitleTxt
    end

    local locObj_RaffleRecordPanel_ProbabilityTitleTxt = Root:Find("BoxBg/StatisticsBoxBg/ProbabilityTitleTxt")
    if locObj_RaffleRecordPanel_ProbabilityTitleTxt then
        locObj_RaffleRecordPanel_ProbabilityTitleTxt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.RaffleRecordPanel_ProbabilityTitleTxt
    end

    local locObj_RaffleRecordPanel_PoolNameTxt = Root:Find("BoxBg/RecordTitleBox/PoolNameTxt")
    if locObj_RaffleRecordPanel_PoolNameTxt then
        locObj_RaffleRecordPanel_PoolNameTxt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.RaffleRecordPanel_PoolNameTxt
    end

    local locObj_RaffleRecordPanel_RoleNameTxt = Root:Find("BoxBg/RecordTitleBox/RoleNameTxt")
    if locObj_RaffleRecordPanel_RoleNameTxt then
        locObj_RaffleRecordPanel_RoleNameTxt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.RaffleRecordPanel_RoleNameTxt
    end

    local locObj_RaffleRecordPanel_TimeTxt = Root:Find("BoxBg/RecordTitleBox/TimeTxt")
    if locObj_RaffleRecordPanel_TimeTxt then
        locObj_RaffleRecordPanel_TimeTxt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.RaffleRecordPanel_TimeTxt
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return RaffleRecordPanel