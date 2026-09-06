-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/origingoldendragonclg/view/OriginGoldenDragonClgSelectView.lua

module("logic.extensions.origingoldendragonclg.view.OriginGoldenDragonClgSelectView", package.seeall)

local OriginGoldenDragonClgSelectView = class("OriginGoldenDragonClgSelectView", ViewComponent)

function OriginGoldenDragonClgSelectView:ctor()
	OriginGoldenDragonClgSelectView.super.ctor(self)
end

function OriginGoldenDragonClgSelectView:unbindEvents()
	OriginGoldenDragonClgSelectView.super.unbindEvents(self)
	GameUtil.rmClickHandler(self._btnEnter)
end

function OriginGoldenDragonClgSelectView:bindEvents()
	OriginGoldenDragonClgSelectView.super.bindEvents(self)
	GameUtil.addClickHandler(self._btnEnter, self._onClickBtnEnter, self)
end

function OriginGoldenDragonClgSelectView:buildUI()
	OriginGoldenDragonClgSelectView.super.buildUI(self)

	local goTab = self:getGo("tableview")
	local goCell = self:getGo("tableview/viewport/content/cell")

	self._tableview = ScrollerList.create(goTab, goCell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._btnEnter = self:getGo("btnEnter")
	self._txtHitstory = self:getTxt("txtHitstory")
end

function OriginGoldenDragonClgSelectView:onExit()
	OriginGoldenDragonClgSelectView.super.onExit(self)
end

function OriginGoldenDragonClgSelectView:onEnter()
	OriginGoldenDragonClgSelectView.super.onEnter(self)
	self.addGEvent(self, GlobalNotify.OriginGoldenDragonClgChangeProphecyId, self._onProphecyIdChanged, self)
	self.addGEvent(self, GlobalNotify.PM_OriginGoldenDragonClgGetInfoRes, self._updateUIByInfo, self)

	local params = self:getOpenParam() or {}

	self._activityId = checknumber(params[1])

	if self._activityId == 0 then
		self._activityId = OriginGoldenDragonClgController.instance:getDefaultActivityId()
	end

	self._stageId = checknumber(params[2])
	self._isEnterFormFmt = params[3] == true

	self:_updateUIbyCfg()
	self:_updateUIByInfo()
	OriginGoldenDragonClgController.instance:getInfo(self._activityId)
end

function OriginGoldenDragonClgSelectView:_updateUIbyCfg()
	self._curShowDataList = {}

	local allProCfgs = OriginGoldenDragonClgConfig.instance:getAllProphecyCfgsByActId(self._activityId) or {}

	for _, cfg in ipairs(allProCfgs) do
		table.insert(self._curShowDataList, cfg)
	end
end

function OriginGoldenDragonClgSelectView:_updateUIByInfo()
	ArraySort.sortOn(self._curShowDataList, {
		function(cfg)
			local prophecyId = cfg.prophecyId
			local hasProphecy = OriginGoldenDragonClgModel.instance:hasProphecy(self._activityId, prophecyId)

			return hasProphecy and 1 or 0
		end
	}, {
		ArraySort.NUMERIC
	})

	local hasProphecyCfgs = {}

	for _, cfg in ipairs(self._curShowDataList) do
		local prophecyId = cfg.prophecyId

		if OriginGoldenDragonClgModel.instance:hasProphecy(self._activityId, prophecyId) then
			table.insert(hasProphecyCfgs, cfg)
		end
	end

	if #hasProphecyCfgs > 0 then
		local showTxt = ""
		local colNum = math.ceil(#hasProphecyCfgs / 2)

		for i, cfg in ipairs(hasProphecyCfgs) do
			if not cfg.name then
				local name = ""
				local addTips = langPara("%s、%s", i, name)

				showTxt = showTxt .. addTips .. "    "

				if i % colNum == 0 then
					showTxt = showTxt .. "\n"
				end
			end
		end

		self._txtHitstory.text = showTxt
	else
		self._txtHitstory.text = lang("无")
	end

	if not self._isEnterFormFmt then
		if self._curShowDataList[1] then
			self._curSelectProphecyId = self._curShowDataList[1].prophecyId or 0
		end

		OriginGoldenDragonClgController.instance:setCurSelectProphecyId(self._curSelectProphecyId)
	else
		self._curSelectProphecyId = OriginGoldenDragonClgController.instance:getCurSelectProphecyId()
	end

	self._tableview:reloadData(self._curShowDataList)
	self._tableview:MoveCellToBegin(0)
end

function OriginGoldenDragonClgSelectView:_onProphecyIdChanged()
	self._curSelectProphecyId = OriginGoldenDragonClgController.instance:getCurSelectProphecyId()

	self._tableview:reloadData(self._curShowDataList)
end

function OriginGoldenDragonClgSelectView:_updateCell(view, cell, data)
	local prophecyId = data.prophecyId
	local hasProphecy = OriginGoldenDragonClgModel.instance:hasProphecy(self._activityId, prophecyId)
	local go = cell.gameObject
	local con = goutil.findChild(go, "con")
	local txtName = goutil.findChildTextComponent(go, "con/txtName")

	txtName.text = data.name or ""

	GameUtil.SetGray(con, hasProphecy)

	local txtScore = goutil.findChildTextComponent(go, "txtScore")

	txtScore.text = langPara("分数%s", data.baseScore or 0)

	local txtDesc = goutil.findChildTextComponent(go, "txtDesc")

	txtDesc.text = data.desc or ""

	GameUtil.addClickHandler(go, GameUtil.handler(function()
		if hasProphecy then
			TipsFacade.instance:openCommonTips(lang("不可重复选择~"))

			return
		end

		self._curSelectProphecyId = prophecyId

		self._tableview:reloadData(self._curShowDataList)
	end, self, data))

	local selected = self._curSelectProphecyId == prophecyId
	local markSelect = goutil.findChild(go, "select")

	goutil.setActive(markSelect, selected)
end

function OriginGoldenDragonClgSelectView:_clearCell(go)
	local go = go.gameObject

	GameUtil.rmClickHandler(go)
end

function OriginGoldenDragonClgSelectView:_onClickBtnEnter()
	local prophecyId = self._curSelectProphecyId
	local prophecyCfg = OriginGoldenDragonClgConfig.instance:getProphecyCfgById(self._activityId, prophecyId)

	if prophecyCfg == nil then
		TipsFacade.instance:openCommonTips(lang("预言配置不存在~"))

		return
	end

	if OriginGoldenDragonClgModel.instance:hasProphecy(self._activityId, prophecyId) then
		TipsFacade.instance:openCommonTips(lang("不可重复选择~"))

		return
	end

	self:close()
	OriginGoldenDragonClgController.instance:setCurSelectProphecyId(self._curSelectProphecyId)

	if not self._isEnterFormFmt then
		OriginGoldenDragonClgController.instance:enterFmtMo(self._activityId, self._stageId)
	end
end

return OriginGoldenDragonClgSelectView
