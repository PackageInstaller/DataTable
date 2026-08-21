---@class SkillMsgPanel_Generate_unEquipBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class SkillMsgPanel_Generate_changeBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class SkillMsgPanel_Generate_equipBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class SkillMsgPanel_Generate_skillTypeBox_2_typeTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class SkillMsgPanel_Generate_skillTypeBox_2
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image
---@field public typeTxt SkillMsgPanel_Generate_skillTypeBox_2_typeTxt

---@class SkillMsgPanel_Generate_skillTypeBox_1_typeTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class SkillMsgPanel_Generate_skillTypeBox_1
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image
---@field public typeTxt SkillMsgPanel_Generate_skillTypeBox_1_typeTxt

---@class SkillMsgPanel_Generate_rangebox
---@field public gameObject UnityEngine.GameObject
---@field public rangeIcon1 UnityEngine.GameObject
---@field public rangeIcon2 UnityEngine.GameObject
---@field public rangeIcon3 UnityEngine.GameObject
---@field public rangeIcon4 UnityEngine.GameObject

---@class SkillMsgPanel_Generate_skillRangeList
---@field public gameObject UnityEngine.GameObject
---@field public gridLayoutGroup UnityEngine.UI.GridLayoutGroup

---@class SkillMsgPanel_Generate_skillRangeTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class SkillMsgPanel_Generate_preCdTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class SkillMsgPanel_Generate_skillMsgTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class SkillMsgPanel_Generate_skillMsgList
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public button UnityEngine.UI.Button

---@class SkillMsgPanel_Generate_skillrePlaceBox_skillrePlaceTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class SkillMsgPanel_Generate_skillrePlaceBox
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image
---@field public skillrePlaceTxt SkillMsgPanel_Generate_skillrePlaceBox_skillrePlaceTxt

---@class SkillMsgPanel_Generate_skillNameTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class SkillMsgPanel_Generate_iconImg
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class SkillMsgPanel_Generate_countTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class SkillMsgPanel_Generate_skillMsgBg
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class SkillMsgPanel_Generate_mask
---@field public gameObject UnityEngine.GameObject
---@field public dragListener DragListener
---@field public pointerListener PointerListener

---@class SkillMsgPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public rectTransform UnityEngine.RectTransform
---@field public mask SkillMsgPanel_Generate_mask
---@field public skillMsgBg SkillMsgPanel_Generate_skillMsgBg
---@field public countBg UnityEngine.GameObject
---@field public countTxt SkillMsgPanel_Generate_countTxt
---@field public iconImg SkillMsgPanel_Generate_iconImg
---@field public isAnim UnityEngine.GameObject
---@field public skillNameTxt SkillMsgPanel_Generate_skillNameTxt
---@field public skillrePlaceBox SkillMsgPanel_Generate_skillrePlaceBox
---@field public skillMsgList SkillMsgPanel_Generate_skillMsgList
---@field public skillMsgTxt SkillMsgPanel_Generate_skillMsgTxt
---@field public rangeBg UnityEngine.GameObject
---@field public preCdTxt SkillMsgPanel_Generate_preCdTxt
---@field public skillRangeTxt SkillMsgPanel_Generate_skillRangeTxt
---@field public skillRangeList SkillMsgPanel_Generate_skillRangeList
---@field public rangebox SkillMsgPanel_Generate_rangebox
---@field public skillTypeBox_1 SkillMsgPanel_Generate_skillTypeBox_1
---@field public skillTypeBox_2 SkillMsgPanel_Generate_skillTypeBox_2
---@field public hasLine UnityEngine.GameObject
---@field public equipBtn SkillMsgPanel_Generate_equipBtn
---@field public changeBtn SkillMsgPanel_Generate_changeBtn
---@field public unEquipBtn SkillMsgPanel_Generate_unEquipBtn
local SkillMsgPanel = class("SkillMsgPanel", require("CommonBase"))

function SkillMsgPanel:ctor(data)
end

---@private
function SkillMsgPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("SkillMsgPanel")

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
	self:InitGenerate__25(Root,data)
	self:InitGenerate__26(Root,data)
	self:InitGenerate__27(Root,data)
	self:InitGenerate__28(Root,data)
	self:InitGenerate__29(Root,data)

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function SkillMsgPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.rectTransform = Root:GetComponent(TypeInfo.RectTransform)


end

---@private
function SkillMsgPanel:InitGenerate__2(Root, data)
--[[
	Mask
--]]
	local tmp = Root:Find("Mask").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.mask = tmp

	tmp.dragListener = tmp:GetComponent(TypeInfo.DragListener)

	tmp.pointerListener = tmp:GetComponent(TypeInfo.PointerListener)


end

