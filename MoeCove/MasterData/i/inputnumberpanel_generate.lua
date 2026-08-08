---@class InputNumberPanel__Generate_cancleButton_text
---@field public gameObject UnityEngine.GameObject
---@field public text UnityEngine.UI.Text

---@class InputNumberPanel__Generate_cancleButton
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button
---@field public uiAudio UIAudio
---@field public text InputNumberPanel__Generate_cancleButton_text

---@class InputNumberPanel__Generate_okButton_text
---@field public gameObject UnityEngine.GameObject
---@field public text UnityEngine.UI.Text

---@class InputNumberPanel__Generate_okButton
---@field public gameObject UnityEngine.GameObject
---@field public button UnityEngine.UI.Button
---@field public uiAudio UIAudio
---@field public text InputNumberPanel__Generate_okButton_text

---@class InputNumberPanel__Generate_inputField
---@field public gameObject UnityEngine.GameObject
---@field public inputField UnityEngine.UI.InputField

---@class InputNumberPanel__Generate
---@field private gameObject UnityEngine.GameObject
---@field private transform UnityEngine.Transform
---@field private uiConfig table
---@field private inputField InputNumberPanel__Generate_inputField
---@field private okButton InputNumberPanel__Generate_okButton
---@field private cancleButton InputNumberPanel__Generate_cancleButton
local InputNumberPanel = class("InputNumberPanel", require("MsgBoxBase"))

function InputNumberPanel:ctor(data)
end

---@private
function InputNumberPanel:InitGenerate(data)

	self.uiConfig = Config.GetUIConfigInfo("InputNumberPanel")

	local Root = self.transform 
	local tmp

	tmp = Root:Find("TouchBG")
	if tmp then
		EventTriggerListener.Get(tmp.gameObject).onUp = function (go, data)
			self:TouchBG_Close()
		end
		EventTriggerListener.Get(tmp.gameObject).onCancel = function (go, data)
			self:TouchBG_Close()
		end
		EventTriggerListener.Get(tmp.gameObject).onBeginDrag = function (go, data)
			self:TouchBG_Close()
		end
	end

	self:InitGenerate__1(Root,data)
	self:InitGenerate__2(Root,data)
	self:InitGenerate__3(Root,data)
	self:InitGenerate__4(Root,data)
	self:InitGenerate__5(Root,data)
	self:InitGenerate__6(Root,data)
	self:InitGenerate__7(Root,data)

	self:InitLogic(data)

end

---@private
function InputNumberPanel:InitGenerate__1(Root, data)
--[[
	Root
--]]


end

---@private
function InputNumberPanel:InitGenerate__2(Root, data)
--[[
	BgClickClose
--]]
	local tmp = Root:Find("BgClickClose").gameObject

	tmp:AddComponentLua("BgClickClose", data)


end

---@private
function InputNumberPanel:InitGenerate__3(Root, data)
--[[
	InputField
--]]
	local tmp = Root:Find("InputField").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.inputField = tmp

	tmp.inputField = tmp:GetComponent(TypeInfo.InputField)


end

---@private
function InputNumberPanel:InitGenerate__4(Root, data)
--[[
	BottomBtns/OkButton
--]]
	local tmp = Root:Find("BottomBtns/OkButton").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.okButton = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.uiAudio = tmp:GetComponent(TypeInfo.UIAudio)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
			if self.okButton.uiAudio.click then
				self:play2DSound(self.okButton.uiAudio.click, 1, 1)
			end
			if self.okButton_Button_onClick then
				self:okButton_Button_onClick(self.okButton)
			end
		end)


end

---@private
function InputNumberPanel:InitGenerate__5(Root, data)
--[[
	BottomBtns/OkButton/Text
--]]
	local tmp = Root:Find("BottomBtns/OkButton/Text").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.okButton.text = tmp

	tmp.text = tmp:GetComponent(TypeInfo.Text)


end

---@private
function InputNumberPanel:InitGenerate__6(Root, data)
--[[
	BottomBtns/CancleButton
--]]
	local tmp = Root:Find("BottomBtns/CancleButton").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.cancleButton = tmp

	tmp.button = tmp:GetComponent(TypeInfo.Button)
	tmp.uiAudio = tmp:GetComponent(TypeInfo.UIAudio)
	tmp.button.onClick:RemoveAllListeners()
	tmp.button.onClick:AddListener(function ()
			if self.cancleButton.uiAudio.click then
				self:play2DSound(self.cancleButton.uiAudio.click, 1, 1)
			end
			if self.cancleButton_Button_onClick then
				self:cancleButton_Button_onClick(self.cancleButton)
			end
		end)


end

---@private
function InputNumberPanel:InitGenerate__7(Root, data)
--[[
	BottomBtns/CancleButton/Text
--]]
	local tmp = Root:Find("BottomBtns/CancleButton/Text").gameObject
	if tolua.getpeer(tmp) == nil then
		tolua.setpeer(tmp, {})
	end
	self.cancleButton.text = tmp

	tmp.text = tmp:GetComponent(TypeInfo.Text)


end

return InputNumberPanel