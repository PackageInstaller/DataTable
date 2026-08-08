---@class BattleStoryPanel_Generate_endCurtain
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class BattleStoryPanel_Generate_curtain
---@field public gameObject UnityEngine.GameObject
---@field public canvasGroup UnityEngine.CanvasGroup

---@class BattleStoryPanel_Generate_skipBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class BattleStoryPanel_Generate_doAuto
---@field public gameObject UnityEngine.GameObject
---@field public canvasGroup UnityEngine.CanvasGroup

---@class BattleStoryPanel_Generate_unAuto
---@field public gameObject UnityEngine.GameObject
---@field public canvasGroup UnityEngine.CanvasGroup

---@class BattleStoryPanel_Generate_round
---@field public gameObject UnityEngine.GameObject
---@field public animator UnityEngine.Animator

---@class BattleStoryPanel_Generate_autoBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class BattleStoryPanel_Generate_speakEmote_emoteSpine
---@field public gameObject UnityEngine.GameObject
---@field public skeletonGraphic Spine.Unity.SkeletonGraphic
---@field public skeletonAnimation Spine.Unity.SkeletonAnimation

---@class BattleStoryPanel_Generate_speakEmote
---@field public gameObject UnityEngine.GameObject
---@field public emoteSpine BattleStoryPanel_Generate_speakEmote_emoteSpine

---@class BattleStoryPanel_Generate_speakBubble_rootPos4
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class BattleStoryPanel_Generate_speakBubble_rootPos3
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class BattleStoryPanel_Generate_speakBubble_rootPos2
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class BattleStoryPanel_Generate_speakBubble_rootPos1
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class BattleStoryPanel_Generate_speakBubble_wordsTxt
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public text TMPro.TextMeshProUGUI

---@class BattleStoryPanel_Generate_speakBubble_wordsRoot
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class BattleStoryPanel_Generate_speakBubble_nameText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class BattleStoryPanel_Generate_speakBubble_nameBg
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class BattleStoryPanel_Generate_speakBubble_headIconFrame
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform

---@class BattleStoryPanel_Generate_speakBubble_bubbleBg
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image

---@class BattleStoryPanel_Generate_speakBubble
---@field public gameObject UnityEngine.GameObject
---@field public canvasGroup UnityEngine.CanvasGroup
---@field public bubbleBg BattleStoryPanel_Generate_speakBubble_bubbleBg
---@field public bubbleMiddle UnityEngine.GameObject
---@field public headIconFrame BattleStoryPanel_Generate_speakBubble_headIconFrame
---@field public roleRoot UnityEngine.GameObject
---@field public nameBg BattleStoryPanel_Generate_speakBubble_nameBg
---@field public nameText BattleStoryPanel_Generate_speakBubble_nameText
---@field public wordsRoot BattleStoryPanel_Generate_speakBubble_wordsRoot
---@field public wordsTxt BattleStoryPanel_Generate_speakBubble_wordsTxt
---@field public nextArrow UnityEngine.GameObject
---@field public rootPos1 BattleStoryPanel_Generate_speakBubble_rootPos1
---@field public rootPos2 BattleStoryPanel_Generate_speakBubble_rootPos2
---@field public rootPos3 BattleStoryPanel_Generate_speakBubble_rootPos3
---@field public rootPos4 BattleStoryPanel_Generate_speakBubble_rootPos4

---@class BattleStoryPanel_Generate_doNextBtn
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button

---@class BattleStoryPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public doNextBtn BattleStoryPanel_Generate_doNextBtn
---@field public speakBubblesList UnityEngine.GameObject
---@field public speakBubble BattleStoryPanel_Generate_speakBubble
---@field public speakEmoteList UnityEngine.GameObject
---@field public speakEmote BattleStoryPanel_Generate_speakEmote
---@field public autoBtn BattleStoryPanel_Generate_autoBtn
---@field public round BattleStoryPanel_Generate_round
---@field public autoChange UnityEngine.GameObject
---@field public unAuto BattleStoryPanel_Generate_unAuto
---@field public doAuto BattleStoryPanel_Generate_doAuto
---@field public skipBtn BattleStoryPanel_Generate_skipBtn
---@field public curtain BattleStoryPanel_Generate_curtain
---@field public endCurtain BattleStoryPanel_Generate_endCurtain
local BattleStoryPanel = class("BattleStoryPanel", require("WndBase"))

