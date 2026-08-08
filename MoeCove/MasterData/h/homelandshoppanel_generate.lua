---@class HomelandShopPanel_Generate_unlockRefreshBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class HomelandShopPanel_Generate_refreshItemNumText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class HomelandShopPanel_Generate_refreshItemIcon
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class HomelandShopPanel_Generate_refreshBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class HomelandShopPanel_Generate_refreshCountText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class HomelandShopPanel_Generate_refreshTimeText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class HomelandShopPanel_Generate_shopItemPrefab_lockText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class HomelandShopPanel_Generate_shopItemPrefab_oriPicText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class HomelandShopPanel_Generate_shopItemPrefab_picText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class HomelandShopPanel_Generate_shopItemPrefab_picIcon
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class HomelandShopPanel_Generate_shopItemPrefab_buyBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class HomelandShopPanel_Generate_shopItemPrefab_discountText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class HomelandShopPanel_Generate_shopItemPrefab_numText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class HomelandShopPanel_Generate_shopItemPrefab_limitText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class HomelandShopPanel_Generate_shopItemPrefab_nameText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class HomelandShopPanel_Generate_shopItemPrefab_iconImg
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class HomelandShopPanel_Generate_shopItemPrefab_quaityImg
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class HomelandShopPanel_Generate_shopItemPrefab_content
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public canvasGroup UnityEngine.CanvasGroup
---@field public scaleButton ScaleButton

---@class HomelandShopPanel_Generate_shopItemPrefab
---@field public gameObject UnityEngine.GameObject
---@field public content HomelandShopPanel_Generate_shopItemPrefab_content
---@field public quaityImg HomelandShopPanel_Generate_shopItemPrefab_quaityImg
---@field public iconImg HomelandShopPanel_Generate_shopItemPrefab_iconImg
---@field public nameText HomelandShopPanel_Generate_shopItemPrefab_nameText
---@field public limitText HomelandShopPanel_Generate_shopItemPrefab_limitText
---@field public numText HomelandShopPanel_Generate_shopItemPrefab_numText
---@field public discountInfo UnityEngine.GameObject
---@field public discountText HomelandShopPanel_Generate_shopItemPrefab_discountText
---@field public buyBtn HomelandShopPanel_Generate_shopItemPrefab_buyBtn
---@field public picIcon HomelandShopPanel_Generate_shopItemPrefab_picIcon
---@field public picText HomelandShopPanel_Generate_shopItemPrefab_picText
---@field public oriPicText HomelandShopPanel_Generate_shopItemPrefab_oriPicText
---@field public selloutView UnityEngine.GameObject
---@field public lockView UnityEngine.GameObject
---@field public lockText HomelandShopPanel_Generate_shopItemPrefab_lockText

---@class HomelandShopPanel_Generate_shopList
---@field public gameObject UnityEngine.GameObject
---@field public scrollRect UnityEngine.UI.ScrollRect
---@field public loopGridView SuperScrollView.LoopGridView

---@class HomelandShopPanel_Generate_goodsViewBgImage
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class HomelandShopPanel_Generate_goodsViewPanel
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class HomelandShopPanel_Generate_menuListToggle
---@field public gameObject UnityEngine.GameObject
---@field public toggle UnityEngine.UI.Toggle

---@class HomelandShopPanel_Generate_autoRoot
---@field public gameObject UnityEngine.GameObject
---@field public autoAdjustCanvasRoot AutoAdjustCanvasRoot

---@class HomelandShopPanel_Generate_customBackPanel
---@field public gameObject UnityEngine.GameObject
---@field public customBackPanel CustomBackPanel

---@class HomelandShopPanel_Generate_spineRoot
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class HomelandShopPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public spineRoot HomelandShopPanel_Generate_spineRoot
---@field public customBackPanel HomelandShopPanel_Generate_customBackPanel
---@field public autoRoot HomelandShopPanel_Generate_autoRoot
---@field public menuListToggle HomelandShopPanel_Generate_menuListToggle
---@field public goodsViewPanel HomelandShopPanel_Generate_goodsViewPanel
---@field public goodsViewBgImage HomelandShopPanel_Generate_goodsViewBgImage
---@field public shopList HomelandShopPanel_Generate_shopList
---@field public shopItemPrefab HomelandShopPanel_Generate_shopItemPrefab
---@field public refreshInfoView UnityEngine.GameObject
---@field public refreshTimeText HomelandShopPanel_Generate_refreshTimeText
---@field public refreshCountText HomelandShopPanel_Generate_refreshCountText
---@field public refreshBtn HomelandShopPanel_Generate_refreshBtn
---@field public refreshItemInfo UnityEngine.GameObject
---@field public refreshItemIcon HomelandShopPanel_Generate_refreshItemIcon
---@field public refreshItemNumText HomelandShopPanel_Generate_refreshItemNumText
---@field public unlockRefreshBtn HomelandShopPanel_Generate_unlockRefreshBtn
local HomelandShopPanel = class("HomelandShopPanel", require("WndBase"))

