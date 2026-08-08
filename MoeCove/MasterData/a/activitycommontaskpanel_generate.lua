---@class ActivityCommonTaskPanel_Generate_toggleBtn_nameText2
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class ActivityCommonTaskPanel_Generate_toggleBtn_nameText
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class ActivityCommonTaskPanel_Generate_toggleBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton
---@field public nameText ActivityCommonTaskPanel_Generate_toggleBtn_nameText
---@field public isOn UnityEngine.GameObject
---@field public nameText2 ActivityCommonTaskPanel_Generate_toggleBtn_nameText2
---@field public redPoint UnityEngine.GameObject

---@class ActivityCommonTaskPanel_Generate_customMsgPanel
---@field public gameObject UnityEngine.GameObject
---@field public customMsgPanel CustomMsgPanel

---@class ActivityCommonTaskPanel_Generate_customBackPanel
---@field public gameObject UnityEngine.GameObject
---@field public customBackPanel CustomBackPanel

---@class ActivityCommonTaskPanel_Generate_customBox
---@field public gameObject UnityEngine.GameObject
---@field public customBox CustomBox

---@class ActivityCommonTaskPanel_Generate_commonTaskBox_getBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class ActivityCommonTaskPanel_Generate_commonTaskBox_goToBtn
---@field public gameObject UnityEngine.GameObject
---@field public scaleButton ScaleButton

---@class ActivityCommonTaskPanel_Generate_commonTaskBox_taskMsgTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class ActivityCommonTaskPanel_Generate_commonTaskBox_taskNameTxt
---@field public gameObject UnityEngine.GameObject
---@field public text TMPro.TextMeshProUGUI

---@class ActivityCommonTaskPanel_Generate_commonTaskBox
---@field public gameObject UnityEngine.GameObject
---@field public taskNameTxt ActivityCommonTaskPanel_Generate_commonTaskBox_taskNameTxt
---@field public taskMsgTxt ActivityCommonTaskPanel_Generate_commonTaskBox_taskMsgTxt
---@field public rewardList UnityEngine.GameObject
---@field public goToBtn ActivityCommonTaskPanel_Generate_commonTaskBox_goToBtn
---@field public getBtn ActivityCommonTaskPanel_Generate_commonTaskBox_getBtn
---@field public mask UnityEngine.GameObject

---@class ActivityCommonTaskPanel_Generate_taskLoopList
---@field public gameObject UnityEngine.GameObject
---@field public rectTransform UnityEngine.RectTransform
---@field public loopListView2 SuperScrollView.LoopListView2

---@class ActivityCommonTaskPanel_Generate_imgBg
---@field public gameObject UnityEngine.GameObject
---@field public image UnityEngine.UI.Image
---@field public canvasGroup UnityEngine.CanvasGroup

---@class ActivityCommonTaskPanel_Generate
---@field public gameObject UnityEngine.GameObject
---@field public transform UnityEngine.Transform
---@field public uiConfig table
---@field public rectTransform UnityEngine.RectTransform
---@field public animator UnityEngine.Animator
---@field public animOverCallBack AnimOverCallBack
---@field public imgBg ActivityCommonTaskPanel_Generate_imgBg
---@field public toggleList UnityEngine.GameObject
---@field public taskLoopList ActivityCommonTaskPanel_Generate_taskLoopList
---@field public commonTaskBox ActivityCommonTaskPanel_Generate_commonTaskBox
---@field public customBox ActivityCommonTaskPanel_Generate_customBox
---@field public customBackPanel ActivityCommonTaskPanel_Generate_customBackPanel
---@field public customMsgPanel ActivityCommonTaskPanel_Generate_customMsgPanel
---@field public toggleBtn ActivityCommonTaskPanel_Generate_toggleBtn
local ActivityCommonTaskPanel = class("ActivityCommonTaskPanel", require("WndBase"))

function ActivityCommonTaskPanel:ctor(data)
end

---@private
function ActivityCommonTaskPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("ActivityCommonTaskPanel")

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

	self:SetLocalizedText(Root)


	self:InitLogic(data)

end

---@private
function ActivityCommonTaskPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]

	self.rectTransform = Root:GetComponent(TypeInfo.RectTransform)

	self.animator = Root:GetComponent(TypeInfo.Animator)

	self.animOverCallBack = Root:GetComponent(TypeInfo.AnimOverCallBack)


end

---@private
function ActivityCommonTaskPanel:InitGenerate__2(Root, data)
--[[
	ImgBg
--]]
	local tmp = Root:Find("ImgBg").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.imgBg = tmp

	tmp.image = tmp:GetComponent(TypeInfo.Image)

	tmp.canvasGroup = tmp:GetComponent(TypeInfo.CanvasGroup)


end

