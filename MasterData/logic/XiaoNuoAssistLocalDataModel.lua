-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xiaonuoassistant/model/XiaoNuoAssistLocalDataModel.lua

module("logic.extensions.xiaonuoassistant.model.XiaoNuoAssistLocalDataModel", package.seeall)

local XiaoNuoAssistLocalDataModel = class("XiaoNuoAssistLocalDataModel", BaseModel)
local OpenDataKey = "XiaoNuoAssistOpenData"
local CellSelectDataKey = "XiaoNuoAssistCellSelectData"
local CellDataKey = "XiaoNuoAssistCellData"

function XiaoNuoAssistLocalDataModel:ctor()
	return
end

function XiaoNuoAssistLocalDataModel:setOpenData(funcEnum, isOpen)
	GameUtil.saveUserData(string.format("%s_%d", OpenDataKey, funcEnum), isOpen)
end

function XiaoNuoAssistLocalDataModel:getOpenData(funcEnum)
	return GameUtil.getUserData(string.format("%s_%d", OpenDataKey, funcEnum))
end

function XiaoNuoAssistLocalDataModel:setCellSelect(funcEnum, index, isSelect)
	GameUtil.saveUserData(string.format("%s_%d_%d", CellSelectDataKey, funcEnum, index), isSelect)
end

function XiaoNuoAssistLocalDataModel:getCellSelect(funcEnum, index)
	return GameUtil.getUserData(string.format("%s_%d_%d", CellSelectDataKey, funcEnum, index))
end

function XiaoNuoAssistLocalDataModel:setCellData(funcEnum, key, value)
	GameUtil.saveUserData(string.format("%s_%d_%s", CellDataKey, funcEnum, key), value)
end

function XiaoNuoAssistLocalDataModel:getCellData(funcEnum, key)
	return GameUtil.getUserData(string.format("%s_%d_%s", CellDataKey, funcEnum, key))
end

XiaoNuoAssistLocalDataModel.instance = XiaoNuoAssistLocalDataModel.New()

return XiaoNuoAssistLocalDataModel