function HomelandShopPanel:ctor(data)
end

---@private
function HomelandShopPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("HomelandShopPanel")

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

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function HomelandShopPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function HomelandShopPanel:InitGenerate__2(Root, data)
--[[
	autoRoot/spineRoot
--]]
	local tmp = Root:Find("autoRoot/spineRoot").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.spineRoot = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function HomelandShopPanel:InitGenerate__3(Root, data)
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
function HomelandShopPanel:InitGenerate__4(Root, data)
--[[
	autoRoot
--]]
	local tmp = Root:Find("autoRoot").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.autoRoot = tmp

	tmp.autoAdjustCanvasRoot = tmp:GetComponent(TypeInfo.AutoAdjustCanvasRoot)


end

---@private
function HomelandShopPanel:InitGenerate__5(Root, data)
--[[
	autoRoot/menuListPanel/menuListToggle
--]]
	local tmp = Root:Find("autoRoot/menuListPanel/menuListToggle").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.menuListToggle = tmp

	tmp.toggle = tmp:GetComponent(TypeInfo.Toggle)


end

---@private
function HomelandShopPanel:InitGenerate__6(Root, data)
--[[
	autoRoot/goodsViewPanel
--]]
	local tmp = Root:Find("autoRoot/goodsViewPanel").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.goodsViewPanel = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function HomelandShopPanel:InitGenerate__7(Root, data)
--[[
	autoRoot/goodsViewPanel/goodsViewBgImage
--]]
	local tmp = Root:Find("autoRoot/goodsViewPanel/goodsViewBgImage").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.goodsViewBgImage = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function HomelandShopPanel:InitGenerate__8(Root, data)
--[[
	autoRoot/goodsViewPanel/shopList
--]]
	local tmp = Root:Find("autoRoot/goodsViewPanel/shopList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.shopList = tmp

	tmp.scrollRect = tmp:GetComponent(TypeInfo.ScrollRect)

	tmp.loopGridView = tmp:GetComponent(TypeInfo.LoopGridView)


end

---@private
function HomelandShopPanel:InitGenerate__9(Root, data)
--[[
	autoRoot/goodsViewPanel/shopList/Viewport/Content/shopItemPrefab
--]]
	local tmp = Root:Find("autoRoot/goodsViewPanel/shopList/Viewport/Content/shopItemPrefab").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.shopItemPrefab = tmp


end

---@private
function HomelandShopPanel:InitGenerate__10(Root, data)
--[[
	autoRoot/goodsViewPanel/shopList/Viewport/Content/shopItemPrefab/content
--]]
	local tmp = Root:Find("autoRoot/goodsViewPanel/shopList/Viewport/Content/shopItemPrefab/content").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.shopItemPrefab.content = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)


end