---@private
function ActivityCommonTaskPanel:InitGenerate__3(Root, data)
--[[
	ToggleList
--]]
	local tmp = Root:Find("ToggleList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.toggleList = tmp


end

---@private
function ActivityCommonTaskPanel:InitGenerate__4(Root, data)
--[[
	TaskLoopList
--]]
	local tmp = Root:Find("TaskLoopList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.taskLoopList = tmp

	tmp.rectTransform = tmp:GetComponent(TypeInfo.RectTransform)

	tmp.loopListView2 = tmp:GetComponent(TypeInfo.LoopListView2)


end

---@private
function ActivityCommonTaskPanel:InitGenerate__5(Root, data)
--[[
	TaskLoopList/Viewport/Content/CommonTaskBox
--]]
	local tmp = Root:Find("TaskLoopList/Viewport/Content/CommonTaskBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.commonTaskBox = tmp


end

---@private
function ActivityCommonTaskPanel:InitGenerate__6(Root, data)
--[[
	TaskLoopList/Viewport/Content/CommonTaskBox/TaskNameTxt
--]]
	local tmp = Root:Find("TaskLoopList/Viewport/Content/CommonTaskBox/TaskNameTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.commonTaskBox.taskNameTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function ActivityCommonTaskPanel:InitGenerate__7(Root, data)
--[[
	TaskLoopList/Viewport/Content/CommonTaskBox/TaskMsgTxt
--]]
	local tmp = Root:Find("TaskLoopList/Viewport/Content/CommonTaskBox/TaskMsgTxt").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.commonTaskBox.taskMsgTxt = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function ActivityCommonTaskPanel:InitGenerate__8(Root, data)
--[[
	TaskLoopList/Viewport/Content/CommonTaskBox/RewardList
--]]
	local tmp = Root:Find("TaskLoopList/Viewport/Content/CommonTaskBox/RewardList").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.commonTaskBox.rewardList = tmp


end

---@private
function ActivityCommonTaskPanel:InitGenerate__9(Root, data)
--[[
	TaskLoopList/Viewport/Content/CommonTaskBox/GoToBtn
--]]
	local tmp = Root:Find("TaskLoopList/Viewport/Content/CommonTaskBox/GoToBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.commonTaskBox.goToBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("ActivityCommonTaskPanel_goToBtn")
			if self.goToBtn_ScaleButton_onClick then
				self:goToBtn_ScaleButton_onClick(self.commonTaskBox.goToBtn)
			end
		end)


end

---@private
function ActivityCommonTaskPanel:InitGenerate__10(Root, data)
--[[
	TaskLoopList/Viewport/Content/CommonTaskBox/GetBtn
--]]
	local tmp = Root:Find("TaskLoopList/Viewport/Content/CommonTaskBox/GetBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.commonTaskBox.getBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("ActivityCommonTaskPanel_getBtn")
			if self.getBtn_ScaleButton_onClick then
				self:getBtn_ScaleButton_onClick(self.commonTaskBox.getBtn)
			end
		end)


end

---@private
function ActivityCommonTaskPanel:InitGenerate__11(Root, data)
--[[
	TaskLoopList/Viewport/Content/CommonTaskBox/Mask
--]]
	local tmp = Root:Find("TaskLoopList/Viewport/Content/CommonTaskBox/Mask").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.commonTaskBox.mask = tmp


end

---@private
function ActivityCommonTaskPanel:InitGenerate__12(Root, data)
--[[
	Custom/CustomBox
--]]
	local tmp = Root:Find("Custom/CustomBox").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.customBox = tmp

	tmp.customBox = tmp:AddComponentLua("CustomBox", data)


end

---@private
function ActivityCommonTaskPanel:InitGenerate__13(Root, data)
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
function ActivityCommonTaskPanel:InitGenerate__14(Root, data)
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
function ActivityCommonTaskPanel:InitGenerate__15(Root, data)
--[[
	ToggleBtn
--]]
	local tmp = Root:Find("ToggleBtn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.toggleBtn = tmp

	tmp.scaleButton = tmp:GetComponent(TypeInfo.ScaleButton)
	tmp.scaleButton.onClick:RemoveAllListeners()
	tmp.scaleButton.onClick:AddListener(function ()
		UIMgr:SendUiUseMessage("ActivityCommonTaskPanel_toggleBtn")
			if self.toggleBtn_ScaleButton_onClick then
				self:toggleBtn_ScaleButton_onClick(self.toggleBtn)
			end
		end)


end

---@private
function ActivityCommonTaskPanel:InitGenerate__16(Root, data)
--[[
	ToggleBtn/NameText
--]]
	local tmp = Root:Find("ToggleBtn/NameText").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.toggleBtn.nameText = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function ActivityCommonTaskPanel:InitGenerate__17(Root, data)
--[[
	ToggleBtn/IsOn
--]]
	local tmp = Root:Find("ToggleBtn/IsOn").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.toggleBtn.isOn = tmp


end

---@private
function ActivityCommonTaskPanel:InitGenerate__18(Root, data)
--[[
	ToggleBtn/IsOn/NameText2
--]]
	local tmp = Root:Find("ToggleBtn/IsOn/NameText2").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.toggleBtn.nameText2 = tmp

	tmp.text = tmp:GetComponent(TypeInfo.TextMeshProUGUI)


end

---@private
function ActivityCommonTaskPanel:InitGenerate__19(Root, data)
--[[
	ToggleBtn/RedPoint
--]]
	local tmp = Root:Find("ToggleBtn/RedPoint").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.toggleBtn.redPoint = tmp


end


---##################### GenerateLocalizedText  Start #####################
---------------------------------------------------------------------------

function ActivityCommonTaskPanel:SetLocalizedText(Root)

end

---------------------------------------------------------------------------
---##################### GenerateLocalizedText  End #####################
return ActivityCommonTaskPanel