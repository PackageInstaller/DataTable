---@class EquipStarPanel_Generate_newRankLimitTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class EquipStarPanel_Generate_lastRankLimitTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class EquipStarPanel_Generate_newLevelLimitTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class EquipStarPanel_Generate_lastLevelLimitTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class EquipStarPanel_Generate_newStar_starList_star_6
---@field public gameObject UnityEngine.GameObject
---@field public starOn UnityEngine.GameObject

---@class EquipStarPanel_Generate_newStar_starList_star_5
---@field public gameObject UnityEngine.GameObject
---@field public starOn UnityEngine.GameObject

---@class EquipStarPanel_Generate_newStar_starList_star_4
---@field public gameObject UnityEngine.GameObject
---@field public starOn UnityEngine.GameObject

---@class EquipStarPanel_Generate_newStar_starList_star_3
---@field public gameObject UnityEngine.GameObject
---@field public starOn UnityEngine.GameObject

---@class EquipStarPanel_Generate_newStar_starList_star_2
---@field public gameObject UnityEngine.GameObject
---@field public starOn UnityEngine.GameObject

---@class EquipStarPanel_Generate_newStar_starList_star_1
---@field public gameObject UnityEngine.GameObject
---@field public starOn UnityEngine.GameObject

---@class EquipStarPanel_Generate_newStar_starList
---@field public gameObject UnityEngine.GameObject
---@field public star_1 EquipStarPanel_Generate_newStar_starList_star_1
---@field public star_2 EquipStarPanel_Generate_newStar_starList_star_2
---@field public star_3 EquipStarPanel_Generate_newStar_starList_star_3
---@field public star_4 EquipStarPanel_Generate_newStar_starList_star_4
---@field public star_5 EquipStarPanel_Generate_newStar_starList_star_5
---@field public star_6 EquipStarPanel_Generate_newStar_starList_star_6

---@class EquipStarPanel_Generate_newStar
---@field public gameObject UnityEngine.GameObject
---@field public starList EquipStarPanel_Generate_newStar_starList

---@class EquipStarPanel_Generate_nowStar_starList_star_6
---@field public gameObject UnityEngine.GameObject
---@field public starOn UnityEngine.GameObject

---@class EquipStarPanel_Generate_nowStar_starList_star_5
---@field public gameObject UnityEngine.GameObject
---@field public starOn UnityEngine.GameObject

---@class EquipStarPanel_Generate_nowStar_starList_star_4
---@field public gameObject UnityEngine.GameObject
---@field public starOn UnityEngine.GameObject

---@class EquipStarPanel_Generate_nowStar_starList_star_3
---@field public gameObject UnityEngine.GameObject
---@field public starOn UnityEngine.GameObject

---@class EquipStarPanel_Generate_nowStar_starList_star_2
---@field public gameObject UnityEngine.GameObject
---@field public starOn UnityEngine.GameObject

---@class EquipStarPanel_Generate_nowStar_starList_star_1
---@field public gameObject UnityEngine.GameObject
---@field public starOn UnityEngine.GameObject

---@class EquipStarPanel_Generate_nowStar_starList
---@field public gameObject UnityEngine.GameObject
---@field public star_1 EquipStarPanel_Generate_nowStar_starList_star_1
---@field public star_2 EquipStarPanel_Generate_nowStar_starList_star_2
---@field public star_3 EquipStarPanel_Generate_nowStar_starList_star_3
---@field public star_4 EquipStarPanel_Generate_nowStar_starList_star_4
---@field public star_5 EquipStarPanel_Generate_nowStar_starList_star_5
---@field public star_6 EquipStarPanel_Generate_nowStar_starList_star_6

---@class EquipStarPanel_Generate_nowStar
---@field public gameObject UnityEngine.GameObject
---@field public starList EquipStarPanel_Generate_nowStar_starList

---@class EquipStarPanel_Generate_equipBox
---@field public gameObject UnityEngine.GameObject
---@field public customBox CustomBox

---@class EquipStarPanel_Generate_mask
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class EquipStarPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public mask EquipStarPanel_Generate_mask
---@field public equipBox EquipStarPanel_Generate_equipBox
---@field public nowStar EquipStarPanel_Generate_nowStar
---@field public newStar EquipStarPanel_Generate_newStar
---@field public lastLevelLimitTxt EquipStarPanel_Generate_lastLevelLimitTxt
---@field public newLevelLimitTxt EquipStarPanel_Generate_newLevelLimitTxt
---@field public lastRankLimitTxt EquipStarPanel_Generate_lastRankLimitTxt
---@field public newRankLimitTxt EquipStarPanel_Generate_newRankLimitTxt
local EquipStarPanel = class("EquipStarPanel", require("WndBase"))

function EquipStarPanel:ctor(data)
end