---@private
function HomelandShopPanel:InitGenerate__11(Root, data)
--[[
	autoRoot/goodsViewPanel/shopList/Viewport/Content/shopItemPrefab/content/quaityImg
--]]
	local tmp = Root:Find("autoRoot/goodsViewPanel/shopList/Viewport/Content/shopItemPrefab/content/quaityImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.shopItemPrefab.quaityImg = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function HomelandShopPanel:InitGenerate__12(Root, data)
--[[
	autoRoot/goodsViewPanel/shopList/Viewport/Content/shopItemPrefab/content/iconImg
--]]
	local tmp = Root:Find("autoRoot/goodsViewPanel/shopList/Viewport/Content/shopItemPrefab/content/iconImg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.shopItemPrefab.iconImg = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function HomelandShopPanel:InitGenerate__13(Root, data)
--[[
	autoRoot/goodsViewPanel/shopList/Viewport/Content/shopItemPrefab/content/nameText
--]]
	local tmp = Root:Find("autoRoot/goodsViewPanel/shopList/Viewport/Content/shopItemPrefab/content/nameText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.shopItemPrefab.nameText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function HomelandShopPanel:InitGenerate__14(Root, data)
--[[
	autoRoot/goodsViewPanel/shopList/Viewport/Content/shopItemPrefab/content/limitText
--]]
	local tmp = Root:Find("autoRoot/goodsViewPanel/shopList/Viewport/Content/shopItemPrefab/content/limitText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.shopItemPrefab.limitText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function HomelandShopPanel:InitGenerate__15(Root, data)
--[[
	autoRoot/goodsViewPanel/shopList/Viewport/Content/shopItemPrefab/content/numText
--]]
	local tmp = Root:Find("autoRoot/goodsViewPanel/shopList/Viewport/Content/shopItemPrefab/content/numText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.shopItemPrefab.numText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function HomelandShopPanel:InitGenerate__16(Root, data)
--[[
	autoRoot/goodsViewPanel/shopList/Viewport/Content/shopItemPrefab/content/discountInfo
--]]
	local tmp = Root:Find("autoRoot/goodsViewPanel/shopList/Viewport/Content/shopItemPrefab/content/discountInfo").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.shopItemPrefab.discountInfo = tmp


end

---@private
function HomelandShopPanel:InitGenerate__17(Root, data)
--[[
	autoRoot/goodsViewPanel/shopList/Viewport/Content/shopItemPrefab/content/discountInfo/discountText
--]]
	local tmp = Root:Find("autoRoot/goodsViewPanel/shopList/Viewport/Content/shopItemPrefab/content/discountInfo/discountText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.shopItemPrefab.discountText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function HomelandShopPanel:InitGenerate__18(Root, data)
--[[
	autoRoot/goodsViewPanel/shopList/Viewport/Content/shopItemPrefab/content/buyBtn
--]]
	local tmp = Root:Find("autoRoot/goodsViewPanel/shopList/Viewport/Content/shopItemPrefab/content/buyBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.shopItemPrefab.buyBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("HomelandShopPanel_buyBtn")
			if self.buyBtn_ScaleButton_onClick then
				self:buyBtn_ScaleButton_onClick(self.shopItemPrefab.buyBtn)
			end
		end)


end

---@private
function HomelandShopPanel:InitGenerate__19(Root, data)
--[[
	autoRoot/goodsViewPanel/shopList/Viewport/Content/shopItemPrefab/content/buyBtn/picIcon
--]]
	local tmp = Root:Find("autoRoot/goodsViewPanel/shopList/Viewport/Content/shopItemPrefab/content/buyBtn/picIcon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.shopItemPrefab.picIcon = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function HomelandShopPanel:InitGenerate__20(Root, data)
--[[
	autoRoot/goodsViewPanel/shopList/Viewport/Content/shopItemPrefab/content/buyBtn/picText
--]]
	local tmp = Root:Find("autoRoot/goodsViewPanel/shopList/Viewport/Content/shopItemPrefab/content/buyBtn/picText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.shopItemPrefab.picText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function HomelandShopPanel:InitGenerate__21(Root, data)
--[[
	autoRoot/goodsViewPanel/shopList/Viewport/Content/shopItemPrefab/content/buyBtn/oriPicText
--]]
	local tmp = Root:Find("autoRoot/goodsViewPanel/shopList/Viewport/Content/shopItemPrefab/content/buyBtn/oriPicText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.shopItemPrefab.oriPicText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function HomelandShopPanel:InitGenerate__22(Root, data)
--[[
	autoRoot/goodsViewPanel/shopList/Viewport/Content/shopItemPrefab/content/selloutView
--]]
	local tmp = Root:Find("autoRoot/goodsViewPanel/shopList/Viewport/Content/shopItemPrefab/content/selloutView").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.shopItemPrefab.selloutView = tmp


end

---@private
function HomelandShopPanel:InitGenerate__23(Root, data)
--[[
	autoRoot/goodsViewPanel/shopList/Viewport/Content/shopItemPrefab/content/lockView
--]]
	local tmp = Root:Find("autoRoot/goodsViewPanel/shopList/Viewport/Content/shopItemPrefab/content/lockView").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.shopItemPrefab.lockView = tmp


end

---@private
function HomelandShopPanel:InitGenerate__24(Root, data)
--[[
	autoRoot/goodsViewPanel/shopList/Viewport/Content/shopItemPrefab/content/lockView/maskImg/Image/lockText
--]]
	local tmp = Root:Find("autoRoot/goodsViewPanel/shopList/Viewport/Content/shopItemPrefab/content/lockView/maskImg/Image/lockText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.shopItemPrefab.lockText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function HomelandShopPanel:InitGenerate__25(Root, data)
--[[
	autoRoot/bottomInfoView/refreshInfoView
--]]
	local tmp = Root:Find("autoRoot/bottomInfoView/refreshInfoView").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.refreshInfoView = tmp


end

---@private
function HomelandShopPanel:InitGenerate__26(Root, data)
--[[
	autoRoot/bottomInfoView/refreshInfoView/refreshInfo/refreshTimeText
--]]
	local tmp = Root:Find("autoRoot/bottomInfoView/refreshInfoView/refreshInfo/refreshTimeText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.refreshTimeText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function HomelandShopPanel:InitGenerate__27(Root, data)
--[[
	autoRoot/bottomInfoView/refreshInfoView/refreshCountText
--]]
	local tmp = Root:Find("autoRoot/bottomInfoView/refreshInfoView/refreshCountText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.refreshCountText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function HomelandShopPanel:InitGenerate__28(Root, data)
--[[
	autoRoot/bottomInfoView/refreshInfoView/refreshBtn
--]]
	local tmp = Root:Find("autoRoot/bottomInfoView/refreshInfoView/refreshBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.refreshBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("HomelandShopPanel_refreshBtn")
			if self.refreshBtn_ScaleButton_onClick then
				self:refreshBtn_ScaleButton_onClick(self.refreshBtn)
			end
		end)


end

---@private
function HomelandShopPanel:InitGenerate__29(Root, data)
--[[
	autoRoot/bottomInfoView/refreshInfoView/refreshBtn/refreshItemInfo
--]]
	local tmp = Root:Find("autoRoot/bottomInfoView/refreshInfoView/refreshBtn/refreshItemInfo").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.refreshItemInfo = tmp


end

---@private
function HomelandShopPanel:InitGenerate__30(Root, data)
--[[
	autoRoot/bottomInfoView/refreshInfoView/refreshBtn/refreshItemInfo/refreshItemIcon
--]]
	local tmp = Root:Find("autoRoot/bottomInfoView/refreshInfoView/refreshBtn/refreshItemInfo/refreshItemIcon").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.refreshItemIcon = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function HomelandShopPanel:InitGenerate__31(Root, data)
--[[
	autoRoot/bottomInfoView/refreshInfoView/refreshBtn/refreshItemInfo/refreshItemNumText
--]]
	local tmp = Root:Find("autoRoot/bottomInfoView/refreshInfoView/refreshBtn/refreshItemInfo/refreshItemNumText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.refreshItemNumText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function HomelandShopPanel:InitGenerate__32(Root, data)
--[[
	autoRoot/bottomInfoView/refreshInfoView/unlockRefreshBtn
--]]
	local tmp = Root:Find("autoRoot/bottomInfoView/refreshInfoView/unlockRefreshBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.unlockRefreshBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("HomelandShopPanel_unlockRefreshBtn")
			if self.unlockRefreshBtn_ScaleButton_onClick then
				self:unlockRefreshBtn_ScaleButton_onClick(self.unlockRefreshBtn)
			end
		end)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function HomelandShopPanel:SetLocalizedText(Root)

    local locObj_HomelandShopPanel_Text = Root:Find("autoRoot/goodsViewPanel/shopList/Viewport/Content/shopItemPrefab/content/selloutView/maskImg/Text")
    if locObj_HomelandShopPanel_Text then
        locObj_HomelandShopPanel_Text.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.HomelandShopPanel_Text
    end

    local locObj_HomelandShopPanel_rn_Text = Root:Find("autoRoot/bottomInfoView/refreshInfoView/refreshBtn/Text")
    if locObj_HomelandShopPanel_rn_Text then
        locObj_HomelandShopPanel_rn_Text.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.HomelandShopPanel_rn_Text
    end

    local locObj_HomelandShopPanel_un_Text = Root:Find("autoRoot/bottomInfoView/refreshInfoView/unlockRefreshBtn/Text")
    if locObj_HomelandShopPanel_un_Text then
        locObj_HomelandShopPanel_un_Text.gameObject:GetComponent(TypeInfo.TextMeshProUGUI).text = UILanguageEnum.HomelandShopPanel_un_Text
    end

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return HomelandShopPanel