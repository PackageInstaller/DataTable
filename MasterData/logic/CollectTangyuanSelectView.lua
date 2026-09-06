-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/collecttangyuan/view/CollectTangyuanSelectView.lua

module("logic.extensions.collecttangyuan.view.CollectTangyuanSelectView", package.seeall)

local CollectTangyuanSelectView = class("CollectTangyuanSelectView", TableViewComponent)

function CollectTangyuanSelectView:ctor()
	CollectTangyuanSelectView.super.ctor(self)

	self._selectList = nil
end

function CollectTangyuanSelectView:unbindEvents()
	CollectTangyuanSelectView.super.unbindEvents(self)
	self._celenBtn:RemoveClickListener()
	self._sureBtn:RemoveClickListener()
end

function CollectTangyuanSelectView:bindEvents()
	CollectTangyuanSelectView.super.bindEvents(self)
	self._celenBtn:AddClickListener(self.close, self)
	self._sureBtn:AddClickListener(self._onClickSureBtn, self)
end

function CollectTangyuanSelectView:buildUI()
	CollectTangyuanSelectView.super.buildUI(self)

	self._celenBtn = self:getBtn("viewBgGo/celenBtn")
	self._sureBtn = self:getBtn("viewBgGo/sureBtn")
	self._descTxt = self:getTxt("viewBgGo/descTxt")
end

function CollectTangyuanSelectView:onEnter()
	CollectTangyuanSelectView.super.onEnter(self)

	self._curParams = self:getFirstParam()
	self._curViewDatas = {}

	local prizeIds = self._curParams.cfg.prizeId
	local erInfos = self._curParams.exchangeRecords
	local cfg

	for _, v in pairs(prizeIds or {}) do
		if v and checknumber(v) > 0 then
			cfg = CollectTangyuanConfig.instance:getCollectTangyuanPrizes(self._curParams.planId, v)

			if cfg and cfg.limit > 0 then
				table.insert(self._curViewDatas, {
					cfg = cfg,
					useNum = checknumber(erInfos[cfg.prizeId])
				})
			end
		end
	end

	if #self._curViewDatas > 1 then
		table.sort(self._curViewDatas, function(a, b)
			return a.cfg.prizeId < b.cfg.prizeId
		end)
	end

	self:_updataSelectItemListSR()
end

function CollectTangyuanSelectView:_updataSelectItemListSR()
	self._selectList = {}
	self._descTxt.text = string.format("可选道具：<color=#009531>%s/%s</color>", math.max(self._curParams.cfg.selectNum - #self._selectList, 0), self._curParams.cfg.selectNum)

	self:reloadData()
end

function CollectTangyuanSelectView:_onClickSureBtn()
	if self._selectList == nil or #self._selectList ~= self._curParams.cfg.selectNum then
		FloatWordMgr.instance:show(string.format("请选择%s个奖励做为兑换目标！", self._curParams.cfg.selectNum))

		return
	end

	YuanXiaoKingsExchangeAgent.instance:sendPM_KingsExchangeSelectListReq(self._curParams.activityId, self._curParams.cfg.groupId, self._selectList)
	self:close()
end

function CollectTangyuanSelectView:_getPath()
	return {
		cellPath = "viewBgGo/itemGo",
		viewPath = "viewBgGo/itemListSR"
	}
end

function CollectTangyuanSelectView:_updateCell(view, cell, data)
	local goodsPos = goutil.findChild(cell, "goodsPos")
	local goodsTxt = goutil.findChildTextComponent(cell, "goodsTxt")
	local nameTxt = goutil.findChildTextComponent(cell, "nameTxt")
	local selectGo = goutil.findChild(cell, "selectGo")
	local clickBtnGo = goutil.findChild(cell, "clickBtn")

	GameUtil.asBtn(clickBtnGo):RemoveClickListener()
	MaterialMgr.resetAll(goodsPos)
	MaterialMgr.setCellByCfg(data.cfg.gain, goodsPos)

	goodsTxt.text = string.format("剩余：%s/%s", math.max(data.cfg.limit - data.useNum), data.cfg.limit)

	local index = table.indexof(self._selectList, data.cfg.prizeId)
	local isSelect = index ~= false

	GameUtil.SetActive(selectGo, isSelect)

	nameTxt.text = MaterialMgr.getMaterialsNameByCfg(data.cfg.gain)

	GameUtil.asBtn(clickBtnGo):AddClickListener(function()
		self._selectList = self._selectList or {}

		if not isSelect then
			if #self._selectList >= self._curParams.cfg.selectNum then
				FloatWordMgr.instance:show("已选择了最大数量奖励了！")

				return
			end

			if data.useNum >= data.cfg.limit then
				FloatWordMgr.instance:show("当前奖励次数使用完了！")

				return
			end

			table.insert(self._selectList, data.cfg.prizeId)
		else
			table.remove(self._selectList, index)
		end

		self._descTxt.text = string.format("可选道具：<color=green>%s/%s</color>", math.max(self._curParams.cfg.selectNum - #self._selectList, 0), self._curParams.cfg.selectNum)

		self:reloadData()
	end, self)
end

return CollectTangyuanSelectView
