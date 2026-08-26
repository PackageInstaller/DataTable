-- chunkname: @modules/logic/activity/model/ActivityType101Model.lua

local sf = string.format

module("modules.logic.activity.model.ActivityType101Model", package.seeall)

local ActivityType101Model = class("ActivityType101Model", BaseModel)
local kState_None = 0
local kState_Available = 1
local kState_Received = 2

function ActivityType101Model:onInit()
	self:reInit()
end

function ActivityType101Model:reInit()
	self._type101Info = {}

	self:setCurIndex(nil)
end

function ActivityType101Model:getCurIndex()
	return self._curIndex
end

function ActivityType101Model:setCurIndex(index)
	self._curIndex = index
end

function ActivityType101Model:setType101Info(info)
	local data = {}
	local infos = {}
	local spInfos = {}

	for _, v in ipairs(info.infos) do
		local norSignInfoMo = ActivityType101InfoMo.New()

		norSignInfoMo:init(v)

		infos[v.id] = norSignInfoMo
	end

	for _, act101SpInfo in ipairs(info.spInfos) do
		local id = act101SpInfo.id
		local spInfo = ActivityType101SpInfoMo.New()

		spInfo:init(act101SpInfo)

		spInfos[id] = spInfo
	end

	data.infos = infos
	data.count = info.loginCount
	data.spInfos = spInfos
	self._type101Info[info.activityId] = data
end

function ActivityType101Model:setBonusGet(info)
	local actId = info.activityId

	if not self:isInit(actId) then
		return
	end

	self._type101Info[actId].infos[info.id].state = kState_Received
end

function ActivityType101Model:setBonusListGet(actId, ids)
	if not self:isInit(actId) then
		return
	end

	local infos = self._type101Info[actId].infos

	if ids and next(ids) then
		for _, id in ipairs(ids) do
			infos[id].state = kState_Received
		end
	end
end

function ActivityType101Model:getType101LoginCount(actId)
	if not self:isInit(actId) then
		return 0
	end

	return self._type101Info[actId].count
end

function ActivityType101Model:isType101RewardGet(actId, id)
	return self:getType101InfoState(actId, id) == kState_Received
end

function ActivityType101Model:isType101RewardCouldGet(actId, id)
	return self:getType101InfoState(actId, id) == kState_Available
end

function ActivityType101Model:getType101Info(actId)
	if not self:isInit(actId) then
		return
	end

	return self._type101Info[actId].infos
end

function ActivityType101Model:isType101RewardCouldGetAnyOne(actId)
	local infos = self:getType101Info(actId)

	if not infos then
		return false
	end

	for _, v in pairs(infos) do
		if v.state == kState_Available then
			return true
		end
	end

	return false
end

function ActivityType101Model:hasReceiveAllReward(actId)
	local infos = self:getType101Info(actId)

	if not infos then
		return true
	end

	for _, v in pairs(infos) do
		if v.state == kState_None or v.state == kState_Available then
			return false
		end
	end

	return true
end

function ActivityType101Model:isInit(actId)
	return not not self._type101Info[actId]
end

function ActivityType101Model:isOpen(actId)
	return ActivityHelper.getActivityStatus(actId, true) == ActivityEnum.ActivityStatus.Normal
end

