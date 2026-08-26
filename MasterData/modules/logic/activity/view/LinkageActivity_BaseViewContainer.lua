-- chunkname: @modules/logic/activity/view/LinkageActivity_BaseViewContainer.lua

module("modules.logic.activity.view.LinkageActivity_BaseViewContainer", package.seeall)

local LinkageActivity_BaseViewContainer = class("LinkageActivity_BaseViewContainer", BaseViewContainer)

function LinkageActivity_BaseViewContainer:buildViews()
	assert(false, "please override this function")
end

function LinkageActivity_BaseViewContainer:view()
	assert(false, "please override this function")
end

function LinkageActivity_BaseViewContainer:switchPage(pageIndex)
	local viewObj = self:view()

	viewObj:selectedPage(pageIndex)
end

function LinkageActivity_BaseViewContainer:itemCo2TIQ(itemCo)
	if string.nilorempty(itemCo) then
		return
	end

	local strList = string.split(itemCo, "#")

	assert(#strList >= 2, "[LinkageActivity_BaseViewContainer] invalid itemCo=" .. tostring(itemCo))

	local list = string.split(itemCo, "#")
	local type = tonumber(list[1])
	local id = tonumber(list[2])
	local quantity = tonumber(list[3])

	return type, id, quantity
end

function LinkageActivity_BaseViewContainer:getItemConfig(materialType, id)
	local func = ItemConfigGetDefine.instance:getItemConfigFunc(materialType)

	assert(func, "[LinkageActivity_BaseViewContainer] ItemIconGetDefine-getItemConfigFunc unsupported materialType: " .. tostring(materialType))

	local config = func(id)

	assert(config, "[LinkageActivity_BaseViewContainer] item config not found materialType=" .. tostring(materialType) .. " id=" .. tostring(id))

	return config
end

function LinkageActivity_BaseViewContainer:getItemIconResUrl(materialType, id)
	if not materialType or not id then
		return ""
	end

	local func = ItemIconGetDefine.instance:getItemIconFunc(materialType)

	assert(func, "[LinkageActivity_BaseViewContainer] ItemIconGetDefine-getItemIconFunc unsupported materialType: " .. tostring(materialType))

	local config = self:getItemConfig(materialType, id)

	return func(config) or ""
end

function LinkageActivity_BaseViewContainer:getAssetItem_VideoLoadingPng()
	local otherRes = self._viewSetting.otherRes

	return self:getRes(otherRes[1])
end

function LinkageActivity_BaseViewContainer.Vxax_LinkageActivity_xxxView_Container(T, viewCls)
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

function LinkageActivity_BaseViewContainer.Vxax_LinkageActivity_FullView(T, major, minor)
	return
end

function LinkageActivity_BaseViewContainer.Vxax_LinkageActivity_PanelView(T, major, minor)
	return
end

local function _Vxax_Special_xxxSignView_ContainerImpl(fmt)
	local major = GameBranchMgr.instance:getMajorVer()
	local minor = GameBranchMgr.instance:getMinorVer()

	return _G[string.format(fmt, major, minor)]
end

function LinkageActivity_BaseViewContainer.Vxax_LinkageActivity_FullView_ContainerImpl()
	return _Vxax_Special_xxxSignView_ContainerImpl("V%sa%s_LinkageActivity_FullViewContainer")
end

function LinkageActivity_BaseViewContainer.Vxax_LinkageActivity_PanelView_ContainerImpl()
	return _Vxax_Special_xxxSignView_ContainerImpl("V%sa%s_LinkageActivity_PanelViewContainer")
end

return LinkageActivity_BaseViewContainer
