-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/UI\\Common\\FlyIconUtils.lua

local EventConst = require("EventConst")
local UIMiscConfig = require("DesignerScript/UIMiscConfig")
local LuaToolkit = Framework.Tools.LuaToolkit
local FlyIconUtils = {}
local self = FlyIconUtils

function FlyIconUtils.setFlyUItoUI(startUIObj, endUIObj, itemId, itemNum, scale, endCB)
	local splitNum = UIMiscConfig.getFlyIconSplit(itemNum)
	local startWorldPos = self._calcUIWorldPos(startUIObj)
	local endWorldPos = self._calcUIWorldPos(endUIObj)
	local iconPath

	if itemId then
		iconPath = BaseObject.getItemIconPath(itemId)
	else
		iconPath = self._getUISprite(startUIObj)
	end

	if startWorldPos and endWorldPos and iconPath then
		local flyDlg = UIManager.getUI("flyIconDlg", true)

		flyDlg:addEndCallBack(endCB)
		flyDlg:setFlyData(iconPath[1], iconPath[2], startWorldPos, endWorldPos, splitNum, scale)
	end
end

function FlyIconUtils.setFlyImagetoUI(startUIObj, endUIObj, iconPath, iconName, scale, endCB)
	local splitNum = 1
	local startWorldPos = self._calcUIWorldPos(startUIObj)
	local endWorldPos = self._calcUIWorldPos(endUIObj)

	if startWorldPos and endWorldPos and iconPath and iconName then
		local flyDlg = UIManager.getUI("flyIconDlg", true)

		flyDlg:setFlyData(iconPath, iconName, startWorldPos, endWorldPos, splitNum, scale)
	end
end

function FlyIconUtils.setFly2DPosToUI(startWorldPos, endUIObj, itemId, itemNum, scale, endCB)
	if not itemId then
		return
	end

	local splitNum = UIMiscConfig.getFlyIconSplit(itemNum)
	local iconPath = BaseObject.getItemIconPath(itemId)
	local endWorldPos = self._calcUIWorldPos(endUIObj)

	if startWorldPos and endWorldPos and iconPath and #iconPath == 2 then
		local flyDlg = UIManager.getUI("flyIconDlg", true)

		flyDlg:setFlyData(iconPath[1], iconPath[2], startWorldPos, endWorldPos, splitNum, scale)
	end
end

function FlyIconUtils.setFly3DtoUI(realWorldPos, endUIObj, itemId, itemNum, scale, endCB)
	if not itemId then
		return
	end

	local splitNum = UIMiscConfig.getFlyIconSplit(itemNum)
	local iconPath = BaseObject.getItemIconPath(itemId)
	local endWorldPos = self._calcUIWorldPos(endUIObj)
	local startWorldPos = self._calc3dWorldPos(realWorldPos)

	if startWorldPos and endWorldPos and iconPath and #iconPath == 2 then
		local flyDlg = UIManager.getUI("flyIconDlg", true)

		flyDlg:setFlyData(iconPath[1], iconPath[2], startWorldPos, endWorldPos, splitNum, scale)
	end
end

function FlyIconUtils.setFlyEffect3DToUI(realWorldPos, endUIObj, effectPath, belongScene, scale, endCB)
	local startWorldPos = self._calc3dWorldPos(realWorldPos)
	local endWorldPos = self._calcUIWorldPos(endUIObj)

	if startWorldPos and endWorldPos then
		if belongScene then
			local flyDlg = UIManager.getUI("fly3DIconDlg", true)

			flyDlg:setFlyEffectData(startWorldPos, endWorldPos, effectPath, scale)
		else
			local flyDlg = UIManager.getUI("flyIconDlg", true)

			flyDlg:setFlyEffectData(startWorldPos, endWorldPos, effectPath, scale)
		end
	end
end

function FlyIconUtils.sendFlyEvent(obj, itemId, itemNum)
	if UIManager.tryGetUI("captureDlg") then
		return
	end

	EventCenter.sendEvent(EventConst.MONEY_FLY, UIConst.FLY_MODE_UI_OBJ, {
		{
			itemId,
			obj,
			itemNum
		}
	})
end

function FlyIconUtils.send3DFlyEvent(worldPos, itemId, itemNum)
	EventCenter.sendEvent(EventConst.MONEY_FLY, UIConst.FLY_MODE_3D, {
		{
			itemId,
			worldPos,
			itemNum
		}
	})
end

function FlyIconUtils._getUISprite(uiObj)
	if uiObj then
		local controlType = uiObj:getControlType()

		if controlType == UIConst.ControlTypeImage then
			local icon, sprite = uiObj:getImagePath()

			return {
				icon,
				sprite
			}
		end
	end

	return nil
end

function FlyIconUtils._calcUIWorldPos(uiObj)
	if uiObj then
		local pos = uiObj:getAbsPosition()

		if pos and pos.x then
			return Vector2(pos.x, pos.y)
		end
	end
end

function FlyIconUtils._calc3dWorldPos(realWorldPos)
	local worldPos = LuaToolkit.WorldTo2DCameraPos(realWorldPos)

	return Vector2(worldPos.x, worldPos.y)
end

return FlyIconUtils