function ActivityType101Model:getLastGetIndex(actId)
	local n = self:getType101LoginCount(actId)

	if n == 0 then
		return 0
	end

	local isGot = self:isType101RewardGet(n)

	if isGot then
		return n
	end

	local infos = self:getType101Info(actId)

	if not infos then
		return 0
	end

	local list = {}

	for _, v in pairs(infos) do
		local id = v.id

		if v.state == kState_Received then
			list[#list + 1] = id
		end
	end

	table.sort(list)

	return list[#list] or 0
end

function ActivityType101Model:getType101InfoState(actId, id)
	if not self:isInit(actId) then
		return kState_None
	end

	local infos = self:getType101Info(actId)

	if not infos then
		return kState_None
	end

	local info = infos[id]

	if not info then
		return kState_None
	end

	return info.state or kState_None
end

function ActivityType101Model:getType101SpInfo(actId)
	if not self:isInit(actId) then
		return
	end

	return self._type101Info[actId].spInfos
end

function ActivityType101Model:getType101SpInfoMo(actId, id)
	if not self:isInit(actId) then
		return
	end

	local spInfos = self:getType101SpInfo(actId)

	if not spInfos then
		return
	end

	return spInfos[id]
end

function ActivityType101Model:isType101SpRewardUncompleted(actId, id)
	local type101SpInfoMo = self:getType101SpInfoMo(actId, id)

	if not type101SpInfoMo then
		return false
	end

	return type101SpInfoMo:isNone()
end

function ActivityType101Model:isType101SpRewardCouldGet(actId, id)
	local type101SpInfoMo = self:getType101SpInfoMo(actId, id)

	if not type101SpInfoMo then
		return false
	end

	return type101SpInfoMo:isAvailable()
end

function ActivityType101Model:isType101SpRewardGot(actId, id)
	local type101SpInfoMo = self:getType101SpInfoMo(actId, id)

	if not type101SpInfoMo then
		return false
	end

	return type101SpInfoMo:isReceived()
end

function ActivityType101Model:setSpBonusGet(info)
	local actId = info.activityId
	local id = info.id
	local type101SpInfoMo = self:getType101SpInfoMo(actId, id)

	if not type101SpInfoMo then
		return
	end

	type101SpInfoMo:setState_Received()
end

function ActivityType101Model:isType101SpRewardCouldGetAnyOne(actId)
	local spInfos = self:getType101SpInfo(actId)

	if not spInfos then
		return false
	end

	for id, type101SpInfoMo in pairs(spInfos) do
		if type101SpInfoMo:isAvailable() then
			return true
		end
	end

	return false
end

function ActivityType101Model:claimAll(actId, cb, cbObj)
	local n = self:getType101LoginCount(actId)

	if n == 0 then
		if cb then
			cb(cbObj)
		end

		return
	end

	local infos = self:getType101Info(actId)

	if not infos then
		if cb then
			cb(cbObj)
		end

		return
	end

	local list = {}

	for _, v in pairs(infos) do
		local id = v.id

		if v.state == kState_Available then
			list[#list + 1] = id
		end
	end

	for i, id in ipairs(list) do
		local _cb, _cbObj

		if i == #list then
			_cb = cb
			_cbObj = cbObj
		end

		Activity101Rpc.instance:sendGet101BonusRequest(actId, id, _cb, _cbObj)
	end
end

function ActivityType101Model:getFirstAvailableIndex(actId)
	local infos = self:getType101Info(actId)

	for i, v in ipairs(infos or {}) do
		if v.state == kState_Available then
			return i
		end
	end

	return 0
end

function ActivityType101Model:isDayOpen(actId, id)
	if not id or not self:isInit(actId) then
		return false
	end

	local n = self:getType101LoginCount(actId)

	return id <= n
end

local k_Container = "_Container"
local Vxax_Role_FullSignView_Part = {
	bgBlur = 0,
	destroy = 0,
	mainRes = "ui/viewres/activity/v%sa%s_role_fullsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v%sa%s_role_signitem.prefab"
	}
}
local Vxax_Role_FullSignView_Part1 = Vxax_Role_FullSignView_Part
local Vxax_Role_FullSignView_Part2 = tabletool.copy(Vxax_Role_FullSignView_Part)

Vxax_Role_FullSignView_Part1.container = "Vxax_Role_FullSignView_Part1_Container"
Vxax_Role_FullSignView_Part2.container = "Vxax_Role_FullSignView_Part2_Container"
Vxax_Role_FullSignView_Part1._viewName = "V%sa%s_Role_FullSignView_Part1"
Vxax_Role_FullSignView_Part2._viewName = "V%sa%s_Role_FullSignView_Part2"
Vxax_Role_FullSignView_Part1._viewContainerName = Vxax_Role_FullSignView_Part1._viewName .. k_Container
Vxax_Role_FullSignView_Part2._viewContainerName = Vxax_Role_FullSignView_Part2._viewName .. k_Container
Vxax_Role_FullSignView_Part1._isFullView = true
Vxax_Role_FullSignView_Part2._isFullView = true
Vxax_Role_FullSignView_Part1._whichPart = 1
Vxax_Role_FullSignView_Part2._whichPart = 2

local Vxax_Role_PanelSignView_Part = {
	bgBlur = 1,
	destroy = 0,
	mainRes = "ui/viewres/activity/v%sa%s_role_panelsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default,
	otherRes = {
		[1] = "ui/viewres/activity/v%sa%s_role_signitem.prefab"
	}
}
local Vxax_Role_PanelSignView_Part1 = Vxax_Role_PanelSignView_Part
local Vxax_Role_PanelSignView_Part2 = tabletool.copy(Vxax_Role_PanelSignView_Part)

Vxax_Role_PanelSignView_Part1.container = "Vxax_Role_PanelSignView_Part1_Container"
Vxax_Role_PanelSignView_Part2.container = "Vxax_Role_PanelSignView_Part2_Container"
Vxax_Role_PanelSignView_Part1._viewName = "V%sa%s_Role_PanelSignView_Part1"
Vxax_Role_PanelSignView_Part2._viewName = "V%sa%s_Role_PanelSignView_Part2"
Vxax_Role_PanelSignView_Part1._viewContainerName = Vxax_Role_PanelSignView_Part1._viewName .. k_Container
Vxax_Role_PanelSignView_Part2._viewContainerName = Vxax_Role_PanelSignView_Part2._viewName .. k_Container
Vxax_Role_PanelSignView_Part1._isFullView = false
Vxax_Role_PanelSignView_Part2._isFullView = false
Vxax_Role_PanelSignView_Part1._whichPart = 1
Vxax_Role_PanelSignView_Part2._whichPart = 2

local Vxax_Special_FullSignView = {
	bgBlur = 0,
	container = "Vxax_Special_FullSignViewContainer",
	destroy = 0,
	_viewContainerName = "V%sa%s_Special_FullSignViewContainer",
	_isFullView = true,
	_viewName = "V%sa%s_Special_FullSignView",
	mainRes = "ui/viewres/activity/v%sa%s_special_fullsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
local Vxax_Special_PanelSignView = {
	bgBlur = 1,
	container = "Vxax_Special_PanelSignViewContainer",
	destroy = 0,
	_viewContainerName = "V%sa%s_Special_PanelSignViewContainer",
	_isFullView = false,
	_viewName = "V%sa%s_Special_PanelSignView",
	mainRes = "ui/viewres/activity/v%sa%s_special_panelsignview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
local Vxax_LinkageActivity_FullView = {
	bgBlur = 0,
	container = "Vxax_LinkageActivity_FullViewContainer",
	destroy = 0,
	_viewContainerName = "V%sa%s_LinkageActivity_FullViewContainer",
	_isFullView = true,
	_viewName = "V%sa%s_LinkageActivity_FullView",
	mainRes = "ui/viewres/activity/v%sa%s_linkageactivity_fullview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Normal,
	anim = ViewAnim.Default
}
local Vxax_LinkageActivity_PanelView = {
	bgBlur = 1,
	container = "Vxax_LinkageActivity_PanelViewContainer",
	destroy = 0,
	_viewContainerName = "V%sa%s_LinkageActivity_PanelViewContainer",
	_isFullView = false,
	_viewName = "V%sa%s_LinkageActivity_PanelView",
	mainRes = "ui/viewres/activity/v%sa%s_linkageactivity_panelview.prefab",
	layer = "POPUP_TOP",
	viewType = ViewType.Modal,
	anim = ViewAnim.Default
}

local function _make_SpecialSign__module_views(V, A, module_views)
	local function _make(setting)
		local viewname = sf(setting._viewName, V, A)
		local viewContainerName = sf(setting._viewContainerName, V, A)

		setting.mainRes = sf(setting.mainRes, V, A)
		setting._viewName = viewname

		local viewCls
		local viewContainerCls = _G.class(viewContainerName, Vxax_Special_SignItemViewContainer)

		if setting._isFullView then
			viewCls = _G.class(viewname, Vxax_Special_FullSignView)

			Vxax_Special_SignItemViewContainer.Vxax_Special_FullSignView(viewCls, V, A)
		else
			viewCls = _G.class(viewname, Vxax_Special_PanelSignView)

			Vxax_Special_SignItemViewContainer.Vxax_Special_PanelSignView(viewCls, V, A)
		end

		Vxax_Special_SignItemViewContainer.Vxax_Special_xxxSignView_Container(viewContainerCls, viewCls)

		module_views[viewname] = setting

		rawset(_G.ViewName, viewname, viewname)
		rawset(_G, viewname, viewCls)
		rawset(_G, viewContainerName, viewContainerCls)
	end

	_make(Vxax_Special_FullSignView)
	_make(Vxax_Special_PanelSignView)
end

local function _make_LinkageActivity__module_views(V, A, module_views)
	local function _make(setting)
		local viewname = sf(setting._viewName, V, A)
		local viewContainerName = sf(setting._viewContainerName, V, A)

		setting.mainRes = sf(setting.mainRes, V, A)
		setting._viewName = viewname

		local viewCls
		local viewContainerCls = _G.class(viewContainerName, LinkageActivity_BaseViewContainer)

		if setting._isFullView then
			viewCls = _G.class(viewname, LinkageActivity_FullView)

			LinkageActivity_BaseViewContainer.Vxax_LinkageActivity_FullView(viewCls, V, A)
		else
			viewCls = _G.class(viewname, LinkageActivity_PanelView)

			LinkageActivity_BaseViewContainer.Vxax_LinkageActivity_PanelView(viewCls, V, A)
		end

		LinkageActivity_BaseViewContainer.Vxax_LinkageActivity_xxxView_Container(viewContainerCls, viewCls)

		module_views[viewname] = setting

		rawset(_G.ViewName, viewname, viewname)
		rawset(_G, viewname, viewCls)
		rawset(_G, viewContainerName, viewContainerCls)
	end

	_make(Vxax_LinkageActivity_FullView)
	_make(Vxax_LinkageActivity_PanelView)
end

function ActivityType101Model:onModuleViews(versionFullInfo, module_views)
	local V, A = versionFullInfo.curV, versionFullInfo.curA

	_make_SpecialSign__module_views(V, A, module_views)
	_make_LinkageActivity__module_views(V, A, module_views)
end

ActivityType101Model.instance = ActivityType101Model.New()

return ActivityType101Model
