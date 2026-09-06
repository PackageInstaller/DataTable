-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/elementspark/view/ElementsparkpopView.lua

module("logic.extensions.elementspark.view.ElementsparkpopView", package.seeall)

local ElementsparkpopView = class("ElementsparkpopView", ViewComponent)

function ElementsparkpopView:ctor()
	ElementsparkpopView.super.ctor(self)
end

function ElementsparkpopView:unbindEvents()
	ElementsparkpopView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function ElementsparkpopView:bindEvents()
	ElementsparkpopView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickbtnClose, self)
end

function ElementsparkpopView:buildUI()
	ElementsparkpopView.super.buildUI(self)

	self._tablecellbelongGo = self:getGo("tablecellbelong")
	self._tableviewBelongGo = self:getGo("tableviewBelong")
	self._tableviewGo = self:getGo("tableview")
	self._tablecellGo = self:getGo("tablecell")
	self._txtDesc = self:getTxt("txtDesc")
	self._btnClose = self:getBtn("btnClose")
	self._belongEmptyGo = self:getGo("belongEmpty")
	self._emptyGo = self:getGo("empty")
	self._scrollerList = ScrollerList.create(self._tableviewGo, self._tablecellGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._scrollerListBelong = ScrollerList.create(self._tableviewBelongGo, self._tablecellbelongGo, GameUtil.handler(self._updateBelongCell, self), GameUtil.handler(self._clearBelongCell, self))
end

function ElementsparkpopView:onExit()
	ElementsparkpopView.super.onExit(self)
	self._scrollerList:dispose()
	self._scrollerListBelong:dispose()
end

function ElementsparkpopView:onEnter()
	ElementsparkpopView.super.onEnter(self)

	self._activityId = ElementSparkController.instance:getActivityId()
	self._belongCampId = ElementSparkModel.instance:getSparkBelong()

	self.addGEvent(self, GlobalNotify.ElementSparkGetSparkInfo, self._onElementSparkGetSparkInfo, self)
	self:_updateUI()
	ElementSparkController.instance:sendPM_EleSparkGetSparkInfoReq()
end

function ElementsparkpopView:_onClickbtnClose()
	self:close()
end

function ElementsparkpopView:_updateUI()
	local info = ElementSparkModel.instance:getSparkInfo()

	if not info then
		return
	end

	if not info.historyCampIds then
		local historyCampIds = {}
		local newhistoryCampIds = {}

		for i = #historyCampIds, 1, -1 do
			table.insert(newhistoryCampIds, historyCampIds[i])
		end

		self._scrollerListBelong:reloadData(newhistoryCampIds)
		goutil.setActive(self._belongEmptyGo, #historyCampIds <= 0)

		if not info.campOccupyInfos then
			local campOccupyInfos = {}

			self._scrollerList:reloadData(campOccupyInfos)
			goutil.setActive(self._emptyGo, #campOccupyInfos <= 0)
			self:_setDesc()
		end
	end
end

function ElementsparkpopView:_setDesc()
	local planId = ElementSparkController.instance:getMapPlanId()
	local chunkCfgs = ElementSparkConfig.instance:getMapChunkCfgs(planId)
	local sparkPlanId = 0

	for i, v in pairs(chunkCfgs) do
		if v.chunkType == GameEnum.ElementSparkChunkType.Spark then
			sparkPlanId = v.sparkPlanId

			break
		end
	end

	local numList = {}
	local rateList = {}

	if sparkPlanId > 0 then
		local cfgs = ElementSparkConfig.instance:getSparkSurroundCfgs(sparkPlanId)
		local list = table.values(cfgs)

		table.sort(list, function(a, b)
			return a.surroundCount < b.surroundCount
		end)

		for i, v in ipairs(list) do
			table.insert(numList, v.surroundCount)

			if v.production then
				local num = 0

				for _, prodId in ipairs(v.production) do
					local pcfg = ElementSparkConfig.instance:getProductCfg(prodId)

					num = num + pcfg.rate
				end

				table.insert(rateList, "+" .. num)
			else
				table.insert(rateList, "+0")
			end
		end
	end

	self._txtDesc.text = string.format("累计占领%s个龙蛋周边地块，可分别获得每分钟%s的阵营积分加成", table.concat(numList, "/"), table.concat(rateList, "/"))
end

function ElementsparkpopView:_updateCell(view, cell, data, tag)
	local txtDesc = goutil.findChildTextComponent(cell.gameObject, "txtDesc")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local lineChange = goutil.findChild(cell.gameObject, "line"):GetComponent(ComponentType.UIImageSpriteChange)
	local txtEmpty = goutil.findChild(cell.gameObject, "txtEmpty")
	local campCfg = ElementSparkConfig.instance:getCampCfgById(self._activityId, data.campId)

	txtName.text = campCfg.name

	goutil.setActive(txtEmpty, data.occupyCount < 3)
	goutil.setActive(lineChange.gameObject, data.occupyCount >= 3)

	idx = data.occupyCount < 6 and 0 or data.occupyCount < 9 and 1 or data.occupyCount < 12 and 2 or 3

	lineChange:SetState(idx)

	txtDesc.text = string.format("阵营积分额外+%s/分钟", data.productRate)
end

function ElementsparkpopView:_clearCell(cell)
	return
end

function ElementsparkpopView:_updateBelongCell(view, cell, campId, tag)
	local goIcon = goutil.findChild(cell.gameObject, "icon")
	local goTag = goutil.findChild(cell.gameObject, "tag")
	local txtName = goutil.findChildTextComponent(cell.gameObject, "txtName")
	local campCfg = ElementSparkConfig.instance:getCampCfgById(self._activityId, campId)

	txtName.text = campCfg.name

	local isGray = cell.data ~= 1 or campId ~= self._belongCampId

	goutil.setActive(goTag, not isGray)
	GameUtil.SetGray(cell.gameObject, isGray)

	local spriteName = string.format("ui/icon/%s.png", campCfg.headIcon)

	uGuiUtil.setSpriteToImage(goIcon, nil, spriteName)
end

function ElementsparkpopView:_clearBelongCell(cell)
	GameUtil.SetGray(cell.gameObject, false)

	local goIcon = goutil.findChild(cell.gameObject, "icon")

	uGuiUtil.clearImage(goIcon)
end

function ElementsparkpopView:_onElementSparkGetSparkInfo()
	self:_updateUI()
end

return ElementsparkpopView
