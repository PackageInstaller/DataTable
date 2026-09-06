-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/season/view/SeasonRankMainView.lua

module("logic.extensions.season.view.SeasonRankMainView", package.seeall)

local SeasonRankMainView = class("SeasonRankMainView", ViewComponent)

function SeasonRankMainView:ctor()
	SeasonRankMainView.super.ctor(self)
end

function SeasonRankMainView:unbindEvents()
	SeasonRankMainView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnTip:RemoveClickListener()
	self._dropdown:RemoveOnValueChanged()
end

function SeasonRankMainView:bindEvents()
	SeasonRankMainView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
	self._btnTip:AddClickListener(self._onClickRule, self)
	self._dropdown:AddOnValueChanged(self._onValueChanged, self)
end

function SeasonRankMainView:buildUI()
	SeasonRankMainView.super.buildUI(self)

	self._viewBgGo = self:getGo("bg")
	self._container = self:getGo("right")
	self._btnClose = self:getBtn("btnClose")
	self._btnTip = self:getBtn("btnTip")
	self._txtTitle = self:getTxt("txtTitle")
	self._dropdown = DropDownAdapter.Get(self:getGo("division"))
	self._tabCell = self:getGo("tabCell")
	self._goTabView = self:getGo("tabView")
	self._tabTabView = ScrollerList.create(self._goTabView, self._tabCell, GameUtil.handler(self._updateTabCell, self), GameUtil.handler(self._clearTabCell, self))
	self._nowSelectType = 1
	self._nowSelectTab = 1
	self._tabItemMap = {}
end

function SeasonRankMainView:onExit()
	SeasonRankMainView.super.onExit(self)
	GlobalDispatcher:removeListener(GlobalNotify.SeasonRankChangeTab, self._changeTabByRankType, self)
	self._tabTabView:dispose()
end

function SeasonRankMainView:onEnter()
	SeasonRankMainView.super.onEnter(self)
	GlobalDispatcher:addListener(GlobalNotify.SeasonRankChangeTab, self._changeTabByRankType, self)

	local params = self._viewPresentor:getOpenParam()

	if params then
		if params[1] then
			self._seasonId = checknumber(params[1])
		end
	else
		printError(">>>>>>>必须传入 _seasonId ")

		self._seasonId = SeasonModel.instance:getSeasonId()
	end

	local rankCfg = SeasonRankModel.instance:getRankAllTabViewData(self._seasonId)

	self._tabData = rankCfg.rankType
	self._areaData = rankCfg.areaType

	self:_setMainViewData()
	self._dropdown:ClearOptions()

	for i, value in ipairs(self._areaData) do
		self._dropdown:AddOptions(value.name)
	end

	self._tabTabView:reloadData(self._tabData)

	self._selfAreaId = RoleModel.instance:getAreaId()

	for k, v in ipairs(self._areaData) do
		local minAreaId = v.areaIds[1]
		local maxAreaId = v.areaIds[2]

		if minAreaId <= self._selfAreaId and maxAreaId >= self._selfAreaId then
			self._nowSelectType = k
		end
	end

	self._dropdown:SetValue(self._nowSelectType - 1)
	self:_changeTabByRankType(self._nowSelectTab)
end

function SeasonRankMainView:_updateTabCell(view, goCell, data)
	local cell = self:_clearTabCell(goCell)

	cell.txtName.text = data.name

	cell.txtColor:SetState(self._nowSelectTab == data.type and 1 or 0)
	cell.changeTab:SetState(self._nowSelectTab == data.type and 1 or 0)

	self._tabItemMap[data.type] = cell

	GameUtil.addClickHandler(cell.go, GameUtil.handler(self._onClickTab, self, data))
end

function SeasonRankMainView:_clearTabCell(goCell)
	local cell = {}

	cell.go = goCell
	cell.txtName = goutil.findChildTextComponent(goCell, "txtName")
	cell.txtColor = goutil.findChildComponent(goCell, "txtName", "UITextColorChange")
	cell.changeTab = goCell:GetComponent(typeof(UIChangeGroup))

	GameUtil.rmClickHandler(cell.go)

	return cell
end

function SeasonRankMainView:_setMainViewData()
	local seasonId = self._seasonId

	self._txtTitle.text = "S" .. seasonId .. "赛季"
end

function SeasonRankMainView:_changeTabByRankType(rankType)
	if rankType then
		self._nowSelectTab = rankType

		self:_onClickTab(self._tabData[self._nowSelectTab])
	end
end

function SeasonRankMainView:_onClickTab(data)
	self:_changeTab(data.type)

	local param = {
		rankType = self._tabData[self._nowSelectTab].type,
		zoneId = self._areaData[self._nowSelectType].zoneId,
		seasonId = self._seasonId
	}

	self:showTabAt(self._container, data.viewName, param)
	self._tabTabView:MoveCellToCenter(self._nowSelectTab)
end

function SeasonRankMainView:_changeTab(tabType)
	for type, cell in pairs(self._tabItemMap) do
		cell.txtColor:SetState(tabType == type and 1 or 0)
		cell.changeTab:SetState(tabType == type and 1 or 0)
	end

	self._nowSelectTab = tabType
end

function SeasonRankMainView:_onValueChanged(value)
	value = value + 1

	if self._nowSelectType ~= value then
		self._nowSelectType = value

		self:_onClickTab(self._tabData[self._nowSelectTab])

		local param = {
			rankType = self._tabData[self._nowSelectTab].type,
			zoneId = self._areaData[self._nowSelectType].zoneId,
			seasonId = self._seasonId
		}

		SeasonController.instance:localNotify(SeasonController.RefreshViewData, param)
	end
end

function SeasonRankMainView:_onClickClose()
	self:close()
end

function SeasonRankMainView:_onClickRule()
	local cfg = SeasonConfig.instance:getSeasonConfigBySeasonId(self._seasonId)

	if cfg and not string.nilorempty(cfg.rankRuleKey) then
		TipsFacade.instance:openRulesView(cfg.rankRuleKey)
	else
		TipsFacade.instance:openRulesView("seasonrankmain")
	end
end

return SeasonRankMainView
