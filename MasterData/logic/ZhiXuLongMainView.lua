-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/view/zhixulong/ZhiXuLongMainView.lua

module("logic.extensions.timelimitedchallenge.view.zhixulong.ZhiXuLongMainView", package.seeall)

local ZhiXuLongMainView = class("ZhiXuLongMainView", TimedPointRaceModeMainView)

function ZhiXuLongMainView:buildUI()
	ZhiXuLongMainView.super.buildUI(self)

	self._challengeId = 27
	self.shop = self:getGo("shop")
	self.item = self:getGo("shop/item")
	self.btnShop = self:getGo("shop/btnShop")
end

function ZhiXuLongMainView:onEnter()
	ZhiXuLongMainView.super.onEnter(self)
	GameUtil.SetActive(self.shop, false)

	if FuncOpenModel.instance:getFuncIsOpen(500) then
		GameUtil.SetActive(self.shop, true)
		MaterialMgr.setCellByCfg("100:11002:1:1", self.item)
		GameUtil.addClickHandler(self.btnShop, function()
			if self._commonCfg then
				GotoMgr.gotoByString(self._commonCfg.jumpTo)
			end
		end)
	end
end

function ZhiXuLongMainView:onExit()
	ZhiXuLongMainView.super.onExit(self)
	MaterialMgr.resetAll(self.item)
	GameUtil.rmClickHandler(self.btnShop)
end

return ZhiXuLongMainView
