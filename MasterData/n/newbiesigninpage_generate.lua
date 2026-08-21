---@class NewbieSignInPage__Generate_rewardInfoBox_decText
---@field public gameObject UnityEngine.GameObject
---@field public text UnityEngine.UI.Text

---@class NewbieSignInPage__Generate_rewardInfoBox_numText
---@field public gameObject UnityEngine.GameObject
---@field public text UnityEngine.UI.Text

---@class NewbieSignInPage__Generate_rewardInfoBox_nameText
---@field public gameObject UnityEngine.GameObject
---@field public text UnityEngine.UI.Text

---@class NewbieSignInPage__Generate_rewardInfoBox
---@field public gameObject UnityEngine.GameObject
---@field public nameText NewbieSignInPage__Generate_rewardInfoBox_nameText
---@field public numText NewbieSignInPage__Generate_rewardInfoBox_numText
---@field public decText NewbieSignInPage__Generate_rewardInfoBox_decText

---@class NewbieSignInPage__Generate_rewardBtn7_numText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class NewbieSignInPage__Generate_rewardBtn7_icon
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class NewbieSignInPage__Generate_rewardBtn7
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public icon NewbieSignInPage__Generate_rewardBtn7_icon
---@field public numText NewbieSignInPage__Generate_rewardBtn7_numText
---@field public getMask UnityEngine.GameObject
---@field public rewardMask UnityEngine.GameObject

---@class NewbieSignInPage__Generate_rewardBtn6_numText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class NewbieSignInPage__Generate_rewardBtn6_icon
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class NewbieSignInPage__Generate_rewardBtn6
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public icon NewbieSignInPage__Generate_rewardBtn6_icon
---@field public numText NewbieSignInPage__Generate_rewardBtn6_numText
---@field public getMask UnityEngine.GameObject
---@field public rewardMask UnityEngine.GameObject

---@class NewbieSignInPage__Generate_rewardBtn5_numText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class NewbieSignInPage__Generate_rewardBtn5_icon
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class NewbieSignInPage__Generate_rewardBtn5
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public icon NewbieSignInPage__Generate_rewardBtn5_icon
---@field public numText NewbieSignInPage__Generate_rewardBtn5_numText
---@field public getMask UnityEngine.GameObject
---@field public rewardMask UnityEngine.GameObject

---@class NewbieSignInPage__Generate_rewardBtn4_numText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class NewbieSignInPage__Generate_rewardBtn4_icon
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class NewbieSignInPage__Generate_rewardBtn4
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public icon NewbieSignInPage__Generate_rewardBtn4_icon
---@field public numText NewbieSignInPage__Generate_rewardBtn4_numText
---@field public getMask UnityEngine.GameObject
---@field public rewardMask UnityEngine.GameObject

---@class NewbieSignInPage__Generate_rewardBtn3_numText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class NewbieSignInPage__Generate_rewardBtn3_icon
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class NewbieSignInPage__Generate_rewardBtn3
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public icon NewbieSignInPage__Generate_rewardBtn3_icon
---@field public numText NewbieSignInPage__Generate_rewardBtn3_numText
---@field public getMask UnityEngine.GameObject
---@field public rewardMask UnityEngine.GameObject

---@class NewbieSignInPage__Generate_rewardBtn2_numText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class NewbieSignInPage__Generate_rewardBtn2_icon
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class NewbieSignInPage__Generate_rewardBtn2
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public icon NewbieSignInPage__Generate_rewardBtn2_icon
---@field public numText NewbieSignInPage__Generate_rewardBtn2_numText
---@field public getMask UnityEngine.GameObject
---@field public rewardMask UnityEngine.GameObject

---@class NewbieSignInPage__Generate_rewardBtn1_numText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class NewbieSignInPage__Generate_rewardBtn1_icon
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class NewbieSignInPage__Generate_rewardBtn1
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public icon NewbieSignInPage__Generate_rewardBtn1_icon
---@field public numText NewbieSignInPage__Generate_rewardBtn1_numText
---@field public getMask UnityEngine.GameObject
---@field public rewardMask UnityEngine.GameObject

---@class NewbieSignInPage__Generate_tipCloseMask
---@field public gameObject UnityEngine.GameObject
---@field public pointerListener PointerListener