---@private
function EquipStarPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("EquipStarPanel")

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
	self:InitGenerate__30(Root,data)
	self:InitGenerate__31(Root,data)
	self:InitGenerate__32(Root,data)
	self:InitGenerate__33(Root,data)
	self:InitGenerate__34(Root,data)
	self:InitGenerate__35(Root,data)

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function EquipStarPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function EquipStarPanel:InitGenerate__2(Root, data)
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
		UIMgr:SendUiUseMessage("EquipStarPanel_mask")
			if self.mask_Button_onClick then
				self:mask_Button_onClick(self.mask)
			end
		end)


end

---@private
function EquipStarPanel:InitGenerate__3(Root, data)
--[[
	EquipBox
--]]
	local tmp = Root:Find("EquipBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.equipBox = tmp

	tmp.customBox = tmp:AddComponentLua("CustomBox", data)


end

---@private
function EquipStarPanel:InitGenerate__4(Root, data)
--[[
	StarBg/NowStar
--]]
	local tmp = Root:Find("StarBg/NowStar").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.nowStar = tmp


end

---@private
function EquipStarPanel:InitGenerate__5(Root, data)
--[[
	StarBg/NowStar/StarList
--]]
	local tmp = Root:Find("StarBg/NowStar/StarList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.nowStar.starList = tmp


end

---@private
function EquipStarPanel:InitGenerate__6(Root, data)
--[[
	StarBg/NowStar/StarList/Star_1
--]]
	local tmp = Root:Find("StarBg/NowStar/StarList/Star_1").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.nowStar.starList.star_1 = tmp


end

---@private
function EquipStarPanel:InitGenerate__7(Root, data)
--[[
	StarBg/NowStar/StarList/Star_1/StarOn
--]]
	local tmp = Root:Find("StarBg/NowStar/StarList/Star_1/StarOn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.nowStar.starList.star_1.starOn = tmp


end

---@private
function EquipStarPanel:InitGenerate__8(Root, data)
--[[
	StarBg/NowStar/StarList/Star_2
--]]
	local tmp = Root:Find("StarBg/NowStar/StarList/Star_2").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.nowStar.starList.star_2 = tmp


end

---@private
function EquipStarPanel:InitGenerate__9(Root, data)
--[[
	StarBg/NowStar/StarList/Star_2/StarOn
--]]
	local tmp = Root:Find("StarBg/NowStar/StarList/Star_2/StarOn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.nowStar.starList.star_2.starOn = tmp


end

---@private
function EquipStarPanel:InitGenerate__10(Root, data)
--[[
	StarBg/NowStar/StarList/Star_3
--]]
	local tmp = Root:Find("StarBg/NowStar/StarList/Star_3").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.nowStar.starList.star_3 = tmp


end

---@private
function EquipStarPanel:InitGenerate__11(Root, data)
--[[
	StarBg/NowStar/StarList/Star_3/StarOn
--]]
	local tmp = Root:Find("StarBg/NowStar/StarList/Star_3/StarOn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.nowStar.starList.star_3.starOn = tmp


end

---@private
function EquipStarPanel:InitGenerate__12(Root, data)
--[[
	StarBg/NowStar/StarList/Star_4
--]]
	local tmp = Root:Find("StarBg/NowStar/StarList/Star_4").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.nowStar.starList.star_4 = tmp


end

---@private
function EquipStarPanel:InitGenerate__13(Root, data)
--[[
	StarBg/NowStar/StarList/Star_4/StarOn
--]]
	local tmp = Root:Find("StarBg/NowStar/StarList/Star_4/StarOn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.nowStar.starList.star_4.starOn = tmp


end

---@private
function EquipStarPanel:InitGenerate__14(Root, data)
--[[
	StarBg/NowStar/StarList/Star_5
--]]
	local tmp = Root:Find("StarBg/NowStar/StarList/Star_5").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.nowStar.starList.star_5 = tmp


end

---@private
function EquipStarPanel:InitGenerate__15(Root, data)
--[[
	StarBg/NowStar/StarList/Star_5/StarOn
--]]
	local tmp = Root:Find("StarBg/NowStar/StarList/Star_5/StarOn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.nowStar.starList.star_5.starOn = tmp


end

---@private
function EquipStarPanel:InitGenerate__16(Root, data)
--[[
	StarBg/NowStar/StarList/Star_6
--]]
	local tmp = Root:Find("StarBg/NowStar/StarList/Star_6").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.nowStar.starList.star_6 = tmp


end

---@private
function EquipStarPanel:InitGenerate__17(Root, data)
--[[
	StarBg/NowStar/StarList/Star_6/StarOn
--]]
	local tmp = Root:Find("StarBg/NowStar/StarList/Star_6/StarOn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.nowStar.starList.star_6.starOn = tmp


end

---@private
function EquipStarPanel:InitGenerate__18(Root, data)
--[[
	StarBg/NewStar
--]]
	local tmp = Root:Find("StarBg/NewStar").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.newStar = tmp


end

---@private
function EquipStarPanel:InitGenerate__19(Root, data)
--[[
	StarBg/NewStar/StarList
--]]
	local tmp = Root:Find("StarBg/NewStar/StarList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.newStar.starList = tmp


end

---@private
function EquipStarPanel:InitGenerate__20(Root, data)
--[[
	StarBg/NewStar/StarList/Star_1
--]]
	local tmp = Root:Find("StarBg/NewStar/StarList/Star_1").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.newStar.starList.star_1 = tmp


end

---@private
function EquipStarPanel:InitGenerate__21(Root, data)
--[[
	StarBg/NewStar/StarList/Star_1/StarOn
--]]
	local tmp = Root:Find("StarBg/NewStar/StarList/Star_1/StarOn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.newStar.starList.star_1.starOn = tmp


end

---@private
function EquipStarPanel:InitGenerate__22(Root, data)
--[[
	StarBg/NewStar/StarList/Star_2
--]]
	local tmp = Root:Find("StarBg/NewStar/StarList/Star_2").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.newStar.starList.star_2 = tmp


end

---@private
function EquipStarPanel:InitGenerate__23(Root, data)
--[[
	StarBg/NewStar/StarList/Star_2/StarOn
--]]
	local tmp = Root:Find("StarBg/NewStar/StarList/Star_2/StarOn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.newStar.starList.star_2.starOn = tmp


end

---@private
function EquipStarPanel:InitGenerate__24(Root, data)
--[[
	StarBg/NewStar/StarList/Star_3
--]]
	local tmp = Root:Find("StarBg/NewStar/StarList/Star_3").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.newStar.starList.star_3 = tmp


end

---@private
function EquipStarPanel:InitGenerate__25(Root, data)
--[[
	StarBg/NewStar/StarList/Star_3/StarOn
--]]
	local tmp = Root:Find("StarBg/NewStar/StarList/Star_3/StarOn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.newStar.starList.star_3.starOn = tmp


end

---@private
function EquipStarPanel:InitGenerate__26(Root, data)
--[[
	StarBg/NewStar/StarList/Star_4
--]]
	local tmp = Root:Find("StarBg/NewStar/StarList/Star_4").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.newStar.starList.star_4 = tmp


end

---@private
function EquipStarPanel:InitGenerate__27(Root, data)
--[[
	StarBg/NewStar/StarList/Star_4/StarOn
--]]
	local tmp = Root:Find("StarBg/NewStar/StarList/Star_4/StarOn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.newStar.starList.star_4.starOn = tmp


end

---@private
function EquipStarPanel:InitGenerate__28(Root, data)
--[[
	StarBg/NewStar/StarList/Star_5
--]]
	local tmp = Root:Find("StarBg/NewStar/StarList/Star_5").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.newStar.starList.star_5 = tmp


end

---@private
function EquipStarPanel:InitGenerate__29(Root, data)
--[[
	StarBg/NewStar/StarList/Star_5/StarOn
--]]
	local tmp = Root:Find("StarBg/NewStar/StarList/Star_5/StarOn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.newStar.starList.star_5.starOn = tmp


end

---@private
function EquipStarPanel:InitGenerate__30(Root, data)
--[[
	StarBg/NewStar/StarList/Star_6
--]]
	local tmp = Root:Find("StarBg/NewStar/StarList/Star_6").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.newStar.starList.star_6 = tmp


end

---@private
function EquipStarPanel:InitGenerate__31(Root, data)
--[[
	StarBg/NewStar/StarList/Star_6/StarOn
--]]
	local tmp = Root:Find("StarBg/NewStar/StarList/Star_6/StarOn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.newStar.starList.star_6.starOn = tmp


end

---@private
function EquipStarPanel:InitGenerate__32(Root, data)
--[[
	LevelLimitBg/LastLevelLimitTxt
--]]
	local tmp = Root:Find("LevelLimitBg/LastLevelLimitTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.lastLevelLimitTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function EquipStarPanel:InitGenerate__33(Root, data)
--[[
	LevelLimitBg/NewLevelLimitTxt
--]]
	local tmp = Root:Find("LevelLimitBg/NewLevelLimitTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.newLevelLimitTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function EquipStarPanel:InitGenerate__34(Root, data)
--[[
	RankLimitBg/LastRankLimitTxt
--]]
	local tmp = Root:Find("RankLimitBg/LastRankLimitTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.lastRankLimitTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function EquipStarPanel:InitGenerate__35(Root, data)
--[[
	RankLimitBg/NewRankLimitTxt
--]]
	local tmp = Root:Find("RankLimitBg/NewRankLimitTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.newRankLimitTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function EquipStarPanel:SetLocalizedText(Root)

    local locObj_StarUpPanel_Tips = Root:Find("Tips")
    if locObj_StarUpPanel_Tips then
        locObj_StarUpPanel_Tips.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.StarUpPanel_Tips
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return EquipStarPanel