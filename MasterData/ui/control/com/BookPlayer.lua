-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Control\\Com\\BookPlayer.lua

local UIBaseControl = require("UI/Control/Base/UIBaseControl")
local CanvasType = typeof(UnityEngine.Canvas)
local strClassName = "BookPlayer"
local BookPlayer = Class(strClassName, UIBaseControl)

function BookPlayer:ctor(parent, path)
	return
end

function BookPlayer:_getControlType()
	return UIConst.ControlTypeBookPlayer
end

function BookPlayer:addPage(pageChild)
	local pageCanvas
	local childController = pageChild:getController()

	if childController then
		pageCanvas = childController.transform:GetComponent(CanvasType)

		if not pageCanvas then
			return
		end
	end

	local obj = self:getComObj()

	if obj then
		return obj:AddPage(pageCanvas)
	end
end

function BookPlayer:setFlipPage(fromIdx, toIdx)
	local obj = self:getComObj()

	if obj then
		return obj:SetFlipPage(fromIdx, toIdx)
	end
end

function BookPlayer:manualFlipPage(percent, duration)
	duration = duration or 0

	local obj = self:getComObj()

	if obj then
		return obj:ManualFlipPage(percent, duration)
	end
end

function BookPlayer:autoFlipPage(fromIdx, toIdx)
	local obj = self:getComObj()

	if obj then
		return obj:AutoFlipPage(fromIdx, toIdx)
	end
end

return BookPlayer