---@class NewbieSignInPage__Generate
---@field private gameObject UnityEngine.GameObject
---@field private transform UnityEngine.Transform
---@field private tipCloseMask NewbieSignInPage__Generate_tipCloseMask
---@field private rewardBtn1 NewbieSignInPage__Generate_rewardBtn1
---@field private rewardBtn2 NewbieSignInPage__Generate_rewardBtn2
---@field private rewardBtn3 NewbieSignInPage__Generate_rewardBtn3
---@field private rewardBtn4 NewbieSignInPage__Generate_rewardBtn4
---@field private rewardBtn5 NewbieSignInPage__Generate_rewardBtn5
---@field private rewardBtn6 NewbieSignInPage__Generate_rewardBtn6
---@field private rewardBtn7 NewbieSignInPage__Generate_rewardBtn7
---@field private rewardInfoBox NewbieSignInPage__Generate_rewardInfoBox
local NewbieSignInPage = class("NewbieSignInPage", require("LuaMonoBehavior"))

function NewbieSignInPage:ctor(data)
end

---@private
function NewbieSignInPage:InitGenerate(data)

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
	self:InitGenerate__36(Root,data)
	self:InitGenerate__37(Root,data)
	self:InitGenerate__38(Root,data)
	self:InitGenerate__39(Root,data)
	self:InitGenerate__40(Root,data)
	self:InitGenerate__41(Root,data)

	self:InitLogic(data)

end

---@private
function NewbieSignInPage:InitGenerate__1(Root, data)
--[[
	Root
--]]


end

---@private
function NewbieSignInPage:InitGenerate__2(Root, data)
--[[
	TipCloseMask
--]]
	local tmp = Root:Find("TipCloseMask").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.tipCloseMask = tmp

	tmp.pointerListener = tmp:GetComponent(TypeInfo.PointerListener)


end

---@private
function NewbieSignInPage:InitGenerate__3(Root, data)
--[[
	RewardsGroup/RewardBtn1
--]]
	local tmp = Root:Find("RewardsGroup/RewardBtn1").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardBtn1 = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
			if self.rewardBtn1_ScaleButton_onClick then
				self:rewardBtn1_ScaleButton_onClick(self.rewardBtn1)
			end
		end)


end