---@private
function SkillMsgPanel:InitGenerate__3(Root, data)
--[[
	SkillMsgBg
--]]
	local tmp = Root:Find("SkillMsgBg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.skillMsgBg = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function SkillMsgPanel:InitGenerate__4(Root, data)
--[[
	SkillMsgBg/CountBg
--]]
	local tmp = Root:Find("SkillMsgBg/CountBg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.countBg = tmp


end

---@private
function SkillMsgPanel:InitGenerate__5(Root, data)
--[[
	SkillMsgBg/CountBg/CountTxt
--]]
	local tmp = Root:Find("SkillMsgBg/CountBg/CountTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.countTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function SkillMsgPanel:InitGenerate__6(Root, data)
--[[
	SkillMsgBg/IconBg/IconImg
--]]
	local tmp = Root:Find("SkillMsgBg/IconBg/IconImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.iconImg = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function SkillMsgPanel:InitGenerate__7(Root, data)
--[[
	SkillMsgBg/IconBg/IsAnim
--]]
	local tmp = Root:Find("SkillMsgBg/IconBg/IsAnim").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.isAnim = tmp


end

---@private
function SkillMsgPanel:InitGenerate__8(Root, data)
--[[
	SkillMsgBg/SkillNameTxt
--]]
	local tmp = Root:Find("SkillMsgBg/SkillNameTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.skillNameTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function SkillMsgPanel:InitGenerate__9(Root, data)
--[[
	SkillMsgBg/SkillrePlaceBox
--]]
	local tmp = Root:Find("SkillMsgBg/SkillrePlaceBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.skillrePlaceBox = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function SkillMsgPanel:InitGenerate__10(Root, data)
--[[
	SkillMsgBg/SkillrePlaceBox/SkillrePlaceTxt
--]]
	local tmp = Root:Find("SkillMsgBg/SkillrePlaceBox/SkillrePlaceTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.skillrePlaceBox.skillrePlaceTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function SkillMsgPanel:InitGenerate__11(Root, data)
--[[
	SkillMsgBg/SkillMsgList
--]]
	local tmp = Root:Find("SkillMsgBg/SkillMsgList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.skillMsgList = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("SkillMsgPanel_skillMsgList")
			if self.skillMsgList_Button_onClick then
				self:skillMsgList_Button_onClick(self.skillMsgList)
			end
		end)


end

---@private
function SkillMsgPanel:InitGenerate__12(Root, data)
--[[
	SkillMsgBg/SkillMsgList/Viewport/SkillMsgTxt
--]]
	local tmp = Root:Find("SkillMsgBg/SkillMsgList/Viewport/SkillMsgTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.skillMsgTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function SkillMsgPanel:InitGenerate__13(Root, data)
--[[
	SkillMsgBg/RangeBg
--]]
	local tmp = Root:Find("SkillMsgBg/RangeBg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rangeBg = tmp


end

---@private
function SkillMsgPanel:InitGenerate__14(Root, data)
--[[
	SkillMsgBg/RangeBg/preCdBg/preCdTxt
--]]
	local tmp = Root:Find("SkillMsgBg/RangeBg/preCdBg/preCdTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.preCdTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function SkillMsgPanel:InitGenerate__15(Root, data)
--[[
	SkillMsgBg/RangeBg/skillRangeInfo/skillRangeTxt
--]]
	local tmp = Root:Find("SkillMsgBg/RangeBg/skillRangeInfo/skillRangeTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.skillRangeTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function SkillMsgPanel:InitGenerate__16(Root, data)
--[[
	SkillMsgBg/RangeBg/skillRangeBg/skillRangeList
--]]
	local tmp = Root:Find("SkillMsgBg/RangeBg/skillRangeBg/skillRangeList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.skillRangeList = tmp

	tmp.gridLayoutGroup = tmp:GetComponent(TypeInfo.GridLayoutGroup)


end

---@private
function SkillMsgPanel:InitGenerate__17(Root, data)
--[[
	SkillMsgBg/RangeBg/skillRangeBg/skillRangeList/rangebox
--]]
	local tmp = Root:Find("SkillMsgBg/RangeBg/skillRangeBg/skillRangeList/rangebox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rangebox = tmp


end

---@private
function SkillMsgPanel:InitGenerate__18(Root, data)
--[[
	SkillMsgBg/RangeBg/skillRangeBg/skillRangeList/rangebox/rangeIcon1
--]]
	local tmp = Root:Find("SkillMsgBg/RangeBg/skillRangeBg/skillRangeList/rangebox/rangeIcon1").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rangebox.rangeIcon1 = tmp


end

---@private
function SkillMsgPanel:InitGenerate__19(Root, data)
--[[
	SkillMsgBg/RangeBg/skillRangeBg/skillRangeList/rangebox/rangeIcon2
--]]
	local tmp = Root:Find("SkillMsgBg/RangeBg/skillRangeBg/skillRangeList/rangebox/rangeIcon2").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rangebox.rangeIcon2 = tmp


end

---@private
function SkillMsgPanel:InitGenerate__20(Root, data)
--[[
	SkillMsgBg/RangeBg/skillRangeBg/skillRangeList/rangebox/rangeIcon3
--]]
	local tmp = Root:Find("SkillMsgBg/RangeBg/skillRangeBg/skillRangeList/rangebox/rangeIcon3").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rangebox.rangeIcon3 = tmp


end

---@private
function SkillMsgPanel:InitGenerate__21(Root, data)
--[[
	SkillMsgBg/RangeBg/skillRangeBg/skillRangeList/rangebox/rangeIcon4
--]]
	local tmp = Root:Find("SkillMsgBg/RangeBg/skillRangeBg/skillRangeList/rangebox/rangeIcon4").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rangebox.rangeIcon4 = tmp


end

---@private
function SkillMsgPanel:InitGenerate__22(Root, data)
--[[
	SkillMsgBg/RangeBg/skillTypeBg/SkillTypeBox_1
--]]
	local tmp = Root:Find("SkillMsgBg/RangeBg/skillTypeBg/SkillTypeBox_1").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.skillTypeBox_1 = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function SkillMsgPanel:InitGenerate__23(Root, data)
--[[
	SkillMsgBg/RangeBg/skillTypeBg/SkillTypeBox_1/TypeTxt
--]]
	local tmp = Root:Find("SkillMsgBg/RangeBg/skillTypeBg/SkillTypeBox_1/TypeTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.skillTypeBox_1.typeTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function SkillMsgPanel:InitGenerate__24(Root, data)
--[[
	SkillMsgBg/RangeBg/skillTypeBg/SkillTypeBox_2
--]]
	local tmp = Root:Find("SkillMsgBg/RangeBg/skillTypeBg/SkillTypeBox_2").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.skillTypeBox_2 = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function SkillMsgPanel:InitGenerate__25(Root, data)
--[[
	SkillMsgBg/RangeBg/skillTypeBg/SkillTypeBox_2/TypeTxt
--]]
	local tmp = Root:Find("SkillMsgBg/RangeBg/skillTypeBg/SkillTypeBox_2/TypeTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.skillTypeBox_2.typeTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function SkillMsgPanel:InitGenerate__26(Root, data)
--[[
	SkillMsgBg/HasLine
--]]
	local tmp = Root:Find("SkillMsgBg/HasLine").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.hasLine = tmp


end

---@private
function SkillMsgPanel:InitGenerate__27(Root, data)
--[[
	SkillMsgBg/EquipBtn
--]]
	local tmp = Root:Find("SkillMsgBg/EquipBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.equipBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("SkillMsgPanel_equipBtn")
			if self.equipBtn_ScaleButton_onClick then
				self:equipBtn_ScaleButton_onClick(self.equipBtn)
			end
		end)


end

---@private
function SkillMsgPanel:InitGenerate__28(Root, data)
--[[
	SkillMsgBg/ChangeBtn
--]]
	local tmp = Root:Find("SkillMsgBg/ChangeBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.changeBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("SkillMsgPanel_changeBtn")
			if self.changeBtn_ScaleButton_onClick then
				self:changeBtn_ScaleButton_onClick(self.changeBtn)
			end
		end)


end

---@private
function SkillMsgPanel:InitGenerate__29(Root, data)
--[[
	SkillMsgBg/UnEquipBtn
--]]
	local tmp = Root:Find("SkillMsgBg/UnEquipBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.unEquipBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("SkillMsgPanel_unEquipBtn")
			if self.unEquipBtn_ScaleButton_onClick then
				self:unEquipBtn_ScaleButton_onClick(self.unEquipBtn)
			end
		end)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function SkillMsgPanel:SetLocalizedText(Root)

    local locObj_SkillMsgPanel_preCdTitle = Root:Find("SkillMsgBg/RangeBg/preCdBg/preCdTitle")
    if locObj_SkillMsgPanel_preCdTitle then
        locObj_SkillMsgPanel_preCdTitle.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.SkillMsgPanel_preCdTitle
    end

    local locObj_SkillMsgPanel_skillRangeTitle = Root:Find("SkillMsgBg/RangeBg/skillRangeInfo/skillRangeTitle")
    if locObj_SkillMsgPanel_skillRangeTitle then
        locObj_SkillMsgPanel_skillRangeTitle.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.SkillMsgPanel_skillRangeTitle
    end

    local locObj_SkillMsgPanel_txt = Root:Find("SkillMsgBg/EquipBtn/txt")
    if locObj_SkillMsgPanel_txt then
        locObj_SkillMsgPanel_txt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.SkillMsgPanel_txt
    end

    local locObj_SkillMsgPanel_Cn_txt = Root:Find("SkillMsgBg/ChangeBtn/txt")
    if locObj_SkillMsgPanel_Cn_txt then
        locObj_SkillMsgPanel_Cn_txt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.SkillMsgPanel_Cn_txt
    end

    local locObj_SkillMsgPanel_Un_txt = Root:Find("SkillMsgBg/UnEquipBtn/txt")
    if locObj_SkillMsgPanel_Un_txt then
        locObj_SkillMsgPanel_Un_txt.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.SkillMsgPanel_Un_txt
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return SkillMsgPanel