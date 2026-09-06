-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/miruikeintroduce/view/MiruikeBuyView.lua

module("logic.extensions.miruikeintroduce.view.MiruikeBuyView", package.seeall)

local MiruikeBuyView = class("MiruikeBuyView", ViewComponent)

function MiruikeBuyView:ctor()
	MiruikeBuyView.super.ctor(self)
end

function MiruikeBuyView:unbindEvents()
	MiruikeBuyView.super.unbindEvents(self)

	for _, btn in ipairs(self._adJumps) do
		GameUtil.rmClickHandler(btn)
	end
end

function MiruikeBuyView:bindEvents()
	MiruikeBuyView.super.bindEvents(self)

	for i, btn in ipairs(self._adJumps) do
		GameUtil.addClickHandler(btn, GameUtil.handler(self._onClickJump, self, i))
	end
end

function MiruikeBuyView:buildUI()
	MiruikeBuyView.super.buildUI(self)

	self._scrollRect = self:getGo("tableview"):GetComponent(ComponentType.ScrollRect)
	self.tableview = self:getGo("tableview")
	self.cell = self:getGo("cell")
	self.scrollList = ScrollerList.create(self.tableview, self.cell, GameUtil.handler(self._updateCell, self), GameUtil.handler(self.clearCell, self))
	self.cellMap = {}
	self._curActId = checkint(MiruikeIntroduceConfig.instance:getCommonValue("TAB2_ACT_ID"))
	self._adDescs = {}
	self._adJumps = {}
	self._adItems = {}
	self._tags = {}

	for i = 1, 2 do
		table.insert(self._adDescs, self:getTxt(string.format("adCell_%d/txtDesc", i)))
		table.insert(self._adJumps, self:getBtn(string.format("adCell_%d/btnJump", i)))
		table.insert(self._adItems, self:getGo(string.format("adCell_%d/item", i)))
		table.insert(self._tags, self:getTxt(string.format("tag%d/txt", i)))
	end

	self._txtIntroduce = self:getTxt("txtIntroduce")
end

function MiruikeBuyView:onExit()
	MiruikeBuyView.super.onExit(self)
	self.scrollList:dispose()
	GlobalDispatcher:removeListener(PayShopModel.ChangeMibaoShopBuyTimes, self.updateGoodsView, self)
	GlobalDispatcher:removeListener(PayAgent.NotifyPayResultRes, self._payResultRes, self)
end

function MiruikeBuyView:onEnter()
	MiruikeBuyView.super.onEnter(self)

	self.listCfg = ActivityPopupModel.instance:getAutoMallCfgs(self._curActId)

	GlobalDispatcher:addListener(PayShopModel.ChangeMibaoShopBuyTimes, self.updateGoodsView, self)
	GlobalDispatcher:addListener(PayAgent.NotifyPayResultRes, self._payResultRes, self)

	for i = 1, 2 do
		local conf = MiruikeIntroduceConfig.instance:getJump2Conf(i)

		self._adDescs[i].text = conf.desc

		if not string.nilorempty(conf.item) then
			MaterialMgr.updateItemByStr(self._adItems[i], tostring(conf.item))
		end

		self._tags[i].text = MiruikeIntroduceConfig.instance:getCommonValue(string.format("TAB_TAG_%d", i))
	end

	self._txtIntroduce.text = MiruikeIntroduceConfig.instance:getCommonValue("INTRODUCE")

	self:updateGoodsView()
end

function MiruikeBuyView:_payResultRes(status, msg)
	if status == 0 then
		local goodsId = msg.subGoodsId
		local payCfg = PayShopConfig.instance:getPayShopGoodsCfgById(goodsId)

		if payCfg then
			SurveyController.instance:reportBehavior(SurveyBehaviorID.SHOP_POPUP_BUY, payCfg.name)
		end

		self:updateGoodsView()
	end
end

function MiruikeBuyView:updateGoodsView()
	local datas = {}

	for i, cfg in ipairs(self.listCfg) do
		local obj = {}

		obj.id = cfg.id
		obj.index = i
		obj.times = PayShopModel.instance:getMibaoBuyTimesById(cfg.id)

		local goodsCfg = PayShopConfig.instance:getPayShopGoodsCfgById(obj.id)

		table.insert(datas, {
			goodsData = obj
		})
	end

	ArraySort.sortOn(datas, {
		function(obj)
			local goodsCfg = PayShopConfig.instance:getPayShopGoodsCfgById(obj.goodsData.id)

			if goodsCfg.limitType ~= "none" and goodsCfg.limitTimes > 0 then
				if obj.goodsData.times then
					local isSellOut = obj.goodsData.times >= goodsCfg.limitTimes

					if isSellOut then
						return 1
					else
						return 0
					end
				end
			end
		end,
		"index"
	})
	self.scrollList:reloadData(datas)
	self.scrollList:refresh()
end

function MiruikeBuyView:_updateCell(view, cell, data, tag)
	local component = GameUtil.AddLuaOnce(cell.gameObject, PayShopMibaoGoodsItem)

	component:onEnter(self, self._scrollRect, data)
end

function MiruikeBuyView:clearCell(cell)
	local component = GameUtil.AddLuaOnce(cell.gameObject, PayShopMibaoGoodsItem)

	component:onExit()
end

function MiruikeBuyView:_onClickJump(index)
	if index == 1 then
		SurveyController.instance:reportBehavior(200926)
	elseif index == 2 then
		SurveyController.instance:reportBehavior(200927)
	end

	MiruikeTipsView.showInternal()
end

return MiruikeBuyView
