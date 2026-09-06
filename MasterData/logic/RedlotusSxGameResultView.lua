-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/redlotusdinnerparty/view/RedlotusSxGameResultView.lua

module("logic.extensions.redlotusdinnerparty.view.RedlotusSxGameResultView", package.seeall)

local RedlotusSxGameResultView = class("RedlotusSxGameResultView", SxGameResultView)

function RedlotusSxGameResultView:ctor(componetContainer)
	RedlotusSxGameResultView.super.ctor(self, componetContainer)
end

function RedlotusSxGameResultView:_quitFunc()
	local giftArr = SxGameModel.instance:getGiftArr()

	GameUtil.callBack(self._quitCallBack)
end

function RedlotusSxGameResultView:initParam(perCfg, quitCallBack)
	self._perCfg = perCfg
	self._quitCallBack = quitCallBack
end

function RedlotusSxGameResultView:_refreshGift()
	local giftArr = SxGameModel.instance:getGiftArr()
	local count = checknumber(giftArr[SxGameCellType.Red]) + checknumber(giftArr[SxGameCellType.Yellow]) + checknumber(giftArr[SxGameCellType.Green]) + checknumber(giftArr[SxGameCellType.Purple])

	self.txtNum.text = langPara("x%s 、积分x%s", 0, count)

	if self._perCfg then
		local type, id, num = MaterialMgr.getMatParams(self._perCfg.gamePrize)
		local proxy = MaterialMgr.setCellByCfg(self._perCfg.gamePrize, self.con)

		if proxy then
			proxy.binder:setNum(0)
		end

		self.txtNum.text = langPara("x%s 、积分x%s", num, count)
	end
end

return RedlotusSxGameResultView
