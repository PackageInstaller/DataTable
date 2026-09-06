-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/sxgame/view/SxGameResultView.lua

module("logic.extensions.sxgame.view.SxGameResultView", package.seeall)

local SxGameResultView = class("SxGameResultView", ViewComponent)

function SxGameResultView:ctor()
	SxGameResultView.super.ctor(self)

	self._finish = false
end

function SxGameResultView:bindEvents()
	SxGameResultView.super.bindEvents(self)
end

function SxGameResultView:unbindEvents()
	SxGameResultView.super.unbindEvents(self)
end

function SxGameResultView:buildUI()
	SxGameResultView.super.buildUI(self)

	self._Btn_Continue = goutil.findChild(self.mainGO, "Btn_Continue")
	self._Btn_Quit = goutil.findChild(self.mainGO, "Btn_Quit")
	self._Btn_Great = goutil.findChild(self.mainGO, "Btn_Great")
	self._Btn_Close = goutil.findChild(self.mainGO, "Btn_Close")
	self._continueAdapter = Framework.ButtonAdapter.Get(self._Btn_Continue.gameObject)

	self._continueAdapter:AddClickListener(self._continueFunc, self)

	self._quitAdapter = Framework.ButtonAdapter.Get(self._Btn_Quit.gameObject)

	self._quitAdapter:AddClickListener(self._quitFunc, self)

	self._greatAdapter = Framework.ButtonAdapter.Get(self._Btn_Great.gameObject)

	self._greatAdapter:AddClickListener(self._quitFunc, self)

	self._closeAdapter = Framework.ButtonAdapter.Get(self._Btn_Close.gameObject)

	self._closeAdapter:AddClickListener(self._onCloseFunc, self)

	self.txtNum = goutil.findChildTextComponent(self.mainGO, "txtNum/txt")
	self.con = goutil.findChild(self.mainGO, "con")
	self._title = goutil.findChildTextComponent(self.mainGO, "title")
	self._txtTips = goutil.findChildTextComponent(self.mainGO, "txtTips")
end

function SxGameResultView:onEnter()
	SxGameResultView.super.bindEvents(self)

	local params = self:getOpenParam() or {}

	self._finishCallBack = params[1]
	self._isPass = SxGameModel.instance:getCurStep() == 0

	if self._isPass then
		self:showFinishView()
	else
		self:showNoFinishView()
	end

	self:_refreshGift()
end

function SxGameResultView:onExit()
	SxGameResultView.super.bindEvents(self)
end

function SxGameResultView:destroyUI()
	SxGameResultView.super.destroyUI(self)
end

function SxGameResultView:showFinishView()
	GameUtil.SetActive(self._txtTips, false)

	self._title.text = "" .. lang("恭喜获得如下奖励")

	self._Btn_Continue:SetActive(false)
	self._Btn_Quit:SetActive(false)
	self._Btn_Great:SetActive(true)

	self._finish = true
end

function SxGameResultView:showNoFinishView()
	GameUtil.SetActive(self._txtTips, true)

	self._title.text = "" .. lang("当前退出可获得如下奖励")

	self._Btn_Continue:SetActive(true)
	self._Btn_Quit:SetActive(true)
	self._Btn_Great:SetActive(false)

	self._finish = false
end

function SxGameResultView:_continueFunc()
	self:close()
end

function SxGameResultView:_onCloseFunc()
	if self._finish then
		self:_quitFunc()
	else
		self:close()
	end
end

function SxGameResultView:_quitFunc()
	local isPass = true
	local gameScore = 0
	local giftArr = SxGameModel.instance:getGiftArr()
	local keyList = {
		SxGameCellType.Red,
		SxGameCellType.Green,
		SxGameCellType.Yellow,
		SxGameCellType.Purple
	}

	for _, v in ipairs(keyList) do
		gameScore = gameScore + checknumber(giftArr[v])
	end

	self:_doFinfishCallBack(isPass, gameScore)
	UIStateManager.instance:popByName(ViewName.Sxgame)
	self:close()
end

function SxGameResultView:_doFinfishCallBack(isPass, gameScore)
	local info = {}

	info.isPass = isPass
	info.gameScore = gameScore

	GameUtil.callBack(self._finishCallBack, info)
end

function SxGameResultView:_refreshGift()
	local giftArr = SxGameModel.instance:getGiftArr()
	local count = checknumber(giftArr[SxGameCellType.Red]) + checknumber(giftArr[SxGameCellType.Yellow]) + checknumber(giftArr[SxGameCellType.Green]) + checknumber(giftArr[SxGameCellType.Purple])
	local mat = MiniGameCollectionConfig.instance:getParamValueByKey("GAME_PRIZE")
	local max = MiniGameCollectionConfig.instance:getCoinCount(GameEnum.MiniGame.SXGame, count)
	local proxy = MaterialMgr.setCellByCfg(mat, self.con)

	if proxy then
		proxy.binder:setNum(0)
	end

	self.txtNum.text = "x" .. max
end

return SxGameResultView
