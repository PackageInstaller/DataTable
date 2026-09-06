-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingway/view/KingwayprizeView.lua

module("logic.extensions.kingway.view.KingwayprizeView", package.seeall)

local KingwayprizeView = class("KingwayprizeView", ViewComponent)

function KingwayprizeView:ctor()
	KingwayprizeView.super.ctor(self)
end

function KingwayprizeView:buildUI()
	KingwayprizeView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._tableGo = self:getGo("tableview")
	self._itemGo = self:getGo("tablecell")
	self._tableview = ScrollerList.create(self._tableGo, self._itemGo, GameUtil.handler(self._updateCell, self), GameUtil.handler(self._clearCell, self))
	self._txtTip = goutil.findChildTextComponent(self.mainGO, "txtTip")
end

function KingwayprizeView:bindEvents()
	KingwayprizeView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
end

function KingwayprizeView:unbindEvents()
	KingwayprizeView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function KingwayprizeView:destroyUI()
	KingwayprizeView.super.destroyUI(self)
end

function KingwayprizeView:onEnter()
	KingwayprizeView.super.onEnter(self)

	local dataList = {}

	self.battleId, self.stageId = KingWayModel.instance:GetKingBattleAndStageId()

	local battleCfg = KingWayConfig.instance:GetWayStagesCfg(self.battleId)

	if battleCfg == nil then
		error("sr_王者之路  KingBattleView:onEnter()    获取配置为空 = " .. self.battleId)

		return
	end

	if battleCfg then
		for i, cfg in pairs(battleCfg) do
			local goodsList = KingWayModel.instance:GetWayStageGoods(self.battleId, cfg.stageId)

			if goodsList then
				local single = {}

				single.rewardStr = goodsList
				single.stageId = cfg.stageId
				single.isPass = self.stageId >= cfg.stageId

				table.insert(dataList, single)
			end
		end
	end

	table.sort(dataList, function(a, b)
		if a.isPass ~= b.isPass then
			return b.isPass
		end

		return b.stageId > a.stageId
	end)

	self._txtTip.text = "首次通关后可马上获得<color=#60ee85>首通奖励</color>，不可重复挑战也不可扫荡。"

	self._tableview:reloadData(dataList)
end

function KingwayprizeView:onEnterFinished()
	KingwayprizeView.super.onEnterFinished(self)
end

function KingwayprizeView:onExit()
	KingwayprizeView.super.onExit(self)
	self._tableview:dispose()
end

function KingwayprizeView:onExitFinished()
	KingwayprizeView.super.onExitFinished(self)
end

function KingwayprizeView:_updateCell(view, cell, data)
	local txtName = goutil.findChildTextComponent(cell, "imgDes/name")
	local content = goutil.findChild(cell, "content")
	local itemCell = goutil.findChild(cell, "itemCell")
	local goNotGet = goutil.findChild(cell, "state/notGet")
	local goGet = goutil.findChild(cell, "state/get")
	local goState = goutil.findChild(cell, "state")

	goutil.clearChildren(content)

	txtName.text = string.format("第%s层", data.stageId)

	goutil.setActive(goState, true)
	goutil.setActive(goNotGet, not data.isPass)
	goutil.setActive(goGet, data.isPass)

	local length2 = #data.rewardStr

	for i = 1, length2 do
		if not string.nilorempty(data.rewardStr[i]) then
			local itemcell = goutil.cloneAndSetParent(itemCell, content.transform)

			MaterialMgr.setCellByCfg(data.rewardStr[i], itemcell)
		end
	end
end

return KingwayprizeView
