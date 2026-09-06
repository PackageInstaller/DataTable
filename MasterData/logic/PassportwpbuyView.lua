-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/passport/view/PassportwpbuyView.lua

module("logic.extensions.passport.view.PassportwpbuyView", package.seeall)

local PassportwpbuyView = class("PassportwpbuyView", ViewComponent)
local json = require("cjson")

function PassportwpbuyView:ctor()
	PassportwpbuyView.super.ctor(self)
end

function PassportwpbuyView:buildUI()
	PassportwpbuyView.super.buildUI(self)

	self._btnClose = self:getBtn("btnClose")
	self._btnBuy = self:getBtn("btnBuy")
	self._btnBuySuper = self:getBtn("btnBuySuper")
	self._btnInfo = self:getBtn("btnInfo")
	self._txtBuySuper = self:getTxt("btnBuySuper/txt")
	self._txtBuySuperFake = self:getTxt("btnBuySuper/txtShow")
	self._txtBuy = self:getTxt("btnBuy/txt")
	self._showItems = {}
	self._showItemAdds = {}

	for i = 1, 3 do
		self._showItems[i] = self:getGo("show/item" .. i)
		self._showItemAdds[i] = self:getGo("show_add/item" .. i)
	end

	self._superShowItems = {}

	for i = 1, 9 do
		self._superShowItems[i] = self:getGo("superShow/item" .. i)
	end

	self._effPath = "fx_ui_tongxingzheng/fx_ui_tongxingzheng_01.prefab"
end

function PassportwpbuyView:bindEvents()
	PassportwpbuyView.super.bindEvents(self)
	self._btnClose:AddClickListener(self.close, self)
	self._btnBuy:AddClickListener(self._onClickBtnBuy, self)
	self._btnBuySuper:AddClickListener(self._onClickBtnBuySuper, self)
	self._btnInfo:AddClickListener(self._onClickBtnInfo, self)
end

function PassportwpbuyView:unbindEvents()
	PassportwpbuyView.super.unbindEvents(self)
	self._btnClose:RemoveClickListener()
	self._btnBuy:RemoveClickListener()
	self._btnBuySuper:RemoveClickListener()
	self._btnInfo:RemoveClickListener()
end

function PassportwpbuyView:destroyUI()
	PassportwpbuyView.super.destroyUI(self)
end

function PassportwpbuyView:onEnter()
	PassportwpbuyView.super.onEnter(self)

	local params = self:getOpenParam()

	if params == nil or #params < 3 then
		self:close()

		return
	end

	self._actCfg = params[1]
	self._funcCfg = params[2]
	self._state = params[3]

	local goodsCfg = PayConfig.instance:getPayGoodsCfg(self._actCfg.goodsId)

	self._txtBuy.text = self:_changeGoodId(self._actCfg.goodsId)
	self._txtBuySuper.text = self:_changeGoodId(self._actCfg.higherGoodsId)
	self._txtBuySuperFake.text = "￥" .. self._actCfg.higherGoodsShowId

	local dataList = MaterialMgr.changeItemStrArr(self._actCfg.superShowPrize)

	if self._funcCfg.id == 1 then
		-- block empty
	end

	for i = 1, 9 do
		if dataList[i] then
			MaterialMgr.setCellByCfg(dataList[i], self._superShowItems[i])
			GameUtil.SetActive(self._superShowItems[i], true)
		else
			GameUtil.SetActive(self._superShowItems[i], false)
		end
	end

	dataList = MaterialMgr.changeItemStrArr(self._actCfg.showPrize)

	for i = 1, 3 do
		if dataList[i] then
			MaterialMgr.setCellByCfg(dataList[i], self._showItems[i])
			GameUtil.SetActive(self._showItems[i], true)
			MaterialMgr.setCellByCfg(dataList[i], self._showItemAdds[i])
			GameUtil.SetActive(self._showItemAdds[i], true)
		else
			GameUtil.SetActive(self._showItemAdds[i], false)
			GameUtil.SetActive(self._showItems[i], false)
		end
	end

	local effResPath = self._effPath

	if not GameUtil.isEmptyString(effResPath) then
		self._playEff = UIEffectManager.instance:playEffect(self, effResPath, nil, 0, 0, true, false, nil, function(target, eff)
			eff:setParent(self.mainGO.transform)
			eff:setLocalPos(0, 0, 0)
			eff:setScale(1)

			eff.hideEffWhileNotOnTop = true
		end)
	end

	self._jumpTo = self._actCfg.jumpTo

	if string.nilorempty(self._jumpTo) then
		GameUtil.SetActive(self._btnInfo.gameObject, false)
	else
		local jumpToParms = string.split(self._jumpTo, "#")

		if jumpToParms[1] == "skin" then
			GameUtil.SetActive(self._btnInfo.gameObject, true)
		elseif jumpToParms[1] == "pet" then
			GameUtil.SetActive(self._btnInfo.gameObject, true)
		elseif jumpToParms[1] == "mount" then
			GameUtil.SetActive(self._btnInfo.gameObject, true)
		else
			GameUtil.SetActive(self._btnInfo.gameObject, false)
			printError("参数未定义")
		end
	end
end

function PassportwpbuyView:onEnterFinished()
	PassportwpbuyView.super.onEnterFinished(self)
end

function PassportwpbuyView:onExit()
	PassportwpbuyView.super.onExit(self)
	MaterialMgr.resetAll(item)

	for i = 1, 3 do
		MaterialMgr.resetAll(self._showItems[i])
		MaterialMgr.resetAll(self._showItemAdds[i])
	end

	for i = 1, 9 do
		MaterialMgr.resetAll(self._superShowItems[i])
	end

	if self._playEff then
		UIEffectManager.instance:stopEffect(self._playEff)

		self._playEff = nil
	end
end

function PassportwpbuyView:onExitFinished()
	PassportwpbuyView.super.onExitFinished(self)
end

function PassportwpbuyView:_changeGoodId(goodId)
	local num = PayConfig.instance:getPayMoneyYuan(goodId)

	return "￥" .. num
end

function PassportwpbuyView:_onClickBtnBuy()
	PassportController.instance:_buyPassportWithDifferentPayType(self._actCfg.actId, false)
end

function PassportwpbuyView:_onClickBtnBuySuper()
	PassportController.instance:_buyPassportWithDifferentPayType(self._actCfg.actId, true)
end

function PassportwpbuyView:_onClickBtnInfo()
	local jumpToParms = string.split(self._jumpTo, "#")

	if jumpToParms[1] == "skin" then
		local skinId = checkint(jumpToParms[2])

		UIStateManager.instance:push(ViewName.PetskinView, PetskinView.TYPE_SHOP, skinId)
	elseif jumpToParms[1] == "pet" then
		local raceId = checkint(jumpToParms[2])

		PetbookController.instance:openPetinfoView(raceId)
	elseif jumpToParms[1] == "mount" then
		local mountId = checkint(jumpToParms[2])

		UIStateManager.instance:push(ViewName.MountView, mountId)
	end
end

return PassportwpbuyView
