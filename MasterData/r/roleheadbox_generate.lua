---@class RoleHeadBox_Generate_battlePoint_mask
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class RoleHeadBox_Generate_battlePoint_num
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class RoleHeadBox_Generate_battlePoint
---@field public gameObject UnityEngine.GameObject
---@field public highLight UnityEngine.GameObject
---@field public num RoleHeadBox_Generate_battlePoint_num
---@field public mask RoleHeadBox_Generate_battlePoint_mask

---@class RoleHeadBox_Generate_grayMask
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class RoleHeadBox_Generate_noTag
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class RoleHeadBox_Generate_tagTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class RoleHeadBox_Generate_tagBg
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public image UnityEngine.UI.Image
---@field public scaleButton ScaleButton

---@class RoleHeadBox_Generate_levelText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class RoleHeadBox_Generate_energy_num
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class RoleHeadBox_Generate_energy
---@field public gameObject UnityEngine.GameObject
---@field public hp1 UnityEngine.GameObject
---@field public hp2 UnityEngine.GameObject
---@field public hp3 UnityEngine.GameObject
---@field public num RoleHeadBox_Generate_energy_num
---@field public up UnityEngine.GameObject

---@class RoleHeadBox_Generate_shipTypeIcon
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class RoleHeadBox_Generate_starImg
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class RoleHeadBox_Generate_frameImg
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class RoleHeadBox_Generate_roleImg
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class RoleHeadBox_Generate_roleMask
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class RoleHeadBox_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public roleMask RoleHeadBox_Generate_roleMask
---@field public roleImg RoleHeadBox_Generate_roleImg
---@field public frameImg RoleHeadBox_Generate_frameImg
---@field public levelBg UnityEngine.GameObject
---@field public starBg UnityEngine.GameObject
---@field public starImg RoleHeadBox_Generate_starImg
---@field public shipTypeIcon RoleHeadBox_Generate_shipTypeIcon
---@field public energy RoleHeadBox_Generate_energy
---@field public addLab UnityEngine.GameObject
---@field public deployedMark UnityEngine.GameObject
---@field public levelTitle UnityEngine.GameObject
---@field public levelText RoleHeadBox_Generate_levelText
---@field public tagBg RoleHeadBox_Generate_tagBg
---@field public tagTxt RoleHeadBox_Generate_tagTxt
---@field public noTag RoleHeadBox_Generate_noTag
---@field public selImg UnityEngine.GameObject
---@field public grayMask RoleHeadBox_Generate_grayMask
---@field public battlePoint RoleHeadBox_Generate_battlePoint
---@field public advantageousRoot UnityEngine.GameObject
local RoleHeadBox = class("RoleHeadBox", require("CommonBase"))

function RoleHeadBox:ctor(data)
end

---@private
function RoleHeadBox:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("RoleHeadBox")

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

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function RoleHeadBox:InitGenerate__1(Root, data)
--[[
	Root
--]]


end

---@private
function RoleHeadBox:InitGenerate__2(Root, data)
--[[
	RoleMask
--]]
	local tmp = Root:Find("RoleMask").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.roleMask = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("RoleHeadBox_roleMask")
			if self.roleMask_ScaleButton_onClick then
				self:roleMask_ScaleButton_onClick(self.roleMask)
			end
		end)


end

