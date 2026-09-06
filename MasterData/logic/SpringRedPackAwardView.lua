-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/springredpack/view/SpringRedPackAwardView.lua

module("logic.extensions.springredpack.view.SpringRedPackAwardView", package.seeall)

local SpringRedPackAwardView = class("SpringRedPackAwardView", TableViewComponent)

function SpringRedPackAwardView:_getPath()
	return {
		cellPath = "other/tablecell",
		viewPath = "other/tableview"
	}
end

function SpringRedPackAwardView:buildUI()
	SpringRedPackAwardView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._txtTip = self:getTxt("txtTip")
	self._txtName = self:getTxt("bigAward/txtName")
	self._item = self:getGo("bigAward/item")
	self._item2 = self:getGo("bigAward/item2")
	self._con_21 = self:getGo("bigAward/item2/con_1")
	self._con_22 = self:getGo("bigAward/item2/con_2")
	self._item3 = self:getGo("bigAward/item3")
	self._con_31 = self:getGo("bigAward/item3/con_1")
	self._con_32 = self:getGo("bigAward/item3/con_2")
	self._con_33 = self:getGo("bigAward/item3/con_3")
end

function SpringRedPackAwardView:bindEvents()
	SpringRedPackAwardView.super.bindEvents(self)
	self._btnClose:AddClickListener(self._onClickClose, self)
end

function SpringRedPackAwardView:unbindEvents()
	SpringRedPackAwardView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
end

function SpringRedPackAwardView:onEnter()
	SpringRedPackAwardView.super.onEnter(self)

	local redPackId = self:getFirstParam()
	local cfg = SpringRedPackConfig.instance:getRedPackCfg(redPackId)

	if cfg then
		self:_initBigReward(cfg.prize, cfg.bigPrizeName)
		self:_initRewardList(cfg.prizePlanId)
	end
end

function SpringRedPackAwardView:onExit()
	SpringRedPackAwardView.super.onExit(self)
	self:_clearReward()
end

function SpringRedPackAwardView:_onClickClose()
	self:close()
end

function SpringRedPackAwardView:_updateCell(view, cell, data)
	MaterialMgr.setCellByCfg(data.prize, cell.gameObject)
end

function SpringRedPackAwardView:_clearTableview(cell)
	MaterialMgr.resetAll(cell.gameObject)
end

function SpringRedPackAwardView:_initBigReward(prize, bigPrizeName)
	local arr = string.split(prize, "#")

	GameUtil.SetActive(self._item, false)
	GameUtil.SetActive(self._item2, false)
	GameUtil.SetActive(self._item3, false)

	local list = {}

	for i, v in ipairs(arr) do
		local matType, id, matNum = MaterialMgr.getMatParams(v)
		local nn = MaterialMgr.getMaterialsName(matType, id)

		table.insert(list, nn .. "x" .. matNum)
	end

	if #arr == 1 then
		GameUtil.SetActive(self._item, true)

		local pp = arr[1]
		local matType, id, matNum = MaterialMgr.getMatParams(pp)
		local name = MaterialMgr.getMaterialsName(matType, id)

		self._txtName.text = string.format("%s*%s", name, matNum)

		MaterialMgr.setCellByCfg(pp, self._item)
	elseif #arr == 2 then
		GameUtil.SetActive(self._item2, true)
		MaterialMgr.setCellByCfg(arr[1], self._con_21)
		MaterialMgr.setCellByCfg(arr[2], self._con_22)
	elseif #arr == 3 then
		GameUtil.SetActive(self._item3, true)
		MaterialMgr.setCellByCfg(arr[1], self._con_31)
		MaterialMgr.setCellByCfg(arr[2], self._con_32)
		MaterialMgr.setCellByCfg(arr[3], self._con_33)
	end

	if not string.nilorempty(bigPrizeName) then
		self._txtName.text = bigPrizeName
	end

	self._txtTip.text = string.format("%s红包，最多可抽到<color=#F48B6FFF>%s</color>", bigPrizeName, table.concat(list, "、"))
end

function SpringRedPackAwardView:_initRewardList(prizePlanId)
	local list = SpringRedPackConfig.instance:getPrizeList(prizePlanId, false)

	self:updateListData(list)
end

function SpringRedPackAwardView:_clearReward()
	MaterialMgr.resetAll(self._item)
end

return SpringRedPackAwardView