function BattleStoryPanel:ctor(data)
end

---@private
function BattleStoryPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("BattleStoryPanel")

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
function BattleStoryPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function BattleStoryPanel:InitGenerate__2(Root, data)
--[[
	DoNextBtn
--]]
	local tmp = Root:Find("DoNextBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.doNextBtn = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("BattleStoryPanel_doNextBtn")
			if self.doNextBtn_Button_onClick then
				self:doNextBtn_Button_onClick(self.doNextBtn)
			end
		end)


end

---@private
function BattleStoryPanel:InitGenerate__3(Root, data)
--[[
	SpeakBubblesList
--]]
	local tmp = Root:Find("SpeakBubblesList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.speakBubblesList = tmp


end

---@private
function BattleStoryPanel:InitGenerate__4(Root, data)
--[[
	SpeakBubblesList/SpeakBubble
--]]
	local tmp = Root:Find("SpeakBubblesList/SpeakBubble").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.speakBubble = tmp

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function BattleStoryPanel:InitGenerate__5(Root, data)
--[[
	SpeakBubblesList/SpeakBubble/BubbleBg
--]]
	local tmp = Root:Find("SpeakBubblesList/SpeakBubble/BubbleBg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.speakBubble.bubbleBg = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end

---@private
function BattleStoryPanel:InitGenerate__6(Root, data)
--[[
	SpeakBubblesList/SpeakBubble/BubbleBg/BubbleMiddle
--]]
	local tmp = Root:Find("SpeakBubblesList/SpeakBubble/BubbleBg/BubbleMiddle").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.speakBubble.bubbleMiddle = tmp


end

---@private
function BattleStoryPanel:InitGenerate__7(Root, data)
--[[
	SpeakBubblesList/SpeakBubble/BubbleBg/HeadIconFrame
--]]
	local tmp = Root:Find("SpeakBubblesList/SpeakBubble/BubbleBg/HeadIconFrame").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.speakBubble.headIconFrame = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function BattleStoryPanel:InitGenerate__8(Root, data)
--[[
	SpeakBubblesList/SpeakBubble/BubbleBg/HeadIconFrame/RoleMask/RoleRoot
--]]
	local tmp = Root:Find("SpeakBubblesList/SpeakBubble/BubbleBg/HeadIconFrame/RoleMask/RoleRoot").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.speakBubble.roleRoot = tmp


end

---@private
function BattleStoryPanel:InitGenerate__9(Root, data)
--[[
	SpeakBubblesList/SpeakBubble/BubbleBg/HeadIconFrame/NameBg
--]]
	local tmp = Root:Find("SpeakBubblesList/SpeakBubble/BubbleBg/HeadIconFrame/NameBg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.speakBubble.nameBg = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function BattleStoryPanel:InitGenerate__10(Root, data)
--[[
	SpeakBubblesList/SpeakBubble/BubbleBg/HeadIconFrame/NameBg/NameText
--]]
	local tmp = Root:Find("SpeakBubblesList/SpeakBubble/BubbleBg/HeadIconFrame/NameBg/NameText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.speakBubble.nameText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function BattleStoryPanel:InitGenerate__11(Root, data)
--[[
	SpeakBubblesList/SpeakBubble/BubbleBg/WordsRoot
--]]
	local tmp = Root:Find("SpeakBubblesList/SpeakBubble/BubbleBg/WordsRoot").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.speakBubble.wordsRoot = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function BattleStoryPanel:InitGenerate__12(Root, data)
--[[
	SpeakBubblesList/SpeakBubble/BubbleBg/WordsRoot/WordsTxt
--]]
	local tmp = Root:Find("SpeakBubblesList/SpeakBubble/BubbleBg/WordsRoot/WordsTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.speakBubble.wordsTxt = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function BattleStoryPanel:InitGenerate__13(Root, data)
--[[
	SpeakBubblesList/SpeakBubble/BubbleBg/WordsRoot/WordsTxt/NextArrow
--]]
	local tmp = Root:Find("SpeakBubblesList/SpeakBubble/BubbleBg/WordsRoot/WordsTxt/NextArrow").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.speakBubble.nextArrow = tmp


end

---@private
function BattleStoryPanel:InitGenerate__14(Root, data)
--[[
	SpeakBubblesList/SpeakBubble/RootPos1
--]]
	local tmp = Root:Find("SpeakBubblesList/SpeakBubble/RootPos1").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.speakBubble.rootPos1 = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function BattleStoryPanel:InitGenerate__15(Root, data)
--[[
	SpeakBubblesList/SpeakBubble/RootPos2
--]]
	local tmp = Root:Find("SpeakBubblesList/SpeakBubble/RootPos2").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.speakBubble.rootPos2 = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function BattleStoryPanel:InitGenerate__16(Root, data)
--[[
	SpeakBubblesList/SpeakBubble/RootPos3
--]]
	local tmp = Root:Find("SpeakBubblesList/SpeakBubble/RootPos3").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.speakBubble.rootPos3 = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function BattleStoryPanel:InitGenerate__17(Root, data)
--[[
	SpeakBubblesList/SpeakBubble/RootPos4
--]]
	local tmp = Root:Find("SpeakBubblesList/SpeakBubble/RootPos4").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.speakBubble.rootPos4 = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)


end

---@private
function BattleStoryPanel:InitGenerate__18(Root, data)
--[[
	SpeakEmoteList
--]]
	local tmp = Root:Find("SpeakEmoteList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.speakEmoteList = tmp


end

---@private
function BattleStoryPanel:InitGenerate__19(Root, data)
--[[
	SpeakEmoteList/SpeakEmote
--]]
	local tmp = Root:Find("SpeakEmoteList/SpeakEmote").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.speakEmote = tmp


end

---@private
function BattleStoryPanel:InitGenerate__20(Root, data)
--[[
	SpeakEmoteList/SpeakEmote/EmoteSpine
--]]
	local tmp = Root:Find("SpeakEmoteList/SpeakEmote/EmoteSpine").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.speakEmote.emoteSpine = tmp

	tmp.skeletonGraphic = tmp:GetComponent(TypeInfo.SkeletonGraphic)

	tmp.skeletonAnimation = tmp:GetComponent(TypeInfo.SkeletonAnimation)


end

---@private
function BattleStoryPanel:InitGenerate__21(Root, data)
--[[
	BtnList/AutoBtn
--]]
	local tmp = Root:Find("BtnList/AutoBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.autoBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("BattleStoryPanel_autoBtn")
			if self.autoBtn_ScaleButton_onClick then
				self:autoBtn_ScaleButton_onClick(self.autoBtn)
			end
		end)


end

---@private
function BattleStoryPanel:InitGenerate__22(Root, data)
--[[
	BtnList/AutoBtn/round
--]]
	local tmp = Root:Find("BtnList/AutoBtn/round").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.round = tmp

	tmp.animator = tmp:GetComponent(TypeInfo.Animator)


end

---@private
function BattleStoryPanel:InitGenerate__23(Root, data)
--[[
	BtnList/AutoBtn/AutoChange
--]]
	local tmp = Root:Find("BtnList/AutoBtn/AutoChange").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.autoChange = tmp


end

---@private
function BattleStoryPanel:InitGenerate__24(Root, data)
--[[
	BtnList/AutoBtn/AutoChange/UnAuto
--]]
	local tmp = Root:Find("BtnList/AutoBtn/AutoChange/UnAuto").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.unAuto = tmp

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function BattleStoryPanel:InitGenerate__25(Root, data)
--[[
	BtnList/AutoBtn/AutoChange/DoAuto
--]]
	local tmp = Root:Find("BtnList/AutoBtn/AutoChange/DoAuto").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.doAuto = tmp

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function BattleStoryPanel:InitGenerate__26(Root, data)
--[[
	BtnList/SkipBtn
--]]
	local tmp = Root:Find("BtnList/SkipBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.skipBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("BattleStoryPanel_skipBtn")
			if self.skipBtn_ScaleButton_onClick then
				self:skipBtn_ScaleButton_onClick(self.skipBtn)
			end
		end)


end

---@private
function BattleStoryPanel:InitGenerate__27(Root, data)
--[[
	Curtain
--]]
	local tmp = Root:Find("Curtain").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.curtain = tmp

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function BattleStoryPanel:InitGenerate__28(Root, data)
--[[
	EndCurtain
--]]
	local tmp = Root:Find("EndCurtain").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.endCurtain = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function BattleStoryPanel:SetLocalizedText(Root)

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return BattleStoryPanel