---@private
function NewbieSignInPage:InitGenerate__4(Root, data)
--[[
	RewardsGroup/RewardBtn1/Icon
--]]
	local tmp = Root:Find("RewardsGroup/RewardBtn1/Icon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardBtn1.icon = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function NewbieSignInPage:InitGenerate__5(Root, data)
--[[
	RewardsGroup/RewardBtn1/NumText
--]]
	local tmp = Root:Find("RewardsGroup/RewardBtn1/NumText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardBtn1.numText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function NewbieSignInPage:InitGenerate__6(Root, data)
--[[
	RewardsGroup/RewardBtn1/GetMask
--]]
	local tmp = Root:Find("RewardsGroup/RewardBtn1/GetMask").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardBtn1.getMask = tmp


end

---@private
function NewbieSignInPage:InitGenerate__7(Root, data)
--[[
	RewardsGroup/RewardBtn1/RewardMask
--]]
	local tmp = Root:Find("RewardsGroup/RewardBtn1/RewardMask").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardBtn1.rewardMask = tmp


end

---@private
function NewbieSignInPage:InitGenerate__8(Root, data)
--[[
	RewardsGroup/RewardBtn2
--]]
	local tmp = Root:Find("RewardsGroup/RewardBtn2").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardBtn2 = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
			if self.rewardBtn2_ScaleButton_onClick then
				self:rewardBtn2_ScaleButton_onClick(self.rewardBtn2)
			end
		end)


end

---@private
function NewbieSignInPage:InitGenerate__9(Root, data)
--[[
	RewardsGroup/RewardBtn2/Icon
--]]
	local tmp = Root:Find("RewardsGroup/RewardBtn2/Icon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardBtn2.icon = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function NewbieSignInPage:InitGenerate__10(Root, data)
--[[
	RewardsGroup/RewardBtn2/NumText
--]]
	local tmp = Root:Find("RewardsGroup/RewardBtn2/NumText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardBtn2.numText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function NewbieSignInPage:InitGenerate__11(Root, data)
--[[
	RewardsGroup/RewardBtn2/GetMask
--]]
	local tmp = Root:Find("RewardsGroup/RewardBtn2/GetMask").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardBtn2.getMask = tmp


end

---@private
function NewbieSignInPage:InitGenerate__12(Root, data)
--[[
	RewardsGroup/RewardBtn2/RewardMask
--]]
	local tmp = Root:Find("RewardsGroup/RewardBtn2/RewardMask").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardBtn2.rewardMask = tmp


end

---@private
function NewbieSignInPage:InitGenerate__13(Root, data)
--[[
	RewardsGroup/RewardBtn3
--]]
	local tmp = Root:Find("RewardsGroup/RewardBtn3").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardBtn3 = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
			if self.rewardBtn3_ScaleButton_onClick then
				self:rewardBtn3_ScaleButton_onClick(self.rewardBtn3)
			end
		end)


end

---@private
function NewbieSignInPage:InitGenerate__14(Root, data)
--[[
	RewardsGroup/RewardBtn3/Icon
--]]
	local tmp = Root:Find("RewardsGroup/RewardBtn3/Icon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardBtn3.icon = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function NewbieSignInPage:InitGenerate__15(Root, data)
--[[
	RewardsGroup/RewardBtn3/NumText
--]]
	local tmp = Root:Find("RewardsGroup/RewardBtn3/NumText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardBtn3.numText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function NewbieSignInPage:InitGenerate__16(Root, data)
--[[
	RewardsGroup/RewardBtn3/GetMask
--]]
	local tmp = Root:Find("RewardsGroup/RewardBtn3/GetMask").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardBtn3.getMask = tmp


end

---@private
function NewbieSignInPage:InitGenerate__17(Root, data)
--[[
	RewardsGroup/RewardBtn3/RewardMask
--]]
	local tmp = Root:Find("RewardsGroup/RewardBtn3/RewardMask").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardBtn3.rewardMask = tmp


end

---@private
function NewbieSignInPage:InitGenerate__18(Root, data)
--[[
	RewardsGroup/RewardBtn4
--]]
	local tmp = Root:Find("RewardsGroup/RewardBtn4").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardBtn4 = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
			if self.rewardBtn4_ScaleButton_onClick then
				self:rewardBtn4_ScaleButton_onClick(self.rewardBtn4)
			end
		end)


end

---@private
function NewbieSignInPage:InitGenerate__19(Root, data)
--[[
	RewardsGroup/RewardBtn4/Icon
--]]
	local tmp = Root:Find("RewardsGroup/RewardBtn4/Icon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardBtn4.icon = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function NewbieSignInPage:InitGenerate__20(Root, data)
--[[
	RewardsGroup/RewardBtn4/NumText
--]]
	local tmp = Root:Find("RewardsGroup/RewardBtn4/NumText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardBtn4.numText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function NewbieSignInPage:InitGenerate__21(Root, data)
--[[
	RewardsGroup/RewardBtn4/GetMask
--]]
	local tmp = Root:Find("RewardsGroup/RewardBtn4/GetMask").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardBtn4.getMask = tmp


end

---@private
function NewbieSignInPage:InitGenerate__22(Root, data)
--[[
	RewardsGroup/RewardBtn4/RewardMask
--]]
	local tmp = Root:Find("RewardsGroup/RewardBtn4/RewardMask").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardBtn4.rewardMask = tmp


end

---@private
function NewbieSignInPage:InitGenerate__23(Root, data)
--[[
	RewardsGroup/RewardBtn5
--]]
	local tmp = Root:Find("RewardsGroup/RewardBtn5").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardBtn5 = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
			if self.rewardBtn5_ScaleButton_onClick then
				self:rewardBtn5_ScaleButton_onClick(self.rewardBtn5)
			end
		end)


end

---@private
function NewbieSignInPage:InitGenerate__24(Root, data)
--[[
	RewardsGroup/RewardBtn5/Icon
--]]
	local tmp = Root:Find("RewardsGroup/RewardBtn5/Icon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardBtn5.icon = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function NewbieSignInPage:InitGenerate__25(Root, data)
--[[
	RewardsGroup/RewardBtn5/NumText
--]]
	local tmp = Root:Find("RewardsGroup/RewardBtn5/NumText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardBtn5.numText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function NewbieSignInPage:InitGenerate__26(Root, data)
--[[
	RewardsGroup/RewardBtn5/GetMask
--]]
	local tmp = Root:Find("RewardsGroup/RewardBtn5/GetMask").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardBtn5.getMask = tmp


end

---@private
function NewbieSignInPage:InitGenerate__27(Root, data)
--[[
	RewardsGroup/RewardBtn5/RewardMask
--]]
	local tmp = Root:Find("RewardsGroup/RewardBtn5/RewardMask").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardBtn5.rewardMask = tmp


end

---@private
function NewbieSignInPage:InitGenerate__28(Root, data)
--[[
	RewardsGroup/RewardBtn6
--]]
	local tmp = Root:Find("RewardsGroup/RewardBtn6").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardBtn6 = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
			if self.rewardBtn6_ScaleButton_onClick then
				self:rewardBtn6_ScaleButton_onClick(self.rewardBtn6)
			end
		end)


end

---@private
function NewbieSignInPage:InitGenerate__29(Root, data)
--[[
	RewardsGroup/RewardBtn6/Icon
--]]
	local tmp = Root:Find("RewardsGroup/RewardBtn6/Icon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardBtn6.icon = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function NewbieSignInPage:InitGenerate__30(Root, data)
--[[
	RewardsGroup/RewardBtn6/NumText
--]]
	local tmp = Root:Find("RewardsGroup/RewardBtn6/NumText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardBtn6.numText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function NewbieSignInPage:InitGenerate__31(Root, data)
--[[
	RewardsGroup/RewardBtn6/GetMask
--]]
	local tmp = Root:Find("RewardsGroup/RewardBtn6/GetMask").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardBtn6.getMask = tmp


end

---@private
function NewbieSignInPage:InitGenerate__32(Root, data)
--[[
	RewardsGroup/RewardBtn6/RewardMask
--]]
	local tmp = Root:Find("RewardsGroup/RewardBtn6/RewardMask").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardBtn6.rewardMask = tmp


end

---@private
function NewbieSignInPage:InitGenerate__33(Root, data)
--[[
	RewardsGroup/RewardBtn7
--]]
	local tmp = Root:Find("RewardsGroup/RewardBtn7").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardBtn7 = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
			if self.rewardBtn7_ScaleButton_onClick then
				self:rewardBtn7_ScaleButton_onClick(self.rewardBtn7)
			end
		end)


end

---@private
function NewbieSignInPage:InitGenerate__34(Root, data)
--[[
	RewardsGroup/RewardBtn7/Icon
--]]
	local tmp = Root:Find("RewardsGroup/RewardBtn7/Icon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardBtn7.icon = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function NewbieSignInPage:InitGenerate__35(Root, data)
--[[
	RewardsGroup/RewardBtn7/NumText
--]]
	local tmp = Root:Find("RewardsGroup/RewardBtn7/NumText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardBtn7.numText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function NewbieSignInPage:InitGenerate__36(Root, data)
--[[
	RewardsGroup/RewardBtn7/GetMask
--]]
	local tmp = Root:Find("RewardsGroup/RewardBtn7/GetMask").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardBtn7.getMask = tmp


end

---@private
function NewbieSignInPage:InitGenerate__37(Root, data)
--[[
	RewardsGroup/RewardBtn7/RewardMask
--]]
	local tmp = Root:Find("RewardsGroup/RewardBtn7/RewardMask").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardBtn7.rewardMask = tmp


end

---@private
function NewbieSignInPage:InitGenerate__38(Root, data)
--[[
	RewardsGroup/RewardInfoBox
--]]
	local tmp = Root:Find("RewardsGroup/RewardInfoBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardInfoBox = tmp


end

---@private
function NewbieSignInPage:InitGenerate__39(Root, data)
--[[
	RewardsGroup/RewardInfoBox/NameText
--]]
	local tmp = Root:Find("RewardsGroup/RewardInfoBox/NameText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardInfoBox.nameText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.Text)


end

---@private
function NewbieSignInPage:InitGenerate__40(Root, data)
--[[
	RewardsGroup/RewardInfoBox/NumText
--]]
	local tmp = Root:Find("RewardsGroup/RewardInfoBox/NumText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardInfoBox.numText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.Text)


end

---@private
function NewbieSignInPage:InitGenerate__41(Root, data)
--[[
	RewardsGroup/RewardInfoBox/DecText
--]]
	local tmp = Root:Find("RewardsGroup/RewardInfoBox/DecText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.rewardInfoBox.decText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.Text)


end

return NewbieSignInPage