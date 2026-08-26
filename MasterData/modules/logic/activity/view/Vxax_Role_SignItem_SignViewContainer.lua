-- chunkname: @modules/logic/activity/view/Vxax_Role_SignItem_SignViewContainer.lua

module("modules.logic.activity.view.Vxax_Role_SignItem_SignViewContainer", package.seeall)

local sf = string.format
local Vxax_Role_SignItem_SignViewContainer = class("Vxax_Role_SignItem_SignViewContainer", Activity101SignViewBaseContainer)

function Vxax_Role_SignItem_SignViewContainer:onModifyListScrollParam(refListScrollParam)
	refListScrollParam.cellClass = Vxax_Role_SignItem
	refListScrollParam.scrollGOPath = "Root/#scroll_ItemList"
	refListScrollParam.cellWidth = 220
	refListScrollParam.cellHeight = 600
	refListScrollParam.cellSpaceH = -12
end

function Vxax_Role_SignItem_SignViewContainer:onBuildViews()
	return {
		(self:getMainView())
	}
end

local function _getVxaxSignSingleBg(V, A, resName)
	return sf("singlebg/v%sa%s_sign_singlebg/%s.png", V, A, resName)
end

local function _getVxaxSignSingleBgLang(V, A, resName)
	return sf("singlebg_lang/txt_v%sa%s_sign_singlebg/%s.png", V, A, resName)
end

function Vxax_Role_SignItem_SignViewContainer.Vxax_Role_xxxSignView_Container(T, viewCls)
	function T.onGetMainViewClassType(Self)
		return viewCls
	end
end

function Vxax_Role_SignItem_SignViewContainer.Vxax_Role_FullSignView_PartX(T, major, minor, whichPart)
	function T._editableInitView(Self)
		local bgResName = sf("v%sa%s_sign_fullbg%s", major, minor, whichPart)

		GameUtil.loadSImage(Self._simageFullBG, _getVxaxSignSingleBg(major, minor, bgResName))

		local titleName = sf("v%sa%s_sign_title_%s", major, minor, whichPart)

		GameUtil.loadSImage(Self._simageTitle, _getVxaxSignSingleBgLang(major, minor, titleName))

		local go1 = gohelper.findChild(Self.viewGO, "Root/vx_effect1")
		local go2 = gohelper.findChild(Self.viewGO, "Root/vx_effect2")

		gohelper.setActive(go1, true)
		gohelper.setActive(go2, false)
	end
end

function Vxax_Role_SignItem_SignViewContainer.Vxax_Role_PanelSignView_PartX(T, major, minor, whichPart)
	function T._editableInitView(Self)
		local bgResName = sf("v%sa%s_sign_panelbg%s", major, minor, whichPart)

		GameUtil.loadSImage(Self._simagePanelBG, _getVxaxSignSingleBg(major, minor, bgResName))

		local titleName = sf("v%sa%s_sign_title_%s", major, minor, whichPart)

		GameUtil.loadSImage(Self._simageTitle, _getVxaxSignSingleBgLang(major, minor, titleName))

		local go1 = gohelper.findChild(Self.viewGO, "Root/vx_effect1")
		local go2 = gohelper.findChild(Self.viewGO, "Root/vx_effect2")

		gohelper.setActive(go1, true)
		gohelper.setActive(go2, false)
	end
end

local function _Vxax_Role_xxxSignView_PartX_ContainerImpl(fmt, whichPart)
	local major = GameBranchMgr.instance:getMajorVer()
	local minor = GameBranchMgr.instance:getMinorVer()

	return _G[sf(fmt, major, minor, whichPart)]
end

function Vxax_Role_SignItem_SignViewContainer.Vxax_Role_FullSignView_PartX_ContainerImpl(whichPart)
	return _Vxax_Role_xxxSignView_PartX_ContainerImpl("V%sa%s_Role_FullSignView_Part%s_Container", whichPart)
end

function Vxax_Role_SignItem_SignViewContainer.Vxax_Role_PanelSignView_PartX_ContainerImpl(whichPart)
	return _Vxax_Role_xxxSignView_PartX_ContainerImpl("V%sa%s_Role_PanelSignView_Part%s_Container", whichPart)
end

return Vxax_Role_SignItem_SignViewContainer
