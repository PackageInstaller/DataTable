-- chunkname: @modules/logic/activity/view/V2a3_Special_SignItemViewContainer.lua

module("modules.logic.activity.view.V2a3_Special_SignItemViewContainer", package.seeall)

local V2a3_Special_SignItemViewContainer = class("V2a3_Special_SignItemViewContainer", BaseViewContainer)

function V2a3_Special_SignItemViewContainer:buildViews()
	assert(false, "please override this function")
end

function V2a3_Special_SignItemViewContainer:view()
	assert(false, "please override this function")
end

function V2a3_Special_SignItemViewContainer:actId()
	return self.viewParam.actId
end

function V2a3_Special_SignItemViewContainer:itemCo2TIQ(itemCo)
	if string.nilorempty(itemCo) then
		return
	end

	local strList = string.split(itemCo, "#")

	assert(#strList >= 2, "[V2a3_Special_SignItemViewContainer] invalid itemCo=" .. tostring(itemCo))

	local list = string.split(itemCo, "#")
	local type = tonumber(list[1])
	local id = tonumber(list[2])
	local quantity = tonumber(list[3])

	return type, id, quantity
end

function V2a3_Special_SignItemViewContainer:getItemConfig(materialType, id)
	local func = ItemConfigGetDefine.instance:getItemConfigFunc(materialType)

	assert(func, "[V2a3_Special_SignItemViewContainer] ItemIconGetDefine-getItemConfigFunc unsupported materialType: " .. tostring(materialType))

	local config = func(id)

	assert(config, "[V2a3_Special_SignItemViewContainer] item config not found materialType=" .. tostring(materialType) .. " id=" .. tostring(id))

	return config
end

function V2a3_Special_SignItemViewContainer:getItemIconResUrl(materialType, id)
	if not materialType or not id then
		return ""
	end

	local func = ItemIconGetDefine.instance:getItemIconFunc(materialType)

	assert(func, "[V2a3_Special_SignItemViewContainer] ItemIconGetDefine-getItemIconFunc unsupported materialType: " .. tostring(materialType))

	local config = self:getItemConfig(materialType, id)

	return func(config) or ""
end

return V2a3_Special_SignItemViewContainer