---@private
function RoleHeadBox:InitGenerate__3(Root, data)
--[[
	RoleMask/RoleImg
--]]
	local tmp = Root:Find("RoleMask/RoleImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.roleImg = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function RoleHeadBox:InitGenerate__4(Root, data)
--[[
	RoleMask/FrameImg
--]]
	local tmp = Root:Find("RoleMask/FrameImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.frameImg = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function RoleHeadBox:InitGenerate__5(Root, data)
--[[
	RoleMask/LevelBg
--]]
	local tmp = Root:Find("RoleMask/LevelBg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.levelBg = tmp


end

---@private
function RoleHeadBox:InitGenerate__6(Root, data)
--[[
	RoleMask/StarBg
--]]
	local tmp = Root:Find("RoleMask/StarBg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.starBg = tmp


end

---@private
function RoleHeadBox:InitGenerate__7(Root, data)
--[[
	RoleMask/StarBg/StarImg
--]]
	local tmp = Root:Find("RoleMask/StarBg/StarImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.starImg = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function RoleHeadBox:InitGenerate__8(Root, data)
--[[
	RoleMask/ShipTypeIcon
--]]
	local tmp = Root:Find("RoleMask/ShipTypeIcon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.shipTypeIcon = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function RoleHeadBox:InitGenerate__9(Root, data)
--[[
	RoleMask/Energy
--]]
	local tmp = Root:Find("RoleMask/Energy").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.energy = tmp


end

---@private
function RoleHeadBox:InitGenerate__10(Root, data)
--[[
	RoleMask/Energy/Hp1
--]]
	local tmp = Root:Find("RoleMask/Energy/Hp1").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.energy.hp1 = tmp


end

---@private
function RoleHeadBox:InitGenerate__11(Root, data)
--[[
	RoleMask/Energy/Hp2
--]]
	local tmp = Root:Find("RoleMask/Energy/Hp2").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.energy.hp2 = tmp


end

---@private
function RoleHeadBox:InitGenerate__12(Root, data)
--[[
	RoleMask/Energy/Hp3
--]]
	local tmp = Root:Find("RoleMask/Energy/Hp3").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.energy.hp3 = tmp


end

---@private
function RoleHeadBox:InitGenerate__13(Root, data)
--[[
	RoleMask/Energy/Num
--]]
	local tmp = Root:Find("RoleMask/Energy/Num").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.energy.num = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function RoleHeadBox:InitGenerate__14(Root, data)
--[[
	RoleMask/Energy/Up
--]]
	local tmp = Root:Find("RoleMask/Energy/Up").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.energy.up = tmp


end

---@private
function RoleHeadBox:InitGenerate__15(Root, data)
--[[
	RoleMask/AddLab
--]]
	local tmp = Root:Find("RoleMask/AddLab").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.addLab = tmp


end

---@private
function RoleHeadBox:InitGenerate__16(Root, data)
--[[
	RoleMask/DeployedMark
--]]
	local tmp = Root:Find("RoleMask/DeployedMark").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.deployedMark = tmp


end

---@private
function RoleHeadBox:InitGenerate__17(Root, data)
--[[
	RoleMask/LevelTitle
--]]
	local tmp = Root:Find("RoleMask/LevelTitle").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.levelTitle = tmp


end

---@private
function RoleHeadBox:InitGenerate__18(Root, data)
--[[
	RoleMask/LevelText
--]]
	local tmp = Root:Find("RoleMask/LevelText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.levelText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function RoleHeadBox:InitGenerate__19(Root, data)
--[[
	TagBg
--]]
	local tmp = Root:Find("TagBg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.tagBg = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.image = tmp:GetComponent(TypeInfo.Image)

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("RoleHeadBox_tagBg")
			if self.tagBg_ScaleButton_onClick then
				self:tagBg_ScaleButton_onClick(self.tagBg)
			end
		end)


end

---@private
function RoleHeadBox:InitGenerate__20(Root, data)
--[[
	TagBg/TagTxt
--]]
	local tmp = Root:Find("TagBg/TagTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.tagTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function RoleHeadBox:InitGenerate__21(Root, data)
--[[
	NoTag
--]]
	local tmp = Root:Find("NoTag").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.noTag = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function RoleHeadBox:InitGenerate__22(Root, data)
--[[
	SelImg
--]]
	local tmp = Root:Find("SelImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.selImg = tmp


end

---@private
function RoleHeadBox:InitGenerate__23(Root, data)
--[[
	GrayMask
--]]
	local tmp = Root:Find("GrayMask").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.grayMask = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function RoleHeadBox:InitGenerate__24(Root, data)
--[[
	BattlePoint
--]]
	local tmp = Root:Find("BattlePoint").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.battlePoint = tmp


end

---@private
function RoleHeadBox:InitGenerate__25(Root, data)
--[[
	BattlePoint/HighLight
--]]
	local tmp = Root:Find("BattlePoint/HighLight").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.battlePoint.highLight = tmp


end

---@private
function RoleHeadBox:InitGenerate__26(Root, data)
--[[
	BattlePoint/Num
--]]
	local tmp = Root:Find("BattlePoint/Num").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.battlePoint.num = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function RoleHeadBox:InitGenerate__27(Root, data)
--[[
	BattlePoint/Mask
--]]
	local tmp = Root:Find("BattlePoint/Mask").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.battlePoint.mask = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function RoleHeadBox:InitGenerate__28(Root, data)
--[[
	AdvantageousRoot
--]]
	local tmp = Root:Find("AdvantageousRoot").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.advantageousRoot = tmp


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function RoleHeadBox:SetLocalizedText(Root)

    local locObj_RoleHeadBox_LevelTitle = Root:Find("RoleMask/LevelTitle")
    if locObj_RoleHeadBox_LevelTitle then
        locObj_RoleHeadBox_LevelTitle.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.RoleHeadBox_LevelTitle
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return RoleHeadBox