---@class WeeklyBossTagBox_Generate_downPtc
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class WeeklyBossTagBox_Generate_upPtc
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class WeeklyBossTagBox_Generate_emptyText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class WeeklyBossTagBox_Generate_typeText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class WeeklyBossTagBox_Generate_tipsText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class WeeklyBossTagBox_Generate_tagDesc
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public text TMPro.TextMeshProUGUI

---@class WeeklyBossTagBox_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public scaleButton ScaleButton
---@field public haveSelectTag UnityEngine.GameObject
---@field public tagDesc WeeklyBossTagBox_Generate_tagDesc
---@field public notSelectTag UnityEngine.GameObject
---@field public tipsText WeeklyBossTagBox_Generate_tipsText
---@field public typeText WeeklyBossTagBox_Generate_typeText
---@field public emptyTag UnityEngine.GameObject
---@field public emptyText WeeklyBossTagBox_Generate_emptyText
---@field public isSelect UnityEngine.GameObject
---@field public notMeetRequirement UnityEngine.GameObject
---@field public upTag UnityEngine.GameObject
---@field public upPtc WeeklyBossTagBox_Generate_upPtc
---@field public downTag UnityEngine.GameObject
---@field public downPtc WeeklyBossTagBox_Generate_downPtc
---@field public notMeetRequirementTag UnityEngine.GameObject
local WeeklyBossTagBox = class("WeeklyBossTagBox", require("CommonBase"))

function WeeklyBossTagBox:ctor(data)
end

---@private
function WeeklyBossTagBox:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("WeeklyBossTagBox")

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
function WeeklyBossTagBox:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.scaleButton = Root:GetComponent(TypeInfo.ScaleButton)


end

---@private
function WeeklyBossTagBox:InitGenerate__2(Root, data)
--[[
	HaveSelectTag
--]]
	local tmp = Root:Find("HaveSelectTag").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.haveSelectTag = tmp


end

---@private
function WeeklyBossTagBox:InitGenerate__3(Root, data)
--[[
	HaveSelectTag/TagDesc
--]]
	local tmp = Root:Find("HaveSelectTag/TagDesc").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.tagDesc = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function WeeklyBossTagBox:InitGenerate__4(Root, data)
--[[
	NotSelectTag
--]]
	local tmp = Root:Find("NotSelectTag").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.notSelectTag = tmp


end

---@private
function WeeklyBossTagBox:InitGenerate__5(Root, data)
--[[
	NotSelectTag/SelectTipsBg/TipsText
--]]
	local tmp = Root:Find("NotSelectTag/SelectTipsBg/TipsText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.tipsText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function WeeklyBossTagBox:InitGenerate__6(Root, data)
--[[
	NotSelectTag/TagTypeBg/TypeText
--]]
	local tmp = Root:Find("NotSelectTag/TagTypeBg/TypeText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.typeText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function WeeklyBossTagBox:InitGenerate__7(Root, data)
--[[
	EmptyTag
--]]
	local tmp = Root:Find("EmptyTag").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.emptyTag = tmp


end

---@private
function WeeklyBossTagBox:InitGenerate__8(Root, data)
--[[
	EmptyTag/EmptyText
--]]
	local tmp = Root:Find("EmptyTag/EmptyText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.emptyText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function WeeklyBossTagBox:InitGenerate__9(Root, data)
--[[
	IsSelect
--]]
	local tmp = Root:Find("IsSelect").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.isSelect = tmp


end

---@private
function WeeklyBossTagBox:InitGenerate__10(Root, data)
--[[
	NotMeetRequirement
--]]
	local tmp = Root:Find("NotMeetRequirement").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.notMeetRequirement = tmp


end

---@private
function WeeklyBossTagBox:InitGenerate__11(Root, data)
--[[
	UpTag
--]]
	local tmp = Root:Find("UpTag").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.upTag = tmp


end

---@private
function WeeklyBossTagBox:InitGenerate__12(Root, data)
--[[
	UpTag/UpPtc
--]]
	local tmp = Root:Find("UpTag/UpPtc").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.upPtc = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function WeeklyBossTagBox:InitGenerate__13(Root, data)
--[[
	DownTag
--]]
	local tmp = Root:Find("DownTag").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.downTag = tmp


end

---@private
function WeeklyBossTagBox:InitGenerate__14(Root, data)
--[[
	DownTag/DownPtc
--]]
	local tmp = Root:Find("DownTag/DownPtc").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.downPtc = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function WeeklyBossTagBox:InitGenerate__15(Root, data)
--[[
	NotMeetRequirementTag
--]]
	local tmp = Root:Find("NotMeetRequirementTag").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.notMeetRequirementTag = tmp


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function WeeklyBossTagBox:SetLocalizedText(Root)

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return WeeklyBossTagBox