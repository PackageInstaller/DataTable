-- chunkname: @modules/logic/activity/view/Vxax_Special_SignItemViewContainer.lua

module("modules.logic.activity.view.Vxax_Special_SignItemViewContainer", package.seeall)

local Vxax_Special_SignItemViewContainer = class("Vxax_Special_SignItemViewContainer", BaseViewContainer)

function Vxax_Special_SignItemViewContainer:buildViews()
	assert(false, "please override this function")
end

function Vxax_Special_SignItemViewContainer:view()
	assert(false, "please override this function")
end

function Vxax_Special_SignItemViewContainer:actId()
	return self.viewParam.actId
end

function Vxax_Special_SignItemViewContainer:itemCo2TIQ(itemCo)
	if string.nilorempty(itemCo) then
		return
	end

	local strList = string.split(itemCo, "#")

	assert(#strList >= 2, "[Vxax_Special_SignItemViewContainer] invalid itemCo=" .. tostring(itemCo))

	local list = string.split(itemCo, "#")
	local type = tonumber(list[1])
	local id = tonumber(list[2])
	local quantity = tonumber(list[3])

	return type, id, quantity
end

function Vxax_Special_SignItemViewContainer:getItemConfig(materialType, id)
	local func = ItemConfigGetDefine.instance:getItemConfigFunc(materialType)

	assert(func, "[Vxax_Special_SignItemViewContainer] ItemIconGetDefine-getItemConfigFunc unsupported materialType: " .. tostring(materialType))

	local config = func(id)

	assert(config, "[Vxax_Special_SignItemViewContainer] item config not found materialType=" .. tostring(materialType) .. " id=" .. tostring(id))

	return config
end

function Vxax_Special_SignItemViewContainer:getItemIconResUrl(materialType, id)
	if not materialType or not id then
		return ""
	end

	local func = ItemIconGetDefine.instance:getItemIconFunc(materialType)

	assert(func, "[Vxax_Special_SignItemViewContainer] ItemIconGetDefine-getItemIconFunc unsupported materialType: " .. tostring(materialType))

	local config = self:getItemConfig(materialType, id)

	return func(config) or ""
end

function Vxax_Special_SignItemViewContainer.Vxax_Special_xxxSignView_Container(T, viewCls)
	function T.buildViews(Self)
		Self._view = viewCls.New()

		return {
			Self._view
		}
	end

	function T.view(Self)
		return Self._view
	end
end

function Vxax_Special_SignItemViewContainer.Vxax_Special_FullSignView(T, major, minor)
	return
end

function Vxax_Special_SignItemViewContainer.Vxax_Special_PanelSignView(T, major, minor)
	return
end

local function _Vxax_Special_xxxSignView_ContainerImpl(fmt)
	local major = GameBranchMgr.instance:getMajorVer()
	local minor = GameBranchMgr.instance:getMinorVer()

	return _G[string.format(fmt, major, minor)]
end

function Vxax_Special_SignItemViewContainer.Vxax_Special_FullSignView_ContainerImpl()
	return _Vxax_Special_xxxSignView_ContainerImpl("V%sa%s_Special_FullSignViewContainer")
end

function Vxax_Special_SignItemViewContainer.Vxax_Special_PanelSignView_ContainerImpl()
	return _Vxax_Special_xxxSignView_ContainerImpl("V%sa%s_Special_PanelSignViewContainer")
end

return Vxax_Special_SignItemViewContainer
